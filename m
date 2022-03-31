Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E174ED759
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiCaJ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCaJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:56:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 883883DDD6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:54:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 413B323A;
        Thu, 31 Mar 2022 02:54:15 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 658873F718;
        Thu, 31 Mar 2022 02:54:12 -0700 (PDT)
Date:   Thu, 31 Mar 2022 10:54:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 0/4] kasan, arm64, scs, stacktrace: collect stack
 traces from Shadow Call Stack
Message-ID: <YkV6QG+VtO7b0H7g@FVFF77S0Q05N>
References: <cover.1648049113.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648049113.git.andreyknvl@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Wed, Mar 23, 2022 at 04:32:51PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> kasan, arm64, scs, stacktrace: collect stack traces from Shadow Call Stack
> 
> Currently, KASAN always uses the normal stack trace collection routines,
> which rely on the unwinder, when saving alloc and free stack traces.
> 
> Instead of invoking the unwinder, collect the stack trace by copying
> frames from the Shadow Call Stack whenever it is enabled. This reduces
> boot time by 30% for all KASAN modes when Shadow Call Stack is enabled.

That is an impressive number. TBH, I'm shocked that this has *that* much of an
improvement, and I suspect this means we're doing something unnecssarily
expensive in the regular unwinder.

I've given some specific comments on patches, but a a high-level, I don't want
to add yet another unwind mechanism. For maintenance and correctness reasons,
we've spent the last few years consolidating various unwinders, which this
unfortunately goes against.

I see that there are number of cases this unwinder will fall afoul of (e.g.
kretprobes and ftrace graph trampolines), and making those work correctly will
require changes elsewhere (e.g. as we rely upon a snapshot of the FP to
disambiguate cases today).

I'm also very much not keen on having to stash things in the entry assembly for
this distinct unwinder.

Going forward, I'm also planning on making changes to the way we unwind across
exception boundaries (e.g. to report the LR and FP), and as that depends on
finding the pt_regs based on the FP, that's not going to work with SCS.

So at a high level, I don't want to add an SCS based unwinder.

However, I'm very much open to how we could improve the standard unwinder to be
faster, which would be more generally beneficial. I can see that there are some
things we could reasonably do with simple refactoring.

Thanks,
Mark.

> Stack staces are collected from the Shadow Call Stack via a new
> stack_trace_save_shadow() interface.
> 
> Note that the frame of the interrupted function is not included into
> the stack trace, as it is not yet saved on the SCS when an interrupt
> happens.
> 
> ---
> 
> To deal with this last thing, we could save the interrupted frame address
> in another per-CPU variable. I'll look into implementing this for v3.
> 
> I decided to postpone the changes to stack depot that avoid copying
> frames twice until a planned upcoming update for stack depot.
> 
> Changes v1->v2:
> - Provide a kernel-wide stack_trace_save_shadow() interface for collecting
>   stack traces from shadow stack.
> - Use ptrauth_strip_insn_pac() and READ_ONCE_NOCHECK, see the comments.
> - Get SCS pointer from x18, as per-task value is meant to save the SCS
>   value on CPU switches.
> - Collect stack frames from SDEI and IRQ contexts.
> 
> Andrey Konovalov (4):
>   stacktrace: add interface based on shadow call stack
>   arm64, scs: save scs_sp values per-cpu when switching stacks
>   arm64: implement stack_trace_save_shadow
>   kasan: use stack_trace_save_shadow
> 
>  arch/Kconfig                       |  6 +++
>  arch/arm64/Kconfig                 |  1 +
>  arch/arm64/include/asm/assembler.h | 12 +++++
>  arch/arm64/include/asm/scs.h       | 13 ++++-
>  arch/arm64/kernel/entry.S          | 28 ++++++++--
>  arch/arm64/kernel/irq.c            |  4 +-
>  arch/arm64/kernel/sdei.c           |  5 +-
>  arch/arm64/kernel/stacktrace.c     | 83 ++++++++++++++++++++++++++++++
>  include/linux/stacktrace.h         | 15 ++++++
>  kernel/stacktrace.c                | 21 ++++++++
>  mm/kasan/common.c                  |  9 ++--
>  11 files changed, 183 insertions(+), 14 deletions(-)
> 
> -- 
> 2.25.1
> 
