Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D339349AD33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442679AbiAYHKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378094AbiAYHEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:04:36 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A25C041883
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:44:01 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 128so18484462pfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQS+XB01rQTghLAjvmUkl8tFaMQ6CMQ1+K0sDDXtaTI=;
        b=Ky+UZvUt3KlfSaUIzSkiXKL3tJePDBQAjdWQLddrc4hgN63O6uogDkolOLjlF53Bn9
         VPvfMSi8100wkYCP4WISvBQWXzxIbuWfrf3xkQJKAhv61BAtY3LWN/vf0IVXJ+jWw7Dj
         9+zkGdkWRVcNGi0rpqI1bCaF/pgO4jgj6ra97b5428qJbBbGqQ2DDXxYOO5/BLmkvT/9
         sf/CbFSOr8QDetg0xTCqFexST5SlPPuoYNXzDNyQKvhmL69uxuV421bz1yaA80lFUJ/W
         zHaq1YQ9ZeFle2HzKjPS0p25cZlX3DbZ3K9E6gVC8zVIJJDm2ffuf5CXF3U7wIxB6fb0
         M6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQS+XB01rQTghLAjvmUkl8tFaMQ6CMQ1+K0sDDXtaTI=;
        b=CGb+isdj3lQiAvR5yv6gmbo+ZfSHp1J5BcnEPvgQukNTqCJegdM6bEravPIdj5KKY7
         S75I734a/kzRpOniuDVM/K8Y5FGwEPNHpze1vOMM/vQqQl/GF29vjYrgo9kw/POOHyWU
         iX3oxPgN88dgg5oEn9ew6mwXSwoE7rSo91qiRz6nmEWU9jGOJnnmXZlYP4DQ6pKX1DXf
         y0kdxA5nhJDsBwtdx8dog3UZMSuMUke4KlVU3jkSYv6VCvpi4lLl0iUa/8kfV0ykn7Bm
         vfvuNzHggSgLfCZSaACsqwm4NQGMcnCRCbRSCGKaDQUjg4Gxe+yfr3FGwSdYqGTvsLjw
         9TWw==
X-Gm-Message-State: AOAM532H4HptUd3c+Fy1FB7XWMBI1KruzXttCP/UAnf0wEYEHfxKRBMQ
        whNco57D31rGSMUwKDQqSpQWyw==
X-Google-Smtp-Source: ABdhPJzMWcWR6nzR3mwo77XGWNf8PMri0gVk1yT1811+iC80BfVQO9Nmz+o+PxMVKmPrJqIXqV43JQ==
X-Received: by 2002:a05:6a00:179c:b0:4c9:ef72:87eb with SMTP id s28-20020a056a00179c00b004c9ef7287ebmr5121764pfg.47.1643089440765;
        Mon, 24 Jan 2022 21:44:00 -0800 (PST)
Received: from localhost.localdomain ([122.179.14.218])
        by smtp.gmail.com with ESMTPSA id c6sm19524508pfl.200.2022.01.24.21.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 21:44:00 -0800 (PST)
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
Subject: [PATCH 2/6] irqchip/riscv-intc: Set intc domain as the default host
Date:   Tue, 25 Jan 2022 11:12:13 +0530
Message-Id: <20220125054217.383482-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220125054217.383482-1-apatel@ventanamicro.com>
References: <20220125054217.383482-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have quite a few RISC-V drivers (such as RISC-V SBI IPI driver,
RISC-V timer driver, RISC-V PMU driver, etc) which do not have a
dedicated DT/ACPI fwnode. This patch makes intc domain as the default
host so that these drivers can directly create local interrupt mapping
using standardized local interrupt numbers

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/clocksource/timer-riscv.c | 17 +----------------
 drivers/irqchip/irq-riscv-intc.c  |  9 +++++++++
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 1767f8bf2013..dd6916ae6365 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -102,8 +102,6 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
 	int cpuid, hartid, error;
-	struct device_node *child;
-	struct irq_domain *domain;
 
 	hartid = riscv_of_processor_hartid(n);
 	if (hartid < 0) {
@@ -121,20 +119,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	if (cpuid != smp_processor_id())
 		return 0;
 
-	domain = NULL;
-	child = of_get_compatible_child(n, "riscv,cpu-intc");
-	if (!child) {
-		pr_err("Failed to find INTC node [%pOF]\n", n);
-		return -ENODEV;
-	}
-	domain = irq_find_host(child);
-	of_node_put(child);
-	if (!domain) {
-		pr_err("Failed to find IRQ domain for node [%pOF]\n", n);
-		return -ENODEV;
-	}
-
-	riscv_clock_event_irq = irq_create_mapping(domain, RV_IRQ_TIMER);
+	riscv_clock_event_irq = irq_create_mapping(NULL, RV_IRQ_TIMER);
 	if (!riscv_clock_event_irq) {
 		pr_err("Failed to map timer interrupt for node [%pOF]\n", n);
 		return -ENODEV;
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index b65bd8878d4f..9f0a7a8a5c4d 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -125,6 +125,15 @@ static int __init riscv_intc_init(struct device_node *node,
 		return rc;
 	}
 
+	/*
+	 * Make INTC as the default domain which will allow drivers
+	 * not having dedicated DT/ACPI fwnode (such as RISC-V SBI IPI
+	 * driver, RISC-V timer driver, RISC-V PMU driver, etc) can
+	 * directly create local interrupt mapping using standardized
+	 * local interrupt numbers.
+	 */
+	irq_set_default_host(intc_domain);
+
 	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
 			  "irqchip/riscv/intc:starting",
 			  riscv_intc_cpu_starting,
-- 
2.25.1

