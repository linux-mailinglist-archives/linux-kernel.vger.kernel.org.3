Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819795ABFB3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 18:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiICQNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 12:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiICQNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 12:13:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEF2578A8
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 09:13:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o4so4649797pjp.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8JkNs45nL6eP4dRpsaaqSOVaaU3NIoI49DX3nwl5ILw=;
        b=Duyr0jTuBmKUwt6kYFq/ZadFOsToEWnw63musiokdEf7QOpQ2wKF+JrJYeDZurILG5
         qxsY6abtjFPZDR964XsG0hse847AQuA1RgNA+GsJLPuM9USCypLKohzBiuYwfKWi3U4j
         xR0TeMxPJZsEZVAuBA96YCEsj66h6FiOVP1edTxF0EORomKLE4numgzBmZ6aVlX/J9vR
         4mvRPit/8y0E7ZdmCGwfFL7RnYrZW207sLXCwTBvwaJai3fm5LqEsBG/0Y6tmF3InAm/
         njF8e/BF+YiCKRm1BnrZwqHIZF/7hRQ9YJysq+EscIJZO8bUL1eeXfzd7SA2IdTj8s2N
         x+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8JkNs45nL6eP4dRpsaaqSOVaaU3NIoI49DX3nwl5ILw=;
        b=W/pArLSC7guyTxt4q9e0bbC6iQLlkeSH7giPu4ISZVARLTe655eG7bScYmkZAfiOqz
         gegBeE8g/FCQTPgpFWz2WnLg+E5yGktP3OBRSBVaVwDJFhPyjzT/4Wt0ghwAvOGWU0Ln
         jkgdZEiK6ofWDPMAYjdJm2Ql2stRfyYs/AIG7GAask1TN4dzKuSAhJefiQshaBKORnkM
         Ff+VzzGqMHT1ImRWepQgemzGyAQ2DbSRDhMR834cZR43duAnFHg9S3MWIK+4x8Am1RRO
         9e4rF3/fSWWSV/ORwE0cJiuPv7LYW07EJ/rWPPjw1Tn81U22tfBhf3bEiKO/mF0pV9JE
         5PrA==
X-Gm-Message-State: ACgBeo3GUY9keW5TrWgD/qmvAoJuiG/FJZ4LQz8BnAaKt1R6V4S9AAi3
        U7qk3Oxw3SGDt7wyQGw+NHi35Q==
X-Google-Smtp-Source: AA6agR7yPK07/ICQzzniBUyG0RiWPYgDJC7VnbhupYqfnRmXka+jciNIFiXuHhV795HRVw6GImUxig==
X-Received: by 2002:a17:90a:d484:b0:1fd:7c5b:8fdb with SMTP id s4-20020a17090ad48400b001fd7c5b8fdbmr10906100pju.151.1662221618722;
        Sat, 03 Sep 2022 09:13:38 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.86.115])
        by smtp.gmail.com with ESMTPSA id 4-20020a620504000000b00537b1aa9191sm4166738pff.178.2022.09.03.09.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 09:13:38 -0700 (PDT)
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
Subject: [PATCH v9 3/7] genirq: Add mechanism to multiplex a single HW IPI
Date:   Sat,  3 Sep 2022 21:43:05 +0530
Message-Id: <20220903161309.32848-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220903161309.32848-1-apatel@ventanamicro.com>
References: <20220903161309.32848-1-apatel@ventanamicro.com>
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

To support multiple IPIs on RISC-V, we add a generic IPI multiplexing
mechanism which help us create multiple virtual IPIs using a single
HW IPI. This generic IPI multiplexing is shared among various RISC-V
irqchip drivers.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/irq.h  |  18 ++++
 kernel/irq/Kconfig   |   5 +
 kernel/irq/Makefile  |   1 +
 kernel/irq/ipi-mux.c | 244 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 kernel/irq/ipi-mux.c

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c3eb89606c2b..5ab702cb0a5b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1266,6 +1266,24 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
 int ipi_send_single(unsigned int virq, unsigned int cpu);
 int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
 
