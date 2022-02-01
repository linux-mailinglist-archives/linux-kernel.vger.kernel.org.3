Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F094A5999
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiBAKEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiBAKEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:04:12 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFABC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 02:04:12 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id b186so26040920oif.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 02:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImE3jvqtwAV+LD3LBZrBAooPJ/AXfRcf5iFSgOr0w6o=;
        b=WtlpDy3xnPS4Ow6+vQ4dBxrn6Vz3PPESADC0fgiQsxxozS48nxXZGUrTLaoT1rGuW0
         f1AA+qmsaA6J3V47p3Ap2I32/7f/Ij1JGb1OV0o20eYeA//GenP6FIGbFwNtFGdtpxsE
         DVk7qaMSLatybP6lNOubpT29dRe7zM41Z18Y0SGVIV5GnOiuymNfInEZkSFfh4lqk7Tk
         S1hq///EMoqDNPmR21bsqRR5p/pNLmhJmKYOMdBg+lqSsFv8gK0pqOSJJJrEeIRWsapZ
         qbb+y6tnVCaDnFD97p3YOIsTWOYTsPcS5nZEoUTjDHbpyZcH1SjG4VM9OJHjy3Jr3lE3
         q0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImE3jvqtwAV+LD3LBZrBAooPJ/AXfRcf5iFSgOr0w6o=;
        b=UIFyrpneRP6GVmZ7hP+JpZaLZ4eUmIbLJVtZ2OHeAh+ypkR8O++8/MY51QW6neig6J
         eRWbBEWXi8ZEhEokNCXsxR1Yuj77v0zsN/W/10h9dz8ZQV9xjbKj7VIQBwqnF2KeiVI7
         aLTahIOWSOjKGMSmkkguW2dJtjNVXk6Wx9IO5tWEku3+sd53k3EXxX2l0/jFjKi6Ag8r
         S4pQDsr1fLQg93KXov91mNz0zE6dVpceo1xCnk2yzHW1M3oLSB6R+9VaFGwKSlYQC46D
         Yfki8VQ49XUzUv3cailO/ZZDWn1eaj14HccwaUgtSNN5F9gGfj8qv8ALa7UCLB59YitK
         3f5g==
X-Gm-Message-State: AOAM531hpRqC35W6frAw2bLS5VK0c2Qhc/qCbuhIDnFIsMlvlrGIDvo6
        +L36yvsSPNZLIEHoXfe7OZLFpzfei5l4uKjqjl1YHg==
X-Google-Smtp-Source: ABdhPJw5zMzYhl7/GpfkUsz0+xaN8Oq2G9kzMaTDdieWF+Ulwd9qnLTG2T47AyHbQ67Tglw2fH6iOhP1w6+O8DpSego=
X-Received: by 2002:a05:6808:b10:: with SMTP id s16mr637994oij.307.1643709851162;
 Tue, 01 Feb 2022 02:04:11 -0800 (PST)
MIME-Version: 1.0
References: <bfa0af18-04ac-857d-d3d8-ad9290f912c8@huawei.com> <20220131175526.1777801-1-dvyukov@google.com>
In-Reply-To: <20220131175526.1777801-1-dvyukov@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 1 Feb 2022 11:03:59 +0100
Message-ID: <CACT4Y+YVyJcqbR5j2fsSQ+C5hy78X+aobrUHaZKghFf0_NMv=A@mail.gmail.com>
Subject: Re: Test 73 Sig_trap fails on arm64
To:     john.garry@huawei.com, will@kernel.org
Cc:     acme@kernel.org, elver@google.com, gor@linux.ibm.com,
        hca@linux.ibm.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 at 18:55, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > On 18/01/2022 12:43, Leo Yan wrote:
> >
> > Hi Will,
> >
> > Can you kindly check below the question from Leo on this issue?
> >
> > You were cc'ed earlier in this thread so should be able to find more
> > context, if needed.
>
> Hi Will, John,
>
> I wonder if PSTATE.D flag can be used to resolve this
> (similar to x86's use of EFLAGS.RF)?
> I naively tried to do:
>
> void OnSigtrap(int sig, siginfo_t* info, void* uctx) {
>   auto& mctx = static_cast<ucontext_t*>(uctx)->uc_mcontext;
>   mctx.pstate |= PSR_D_BIT;
> }
>
> But then I got a SIGSEGV from kernel.
> But I wasn't able to track yet what part of the kernel did
> not like setting of D bit.

I did a naive attempt of moving enabling of single-stepping from
watchpoint_handler() to rt_sigreturn(), so that we step over the
intended trapping instruction rather than first instruction of the
signal handler:
https://github.com/dvyukov/linux/commit/dfd6903d9c6538e3ad792c1df6ffbcce2072b12b
(the patch is just a prototype, wrong in lots of ways)

This almost worked:
 - we correctly did not enable single-stepping for the signal handler
 - rt_sigreturn correctly detected this case and enabled
single-stepping after restoring the original pr_regs

However, after re_sigreturn I got a call to single_step_handler() with
pt_regs pointing to the first instruction of the signal handler again.
I can't explain this, I am not sure how/where the signal handler PC
got into the picture again... we should have got single_step_handler()
with pt_regs pointing to the original trapping instruction (the next
instruction to be precise).





> > > On Tue, Jan 18, 2022 at 12:40:04PM +0100, Marco Elver wrote:
> > >
> > > [...]
> > >
> > >>> Both Arm and Arm64 platforms cannot support signal handler with
> > >>> breakpoint, please see the details in [1].  So I think we need
> > >>> something like below:
> > >>>
> > >>> static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> > >>> {
> > >>>          ...
> > >>>
> > >>>          if (!BP_SIGNAL_IS_SUPPORTED) {
> > >>>                  pr_debug("Test not supported on this architecture");
> > >>>                  return TEST_SKIP;
> > >>>          }
> > >>>
> > >>>          ...
> > >>> }
> > >>>
> > >>> Since we have defined BP_SIGNAL_IS_SUPPORTED, I think we can reuse it at
> > >>> here.
> > >>>
> > >>> [1]https://lore.kernel.org/lkml/157169993406.29376.12473771029179755767.tip-bot2@tip-bot2/
> > >> Does this limitation also exist for address watchpoints? The sigtrap
> > >> test does not make use of instruction breakpoints, but instead just
> > >> sets up a watchpoint on access to a data address.
> > > Yes, after reading the code, the flow for either instrution breakpoint
> > > or watchpoint both use the single step [1], thus the signal handler will
> > > take the single step execution and lead to the infinite loop.
> > >
> > > I am not the best person to answer this question; @Will, could you
> > > confirm for this?  Thanks!
> > >
> > > Leo
> > >
> > > [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/hw_breakpoint.c
