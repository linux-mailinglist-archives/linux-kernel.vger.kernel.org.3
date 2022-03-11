Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FC84D579C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345453AbiCKBwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241288AbiCKBwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:52:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858D91959F5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:51:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34A14B82999
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24469C340E8;
        Fri, 11 Mar 2022 01:50:59 +0000 (UTC)
Date:   Thu, 10 Mar 2022 20:50:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: Re: [GIT PULL] tracing: minor fixes
Message-ID: <20220310205057.6769ac0d@gandalf.local.home>
In-Reply-To: <CAHk-=wjrhzKn2p6s7WPDGegmcnyOWL4jt5+4By11sGJGAkxG1w@mail.gmail.com>
References: <20220310174545.68e872fc@gandalf.local.home>
        <CAHk-=wjrhzKn2p6s7WPDGegmcnyOWL4jt5+4By11sGJGAkxG1w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 17:28:31 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Mar 10, 2022 at 2:45 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >  - Fix unregistering the same event twice a the user could disable
> >    the event osnoise will disable on unregistering.  
> 
> What? That sounds like a (bad) markov chain text generator made random
> commit noises.
> 
> I tried to edit that to something that actually makes some sense, but
> who knows..

Ah sorry. That was something difficult to shorten, and I wrote that up at
the end of the night.

tracepoints will warn if you try to unregister a callback that is not
registered. It doesn't break anything to do so, but because tracepoints are
asynchronous, and when the user reads the ring buffer it triggers calls to
special functions associated to a tracepoint, unregistering twice usually
is because of a bug that can cause a hard to debug situation. So we warn if
a callback is unregistered from a tracepoint that is not currently
registered.

What happened above is that the osnoise tracer registered callbacks to the
tracepoints. And it unregisters them when the tracer is stopped (echo 0
into tracing_on) or removed (echo nop > current_tracer). If the user stops
osnoise with the echo 0 to tracing_on that will cause the tracepoint
callbacks to be unregistered. If the user then turns off osnoise, then it
will unregister the callbacks again, even though they were no longer
registered.

Basically it was just an accounting error.

-- Steve
