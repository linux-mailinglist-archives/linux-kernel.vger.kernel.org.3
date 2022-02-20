Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222124BCC39
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 06:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiBTFK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 00:10:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiBTFKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 00:10:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E8B517FA
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:10:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so418648pjw.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWgup5+s0NpBdPrI8o/lvYeDK7LCK1AyJL6/Cnvbp+I=;
        b=l1nnOk+uSVryT9WPWfV5mA4fmGwv/bvudzwwVf6f/zyOIwxGrONbb7hJ+jT+dGSKS8
         wn2ir1HXwyKaD+iGQCJ3d5a0BovwIWOk+rkG5MZZ+dO+bHE7Anh9fyXWPMI1OsJHOpxW
         jEiZaFm/8xiLQFaguByff7tgndBncn5I/otEb948t/rlQdDBjXj+swBdQqWvKzxIU19w
         rvG6RLnFYKTdnOSxcJ3eST/31JEuvZXebQVd+CebqMBd4HfO1jHjAzLCT3lzrw4eWiSQ
         V+H+R9sJwkttDISJ7FQ3oSx46TTGhawhDjduixox5cuasNlq2m1eD/S7kmeh6BUs08Za
         4JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWgup5+s0NpBdPrI8o/lvYeDK7LCK1AyJL6/Cnvbp+I=;
        b=MDKZaANDpM+MPBoWYVQjcVqJoPK69emeE1k0HnsbJTbmXubOrGDybYYKT2bEowOiCa
         hQdZQnpST5o0V0JVp5X+6HG3oqBj+C+mpn+gvqPhjgfWQi+Bgec6iakTWmspJryToSeA
         4Y6dmTwXKAY4mW9l08jQKsmd+DzEVodxfftlibf5to+cI6+UHMPQTH8fLttNqmrpHRTX
         ZmsHlsUnFOEsg9t/LLCW4Oio4QRINxBKGPrxDFMVk/+RdGIDVgyHqpjAhVIRuvOxDGHF
         H7tHkg5T2RCfAAPIETGnCQrSEcB61d/hggGHW/UAD6nGk7bZzyQLc+Ei6LLf+gnlwUcX
         HYzw==
X-Gm-Message-State: AOAM5311PFcjOogZtlKjb2Mk5j8sLCZv7rrkk+QlHNAZSoMznyQ55An3
        +JjUx00zLTWvm/CbMvEWKvItBw==
X-Google-Smtp-Source: ABdhPJwz3KXYF+aZ05CTM/caMxMstp5Q8pihJPiS1ThnZ4dObwL/F15gnHlX/qVX8xpg/RIpeC2qHQ==
X-Received: by 2002:a17:90a:5302:b0:1b9:ba0a:27e5 with SMTP id x2-20020a17090a530200b001b9ba0a27e5mr19589604pjh.91.1645333803853;
        Sat, 19 Feb 2022 21:10:03 -0800 (PST)
Received: from localhost.localdomain ([122.162.118.38])
        by smtp.gmail.com with ESMTPSA id 84sm7602730pfx.181.2022.02.19.21.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 21:10:03 -0800 (PST)
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
Subject: [PATCH v3 2/6] irqchip/riscv-intc: Allow drivers to directly discover INTC hwnode
Date:   Sun, 20 Feb 2022 10:38:50 +0530
Message-Id: <20220220050854.743420-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220220050854.743420-1-apatel@ventanamicro.com>
References: <20220220050854.743420-1-apatel@ventanamicro.com>
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
 arch/riscv/kernel/irq.c          | 19 +++++++++++++++++++
 drivers/irqchip/irq-riscv-intc.c |  7 +++++++
 3 files changed, 30 insertions(+)

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
index 7207fa08d78f..ead92432df8c 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -7,9 +7,28 @@
 
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
+EXPORT_SYMBOL_GPL(riscv_set_intc_hwnode_fn);
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
index b65bd8878d4f..fa24ecd01d39 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -92,6 +92,11 @@ static const struct irq_domain_ops riscv_intc_domain_ops = {
 	.xlate	= irq_domain_xlate_onecell,
 };
 
+static struct fwnode_handle *riscv_intc_hwnode(void)
+{
+	return (intc_domain) ? intc_domain->fwnode : NULL;
+}
+
 static int __init riscv_intc_init(struct device_node *node,
 				  struct device_node *parent)
 {
@@ -119,6 +124,8 @@ static int __init riscv_intc_init(struct device_node *node,
 		return -ENXIO;
 	}
 
+	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
+
 	rc = set_handle_irq(&riscv_intc_irq);
 	if (rc) {
 		pr_err("failed to set irq handler\n");
-- 
2.25.1

