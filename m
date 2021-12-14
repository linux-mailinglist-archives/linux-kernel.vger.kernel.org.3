Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE17A473F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhLNJOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhLNJOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:14:23 -0500
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79397C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:14:22 -0800 (PST)
Received: from sas1-f45a06513e06.qloud-c.yandex.net (sas1-f45a06513e06.qloud-c.yandex.net [IPv6:2a02:6b8:c08:b315:0:640:f45a:651])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 7619A6CB66C6;
        Tue, 14 Dec 2021 12:14:16 +0300 (MSK)
Received: from sas1-7a2c1d25dbfc.qloud-c.yandex.net (sas1-7a2c1d25dbfc.qloud-c.yandex.net [2a02:6b8:c08:c9f:0:640:7a2c:1d25])
        by sas1-f45a06513e06.qloud-c.yandex.net (mxback/Yandex) with ESMTP id ELZ1gc2bz8-EEfSAVDo;
        Tue, 14 Dec 2021 12:14:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1639473256;
        bh=oUuW8ldGeci2ZFZCA/ta8DDGK1USFYyWSAonErha41c=;
        h=In-Reply-To:Subject:To:From:References:Date:Message-ID:Cc;
        b=Zh5uls1KVOMPL0XY9Ti5pCmCZCKrX1EJcrBVLGgRbC8CiYjT2328QKc8sEIFp9qYK
         BZ+gCJ4nr24ScdpyKsmydLrrVT2X86FP+XfwnRs+anIcHeikJCf2aoblLhsjKsRj5J
         +lx9zJZKT5raVkQAQN2OeiArZUH9yJi+WGV7iBtE=
Authentication-Results: sas1-f45a06513e06.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by sas1-7a2c1d25dbfc.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id GNtx2IE1sC-EDPaHheD;
        Tue, 14 Dec 2021 12:14:13 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Date:   Tue, 14 Dec 2021 12:14:12 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        devicetree@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [v4 00/11] Improve RISC-V Perf support using SBI PMU and
 sscofpmf extension
Message-ID: <20211214121412.6aa896c9@redslave.neermore.group>
In-Reply-To: <20211025195350.242914-1-atish.patra@wdc.com>
References: <20211025195350.242914-1-atish.patra@wdc.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Atish!

I get linker error if CONFIG_RISCV_PMU_LEGACY is not set:

riscv64-unknown-linux-gnu-ld: drivers/perf/riscv_pmu_sbi.o: in function
`pmu_sbi_device_probe': linux/drivers/perf/riscv_pmu_sbi.c:688:
undefined reference to `riscv_pmu_legacy_init'

It looks like you need some guards or a dummy function for
riscv_pmu_legacy_init.

On Mon, 25 Oct 2021 12:53:39 -0700
Atish Patra <atish.patra@wdc.com> wrote:

