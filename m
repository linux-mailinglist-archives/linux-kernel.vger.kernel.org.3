Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F7A4E65DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351261AbiCXPPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351242AbiCXPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:15:49 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614AC6D1AF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:14:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so5627339pjo.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WcwCMxaX9JGeZSa3WsYbeDt7zeQSVMsZQFsPlTBgjwI=;
        b=ao50hYAHeoP2jOTtUXeOZTknJ0f/Xmi+TM8O+7ruznhPlZUUNFR/nPHJyOzqTF/4bu
         hgwBKOkZHh/d4al26PR6q08WHmoxCHxcmv6CqKT4V405CIgeaGz8xKl4PnkyRmY/EB18
         35E03LRxNQ/k+FRG+jC3FI6EjgHul4IQcSksnDXgKtL2ElVRhzqALMkplvpeWqJbsxbG
         xk3Qg//fGkigrRJ0cYwRld6OOMJwhOF9V5/dqho46dMPyPHB9Kxh8ulzRXhip9vaTEy2
         dat1+1BsABy+1YJurT6rlaKhEMoF8klJ2VhY4NDxgzCLBZLNfac+jkC/ZAY9boxbbBxH
         lmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WcwCMxaX9JGeZSa3WsYbeDt7zeQSVMsZQFsPlTBgjwI=;
        b=jzyUMfMB07oLbLLHrDmpjDntABRwjnfKx9RiA+qJm9TupsbQ8q2SQvokdrhcdGZ4MR
         CTIAiZIYJtuga8KeI5grFsvwRMHWVf8VxLj8uLs4nyDCs2UDG2uoYydSw4iqiqNkWMRP
         sOi9NHpLA7z/geS6fPQrhJJfsiwPuIE9LzIydjFGMtA7aRPEV7SwD1HKyhM/dpG7DRvD
         JslBKsaWgiTruJ8O1c90KLiyyAUOCeAF8xv8XNkM0pnj/a6rW7Ol00jJoMO6Uzrdg3tC
         0UqYq6xRbR492+31S0mD8IiF01Bl5KtX7ctsA2PdilqtLCCpLk1AwpKgrbwRjp+hatt8
         iIkw==
X-Gm-Message-State: AOAM532xrXC09jXb454Ym0Pli1MlYEV9+qjz8tDoJ+mqZIscHwaM4Zsc
        9eKeDldKEhiQpoJy9DDZmibWxA==
X-Google-Smtp-Source: ABdhPJzSVlFuesIy3ozcbs1Ya9/BR2hqxQl/oz2eLEJWztKwhCuJJPBlm/wUz0WWxO8nsUrReBdutQ==
X-Received: by 2002:a17:902:8491:b0:14e:dad4:5ce5 with SMTP id c17-20020a170902849100b0014edad45ce5mr6156464plo.76.1648134856759;
        Thu, 24 Mar 2022 08:14:16 -0700 (PDT)
Received: from localhost.localdomain ([122.171.187.87])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a00239000b004fa7103e13csm4166065pfc.41.2022.03.24.08.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 08:14:16 -0700 (PDT)
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
Subject: [PATCH v5 3/7] genirq: Add mechanism to multiplex a single HW IPI
Date:   Thu, 24 Mar 2022 20:42:54 +0530
Message-Id: <20220324151258.943896-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324151258.943896-1-apatel@ventanamicro.com>
References: <20220324151258.943896-1-apatel@ventanamicro.com>
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

All RISC-V platforms have a single HW IPI provided by the INTC local
interrupt controller. The HW method to trigger INTC IPI can be through
external irqchip (e.g. RISC-V AIA), through platform specific device
(e.g. SiFive CLINT timer), or through firmware (e.g. SBI IPI call).

To support multiple IPIs on RISC-V, we need a generic mechanism to
create multiple per-CPU vIRQs using a single HW IPI hence this patch.

