Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DFC531F60
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiEWXvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiEWXv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:51:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F39DF35
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n10so15344279pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBerACEu3D8hwDgAD8a9aSNcUVMJ4eBb9MKktGy8X5M=;
        b=JdYNKv5bcTK3UCko8lH+RyHpLlqF0q/0mKviUgMbM+fzH9Vw8fed9b0MFyVvmhRoui
         OAOsCoIz52MvyHYTUnh0EMCzX913SrcIQzgPe135YD4HQpREppZXYcMDvpvINEDj49Rr
         LzB3KiGgjmZHa9E8QJqvTBOhKGdVX/iwIPUj6wqEgtW4ghlPV+Xq/JZUGe0GYKmxPPhB
         k7VYu412GblRSac6njK1+OZwRweEyLpJgcN/eIlOUVP3YXprvs5FW8h3JG9yFQX3axaF
         5Yo0m5cUUvtkbrCyquFVjHTXEfvUZuseLvpvqpU8nAFIQss9qCyA/UUbHYMQnrSzLoff
         qCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBerACEu3D8hwDgAD8a9aSNcUVMJ4eBb9MKktGy8X5M=;
        b=jMe4qGK1tRHRHG11LBc2I9mPygHPb2EF2WAS1SPzuHslwBjrLQMBWf/sFkwUYni53W
         +aYEjJuBTudeUd5UgjLRZZV2jpUTS3Fjq3LKIerlO2UpS5hHyfqZEQjzsys8jim/mygD
         Q/mmVhPmTLGHxpnIv9W4t5ZcMcdwmWOQaLJIkRScA8wLEcRNyxFthe/+GG6FKR1LSlTn
         ZNC8nAOcTm9K9oGmTsx/tdc60KhWUzPYouXNXQ/M2jyx2I8jItXFg9FJps+L+2DdWw0O
         E0uizMGBXWlkZoT1Xbp2h49mfIdGRVvcdqEnOOeczLgPIhWeBtuU49TYIXG2HkM4j43x
         UkiQ==
X-Gm-Message-State: AOAM532cZ8PUgq3G2agCv921bICOZWMOyx3jeZ190L5m8UVaREJA02kd
        hAnMdsszj12yuwvVeqZFKhDR/ruimFd2PA==
X-Google-Smtp-Source: ABdhPJxyXGCAx2N3VHMyu3UC4A1qliBS+x+Rs+sv7qgkjje3Wz8rSmWTdpsnNTAy270vOJoJTwiJog==
X-Received: by 2002:a17:90a:ba11:b0:1df:2d09:1308 with SMTP id s17-20020a17090aba1100b001df2d091308mr1503032pjr.184.1653349885018;
        Mon, 23 May 2022 16:51:25 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id pl15-20020a17090b268f00b001df4b919937sm257084pjb.16.2022.05.23.16.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 16:51:24 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v9 00/12] Improve PMU support
Date:   Mon, 23 May 2022 16:50:45 -0700
Message-Id: <20220523235057.123882-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
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

The latest version of the SBI specification includes a Performance Monitoring
Unit(PMU) extension[1] which allows the supervisor to start/stop/configure
various PMU events. The Sscofpmf ('Ss' for Privileged arch and Supervisor-level
extensions, and 'cofpmf' for Count OverFlow and Privilege Mode Filtering)
extension[2] allows the perf like tool to handle overflow interrupts and
filtering support.

This series implements full PMU infrastructure to support
PMU in virt machine. This will allow us to add any PMU events in future.

Currently, this series enables the following omu events.
1. cycle count
2. instruction count
3. DTLB load/store miss
4. ITLB prefetch miss

The first two are computed using host ticks while last three are counted during
cpu_tlb_fill. We can do both sampling and count from guest userspace.
This series has been tested on both RV64 and RV32. Both Linux[3] and Opensbi[4]
patches are required to get the perf working.

Here is an output of perf stat/report while running hackbench with latest
OpenSBI & Linux kernel.

