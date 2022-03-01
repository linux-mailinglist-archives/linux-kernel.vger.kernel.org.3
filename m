Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0464C8249
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiCAE3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiCAE3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:29:10 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C154DF6D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:28:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d3so18503283wrf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8F9RQiw9SFGNdqknO7Pbqv6uC/+3poM4SniibT95aP4=;
        b=U4+BPOS/177h0GFa2zL41uf8c+Q+oMorjDOSyHonAP38l9hSwq9iRVgmN38M6Y+PSz
         B5s7pbbeyqGBS0RD+VDoHXZdH643Lixolc9xLRjQ16AwKmMjR5njoQKXVVoEpwrTXQwb
         03OO3fXf+SmVQG9Xsoz7EACJ1pnfjh7oqxTRR2iXQuAg7bLxmAzqodZPLojsvIju7MVx
         jXY8JXp526lBOKyFCPXm+a1r+9BTJ9BCDof6P4mJkq2OMN0RbiZr2BGG902jtNpl48Zd
         JCaIqAxWonblocLnRFHZ1xcM5AjYYpqT8NBdHF/4Tz5GGZM03P/dzYZVz4COoIe1k3r9
         TETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8F9RQiw9SFGNdqknO7Pbqv6uC/+3poM4SniibT95aP4=;
        b=TeOVPBFTjVesw+rVSoRYsjUsbZ77nwqzkHFREZ0zc0KzuY8f72MNti4Z5cf1qJRNn+
         xsBmhddaopgG4y67gJZ26z9JqdwRjJcdBzNw1LX33A7e+QuwfyUNrNE6UlQn9FsD7X1R
         S9teEDaqnUgnit85aTObIK66C3xbNetshaGtU6d8fxtk8bc52V7/ofiRp/VGAXN8a7es
         /lo+tFi1U7xrEhk3I348PazKz3v0XRCNtZlqhl7yh/cnBkR/MQWzDBOEPf/+s5LEHOuo
         FTbUt6WGWTTDrDGqONdAnfeKz+pMPRC5Eo+/j/YhRpPRNQZsKnC1+Xaj/3+SIIlAV05i
         fhHQ==
X-Gm-Message-State: AOAM533Z1XrTQaoj166Zc2i3GRlsC8J5fEABfYcq4U++AUQAj63Q3QwY
        QC10TlIL1VmGYuXibOi7dhLd5Q==
X-Google-Smtp-Source: ABdhPJz5M3W2RA8UZU0TQhrDlcH0Dx7tXSr5vWs25Ue+DBhlE6sPyYBWABtgNkjW+dknZSNMm+PXkw==
X-Received: by 2002:adf:c50b:0:b0:1ef:7a8c:bef2 with SMTP id q11-20020adfc50b000000b001ef7a8cbef2mr12521774wrf.177.1646108907425;
        Mon, 28 Feb 2022 20:28:27 -0800 (PST)
Received: from localhost.localdomain ([122.179.35.69])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm1209107wmz.43.2022.02.28.20.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 20:28:27 -0800 (PST)
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
Subject: [PATCH v4 3/6] RISC-V: Treat IPIs as normal Linux IRQs
Date:   Tue,  1 Mar 2022 09:57:19 +0530
Message-Id: <20220301042722.401113-4-apatel@ventanamicro.com>
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

Currently, the RISC-V kernel provides arch specific hooks (i.e.
struct riscv_ipi_ops) to register IPI handling methods. The stats
gathering of IPIs is also arch specific in the RISC-V kernel.

Other architectures (such as ARM, ARM64, and MIPS) have moved away
from custom arch specific IPI handling methods. Currently, these
architectures have Linux irqchip drivers providing a range of Linux
IRQ numbers to be used as IPIs and IPI triggering is done using
generic IPI APIs. This approach allows architectures to treat IPIs
as normal Linux IRQs and IPI stats gathering is done by the generic
Linux IRQ subsystem.

