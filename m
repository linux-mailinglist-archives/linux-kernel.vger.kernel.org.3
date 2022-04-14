Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62656500DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243423AbiDNMje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiDNMjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:39:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5C248F9AA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:37:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DD25139F;
        Thu, 14 Apr 2022 05:37:07 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31D4D3F70D;
        Thu, 14 Apr 2022 05:37:05 -0700 (PDT)
Date:   Thu, 14 Apr 2022 13:36:59 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v3 0/3] kasan, arm64, scs: collect stack traces from
 Shadow Call Stack
Message-ID: <YlgVa+AP0g4IYvzN@lakrids>
References: <cover.1649877511.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649877511.git.andreyknvl@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:26:43PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Currently, when saving alloc and free stack traces, KASAN uses the normal
> stack trace collection routines, which rely on the unwinder.
> 
> Instead of invoking the unwinder, collect the stack trace by copying
> frames from the Shadow Call Stack. This reduces boot time by ~30% for
> all KASAN modes when Shadow Call Stack is enabled. See below for the
> details of how the measurements were performed.
> 
> Stack staces are collected from the Shadow Call Stack via a new
> stack_trace_save_shadow() interface.
> 
> Note that the implementation is best-effort and only works in certain
> contexts. See patch #3 for details.
> 
> ---
> 
> Changes
> =======
> 
> v2->v3:
> - Limit hardirq and drop SDEI support for performance and simplicity.
> - Move stack_trace_save_shadow() implementation back to mm/kasan:
>   it's not mature enough to be used as a system-wide stack trace
>   collection replacement.
> - Clarify -ENOSYS return value from stack_trace_save_shadow().
> - Don't rename nr_entries to size in kasan_save_stack().
> - Check return value of stack_trace_save_shadow() instead of checking
>   CONFIG_HAVE_SHADOW_STACKTRACE in kasan_save_stack().
> 
> v1->v2:
> - Provide a kernel-wide stack_trace_save_shadow() interface for collecting
>   stack traces from shadow stack.
> - Use ptrauth_strip_insn_pac() and READ_ONCE_NOCHECK, see the comments.
> - Get SCS pointer from x18, as per-task value is meant to save the SCS
>   value on CPU switches.
> - Collect stack frames from SDEI and IRQ contexts.
> 
> Perf
> ====
> 
> To measure performance impact, I used QEMU in full system emulation mode
> on an x86-64 host.

Just to be clear: QEMU TCG mode is *in no way* representative of HW
performance, and has drastically different performance characteristics
compared to real HW. Please be very clear when you are quoting
performance figures from QEMU TCG mode.

Previously you said you were trying to optimize this so that some
version of KASAN could be enabled in production builds, and the above is
not a suitable benchmark system for that.

Is that *actually* what you're trying to enable, or are you just trying
to speed up running instances under QEMU (e.g. for arm64 Syzkaller runs
on GCE)?

> As proposed by Mark, I passed no filesystem to QEMU and booted with panic=-1:
> 
> qemu-system-aarch64 \
> 	-machine virt,mte=on -cpu max \
> 	-m 2G -smp 1 -nographic \
> 	-kernel ./xbins/Image \
> 	-append "console=ttyAMA0 earlyprintk=serial panic=-1" \
> 	-no-shutdown -no-reboot
> 
> Just in case, the QEMU version is:
> 
> $ qemu-system-aarch64 --version
> QEMU emulator version 6.2.94 (v5.2.0-rc3-12124-g81c7ed41a1)

Thanks for this information, this makes it *much* easier to see what's
going on here.

As I suspected, you're hitting a known performance oddity with QEMU TCG
mode where pointer authentication is *incredibly* slow when using the
architected QARMA5 algorithm (enabled by default with `-cpu max`).

Practically speaking, when using TCG mode with `-cpu max`, PACIASP and
AUTIASP instructions in function prologues/epilogues take much longer
than they would on real hardware, and this means that those skew
performance with an overhead whcih scales with the number of function
calls. The regular unwinder is hit pretty bad by this because it has a
few function calls (including KASAN instrumentation), and the overhead
of this dominates the cost of the actual unwind logic. Your SCS unwinder
isn't as badly hit by that because it has fewer function calls.

This overhead has nothing to do with the *nature* of the unwinder, and
is an artifact of the *platform* and the *structure* of the code.
There's plenty that can be done to avoid that overhead, including basic
QEMU options which don't require kernel changes.

For example, if you replace:

	-cpu max

With:

	-cpu max,pauth-impdef=true

... QEMU will use an IMPLEMENTATION DEFINED pointer authentication
algorithm which is *much* faster than its implementation of QARMA5 (and
tests below show that make the kernel reach the panic in ~1/6 the time).

Since you're testing with shadow call stack, you could decide to disable
pointer authentication entirely. You can tell QEMU to not provide that
with:

	-cpu max,pauth=false

... which in tests below makes the kernel reach the panic in 1/9 the
time.

