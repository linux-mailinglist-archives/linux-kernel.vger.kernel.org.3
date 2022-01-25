Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E4449AD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392084AbiAYHH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384569AbiAYHEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:04:36 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CD9C0424FF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:43:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so1154600pjj.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8bdPFvu0KYwY+deTDk1RV7vsOfEo42xcwC/j+hIQro=;
        b=kc9FKdqXuSjdbaYL7OvcZcEhkGhrE2bP6qaAjucN+PcXjc9ij2U3jpQ+BISAIkkq2Q
         PyjqHDrpfwmKoBvYHm/J6JnQKotXc7XfdsAoveyTjJKIF9D2nEJN4xMTC6XjE/PhZcS6
         e83qL0mDpTIMSm0eRXsdULP0yrFNegDbORZHmk+3igwbH4d068sJxvpiXin2zcdR2SVa
         YmA7ZLhphgVT36DnxL3h9fIyYQC5vNcYOax+v4VgA+RpRmhxWOR6igiBw6muLEgNG88b
         v1eV0mc+v02iOXGLJPc7WdJ8leLJGYSlnWbY2QiAaK/W9nO/KNyo5SRMmkZ+Le0RnfbM
         VBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8bdPFvu0KYwY+deTDk1RV7vsOfEo42xcwC/j+hIQro=;
        b=1BUDpN5qsftMDAecsonyYharwpdqoPJYqUUs+fUxjh9vVMiqSyqM3qfbUjqGRnzUCa
         aJdzd7plllSJ4SOnwjqvpDyl1y6umUAilXWoB3cf3UaD2F+2TJX9jdBSo0k2p2hJmZMk
         gnofmwW+tvOdEm6du3KZ6t9GJYThf4EIvKy7EHstP4bX5zvNxc34/qDuBPNvPaLfts6a
         mZMd9ksLSL2sphFT5Qgw/UTNtX1RQYxeOgmwcnDM4ViDbx3bg9WY8Fs9rWLtOW3SJrJw
         R3Y1q/RONVk1HjJuuQo5bvd2s1W/rMK9LvpcWxcovIDSh6gK7rxpZhghG8y9s5fuU+NM
         sJqg==
X-Gm-Message-State: AOAM532dyTgJat+ZJyyM7HjLl2l+9PIFLkRQWA97KbkVpcbF235kOJBq
        xdwTLY1Q5f7kBUxvjol3Y4tJyg==
X-Google-Smtp-Source: ABdhPJzBpyC2qWDsq6GkdaiLHkBIUGrCHoN9Dn3I4c5Jei0Kdyvy3O0ztqpSVka+1k1kZg1p4wiRrw==
X-Received: by 2002:a17:90b:240a:: with SMTP id nr10mr1863085pjb.110.1643089430401;
        Mon, 24 Jan 2022 21:43:50 -0800 (PST)
Received: from localhost.localdomain ([122.179.14.218])
        by smtp.gmail.com with ESMTPSA id c6sm19524508pfl.200.2022.01.24.21.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 21:43:49 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/6] RISC-V IPI Improvements
Date:   Tue, 25 Jan 2022 11:12:11 +0530
Message-Id: <20220125054217.383482-1-apatel@ventanamicro.com>
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

These patches can also be found in riscv_ipi_imp_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (6):
  RISC-V: Clear SIP bit only when using SBI IPI operations
  irqchip/riscv-intc: Set intc domain as the default host
  RISC-V: Treat IPIs as normal Linux IRQs
  RISC-V: Allow marking IPIs as suitable for remote FENCEs
  RISC-V: Use IPIs for remote TLB flush when possible
  RISC-V: Use IPIs for remote icache flush when possible

 arch/riscv/Kconfig                |   1 +
 arch/riscv/include/asm/ipi-mux.h  |  45 +++++++
 arch/riscv/include/asm/sbi.h      |   2 +
 arch/riscv/include/asm/smp.h      |  49 +++++--
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/ipi-mux.c       | 217 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/irq.c           |   3 +-
 arch/riscv/kernel/sbi.c           |  18 ++-
 arch/riscv/kernel/smp.c           | 164 +++++++++++-----------
 arch/riscv/kernel/smpboot.c       |   5 +-
 arch/riscv/mm/cacheflush.c        |   5 +-
 arch/riscv/mm/tlbflush.c          |  93 ++++++++++---
 drivers/clocksource/timer-clint.c |   8 +-
 drivers/clocksource/timer-riscv.c |  17 +--
 drivers/irqchip/irq-riscv-intc.c  |  62 ++++-----
 16 files changed, 521 insertions(+), 172 deletions(-)
 create mode 100644 arch/riscv/include/asm/ipi-mux.h
 create mode 100644 arch/riscv/kernel/ipi-mux.c

-- 
2.25.1

