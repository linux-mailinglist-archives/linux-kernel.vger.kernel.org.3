Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E159ABDA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244618AbiHTG4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244366AbiHTGz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:55:56 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED2C04E7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:55:55 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v125so7017561oie.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7gL51KGK8h2gYdKsAsi/esrqwK4Ga0hyaEGMAaUXEgw=;
        b=Sw04uJ3vbDVepAg/gWVJcWOV7MbzEmF8dKmsd/rb6F8inqTs1ofPx1MK09cu3sGCTc
         0VvQSYC0ZBw+zM+SXSv1L1UObgmZzvYVFbPwoMaYQ42uWio23+ffNmsmi+dimTW8E6u5
         8O4T4xGCd206w7/uqNwH9F5bwTQY2wNgBLDZZd9u9xxYKp7pElOD0PXM7AiAvTkAQccV
         HsMXix2vDP8/m0hM8ddQW0m0vEPms6xLU6j7mPJ0UsUkauth3dyKJ/fDctjj3G+QGcYv
         lgVblX5ZvzjUpFnGtjWBem/SXRb3s3wrn6p45TOr5X2AUVAdCLOYvqPSYxkWvbZjdx7f
         b5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7gL51KGK8h2gYdKsAsi/esrqwK4Ga0hyaEGMAaUXEgw=;
        b=RkxoBQ1cyKhIe0QwpDDDX1H4/uonRvjBv1A2TmVbVBhaZBAEt/L1Xeew41ajoq1I4Q
         WPLWECzmBAUHUc5zRa3h3P46jRTVZMAIrYq6zoqk5+CanY363YtNCTrmqyHPpPbMYxrC
         WQEAgcloLklCrDtF2Wl/ACqsmwg1KZQmUjWCau2FQg+nFRmsjGKzA1/EdwNyf6+g23Qx
         IU/zkDZUmb8KXl+DxlBb1v5439JEKTy51y09QK49i7+INCjVViwPZg593Qgc1CaheWVF
         wbVDC6n4OEtTlgoonI3FglKlCL+d4dARKCaLUH39qQFew0C0QkjAgJBZ6/Yprmf9GflD
         bazw==
X-Gm-Message-State: ACgBeo2k6pEaQzHQgrYW1tbFydk+N3RqqISLF3sAscYc4rb93fU5Gv3b
        K/uEnm0U4JFv6XRqAPmHE4geOA==
X-Google-Smtp-Source: AA6agR5utbHM4pipxClH5gyEYq4cq0Nm0cG2E0loDJemIx24wNgpN5lXHXqEGa8/FgPkVBgRhwGxRA==
X-Received: by 2002:aca:5e8b:0:b0:344:d1ef:2293 with SMTP id s133-20020aca5e8b000000b00344d1ef2293mr7608063oib.158.1660978554932;
        Fri, 19 Aug 2022 23:55:54 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.82.68])
        by smtp.gmail.com with ESMTPSA id h26-20020a9d641a000000b00636faf5e2d9sm1661098otl.39.2022.08.19.23.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 23:55:54 -0700 (PDT)
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
Subject: [PATCH v8 2/7] irqchip/riscv-intc: Allow drivers to directly discover INTC hwnode
Date:   Sat, 20 Aug 2022 12:24:41 +0530
Message-Id: <20220820065446.389788-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220820065446.389788-1-apatel@ventanamicro.com>
References: <20220820065446.389788-1-apatel@ventanamicro.com>
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
index 499e5f81b3fe..9066467e99e4 100644
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
@@ -126,6 +131,8 @@ static int __init riscv_intc_init(struct device_node *node,
 		return rc;
 	}
 
+	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
+
 	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
 			  "irqchip/riscv/intc:starting",
 			  riscv_intc_cpu_starting,
-- 
2.34.1

