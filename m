Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCEA4BC39C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbiBSArg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:47:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiBSArc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:47:32 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9818A276D79
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:47:14 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so3092425oti.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5kb3IKgrEaUkoVxz5aA0o1q5npWMf+JMdpdQ0OBpg8g=;
        b=ZUmRgqQVRSD5lIFjVIwRB6jQQeJs7QynEZXYd4c4cUhTiMs75PJkD2I1Blqblf87TY
         OziWTMeFRi1zFzK2nDoy55VmrlkR38d5L9K93vIG7U2Cou1UcYukKXzYiHD9eACNtw7v
         sTbnWKXLfw4544w1f7hqnd+jkVQ93ZW4VkiMzJO9LzjH08fKK8caWZgpTIeedDpql8CG
         TUgYyvf2jCPPL5C4xGhZMyz8RM5PspPCKoQgj0rsB6lL/7wlzi6Ilm6yKZNoVE8WfVqg
         8Toiin0ZLm1KFrqHWHjo+KK9c2I28/b+Y/5pgnI7F72libtLl/acOq3h2tN5dsABkzB4
         5OXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5kb3IKgrEaUkoVxz5aA0o1q5npWMf+JMdpdQ0OBpg8g=;
        b=yLmQ3ZRaf1pXFTk+iBjnDb1Qkl9eLTqmMHy598G+yWHVsrRpmkGDZ+M8OmeFaXTETK
         KwOF/mo/IJpAOsb6G0+wDkFzJhFuuz7JwOwOihOG+CLuaKSqAPXVjm8xPAYBsuXc4A09
         VRT1S0sDkWoq3J515uZM09xR1UZNWIIQgeNVqH64MZhvQSntiyczwAEKmw7Kbjp9kMKP
         IVMuGtDkr4XJgMA3MKR0LUQoGHLOeXA2NfX8lfAYzm3YGdvbugBLb/mLQ0K4NnSlebFn
         BN48QzAs94F9DwTFjLOBYO9It0gTW3gn47tjt5odmu5df6IwWfjtWSSFEdiSwP9bhp94
         7XbQ==
X-Gm-Message-State: AOAM530lYKH6TQiXSdcNphQkHVn3Rh8EyTXi8Pi+1Kj7ztAcSjOCbnx/
        WJKgJ4fximIOHB+cpy/UerY98CvTiafp7a9F
X-Google-Smtp-Source: ABdhPJyT5RyK68SEDq1cNRE8g55FB2gnh2Kwx7nCvePB+hBNzvJHy6UClKZv5OIYG61KDyvU8b/mlw==
X-Received: by 2002:a9d:668:0:b0:5ad:fb5:3745 with SMTP id 95-20020a9d0668000000b005ad0fb53745mr3261328otn.82.1645231633381;
        Fri, 18 Feb 2022 16:47:13 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id n11sm11360794oal.1.2022.02.18.16.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:47:12 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [v6 0/9] Improve RISC-V Perf support using SBI PMU and sscofpmf extension
Date:   Fri, 18 Feb 2022 16:46:51 -0800
Message-Id: <20220219004700.1973682-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds improved perf support for RISC-V based system using
SBI PMU extension[1] and Sscofpmf extension[2]. The SBI PMU extension allows
the kernel to program the counters for different events and start/stop counters
while the sscofpmf extension allows the counter overflow interrupt and privilege
mode filtering. An hardware platform can leverage SBI PMU extension without
the sscofpmf extension if it supports mcounteren at least. Perf stat will work
but record won't work as sscofpmf & mcountinhibit is required to support that.
A platform can support both features event counting and sampling using perf
tool only if sscofpmf is supported. 

This series introduces a platform perf driver instead of a existing arch
specific implementation. The new perf implementation has adopted a modular
approach where most of the generic event handling is done in the core library
while individual PMUs need to only implement necessary features specific to
the PMU. This is easily extensible and any future RISC-V PMU implementation
can leverage this. Currently, SBI PMU driver & legacy PMU driver are implemented
as a part of this series.

The legacy driver tries to reimplement the existing minimal perf under a new
config to maintain backward compatibility. This implementation only allows
monitoring of always running cycle/instruction counters. Moreover, they can
not be started or stopped. In general, this is very limited and not very useful.
That's why, I am not very keen to carry the support into the new driver.
However, I don't want to break perf for any existing hardware platforms.
If everybody agrees that we don't need legacy perf implementation for older
implementation, I will be happy to drop PATCH 4.

