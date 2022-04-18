Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A8B504F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiDRK4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbiDRK4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:56:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B27819C10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:54:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id md4so12698867pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LYvOW09t4vmkz1R5WaoV0j5+bkTW2NqkXYOOT3FmrYw=;
        b=fq/BqEAexd1N81JXpAGebu9PtmCBnqoBE/xalSjEGoL5YgXtzbFEXzJKK3zSGoC2do
         pBCQ1oIEsrRgKptN/ng7FioHM250KH2dv9J9GhhvXBje3Fk0jS6Iv6CJ6AqMKBrD//PK
         1oSQnElz3gkpihtiz0BkBoAO/RUNHLGkZ3xAtTS0dgdB7gbp9RkBAvnKXlCILAt/PU+F
         gvoQytnQmHEDzYUFRmNuVKbHIl2m6Y47hyH66RiIOG6cNGv94KGD84d7in6eLhG8D7y8
         K261olM8M23g4q1q+roVpmG7OLUgAYOHCL7XGZ3Yo6mCFjf4TrTTTtUT1XievHx1rQvW
         pxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LYvOW09t4vmkz1R5WaoV0j5+bkTW2NqkXYOOT3FmrYw=;
        b=yOFIlRL7jSDVwMsOr4ZG+dEi5RBUbSIyMz09e4KrEoM5qxiS/s6AFZyB9wkoGMSYyO
         J5Hs8VY3y8D27Scm2BoQi50fOIAViG8Q7dLxA47txNGgmepH9PKFxCjBI8YXGzWVmjLe
         uPfvyWOtMNoBS61EHg+O9vwMciRkb+1m4+32TpQ6d6mDa6VqyZhdFKFTB7TSGWJyD5BH
         x+Vd0ferrfkY8grZQKlz2gAD9mdnV7KEd5dxvbD1yexOdsIKQw4hHyc4kwyKpikYuTJl
         QqorYbdPicE5pT5E5Qyfj9PaMGDydzrddlpecLdMbNsfXGvruazH1qsHfWFf/WHCQOM8
         5Z0w==
X-Gm-Message-State: AOAM5338lz5yZMloFj3aL1YYEklhc9U2OwSD/frS4AGCXCFvfF6oASce
        GrtEQSPVcx4wc1fCSyTpe676fA==
X-Google-Smtp-Source: ABdhPJxowHNS+1+mHzIjDBf+GKoUuj8zHH4C04dvg7JRNu09q22/8RG37y66e2349N9qIRuo+F125w==
X-Received: by 2002:a17:90a:4e08:b0:1cb:a3ac:938b with SMTP id n8-20020a17090a4e0800b001cba3ac938bmr17493419pjh.112.1650279241897;
        Mon, 18 Apr 2022 03:54:01 -0700 (PDT)
Received: from localhost.localdomain ([122.172.241.223])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm12986278pfu.202.2022.04.18.03.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 03:54:01 -0700 (PDT)
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
Subject: [PATCH v6 4/7] RISC-V: Treat IPIs as normal Linux IRQs
Date:   Mon, 18 Apr 2022 16:23:02 +0530
Message-Id: <20220418105305.1196665-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418105305.1196665-1-apatel@ventanamicro.com>
References: <20220418105305.1196665-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 arch/riscv/Kconfig                |   2 +
 arch/riscv/include/asm/sbi.h      |   2 +
 arch/riscv/include/asm/smp.h      |  35 ++++---
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/irq.c           |   3 +-
 arch/riscv/kernel/sbi-ipi.c       |  60 ++++++++++++
 arch/riscv/kernel/sbi.c           |  17 ----
 arch/riscv/kernel/smp.c           | 153 +++++++++++++++---------------
 arch/riscv/kernel/smpboot.c       |   5 +-
 drivers/clocksource/timer-clint.c |  41 +++++---
 drivers/irqchip/irq-riscv-intc.c  |  55 +++++------
 12 files changed, 222 insertions(+), 155 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi-ipi.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 00fd9c548f26..658dfa05ed18 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -57,6 +57,8 @@ config RISCV
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP if MMU
+	select GENERIC_IRQ_IPI
+	select GENERIC_IRQ_IPI_MUX
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 9e3c2cf1edaf..72a5426364ab 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -228,6 +228,7 @@ struct sbiret {
 };
 
 void sbi_init(void);
+void sbi_ipi_init(void);
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
 			unsigned long arg3, unsigned long arg4,
@@ -297,6 +298,7 @@ static inline unsigned long sbi_mk_version(unsigned long major,
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
index 87adbe47bc15..2390510d877a 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_TRACE_IRQFLAGS)	+= trace_irq.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
+obj-$(CONFIG_RISCV_SBI)		+= sbi-ipi.o
 ifeq ($(CONFIG_RISCV_SBI), y)
 obj-$(CONFIG_SMP) += cpu_ops_sbi.o
 endif
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
diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
new file mode 100644
index 000000000000..67f213ec2b04
--- /dev/null
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Multiplex several IPIs over a single HW IPI.
+ *
+ * Copyright (c) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv: " fmt
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <asm/sbi.h>
+
+static void sbi_send_cpumask_ipi(unsigned int parent_virq,
+				 const struct cpumask *target)
+{
+	sbi_send_ipi(target);
+}
+
+static void sbi_ipi_clear(unsigned int parent_virq)
+{
+	csr_clear(CSR_IP, IE_SIE);
+}
+
+static struct ipi_mux_ops sbi_ipi_ops = {
+	.ipi_mux_clear = sbi_ipi_clear,
+	.ipi_mux_send = sbi_send_cpumask_ipi,
+};
+
+void __init sbi_ipi_init(void)
+{
+	int virq, parent_virq;
+	struct irq_domain *domain;
+
+	if (riscv_ipi_have_virq_range())
+		return;
+
+	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+					  DOMAIN_BUS_ANY);
+	if (!domain) {
+		pr_err("unable to find INTC IRQ domain\n");
+		return;
+	}
+
+	parent_virq = irq_create_mapping(domain, RV_IRQ_SOFT);
+	if (!parent_virq) {
+		pr_err("unable to create INTC IRQ mapping\n");
+		return;
+	}
+
+	virq = ipi_mux_create(parent_virq, &sbi_ipi_ops);
+	if (virq <= 0) {
+		pr_err("unable to create muxed IPIs\n");
+		irq_dispose_mapping(parent_virq);
+		return;
+	}
+
+	riscv_ipi_set_virq_range(virq, IPI_MUX_NR_IRQS);
+	pr_info("providing IPIs using SBI IPI extension\n");
+}
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index fc614650a2e3..e9f04eba0e09 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -638,21 +638,6 @@ long sbi_get_mimpid(void)
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
 }
 
