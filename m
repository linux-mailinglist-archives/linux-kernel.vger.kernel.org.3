Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0880D504F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiDRK4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiDRK4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:56:21 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489F21901D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:53:43 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k62so12157089pgd.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=her0KFXUz9ZM0eej9Tysz7JCVsy+0ZU1+POTkCVRJPk=;
        b=BTMPZTQ6i3UnKiuixUwA9qpCyzIB/p/mZE8778CnegoWieKLJqqpZfXpqkP0LqOWmi
         nQkwXeT+QlIdkJFiXcsZ6B7rh5fcmDRCMgRRI+vcernAOKt7BtmzCZEl9ThkyGehDvEL
         0stXaNy9UWBh+iKF6si6AbPtjpUBajNPUPOM6yOSwRIqeQDIiHSACwZ7/Sed5z12J/Kg
         cNdX8KDQiqbQy9Cq+zstlFwhrS3EewCTs96+HaYKVeIBkndydKJoGrBO8nX/k+z2gXiq
         LC8NhSuaVjazf15cqhWQc4QBYYFxsnGaUf7gV5Pxj6j7H+CIbopx80AT2cq+tmuDaAQe
         qoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=her0KFXUz9ZM0eej9Tysz7JCVsy+0ZU1+POTkCVRJPk=;
        b=MTZ9k7S7XXHLQkaILHEpS/Myh02F9L9uDs4+nnjZMkTWLq4SJN/1SJW/YPUVDWlA/6
         bnTswC0rfyjjqK74qnRaZxUXTBb0ZhP9YNz7EtZpnV4pp5XDi/sgWZIfWfxY1xI7StQY
         Arl8C1/f7AtGhaShGsIYYpunAYxzx/VuhwsrnFCugT8Ewm+41a3j90cLNltiCXrf3vJv
         gZs8+7gNnoEOMhawZ4ZfOhW9Tq8CaFCkhUjAVhHcgL2omJdhxX8CUovPymzfCnm6/DKQ
         9pdKBmKgZEMwUds9rQevUCsyIcLOdgRJGMdaZppICkaW6N0ize5D9DmCfegJFb6vJ6Mz
         fjJA==
X-Gm-Message-State: AOAM5307UyPcHuGFZHVCa5YH/Zn6R82B5zmnWm5Ugjazb27pRHT+yR1D
        /sFUn7XpdpS8oixpfEtun7AiAA==
X-Google-Smtp-Source: ABdhPJysT7CWdPdJ4dp09F7+iT+mxn/7CeeF09kO5aewy36J0xFI6mTXW+GLV3EJYhltb8j2V35j/w==
X-Received: by 2002:a65:6a07:0:b0:39d:8c35:426b with SMTP id m7-20020a656a07000000b0039d8c35426bmr9750747pgu.171.1650279222665;
        Mon, 18 Apr 2022 03:53:42 -0700 (PDT)
Received: from localhost.localdomain ([122.172.241.223])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm12986278pfu.202.2022.04.18.03.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 03:53:41 -0700 (PDT)
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
Subject: [PATCH v6 0/7] RISC-V IPI Improvements
Date:   Mon, 18 Apr 2022 16:22:58 +0530
Message-Id: <20220418105305.1196665-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

These patches can also be found in riscv_ipi_imp_v6 branch at:
https://github.com/avpatel/linux.git

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
 arch/riscv/include/asm/smp.h      |  49 +++++---
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/irq.c           |  21 +++-
 arch/riscv/kernel/sbi-ipi.c       |  60 +++++++++
 arch/riscv/kernel/sbi.c           |  11 --
 arch/riscv/kernel/smp.c           | 164 +++++++++++++------------
 arch/riscv/kernel/smpboot.c       |   5 +-
 arch/riscv/mm/cacheflush.c        |   5 +-
 arch/riscv/mm/tlbflush.c          |  93 +++++++++++---
 drivers/clocksource/timer-clint.c |  41 +++++--
 drivers/irqchip/irq-riscv-intc.c  |  60 ++++-----
 include/linux/irq.h               |  11 ++
 kernel/irq/Kconfig                |   4 +
 kernel/irq/Makefile               |   1 +
 kernel/irq/ipi-mux.c              | 197 ++++++++++++++++++++++++++++++
 19 files changed, 567 insertions(+), 167 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi-ipi.c
 create mode 100644 kernel/irq/ipi-mux.c

-- 
2.25.1