This series has been tested in Qemu (RV64 & RV32) and HiFive Unmatched.
Qemu patches[4] and OpenSBI v1.0 is required to test it on Qemu and a dt patch
required in U-Boot[5] for HiFive Unmatched. Qemu changes are not
backward compatible. That means, you can not use perf anymore on older Qemu
versions with latest OpenSBI and/or Kernel. However, newer kernel will
just use legacy pmu driver if old OpenSBI is detected.

The U-Boot patch is just an example that encodes few of the events defined
in fu740 documentation [6] in the DT. We can update the DT to include all the
events defined if required.

This series depends on the ISA extension parsing series[7].

Here is an output of perf stat/report while running perf benchmark with OpenSBI, 
Linux kernel and U-Boot patches applied.

HiFive Unmatched:
=================
perf stat -e cycles -e instructions -e L1-icache-load-misses -e branches -e branch-misses \
-e r0000000000000200 -e r0000000000000400 \
-e r0000000000000800 perf bench sched messaging -g 25 -l 15

# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 25 groups == 1000 processes run

     Total time: 0.826 [sec]

 Performance counter stats for 'perf bench sched messaging -g 25 -l 15':

        3426710073      cycles                (65.92%)
        1348772808      instructions          #0.39  insn per cycle  (75.44%)
                 0      L1-icache-load-misses (72.28%)
         201133996      branches              (67.88%)
          44663584      branch-misses         #22.21% of all branches (35.01%)
         248194747      r0000000000000200     (41.94%) --> Integer load instruction retired
         156879950      r0000000000000400     (43.58%) --> Integer store instruction retired
           6988678      r0000000000000800     (47.91%) --> Atomic memory operation retired

       1.931335000 seconds time elapsed

       1.100415000 seconds user
       3.755176000 seconds sys


QEMU:
=========
Perf stat:
=========

[root@fedora-riscv riscv]# perf stat -e r8000000000000005 -e r8000000000000007 \
-e r8000000000000006 -e r0000000000020002 -e r0000000000020004 -e branch-misses \
-e cache-misses -e dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses \
-e cycles -e instructions perf bench sched messaging -g 15 -l 10 \
Running with 15*40 (== 600) tasks.
Time: 6.578

 Performance counter stats for './hackbench -pipe 15 process':

             1,794      r8000000000000005      (52.59%) --> SBI_PMU_FW_SET_TIMER
             2,859      r8000000000000007      (60.74%) --> SBI_PMU_FW_IPI_RECVD
             4,205      r8000000000000006      (68.71%) --> SBI_PMU_FW_IPI_SENT
                 0      r0000000000020002      (81.69%)
     <not counted>      r0000000000020004      (0.00%)
     <not counted>      branch-misses          (0.00%)
     <not counted>      cache-misses           (0.00%)
         7,878,328      dTLB-load-misses       (15.60%)
           680,270      dTLB-store-misses      (28.45%)
         8,287,931      iTLB-load-misses       (39.24%)
    20,008,506,675      cycles                 (48.60%)
    21,484,427,932      instructions   # 1.07  insn per cycle (56.60%)

       1.681344735 seconds time elapsed

       0.614460000 seconds user
       8.313254000 seconds sys


[root@fedora-riscv ~]# perf stat -e cycles -e instructions -e dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses \
> perf bench sched messaging -g 1 -l 10
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 1 groups == 40 processes run

     Total time: 0.218 [sec]

 Performance counter stats for 'perf bench sched messaging -g 1 -l 10':

     3,685,401,394      cycles                                                      
     3,684,529,388      instructions              #    1.00  insn per cycle         
         3,006,042      dTLB-load-misses                                            
           258,144      dTLB-store-misses                                           
         1,992,860      iTLB-load-misses                                            

       0.588717389 seconds time elapsed

       0.324009000 seconds user
       0.937087000 seconds sys

[root@fedora-riscv ~]# perf record -e cycles -e instructions -e dTLB-load-misses -e dTLB-store-misses \
-e iTLB-load-misses -c 10000 perf bench sched messaging -g 1 -l 10
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 1 groups == 40 processes run

     Total time: 2.160 [sec]
[ perf record: Woken up 11 times to write data ]
Warning:
Processed 291769 events and lost 1 chunks!

[root@fedora-riscv ~]# perf report