-static void sbi_send_cpumask_ipi(const struct cpumask *target)
-{
-	sbi_send_ipi(target);
-}
-
-static void sbi_ipi_clear(void)
-{
-	csr_clear(CSR_IP, IE_SIE);
-}
-
-static const struct riscv_ipi_ops sbi_ipi_ops = {
-	.ipi_inject = sbi_send_cpumask_ipi,
-	.ipi_clear = sbi_ipi_clear
-};
-
 void __init sbi_init(void)
 {
 	int ret;
@@ -699,6 +684,4 @@ void __init sbi_init(void)
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
index 6cfe2ab73eb0..1861db1bfcbf 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -17,6 +17,8 @@
 #include <linux/sched_clock.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/smp.h>
 #include <linux/timex.h>
@@ -31,6 +33,7 @@
 
 /* CLINT manages IPI and Timer for RISC-V M-mode  */
 static u32 __iomem *clint_ipi_base;
+static unsigned int clint_ipi_irq;
 static u64 __iomem *clint_timer_cmp;
 static u64 __iomem *clint_timer_val;
 static unsigned long clint_timer_freq;
@@ -41,7 +44,8 @@ u64 __iomem *clint_time_val;
 EXPORT_SYMBOL(clint_time_val);
 #endif
 
-static void clint_send_ipi(const struct cpumask *target)
+static void clint_send_ipi(unsigned int parent_virq,
+			   const struct cpumask *target)
 {
 	unsigned int cpu;
 
@@ -49,14 +53,14 @@ static void clint_send_ipi(const struct cpumask *target)
 		writel(1, clint_ipi_base + cpuid_to_hartid_map(cpu));
 }
 
-static void clint_clear_ipi(void)
+static void clint_clear_ipi(unsigned int parent_virq)
 {
 	writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()));
 }
 
-static struct riscv_ipi_ops clint_ipi_ops = {
-	.ipi_inject = clint_send_ipi,
-	.ipi_clear = clint_clear_ipi,
+static struct ipi_mux_ops clint_ipi_ops = {
+	.ipi_mux_clear = clint_clear_ipi,
+	.ipi_mux_send = clint_send_ipi,
 };
 
 #ifdef CONFIG_64BIT
@@ -146,7 +150,7 @@ static irqreturn_t clint_timer_interrupt(int irq, void *dev_id)
 
 static int __init clint_timer_init_dt(struct device_node *np)
 {
-	int rc;
+	int rc, virq;
 	u32 i, nr_irqs;
 	void __iomem *base;
 	struct of_phandle_args oirq;
@@ -170,6 +174,12 @@ static int __init clint_timer_init_dt(struct device_node *np)
 			return -ENODEV;
 		}
 
+		/* Find parent irq domain and map ipi irq */
+		if (!clint_ipi_irq &&
+		    oirq.args[0] == RV_IRQ_SOFT &&
+		    irq_find_host(oirq.np))
+			clint_ipi_irq = irq_of_parse_and_map(np, i);
+
 		/* Find parent irq domain and map timer irq */
 		if (!clint_timer_irq &&
 		    oirq.args[0] == RV_IRQ_TIMER &&
@@ -177,9 +187,9 @@ static int __init clint_timer_init_dt(struct device_node *np)
 			clint_timer_irq = irq_of_parse_and_map(np, i);
 	}
 
-	/* If CLINT timer irq not found then fail */
-	if (!clint_timer_irq) {
-		pr_err("%pOFP: timer irq not found\n", np);
+	/* If CLINT ipi or timer irq not found then fail */
+	if (!clint_ipi_irq || !clint_timer_irq) {
+		pr_err("%pOFP: ipi/timer irq not found\n", np);
 		return -ENODEV;
 	}
 
@@ -228,11 +238,20 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		goto fail_free_irq;
 	}
 
-	riscv_set_ipi_ops(&clint_ipi_ops);
-	clint_clear_ipi();
+	virq = ipi_mux_create(clint_ipi_irq, &clint_ipi_ops);
+	if (virq <= 0) {
+		pr_err("unable to create muxed IPIs\n");
+		rc = (virq < 0) ? virq : -ENODEV;
+		goto fail_remove_cpuhp;
+	}
+
+	riscv_ipi_set_virq_range(virq, IPI_MUX_NR_IRQS);
+	clint_clear_ipi(clint_ipi_irq);
 
 	return 0;
 
+fail_remove_cpuhp:
+	cpuhp_remove_state(CPUHP_AP_CLINT_TIMER_STARTING);
 fail_free_irq:
 	free_irq(clint_timer_irq, &clint_clock_event);
 fail_iounmap:
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

