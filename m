Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12A547F260
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 07:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhLYGMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 01:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhLYGMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 01:12:32 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18CAC061757
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 22:12:31 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id k69so12881300ybf.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 22:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dzkabnF+DJWBBK27hKdSbhfuLgzQlCBq4aSNcChshzM=;
        b=q9XpPc3Hj0+A1w06/ay49FUWMkPEH14U4f9q5kkSRsq5EiLae+4mumW2qoXQVA0eNM
         RgADOQgeSxq/BfuHW7VI82XEuvpgCbpJmQVBsYXKb6CAa9hfrmw6KbPwHx/SI9eTKofI
         mtcS4hjlrbf7jBzp1I0p1WsjCPnXy8whVwSxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dzkabnF+DJWBBK27hKdSbhfuLgzQlCBq4aSNcChshzM=;
        b=66yQkulnMW88iZZQwYF6evuDrhf4aVIO48wmePPOq+ecscNnDhqXgQJRldRCmk+9m0
         b5mJeS5BhfoTDTKNMOAzZutDgIY4AE6wRHjy8sKiEc0Orei8VXWkBdTGvx/3OassiYFj
         YXbbH9UFVOPybjOOGeL5dFeUiKQKFkixr6sIEXapbslYb8mJOvtK/3n9NR/eXCd9wIB8
         /YhRDtUCMKGvLpFz+b7vYVPp01ZfQooB5hJ6kpRwvjV+gsDUV9IT/DP0Q/EDnuV/oXOZ
         aeMFy+oWZj15Wk8kEAPpA8PjjBfqErXE3QrY997BIwVrb6mvBymTwoj4DPYtrpVSnJ6C
         TieA==
X-Gm-Message-State: AOAM531PWsBmVRosX1fU7+uqTcGuda8mi1tlTUSPivamswg3slu77/6e
        f++ZrT4P3BA4TEru8YcPqj/03bU6lqxVFs6PyI/oM+Glv7bn
X-Google-Smtp-Source: ABdhPJyL136Wsn2OUBJHP6++MUVbop0RN/qSVlJsm2qxwTJXjJPuHCOJTdaahIG3tKMNX7J7CIovmAQHtDBOOfmzRhE=
X-Received: by 2002:a5b:b92:: with SMTP id l18mr11462503ybq.10.1640412750951;
 Fri, 24 Dec 2021 22:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20211225054647.1750577-1-atishp@rivosinc.com>
In-Reply-To: <20211225054647.1750577-1-atishp@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 24 Dec 2021 22:12:20 -0800
Message-ID: <CAOnJCU+duqiLAX5G=DQOfb=ugeP_ZVPLPd=HKzG7PMU2XEH6yg@mail.gmail.com>
Subject: Re: [v5 0/9] Improve RISC-V Perf support using SBI PMU and sscofpmf extension
To:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 9:47 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> This series adds improved perf support for RISC-V based system using
> SBI PMU extension[1] and Sscofpmf extension[2]. The SBI PMU extension all=
ows
> the kernel to program the counters for different events and start/stop co=
unters
> while the sscofpmf extension allows the counter overflow interrupt and pr=
ivilege
> mode filtering. An hardware platform can leverage SBI PMU extension witho=
ut
> the sscofpmf extension if it supports mcounteren at least. Perf stat will=
 work