Available samples                                                               
146K cycles                                                                    ◆
146K instructions                                                              ▒
298 dTLB-load-misses                                                           ▒
8 dTLB-store-misses                                                            ▒
211 iTLB-load-misses  

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
[2] https://drive.google.com/file/d/171j4jFjIkKdj5LWcExphq4xG_2sihbfd/edit
[3] https://github.com/atishp04/linux/tree/riscv_pmu_v6
[4] https://github.com/atishp04/qemu/tree/riscv_pmu_v5
[5] https://github.com/atishp04/u-boot/tree/hifive_unmatched_dt_pmu
[6] https://sifive.cdn.prismic.io/sifive/de1491e5-077c-461d-9605-e8a0ce57337d_fu740-c000-manual-v1p3.pdf
[7] https://lkml.org/lkml/2022/2/15/1604

Changes from v5->v6:
1. Split the used counters bitmap to firmware and hardware so that we don't
   have to generate a hardware only used counter mask during overflow handling.
2. Stopped all the counters during cpu hotplug to restore correct behavior.
3. Addressed all the comments during the v5 review.
4. Rebased on top of the isa extension framework series and 5.17-rc4.

Changes from v4->v5:
1. Fixed few corner case issues in perf interrupt handling.
2. Changed the set_period API so that the caller can compute the initialize
   value.
3. Fixed the per cpu interrupt enablement issue.
4. Fixed a bug for the privilege mode filtering.
5. Modified the sbi driver independent of the DT.
6. Removed any DT related modifications.

Changes from v3->v4:
1. Do not proceed overflow handler if event doesn't set for sampling.
2. overflow status register is only read after counters are stopped.
3. Added the PMU DT node for HiFive Unmatched.

Changes from v2->v3:
1. Added interrupt overflow support.
2. Cleaned up legacy driver initialization.
3. Supports perf record now.
4. Added the DT binding and maintainers file.
5. Changed cpu hotplug notifier to be multi-state.
6. OpenSBI doesn't disable cycle/instret counter during boot. Update the
   perf code to disable all the counter during the boot.

Changes from v1->v2
1. Implemented the latest SBI PMU extension specification.
2. The core platform driver was changed to operate as a library while only
   sbi based PMU is built as a driver. The legacy one is just a fallback if
   SBI PMU extension is not available.

Atish Patra (9):
RISC-V: Remove the current perf implementation
RISC-V: Add CSR encodings for all HPMCOUNTERS
RISC-V: Add a perf core library for pmu drivers
RISC-V: Add a simple platform driver for RISC-V legacy perf
RISC-V: Add RISC-V SBI PMU extension definitions
RISC-V: Add perf platform driver based on SBI PMU extension
RISC-V: Add sscofpmf extension support
Documentation: riscv: Remove the old documentation
MAINTAINERS: Add entry for RISC-V PMU drivers

Documentation/riscv/pmu.rst         | 255 ---------
MAINTAINERS                         |   9 +
arch/riscv/Kconfig                  |  13 -
arch/riscv/include/asm/csr.h        |  66 ++-
arch/riscv/include/asm/hwcap.h      |   1 +
arch/riscv/include/asm/perf_event.h |  72 ---
arch/riscv/include/asm/sbi.h        |  95 ++++
arch/riscv/kernel/Makefile          |   1 -
arch/riscv/kernel/cpu.c             |   1 +
arch/riscv/kernel/cpufeature.c      |   2 +
arch/riscv/kernel/perf_event.c      | 485 -----------------
drivers/perf/Kconfig                |  30 ++
drivers/perf/Makefile               |   3 +
drivers/perf/riscv_pmu.c            | 324 ++++++++++++
drivers/perf/riscv_pmu_legacy.c     | 142 +++++
drivers/perf/riscv_pmu_sbi.c        | 790 ++++++++++++++++++++++++++++
include/linux/cpuhotplug.h          |   1 +
include/linux/perf/riscv_pmu.h      |  75 +++
18 files changed, 1538 insertions(+), 827 deletions(-)
delete mode 100644 Documentation/riscv/pmu.rst
delete mode 100644 arch/riscv/kernel/perf_event.c
create mode 100644 drivers/perf/riscv_pmu.c
create mode 100644 drivers/perf/riscv_pmu_legacy.c
create mode 100644 drivers/perf/riscv_pmu_sbi.c
create mode 100644 include/linux/perf/riscv_pmu.h

--
2.30.2

