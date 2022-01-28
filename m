Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F6749F2FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346105AbiA1FZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242293AbiA1FZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:25:55 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A142C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:25:55 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id r59so5470700pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6Dhv5CqQOYQndQIhDjH4EYISmVCA9GVd9cSSXcZ/p4=;
        b=GaXc22d/Oeuw/Z0L7w4JWWMIkz1bLJPPEfpeg6Gv42VmaRtNwHriEPd8k353vLwaM5
         /b3sM7LdNeYkP7s1RGP+dZJ0s06OwUnAhb9X2ckTffHlVyL1ovu97uvbHZLjCYY/k2yB
         mimEKZwdRi7ScdWTGQf8zD4VLVnwIJn9HOlsMgr2+2CQ2wOs1/nT7a57f2n8W64pLsH6
         V4duYC6ZqwlaEgiKNCSHgxnUgMCwh4jV8vBEhLkn6cCooycRyqhjQ7oWgoZY1+IA5M3H
         b8b2A4Edt584wG2igCvwKDEPlyq9AJFnqZwz1PiwV5I7eXSFZa6CbJLmSSMNWOBESVPY
         mZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6Dhv5CqQOYQndQIhDjH4EYISmVCA9GVd9cSSXcZ/p4=;
        b=Quv8Bzbl6FzpWOhCs4oXFoodRiV2gGfY7lgYfsKuQd4aPMksypWARDMmjf/lPi9l1X
         CzpKA2OG8tPk7Y4enlC9wxRw+h68ZIag9pWvIMp3jsZo6ae9swNZPb3HHKyQfcriqGJk
         IGL27SCpo6RS3HWy9Vi9rZcvr1logae2L/pTUfvMKwA4yQSDPWB0P4oH3YNlF3Ti/HS0
         49Sseov1qUvkRYYgg1Tso8DWpB0hlOa748BtyMPPrxSQbObM9yY5JuipkFlaOdZYwPYF
         QBa+XDZfoKIIc0USC+jn2ulepoQ1QhFgvzQ7RT7DnvDcmtpTU9A1743XskbtEO7YzTIr
         G1Xg==
X-Gm-Message-State: AOAM531Fctf0309lytlJW9UAV4mE6FXvfLgMNhvnzrEqBKCfmece5E00
        eRSd6d+sQGmPUG6UUiZcPg0YNg==
X-Google-Smtp-Source: ABdhPJz2/UsyxAXmlYhVZjgHVyydrJYSa6gO05OevE7Cy5PSp7fuRDkxOdQScASf9qei8T7dD657+Q==
X-Received: by 2002:a17:90a:39c6:: with SMTP id k6mr17979017pjf.194.1643347555092;
        Thu, 27 Jan 2022 21:25:55 -0800 (PST)
Received: from localhost.localdomain ([122.171.184.231])
        by smtp.gmail.com with ESMTPSA id b20sm7731744pfv.134.2022.01.27.21.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 21:25:54 -0800 (PST)
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
Subject: [PATCH v2 2/6] irqchip/riscv-intc: Create domain using named fwnode
Date:   Fri, 28 Jan 2022 10:55:01 +0530
Message-Id: <20220128052505.859518-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128052505.859518-1-apatel@ventanamicro.com>
References: <20220128052505.859518-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should create INTC domain using a synthetic fwnode which will allow
drivers (such as RISC-V SBI IPI driver, RISC-V timer driver, RISC-V
PMU driver, etc) not having dedicated DT/ACPI node to directly create
interrupt mapping for standard local interrupt numbers defined by the
RISC-V privileged specification.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h      |  2 ++
 arch/riscv/kernel/irq.c           | 13 +++++++++++++
 drivers/clocksource/timer-clint.c | 13 +++++++------
 drivers/clocksource/timer-riscv.c | 11 ++---------
 drivers/irqchip/irq-riscv-intc.c  | 12 ++++++++++--
 drivers/irqchip/irq-sifive-plic.c | 19 +++++++++++--------
 6 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index e4c435509983..f85ebaf07505 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -12,6 +12,8 @@
 
 #include <asm-generic/irq.h>
 
+extern struct fwnode_handle *riscv_intc_fwnode(void);
+
 extern void __init init_IRQ(void);
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 7207fa08d78f..f2fed78ab659 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -7,9 +7,22 @@
 
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
 #include <linux/seq_file.h>
 #include <asm/smp.h>
 