We extend the RISC-V IPI handling as-per above approach so that arch
specific IPI handling methods (struct riscv_ipi_ops) can be removed
and the IPI handling is done through the Linux IRQ subsystem.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/Kconfig                |   1 +
 arch/riscv/include/asm/ipi-mux.h  |  43 ++++++
 arch/riscv/include/asm/sbi.h      |   2 +
 arch/riscv/include/asm/smp.h      |  35 +++--
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/ipi-mux.c       | 222 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/irq.c           |   3 +-
 arch/riscv/kernel/sbi.c           |  13 +-
 arch/riscv/kernel/smp.c           | 153 ++++++++++----------
 arch/riscv/kernel/smpboot.c       |   5 +-
 drivers/clocksource/timer-clint.c |   8 +-
 drivers/irqchip/irq-riscv-intc.c  |  55 ++++----
 13 files changed, 405 insertions(+), 139 deletions(-)
 create mode 100644 arch/riscv/include/asm/ipi-mux.h
 create mode 100644 arch/riscv/kernel/ipi-mux.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5adcbd9b5e88..167681d6d3f8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -54,6 +54,7 @@ config RISCV
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP if MMU
+	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
diff --git a/arch/riscv/include/asm/ipi-mux.h b/arch/riscv/include/asm/ipi-mux.h
new file mode 100644
index 000000000000..988e2bba372a
--- /dev/null
+++ b/arch/riscv/include/asm/ipi-mux.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Ventana Micro Systems Inc.
+ */
+
+#ifndef _ASM_RISCV_IPI_MUX_H
+#define _ASM_RISCV_IPI_MUX_H
+
+struct cpumask;
+
+#ifdef CONFIG_SMP
+
+/* Handle muxed IPIs */
+void riscv_ipi_mux_handle_irq(void);
+
+/* Create irq_domain for muxed IPIs */
+struct irq_domain *riscv_ipi_mux_create(bool use_soft_irq,
+			void (*clear_ipi)(void),
+			void (*send_ipi)(const struct cpumask *mask));
+
+/* Destroy irq_domain for muxed IPIs */
+void riscv_ipi_mux_destroy(struct irq_domain *d);
+
+#else
+
+static inline void riscv_ipi_mux_handle_irq(void)
+{
+}
+
+static inline struct irq_domain *riscv_ipi_mux_create(bool use_soft_irq,
+			void (*clear_ipi)(void),
+			void (*send_ipi)(const struct cpumask *mask))
+{
+	return NULL;
+}
+
+static inline void riscv_ipi_mux_destroy(struct irq_domain *d)
+{
+}
+
+#endif
+
+#endif /* _ASM_RISCV_IPI_MUX_H */
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 06133b4f8e20..edd2c3135b4a 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -133,6 +133,7 @@ struct sbiret {
 };
 
 void sbi_init(void);
+void sbi_ipi_init(void);
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
 			unsigned long arg3, unsigned long arg4,
@@ -202,6 +203,7 @@ static inline unsigned long sbi_mk_version(unsigned long major,
 int sbi_err_map_linux_errno(int err);
 #else /* CONFIG_RISCV_SBI */
 static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1; }
+static inline void sbi_ipi_init(void) { }
 static inline void sbi_init(void) {}
 #endif /* CONFIG_RISCV_SBI */
 #endif /* _ASM_RISCV_SBI_H */
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 23170c933d73..178fe4ada592 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -15,11 +15,6 @@
 struct seq_file;
 extern unsigned long boot_cpu_hartid;
 
-struct riscv_ipi_ops {
-	void (*ipi_inject)(const struct cpumask *target);
-	void (*ipi_clear)(void);
-};
-
 #ifdef CONFIG_SMP
 /*
  * Mapping between linux logical cpu index and hartid.
@@ -33,9 +28,6 @@ void show_ipi_stats(struct seq_file *p, int prec);
 /* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
 
-/* Called from C code, this handles an IPI. */
-void handle_IPI(struct pt_regs *regs);
-
 /* Hook for the generic smp_call_function_many() routine. */
 void arch_send_call_function_ipi_mask(struct cpumask *mask);
 