Perf stat:
==========
[root@fedora-riscv ~]# perf stat -e cycles -e instructions -e dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses \
> perf bench sched messaging -g 1 -l 10
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 1 groups == 40 processes run

     Total time: 0.265 [sec]

 Performance counter stats for 'perf bench sched messaging -g 1 -l 10':

     4,167,825,362      cycles                                                      
     4,166,609,256      instructions              #    1.00  insn per cycle         
         3,092,026      dTLB-load-misses                                            
           258,280      dTLB-store-misses                                           
         2,068,966      iTLB-load-misses                                            

       0.585791767 seconds time elapsed

       0.373802000 seconds user
       1.042359000 seconds sys

Perf record:
============
[root@fedora-riscv ~]# perf record -e cycles -e instructions \
> -e dTLB-load-misses -e dTLB-store-misses -e iTLB-load-misses -c 10000 \
> perf bench sched messaging -g 1 -l 10
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 1 groups == 40 processes run

     Total time: 1.397 [sec]
[ perf record: Woken up 10 times to write data ]
Check IO/CPU overload!
[ perf record: Captured and wrote 8.211 MB perf.data (214486 samples) ]

[root@fedora-riscv riscv]# perf report
Available samples                                                               
107K cycles                                                                    ◆
107K instructions                                                              ▒
250 dTLB-load-misses                                                           ▒
13 dTLB-store-misses                                                           ▒
172 iTLB-load-misses      
..

Changes from v8->v9:
1. Added the write_done flags to the vmstate.
2. Fixed the hpmcounter read access from M-mode.

Changes from v7->v8:
1. Removeding ordering constraints for mhpmcounter & mhpmevent.

Changes from v6->v7:
1. Fixed all the compilation errors for the usermode.

Changes from v5->v6:
1. Fixed compilation issue with PATCH 1.
2. Addressed other comments.

Changes from v4->v5:
1. Rebased on top of the -next with following patches.
   - isa extension
   - priv 1.12 spec
2. Addressed all the comments on v4
3. Removed additional isa-ext DT node in favor of riscv,isa string update

Changes from v3->v4:
1. Removed the dummy events from pmu DT node.
2. Fixed pmu_avail_counters mask generation.
3. Added a patch to simplify the predicate function for counters. 

Changes from v2->v3:
1. Addressed all the comments on PATCH1-4.
2. Split patch1 into two separate patches.
3. Added explicit comments to explain the event types in DT node.
4. Rebased on latest Qemu.

Changes from v1->v2:
1. Dropped the ACks from v1 as signficant changes happened after v1.
2. sscofpmf support.
3. A generic counter management framework.

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
[2] https://drive.google.com/file/d/171j4jFjIkKdj5LWcExphq4xG_2sihbfd/edit
[3] https://github.com/atishp04/qemu/tree/riscv_pmu_v9

Atish Patra (12):
target/riscv: Fix PMU CSR predicate function
target/riscv: Implement PMU CSR predicate function for S-mode
target/riscv: pmu: Rename the counters extension to pmu
target/riscv: pmu: Make number of counters configurable
target/riscv: Implement mcountinhibit CSR
target/riscv: Add support for hpmcounters/hpmevents
target/riscv: Support mcycle/minstret write operation
target/riscv: Add sscofpmf extension support
target/riscv: Simplify counter predicate function
target/riscv: Add few cache related PMU events
hw/riscv: virt: Add PMU DT node to the device tree
target/riscv: Update the privilege field for sscofpmf CSRs

hw/riscv/virt.c           |  28 ++
target/riscv/cpu.c        |  14 +-
target/riscv/cpu.h        |  56 ++-
target/riscv/cpu_bits.h   |  59 +++
target/riscv/cpu_helper.c |  25 ++
target/riscv/csr.c        | 906 ++++++++++++++++++++++++++++----------
target/riscv/machine.c    |  29 ++
target/riscv/meson.build  |   3 +-
target/riscv/pmu.c        | 432 ++++++++++++++++++
target/riscv/pmu.h        |  36 ++
10 files changed, 1353 insertions(+), 235 deletions(-)
create mode 100644 target/riscv/pmu.c
create mode 100644 target/riscv/pmu.h

--
2.25.1