The generic IPI multiplex mechanism added by this patch can also be
useful to other architectures.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/irq.h  |  28 +++++++
 kernel/irq/Kconfig   |   4 +
 kernel/irq/Makefile  |   1 +
 kernel/irq/ipi-mux.c | 190 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 223 insertions(+)
 create mode 100644 kernel/irq/ipi-mux.c

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 848e1e12c5c6..cdce7eae2f37 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1248,6 +1248,34 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
 int ipi_send_single(unsigned int virq, unsigned int cpu);
 int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
 
+#define IPI_MUX_NR_IRQS		BITS_PER_LONG
+struct ipi_mux_ops {
+	void (*ipi_mux_clear)(unsigned int parent_virq);
+	void (*ipi_mux_send)(unsigned int parent_virq,
+			     const struct cpumask *mask);
+};
+
+/* Process multiplexed IPIs */
+void ipi_mux_process(void);
+
+/*
+ * Create multiple IPIs (total IPI_MUX_NR_IRQS) multiplexed on top of a
+ * single parent IPI.
+ *
+ * If the parent IPI > 0 then ipi_mux_process() will be automatically
+ * called via chained handler.
+ *
+ * If the parent IPI <= 0 then it is responsiblity of irqchip drivers
+ * to explicitly call ipi_mux_process() for processing muxed
+ * IPIs.
+ *
+ * Returns first virq of the muxed IPIs upon success or <=0 upon failure
+ */
+int ipi_mux_create(unsigned int parent_virq, const struct ipi_mux_ops *ops);
+
+/* Destroy multiplexed IPIs */
+void ipi_mux_destroy(void);
+
 #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 /*
  * Registers a generic IRQ handling function as the top-level IRQ handler in
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 10929eda9825..2388e7d40ed3 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -84,6 +84,10 @@ config GENERIC_IRQ_IPI
 	bool
 	select IRQ_DOMAIN_HIERARCHY
 
+# Generic IRQ IPI Mux support
+config GENERIC_IRQ_IPI_MUX
+	bool
+
 # Generic MSI interrupt support
 config GENERIC_MSI_IRQ
 	bool
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index b4f53717d143..f19d3080bf11 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
 obj-$(CONFIG_PM_SLEEP) += pm.o
 obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
 obj-$(CONFIG_GENERIC_IRQ_IPI) += ipi.o
+obj-$(CONFIG_GENERIC_IRQ_IPI_MUX) += ipi-mux.o
 obj-$(CONFIG_SMP) += affinity.o
 obj-$(CONFIG_GENERIC_IRQ_DEBUGFS) += debugfs.o
 obj-$(CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR) += matrix.o