@@ -44,11 +36,17 @@ void arch_send_call_function_single_ipi(int cpu);
 
 int riscv_hartid_to_cpuid(int hartid);
 
-/* Set custom IPI operations */
-void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
+/* Enable IPI for CPU hotplug */
+void riscv_ipi_enable(void);
+
+/* Disable IPI for CPU hotplug */
+void riscv_ipi_disable(void);
 
-/* Clear IPI for current CPU */
-void riscv_clear_ipi(void);
+/* Check if IPI interrupt numbers are available */
+bool riscv_ipi_have_virq_range(void);
+
+/* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
+void riscv_ipi_set_virq_range(int virq, int nr_irqs);
 
 /* Secondary hart entry */
 asmlinkage void smp_callin(void);
@@ -82,11 +80,20 @@ static inline unsigned long cpuid_to_hartid_map(int cpu)
 	return boot_cpu_hartid;
 }
 
-static inline void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
+static inline void riscv_ipi_enable(void)
 {
 }
 
-static inline void riscv_clear_ipi(void)
+static inline void riscv_ipi_disable(void)
+{
+}
+
+static inline bool riscv_ipi_have_virq_range(void)
+{
+	return false;
+}
+
+static inline void riscv_ipi_set_virq_range(int virq, int nr)
 {
 }
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index ffc87e76b1dd..5047723e5527 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
+obj-$(CONFIG_SMP)		+= ipi-mux.o
 obj-$(CONFIG_SMP)		+= cpu_ops.o
 
 obj-$(CONFIG_RISCV_BOOT_SPINWAIT) += cpu_ops_spinwait.o
diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index f7a832e3a1d1..39235cf50652 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -13,7 +13,7 @@
 #include <asm/irq.h>
 #include <asm/cpu_ops.h>
 #include <asm/numa.h>