You could instead change your config to have
CONFIG_ARM64_PTR_AUTH_KERNEL=n, which would cause the kernel to be built
without the instructions which are causing the slowdown.

For comparisons below, I've built the same version of QEMU as you're
using. The numbering in that version string is a bit confusing, so I've
gone by the git commit ID:

| commit 81c7ed41a1b33031f3e4fe24191a998a492044b8 (HEAD, tag: v7.0.0-rc4, origin/master, origin/HEAD)
| Author:     Peter Maydell <peter.maydell@linaro.org>
| AuthorDate: Tue Apr 12 17:01:34 2022 +0100
| Commit:     Peter Maydell <peter.maydell@linaro.org>
| CommitDate: Tue Apr 12 17:01:34 2022 +0100
| 
|     Update version for v7.0.0-rc4 release
|     
|     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
| 
| diff --git a/VERSION b/VERSION
| index 80d0afb063..9c57137cdf 100644
| --- a/VERSION
| +++ b/VERSION
| @@ -1 +1 @@
| -6.2.93
| +6.2.94

My host machine is an Intel Xeon E5-2660.

> Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers
> 
> Then, I recorded the timestamp of when the "Kernel panic" line was printed
> to the kernel log.
> 
> The measurements were done on 5 kernel flavors:
> 
> master                 (mainline commit a19944809fe99):
> master-no-stack-traces (stack trace collection commented out)
> master-no-stack-depot  (saving to stack depot commented out)
> up-scs-stacks-v3       (collecting stack traces from SCS)
> up-scs-stacks-v3-noscs (up-scs-stacks-v3 with __noscs marking)
> 
> (The last flavor is included just for the record: it produces an unexpected
>  slowdown. The likely reason is that helper functions stop getting inlined.)

As above, that case is hitting the overhead of QEMU TCG mode's
incredibly slow pointer authentication.

> All the branches can be found here:
> 
> https://github.com/xairy/linux/branches/all
> 
> The measurements were performed for Generic and HW_TAGS KASAN modes.
> 
> The .configs are here (essentially, defconfig + SCS + KASAN):
> 
> Generic KASAN: https://gist.github.com/xairy/d527ad31c0b54898512c92898d62beed
> HW_TAGS KASAN: https://gist.github.com/xairy/390e4ef0140de3f4f9a49efe20708d21
> 
> The results:
> 
> Generic KASAN
> -------------
> 
> master-no-stack-traces: 8.03
> master:                 11.55 (+43.8%)
> master-no-stack-depot:  11.53 (+43.5%)
> up-scs-stacks-v3:       8.31  (+3.4%)
> up-scs-stacks-v3-noscs: 9.11  (+13.4%)

I made the same measurements, reading the timestamp on the panic
message. From my local results, the performance oddity with pointer
authentication dominates everything else, and by changing QEMU options
to minimize or eliminate that overhead the difference in unwinder
overhead becomes far less pronouced and the overall boot time is reduced
to a fraction of the time taken when the incredibly slow imlpementation
of pointer authentication is used:

Generic KASAN w/ `-cpu max`
---------------------------

master-no-stack-traces: 12.66
master:                 18.39 (+45.2%)
master-no-stack-depot:  17.85 (+40.1%)
up-scs-stacks-v3:       13.54 (+7.0%)

Generic KASAN w/ `-cpu max,pauth-impdef=true`
---------------------------------------------

master-no-stack-traces: 2.69
master:                 3.35 (+24.5%)
master-no-stack-depot:  3.54 (+31.5%)
up-scs-stacks-v3:       2.80 (+4.1%)

All results are 5x to 6x faster; the regular unwinder overhead is
reduced by ~20% relative to `-cpu max`.

Generic KASAN w/ `-cpu max,pauth=false`
---------------------------------------

master-no-stack-traces: 1.92
master:                 2.27  (+18.2%)
master-no-stack-depot:  2.22  (+15.6%)
up-scs-stacks-v3:       2.06  (+7.3%)

All results are 6x to 9x faster; the regular unwinder overhead is
reduced by 27% relative to `-cpu max`.

To speed up your QEMU runs, there are a couple of trivial options
available to you which'll improve your runs by ~6x to ~9x, which vastly
outstrips any benefit gained from changing the unwinder. I'd recommend
you at least consider moving to `pauth-impdef=true`.

While the SCS unwinder is still faster, the difference is nowhere near
as pronounced. As I mentioned before, there are changes that we can make
to the regular unwinder to close that gap somewhat, some of which I
intend to make as part of ongoing cleanup/rework in that area.

I haven't bothered testing HW_TAGS, because the performance
characteristics of emulated MTE are also nothing like that of a real HW
implementation.

So, given that and the problems I mentioned before, I don't think
there's a justification for adding a separate SCS unwinder. As before,
I'm still happy to try to make the regular unwinder faster (and I'm
happy to make changes which benefit QEMU TCG mode if those don't harm
the maintainability of the unwinder).

NAK to adding an SCS-specific unwinder, regardless of where in the
source tree that is placed.

Thanks,
Mark.
