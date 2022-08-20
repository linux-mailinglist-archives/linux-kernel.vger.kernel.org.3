Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22C459ABDD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244181AbiHTGzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiHTGzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:55:49 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06978C04FC
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:55:46 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 53-20020a9d0838000000b006371d896343so4410232oty.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=KPNOEhwPuKr2rNEs7Vth7fZX5wzX+lJkHQAT28oftZM=;
        b=mnw8mo+p85WWeHD6KVAZuMFd0M9sEPZgWPeOmxyJAdVCKYqNxjY62gI1d30T3B74/0
         sDIrWCsDeyEfF2UFPDXLPmtW6J/39+zCfB5pEGhyv84oYW8U2+EVAT6VEyTNWirYKTNm
         iEy3aM3j/6lckKeBKE42t6siB30oD11JYGkMRTsfR2J732jSwcUoYolUzf1gWpnbspKF
         EVP3rwcI9UnzOW3WveO/xpO/eBHN22XaGG5vJnIXmNUvTtSRpsaUTY9Hjok9XqltZB6t
         qNGbeHndpxpZ+icJvrXq4TAKLtQoYFVWQG/4kFKAXXaQvcu1gJ6e74z50bknAMRjJkPs
         vKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=KPNOEhwPuKr2rNEs7Vth7fZX5wzX+lJkHQAT28oftZM=;
        b=S43vbAopzDuKE6Oi8/zdvUkunpiLUILqRnBLv9PgiaYy7lwIEb+hM6Udi/uSp10TM8
         i35Uo64LWCcEnLJ0dt0sP7OYNNnxkpX47epHXsHsQaz5BKIal8Uuw1AInyeJwuxYLUWi
         PFtPh82oz54aKrFhrpKv2GworrtTs9KcY2CAx6/+Jw4pI48oOm68qJlxaPIfDdDc7z6F
         ExaBxHmzIm0o3DpGiz1GNneQi0BL5oqFJVonxA9GOLXX0Fs83Y+6j+uvCjHGYNkamLcW
         PPcce285BR4YvK0S1K2fwjmq7eFm/upGQmCKTEbmOW5XqxPG3Enva2+3mypmQ6rqdZkN
         J6iQ==
X-Gm-Message-State: ACgBeo2Kc69e9nofQRWbcw/Gca6/OtzaGWLhwYU+RBZb/zn1brfCmaeg
        eiEunX5AMG7Uibph011YxNNCYuJgVn7mZQ==
X-Google-Smtp-Source: AA6agR5ILnYcedXqGh51ZJjhO/bA6id8F/rppfMkigrZPruGOqlxzUMNW0sV5J1OdsTKvAh7Dzkbfg==
X-Received: by 2002:a05:6830:3c1:b0:637:28be:7920 with SMTP id p1-20020a05683003c100b0063728be7920mr4268310otc.105.1660978544886;
        Fri, 19 Aug 2022 23:55:44 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.82.68])
        by smtp.gmail.com with ESMTPSA id h26-20020a9d641a000000b00636faf5e2d9sm1661098otl.39.2022.08.19.23.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 23:55:44 -0700 (PDT)
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
Subject: [PATCH v8 0/7] RISC-V IPI Improvements
Date:   Sat, 20 Aug 2022 12:24:39 +0530
Message-Id: <20220820065446.389788-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
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
 2) Linux RISC-V SWI support

These patches can also be found in riscv_ipi_imp_v8 branch at:
https://github.com/avpatel/linux.git

Changes since v7:
 - Rebased on Linux-6.0-rc1
 - Use atomic operations to track per-CPU pending and enabled IPIs in PATCH3.
   (Note: this is inspired from IPI muxing implemented in
    drivers/irqchip/irq-apple-aic.c)
 - Made "struct ipi_mux_ops" (added by PATCH3) flexible so that
   drivers/irqchip/irq-apple-aic.c can adopt it in future.

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
 arch/riscv/include/asm/sbi.h      |   7 +
 arch/riscv/include/asm/smp.h      |  49 ++++--
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/irq.c           |  21 ++-
 arch/riscv/kernel/sbi-ipi.c       |  60 ++++++++
 arch/riscv/kernel/sbi.c           |  11 --
 arch/riscv/kernel/smp.c           | 164 ++++++++++----------
 arch/riscv/kernel/smpboot.c       |   5 +-
 arch/riscv/mm/cacheflush.c        |   5 +-
 arch/riscv/mm/tlbflush.c          |  93 ++++++++++--
 drivers/clocksource/timer-clint.c |  42 +++--
 drivers/irqchip/irq-riscv-intc.c  |  60 ++++----
 include/linux/irq.h               |  18 +++
 kernel/irq/Kconfig                |   5 +
 kernel/irq/Makefile               |   1 +
 kernel/irq/ipi-mux.c              | 244 ++++++++++++++++++++++++++++++
 19 files changed, 628 insertions(+), 167 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi-ipi.c
 create mode 100644 kernel/irq/ipi-mux.c

-- 
2.34.1