-#include <asm/sbi.h>
+#include <asm/smp.h>
 
 bool cpu_has_hotplug(unsigned int cpu)
 {
@@ -43,6 +43,7 @@ int __cpu_disable(void)
 	remove_cpu_topology(cpu);
 	numa_remove_cpu(cpu);
 	set_cpu_online(cpu, false);
+	riscv_ipi_disable();
 	irq_migrate_all_off_this_cpu();
 
 	return ret;
diff --git a/arch/riscv/kernel/ipi-mux.c b/arch/riscv/kernel/ipi-mux.c
new file mode 100644
index 000000000000..3a0405f0e0de
--- /dev/null
+++ b/arch/riscv/kernel/ipi-mux.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Multiplex several IPIs over a single HW IPI.
+ *
+ * Copyright (c) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv-ipi-mux: " fmt
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/smp.h>
+#include <asm/ipi-mux.h>
+
+struct ipi_mux {
+	struct irq_domain *domain;
+	int parent_virq;
+	void (*clear_ipi)(void);
+	void (*send_ipi)(const struct cpumask *mask);
+};
+
+static struct ipi_mux ipi_mux_priv;
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
+	if (ipi_mux_priv.send_ipi)
+		ipi_mux_priv.send_ipi(mask);
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
+void riscv_ipi_mux_handle_irq(void)
+{
+	int err;
+	unsigned long irqs, *bits = this_cpu_ptr(&ipi_mux_bits);
+	irq_hw_number_t hwirq;
+
+	while (true) {
+		if (ipi_mux_priv.clear_ipi)
+			ipi_mux_priv.clear_ipi();
+
+		/* Order bit clearing and data access. */
+		mb();
+
+		irqs = xchg(bits, 0);
+		if (!irqs)
+			break;
+
+		for_each_set_bit(hwirq, &irqs, BITS_PER_LONG) {
+			err = generic_handle_domain_irq(ipi_mux_priv.domain,
+							hwirq);
+			if (unlikely(err))
+				pr_warn_ratelimited(
+					"can't find mapping for hwirq %lu\n",
+					hwirq);
+		}
+	}
+}
+
+static void ipi_mux_handle_irq(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+	riscv_ipi_mux_handle_irq();
+	chained_irq_exit(chip, desc);
+}
+
+static int ipi_mux_dying_cpu(unsigned int cpu)
+{
+	if (ipi_mux_priv.parent_virq)
+		disable_percpu_irq(ipi_mux_priv.parent_virq);
+	return 0;
+}
+
+static int ipi_mux_starting_cpu(unsigned int cpu)
+{
+	if (ipi_mux_priv.parent_virq)
+		enable_percpu_irq(ipi_mux_priv.parent_virq,
+			irq_get_trigger_type(ipi_mux_priv.parent_virq));
+	return 0;
+}
+
+struct irq_domain *riscv_ipi_mux_create(bool use_soft_irq,
+			void (*clear_ipi)(void),
+			void (*send_ipi)(const struct cpumask *mask))
+{
+	int virq, parent_virq = 0;
+	struct irq_domain *domain;
+	struct irq_fwspec ipi;
+
+	if (ipi_mux_priv.domain || riscv_ipi_have_virq_range())
+		return NULL;
+
+	if (use_soft_irq) {
+		domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+						  DOMAIN_BUS_ANY);
+		if (!domain) {
+			pr_err("unable to find INTC IRQ domain\n");
+			return NULL;
+		}
+
+		parent_virq = irq_create_mapping(domain, RV_IRQ_SOFT);
+		if (!parent_virq) {
+			pr_err("unable to create INTC IRQ mapping\n");
+			return NULL;
+		}
+	}
+
+	domain = irq_domain_add_linear(NULL, BITS_PER_LONG,
+				       &ipi_mux_domain_ops, NULL);
+	if (!domain) {
+		pr_err("unable to add IPI Mux domain\n");
+		goto fail_dispose_mapping;
+	}
+
+	ipi.fwnode = domain->fwnode;
+	ipi.param_count = 1;
+	ipi.param[0] = 0;
+	virq = __irq_domain_alloc_irqs(domain, -1, BITS_PER_LONG,
+				       NUMA_NO_NODE, &ipi, false, NULL);
+	if (virq <= 0) {
+		pr_err("unable to alloc IRQs from IPI Mux domain\n");
+		goto fail_domain_remove;
+	}
+
+	ipi_mux_priv.domain = domain;
+	ipi_mux_priv.parent_virq = parent_virq;
+	ipi_mux_priv.clear_ipi = clear_ipi;
+	ipi_mux_priv.send_ipi = send_ipi;
+
+	if (parent_virq)
+		irq_set_chained_handler(parent_virq, ipi_mux_handle_irq);
+
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			  "irqchip/riscv/ipi-mux:starting",
+			  ipi_mux_starting_cpu, ipi_mux_dying_cpu);
+
+	riscv_ipi_set_virq_range(virq, BITS_PER_LONG);
+
+	return ipi_mux_priv.domain;
+
+fail_domain_remove:
+	irq_domain_remove(domain);
+fail_dispose_mapping:
+	if (parent_virq)
+		irq_dispose_mapping(parent_virq);
+	return NULL;
+}
+
+void riscv_ipi_mux_destroy(struct irq_domain *d)
+{
+	if (!d || ipi_mux_priv.domain != d)
+		return;
+
+	irq_domain_remove(ipi_mux_priv.domain);
+	if (ipi_mux_priv.parent_virq)
+		irq_dispose_mapping(ipi_mux_priv.parent_virq);
+	memset(&ipi_mux_priv, 0, sizeof(ipi_mux_priv));
+}
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 96d3171f0ca1..eb9a68a539e6 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -10,7 +10,7 @@
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
-#include <asm/smp.h>
+#include <asm/sbi.h>
 
 static struct fwnode_handle *(*__get_intc_node)(void);
 