> but record won't work as sscofpmf & mcountinhibit is required to support =
that.
> A platform can support both features event counting and sampling using pe=
rf
> tool only if sscofpmf is supported.
>
> This series introduces a platform perf driver instead of a existing arch
> specific implementation. The new perf implementation has adopted a modula=
r
> approach where most of the generic event handling is done in the core lib=
rary
> while individual PMUs need to only implement necessary features specific =
to
> the PMU. This is easily extensible and any future RISC-V PMU implementati=
on
> can leverage this. Currently, SBI PMU driver & legacy PMU driver are impl=
emented
> as a part of this series.
>
> The legacy driver tries to reimplement the existing minimal perf under a =
new
> config to maintain backward compatibility. This implementation only allow=
s
> monitoring of always running cycle/instruction counters. Moreover, they c=
an
> not be started or stopped. In general, this is very limited and not very =
useful.
> That's why, I am not very keen to carry the support into the new driver.
> However, I don't want to break perf for any existing hardware platforms.
> If everybody agrees that we don't need legacy perf implementation for old=
er
> implementation, I will be happy to drop PATCH 4.
>
> This series has been tested in Qemu (RV64 & RV32) and HiFive Unmatched.
> Qemu patches[4] and OpenSBI v1.0 is required to test it on Qemu and a dt =
patch
> required in U-Boot[5] for HiFive Unmatched. Qemu changes are not
> backward compatible. That means, you can not use perf anymore on older Qe=
mu
> versions with latest OpenSBI and/or Kernel. However, newer kernel will
> just use legacy pmu driver if old OpenSBI is detected.
>
> The U-Boot patch is just an example that encodes few of the events define=
d
> in fu740 documentation [6] in the DT. We can update the DT to include all=
 the
> events defined if required.
>
> This series depends on the ISA extension parsing series[7].
>
> Here is an output of perf stat/report while running perf benchmark with O=
penSBI,
> Linux kernel and U-Boot patches applied.
>
> HiFive Unmatched:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> perf stat -e cycles -e instructions -e L1-icache-load-misses -e branches =
-e branch-misses \
> -e r0000000000000200 -e r0000000000000400 \
> -e r0000000000000800 perf bench sched messaging -g 25 -l 15
>
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 25 groups =3D=3D 1000 processes run
>
>      Total time: 0.826 [sec]
>
>  Performance counter stats for 'perf bench sched messaging -g 25 -l 15':
>
>         3426710073      cycles                (65.92%)
>         1348772808      instructions          #0.39  insn per cycle  (75.=
44%)
>                  0      L1-icache-load-misses (72.28%)
>          201133996      branches              (67.88%)
>           44663584      branch-misses         #22.21% of all branches (35=
.01%)
>          248194747      r0000000000000200     (41.94%) --> Integer load i=
nstruction retired
>          156879950      r0000000000000400     (43.58%) --> Integer store =
instruction retired
>            6988678      r0000000000000800     (47.91%) --> Atomic memory =
operation retired
>
>        1.931335000 seconds time elapsed
>
>        1.100415000 seconds user
>        3.755176000 seconds sys
>
>
> QEMU:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> Perf stat:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> [root@fedora-riscv riscv]# perf stat -e r8000000000000005 -e r80000000000=
00007 \
> -e r8000000000000006 -e r0000000000020002 -e r0000000000020004 -e branch-=
misses \
> -e cache-misses -e dTLB-load-misses -e dTLB-store-misses -e iTLB-load-mis=
ses \
> -e cycles -e instructions perf bench sched messaging -g 15 -l 10 \
> Running with 15*40 (=3D=3D 600) tasks.
> Time: 6.578
>
>  Performance counter stats for './hackbench -pipe 15 process':
>
>              1,794      r8000000000000005      (52.59%) --> SBI_PMU_FW_SE=
T_TIMER
>              2,859      r8000000000000007      (60.74%) --> SBI_PMU_FW_IP=
I_RECVD
>              4,205      r8000000000000006      (68.71%) --> SBI_PMU_FW_IP=
I_SENT
>                  0      r0000000000020002      (81.69%)
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
> [root@fedora-riscv ~]# perf stat -e cycles -e instructions -e dTLB-load-m=
isses -e dTLB-store-misses -e iTLB-load-misses \
> > perf bench sched messaging -g 1 -l 10
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 1 groups =3D=3D 40 processes run
>
>      Total time: 0.218 [sec]
>
>  Performance counter stats for 'perf bench sched messaging -g 1 -l 10':
>
>      3,685,401,394      cycles
>      3,684,529,388      instructions              #    1.00  insn per cyc=
le
>          3,006,042      dTLB-load-misses
>            258,144      dTLB-store-misses
>          1,992,860      iTLB-load-misses
>
>        0.588717389 seconds time elapsed
>
>        0.324009000 seconds user
>        0.937087000 seconds sys
>
> [root@fedora-riscv ~]# perf record -e cycles -e instructions -e dTLB-load=
-misses -e dTLB-store-misses \
> -e iTLB-load-misses -c 10000 perf bench sched messaging -g 1 -l 10
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 1 groups =3D=3D 40 processes run
>
>      Total time: 2.160 [sec]
> [ perf record: Woken up 11 times to write data ]
> Warning:
> Processed 291769 events and lost 1 chunks!
>
> [root@fedora-riscv ~]# perf report
>
> Available samples
> 146K cycles                                                              =
      =E2=97=86
