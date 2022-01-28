Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DAC49F2FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbiA1FZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiA1FZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:25:45 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAC9C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:25:45 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id e28so5142876pfj.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DUZSzAcBhhZobyRqFeEeGc1759qGpQJqQcRHPtjlbUQ=;
        b=TEF4bPPwMHipCR6h448CMERqnyvi/R7CVUVo5I/BGCZC6VmMF1O1OVn0AzQrJunM5F
         pvT8wXP3kw91xkxEvvjkgNF88OTWWptcIwbkLV0sMyhRJcJkSlbgLeA8MqF75pZDssrG
         E2YrUZf4Vsovudo+OfLuj2FYq72lWEVnxDtTU+HsbodjxLJmO4CuQLNEadbhDTNH4D1B
         Zkw7Zu51/0k+OQVj9jDxtcDJrxS4mknTzssjtUAWER5ROv3PkYz96pkAgcYpntX53QP5
         X23kPt64tl6woC8cCvq6BBnJT4jbr2gMCnJZRT1o5riDDFA4Wajg7sZsmiXSfXYVroza
         viog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DUZSzAcBhhZobyRqFeEeGc1759qGpQJqQcRHPtjlbUQ=;
        b=6auVUG13jtyytYv+KLAXDPTTfha1ClYOwf/Y7uXUlPGjnTcLVlwkX9LFFXYTiNQvkj
         StkjgvfxtHJyWbWrLanLzJRfKYN/I0u6nNiXswgncGYhs4ejRJtueEWTv7+kIHMG2U5w
         Ax/2brRsUOjHz3egiEmWomg+frJenkk7wuLVArzgv5+DtEtnEFBTye+ldy4dNRlVb12M
         Eux/AiMswd26+eWTW5pB6fuHCc0JvixS9WSre5nCHcvwsfpSCBwHa3KD0ohKxoOMcpSD
         W1gMmNKP8UXFdeBmyZeyezkkXa/BSXANEG5P29lwxpmG+6azFXkQIbGKX6elnc8z6Lqq
         U7bA==
X-Gm-Message-State: AOAM532VkkR1+NSKBOKmjfnXdXG4cBjbmKla0VIk6lg1A+KMoAFaS1NL
        lJpM4xyTuCOzex4M3dLsP++nJA==
X-Google-Smtp-Source: ABdhPJwGmC85dSyvoA9FlcpwnwdXnTb6JDpj7JG673O2Cyimnrc2fRGqbcNyrCwVYDsKEKcCA2K32A==
X-Received: by 2002:a62:e317:: with SMTP id g23mr6320329pfh.49.1643347544629;
        Thu, 27 Jan 2022 21:25:44 -0800 (PST)
Received: from localhost.localdomain ([122.171.184.231])
        by smtp.gmail.com with ESMTPSA id b20sm7731744pfv.134.2022.01.27.21.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 21:25:44 -0800 (PST)
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
Subject: [PATCH v2 0/6] RISC-V IPI Improvements
Date:   Fri, 28 Jan 2022 10:54:59 +0530
Message-Id: <20220128052505.859518-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

These patches were already part of the "Linux RISC-V ACLINT Support" series
but this now a separate series so that it can be merged independently of
the "Linux RISC-V ACLINT Support" series.
(Refer, https://lore.kernel.org/lkml/20211007123632.697666-1-anup.patel@wdc.com/)

These patches are also a preparatory patches for the up-coming:
 1) Linux RISC-V ACLINT support
 2) Linux RISC-V AIA support
 3) KVM RISC-V TLB flush improvements

These patches can also be found in riscv_ipi_imp_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v1:
 - Use synthetic fwnode for INTC instead of irq_set_default_host() in PATCH2

Anup Patel (6):
  RISC-V: Clear SIP bit only when using SBI IPI operations
  irqchip/riscv-intc: Create domain using named fwnode
  RISC-V: Treat IPIs as normal Linux IRQs
  RISC-V: Allow marking IPIs as suitable for remote FENCEs
  RISC-V: Use IPIs for remote TLB flush when possible
  RISC-V: Use IPIs for remote icache flush when possible

 arch/riscv/Kconfig                |   1 +
 arch/riscv/include/asm/ipi-mux.h  |  45 ++++++
 arch/riscv/include/asm/irq.h      |   2 +
 arch/riscv/include/asm/sbi.h      |   2 +
 arch/riscv/include/asm/smp.h      |  49 +++++--
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/ipi-mux.c       | 223 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/irq.c           |  16 ++-
 arch/riscv/kernel/sbi.c           |  18 ++-
 arch/riscv/kernel/smp.c           | 164 +++++++++++-----------
 arch/riscv/kernel/smpboot.c       |   5 +-
 arch/riscv/mm/cacheflush.c        |   5 +-
 arch/riscv/mm/tlbflush.c          |  93 +++++++++++--
 drivers/clocksource/timer-clint.c |  21 ++-
 drivers/clocksource/timer-riscv.c |  11 +-
 drivers/irqchip/irq-riscv-intc.c  |  67 ++++-----
 drivers/irqchip/irq-sifive-plic.c |  19 +--
 18 files changed, 563 insertions(+), 182 deletions(-)
 create mode 100644 arch/riscv/include/asm/ipi-mux.h
 create mode 100644 arch/riscv/kernel/ipi-mux.c

-- 
2.25.1

