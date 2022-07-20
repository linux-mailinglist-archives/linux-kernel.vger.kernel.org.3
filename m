Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1C57B98A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbiGTPY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbiGTPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:24:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DE05C365
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:24:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a15so18098870pjs.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHwhUmqnsj8HFUypS9rHK25Hx/gKDzV2R3u+QfRiaMw=;
        b=hzEFXSBuSMgMbFZCf9M8Of8vt+XWPvlwgPldLZpxECiof0cHErJf12FlamvqlHCITP
         kRqoD9rmOjne2RWom0AizCBgGptCe7oLnpBjfF96IP6hAi32xqTRfs+6FJYopD2Yr+Kl
         5CN474gWYkk+p74H64MSNnt+xP9bimiiks4TfA8R7uuOgWGZJKsRFoO9JlZ1uz53mkrH
         YnhB4WpPmWIOl9oJy5MCR049MXiLQKzTKT925LFxJMuAsPPZ422s7FW0tKg+Ruieds6B
         w6XadtOABCMqna95ztZj+yM7eneiMB2plMc2pegDKEPdtMdvUIhgjj3jklBeceJ7/fyf
         Aksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHwhUmqnsj8HFUypS9rHK25Hx/gKDzV2R3u+QfRiaMw=;
        b=VEh1hewZozkytt/PQLmNPdhhsSo4fG8QMZEf0w6We7FVE/73YndceZa/J7P3TWxe7C
         +ZArMFqzcJLWO2T9sscstwhJsqiKv+e/ySV/9GEWZVWkPha5hZdvtYvu7vR4z5lhsHRS
         snJTGkuIXLTmL5gSL+WW6QsdkkHnjmVzBG6Cd5jqDgxiTtu7m6ohjoQoAVEFGXwNzqOa
         pLkUV06OPkODqyuswS5hIKg5EGOXm8ZLL8MNfYZW428nJjDEt1x/22wuOG84J+gl/9+G
         cfga5zbQSo54gEfHXPTxh/G/YjWalBYk9eNdmCVpTt3gS+spIaq1FGwMEilCRh+PeZ5y
         LxVQ==
X-Gm-Message-State: AJIora8nfjGcoEVCBpyCXP07XmFSs/2N52b8jPfSAjtZnOgnCO4HTDob
        FPlllUUfPR0fuyOW8jsIUuY+4Q==
X-Google-Smtp-Source: AGRyM1sCgYiniSpfKT8i8KggkBICG8BAIhcO4Q+48uVLRhVcZhWtkN4L21+uKdniDfLs00cXy7XEBg==
X-Received: by 2002:a17:90b:4b81:b0:1ef:cd2c:bf2e with SMTP id lr1-20020a17090b4b8100b001efcd2cbf2emr5933583pjb.137.1658330662853;
        Wed, 20 Jul 2022 08:24:22 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([122.179.42.230])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b0016cf8f0bdd5sm6013031plk.108.2022.07.20.08.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:24:22 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v7 0/7] RISC-V IPI Improvements
Date:   Wed, 20 Jul 2022 20:53:41 +0530
Message-Id: <20220720152348.2889109-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to improve IPI support in Linux RISC-V in following ways:
 1) Treat IPIs as normal per-CPU interrupts instead of having custom RISC-V
    specific hooks. This also makes Linux RISC-V IPI support aligned with
    other architectures.
 2) Remote TLB flushes and icache flushes should prefer local IPIs instead
    of SBI calls whenever we have specialized hardware (such as RISC-V AIA
    IMSIC and RISC-V SWI) which allows S-mode software to directly inject
    IPIs without any assistance from M-mode runtime firmware.

These patches were originally part of the "Linux RISC-V ACLINT Support"
series but this now a separate series so that it can be merged independently
of the "Linux RISC-V ACLINT Support" series.
(Refer, https://lore.kernel.org/lkml/20211007123632.697666-1-anup.patel@wdc.com/)

These patches are also a preparatory patches for the up-coming:
 1) Linux RISC-V AIA support
 2) KVM RISC-V TLB flush improvements
 3) Linux RISC-V SWI support

These patches can also be found in riscv_ipi_imp_v7 branch at:
https://github.com/avpatel/linux.git

Changes since v6:
 - Rebased on Linux-5.19-rc7
 - Added documentation for struct ipi_mux_ops in PATCH3
 - Dropped dummy irq_mask()/unmask() in PATCH3
 - Added const for "ipi_mux_chip" in PATCH3
 - Removed "type" initialization from ipi_mux_domain_alloc() in PATCH3
 - Dropped translate() from "ipi_mux_domain_ops" in PATCH3
 - Improved barrier documentation in ipi_mux_process() of PATCH3
 - Added percpu check in ipi_mux_create() for parent_virq of PATCH3
 - Added nr_ipi parameter in ipi_mux_create() of PATCH3

Changes since v5:
 - Rebased on Linux-5.18-rc3
 - Used kernel doc style in PATCH3
 - Removed redundant loop in ipi_mux_process() of PATCH3
 - Removed "RISC-V" prefix form ipi_mux_chip.name of PATCH3
 - Removed use of "this patch" in PATCH3 commit description
 - Addressed few other nit comments in PATCH3

Changes since v4:
 - Rebased on Linux-5.17
 - Includes new PATCH3 which adds mechanism to multiplex a single HW IPI

Changes since v3:
 - Rebased on Linux-5.17-rc6
 - Updated PATCH2 to not export riscv_set_intc_hwnode_fn()
 - Simplified riscv_intc_hwnode() in PATCH2

Changes since v2:
 - Rebased on Linux-5.17-rc4
 - Updated PATCH2 to not create synthetic INTC fwnode and instead provide
   a function which allows drivers to directly discover INTC fwnode

Changes since v1:
 - Use synthetic fwnode for INTC instead of irq_set_default_host() in PATCH2

Anup Patel (7):
  RISC-V: Clear SIP bit only when using SBI IPI operations
  irqchip/riscv-intc: Allow drivers to directly discover INTC hwnode
  genirq: Add mechanism to multiplex a single HW IPI
  RISC-V: Treat IPIs as normal Linux IRQs
  RISC-V: Allow marking IPIs as suitable for remote FENCEs
  RISC-V: Use IPIs for remote TLB flush when possible
  RISC-V: Use IPIs for remote icache flush when possible

 arch/riscv/Kconfig                |   2 +
 arch/riscv/include/asm/irq.h      |   4 +
 arch/riscv/include/asm/sbi.h      |   2 +
 arch/riscv/include/asm/smp.h      |  51 +++++---
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/irq.c           |  21 +++-
 arch/riscv/kernel/sbi-ipi.c       |  60 +++++++++
 arch/riscv/kernel/sbi.c           |  11 --
 arch/riscv/kernel/smp.c           | 167 +++++++++++++------------
 arch/riscv/kernel/smpboot.c       |   5 +-
 arch/riscv/mm/cacheflush.c        |   5 +-
 arch/riscv/mm/tlbflush.c          |  93 +++++++++++---
 drivers/clocksource/timer-clint.c |  41 ++++--
 drivers/irqchip/irq-riscv-intc.c  |  60 ++++-----
 include/linux/irq.h               |  16 +++
 kernel/irq/Kconfig                |   4 +
 kernel/irq/Makefile               |   1 +
 kernel/irq/ipi-mux.c              | 199 ++++++++++++++++++++++++++++++
 19 files changed, 579 insertions(+), 167 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi-ipi.c
 create mode 100644 kernel/irq/ipi-mux.c

-- 
2.34.1