diff --git a/kernel/irq/ipi-mux.c b/kernel/irq/ipi-mux.c
new file mode 100644
index 000000000000..7bf3d007b1e6
--- /dev/null
+++ b/kernel/irq/ipi-mux.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Multiplex several IPIs over a single HW IPI.
+ *
+ * Copyright (c) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "ipi-mux: " fmt
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/smp.h>
+
+static unsigned int ipi_mux_parent_virq;
+static struct irq_domain *ipi_mux_domain;
+static const struct  ipi_mux_ops *ipi_mux_ops;
+static DEFINE_PER_CPU(unsigned long, ipi_mux_bits);
+
+static void ipi_mux_dummy(struct irq_data *d)
+{
+}
+
+static void ipi_mux_send_mask(struct irq_data *d, const struct cpumask *mask)
+{
+	int cpu;
+
+	/* Barrier before doing atomic bit update to IPI bits */
+	smp_mb__before_atomic();
+
+	for_each_cpu(cpu, mask)
+		set_bit(d->hwirq, per_cpu_ptr(&ipi_mux_bits, cpu));
+
+	/* Barrier after doing atomic bit update to IPI bits */
+	smp_mb__after_atomic();
+
+	/* Trigger the parent IPI */
+	ipi_mux_ops->ipi_mux_send(ipi_mux_parent_virq, mask);
+}
+
+static struct irq_chip ipi_mux_chip = {
+	.name		= "RISC-V IPI Mux",
+	.irq_mask	= ipi_mux_dummy,
+	.irq_unmask	= ipi_mux_dummy,
+	.ipi_send_mask	= ipi_mux_send_mask,
+};
+
+static int ipi_mux_domain_map(struct irq_domain *d, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_percpu_devid(irq);
+	irq_domain_set_info(d, irq, hwirq, &ipi_mux_chip, d->host_data,
+			    handle_percpu_devid_irq, NULL, NULL);
+
+	return 0;
+}
+
+static int ipi_mux_domain_alloc(struct irq_domain *d, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+
+	ret = irq_domain_translate_onecell(d, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		ret = ipi_mux_domain_map(d, virq + i, hwirq + i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops ipi_mux_domain_ops = {
+	.translate	= irq_domain_translate_onecell,
+	.alloc		= ipi_mux_domain_alloc,
+	.free		= irq_domain_free_irqs_top,
+};
+
+void ipi_mux_process(void)
+{
+	int err;
+	unsigned long irqs, *bits = this_cpu_ptr(&ipi_mux_bits);
+	irq_hw_number_t hwirq;
+
+	while (true) {
+		/* Clear the parent IPI */
+		ipi_mux_ops->ipi_mux_clear(ipi_mux_parent_virq);
+
+		/* Order bit clearing and data access. */
+		mb();
+
+		irqs = xchg(bits, 0);
+		if (!irqs)
+			break;
+
+		for_each_set_bit(hwirq, &irqs, IPI_MUX_NR_IRQS) {
+			err = generic_handle_domain_irq(ipi_mux_domain,
+							hwirq);
+			if (unlikely(err))
+				pr_warn_ratelimited(
+					"can't find mapping for hwirq %lu\n",
+					hwirq);
+		}
+	}
+}
+
+static void ipi_mux_handler(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+	ipi_mux_process();
+	chained_irq_exit(chip, desc);
+}
+
+static int ipi_mux_dying_cpu(unsigned int cpu)
+{
+	if (ipi_mux_parent_virq > 0)
+		disable_percpu_irq(ipi_mux_parent_virq);
+	return 0;
+}
+
+static int ipi_mux_starting_cpu(unsigned int cpu)
+{
+	if (ipi_mux_parent_virq > 0)
+		enable_percpu_irq(ipi_mux_parent_virq,
+			irq_get_trigger_type(ipi_mux_parent_virq));
+	return 0;
+}
+
+int ipi_mux_create(unsigned int parent_virq, const struct ipi_mux_ops *ops)
+{
+	int virq;
+	struct irq_fwspec ipi;
+	struct irq_domain *domain;
+
+	if (ipi_mux_domain ||
+	    !ops || !ops->ipi_mux_send || !ops->ipi_mux_clear)
+		return 0;
+
+	domain = irq_domain_add_linear(NULL, IPI_MUX_NR_IRQS,
+				       &ipi_mux_domain_ops, NULL);
+	if (!domain) {
+		pr_err("unable to add IPI Mux domain\n");
+		return 0;
+	}
+
+	ipi.fwnode = domain->fwnode;
+	ipi.param_count = 1;
+	ipi.param[0] = 0;
+	virq = __irq_domain_alloc_irqs(domain, -1, IPI_MUX_NR_IRQS,
+				       NUMA_NO_NODE, &ipi, false, NULL);
+	if (virq <= 0) {
+		pr_err("unable to alloc IRQs from IPI Mux domain\n");
+		irq_domain_remove(domain);
+		return virq;
+	}
+
+	ipi_mux_domain = domain;
+	ipi_mux_parent_virq = parent_virq;
+	ipi_mux_ops = ops;
+
+	if (parent_virq > 0) {
+		irq_set_chained_handler(parent_virq, ipi_mux_handler);
+
+		cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				  "irqchip/ipi-mux:starting",
+				  ipi_mux_starting_cpu, ipi_mux_dying_cpu);
+	}
+
+	return virq;
+}
+
+void ipi_mux_destroy(void)
+{
+	if (!ipi_mux_domain)
+		return;
+
+	irq_domain_remove(ipi_mux_domain);
+	ipi_mux_domain = NULL;
+	ipi_mux_parent_virq = 0;
+}
-- 
2.25.1

