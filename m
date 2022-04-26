Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDB75107AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353218AbiDZS4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353070AbiDZS4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:56:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3EA15613F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:53:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id bo5so18793766pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMn8myMUy/xks0zAUGTj68bP5leid2WlXPOOX8hNXzU=;
        b=Lq1qfYNvDVIKXnBpxw3hPz6Le2o1L8AkMCTY3ptzmLaYBXEyJzoZO60lICnlYTt9AO
         7DGW53e/1q/T7aOyQLigQK1PHgXVaRAEya+6Sj35Zga+9wejIYH0cWFuDbxrRtg7ZF4p
         xq4yjoPbFEwuBY0FD9dT/bjRt0pNhHqnsKG9shFQjKBMLrSctNPd5JVIQ/WarldNNLaG
         ffyOyySPU02nnWckpcl9Au3a+f1eZe5uo/1dBxOjNQmXXcr5IFb3yzUPqv+G8N8gYixb
         te0ntmjGPh5Yzp0DPeIX0Ji/fST5980Y1uPm7l0rKkkdg3uJ1q0jZGczAdkUSt3/tBKd
         k1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMn8myMUy/xks0zAUGTj68bP5leid2WlXPOOX8hNXzU=;
        b=qY82Yy9eaBHx89R6GX0Bfkz+v2hpbBvY9jzeyFVc5yto0DrxBL+0q8MuYSiGu50nwU
         UN4ZcQXVuWoKmi/HW4qxPocWFgkliUmHzMFepjDNnt6Ke7RKAjNXNheI1+wTPUyOGNQi
         vZo3P7SztNlcnfrppnw+dKJF4w0v9NK1z97+e3MaV+9ocVcudl8Zebn4plKr0Bmpt9mC
         t4yjjLnKVBcdNKWpcwCbyRgoDIjqMvP60JEIpfSlMvZbzBqsVeG/CLuptIn4CZiDKv7z
         IqlUTE89qs9n374opDoMB5f13CUCyI7feo4XBkwSzEYIdhmA9HBSqc5BTdGB4DIUyHJb
         FmgA==
X-Gm-Message-State: AOAM533XpMRYVsavZ/mRRpJMpSeBKKoyDMpDnLMmi4RwT0eAJjuLXpo5
        uV6/qfY1Ze+0N5xp2K46Ylo9iGl4H+/Wkg==
X-Google-Smtp-Source: ABdhPJwNDSCDMjlhPP/yeNIfJjRkz3mOWh6WcKKp1EIcuCmVJORf+JecC065cep/KXKikC3d6gUqTA==
X-Received: by 2002:aa7:83c2:0:b0:505:723f:6ace with SMTP id j2-20020aa783c2000000b00505723f6acemr26200192pfn.86.1650999186971;
        Tue, 26 Apr 2022 11:53:06 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id cl18-20020a17090af69200b001cd4989ff5asm3839664pjb.33.2022.04.26.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:53:06 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 0/4] Add Sstc extension support 
Date:   Tue, 26 Apr 2022 11:52:41 -0700
Message-Id: <20220426185245.281182-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
PATCH 4 implements the Sstc extension in KVM.

This series has been tested on Qemu(RV32 & RV64) with additional patches in
OpenSBI[2] and Qemu[3]. This series can also be found at [4].

Changes from v2->v3:
1. Dropped unrelated KVM fixes from this series.
2. Rebased on 5.18-rc3.

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
[2] https://github.com/atishp04/opensbi/tree/sstc_v2
[3] https://github.com/atishp04/qemu/tree/sstc_v2
[3] https://github.com/atishp04/linux/tree/sstc_v3

Atish Patra (4):
RISC-V: Add SSTC extension CSR details
RISC-V: Enable sstc extension parsing from DT
RISC-V: Prefer sstc extension if available
RISC-V: KVM: Support sstc extension

arch/riscv/include/asm/csr.h            |  11 ++
arch/riscv/include/asm/hwcap.h          |   1 +
arch/riscv/include/asm/kvm_host.h       |   1 +
arch/riscv/include/asm/kvm_vcpu_timer.h |   8 +-
arch/riscv/include/uapi/asm/kvm.h       |   1 +
arch/riscv/kernel/cpu.c                 |   1 +
arch/riscv/kernel/cpufeature.c          |   1 +
arch/riscv/kvm/main.c                   |  12 ++-
arch/riscv/kvm/vcpu.c                   |   5 +-
arch/riscv/kvm/vcpu_timer.c             | 138 +++++++++++++++++++++++-
drivers/clocksource/timer-riscv.c       |  21 +++-
11 files changed, 193 insertions(+), 7 deletions(-)

--
2.25.1

