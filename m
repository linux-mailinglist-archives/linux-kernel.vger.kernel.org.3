Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402D447F242
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 06:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhLYFm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 00:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLYFmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 00:42:47 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631A7C06175C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 21:42:46 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id e25so4125138qkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 21:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1BN5OzyaysjU4EeFWXcqwFTDp+AYSLqwKPfhAYkhC9c=;
        b=Bekmn0IHdcXF8XRz5k19JDew1p8jXHY+mB0RVGE/4W4Yk0EUDwAJW/JWAQPB1cumMI
         dCQuANtLIk+EltuZDsxil0AX3djEH8QU4xQ1ARjLOGGaHsia38WRBS5sN5Y+t97z0vLp
         P1bgCqd1jgMCYuSYMSrAwER5Jsi8WMzCfXfRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1BN5OzyaysjU4EeFWXcqwFTDp+AYSLqwKPfhAYkhC9c=;
        b=M/e1BC8pdO3lPhzeb4kAC0MbRryMnAj6+WUHHL6RI/IeoKO8vWOViEbgdJ7UmG4zW/
         XIF72olRYZMBFWTrcQF5nuYMRk8cwVyImr/y1fSbNb9v4p9LFnKHBQaU7oqn9ZmDpH0k
         KM8IlPGHnWvYBnYxmm2a3sa22dFsy28Bc0dXrty5nGayLfaSogcJxnpBNlY4TxfFn8SU
         yycbtWGfK6r0P4MU6thoFLWpoBNeSseZEtX/BYw2AKHwnK4HdxkU7bVT2XtC/ChjH64E
         NXbqNOvGDeD5xfLr9hj/5DOZIZnWmWVLOsbX5bth/Nwssw9J1qDHb6zavVq4jk7zOjEY
         FxsQ==
X-Gm-Message-State: AOAM530/x8u/ZRs2A8c5bh2l1bD1q7fVeASEuaWrydwF14q6LSfJ+1Q7
        CE8FgNZIrSWwdJ8X249cLvnm3LJY1vRX
X-Google-Smtp-Source: ABdhPJxXAcry6IY8HwlBGE5oWOxsxzPqDMnTlYGrEShaJPeC6rf9Dzh9X2ROhWfdcmFCywdRfALCXA==
X-Received: by 2002:a05:620a:1663:: with SMTP id d3mr5900325qko.368.1640410965291;
        Fri, 24 Dec 2021 21:42:45 -0800 (PST)
Received: from fedora.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id v1sm8438486qtw.65.2021.12.24.21.42.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 21:42:45 -0800 (PST)
From:   Atish Patra <atishp@atishpatra.org>
X-Google-Original-From: Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Subject: [v5 7/9] RISC-V: Add sscofpmf extension support
Date:   Fri, 24 Dec 2021 21:42:36 -0800
Message-Id: <20211225054238.1750241-8-atishp@rivosinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211225054238.1750241-1-atishp@rivosinc.com>
References: <20211225054238.1750241-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

The sscofpmf extension allows counter overflow and filtering for
programmable counters. Enable the perf driver to handle the overflow
interrupt. The overflow interrupt is a hart local interrupt.
Thus, per cpu overflow interrupts are setup as a child under the root
INTC irq domain.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr.h   |   8 +-
 arch/riscv/include/asm/hwcap.h |   1 +
 arch/riscv/kernel/cpufeature.c |   1 +
 drivers/perf/riscv_pmu_sbi.c   | 218 +++++++++++++++++++++++++++++++--
 include/linux/perf/riscv_pmu.h |   2 +
 5 files changed, 222 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index e4d369830af4..8518eb0014bc 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -63,6 +63,7 @@
 #define IRQ_M_TIMER		7
 #define IRQ_S_EXT		9
 #define IRQ_M_EXT		11
+#define IRQ_PMU_OVF		13
 
 /* Exception causes */
 #define EXC_INST_MISALIGNED	0
@@ -151,6 +152,8 @@
 #define CSR_HPMCOUNTER30H	0xc9e
 #define CSR_HPMCOUNTER31H	0xc9f
 
+#define CSR_SSCOUNTOVF		0xda0
+
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
 #define CSR_STVEC		0x105
@@ -212,7 +215,10 @@
 # define RV_IRQ_SOFT		IRQ_S_SOFT
 # define RV_IRQ_TIMER	IRQ_S_TIMER
 # define RV_IRQ_EXT		IRQ_S_EXT
