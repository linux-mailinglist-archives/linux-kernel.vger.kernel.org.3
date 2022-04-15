Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B1050284A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352316AbiDOKb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350201AbiDOKbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:31:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04ABBC843;
        Fri, 15 Apr 2022 03:28:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E156B82DEB;
        Fri, 15 Apr 2022 10:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17D2C385A6;
        Fri, 15 Apr 2022 10:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650018535;
        bh=+KEpsYKGgSKldm+NlWBYkFbQsp6L86Twv51N6txzysE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4WNaud45Hme92XUWA9Z9Mvs3B7jBAVH7vXXw6Y+5UJuzsPz+J/hjKSlt/B3syLiv
         lh7I9ClYkcmsBIZbErevi8Vj7tKeP3+Q7BuzENnTpfpTEuGm4uwnwzo2WDv96HKep+
         z09uBKVwwcHusgB8mk4L2NzsB7oqbQTQ7k35b9+WKybtjCscT1PuKjoNEx+dYMkwo3
         3FQu+V8iySTMcpumNycGUC7mTT1r2S8srkcGjfDYUKyNmHj2DDsvISyF1j6QYOKIPI
         FPuPPNaeZjy4tUsQl7E1TloABt2C5hToiXZVprUkVdzmufLSuHzOpEmWm5amrl2arn
         KaC3mHMRfY72A==
Date:   Fri, 15 Apr 2022 12:28:52 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Alison Chaiken <achaiken@aurora.tech>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Glenn Elliott <glenn@aurora.tech>
Subject: Re: [RT][PATCH 2/2] tick: Fix timer storm since introduction of
 timersd
Message-ID: <20220415102852.GA1654237@lothringen>
References: <20220405010752.1347437-1-frederic@kernel.org>
 <20220405010752.1347437-2-frederic@kernel.org>
 <CAFzL-7s0oWtSS_oYTOJ1A-1Dbso6S+4qoR-n91joexgQYCaJEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFzL-7s0oWtSS_oYTOJ1A-1Dbso6S+4qoR-n91joexgQYCaJEg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 09:21:16AM -0700, Alison Chaiken wrote:
> On Mon, Apr 4, 2022 at 9:33 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > If timers are pending while the tick is reprogrammed on nohz_mode, the
> > next expiry is not armed to fire now, it is delayed one jiffy forward
> > instead so as not to raise an inextinguishable timer storm with such
> > scenario:
> >
> > 1) IRQ triggers and queue a timer
> > 2) ksoftirqd() is woken up
> > 3) IRQ tail: timer is reprogrammed to fire now
> > 4) IRQ exit
> > 5) TIMER interrupt
> > 6) goto 3)
> >
> > ...all that until we finally reach ksoftirqd.
> >
> > Unfortunately we are checking the wrong softirq vector bitmask since
> > timersd kthread has split from ksoftirqd. Timers now have their own
> > vector state field that must be checked separately.
> 
> With kernel 5.15 and the timersd patch applied, we've observed that
> x86_64 cores tend to enter deeper C-states even when there are pending
> hrtimers.      Presumably failure to check the right   bits could also
> explain that observation and, accordingly, the patch might fix it?

Well, this issue rather adds unnecessary ticks. Thus I wouldn't expect
deeper C-states as a consequence but who knows...

Thanks.
