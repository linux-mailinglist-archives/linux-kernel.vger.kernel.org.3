Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAB6500684
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiDNHEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiDNHEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:04:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FF6127CC9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:02:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15C35139F;
        Thu, 14 Apr 2022 00:02:26 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.73.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3444A3F70D;
        Thu, 14 Apr 2022 00:02:23 -0700 (PDT)
Date:   Thu, 14 Apr 2022 08:02:16 +0100
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
Message-ID: <YlfG+LJPz1gRWWUI@FVFF77S0Q05N>
References: <cover.1648049113.git.andreyknvl@google.com>
 <YkV6QG+VtO7b0H7g@FVFF77S0Q05N>
 <YkWg5dCulxknhyZn@FVFF77S0Q05N>
 <CA+fCnZeQ6UnpM9qEQ4q5Y95U3XVwrsD-g7OX=Qxr1U1OR_KCsQ@mail.gmail.com>
 <Yk8wbx7/4+9pMLGE@FVFF77S0Q05N>
 <CA+fCnZcv6PtR5eT-hbJ54hkH7Kr+CUM4DU2S5nbU4Lp2OnG8dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZcv6PtR5eT-hbJ54hkH7Kr+CUM4DU2S5nbU4Lp2OnG8dQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:28:00PM +0200, Andrey Konovalov wrote:
> On Thu, Apr 7, 2022 at 8:42 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > I'm afraid from local testing (atop v5.18-rc1), with your config, I still can't
> > get anywhere near your figures. I've tried to match toolchain versions with
> > what was in your .config file, so I'm using clang 12.0.0 from the llvm.org
> > binary releases, and binutils from the kernel.org crosstool 11.1.0 release.
> >
> > I took baselines with defconfig and defconfig + SHADOW_CALL_STACK, with console
> > output completely suppressed with 'quiet loglevel=0':
> >
> > | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1-defconfig/Image
> > |
> > |  Performance counter stats for
> > |  '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> > |  -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> > |  /home/mark/kernel-images/andrey-unwind-v5.18-rc1-defconfig/Image -append
> > |  loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
> > |
> > |        0.512626031 seconds time elapsed                                          ( +-  0.26% )
> > |
> > | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1-defconfig+scs/Image
> > |
> > |  Performance counter stats for
> > |  '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> > |  -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> > |  /home/mark/kernel-images/andrey-unwind-v5.18-rc1-defconfig+scs/Image -append
> > |  loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
> > |
> > |        0.523245952 seconds time elapsed                                          ( +-  0.18% )
> >
> > Then I tried the same with your config, without your patches:
> >
> > | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1-andrey.config/Image
> > |
> > |  Performance counter stats for
> > |  '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> > |  -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> > |  /home/mark/kernel-images/andrey-unwind-v5.18-rc1-andrey.config/Image -append
> > |  loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
> > |
> > |        1.994692366 seconds time elapsed                                          ( +-  0.05% )
> >
> > Then with your config, without your patches, with the stacktrace hacked out:
> >
> > | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1-andrey.config-nostacktrace/Image
> > |
> > |  Performance counter stats for
> > | '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> > | -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> > | /home/mark/kernel-images/andrey-unwind-v5.18-rc1-andrey.config-nostacktrace/Image
> > | -append loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
> > |
> > |        1.861823869 seconds time elapsed                                          ( +-  0.05% )
> >
> > If I use those number to estimate the proportion of time spent stacktracing,
> > with the baseline SCS number discounted to remove the hypervisor+VMM overheads,
> > I get:
> >
> >         (1.994692366 - 0.523245952) - (1.861823869 - 0.523245952)
> >         ---------------------------------------------------------  = 0.09029788358
> >         (1.994692366 - 0.523245952)
> >
> > So roughly 9% when I try to maximize that figure. When actually poking hardware
> > and doing real work, that figure goes down. For example, if just using "quiet":
> >
> > | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -q -k ~/kernel-images/andrey-unwind-v5.18-rc1-andrey.config/Image > /dev/null
> > |
> > |  Performance counter stats for
> > | '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> > | -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> > | /home/mark/kernel-images/andrey-unwind-v5.18-rc1-andrey.config/Image -append
> > | loglevel=9 earlycon panic=-1 quiet' (50 runs):
> > |
> > |        4.653286475 seconds time elapsed                                          ( +-  0.06% )
> >
> > | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -q -k ~/kernel-images/andrey-unwind-v5.18-rc1-andrey.config-nostacktrace/Image > /dev/null
> > |
> > |  Performance counter stats for
> > |  '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> > |  -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> > |  /home/mark/kernel-images/andrey-unwind-v5.18-rc1-andrey.config-nostacktrace/Image
> > |  -append loglevel=9 earlycon panic=-1 quiet' (50 runs):
> > |
> > |        4.585750154 seconds time elapsed                                          ( +-  0.05% )
> >
> > Which gives an estimate of:
> >
> >         (4.653286475 - 0.523245952) - (4.585750154 - 0.523245952)
> >         ---------------------------------------------------------  = 0.01635245964
> >         (4.653286475 - 0.523245952)
> >
> > ... or ~1.6% time spent backtracing:
> >
> > FWIW, applying your patches do show some benefit, but not as drastic as I was
> > expecting:
> >
> > With console output suprressed:
> >
> > | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -s -k ~/kernel-images/andrey-unwind-v5.18-rc1+scs-unwind-andrey.config/Image
> > |
> > |  Performance counter stats for
> > | '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> > | -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> > | /home/mark/kernel-images/andrey-unwind-v5.18-rc1+scs-unwind-andrey.config/Image
> > | -append loglevel=9 earlycon panic=-1 quiet loglevel=0' (50 runs):
> > |
> > |        1.920300410 seconds time elapsed                                          ( +-  0.05% )
> >
> > ... down from ~9% to ~4%
> >
> > With console output merely reduced:
> >
> > | [mark@gravadlaks:~/repro]% taskset -c 64 ./vmboot.sh --perf-trials 50 -q -k ~/kernel-images/andrey-unwind-v5.18-rc1+scs-unwind-andrey.config/Image > /dev/null
> > |
> > |  Performance counter stats for
> > | '/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64 -m 2048 -smp 1 -nographic
> > | -no-reboot -machine virt,accel=kvm,gic-version=host -cpu host -kernel
> > | /home/mark/kernel-images/andrey-unwind-v5.18-rc1+scs-unwind-andrey.config/Image
> > | -append loglevel=9 earlycon panic=-1 quiet' (50 runs):
> > |
> > |        4.611277833 seconds time elapsed                                          ( +-  0.04% )
> >
> > ... down from 1.6% to 0.6%
> >
> > Given the above I still think we need to understand this a bit better before we
> > consider pursuing the SCS unwinder, given the issues I laid out in my prior mails.
> >
> > My hope is that we can improve the regular unwinder or other code such that
> > this becomes moot. I'm aware of a few things we could try, but given it's very
> > easy to sink a lot of time and effort into this, I'd like to first get some
> > more details, as above.
> 
> Hi Mark,
> 
> I'm about to publish v3, where I'll include a detailed description of
> how I measured the performance.
> 
> Perhaps we see different performance numbers because you're using
> KVM-enabled VM on an Arm host and I'm using QEMU on x86-64 host.