+/**
+ * struct ipi_mux_ops - IPI multiplex operations
+ *
+ * @ipi_mux_pre_handle:	Optional function called before handling parent IPI
+ * @ipi_mux_post_handle:Optional function called after handling parent IPI
+ * @ipi_mux_send:	Trigger parent IPI on target CPUs
+ */
+struct ipi_mux_ops {
+	void (*ipi_mux_pre_handle)(unsigned int parent_virq, void *data);
+	void (*ipi_mux_post_handle)(unsigned int parent_virq, void *data);
+	void (*ipi_mux_send)(unsigned int parent_virq, void *data,
+			     const struct cpumask *mask);
+};
+
+void ipi_mux_process(void);
+int ipi_mux_create(unsigned int parent_virq, unsigned int nr_ipi,
+		   const struct ipi_mux_ops *ops, void *data);
+
 #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 /*
  * Registers a generic IRQ handling function as the top-level IRQ handler in
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index db3d174c53d4..df17dbc54b02 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -86,6 +86,11 @@ config GENERIC_IRQ_IPI
 	depends on SMP
 	select IRQ_DOMAIN_HIERARCHY
 
+# Generic IRQ IPI Mux support
+config GENERIC_IRQ_IPI_MUX
+	bool
+	depends on SMP
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
index 000000000000..8939fa2be73c
--- /dev/null
+++ b/kernel/irq/ipi-mux.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Multiplex several virtual IPIs over a single HW IPI.
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
+static void *ipi_mux_data;
+static unsigned int ipi_mux_nr;
+static unsigned int ipi_mux_parent_virq;
+static struct irq_domain *ipi_mux_domain;
+static const struct ipi_mux_ops *ipi_mux_ops;
+static DEFINE_PER_CPU(atomic_t, ipi_mux_enable);
+static DEFINE_PER_CPU(atomic_t, ipi_mux_bits);
+
+static void ipi_mux_mask(struct irq_data *d)
+{
+	atomic_andnot(BIT(irqd_to_hwirq(d)), this_cpu_ptr(&ipi_mux_enable));
+}
+
+static void ipi_mux_unmask(struct irq_data *d)
+{
+	u32 ipi_bit = BIT(irqd_to_hwirq(d));
+
+	atomic_or(ipi_bit, this_cpu_ptr(&ipi_mux_enable));
+
+	/*
+	 * The atomic_or() above must complete before the atomic_read()
+	 * below to avoid racing ipi_mux_send_mask().
+	 */
+	smp_mb__after_atomic();
+
+	/* If a pending IPI was unmasked, raise a parent IPI immediately. */
+	if (atomic_read(this_cpu_ptr(&ipi_mux_bits)) & ipi_bit)
+		ipi_mux_ops->ipi_mux_send(ipi_mux_parent_virq, ipi_mux_data,
+					  cpumask_of(smp_processor_id()));
+}
+
+static void ipi_mux_send_mask(struct irq_data *d, const struct cpumask *mask)
+{
+	u32 ipi_bit = BIT(irqd_to_hwirq(d));
+	struct cpumask pmask = { 0 };
+	unsigned long pending;
+	int cpu;
+
+	for_each_cpu(cpu, mask) {
+		pending = atomic_fetch_or_release(ipi_bit,
+					per_cpu_ptr(&ipi_mux_bits, cpu));
+
+		/*
+		 * The atomic_fetch_or_release() above must complete before
+		 * the atomic_read() below to avoid racing ipi_mux_unmask().
+		 */
+		smp_mb__after_atomic();
+
+		if (!(pending & ipi_bit) &&
+		    (atomic_read(per_cpu_ptr(&ipi_mux_enable, cpu)) & ipi_bit))
+			cpumask_set_cpu(cpu, &pmask);
+	}
+
+	/* Trigger the parent IPI */
+	ipi_mux_ops->ipi_mux_send(ipi_mux_parent_virq, ipi_mux_data, &pmask);
+}
+
+static const struct irq_chip ipi_mux_chip = {
+	.name		= "IPI Mux",
+	.irq_mask	= ipi_mux_mask,
+	.irq_unmask	= ipi_mux_unmask,
+	.ipi_send_mask	= ipi_mux_send_mask,
+};
+
+static int ipi_mux_domain_alloc(struct irq_domain *d, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	struct irq_fwspec *fwspec = arg;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int i, ret;
+
+	ret = irq_domain_translate_onecell(d, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_set_percpu_devid(virq + i);
+		irq_domain_set_info(d, virq + i, hwirq + i,
+				    &ipi_mux_chip, d->host_data,
+				    handle_percpu_devid_irq, NULL, NULL);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops ipi_mux_domain_ops = {
+	.alloc		= ipi_mux_domain_alloc,
+	.free		= irq_domain_free_irqs_top,
+};
+
+/**
+ * ipi_mux_process - Process multiplexed virtual IPIs
+ */
+void ipi_mux_process(void)
+{
+	irq_hw_number_t hwirq;
+	unsigned long ipis;
+	int en, err;
+
+	if (ipi_mux_ops->ipi_mux_pre_handle)
+		ipi_mux_ops->ipi_mux_pre_handle(ipi_mux_parent_virq,
+						ipi_mux_data);
+
+	/*
+	 * Reading enable mask does not need to be ordered as long as
+	 * this function called from interrupt handler because only
+	 * the CPU itself can change it's own enable mask.
+	 */
+	en = atomic_read(this_cpu_ptr(&ipi_mux_enable));
+
+	/*
+	 * Clear the IPIs we are about to handle. This pairs with the
+	 * atomic_fetch_or_release() in ipi_mux_send_mask().
+	 */
+	ipis = atomic_fetch_andnot(en, this_cpu_ptr(&ipi_mux_bits)) & en;
+
+	for_each_set_bit(hwirq, &ipis, ipi_mux_nr) {
+		err = generic_handle_domain_irq(ipi_mux_domain,
+						hwirq);
+		if (unlikely(err))
+			pr_warn_ratelimited(
+				"can't find mapping for hwirq %lu\n",
+				hwirq);
+	}
+
+	if (ipi_mux_ops->ipi_mux_post_handle)
+		ipi_mux_ops->ipi_mux_post_handle(ipi_mux_parent_virq,
+						 ipi_mux_data);
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
+	disable_percpu_irq(ipi_mux_parent_virq);
+	return 0;
+}
+
+static int ipi_mux_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(ipi_mux_parent_virq,
+			  irq_get_trigger_type(ipi_mux_parent_virq));
+	return 0;
+}
+
+/**
+ * ipi_mux_create - Create virtual IPIs multiplexed on top of a single
+ * parent IPI.
+ * @parent_virq:	virq of the parent per-CPU IRQ
+ * @nr_ipi:		number of virtual IPIs to create. This should
+ *			be <= BITS_PER_TYPE(int)
+ * @ops:		multiplexing operations for the parent IPI
+ * @data:		opaque data used by the multiplexing operations
+ *
+ * If the parent IPI > 0 then ipi_mux_process() will be automatically
+ * called via chained handler.
+ *
+ * If the parent IPI <= 0 then it is responsibility of irqchip drivers
+ * to explicitly call ipi_mux_process() for processing muxed IPIs.
+ *
+ * Returns first virq of the newly created virtual IPIs upon success
+ * or <=0 upon failure
+ */
+int ipi_mux_create(unsigned int parent_virq, unsigned int nr_ipi,
+		   const struct ipi_mux_ops *ops, void *data)
+{
+	struct fwnode_handle *fwnode;
+	struct irq_domain *domain;
+	struct irq_fwspec ipi;
+	int virq;
+
+	if (ipi_mux_domain || BITS_PER_TYPE(int) < nr_ipi ||
+	    !ops || !ops->ipi_mux_send)
+		return -EINVAL;
+
+	if (parent_virq &&
+	    !irqd_is_per_cpu(irq_desc_get_irq_data(irq_to_desc(parent_virq))))
+		return -EINVAL;
+
+	fwnode = irq_domain_alloc_named_fwnode("IPI-Mux");
+	if (!fwnode) {
+		pr_err("unable to create IPI Mux fwnode\n");
+		return -ENOMEM;
+	}
+
+	domain = irq_domain_create_simple(fwnode, nr_ipi, 0,
+					  &ipi_mux_domain_ops, NULL);
+	if (!domain) {
+		pr_err("unable to add IPI Mux domain\n");
+		irq_domain_free_fwnode(fwnode);
+		return -ENOMEM;
+	}
+
+	ipi.fwnode = domain->fwnode;
+	ipi.param_count = 1;
+	ipi.param[0] = 0;
+	virq = __irq_domain_alloc_irqs(domain, -1, nr_ipi,
+				       NUMA_NO_NODE, &ipi, false, NULL);
+	if (virq <= 0) {
+		pr_err("unable to alloc IRQs from IPI Mux domain\n");
+		irq_domain_remove(domain);
+		irq_domain_free_fwnode(fwnode);
+		return virq;
+	}
+
+	ipi_mux_domain = domain;
+	ipi_mux_data = data;
+	ipi_mux_nr = nr_ipi;
+	ipi_mux_parent_virq = parent_virq;
+	ipi_mux_ops = ops;
+
+	if (parent_virq > 0) {
+		irq_set_chained_handler(parent_virq, ipi_mux_handler);
+		cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				  "irqchip/ipi-mux:starting",
+				  ipi_mux_starting_cpu, ipi_mux_dying_cpu);
+	}
+
+	return virq;
+}
-- 
2.34.1

