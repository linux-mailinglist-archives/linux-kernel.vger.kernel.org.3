Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6DD4C8245
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiCAE2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiCAE2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:28:52 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F12149F1D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:28:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso633645wmr.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6K5ttyZHPJI6iQNDkukm5vwi+JLZaFuZquArtV81RWU=;
        b=UnkPtbKLMI6f2js1SIY0+ma/cDIrkrxu91dMh1pGTF8tMKWD0I9RZTDJMyNX0K9hFi
         HP/ONkBfixicmphAJ68CxBRNiuaN5Gv1BMYIuX8AJ/waJw2QJQ7tayDYqFRKd7J2ugBW
         q1shMzvG1PQAPN4JCGpOwq0vmFF9u7EX2DJJKPnejs4RlJD156ZYnDcaSiRF7rAbzrLf
         zxRoeXbS1vurFNNMrzHVJk8HhguuqjCEbPARr4rW0ac1F+hTTbYzHvGXncibOTKw5XwQ
         DuAtAzbOKJgsQhLgz00NRoo3TRlycVLlpsOKfmyi8L7JVHWjevFFZppsIQMK4bVDbSmP
         OUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6K5ttyZHPJI6iQNDkukm5vwi+JLZaFuZquArtV81RWU=;
        b=7tdzOAJ9frywJum5WQJBfeZanVdvbq8J4bZL9PEgy+Mq5Rbbd1ZYpQ/DDwId2NNjNS
         P9fvDh9As/I0pUm1NvEin1KdevF36tZmXnUkBZ1kjsXrz74AXT7kQqbMGZ4dFAb+kNwC
         WcqWxnWSzBP48QuINn23gjiJs15gWnNVZGriHp1NKJLb4UxlQx8k4Gchl4CkrCOq9L9B
         gs2XepaAyDRVbwOksUzCuAzx/vRMWx8x7HUOs8KAgKmnQKbEfJlSO+Uu5pMwmzb3+ZBd
         A09M516V/oc+Ro/8VohlYPs/1ErcAqfgsaxe3XaYWk1RLyBJKKkMUhqN8gkU6SHbErxC
         12uQ==
X-Gm-Message-State: AOAM530oZFgQjAVS1m/hjsY1B8UuyuzkOPZeNc+E6R20JdX8E6jJPxJJ
        e6L7rPYfBtrTet5Q/BInMShhfA==
X-Google-Smtp-Source: ABdhPJyPiJ3pxuvdcHAjFRo93GYUTwZy1y0m1tLQYtRkHQNA0exa4gYQI/SGRx/cKfR8bpN2nRdBAQ==
X-Received: by 2002:a05:600c:14c2:b0:381:80db:c3b2 with SMTP id i2-20020a05600c14c200b0038180dbc3b2mr3281139wmh.56.1646108890552;
        Mon, 28 Feb 2022 20:28:10 -0800 (PST)
Received: from localhost.localdomain ([122.179.35.69])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm1209107wmz.43.2022.02.28.20.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 20:28:10 -0800 (PST)
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
Subject: [PATCH v4 0/6] RISC-V IPI Improvements
Date:   Tue,  1 Mar 2022 09:57:16 +0530
Message-Id: <20220301042722.401113-1-apatel@ventanamicro.com>
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

These patches can also be found in riscv_ipi_imp_v4 branch at:
https://github.com/avpatel/linux.git

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
 arch/riscv/kernel/irq.c           |  21 ++-
 arch/riscv/kernel/sbi.c           |  18 ++-
 arch/riscv/kernel/smp.c           | 164 +++++++++++-----------
 arch/riscv/kernel/smpboot.c       |   5 +-
 arch/riscv/mm/cacheflush.c        |   5 +-
 arch/riscv/mm/tlbflush.c          |  93 +++++++++++--
 drivers/clocksource/timer-clint.c |   8 +-
 drivers/irqchip/irq-riscv-intc.c  |  60 ++++----
 16 files changed, 546 insertions(+), 156 deletions(-)
 create mode 100644 arch/riscv/include/asm/ipi-mux.h
 create mode 100644 arch/riscv/kernel/ipi-mux.c

-- 
2.25.1