> 146K instructions                                                        =
      =E2=96=92
> 298 dTLB-load-misses                                                     =
      =E2=96=92
> 8 dTLB-store-misses                                                      =
      =E2=96=92
> 211 iTLB-load-misses
>
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.=
adoc
> [2] https://drive.google.com/file/d/171j4jFjIkKdj5LWcExphq4xG_2sihbfd/edi=
t
> [3] https://github.com/atishp04/linux/tree/riscv_pmu_v5
> [4] https://github.com/atishp04/qemu/tree/riscv_pmu_v3
> [5] https://github.com/atishp04/u-boot/tree/hifive_unmatched_dt_pmu
> [6] https://sifive.cdn.prismic.io/sifive/de1491e5-077c-461d-9605-e8a0ce57=
337d_fu740-c000-manual-v1p3.pdf
> [7] https://lkml.org/lkml/2021/12/24/313
>
> Changes from v4->v5:
> 1. Fixed few corner case issues in perf interrupt handling.
> 2. Changed the set_period API so that the caller can compute the initiali=
ze
>    value.
> 3. Fixed the per cpu interrupt enablement issue.
> 4. Fixed a bug for the privilege mode filtering.
> 5. Modified the sbi driver independent of the DT.
> 6. Removed any DT related modifications.
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
> 6. OpenSBI doesn't disable cycle/instret counter during boot. Update the
>    perf code to disable all the counter during the boot.
>
> Changes from v1->v2
> 1. Implemented the latest SBI PMU extension specification.
> 2. The core platform driver was changed to operate as a library while onl=
y
>    sbi based PMU is built as a driver. The legacy one is just a fallback =
if
>    SBI PMU extension is not available.
>
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
>
> Documentation/riscv/pmu.rst         | 255 ----------
> MAINTAINERS                         |   9 +
> arch/riscv/Kconfig                  |  13 -
> arch/riscv/include/asm/csr.h        |  66 ++-
> arch/riscv/include/asm/hwcap.h      |   1 +
> arch/riscv/include/asm/perf_event.h |  72 ---
> arch/riscv/include/asm/sbi.h        |  97 ++++
> arch/riscv/kernel/Makefile          |   1 -
> arch/riscv/kernel/cpufeature.c      |   1 +
> arch/riscv/kernel/perf_event.c      | 485 ------------------
> drivers/perf/Kconfig                |  30 ++
> drivers/perf/Makefile               |   5 +
> drivers/perf/riscv_pmu.c            | 330 ++++++++++++
> drivers/perf/riscv_pmu_legacy.c     | 143 ++++++
> drivers/perf/riscv_pmu_sbi.c        | 762 ++++++++++++++++++++++++++++
> include/linux/cpuhotplug.h          |   1 +
> include/linux/perf/riscv_pmu.h      |  73 +++
> 17 files changed, 1517 insertions(+), 827 deletions(-)
> delete mode 100644 Documentation/riscv/pmu.rst
> delete mode 100644 arch/riscv/kernel/perf_event.c
> create mode 100644 drivers/perf/riscv_pmu.c
> create mode 100644 drivers/perf/riscv_pmu_legacy.c
> create mode 100644 drivers/perf/riscv_pmu_sbi.c
> create mode 100644 include/linux/perf/riscv_pmu.h
>
> --
> 2.33.1
>

Apologies for multiple emails on this series (in case you are
subscribed to linux-kernel@vger.kernel.org as well).
I messed up my script earlier and it removed all the CC entries and
sent the email just to lkml by mistake.
Sorry for the noise.

--=20
Regards,
Atish
