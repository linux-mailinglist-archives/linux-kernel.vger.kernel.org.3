Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE34C8247
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiCAE3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiCAE3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:29:04 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66664D603
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:28:23 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r10so18492770wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPOgTx9pa9Jl4kAK/bdibs/Vyw7ywaqt4uScFzAp1mk=;
        b=gICFhfXwhzyyNd8ShrN+bR6Dsqj0G3mNRAF7sZYOqYvRpt1pKzUu2i3kkHbs8EpcOi
         302J3CGLqIXfo7y6Y0X3w3TDZo3G47e3xUwdCJ4Uwt7rRpvF0Lbv3xgaBnXQ4W052WYr
         8RmP6cqbsgFKqr4uex3kaWuS8vR2aIqIvRdwviUu5OvbI8opqcdmxciqmdPZZY35vj3M
         9oqB927UAnmrmmNk96cvwrV0UXS9aBFOMU5Ksx8Ah1QkbzxIkAxbST7HfdwFvYJkTDDq
         KBg2TLDvzAy+mJ7covd9cwKzIFBu6LISZtDrRqWHrfMs1R+IRcwdvWa/TW2xu1ZVccwY
         T9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPOgTx9pa9Jl4kAK/bdibs/Vyw7ywaqt4uScFzAp1mk=;
        b=kIZgUvPpP4VCyTOeAMBLhLoD04a8N9RcyEu/45dcz/IEHtI8xFinBQ5wVsgOR1uDjM
         JqJKJtltJw6ni2OB8RUwa1SuWDFkr0jnE6soaKl2YGn50b4GDDneKpdrqt0aRnsSaZPB
         TQ8/cA1WdyV/pXmzwRGJbmtmCwgk6LnxcyL1F5W6EjQty/xvPioLuCbEMHZjYRuN0PPR
         CsuHP/ue7JmyoFnZLQT8F+KWzoljGQ104hO2YRjshdkgf9N8oJETMS6BrHIwSo9RG7nB
         3KtIRj0PwZJz2UFbPraSrkHP5xoUI4PKgAjsQgIl9yKJxeAsyrp/9ir9SZgWXM9k6Qnf
         syVQ==
X-Gm-Message-State: AOAM530wJ3sBbXYdG7tUMGC47Hkv+DoDeYHrPEP6vMHYzbuZ/Zy5R7Ad
        NhTv6GbrUNelDDE3p9scPhLPDg==
X-Google-Smtp-Source: ABdhPJwikeYsvr36/wo02SUnizlvf5YsP2mjv2VqHzKmNLWhmjMbi7FTYI122m8IP+Ghb1FvKXyNPw==
X-Received: by 2002:a05:6000:1cb:b0:1ed:c295:3e3b with SMTP id t11-20020a05600001cb00b001edc2953e3bmr18605303wrx.111.1646108901887;
        Mon, 28 Feb 2022 20:28:21 -0800 (PST)
Received: from localhost.localdomain ([122.179.35.69])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm1209107wmz.43.2022.02.28.20.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 20:28:21 -0800 (PST)
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
Subject: [PATCH v4 2/6] irqchip/riscv-intc: Allow drivers to directly discover INTC hwnode
Date:   Tue,  1 Mar 2022 09:57:18 +0530
Message-Id: <20220301042722.401113-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301042722.401113-1-apatel@ventanamicro.com>
References: <20220301042722.401113-1-apatel@ventanamicro.com>
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

Various RISC-V drivers (such as SBI IPI, SBI Timer, SBI PMU, and
KVM RISC-V) don't have associated DT node but these drivers need
standard per-CPU (local) interrupts defined by the RISC-V privileged
specification.

We add riscv_get_intc_hwnode() in arch/riscv which allows RISC-V
drivers not having DT node to discover INTC hwnode which in-turn
helps these drivers to map per-CPU (local) interrupts provided
by the INTC driver.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h     |  4 ++++
 arch/riscv/kernel/irq.c          | 18 ++++++++++++++++++
 drivers/irqchip/irq-riscv-intc.c |  7 +++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index e4c435509983..43b9ebfbd943 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -12,6 +12,10 @@
 
 #include <asm-generic/irq.h>
 
+void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
+
+struct fwnode_handle *riscv_get_intc_hwnode(void);
+
 extern void __init init_IRQ(void);
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 7207fa08d78f..96d3171f0ca1 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -7,9 +7,27 @@
 
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
 #include <linux/seq_file.h>
 #include <asm/smp.h>
 
+static struct fwnode_handle *(*__get_intc_node)(void);
+
+void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void))
+{
+	__get_intc_node = fn;
+}
+
+struct fwnode_handle *riscv_get_intc_hwnode(void)
+{
+	if (__get_intc_node)
+		return __get_intc_node();
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(riscv_get_intc_hwnode);
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	show_ipi_stats(p, prec);
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index b65bd8878d4f..084793a57af8 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -92,6 +92,11 @@ static const struct irq_domain_ops riscv_intc_domain_ops = {
 	.xlate	= irq_domain_xlate_onecell,
 };
 
+static struct fwnode_handle *riscv_intc_hwnode(void)
+{
+	return intc_domain->fwnode;
+}
+
 static int __init riscv_intc_init(struct device_node *node,
 				  struct device_node *parent)
 {
@@ -125,6 +130,8 @@ static int __init riscv_intc_init(struct device_node *node,
 		return rc;
 	}
 
+	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
+
 	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
 			  "irqchip/riscv/intc:starting",
 			  riscv_intc_cpu_starting,
-- 
2.25.1

