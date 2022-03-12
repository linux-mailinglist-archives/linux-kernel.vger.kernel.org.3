Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB454D6D56
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 08:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiCLH4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 02:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiCLH4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 02:56:17 -0500
X-Greylist: delayed 89805 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 23:55:07 PST
Received: from forward501o.mail.yandex.net (forward501o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0051AF1B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 23:55:05 -0800 (PST)
Received: from myt6-0d043a4812e9.qloud-c.yandex.net (myt6-0d043a4812e9.qloud-c.yandex.net [IPv6:2a02:6b8:c12:212b:0:640:d04:3a48])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 02C3445C4E6C;
        Sat, 12 Mar 2022 10:51:32 +0300 (MSK)
Received: from myt6-016ca1315a73.qloud-c.yandex.net (myt6-016ca1315a73.qloud-c.yandex.net [2a02:6b8:c12:4e0e:0:640:16c:a131])
        by myt6-0d043a4812e9.qloud-c.yandex.net (mxback/Yandex) with ESMTP id pe20LCyH6q-pUea1kqH;
        Sat, 12 Mar 2022 10:51:31 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1647071491;
        bh=SZZen/V/Z/vp/O8yIgdA/8R3z6pgsFqVW5l4n8DyMRI=;
        h=In-Reply-To:Subject:Cc:To:From:References:Date:Message-ID;
        b=Rf2tP9GuEcps7Iqdn9oFoqQc7lnGIhP6T+4zDVCi42y0A2Ir0rlZoHGgAvIsnWaAO
         ZtcL+bHUnvCErBtfFZ7BqqXqKi2zfKDXMnYxl7Uz49ymMdjT6PYrcN5uVVzoQcNNLu
         WscYuzfqwX7DN2sJSGYQ2n3pySXKNPd/0iPxwFWE=
Authentication-Results: myt6-0d043a4812e9.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt6-016ca1315a73.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id jsuoPkjdGs-pTLaJWxg;
        Sat, 12 Mar 2022 10:51:29 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Sat, 12 Mar 2022 10:51:28 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [v6 0/9] Improve RISC-V Perf support using SBI PMU and sscofpmf
 extension
Message-ID: <20220312105128.114b0364@redslave.neermore.group>
In-Reply-To: <20220219004700.1973682-1-atishp@rivosinc.com>
References: <20220219004700.1973682-1-atishp@rivosinc.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Atish, thank you for your patches.

Tested you series on the top of v5.17-rc7, both on Qemu and HiFive
Unmatched.

Got similar results, everything is working fine.

HiFive Unmatched:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

perf stat -e cycles -e instructions -e L1-icache-load-misses -e
branches -e branch-misses \ -e r0000000000000200 -e r0000000000000400 \
-e r0000000000000800 perf bench sched messaging -g 25 -l 15

# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 25 groups =3D=3D 1000 processes run

     Total time: 0.780 [sec]

 Performance counter stats for 'perf bench sched messaging -g 25 -l 15':

        3046119040      cycles
                      (68.35%) 1117366934      instructions
         #    0.37  insn per cycle           (77.53%) 0
        L1-icache-load-misses
        (72.86%) 149748628      branches
                              (69.44%) 40937064      branch-misses
               #   27.34% of all branches          (35.17%) 175959749
           r0000000000000200
         (43.85%) 117885368      r0000000000000400
                               (45.45%) 6396494      r0000000000000800
                                                   (49.92%)

       1.714602000 seconds time elapsed

       1.091126000 seconds user
       3.391938000 seconds sys

Series was tested on the top of Provide a fraemework for RISC-V ISA
extensions:

https://patchwork.kernel.org/project/linux-riscv/list/?series=3D616887

with Mario "Introduce pmu-events support for HiFive Unmatched" series
applied:=20

https://patchwork.kernel.org/project/linux-riscv/list/?series=3D581071

With "riscv: Fix fill_callchain return value" patch - i was even able
to produce some flame graphs with "perf record".

"perf list pmu" gives exact u740 mapped events, so=20

Tested-by: Nikita Shubin <n.shubin@yadro.com>

To all mentioned series.

Yours,=20
Nikita Shubin

> This series adds improved perf support for RISC-V based system using
> SBI PMU extension[1] and Sscofpmf extension[2]. The SBI PMU extension
> allows the kernel to program the counters for different events and
> start/stop counters while the sscofpmf extension allows the counter
> overflow interrupt and privilege mode filtering. An hardware platform
> can leverage SBI PMU extension without the sscofpmf extension if it
> supports mcounteren at least. Perf stat will work but record won't
> work as sscofpmf & mcountinhibit is required to support that. A
> platform can support both features event counting and sampling using
> perf tool only if sscofpmf is supported.=20
>=20
> This series introduces a platform perf driver instead of a existing
> arch specific implementation. The new perf implementation has adopted
> a modular approach where most of the generic event handling is done
> in the core library while individual PMUs need to only implement
> necessary features specific to the PMU. This is easily extensible and
> any future RISC-V PMU implementation can leverage this. Currently,
> SBI PMU driver & legacy PMU driver are implemented as a part of this
> series.
>=20
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
>=20
> This series has been tested in Qemu (RV64 & RV32) and HiFive
> Unmatched. Qemu patches[4] and OpenSBI v1.0 is required to test it on
> Qemu and a dt patch required in U-Boot[5] for HiFive Unmatched. Qemu
> changes are not backward compatible. That means, you can not use perf
> anymore on older Qemu versions with latest OpenSBI and/or Kernel.
> However, newer kernel will just use legacy pmu driver if old OpenSBI
> is detected.
>=20
> The U-Boot patch is just an example that encodes few of the events
> defined in fu740 documentation [6] in the DT. We can update the DT to
> include all the events defined if required.
>=20
> This series depends on the ISA extension parsing series[7].
>=20
> Here is an output of perf stat/report while running perf benchmark
> with OpenSBI, Linux kernel and U-Boot patches applied.
>=20
> HiFive Unmatched:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> perf stat -e cycles -e instructions -e L1-icache-load-misses -e
> branches -e branch-misses \ -e r0000000000000200 -e r0000000000000400
> \ -e r0000000000000800 perf bench sched messaging -g 25 -l 15
>=20
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 25 groups =3D=3D 1000 processes run
>=20
>      Total time: 0.826 [sec]
>=20
>  Performance counter stats for 'perf bench sched messaging -g 25 -l
> 15':
>=20
>         3426710073      cycles                (65.92%)
>         1348772808      instructions          #0.39  insn per cycle
> (75.44%) 0      L1-icache-load-misses (72.28%)
>          201133996      branches              (67.88%)
>           44663584      branch-misses         #22.21% of all branches
> (35.01%) 248194747      r0000000000000200     (41.94%) --> Integer
> load instruction retired 156879950      r0000000000000400
> (43.58%) --> Integer store instruction retired 6988678
> r0000000000000800     (47.91%) --> Atomic memory operation retired
>=20
>        1.931335000 seconds time elapsed
>=20
>        1.100415000 seconds user
>        3.755176000 seconds sys
>=20
>=20
> QEMU:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> Perf stat:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> [root@fedora-riscv riscv]# perf stat -e r8000000000000005 -e
> r8000000000000007 \ -e r8000000000000006 -e r0000000000020002 -e
> r0000000000020004 -e branch-misses \ -e cache-misses -e
> dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses \ -e cycles
> -e instructions perf bench sched messaging -g 15 -l 10 \ Running with
> 15*40 (=3D=3D 600) tasks. Time: 6.578
>=20
>  Performance counter stats for './hackbench -pipe 15 process':
>=20
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
>=20
>        1.681344735 seconds time elapsed
>=20
>        0.614460000 seconds user
>        8.313254000 seconds sys
>=20
>=20
> [root@fedora-riscv ~]# perf stat -e cycles -e instructions -e
> dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses \
> > perf bench sched messaging -g 1 -l 10 =20
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 1 groups =3D=3D 40 processes run
>=20
>      Total time: 0.218 [sec]
>=20
>  Performance counter stats for 'perf bench sched messaging -g 1 -l
> 10':
>=20
>      3,685,401,394      cycles
> 3,684,529,388      instructions              #    1.00  insn per
> cycle 3,006,042      dTLB-load-misses
> 258,144      dTLB-store-misses
> 1,992,860      iTLB-load-misses
>     =20
>=20
>        0.588717389 seconds time elapsed
>=20
>        0.324009000 seconds user
>        0.937087000 seconds sys
>=20
> [root@fedora-riscv ~]# perf record -e cycles -e instructions -e
> dTLB-load-misses -e dTLB-store-misses \ -e iTLB-load-misses -c 10000
> perf bench sched messaging -g 1 -l 10 # Running 'sched/messaging'
> benchmark: # 20 sender and receiver processes per group
> # 1 groups =3D=3D 40 processes run
>=20
>      Total time: 2.160 [sec]
> [ perf record: Woken up 11 times to write data ]
> Warning:
> Processed 291769 events and lost 1 chunks!
>=20
> [root@fedora-riscv ~]# perf report
>=20
> Available samples
> 146K cycles
>          =E2=97=86 146K instructions
>                     =E2=96=92 298 dTLB-load-misses
>                                =E2=96=92 8 dTLB-store-misses
>                                           =E2=96=92 211 iTLB-load-misses =
=20
>=20
> [1]
> https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> [2]
> https://drive.google.com/file/d/171j4jFjIkKdj5LWcExphq4xG_2sihbfd/edit
> [3] https://github.com/atishp04/linux/tree/riscv_pmu_v6 [4]
> https://github.com/atishp04/qemu/tree/riscv_pmu_v5 [5]
> https://github.com/atishp04/u-boot/tree/hifive_unmatched_dt_pmu [6]
> https://sifive.cdn.prismic.io/sifive/de1491e5-077c-461d-9605-e8a0ce57337d=
_fu740-c000-manual-v1p3.pdf
> [7] https://lkml.org/lkml/2022/2/15/1604
>=20
> Changes from v5->v6:
> 1. Split the used counters bitmap to firmware and hardware so that we
> don't have to generate a hardware only used counter mask during
> overflow handling. 2. Stopped all the counters during cpu hotplug to
> restore correct behavior. 3. Addressed all the comments during the v5
> review. 4. Rebased on top of the isa extension framework series and
> 5.17-rc4.
>=20
> Changes from v4->v5:
> 1. Fixed few corner case issues in perf interrupt handling.
> 2. Changed the set_period API so that the caller can compute the
> initialize value.
> 3. Fixed the per cpu interrupt enablement issue.
> 4. Fixed a bug for the privilege mode filtering.
> 5. Modified the sbi driver independent of the DT.
> 6. Removed any DT related modifications.
>=20
> Changes from v3->v4:
> 1. Do not proceed overflow handler if event doesn't set for sampling.
> 2. overflow status register is only read after counters are stopped.
> 3. Added the PMU DT node for HiFive Unmatched.
>=20
> Changes from v2->v3:
> 1. Added interrupt overflow support.
> 2. Cleaned up legacy driver initialization.
> 3. Supports perf record now.
> 4. Added the DT binding and maintainers file.
> 5. Changed cpu hotplug notifier to be multi-state.
> 6. OpenSBI doesn't disable cycle/instret counter during boot. Update
> the perf code to disable all the counter during the boot.
>=20
> Changes from v1->v2
> 1. Implemented the latest SBI PMU extension specification.
> 2. The core platform driver was changed to operate as a library while
> only sbi based PMU is built as a driver. The legacy one is just a
> fallback if SBI PMU extension is not available.
>=20
> Atish Patra (9):
> RISC-V: Remove the current perf implementation
> RISC-V: Add CSR encodings for all HPMCOUNTERS
> RISC-V: Add a perf core library for pmu drivers
> RISC-V: Add a simple platform driver for RISC-V legacy perf
> RISC-V: Add RISC-V SBI PMU extension definitions
> RISC-V: Add perf platform driver based on SBI PMU extension
> RISC-V: Add sscofpmf extension support
> Documentation: riscv: Remove the old documentation
> MAINTAINERS: Add entry for RISC-V PMU drivers
>=20
> Documentation/riscv/pmu.rst         | 255 ---------
> MAINTAINERS                         |   9 +
> arch/riscv/Kconfig                  |  13 -
> arch/riscv/include/asm/csr.h        |  66 ++-
> arch/riscv/include/asm/hwcap.h      |   1 +
> arch/riscv/include/asm/perf_event.h |  72 ---
> arch/riscv/include/asm/sbi.h        |  95 ++++
> arch/riscv/kernel/Makefile          |   1 -
> arch/riscv/kernel/cpu.c             |   1 +
> arch/riscv/kernel/cpufeature.c      |   2 +
> arch/riscv/kernel/perf_event.c      | 485 -----------------
> drivers/perf/Kconfig                |  30 ++
> drivers/perf/Makefile               |   3 +
> drivers/perf/riscv_pmu.c            | 324 ++++++++++++
> drivers/perf/riscv_pmu_legacy.c     | 142 +++++
> drivers/perf/riscv_pmu_sbi.c        | 790 ++++++++++++++++++++++++++++
> include/linux/cpuhotplug.h          |   1 +
> include/linux/perf/riscv_pmu.h      |  75 +++
> 18 files changed, 1538 insertions(+), 827 deletions(-)
> delete mode 100644 Documentation/riscv/pmu.rst
> delete mode 100644 arch/riscv/kernel/perf_event.c
> create mode 100644 drivers/perf/riscv_pmu.c
> create mode 100644 drivers/perf/riscv_pmu_legacy.c
> create mode 100644 drivers/perf/riscv_pmu_sbi.c
> create mode 100644 include/linux/perf/riscv_pmu.h
>=20
> --
> 2.30.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