Hold on; are you using QEMU in TCG mode? If so that's in no way representative
of real HW performance, and there are operations it simply cannot make as fast
as HW can (e.g. pointer authentication using the architected QARMA variants).

> Although, it's suspicious that the difference is so drastic.

I'm not surprised at all. Some operations can be *orders of magnitude slower*
under TCG than on real HW even when considered relative to other operations,
and this can drasticaly skew benchmarks. We recently hit a case when PACIASP
and AUTIASP were so slow under TCG mode they appeared to be causing a boot
hang, and we eventually figured out that they were just *very* slow, adding
minutes to the boot time. Richard Henderson added options to QEMU to mitigate
that (either disabling authentication, or using an IMPLEMENTATION DEFINED
algorithm).

The bottom line is that QEMU TCG mode is in no way representative of real-world
performance, and *cannot* be used for benchmarking.

I think we first need to understand *what* is so slow under QEMU TCG mode, and
*why* TCG mode performance matters. I suspect there are other ways we could
avoid this overhead *without* adding another unwinder, but even then we need a
justification for *why* we should care.

> I'll try to get my hands on some Arm hardware in the next few days and do the
> measurements there.
> 
> This new version also will not be making any changes to the entry
> code, as these changes add unwanted additional slowdown. That would be
> great, if you could check the performance impact of v3 with your
> setup.

I'll take a look at the series, but as before I do not think we should add
another unwinder. As above, I *certainly* do not think we should add another
unwinder based on TCG performance.

Thanks,
Mark.