@@ -39,4 +39,5 @@ void __init init_IRQ(void)
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
+	sbi_ipi_init();
 }
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index fc614650a2e3..ab38814f1977 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -5,10 +5,12 @@
  * Copyright (c) 2020 Western Digital Corporation or its affiliates.
  */
 
+#define pr_fmt(fmt) "riscv: " fmt
 #include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <linux/reboot.h>
+#include <asm/ipi-mux.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
 
@@ -648,10 +650,11 @@ static void sbi_ipi_clear(void)
 	csr_clear(CSR_IP, IE_SIE);
 }
 
-static const struct riscv_ipi_ops sbi_ipi_ops = {
-	.ipi_inject = sbi_send_cpumask_ipi,
-	.ipi_clear = sbi_ipi_clear
-};
+void __init sbi_ipi_init(void)
+{
+	if (riscv_ipi_mux_create(true, sbi_ipi_clear, sbi_send_cpumask_ipi))
+		pr_info("providing IPIs using SBI IPI extension\n");
+}
 
 void __init sbi_init(void)
 {
@@ -699,6 +702,4 @@ void __init sbi_init(void)
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
 		__sbi_rfence	= __sbi_rfence_v01;
 	}
-
-	riscv_set_ipi_ops(&sbi_ipi_ops);
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 6fd8b3cbec1b..a9f1aca38358 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -17,9 +17,9 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
 #include <linux/irq_work.h>
 
-#include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
@@ -41,11 +41,9 @@ void __init smp_setup_processor_id(void)
 	cpuid_to_hartid_map(0) = boot_cpu_hartid;
 }
 
-/* A collection of single bit ipi messages.  */
-static struct {
-	unsigned long stats[IPI_MAX] ____cacheline_aligned;
-	unsigned long bits ____cacheline_aligned;
-} ipi_data[NR_CPUS] __cacheline_aligned;
+static int ipi_virq_base __ro_after_init;
+static int nr_ipi __ro_after_init = IPI_MAX;
+static struct irq_desc *ipi_desc[IPI_MAX] __read_mostly;
 
 int riscv_hartid_to_cpuid(int hartid)
 {
@@ -77,46 +75,14 @@ static void ipi_stop(void)
 		wait_for_interrupt();
 }
 
-static const struct riscv_ipi_ops *ipi_ops __ro_after_init;
-
-void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
-{
-	ipi_ops = ops;
-}
-EXPORT_SYMBOL_GPL(riscv_set_ipi_ops);
-
-void riscv_clear_ipi(void)
-{
-	if (ipi_ops && ipi_ops->ipi_clear)
-		ipi_ops->ipi_clear();
-}
-EXPORT_SYMBOL_GPL(riscv_clear_ipi);
-
 static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 {
-	int cpu;
-
-	smp_mb__before_atomic();
-	for_each_cpu(cpu, mask)
-		set_bit(op, &ipi_data[cpu].bits);
-	smp_mb__after_atomic();
-
-	if (ipi_ops && ipi_ops->ipi_inject)
-		ipi_ops->ipi_inject(mask);
-	else
-		pr_warn("SMP: IPI inject method not available\n");
+	__ipi_send_mask(ipi_desc[op], mask);
 }
 
 static void send_ipi_single(int cpu, enum ipi_message_type op)
 {
-	smp_mb__before_atomic();
-	set_bit(op, &ipi_data[cpu].bits);
-	smp_mb__after_atomic();
-
-	if (ipi_ops && ipi_ops->ipi_inject)
-		ipi_ops->ipi_inject(cpumask_of(cpu));
-	else
-		pr_warn("SMP: IPI inject method not available\n");
+	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
 }
 
 #ifdef CONFIG_IRQ_WORK
