Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A495D4D9E62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348288AbiCOPNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiCOPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:13:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFC113F10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:11:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D86DB81731
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5003C340E8;
        Tue, 15 Mar 2022 15:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647357112;
        bh=tmAYCIaKsF0LUd/bmZ182eQrbvS+ccIG9Pcjgkbdn9s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RvIKUhyU5dVPz0CZVC34DyE5eEP6wJS7GQ2CftzkIgKqU94K8hfp8HUO62kJTfG0s
         qvAyAjjefh9gyqz1EUITEidFBUsSynD7icsMGHaE5GehLv5dOFC6LZyfXfS0bkk+Fc
         rFB+v0oNM4hKDHs4r6zC7B+hS2dhzJma434yiW1h4FIapkQtMVsxUEMg0XbrSO7gxw
         MGlfDYCrCQzZfmrQ5zM3eQDn7sPd3E5LLUkuCLfBwVlrWAO/sW+NwQx7+fJ6sUgAQ0
         5GNNzCSP4lY3dzct2thsWaFA38Ho6WBV9gnyYJST972ggUPtnRLvaf4N4+i+LCvo9N
         P5g2t0AdszODg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 795E95C417C; Tue, 15 Mar 2022 08:11:52 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:11:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/3] preempt/dynamic: Introduce preempt mode accessors
Message-ID: <20220315151152.GC4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220314133738.269522-1-frederic@kernel.org>
 <20220314133738.269522-3-frederic@kernel.org>
 <CANpmjNPqY65ZYLFukgp779pHbiRH05yns+G7Z36QdWwrQp1WOQ@mail.gmail.com>
 <20220315104817.GE8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315104817.GE8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 11:48:17AM +0100, Peter Zijlstra wrote:
> On Mon, Mar 14, 2022 at 03:44:39PM +0100, Marco Elver wrote:
> > https://lore.kernel.org/lkml/20211112185203.280040-3-valentin.schneider@arm.com/
> > 
> > Is it also possible to take all the rest of that series (all 4
> > patches) from Valentin?
> 
> I'll go stick the remaining 3 patches from Valentin in sched/core, they
> seem to still apply without issue.

If testing goes well, are you planning to push into the upcoming
merge window?  (I won't be pushing until the v5.19 merge window at
the earliest.)

Either way, just please let me know!

							Thanx, Paul
