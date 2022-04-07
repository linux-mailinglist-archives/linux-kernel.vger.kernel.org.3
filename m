Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DAD4F8739
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbiDGSoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiDGSoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:44:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A53827B1C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:42:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D571D12FC;
        Thu,  7 Apr 2022 11:42:00 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.7.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 379703F718;
        Thu,  7 Apr 2022 11:41:58 -0700 (PDT)
Date:   Thu, 7 Apr 2022 19:41:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 0/4] kasan, arm64, scs, stacktrace: collect stack
 traces from Shadow Call Stack
Message-ID: <Yk8wbx7/4+9pMLGE@FVFF77S0Q05N>
References: <cover.1648049113.git.andreyknvl@google.com>
 <YkV6QG+VtO7b0H7g@FVFF77S0Q05N>
 <YkWg5dCulxknhyZn@FVFF77S0Q05N>
 <CA+fCnZeQ6UnpM9qEQ4q5Y95U3XVwrsD-g7OX=Qxr1U1OR_KCsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZeQ6UnpM9qEQ4q5Y95U3XVwrsD-g7OX=Qxr1U1OR_KCsQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 05:10:02PM +0200, Andrey Konovalov wrote:
> On Thu, Mar 31, 2022 at 2:39 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > I've had a quick look into this, to see what we could do to improve the regular
> > unwinder, but I can't reproduce that 30% number.
> >
> > In local testing the worst can I could get to was 6-13% (with both the
> > stacktrace *and* stackdepot logic hacked out entirely).
> >
> > I'm testing with clang 13.0.0 from the llvm.org binary releases, with defconfig
> > + SHADOW_CALL_STACK + KASAN_<option>, using a very recent snapshot of mainline
> > (commit d888c83fcec75194a8a48ccd283953bdba7b2550). I'm booting a
> > KVM-accelerated QEMU VM on ThunderX2 with "init=/sbin/reboot -- -f" in the
> > kernel bootargs, timing the whole run from the outside with "perf stat --null".
> >
> > The 6% figure is if I count boot as a whole including VM startup and teardown
> > (i.e. an under-estimate of the proportion), the 13% figure is if I subtract a
> > baseline timing from a run without KASAN (i.e. an over-estimate of the
> > proportion).
> 
> I think this is the reason for the limited improvement that you
> observe. If you measure the time throughout VM startup and teardown,
> you include the time required for userspace apps, which is irrelevant.

Yes, that's the case for the 6% figure. However I also mentioned how I
accounted for that to get the 13% figure, which does not include those
irrelevant timings (and is an over-estimate of that proportion).

I think the discrepancy lies elsewhere, e.g. kernel version, boot arguments,
platform (and hence driver / subsystem behaviour), etc.

Can you share any of those details? Are you able to test with a mainline
kernel, e.g. v5.18-rc1?

I have a bunch of numbers below, and I think those imply one of the following:

* In your test setup, there are significantly more allocs/frees for which a
  stacktrace is being recorded. That could be down to the platform you're
  testing on, and the drivers that are in use.

* In your test setup, for some reason, some aspect of the stacktrace is
  signficantly more expensive than in my setup. There's the potential that a
  hardware quirk has some impact here, so knowing which hardware you're testing
  on would be very helpful.

* There is a secondary effect at play. There are a number of potential things
  here (e.g. console accesses, the number of stacktraces taken in interrupt
  context, etc).

I'd like to figure out which (if any) of those apply.

> I measure boot time until a certain point during kernel boot. E.g.,
> with the attached config, I measure the time until test_meminit start
> running.

How exactly are you measuring the point at which test_meminit() starts running?
Are you looking through dmesg, or passing some debug options? I ask because
that doesn't seem to dump anything into dmesg until at least one test has run.

FWIW, I was measuring the kernel boot up-to the point we'd run the userspace
init program, by booting the kernel with:

	init=/sbin/reboot -- -f

... which I think is more representative of the full boot time.

I can instead avoid that by not passing a filesystem and booting with:

	panic=-1

... to trigger an instant reboot when we'd normally mount the filesystem, but
the numbers as similar either way for me.

I've followed the latter approach for my numbers below, since it's easier to
reproduce.

> It takes 6 seconds for the kernel to reach test_meminit as is, and 4
> seconds with kasan_save_stack() commented out. Only commenting out
> __stack_depot_save() gives 5.9 seconds, so stack_trace_save() is the
> slow part.

As above, how are you measuring this?

... and since your config has CONFIG_KASAN_KUNIT_TEST=y, which console
options (e.g. 'quiet', 'loglevel=') are you passing on the kernel command line?

I ask because in my local testing, that options results in a load of test
results being dumped to the console, and the time taken to do so dominates
everything else. Hacking out the stack sampling reduces the amount of data we
log to the console, and this secondary effect reduces boot time.