@@ -126,55 +92,88 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-void handle_IPI(struct pt_regs *regs)
+static irqreturn_t handle_IPI(int irq, void *data)
+{
+	int ipi = irq - ipi_virq_base;
+
+	switch (ipi) {
+	case IPI_RESCHEDULE:
+		scheduler_ipi();
+		break;
+	case IPI_CALL_FUNC:
+		generic_smp_call_function_interrupt();
+		break;
+	case IPI_CPU_STOP:
+		ipi_stop();
+		break;
+	case IPI_IRQ_WORK:
+		irq_work_run();
+		break;
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+	case IPI_TIMER:
+		tick_receive_broadcast();
+		break;
+#endif
+	default:
+		pr_warn("CPU%d: unhandled IPI%d\n", smp_processor_id(), ipi);
+		break;
+	};
+
+	return IRQ_HANDLED;
+}
+
+void riscv_ipi_enable(void)
 {
-	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
-	unsigned long *stats = ipi_data[smp_processor_id()].stats;
+	int i;
 
-	riscv_clear_ipi();
+	if (WARN_ON_ONCE(!ipi_virq_base))
+		return;
 
-	while (true) {
-		unsigned long ops;
+	for (i = 0; i < nr_ipi; i++)
+		enable_percpu_irq(ipi_virq_base + i, 0);
+}
 
-		/* Order bit clearing and data access. */
-		mb();
+void riscv_ipi_disable(void)
+{
+	int i;
 
-		ops = xchg(pending_ipis, 0);
-		if (ops == 0)
-			return;
+	if (WARN_ON_ONCE(!ipi_virq_base))
+		return;
 
-		if (ops & (1 << IPI_RESCHEDULE)) {
-			stats[IPI_RESCHEDULE]++;
-			scheduler_ipi();
-		}
+	for (i = 0; i < nr_ipi; i++)
+		disable_percpu_irq(ipi_virq_base + i);
+}
 
-		if (ops & (1 << IPI_CALL_FUNC)) {
-			stats[IPI_CALL_FUNC]++;
-			generic_smp_call_function_interrupt();
-		}
+bool riscv_ipi_have_virq_range(void)
+{
+	return (ipi_virq_base) ? true : false;
+}
 
-		if (ops & (1 << IPI_CPU_STOP)) {
-			stats[IPI_CPU_STOP]++;
-			ipi_stop();
-		}
+void riscv_ipi_set_virq_range(int virq, int nr)
+{
+	int i, err;
 
-		if (ops & (1 << IPI_IRQ_WORK)) {
-			stats[IPI_IRQ_WORK]++;
-			irq_work_run();
-		}
+	if (WARN_ON(ipi_virq_base))
+		return;
 
-#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
-		if (ops & (1 << IPI_TIMER)) {
-			stats[IPI_TIMER]++;
-			tick_receive_broadcast();
-		}
-#endif
-		BUG_ON((ops >> IPI_MAX) != 0);
+	WARN_ON(nr < IPI_MAX);
+	nr_ipi = min(nr, IPI_MAX);
+	ipi_virq_base = virq;
+
+	/* Request IPIs */
+	for (i = 0; i < nr_ipi; i++) {
+		err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
+					 "IPI", &ipi_virq_base);
+		WARN_ON(err);
 
-		/* Order data access and bit testing. */
-		mb();
+		ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
+		irq_set_status_flags(ipi_virq_base + i, IRQ_HIDDEN);
 	}
+
+	/* Enabled IPIs for boot CPU immediately */
+	riscv_ipi_enable();
 }
+EXPORT_SYMBOL_GPL(riscv_ipi_set_virq_range);
 
 static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
@@ -192,7 +191,7 @@ void show_ipi_stats(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10lu ", ipi_data[cpu].stats[i]);
+			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
 		seq_printf(p, " %s\n", ipi_names[i]);
 	}
 }
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 622f226454d5..e37036e779bb 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -30,7 +30,6 @@
 #include <asm/numa.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
-#include <asm/sbi.h>
 #include <asm/smp.h>
 #include <asm/alternative.h>
 