-#endif /* CONFIG_RISCV_M_MODE */
+# define RV_IRQ_PMU	IRQ_PMU_OVF
+# define SIP_LCOFIP     (_AC(0x1, UL) << IRQ_PMU_OVF)
+
+#endif /* !CONFIG_RISCV_M_MODE */
 
 /* IE/IP (Supervisor/Machine Interrupt Enable/Pending) flags */
 #define IE_SIE		(_AC(0x1, UL) << RV_IRQ_SOFT)
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 368ab0f330c8..417e0840647a 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -50,6 +50,7 @@ extern unsigned long elf_hwcap;
  * available logical extension id.
  */
 enum riscv_isa_ext_id {
+	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c70eeec17f5b..3eedfb9ecd48 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -71,6 +71,7 @@ EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
 	}
 
 static struct riscv_isa_ext_data isa_ext_arr[] = {
+	__RISCV_ISA_EXT_DATA(sscofpmf, sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA("", "", RISCV_ISA_EXT_MAX),
 };
 
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index f078d423a89a..ff8692ac43a5 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -11,8 +11,13 @@
 #include <linux/mod_devicetable.h>
 #include <linux/perf/riscv_pmu.h>
 #include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+#include <linux/of.h>
 
 #include <asm/sbi.h>
+#include <asm/hwcap.h>
 
 union sbi_pmu_ctr_info {
 	unsigned long value;
@@ -33,6 +38,7 @@ union sbi_pmu_ctr_info {
  * per_cpu in case of harts with different pmu counters
  */
 static union sbi_pmu_ctr_info *pmu_ctr_list;
+static unsigned int riscv_pmu_irq;
 
 struct pmu_event_data {
 	union {
@@ -450,33 +456,223 @@ static int pmu_sbi_get_ctrinfo(int nctr)
 	return 0;
 }
 
+static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
+{
+	int idx = 0;
+	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
+	unsigned long cmask = 0;
+	union sbi_pmu_ctr_info *info;
+
+	/* We should only stop the used hardware counters */
+	for_each_set_bit(idx, cpu_hw_evt->used_event_ctrs, RISCV_MAX_COUNTERS) {
+		info = &pmu_ctr_list[idx];
+		if (info->type != SBI_PMU_CTR_TYPE_FW)
+			cmask |= (1 << idx);
+	}
+	/* No need to check the error here as we can't do anything about the error */
+	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0, cmask, 0, 0, 0, 0);
+}
+
+/**
+ * This function starts all the used counters in two step approach.
+ * Any counter that did not overflow can be start in a single step
+ * while the overflowed counters need to be started with updated initialization
+ * value.
+ */
+static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
+					       unsigned long ctr_ovf_mask)
+{
+	int idx = 0;
+	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
+	struct perf_event *event;
+	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
+	unsigned long ctr_start_mask = 0;
+	uint64_t max_period;
+	struct hw_perf_event *hwc;
+	u64 init_val = 0;
+
+	ctr_start_mask = cpu_hw_evt->used_event_ctrs[0] & ~ctr_ovf_mask;
+
+	/* Start all the counters that did not overflow in a single shot */
+	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_mask,
+		  0, 0, 0, 0);
+
+	/* Reinitialize and start all the counter that overflowed */
+	while (ctr_ovf_mask) {
+		if (ctr_ovf_mask & 0x01) {
+			event = cpu_hw_evt->events[idx];
+			hwc = &event->hw;
+			max_period = riscv_pmu_ctr_get_width_mask(event);
+			init_val = local64_read(&hwc->prev_count) & max_period;
+			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
+				  flag, init_val, 0, 0);
+		}
+		ctr_ovf_mask = ctr_ovf_mask >> 1;
+		idx++;
+	}
+}
+
+static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
+{
+	struct perf_sample_data data;
+	struct pt_regs *regs;
+	struct hw_perf_event *hw_evt;
+	union sbi_pmu_ctr_info *info;
+	int lidx, hidx, fidx;
+	struct riscv_pmu *pmu;
+	struct perf_event *event;
+	struct cpu_hw_events *cpu_hw_evt = dev;
+	unsigned long overflow;
+	unsigned long overflowed_ctrs = 0;
+
+	fidx = find_first_bit(cpu_hw_evt->used_event_ctrs, RISCV_MAX_COUNTERS);
+	event = cpu_hw_evt->events[fidx];
+	if (!event) {
+		csr_clear(CSR_SIP, SIP_LCOFIP);
+		return IRQ_NONE;
+	}
+
+	pmu = to_riscv_pmu(event->pmu);
+	pmu_sbi_stop_all(pmu);
+
+	/* Overflow status register should only be read after counter are stopped */
+	overflow = csr_read(CSR_SSCOUNTOVF);
+
+	/**
+	 * Overflow interrupt pending bit should only be cleared after stopping
+	 * all the counters to avoid any race condition.
+	 */
+	csr_clear(CSR_SIP, SIP_LCOFIP);
+
+	/* No overflow bit is set */
+	if (!overflow)
+		return IRQ_NONE;
+
+	regs = get_irq_regs();
+
+	for_each_set_bit(lidx, cpu_hw_evt->used_event_ctrs, RISCV_MAX_COUNTERS) {
+		struct perf_event *event = cpu_hw_evt->events[lidx];
+
+		/* Skip if invalid event or user did not request a sampling */
+		if (!event || !is_sampling_event(event))
+			continue;
+
+		info = &pmu_ctr_list[lidx];
+		/* Firmware counter don't support overflow yet */
+		if (!info || info->type == SBI_PMU_CTR_TYPE_FW)
+			continue;
+
+		/* compute hardware counter index */
+		hidx = info->csr - CSR_CYCLE;
+		/* check if the corresponding bit is set in sscountovf */
+		if (!(overflow & (1 << hidx)))
+			continue;
+
+		/*
+		 * Keep a track of overflowed counters so that they can be started
+		 * with updated initial value.
+		 */
+		overflowed_ctrs |= 1 << lidx;
+		hw_evt = &event->hw;
+		riscv_pmu_event_update(event);
+		perf_sample_data_init(&data, 0, hw_evt->last_period);
+		if (riscv_pmu_event_set_period(event)) {
+			/*
+			 * Unlike other ISAs, RISC-V don't have to disable interrupts
+			 * to avoid throttling here. As per the specification, the
+			 * interrupt remains disabled until the OF bit is set.
+			 * Interrupts are enabled again only during the start.
+			 * TODO: We will need to stop the guest counters once
+			 * virtualization support is added.
+			 */
+			perf_event_overflow(event, &data, regs);
+		}
+	}
+	pmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);
+
+	return IRQ_HANDLED;
+}
+
 static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
