Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA34E65D9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351224AbiCXPPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243416AbiCXPPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:15:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8338249F8E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:14:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y6so2463108plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/lHQwYCz6iMd1XYierGzMlVkOLDpnchjw8A/t5vp6xQ=;
        b=UABAOxJzfwjqipTEfrpgHIDYtfS42ghYAxlCG9X9F4EcQR6zMncrbecT+H3Tz+DPnP
         qskduDciaHgzsfc9Tw4cEbXt5mJrdMoVh/mvPXB0mpjLNMf26IUToeO21tUr3SgwafgE
         o4RAIPikGlHr3Ptcw02hgIGeYSTpDQGqQpDxL9ecJmJQp328ozU15VtzeK8PN0TrGi/T
         SNFGhUpg/dGmukBd0PFNmYdPaGIh9v4yG8nyfldh1U0AkBy9PaJpW7TXoMWbdQ0aFovh
         W6AOM12lPGLtZ7mBGa0xKCA8JY7xCUmR4DxXE2Mz3hbxM3mrktxHOz241Zm4de3ELW+u
         rWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/lHQwYCz6iMd1XYierGzMlVkOLDpnchjw8A/t5vp6xQ=;
        b=mzABAsQqnDvOy170Ss3TJomCf0LoRf40ztxWUTJPXaCeHv9QOrhhFtN4Kta8BqppwD
         VquFlP7Kw+Vz3tfmw4jouSJg1UFwt9blIF61E9RUdaaV6o3tNwxKlwvETCaDTfA6AbH6
         K23spCLetzVTym6qYz4pkuAZwfshJno/Y4uAar+nbDTthESlLt9BQL/HVwsuejg7A/W8
         tmZiYMlNfUMuKaczVxAQqC4vGFLZTjMS9c9LKRDLbohzKR3Vd6QYOmHWym4R9iq6yBVm
         qtGcx30b/NyFdeoKBtSERf8tzPVK2jPjXWI2YV9lVIIZwEuCoVlDSgpWPX7+4wzZ+4+Y
         xtnA==
X-Gm-Message-State: AOAM530iM70t1B58WaMSSpP0dVnJj28hp/wCH1gvdHlQCcS/qgGMRXAf
        D6zYNoHJIsXo471ZIZLn1XO5eA==
X-Google-Smtp-Source: ABdhPJxd6U3Ruv7PpJ436PVg71gkDyH1nkaWTeT7Uk4oN78ga7bi4rqlCshe73IUNVBMkb12y+Cbyw==
X-Received: by 2002:a17:903:240c:b0:153:c8df:7207 with SMTP id e12-20020a170903240c00b00153c8df7207mr6372719plo.44.1648134842828;
        Thu, 24 Mar 2022 08:14:02 -0700 (PDT)
Received: from localhost.localdomain ([122.171.187.87])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a00239000b004fa7103e13csm4166065pfc.41.2022.03.24.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 08:14:02 -0700 (PDT)
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
Subject: [PATCH v5 0/7] RISC-V IPI Improvements
Date:   Thu, 24 Mar 2022 20:42:51 +0530
Message-Id: <20220324151258.943896-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

These patches can also be found in riscv_ipi_imp_v5 branch at:
https://github.com/avpatel/linux.git

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
 arch/riscv/include/asm/smp.h      |  49 +++++---
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/irq.c           |  21 +++-
 arch/riscv/kernel/sbi-ipi.c       |  60 ++++++++++
 arch/riscv/kernel/sbi.c           |  11 --
 arch/riscv/kernel/smp.c           | 164 +++++++++++++-------------
 arch/riscv/kernel/smpboot.c       |   5 +-
 arch/riscv/mm/cacheflush.c        |   5 +-
 arch/riscv/mm/tlbflush.c          |  93 ++++++++++++---
 drivers/clocksource/timer-clint.c |  41 +++++--
 drivers/irqchip/irq-riscv-intc.c  |  60 +++++-----
 include/linux/irq.h               |  28 +++++
 kernel/irq/Kconfig                |   4 +
 kernel/irq/Makefile               |   1 +
 kernel/irq/ipi-mux.c              | 190 ++++++++++++++++++++++++++++++
 19 files changed, 577 insertions(+), 167 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi-ipi.c
 create mode 100644 kernel/irq/ipi-mux.c

-- 
2.25.1