> > Could you let me know how you're measuring this, and which platform+config
> > you're using?
> 
> I've attached the config that I use. It's essentially defconfig + SCS
> + KASAN + maybe a few other options.
> 
> > I'll have a play with some configs in case there's a pathological
> > configuration, but if you could let me know how/what you're testing that'd be a
> > great help.

I'm afraid from local testing (atop v5.18-rc1), with your config, I still can't
get anywhere near your figures. I've tried to match toolchain versions with
what was in your .config file, so I'm using clang 12.0.0 from the llvm.org
binary releases, and binutils from the kernel.org crosstool 11.1.0 release.

I took baselines with defconfig and defconfig + SHADOW_CALL_STACK, with console
output completely suppressed with 'quiet loglevel=0':

| [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1-defconfig/Image               
| 
|  Performance counter stats for
|  '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
|  -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
|  /home/mark/kernel-images/andrey-unwind-v5.18-rc1-defconfig/Image -append
|  loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
| 
|        0.512626031 seconds time elapsed                                          ( +-  0.26% )
| 
| [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1-defconfig+scs/Image
| 
|  Performance counter stats for
|  '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
|  -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
|  /home/mark/kernel-images/andrey-unwind-v5.18-rc1-defconfig+scs/Image -append
|  loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
| 
|        0.523245952 seconds time elapsed                                          ( +-  0.18% )

Then I tried the same with your config, without your patches:

| [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1-andrey.config/Image
| 
|  Performance counter stats for
|  '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
|  -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
|  /home/mark/kernel-images/andrey-unwind-v5.18-rc1-andrey.config/Image -append
|  loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
| 
|        1.994692366 seconds time elapsed                                          ( +-  0.05% )

Then with your config, without your patches, with the stacktrace hacked out:

| [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1-andrey.config-nostacktrace/Image            
| 
|  Performance counter stats for
| '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
| -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
| /home/mark/kernel-images/andrey-unwind-v5.18-rc1-andrey.config-nostacktrace/Image
| -append loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
| 
|        1.861823869 seconds time elapsed                                          ( +-  0.05% )

If I use those number to estimate the proportion of time spent stacktracing,
with the baseline SCS number discounted to remove the hypervisor+VMM overheads,
I get:

	(1.994692366 - 0.523245952) - (1.861823869 - 0.523245952)
        ---------------------------------------------------------  = 0.09029788358
	(1.994692366 - 0.523245952)

So roughly 9% when I try to maximize that figure. When actually poking hardware
and doing real work, that figure goes down. For example, if just using "quiet":

| [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -q -k ~/kernel-images/andrey-unwind-v5.18-rc1-andrey.config/Image > /dev/null
| 
|  Performance counter stats for
| '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
| -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
| /home/mark/kernel-images/andrey-unwind-v5.18-rc1-andrey.config/Image -append
| loglevel=9 earlycon panic=-1 quiet' (50 runs):
| 
|        4.653286475 seconds time elapsed                                          ( +-  0.06% )

| [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -q -k ~/kernel-images/andrey-unwind-v5.18-rc1-andrey.config-nostacktrace/Image > /dev/null
| 
|  Performance counter stats for
|  '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
|  -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
|  /home/mark/kernel-images/andrey-unwind-v5.18-rc1-andrey.config-nostacktrace/Image
|  -append loglevel=9 earlycon panic=-1 quiet' (50 runs):
| 
|        4.585750154 seconds time elapsed                                          ( +-  0.05% )

Which gives an estimate of:

	(4.653286475 - 0.523245952) - (4.585750154 - 0.523245952)
	---------------------------------------------------------  = 0.01635245964
	(4.653286475 - 0.523245952)

... or ~1.6% time spent backtracing:

FWIW, applying your patches do show some benefit, but not as drastic as I was
expecting:

With console output suprressed:

| [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1+scs-unwind-andrey.config/Image               
| 
|  Performance counter stats for
| '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
| -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
| /home/mark/kernel-images/andrey-unwind-v5.18-rc1+scs-unwind-andrey.config/Image
| -append loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
| 
|        1.920300410 seconds time elapsed                                          ( +-  0.05% )

... down from ~9% to ~4%

With console output merely reduced:

| [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -q -k ~/kernel-images/andrey-unwind-v5.18-rc1+scs-unwind-andrey.config/Image > /dev/null
| 
|  Performance counter stats for
| '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
| -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
| /home/mark/kernel-images/andrey-unwind-v5.18-rc1+scs-unwind-andrey.config/Image
| -append loglevel=9 earlycon panic=-1 quiet' (50 runs):
| 
|        4.611277833 seconds time elapsed                                          ( +-  0.04% )

... down from 1.6% to 0.6%

Given the above I still think we need to understand this a bit better before we
consider pursuing the SCS unwinder, given the issues I laid out in my prior mails.

My hope is that we can improve the regular unwinder or other code such that
this becomes moot. I'm aware of a few things we could try, but given it's very
easy to sink a lot of time and effort into this, I'd like to first get some
more details, as above.

Thanks,
Mark.