+static struct fwnode_handle *intc_fwnode;
+
+struct fwnode_handle *riscv_intc_fwnode(void)
+{
+	if (!intc_fwnode)
+		intc_fwnode = irq_domain_alloc_named_fwnode("RISCV-INTC");
+
+	return intc_fwnode;
+}
+EXPORT_SYMBOL_GPL(riscv_intc_fwnode);
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	show_ipi_stats(p, prec);
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 6cfe2ab73eb0..6e5624989525 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -149,6 +149,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
 	int rc;
 	u32 i, nr_irqs;
 	void __iomem *base;
+	struct irq_domain *domain;
 	struct of_phandle_args oirq;
 
 	/*
@@ -169,14 +170,14 @@ static int __init clint_timer_init_dt(struct device_node *np)
 			       np, i, oirq.args[0]);
 			return -ENODEV;
 		}
-
-		/* Find parent irq domain and map timer irq */
-		if (!clint_timer_irq &&
-		    oirq.args[0] == RV_IRQ_TIMER &&
-		    irq_find_host(oirq.np))
-			clint_timer_irq = irq_of_parse_and_map(np, i);
 	}
 
+	/* Find parent irq domain and map timer irq */
+	domain = irq_find_matching_fwnode(riscv_intc_fwnode(),
+					  DOMAIN_BUS_ANY);
+	if (!clint_timer_irq && domain)
+		clint_timer_irq = irq_create_mapping(domain, RV_IRQ_TIMER);
+
 	/* If CLINT timer irq not found then fail */
 	if (!clint_timer_irq) {
 		pr_err("%pOFP: timer irq not found\n", np);
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 1767f8bf2013..a98f5d18bab9 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -102,7 +102,6 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
 	int cpuid, hartid, error;
-	struct device_node *child;
 	struct irq_domain *domain;
 
 	hartid = riscv_of_processor_hartid(n);
@@ -121,14 +120,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
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
+	domain = irq_find_matching_fwnode(riscv_intc_fwnode(),
+					  DOMAIN_BUS_ANY);
 	if (!domain) {
 		pr_err("Failed to find IRQ domain for node [%pOF]\n", n);
 		return -ENODEV;
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index b65bd8878d4f..26ed62c11768 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -112,8 +112,16 @@ static int __init riscv_intc_init(struct device_node *node,
 	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
 		return 0;
 
-	intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
-					    &riscv_intc_domain_ops, NULL);
+	/*
+	 * Create INTC domain using a synthetic fwnode which will allow
+	 * drivers (such as RISC-V SBI IPI driver, RISC-V timer driver,
+	 * RISC-V PMU driver, etc) not having dedicated DT/ACPI node to
+	 * directly create interrupt mapping for standard local interrupt
+	 * numbers defined by the RISC-V privileged specification.
+	 */
+	intc_domain = irq_domain_create_linear(riscv_intc_fwnode(),
+					       BITS_PER_LONG,
+					       &riscv_intc_domain_ops, NULL);
 	if (!intc_domain) {
 		pr_err("unable to add IRQ domain\n");
 		return -ENXIO;
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 259065d271ef..2c43ab77c014 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -284,6 +284,7 @@ static int __init plic_init(struct device_node *node,
 	u32 nr_irqs;
 	struct plic_priv *priv;
 	struct plic_handler *handler;
+	struct irq_domain *domain;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -339,14 +340,6 @@ static int __init plic_init(struct device_node *node,
 			continue;
 		}
 
-		/* Find parent domain and register chained handler */
-		if (!plic_parent_irq && irq_find_host(parent.np)) {
-			plic_parent_irq = irq_of_parse_and_map(node, i);
-			if (plic_parent_irq)
-				irq_set_chained_handler(plic_parent_irq,
-							plic_handle_irq);
-		}
-
 		/*
 		 * When running in M-mode we need to ignore the S-mode handler.
 		 * Here we assume it always comes later, but that might be a
@@ -373,6 +366,16 @@ static int __init plic_init(struct device_node *node,
 		nr_handlers++;
 	}
 
+	/* Find parent domain and register chained handler */
+	domain = irq_find_matching_fwnode(riscv_intc_fwnode(),
+					  DOMAIN_BUS_ANY);
+	if (!plic_parent_irq && domain) {
+		plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
+		if (plic_parent_irq)
+			irq_set_chained_handler(plic_parent_irq,
+						plic_handle_irq);
+	}
+
 	/*
 	 * We can have multiple PLIC instances so setup cpuhp state only
 	 * when context handler for current/boot CPU is present.
-- 
2.25.1

