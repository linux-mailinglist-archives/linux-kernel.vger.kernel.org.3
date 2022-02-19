Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967E94BC3B1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbiBSAsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:48:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiBSArw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:47:52 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B524E27792B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:47:26 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id x6-20020a4a4106000000b003193022319cso5609888ooa.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nd4vYxhtOAlUcUpptoKmnAI88shl1K2lARFMdYN/LgM=;
        b=NVVK+u+2VjbDv29XdP0Dvb/TIjxLj7ZpRacQuSgFesWinC0Hx+VEtVXW73NItWYsAA
         am3PJZbm9N09vc2km7JE3VACBfixCGDY6wYiAxuzckhQI6dJLNRubzEASRQJ4mhiqqVv
         PnMFsbBGeRPBzLx8rRvCP5Rw5N2yFDR4ebVJ1KLVhPoJq6EuuH4GBCeHRLrxXXe3yv9P
         vrwQbfs0h+c0bVIAm8VGhPUuXekGpknOW6hOvUoq0dAyYpD6Ouv5KKwe3C41RBFPEJqv
         FOuQfzwkK1E+O1hzFA0I6bAE2Ki2D4P1iyWrjrJLJei87P/BXA33sgwULF54A8Ep4Wat
         +bUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nd4vYxhtOAlUcUpptoKmnAI88shl1K2lARFMdYN/LgM=;
        b=GvagdpS/i2rz56oLk+704nLo/Eu0TLvZiWHH/clR+AwWvZ94egq2tVmVB2MIgk0/Ng
         2yeE+LzmwRzt9zlUNSx/UzU1foAmOblunid0z5PP1z0Yj5j7GmqAck242sAzJ7MVbPZH
         0UY6tcoAvvgiSCMI/+++r1qnZZSxhy0r0xdJNuyPim/MB2ts6sl/omJpY+Nk8TldO99s
         +TVek73mJrnrkNC2BQ9AAUbaCrbU+bzXkwT2qDp6A+S2axa9zCBwcTiFGfrqwDKCN1PF
         J4ePsRDmm7eEhQz3+84GpThk4QwSIuwmiImOKRoWb5Ie6WtV/EKZ/4od4xKSZVyueF3T
         GrgQ==
X-Gm-Message-State: AOAM530rGTAdjrjGkLtk9oGZzCeZgOhRqOCs7RxpHBlWEgWauOkKPUMs
        AzwJc2LaotCNAGOL5WeRP288rMziR/gLc36H
X-Google-Smtp-Source: ABdhPJz49tLu9krZGg7hBtKQ/28otwliM6uBgDz2MPXK3bVqvHaUkOBpMGxeOO0JpMAOv/vJdyrM9w==
X-Received: by 2002:a05:6870:1015:b0:ce:c0c9:5d2 with SMTP id 21-20020a056870101500b000cec0c905d2mr5174837oai.36.1645231645708;
        Fri, 18 Feb 2022 16:47:25 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id n11sm11360794oal.1.2022.02.18.16.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:47:25 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [v6 7/9] RISC-V: Add sscofpmf extension support
Date:   Fri, 18 Feb 2022 16:46:58 -0800
Message-Id: <20220219004700.1973682-8-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220219004700.1973682-1-atishp@rivosinc.com>
References: <20220219004700.1973682-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/riscv/kernel/cpu.c        |   1 +
 arch/riscv/kernel/cpufeature.c |   2 +
 drivers/perf/riscv_pmu_sbi.c   | 222 ++++++++++++++++++++++++++++++++-
 include/linux/perf/riscv_pmu.h |   2 +
 6 files changed, 230 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index ce493df11177..8b2e48077731 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -65,6 +65,7 @@
 #define IRQ_S_EXT		9
 #define IRQ_VS_EXT		10
 #define IRQ_M_EXT		11
+#define IRQ_PMU_OVF		13
 
 /* Exception causes */
 #define EXC_INST_MISALIGNED	0