> This series adds improved perf support for RISC-V based system using
> SBI PMU extension[1] and Sscofpmf extension[2]. The SBI PMU extension
> allows the kernel to program the counters for different events and
> start/stop counters while the sscofpmf extension allows the counter
> overflow interrupt and privilege mode filtering. An hardware platform
> can leverage SBI PMU extension without the sscofpmf extension if it
> supports mcountinhibit and mcounteren. However, the reverse is not
> true. With both of these extension enabled, a platform can take
> advantage of all both event counting and sampling using perf tool. 
> 
> This series introduces a platform perf driver instead of a existing
> arch specific implementation. The new perf implementation has adopted
> a modular approach where most of the generic event handling is done
> in the core library while individual PMUs need to only implement
> necessary features specific to the PMU. This is easily extensible and
> any future RISC-V PMU implementation can leverage this. Currently,
> SBI PMU driver & legacy PMU driver are implemented as a part of this
> series.
> 
> The legacy driver tries to reimplement the existing minimal perf
> under a new config to maintain backward compatibility. This
> implementation only allows monitoring of always running
> cycle/instruction counters. Moreover, they can not be started or
> stopped. In general, this is very limited and not very useful. That's
> why, I am not very keen to carry the support into the new driver.
> However, I don't want to break perf for any existing hardware
> platforms. If everybody agrees that we don't need legacy perf
> implementation for older implementation, I will be happy to drop
> PATCH 4.
> 
> This series has been tested in Qemu (RV64 & RV32) and HiFive
> Unmatched. Qemu[5] & OpenSBI [3] patches are required to test it on
> Qemu and a dt patch required in U-Boot[6] for HiFive Unmatched. Qemu
> changes are not backward compatible. That means, you can not use perf
> anymore on older Qemu versions with latest OpenSBI and/or Kernel.
> However, newer kernel will just use legacy pmu driver if old OpenSBI
> is detected.
> 
> The U-Boot patch is just an example that encodes few of the events
> defined in fu740 documentation [7] in the DT. We can update the DT to
> include all the events defined if required.
> 
> Here is an output of perf stat/report while running perf benchmark
> with OpenSBI, Linux kernel and U-Boot patches applied.
> 
> HiFive Unmatched:
> =================
> perf stat -e cycles -e instructions -e L1-icache-load-misses -e
> branches -e branch-misses \ -e r0000000000000200 -e r0000000000000400
> \ -e r0000000000000800 perf bench sched messaging -g 25 -l 15
> 
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 25 groups == 1000 processes run
> 
>      Total time: 0.826 [sec]
> 
>  Performance counter stats for 'perf bench sched messaging -g 25 -l
> 15':
> 
>         3426710073      cycles                (65.92%)
>         1348772808      instructions          #0.39  insn per cycle
> (75.44%) 0      L1-icache-load-misses (72.28%)
>          201133996      branches              (67.88%)
>           44663584      branch-misses         #22.21% of all branches
> (35.01%) 248194747      r0000000000000200     (41.94%) --> Integer
> load instruction retired 156879950      r0000000000000400
> (43.58%) --> Integer store instruction retired 6988678
> r0000000000000800     (47.91%) --> Atomic memory operation retired
> 
>        1.931335000 seconds time elapsed
> 
>        1.100415000 seconds user
>        3.755176000 seconds sys
> 
> 
> QEMU:
> =========
> Perf stat:
> =========
> 
> [root@fedora-riscv riscv]# perf stat -e r8000000000000005 -e
> r8000000000000007 \ -e r8000000000000006 -e r0000000000020002 -e
> r0000000000020004 -e branch-misses \ -e cache-misses -e
> dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses \ -e cycles
> -e instructions perf bench sched messaging -g 15 -l 10 \ Running with
> 15*40 (== 600) tasks. Time: 6.578
> 
>  Performance counter stats for './hackbench -pipe 15 process':
> 
>              1,794      r8000000000000005      (52.59%) -->
> SBI_PMU_FW_SET_TIMER 2,859      r8000000000000007      (60.74%) -->
> SBI_PMU_FW_IPI_RECVD 4,205      r8000000000000006      (68.71%) -->
> SBI_PMU_FW_IPI_SENT 0      r0000000000020002      (81.69%)
>      <not counted>      r0000000000020004      (0.00%)
>      <not counted>      branch-misses          (0.00%)
>      <not counted>      cache-misses           (0.00%)
>          7,878,328      dTLB-load-misses       (15.60%)
>            680,270      dTLB-store-misses      (28.45%)
>          8,287,931      iTLB-load-misses       (39.24%)
>     20,008,506,675      cycles                 (48.60%)
>     21,484,427,932      instructions   # 1.07  insn per cycle (56.60%)
> 
>        1.681344735 seconds time elapsed
> 
>        0.614460000 seconds user
>        8.313254000 seconds sys
> 
> 
> Perf record:
> ============
> [root@fedora-riscv riscv]# perf record -e cycles -e instructions \
> -e dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses -c 10000
> \ perf bench sched messaging -g 15 -l 10
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 15 groups == 600 processes run
> 
>      Total time: 1.261 [sec]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.101 MB perf.data (845 samples) ]
> 
> [root@fedora-riscv riscv]# perf report
> Available samples
> 407 cycles
>          _ 407 instructions
>                     _ 18 dTLB-load-misses
>                                _ 2 dTLB-store-misses
>                                           _ 11 iTLB-load-misses
>                                                      _ 
> [1]
> https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> [2]
> https://drive.google.com/file/d/171j4jFjIkKdj5LWcExphq4xG_2sihbfd/edit
> [3] https://github.com/atishp04/opensbi/tree/pmu_sscofpmf_v2 [4]
> https://github.com/atishp04/linux/tree/riscv_pmu_v4 [5]
> https://github.com/atishp04/qemu/tree/riscv_pmu_v3 [6]
> https://github.com/atishp04/u-boot/tree/hifive_unmatched_dt_pmu [7]
> https://sifive.cdn.prismic.io/sifive/de1491e5-077c-461d-9605-e8a0ce57337d_fu740-c000-manual-v1p3.pdf
> 
> Changes from v3->v4:
> 1. Do not proceed overflow handler if event doesn't set for sampling.
> 2. overflow status register is only read after counters are stopped.
> 3. Added the PMU DT node for HiFive Unmatched.
> 
> Changes from v2->v3:
> 1. Added interrupt overflow support.
> 2. Cleaned up legacy driver initialization.
> 3. Supports perf record now.
> 4. Added the DT binding and maintainers file.
> 5. Changed cpu hotplug notifier to be multi-state.
> 6. OpenSBI doesn't disable cycle/instret counter during boot. Update
> the perf code to disable all the counter during the boot.
> 
> Changes from v1->v2
> 1. Implemented the latest SBI PMU extension specification.
> 2. The core platform driver was changed to operate as a library while
> only sbi based PMU is built as a driver. The legacy one is just a
> fallback if SBI PMU extension is not available.
> 
> Atish Patra (11):
> RISC-V: Remove the current perf implementation
> RISC-V: Add CSR encodings for all HPMCOUNTERS
> RISC-V: Add a perf core library for pmu drivers
> RISC-V: Add a simple platform driver for RISC-V legacy perf
> RISC-V: Add RISC-V SBI PMU extension definitions
> dt-binding: pmu: Add RISC-V PMU DT bindings
> RISC-V: Add perf platform driver based on SBI PMU extension
> RISC-V: Add interrupt support for perf
> Documentation: riscv: Remove the old documentation
> riscv: dts: fu740: Add pmu node
> MAINTAINERS: Add entry for RISC-V PMU drivers
> 
> .../devicetree/bindings/perf/riscv,pmu.yaml   |  51 ++
> Documentation/riscv/pmu.rst                   | 255 ------
> MAINTAINERS                                   |  10 +
> arch/riscv/Kconfig                            |  13 -
> arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |   3 +
> arch/riscv/include/asm/csr.h                  |  66 +-
> arch/riscv/include/asm/perf_event.h           |  72 --
> arch/riscv/include/asm/sbi.h                  |  97 +++
> arch/riscv/kernel/Makefile                    |   1 -
> arch/riscv/kernel/perf_event.c                | 485 ------------
> drivers/perf/Kconfig                          |  25 +
> drivers/perf/Makefile                         |   5 +
> drivers/perf/riscv_pmu.c                      | 331 ++++++++
> drivers/perf/riscv_pmu_legacy.c               | 143 ++++
> drivers/perf/riscv_pmu_sbi.c                  | 732 ++++++++++++++++++
> include/linux/cpuhotplug.h                    |   1 +
> include/linux/perf/riscv_pmu.h                |  69 ++
> 17 files changed, 1532 insertions(+), 827 deletions(-)
> create mode 100644
> Documentation/devicetree/bindings/perf/riscv,pmu.yaml delete mode
> 100644 Documentation/riscv/pmu.rst delete mode 100644
> arch/riscv/kernel/perf_event.c create mode 100644
> drivers/perf/riscv_pmu.c create mode 100644
> drivers/perf/riscv_pmu_legacy.c create mode 100644
> drivers/perf/riscv_pmu_sbi.c create mode 100644
> include/linux/perf/riscv_pmu.h
> 
> --
> 2.31.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

