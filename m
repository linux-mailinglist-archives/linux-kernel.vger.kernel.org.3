Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2FF4B6F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbiBOOfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:35:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiBOOfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:35:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BB3102173;
        Tue, 15 Feb 2022 06:35:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7298617A0;
        Tue, 15 Feb 2022 14:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B309C340EB;
        Tue, 15 Feb 2022 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644935707;
        bh=gMNo0dT2yRkfLdgfjoiOdwPB4xS6suMxi0zT9x2hKkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NjpRcAizRwVXpkrg+kK417kCTSemyZKUHQFZdOcUqypHCzBKJqLEObGYRR0+0i+El
         mtvzn6dQKj4keH5corDCsxozwAPKDmH6vX3EnRHMzZRqCqCBMJ5mue6rVI1smyHCST
         yGNWcrnDklD8wZAiUfXogdhZ+EHu2eeeD86s6qnL/CIPxGFwekd5LLZGFnHPS55/O6
         PaF5jmxV0LzOeEy7/FWtdfAyS3sDYFa2RYDRc137pYCJtZgltDWhZoUueIBSJ9kXfR
         xQ3PjojPsOzwVBISZIdp4FvaJRGtsocgPFg3e+RSAYr970nwfBm1RcTGz+9qlO6Bpe
         blE6bu7faws+A==
Date:   Tue, 15 Feb 2022 14:35:00 +0000
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Leo Yan <leo.yan@linaro.org>, Marco Elver <elver@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, dvyukov@google.com
Subject: Re: Test 73 Sig_trap fails on arm64 (was Re: [PATCH] perf test: Test
 73 Sig_trap fails on s390)
Message-ID: <20220215143459.GB7592@willie-the-truck>
References: <20211216151454.752066-1-tmricht@linux.ibm.com>
 <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
 <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com>
 <20220118091827.GA98966@leoy-ThinkPad-X240s>
 <CANpmjNMPoU+1b1fKFuYDYwisW2YfjQHxGt5hgLp1tioG7C2jmg@mail.gmail.com>
 <20220118124343.GC98966@leoy-ThinkPad-X240s>
 <bfa0af18-04ac-857d-d3d8-ad9290f912c8@huawei.com>
 <06412caf-42e4-5c4b-c9b3-9691075405bd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06412caf-42e4-5c4b-c9b3-9691075405bd@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 11:16:16AM +0000, John Garry wrote:
> On 24/01/2022 09:19, John Garry wrote:
> 
> Hi Will,
> 
> Have you had a chance to check this or the mail from Dmitry?
> 
> https://lore.kernel.org/linux-perf-users/CACT4Y+YVyJcqbR5j2fsSQ+C5hy78X+aobrUHaZKghFf0_NMv=A@mail.gmail.com/
> 
> If we can't make progress then we just need to skip the test on arm64 for
> now.

Sorry, I haven't had time to look at this (or the thousands of other mails
in my inbox) lately.

I don't recall all of the details, but basically hw_breakpoint really
doesn't work well on arm/arm64 -- the sticking points are around handling
the stepping and whether to step into or over exceptions. Sadly, our ptrace
interface (which is what is used by GDB) is built on top of hw_breakpoint,
so we can't just rip it out and any significant changes are pretty risky.

What I would like to happen is that we rework our debug exception handling
as outlined by [1] so that kernel debug is better defined and the ptrace
interface can interact directly with the debug architecture instead of being
funnelled through hw_breakpoint. Once we have that, I think we could try to
improve hw_breakpoint much more comfortably (or at least defeature it
considerably without having to worry about breaking GDB). I started this a
couple of years ago, but I haven't found time to get back to it for ages.

Anyway, to this specific test...

When we hit a break/watchpoint the faulting PC points at the instruction
which faulted and the exception is reported before the instruction has had
any other side-effects (e.g. if a watchpoint triggers on a store, then
memory will not have been updated when the watchpoint handler runs), so if
we were to return as usual after reporting the exception to perf then we
would just hit the same break/watchpoint again and we'd get stuck. GDB
handles stepping over the faulting instruction, but for perf (and assumedly
these tests), the kernel is expected to handle the step. This handling
amounts to disabling the break/watchpoint which we think we hit and then
attempting a hardware single-step. During the step we could run into more
break/watchpoints on the same instruction, so we'll keep disabling things
until we eventually manage to complete the step, which is signalled by a
specific type of debug exception. At this point, we re-enable the
break/watchpoints and we're good.

Signals make this messy, as the step logic will step _into_ the signal
handler -- we have to do this, otherwise we would miss break/watchpoints
triggered by the signal handler if we had disabled them for the step.
However, it means that when we return back from the signal handler we will
run back into the break/watchpoint which we initially stepped over. When
perf uses SIGTRAP to notify userspace that we hit a break/watchpoint,
then we'll get stuck because we'll step into the handler every time.

Hopefully that clears things up a bit. Ideally, the kernel wouldn't
pretend to handle this stepping at all for arm64 as it adds a bunch of
complexity, overhead to our context-switch and I don't think the current
behaviour is particularly useful.

Will

[1] https://lore.kernel.org/all/20200626095551.GA9312@willie-the-truck/