@@ -159,12 +158,12 @@ asmlinkage __visible void smp_callin(void)
 	struct mm_struct *mm = &init_mm;
 	unsigned int curr_cpuid = smp_processor_id();
 
-	riscv_clear_ipi();
-
 	/* All kernel threads share the same mm context.  */
 	mmgrab(mm);
 	current->active_mm = mm;
 
+	riscv_ipi_enable();
+
 	notify_cpu_starting(curr_cpuid);
 	numa_add_cpu(curr_cpuid);
 	update_siblings_masks(curr_cpuid);
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 6cfe2ab73eb0..b05a9e946633 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -20,6 +20,7 @@
 #include <linux/of_irq.h>
 #include <linux/smp.h>
 #include <linux/timex.h>
+#include <asm/ipi-mux.h>
 
 #ifndef CONFIG_RISCV_M_MODE
 #include <asm/clint.h>
@@ -54,11 +55,6 @@ static void clint_clear_ipi(void)
 	writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()));
 }
 
-static struct riscv_ipi_ops clint_ipi_ops = {
-	.ipi_inject = clint_send_ipi,
-	.ipi_clear = clint_clear_ipi,
-};
-
 #ifdef CONFIG_64BIT
 #define clint_get_cycles()	readq_relaxed(clint_timer_val)
 #else
@@ -228,7 +224,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		goto fail_free_irq;
 	}
 
-	riscv_set_ipi_ops(&clint_ipi_ops);
+	riscv_ipi_mux_create(true, clint_clear_ipi, clint_send_ipi);
 	clint_clear_ipi();
 
 	return 0;
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 084793a57af8..6ab688e54bc1 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -26,20 +26,7 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 	if (unlikely(cause >= BITS_PER_LONG))
 		panic("unexpected interrupt cause");
 
-	switch (cause) {
-#ifdef CONFIG_SMP
-	case RV_IRQ_SOFT:
-		/*
-		 * We only use software interrupts to pass IPIs, so if a
-		 * non-SMP system gets one, then we don't know what to do.
-		 */
-		handle_IPI(regs);
-		break;
-#endif
-	default:
-		generic_handle_domain_irq(intc_domain, cause);
-		break;
-	}
+	generic_handle_domain_irq(intc_domain, cause);
 }
 
 /*
@@ -59,18 +46,6 @@ static void riscv_intc_irq_unmask(struct irq_data *d)
 	csr_set(CSR_IE, BIT(d->hwirq));
 }
 
-static int riscv_intc_cpu_starting(unsigned int cpu)
-{
-	csr_set(CSR_IE, BIT(RV_IRQ_SOFT));
-	return 0;
-}
-
-static int riscv_intc_cpu_dying(unsigned int cpu)
-{
-	csr_clear(CSR_IE, BIT(RV_IRQ_SOFT));
-	return 0;
-}
-
 static struct irq_chip riscv_intc_chip = {
 	.name = "RISC-V INTC",
 	.irq_mask = riscv_intc_irq_mask,
@@ -87,9 +62,32 @@ static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+static int riscv_intc_domain_alloc(struct irq_domain *domain,
+				   unsigned int virq, unsigned int nr_irqs,
+				   void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+
+	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		ret = riscv_intc_domain_map(domain, virq + i, hwirq + i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct irq_domain_ops riscv_intc_domain_ops = {
 	.map	= riscv_intc_domain_map,
 	.xlate	= irq_domain_xlate_onecell,
+	.alloc	= riscv_intc_domain_alloc
 };
 
 static struct fwnode_handle *riscv_intc_hwnode(void)
@@ -132,11 +130,6 @@ static int __init riscv_intc_init(struct device_node *node,
 
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
-	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
-			  "irqchip/riscv/intc:starting",
-			  riscv_intc_cpu_starting,
-			  riscv_intc_cpu_dying);
-
 	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
 
 	return 0;
-- 
2.25.1

