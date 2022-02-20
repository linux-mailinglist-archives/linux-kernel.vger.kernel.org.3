Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6D4BCC36
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 06:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiBTFKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 00:10:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiBTFKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 00:10:16 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4C4517F9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:09:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so505529pja.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9hsPYcteR10WA7lfsDos/ZOUyC+n8S5x6ZzrXPZlWU=;
        b=WItHiDHMImZT8YkqravV5XN9IAt8UdgYE2yTJI3gUEl7h7t4Krs79t1kMYXbckyQ3p
         Ui6Zon1OHSYH1+2I+tKYeAzSfvHJ/JuSBdRf35gnRaaSt96/E15eOCxm7TvH5CTB/Gg0
         U/cJAVAtZyWOYSPrO08c24iE6CxKOEeslduPvdoNVYhRDnHzW7z60g8F1Nk46OIs8xOO
         7BmFSNVWmLEWDtbk7b+Uoan0jlwr5rFxY7hYfLc0ZLWmtCskcD9s2ZirwBJmQ18gQHjR
         jQ4jxZxv82L/7inw+9HddWTxiLOQ4P7eDxK4tXhlE29LnezJpTry4r8+clnvI/xMCZTW
         ElAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9hsPYcteR10WA7lfsDos/ZOUyC+n8S5x6ZzrXPZlWU=;
        b=GbGjoQDdY51J5qYyreftM/JxWm/U+72QeyJ19YbNxcMsC6WQCYUIU5uYTKUB0+iuWa
         tWIMGc1NeV8uDWuLKfVL1Y8DmuCYo3zEHMWypUiM1JI0j9UCvMO5d5xVV51eltHGyxlr
         p+d7PnKInA5wHNELB26nB3iJoAvzd6bGDzbP6x1NbzWGEALoMP908sPLLGtwuv/jzecO
         3MfPRdgrlYGx/Cpy9psDsHSGQwwbeUZB7rg7Dw4hrrsBbg7CLUs7eiaesx/UaDP/w5mT
         XmFosAKPmdmAmyUk+3GA8n/hlJabC87L8RGwnvP+3zZrA6KgNy9Ip9mT6o3jG2P1lBzZ
         CuAg==
X-Gm-Message-State: AOAM530xwKfgFgVvqH4vXVAhYqvWc+os9uc2tRDFeX8UpRu/fBdrKmiB
        hy3vtJsbdn/h42RKUl/tlKJ0QQ==
X-Google-Smtp-Source: ABdhPJzIIsM0NBtAQaKFWKl0r/CtXB/tsXYkX1yg2VL7Ra8z/kgM1Ps334KF1VdRvu12Umj2DbcGIg==
X-Received: by 2002:a17:903:11cc:b0:14d:a0d5:76f with SMTP id q12-20020a17090311cc00b0014da0d5076fmr14104216plh.109.1645333795268;
        Sat, 19 Feb 2022 21:09:55 -0800 (PST)
Received: from localhost.localdomain ([122.162.118.38])
        by smtp.gmail.com with ESMTPSA id 84sm7602730pfx.181.2022.02.19.21.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 21:09:54 -0800 (PST)
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
Subject: [PATCH v3 0/6] RISC-V IPI Improvements
Date:   Sun, 20 Feb 2022 10:38:48 +0530
Message-Id: <20220220050854.743420-1-apatel@ventanamicro.com>
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
    IMSIC and RISC-V ACLINT) which allows S-mode software to directly inject
    IPIs without any assistance from M-mode runtime firmware.

These patches were originally part of the "Linux RISC-V ACLINT Support"
series but this now a separate series so that it can be merged independently
of the "Linux RISC-V ACLINT Support" series.
(Refer, https://lore.kernel.org/lkml/20211007123632.697666-1-anup.patel@wdc.com/)

These patches are also a preparatory patches for the up-coming:
 1) Linux RISC-V AIA support
 2) KVM RISC-V TLB flush improvements
 3) Linux RISC-V SWI support

These patches can also be found in riscv_ipi_imp_v3 branch at:
https://github.com/avpatel/linux.git

Changes since v2:
 - Rebased on Linux-5.17-rc4
 - Updated PATCH2 to not create synthetic INTC fwnode and instead provide
   a function which allows drivers to directly discover INTC fwnode

Changes since v1:
 - Use synthetic fwnode for INTC instead of irq_set_default_host() in PATCH2

Anup Patel (6):
  RISC-V: Clear SIP bit only when using SBI IPI operations
  irqchip/riscv-intc: Allow drivers to directly discover INTC hwnode
  RISC-V: Treat IPIs as normal Linux IRQs
  RISC-V: Allow marking IPIs as suitable for remote FENCEs
  RISC-V: Use IPIs for remote TLB flush when possible
  RISC-V: Use IPIs for remote icache flush when possible

 arch/riscv/Kconfig                |   1 +
 arch/riscv/include/asm/ipi-mux.h  |  45 ++++++
 arch/riscv/include/asm/irq.h      |   4 +
 arch/riscv/include/asm/sbi.h      |   2 +
 arch/riscv/include/asm/smp.h      |  49 +++++--
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/ipi-mux.c       | 223 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/irq.c           |  22 ++-
 arch/riscv/kernel/sbi.c           |  18 ++-
 arch/riscv/kernel/smp.c           | 164 +++++++++++-----------
 arch/riscv/kernel/smpboot.c       |   5 +-
 arch/riscv/mm/cacheflush.c        |   5 +-
 arch/riscv/mm/tlbflush.c          |  93 +++++++++++--
 drivers/clocksource/timer-clint.c |   8 +-
 drivers/irqchip/irq-riscv-intc.c  |  62 ++++-----
 16 files changed, 548 insertions(+), 157 deletions(-)
 create mode 100644 arch/riscv/include/asm/ipi-mux.h
 create mode 100644 arch/riscv/kernel/ipi-mux.c

-- 
2.25.1

