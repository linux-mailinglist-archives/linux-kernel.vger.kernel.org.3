Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6494CDEAA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiCDUPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiCDUPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:15:31 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3244D56C34
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:11:18 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id bc10so8377210qtb.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c3hwhrGILXdhz/XeWc3KW5uuxAFbMTxchWciY7LftwM=;
        b=gWSOzgXN0en0k+yoq+gp40hIQ0jSbo3zMvH3uDi3oO6KZwtgAzpOILlFXgVqme9ZQe
         QL3YG2VE/6OjVosmCdiTn+JwxyrijZr0T7iam6gOGSXhvyljatoF9/m4/mCf0/oW5EY8
         BgDtLZTQYDyLXoBJzGDoEBc47P5Qytf0LNtobMd+TVur6an2OoC899T5IGQYae6dupq5
         hlGs3iz76pUFYOrI5x2MLuKu1g7fe1bc7sZrJckIiAV4QeBEYYhiMirYgU00wffDYnKV
         0UbdZaOomJYY6WQ7i7RdG6OraQxQ8soBBvKsgseUzObhZdsLPcG0e6DWNPh2AAxdB6qm
         VsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c3hwhrGILXdhz/XeWc3KW5uuxAFbMTxchWciY7LftwM=;
        b=74Q8H/bgvoleVm3lxz4veu9wuGzCxyAR2XRaCpMmsnnC1guVGmbNfGGEo7zeiyDq7P
         PfqHuDV9GIATHzn2LF16lMzbJq2vAc1BLzsAVYw5TkfA1ivxmElmzs78Z66QLQUwQdUf
         7iMyWdh05CIXeoaWOCObpbG/RSibau809yume00zNqUyCh5H274PX3h8YP8blLRujmvO
         z2TRd2PGn5kRcc51Bt699LvaCFN0QNHpRJbC+MX0TDp59l85LHcJNPu557tsWy3FSS4/
         Z2zRUHaTz/IaOVqgDnlZfQcutZ2JP4zZmnA9iKAYlIkh44J6RWGj5SutsnD5WPLRoBhV
         aFaw==
X-Gm-Message-State: AOAM531lrszqJg9f3WBBtQB751VNAoHDM0Vmm4qYeogDZY7uYQibdCLK
        2YO2ju3ai9RSBjPmTTywj/cJ4ZtS/jUDLA==
X-Google-Smtp-Source: ABdhPJy7TOhFoNFD4vGDLADKFrKXnucp+teoiBHQIPQ3w172uA42MtTQNHkgRMmFcWN/TpxO2Qz/Qg==
X-Received: by 2002:a05:622a:548:b0:2e0:4a6f:7c7e with SMTP id m8-20020a05622a054800b002e04a6f7c7emr375590qtx.303.1646424637904;
        Fri, 04 Mar 2022 12:10:37 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id 20-20020ac84e94000000b002de8f564305sm4605481qtp.1.2022.03.04.12.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:10:37 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH v2 0/7] Add Sstc extension support 
Date:   Fri,  4 Mar 2022 12:10:13 -0800
Message-Id: <20220304201020.810380-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements Sstc extension support which was ratified recently.
Before the Sstc extension, an SBI call is necessary to generate timer
interrupts as only M-mode have access to the timecompare registers. Thus,
there is significant latency to generate timer interrupts at kernel.
For virtualized enviornments, its even worse as the KVM handles the SBI call
and uses a software timer to emulate the timecomapre register. 

Sstc extension solves both these problems by defining a stimecmp/vstimecmp
at supervisor (host/guest) level. It allows kernel to program a timer and
recieve interrupt without supervisor execution enviornment (M-mode/HS mode)
intervention.

To maintain backward compatibility, KVM directly updates the vstimecmp
if older kernel without sstc support is running in guest. Similary, the
M-mode firmware(OpenSBI) uses stimecmp for older kernel without sstc support. 

The PATCH 1 & 2 enables the basic infrastructure around Sstc extension while
PATCH 3 lets kernel use the Sstc extension if it is available in hardware.
PATCH 4 & 5 adds the infrastructure for KVM to use sstc while PATCH 6 actually
uses the Sstc extension if available. 

This series has been tested on Qemu(RV32 & RV64) with additional patches in
OpenSBI[2] and Qemu[3]. This series can also be found at [4].

Changes from v1->v2:
1. Separate the static key from kvm usage
2. Makde the sstc specific static key local to the driver/clocksource
3. Moved the vstimecmp update code to the vcpu_timer
4. Used function pointers instead of static key to invoke vstimecmp vs
   hrtimer at the run time. This will help in future for migration of vms
   from/to sstc enabled hardware to non-sstc enabled hardware.
5. Unified the vstimer & timer to 1 timer as only one of them will be used
   at runtime.

[1] https://drive.google.com/file/d/1m84Re2yK8m_vbW7TspvevCDR82MOBaSX/view
[2] https://github.com/atishp04/opensbi/tree/sstc_v1
[3] https://github.com/atishp04/qemu/tree/sstc_v1
[3] https://github.com/atishp04/linux/tree/sstc_v2

Atish Patra (7):
RISC-V: Add SSTC extension CSR details
RISC-V: Enable sstc extension parsing from DT
RISC-V: Prefer sstc extension if available
RISC-V: KVM: Remove 's' & 'u' as valid ISA extension
RISC-V: KVM: Restrict the extensions that can be disabled
RISC-V: KVM: Introduce ISA extension register
RISC-V: KVM: Support sstc extension

arch/riscv/include/asm/csr.h            |  11 ++
arch/riscv/include/asm/hwcap.h          |   1 +
arch/riscv/include/asm/kvm_host.h       |   1 +
arch/riscv/include/asm/kvm_vcpu_timer.h |   8 +-
arch/riscv/include/uapi/asm/kvm.h       |  21 ++++
arch/riscv/kernel/cpu.c                 |   1 +
arch/riscv/kernel/cpufeature.c          |   4 +-
arch/riscv/kvm/main.c                   |  12 ++-
arch/riscv/kvm/vcpu.c                   | 128 ++++++++++++++++++++--
arch/riscv/kvm/vcpu_timer.c             | 138 +++++++++++++++++++++++-
drivers/clocksource/timer-riscv.c       |  21 +++-
11 files changed, 328 insertions(+), 18 deletions(-)

--
2.30.2

