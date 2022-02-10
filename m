Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688104B097A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiBJJaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:30:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbiBJJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5A31112
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:29:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69418619A5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7A3C340F3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644485374;
        bh=HGM4Q7IrvX3TCMF1bCBJF/zPO3rFe3dmiOQn+Ok2zCM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tbc8VMytVSPwXhPAFQ+pHW0VyXILcAVQiYcTRAHd9pZIO4SZXyZVupdvYHlpEfFUs
         MayK24kZfPvksWqOGd40rwRrxRceQ8hjZPiEmP1pVr5n4iLKklamS+/WhXp9dsCxXB
         YBENBAFVolTJop4EqJPtwL22sKGbSygW6QpHvUlYeCJX/4bYti6U8wgKltQs9Il4Hm
         Oar81vk9stV3J1/N2UpeA/eufrKFhbtybgz5pVV7hxvEv2O+cfPgePE5fuW/w+zGL5
         BQWTAdmZ0xL8lSQ1hjWn/wJHdOJASqQgkwogbXY+ipSoHzuHxmQaURClnCHG0CgVfR
         mFmr+OZgFVCFg==
Received: by mail-wr1-f50.google.com with SMTP id d27so4604821wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:29:34 -0800 (PST)
X-Gm-Message-State: AOAM532hJDDeZV2n4UE6v1wRghffSnlw3aJE+3bVmmJTI09re+R1UA3X
        eheLHNNqiW3i4mwOMVZgw+wH5r0A7Q4/UZ8rlNA=
X-Google-Smtp-Source: ABdhPJyj1SGdUBiIOfZDt8ZwdLNUao09JQ8pTbN3rxClO1zCdUAgLNfU5RFjsfxJNTGpgIBiQYMSTTpb0iJqfvEwCss=
X-Received: by 2002:a05:6000:15ca:: with SMTP id y10mr5599700wry.417.1644485373021;
 Thu, 10 Feb 2022 01:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20220209153535.818830-1-mark.rutland@arm.com>
In-Reply-To: <20220209153535.818830-1-mark.rutland@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Feb 2022 10:29:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGKRc8NNQWDpgLL_=G2DWYv6wXcgkpFw=H98LxTHjpq+w@mail.gmail.com>
Message-ID: <CAMj1kXGKRc8NNQWDpgLL_=G2DWYv6wXcgkpFw=H98LxTHjpq+w@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] arm64 / sched/preempt: support PREEMPT_DYNAMIC
 with static keys
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        James Morse <james.morse@arm.com>, joey.gouly@arm.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022 at 16:35, Mark Rutland <mark.rutland@arm.com> wrote:
>
> This series enables PREEMPT_DYNAMIC on arm64. To do so, it adds a new
> mechanism allowing the preemption functions to be enabled/disabled using
> static keys rather than static calls, with architectures selecting
> whether they use static calls or static keys.
>
> With non-inline static calls, each function call results in a call to
> the (out-of-line) trampoline which either tail-calls its associated
> callee or performs an early return.
>
> The key idea is that where we're only enabling/disabling a single
> callee, we can inline this trampoline into the start of the callee,
> using a static key to decide whether to return early, and leaving the
> remaining codegen to the compiler. The overhead should be similar to
> (and likely lower than) using a static call trampoline. Since most
> codegen is up to the compiler, we sidestep a number of implementation
> pain-points (e.g. things like CFI should "just work" as well as they do
> for any other functions).
>
> The bulk of the diffstat for kernel/sched/core.c is shuffling the
> PREEMPT_DYNAMIC code later in the file, and the actual additions are
> fairly trivial.
>
> I've given this very light build+boot testing so far.
>
> Since v1 [1]:
> * Rework Kconfig text to be clearer
> * Rework arm64 entry code
> * Clarify commit messages.
>
> Since v2 [2]:
> * Add missing includes
> * Always provide prototype for preempt_schedule()
> * Always provide prototype for preempt_schedule_notrace()
> * Fix __cond_resched() to default to disabled
> * Fix might_resched() to default to disabled
> * Clarify example in commit message
>
> [1] https://lore.kernel.org/r/20211109172408.49641-1-mark.rutland@arm.com/
> [2] https://lore.kernel.org/r/20220204150557.434610-1-mark.rutland@arm.com/
>
> Mark Rutland (7):
>   sched/preempt: move PREEMPT_DYNAMIC logic later
>   sched/preempt: refactor sched_dynamic_update()
>   sched/preempt: simplify irqentry_exit_cond_resched() callers
>   sched/preempt: decouple HAVE_PREEMPT_DYNAMIC from GENERIC_ENTRY
>   sched/preempt: add PREEMPT_DYNAMIC using static keys
>   arm64: entry: centralize premeption decision
>   arm64: support PREEMPT_DYNAMIC
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>


>  arch/Kconfig                     |  37 +++-
>  arch/arm64/Kconfig               |   1 +
>  arch/arm64/include/asm/preempt.h |  19 +-
>  arch/arm64/kernel/entry-common.c |  28 ++-
>  arch/x86/Kconfig                 |   2 +-
>  arch/x86/include/asm/preempt.h   |  10 +-
>  include/linux/entry-common.h     |  15 +-
>  include/linux/kernel.h           |   7 +-
>  include/linux/sched.h            |  10 +-
>  kernel/entry/common.c            |  23 +-
>  kernel/sched/core.c              | 347 ++++++++++++++++++-------------
>  11 files changed, 327 insertions(+), 172 deletions(-)
>
> --
> 2.30.2
>