+	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
 
 	/* Enable the access for TIME csr only from the user mode now */
 	csr_write(CSR_SCOUNTEREN, 0x2);
 
 	/* Stop all the counters so that they can be enabled from perf */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-		  0, GENMASK_ULL(pmu->num_counters - 1, 0), 0, 0, 0, 0);
+	pmu_sbi_stop_all(pmu);
+
+	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
+		hw_events->irq = riscv_pmu_irq;
+		csr_clear(CSR_IP, BIT(RV_IRQ_PMU));
+		csr_set(CSR_IE, BIT(RV_IRQ_PMU));
+		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
+	}
 
 	return 0;
 }
 
 static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 {
+	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
+		disable_percpu_irq(riscv_pmu_irq);
+		csr_clear(CSR_IE, BIT(RV_IRQ_PMU));
+	}
+
 	/* Disable all counters access for user mode now */
 	csr_write(CSR_SCOUNTEREN, 0x0);
 
 	return 0;
 }
 
+static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pdev)
+{
+	int ret;
+	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
+	struct device_node *cpu, *child;
+	struct irq_domain *domain = NULL;
+
+	if (!riscv_isa_extension_available(NULL, SSCOFPMF))
+		return -EOPNOTSUPP;
+
+	for_each_of_cpu_node(cpu) {
+		child = of_get_compatible_child(cpu, "riscv,cpu-intc");
+		if (!child) {
+			pr_err("Failed to find INTC node\n");
+			return -ENODEV;
+		}
+		domain = irq_find_host(child);
+		of_node_put(child);
+		if (domain)
+			break;
+	}
+	if (!domain) {
+		pr_err("Failed to find INTC IRQ root domain\n");
+		return -ENODEV;
+	}
+
+	riscv_pmu_irq = irq_create_mapping(domain, RV_IRQ_PMU);
+	if (!riscv_pmu_irq) {
+		pr_err("Failed to map PMU interrupt for node\n");
+		return -ENODEV;
+	}
+
+	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_handler, "riscv-pmu", hw_events);
+	if (ret) {
+		pr_err("registering percpu irq failed [%d]\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int pmu_sbi_device_probe(struct platform_device *pdev)
 {
 	struct riscv_pmu *pmu = NULL;
 	int num_counters;
-	int ret;
+	int ret = -ENODEV;
 
 	pr_info("SBI PMU extension is available\n");
 	/* Notify legacy implementation that SBI pmu is available*/
@@ -488,13 +684,19 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	num_counters = pmu_sbi_find_num_ctrs();
 	if (num_counters < 0) {
 		pr_err("SBI PMU extension doesn't provide any counters\n");
-		return -ENODEV;
+		goto out_free;
 	}
 
 	/* cache all the information about counters now */
 	if (pmu_sbi_get_ctrinfo(num_counters))
-		return -ENODEV;
+		goto out_free;
 
+	ret = pmu_sbi_setup_irqs(pmu, pdev);
+	if (ret < 0) {
+		pr_info("Perf sampling/filtering is not supported as sscof extension is not available\n");
+		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
+	}
 	pmu->num_counters = num_counters;
 	pmu->ctr_start = pmu_sbi_ctr_start;
 	pmu->ctr_stop = pmu_sbi_ctr_stop;
@@ -515,6 +717,10 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+out_free:
+	kfree(pmu);
+	return ret;
 }
 
 static struct platform_driver pmu_sbi_driver = {
@@ -544,8 +750,6 @@ static int __init pmu_sbi_devinit(void)
 	}
 
 	ret = platform_driver_register(&pmu_sbi_driver);
-	if (ret)
-		return ret;
 
 	pdev = platform_device_register_simple(RISCV_PMU_PDEV_NAME, -1, NULL, 0);
 	if (IS_ERR(pdev)) {
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 52672de540c2..c7e2d689063a 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -29,6 +29,8 @@
 struct cpu_hw_events {
 	/* currently enabled events */
 	int			n_events;
+	/* Counter overflow interrupt */
+	int		irq;
 	/* currently enabled events */
 	struct perf_event	*events[RISCV_MAX_COUNTERS];
 	/* currently enabled counters */
-- 
2.33.1