@@ -212,6 +213,8 @@
 #define CSR_HPMCOUNTER30H	0xc9e
 #define CSR_HPMCOUNTER31H	0xc9f
 
+#define CSR_SSCOUNTOVF		0xda0
+
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
 #define CSR_STVEC		0x105
@@ -298,7 +301,10 @@
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
index 691fc9c8099b..0734e42f74f2 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -51,6 +51,7 @@ extern unsigned long elf_hwcap;
  * available logical extension id.
  */
 enum riscv_isa_ext_id {
+	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ced7e5be8641..2b212b10a5a8 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -71,6 +71,7 @@ int riscv_of_parent_hartid(struct device_node *node)
 	}
 
 static struct riscv_isa_ext_data isa_ext_arr[] = {
+	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index cb9c9e0aab31..eabf82ac53ea 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -187,6 +187,8 @@ void __init riscv_fill_hwcap(void)
 			if (!ext_long) {
 				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
 				set_bit(*ext - 'a', this_isa);
+			} else {
+				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
 			}
 #undef SET_ISA_EXT_MAP
 		}
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 815d5c509c64..a1317a483512 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -13,8 +13,13 @@
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
@@ -35,6 +40,7 @@ union sbi_pmu_ctr_info {
  * per_cpu in case of harts with different pmu counters
  */
 static union sbi_pmu_ctr_info *pmu_ctr_list;
+static unsigned int riscv_pmu_irq;
 
 struct sbi_pmu_event_data {
 	union {
@@ -469,33 +475,229 @@ static int pmu_sbi_get_ctrinfo(int nctr)
 	return 0;
 }
 
+static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
+{
+	/**
+	 * No need to check the error because we are disabling all the counters
+	 * which may include counters that are not enabled yet.
+	 */
+	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
+		  0, GENMASK_ULL(pmu->num_counters - 1, 0), 0, 0, 0, 0);
+}
+
+static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
+{
+	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
+
+	/* No need to check the error here as we can't do anything about the error */
+	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
+		  cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
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
+	ctr_start_mask = cpu_hw_evt->used_hw_ctrs[0] & ~ctr_ovf_mask;
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
+	unsigned long overflow;
+	unsigned long overflowed_ctrs = 0;
+	struct cpu_hw_events *cpu_hw_evt = dev;
+
+	if (WARN_ON_ONCE(!cpu_hw_evt))
+		return IRQ_NONE;
+
+	/* Firmware counter don't support overflow yet */
+	fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
+	event = cpu_hw_evt->events[fidx];
+	if (!event) {
+		csr_clear(CSR_SIP, SIP_LCOFIP);
+		return IRQ_NONE;
+	}
+
+	pmu = to_riscv_pmu(event->pmu);
+	pmu_sbi_stop_hw_ctrs(pmu);
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
+	for_each_set_bit(lidx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
+		struct perf_event *event = cpu_hw_evt->events[lidx];
+
+		/* Skip if invalid event or user did not request a sampling */
+		if (!event || !is_sampling_event(event))
+			continue;
+
+		info = &pmu_ctr_list[lidx];
+		/* Do a sanity check */
+		if (!info || info->type != SBI_PMU_CTR_TYPE_HW)
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
+	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
 
 	/* Enable the access for TIME csr only from the user mode now */
 	csr_write(CSR_SCOUNTEREN, 0x2);
 
 	/* Stop all the counters so that they can be enabled from perf */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-		  0, GENMASK_ULL(pmu->num_counters - 1, 0), 0, 0, 0, 0);
+	pmu_sbi_stop_all(pmu);
+
+	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
+		cpu_hw_evt->irq = riscv_pmu_irq;
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
 	pmu = riscv_pmu_alloc();
@@ -505,13 +707,19 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
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
@@ -532,6 +740,10 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+out_free:
+	kfree(pmu);
+	return ret;
 }
 
 static struct platform_driver pmu_sbi_driver = {
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 0f226948c0ca..46f9b6fe306e 100644
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
 	/* currently enabled hardware counters */
-- 
2.30.2

