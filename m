Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057A6499458
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 21:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389171AbiAXUkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:40:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58660 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381304AbiAXUUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:20:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 790D3B8122D;
        Mon, 24 Jan 2022 20:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4310C340E8;
        Mon, 24 Jan 2022 20:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643055602;
        bh=IOrzP7AZQZvXLCOiOi008mSBOlUIwceqknphO08hNss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9p9wTpKRQZyIKOxNxeLo9FVtT8eHJhsC+GC6TKHlZoVtX++cSqbkiCWhoLQ9ZbBd
         /fdhYV3T1bKowvJW9KZSRgWH+MXzL0wmGG2kxxku/Apr26HTpSbD0+XhCHa6fA7GBn
         LtFd5dQ/a8seiA6T993ih5649GJyyXowPRFaSS57e6CeWafWrfemAmo6y/J+9nUUbH
         DhJGgAUXZArE9ZCbvn8eyZt2s+cVuffxo452yhXegggrJ73Tt13Sits/Y6DWfE/p4A
         JMRBWrDevj9f2A4mG8XUhbVlKmazgUZduKdLiNdReLnfiKagz5J6OhDQHbwST6Vu9z
         cwaoQxKmkxaZQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nC5hf-002Y3f-Ay; Mon, 24 Jan 2022 20:12:39 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
Subject: [PATCH v4 10/10] drivers/perf: Add Apple icestorm/firestorm CPU PMU driver
Date:   Mon, 24 Jan 2022 20:12:31 +0000
Message-Id: <20220124201231.298961-11-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124201231.298961-1-maz@kernel.org>
References: <20220124201231.298961-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new, weird and wonderful driver for the equally weird Apple
PMU HW. Although the PMU itself is functional, we don't know much
about the events yet, so this can be considered as yet another
random number generator...

Nonetheless, it can reliably count at least cycles and instructions
in the usually wonky big-little way. For anything else, it of course
supports raw event numbers.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/apple_m1_pmu.h |  45 ++
 drivers/perf/Kconfig                  |   7 +
 drivers/perf/Makefile                 |   1 +
 drivers/perf/apple_m1_cpu_pmu.c       | 584 ++++++++++++++++++++++++++
 4 files changed, 637 insertions(+)
 create mode 100644 drivers/perf/apple_m1_cpu_pmu.c

diff --git a/arch/arm64/include/asm/apple_m1_pmu.h b/arch/arm64/include/asm/apple_m1_pmu.h
index b848af7faadc..99483b19b99f 100644
--- a/arch/arm64/include/asm/apple_m1_pmu.h
+++ b/arch/arm64/include/asm/apple_m1_pmu.h
@@ -6,8 +6,21 @@
 #include <linux/bits.h>
 #include <asm/sysreg.h>
 
+/* Counters */
+#define SYS_IMP_APL_PMC0_EL1	sys_reg(3, 2, 15, 0, 0)
+#define SYS_IMP_APL_PMC1_EL1	sys_reg(3, 2, 15, 1, 0)
+#define SYS_IMP_APL_PMC2_EL1	sys_reg(3, 2, 15, 2, 0)
+#define SYS_IMP_APL_PMC3_EL1	sys_reg(3, 2, 15, 3, 0)
+#define SYS_IMP_APL_PMC4_EL1	sys_reg(3, 2, 15, 4, 0)
+#define SYS_IMP_APL_PMC5_EL1	sys_reg(3, 2, 15, 5, 0)
+#define SYS_IMP_APL_PMC6_EL1	sys_reg(3, 2, 15, 6, 0)
+#define SYS_IMP_APL_PMC7_EL1	sys_reg(3, 2, 15, 7, 0)
+#define SYS_IMP_APL_PMC8_EL1	sys_reg(3, 2, 15, 9, 0)
+#define SYS_IMP_APL_PMC9_EL1	sys_reg(3, 2, 15, 10, 0)
+
 /* Core PMC control register */
 #define SYS_IMP_APL_PMCR0_EL1	sys_reg(3, 1, 15, 0, 0)
+#define PMCR0_CNT_ENABLE_0_7	GENMASK(7, 0)
 #define PMCR0_IMODE		GENMASK(10, 8)
 #define PMCR0_IMODE_OFF		0
 #define PMCR0_IMODE_PMI		1
@@ -15,5 +28,37 @@
 #define PMCR0_IMODE_HALT	3
 #define PMCR0_IMODE_FIQ		4
 #define PMCR0_IACT		BIT(11)
+#define PMCR0_PMI_ENABLE_0_7	GENMASK(19, 12)
+#define PMCR0_STOP_CNT_ON_PMI	BIT(20)
+#define PMCR0_CNT_GLOB_L2C_EVT	BIT(21)
+#define PMCR0_DEFER_PMI_TO_ERET	BIT(22)
+#define PMCR0_ALLOW_CNT_EN_EL0	BIT(30)
+#define PMCR0_CNT_ENABLE_8_9	GENMASK(33, 32)
+#define PMCR0_PMI_ENABLE_8_9	GENMASK(45, 44)
+
+#define SYS_IMP_APL_PMCR1_EL1	sys_reg(3, 1, 15, 1, 0)
+#define PMCR1_COUNT_A64_EL0_0_7	GENMASK(15, 8)
+#define PMCR1_COUNT_A64_EL1_0_7	GENMASK(23, 16)
+#define PMCR1_COUNT_A64_EL0_8_9	GENMASK(41, 40)
+#define PMCR1_COUNT_A64_EL1_8_9	GENMASK(49, 48)
+
+#define SYS_IMP_APL_PMCR2_EL1	sys_reg(3, 1, 15, 2, 0)
+#define SYS_IMP_APL_PMCR3_EL1	sys_reg(3, 1, 15, 3, 0)
+#define SYS_IMP_APL_PMCR4_EL1	sys_reg(3, 1, 15, 4, 0)
+
+#define SYS_IMP_APL_PMESR0_EL1	sys_reg(3, 1, 15, 5, 0)
+#define PMESR0_EVT_CNT_2	GENMASK(7, 0)
+#define PMESR0_EVT_CNT_3	GENMASK(15, 8)
+#define PMESR0_EVT_CNT_4	GENMASK(23, 16)
+#define PMESR0_EVT_CNT_5	GENMASK(31, 24)
+
+#define SYS_IMP_APL_PMESR1_EL1	sys_reg(3, 1, 15, 6, 0)
+#define PMESR1_EVT_CNT_6	GENMASK(7, 0)
+#define PMESR1_EVT_CNT_7	GENMASK(15, 8)
+#define PMESR1_EVT_CNT_8	GENMASK(23, 16)
+#define PMESR1_EVT_CNT_9	GENMASK(31, 24)
+
+#define SYS_IMP_APL_PMSR_EL1	sys_reg(3, 1, 15, 13, 0)
+#define PMSR_OVERFLOW		GENMASK(9, 0)
 
 #endif /* __ASM_APPLE_M1_PMU_h */
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index e1a0c44bc686..d4fa0dabb05f 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -146,6 +146,13 @@ config MARVELL_CN10K_TAD_PMU
 	  Provides support for Last-Level cache Tag-and-data Units (LLC-TAD)
 	  performance monitors on CN10K family silicons.
 
+config APPLE_M1_CPU_PMU
+	bool "Apple M1 CPU PMU support"
+	depends on ARM_PMU && ARCH_APPLE
+	help
+	  Provides support for the non-architectural CPU PMUs present on
+	  the Apple M1 SoCs and derivatives.
+
 source "drivers/perf/hisilicon/Kconfig"
 
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 2db5418d5b0a..21ad0832e3d4 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
 obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
+obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
new file mode 100644
index 000000000000..979a7c2b4f56
--- /dev/null
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -0,0 +1,584 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CPU PMU driver for the Apple M1 and derivatives
+ *
+ * Copyright (C) 2021 Google LLC
+ *
+ * Author: Marc Zyngier <maz@kernel.org>
+ *
+ * Most of the information used in this driver was provided by the
+ * Asahi Linux project. The rest was experimentally discovered.
+ */
+
+#include <linux/of.h>
+#include <linux/perf/arm_pmu.h>
+#include <linux/platform_device.h>
+
+#include <asm/apple_m1_pmu.h>
+#include <asm/irq_regs.h>
+#include <asm/perf_event.h>
+
+#define M1_PMU_NR_COUNTERS		10
+
+#define M1_PMU_CFG_EVENT		GENMASK(7, 0)
+
+#define ANY_BUT_0_1			GENMASK(9, 2)
+#define ONLY_2_TO_7			GENMASK(7, 2)
+#define ONLY_2_4_6			(BIT(2) | BIT(4) | BIT(6))
+#define ONLY_5_6_7			(BIT(5) | BIT(6) | BIT(7))
+
+/*
+ * Description of the events we actually know about, as well as those with
+ * a specific counter affinity. Yes, this is a grand total of two known
+ * counters, and the rest is anybody's guess.
+ *
+ * Not all counters can count all events. Counters #0 and #1 are wired to
+ * count cycles and instructions respectively, and some events have
+ * bizarre mappings (every other counter, or even *one* counter). These
+ * restrictions equally apply to both P and E cores.
+ *
+ * It is worth noting that the PMUs attached to P and E cores are likely
+ * to be different because the underlying uarches are different. At the
+ * moment, we don't really need to distinguish between the two because we
+ * know next to nothing about the events themselves, and we already have
+ * per cpu-type PMU abstractions.
+ *
+ * If we eventually find out that the events are different across
+ * implementations, we'll have to introduce per cpu-type tables.
+ */
+enum m1_pmu_events {
+	M1_PMU_PERFCTR_UNKNOWN_01	= 0x01,
+	M1_PMU_PERFCTR_CPU_CYCLES	= 0x02,
+	M1_PMU_PERFCTR_INSTRUCTIONS	= 0x8c,
+	M1_PMU_PERFCTR_UNKNOWN_8d	= 0x8d,
+	M1_PMU_PERFCTR_UNKNOWN_8e	= 0x8e,
+	M1_PMU_PERFCTR_UNKNOWN_8f	= 0x8f,
+	M1_PMU_PERFCTR_UNKNOWN_90	= 0x90,
+	M1_PMU_PERFCTR_UNKNOWN_93	= 0x93,
+	M1_PMU_PERFCTR_UNKNOWN_94	= 0x94,
+	M1_PMU_PERFCTR_UNKNOWN_95	= 0x95,
+	M1_PMU_PERFCTR_UNKNOWN_96	= 0x96,
+	M1_PMU_PERFCTR_UNKNOWN_97	= 0x97,
+	M1_PMU_PERFCTR_UNKNOWN_98	= 0x98,
+	M1_PMU_PERFCTR_UNKNOWN_99	= 0x99,
+	M1_PMU_PERFCTR_UNKNOWN_9a	= 0x9a,
+	M1_PMU_PERFCTR_UNKNOWN_9b	= 0x9b,
+	M1_PMU_PERFCTR_UNKNOWN_9c	= 0x9c,
+	M1_PMU_PERFCTR_UNKNOWN_9f	= 0x9f,
+	M1_PMU_PERFCTR_UNKNOWN_bf	= 0xbf,
+	M1_PMU_PERFCTR_UNKNOWN_c0	= 0xc0,
+	M1_PMU_PERFCTR_UNKNOWN_c1	= 0xc1,
+	M1_PMU_PERFCTR_UNKNOWN_c4	= 0xc4,
+	M1_PMU_PERFCTR_UNKNOWN_c5	= 0xc5,
+	M1_PMU_PERFCTR_UNKNOWN_c6	= 0xc6,
+	M1_PMU_PERFCTR_UNKNOWN_c8	= 0xc8,
+	M1_PMU_PERFCTR_UNKNOWN_ca	= 0xca,
+	M1_PMU_PERFCTR_UNKNOWN_cb	= 0xcb,
+	M1_PMU_PERFCTR_UNKNOWN_f5	= 0xf5,
+	M1_PMU_PERFCTR_UNKNOWN_f6	= 0xf6,
+	M1_PMU_PERFCTR_UNKNOWN_f7	= 0xf7,
+	M1_PMU_PERFCTR_UNKNOWN_f8	= 0xf8,
+	M1_PMU_PERFCTR_UNKNOWN_fd	= 0xfd,
+	M1_PMU_PERFCTR_LAST		= M1_PMU_CFG_EVENT,
+
+	/*
+	 * From this point onwards, these are not actual HW events,
+	 * but attributes that get stored in hw->config_base.
+	 */
+	M1_PMU_CFG_COUNT_USER		= BIT(8),
+	M1_PMU_CFG_COUNT_KERNEL		= BIT(9),
+};
+
+/*
+ * Per-event affinity table. Most events can be installed on counter
+ * 2-9, but there are a number of exceptions. Note that this table
+ * has been created experimentally, and I wouldn't be surprised if more
+ * counters had strange affinities.
+ */
+static const u16 m1_pmu_event_affinity[M1_PMU_PERFCTR_LAST + 1] = {
+	[0 ... M1_PMU_PERFCTR_LAST]	= ANY_BUT_0_1,
+	[M1_PMU_PERFCTR_UNKNOWN_01]	= BIT(7),
+	[M1_PMU_PERFCTR_CPU_CYCLES]	= ANY_BUT_0_1 | BIT(0),
+	[M1_PMU_PERFCTR_INSTRUCTIONS]	= BIT(7) | BIT(1),
+	[M1_PMU_PERFCTR_UNKNOWN_8d]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_8e]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_8f]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_90]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_93]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_94]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_95]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_96]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_97]	= BIT(7),
+	[M1_PMU_PERFCTR_UNKNOWN_98]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_99]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_9a]	= BIT(7),
+	[M1_PMU_PERFCTR_UNKNOWN_9b]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_9c]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_9f]	= BIT(7),
+	[M1_PMU_PERFCTR_UNKNOWN_bf]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_c0]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_c1]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_c4]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_c5]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_c6]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_c8]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_ca]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_cb]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_f5]	= ONLY_2_4_6,
+	[M1_PMU_PERFCTR_UNKNOWN_f6]	= ONLY_2_4_6,
+	[M1_PMU_PERFCTR_UNKNOWN_f7]	= ONLY_2_4_6,
+	[M1_PMU_PERFCTR_UNKNOWN_f8]	= ONLY_2_TO_7,
+	[M1_PMU_PERFCTR_UNKNOWN_fd]	= ONLY_2_4_6,
+};
+
+static const unsigned m1_pmu_perf_map[PERF_COUNT_HW_MAX] = {
+	PERF_MAP_ALL_UNSUPPORTED,
+	[PERF_COUNT_HW_CPU_CYCLES]	= M1_PMU_PERFCTR_CPU_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS]	= M1_PMU_PERFCTR_INSTRUCTIONS,
+	/* No idea about the rest yet */
+};
+
+/* sysfs definitions */
+static ssize_t m1_pmu_events_sysfs_show(struct device *dev,
+					struct device_attribute *attr,
+					char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(page, "event=0x%04llx\n", pmu_attr->id);
+}
+
+#define M1_PMU_EVENT_ATTR(name, config)					\
+	PMU_EVENT_ATTR_ID(name, m1_pmu_events_sysfs_show, config)
+
+static struct attribute *m1_pmu_event_attrs[] = {
+	M1_PMU_EVENT_ATTR(cycles, M1_PMU_PERFCTR_CPU_CYCLES),
+	M1_PMU_EVENT_ATTR(instructions, M1_PMU_PERFCTR_INSTRUCTIONS),
+	NULL,
+};
+
+static const struct attribute_group m1_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = m1_pmu_event_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-7");
+
+static struct attribute *m1_pmu_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static const struct attribute_group m1_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = m1_pmu_format_attrs,
+};
+
+/* Low level accessors. No synchronisation. */
+#define PMU_READ_COUNTER(_idx)						\
+	case _idx:	return read_sysreg_s(SYS_IMP_APL_PMC## _idx ##_EL1)
+
+#define PMU_WRITE_COUNTER(_val, _idx)					\
+	case _idx:							\
+		write_sysreg_s(_val, SYS_IMP_APL_PMC## _idx ##_EL1);	\
+		return
+
+static u64 m1_pmu_read_hw_counter(unsigned int index)
+{
+	switch (index) {
+		PMU_READ_COUNTER(0);
+		PMU_READ_COUNTER(1);
+		PMU_READ_COUNTER(2);
+		PMU_READ_COUNTER(3);
+		PMU_READ_COUNTER(4);
+		PMU_READ_COUNTER(5);
+		PMU_READ_COUNTER(6);
+		PMU_READ_COUNTER(7);
+		PMU_READ_COUNTER(8);
+		PMU_READ_COUNTER(9);
+	}
+
+	BUG();
+}
+
+static void m1_pmu_write_hw_counter(u64 val, unsigned int index)
+{
+	switch (index) {
+		PMU_WRITE_COUNTER(val, 0);
+		PMU_WRITE_COUNTER(val, 1);
+		PMU_WRITE_COUNTER(val, 2);
+		PMU_WRITE_COUNTER(val, 3);
+		PMU_WRITE_COUNTER(val, 4);
+		PMU_WRITE_COUNTER(val, 5);
+		PMU_WRITE_COUNTER(val, 6);
+		PMU_WRITE_COUNTER(val, 7);
+		PMU_WRITE_COUNTER(val, 8);
+		PMU_WRITE_COUNTER(val, 9);
+	}
+
+	BUG();
+}
+
+#define get_bit_offset(index, mask)	(__ffs(mask) + (index))
+
+static void __m1_pmu_enable_counter(unsigned int index, bool en)
+{
+	u64 val, bit;
+
+	switch (index) {
+	case 0 ... 7:
+		bit = BIT(get_bit_offset(index, PMCR0_CNT_ENABLE_0_7));
+		break;
+	case 8 ... 9:
+		bit = BIT(get_bit_offset(index - 8, PMCR0_CNT_ENABLE_8_9));
+		break;
+	default:
+		BUG();
+	}
+
+	val = read_sysreg_s(SYS_IMP_APL_PMCR0_EL1);
+
+	if (en)
+		val |= bit;
+	else
+		val &= ~bit;
+
+	write_sysreg_s(val, SYS_IMP_APL_PMCR0_EL1);
+}
+
+static void m1_pmu_enable_counter(unsigned int index)
+{
+	__m1_pmu_enable_counter(index, true);
+}
+
+static void m1_pmu_disable_counter(unsigned int index)
+{
+	__m1_pmu_enable_counter(index, false);
+}
+
+static void __m1_pmu_enable_counter_interrupt(unsigned int index, bool en)
+{
+	u64 val, bit;
+
+	switch (index) {
+	case 0 ... 7:
+		bit = BIT(get_bit_offset(index, PMCR0_PMI_ENABLE_0_7));
+		break;
+	case 8 ... 9:
+		bit = BIT(get_bit_offset(index - 8, PMCR0_PMI_ENABLE_8_9));
+		break;
+	default:
+		BUG();
+	}
+
+	val = read_sysreg_s(SYS_IMP_APL_PMCR0_EL1);
+
+	if (en)
+		val |= bit;
+	else
+		val &= ~bit;
+
+	write_sysreg_s(val, SYS_IMP_APL_PMCR0_EL1);
+}
+
+static void m1_pmu_enable_counter_interrupt(unsigned int index)
+{
+	__m1_pmu_enable_counter_interrupt(index, true);
+}
+
+static void m1_pmu_disable_counter_interrupt(unsigned int index)
+{
+	__m1_pmu_enable_counter_interrupt(index, false);
+}
+
+static void m1_pmu_configure_counter(unsigned int index, u8 event,
+				     bool user, bool kernel)
+{
+	u64 val, user_bit, kernel_bit;
+	int shift;
+
+	switch (index) {
+	case 0 ... 7:
+		user_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL0_0_7));
+		kernel_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL1_0_7));
+		break;
+	case 8 ... 9:
+		user_bit = BIT(get_bit_offset(index - 8, PMCR1_COUNT_A64_EL0_8_9));
+		kernel_bit = BIT(get_bit_offset(index - 8, PMCR1_COUNT_A64_EL1_8_9));
+		break;
+	default:
+		BUG();
+	}
+
+	val = read_sysreg_s(SYS_IMP_APL_PMCR1_EL1);
+
+	if (user)
+		val |= user_bit;
+	else
+		val &= ~user_bit;
+
+	if (kernel)
+		val |= kernel_bit;
+	else
+		val &= ~kernel_bit;
+
+	write_sysreg_s(val, SYS_IMP_APL_PMCR1_EL1);
+
+	/*
+	 * Counters 0 and 1 have fixed events. For anything else,
+	 * place the event at the expected location in the relevant
+	 * register (PMESR0 holds the event configuration for counters
+	 * 2-5, resp. PMESR1 for counters 6-9).
+	 */
+	switch (index) {
+	case 0 ... 1:
+		break;
+	case 2 ... 5:
+		shift = (index - 2) * 8;
+		val = read_sysreg_s(SYS_IMP_APL_PMESR0_EL1);
+		val &= ~((u64)0xff << shift);
+		val |= (u64)event << shift;
+		write_sysreg_s(val, SYS_IMP_APL_PMESR0_EL1);
+		break;
+	case 6 ... 9:
+		shift = (index - 6) * 8;
+		val = read_sysreg_s(SYS_IMP_APL_PMESR1_EL1);
+		val &= ~((u64)0xff << shift);
+		val |= (u64)event << shift;
+		write_sysreg_s(val, SYS_IMP_APL_PMESR1_EL1);
+		break;
+	}
+}
+
+/* arm_pmu backend */
+static void m1_pmu_enable_event(struct perf_event *event)
+{
+	bool user, kernel;
+	u8 evt;
+
+	evt = event->hw.config_base & M1_PMU_CFG_EVENT;
+	user = event->hw.config_base & M1_PMU_CFG_COUNT_USER;
+	kernel = event->hw.config_base & M1_PMU_CFG_COUNT_KERNEL;
+
+	m1_pmu_disable_counter_interrupt(event->hw.idx);
+	m1_pmu_disable_counter(event->hw.idx);
+	isb();
+
+	m1_pmu_configure_counter(event->hw.idx, evt, user, kernel);
+	m1_pmu_enable_counter(event->hw.idx);
+	m1_pmu_enable_counter_interrupt(event->hw.idx);
+	isb();
+}
+
+static void m1_pmu_disable_event(struct perf_event *event)
+{
+	m1_pmu_disable_counter_interrupt(event->hw.idx);
+	m1_pmu_disable_counter(event->hw.idx);
+	isb();
+}
+
+static irqreturn_t m1_pmu_handle_irq(struct arm_pmu *cpu_pmu)
+{
+	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
+	struct pt_regs *regs;
+	u64 overflow, state;
+	int idx;
+
+	overflow = read_sysreg_s(SYS_IMP_APL_PMSR_EL1);
+	if (!overflow) {
+		/* Spurious interrupt? */
+		state = read_sysreg_s(SYS_IMP_APL_PMCR0_EL1);
+		state &= ~PMCR0_IACT;
+		write_sysreg_s(state, SYS_IMP_APL_PMCR0_EL1);
+		isb();
+		return IRQ_NONE;
+	}
+
+	cpu_pmu->stop(cpu_pmu);
+
+	regs = get_irq_regs();
+
+	for (idx = 0; idx < cpu_pmu->num_events; idx++) {
+		struct perf_event *event = cpuc->events[idx];
+		struct perf_sample_data data;
+
+		if (!event)
+			continue;
+
+		armpmu_event_update(event);
+		perf_sample_data_init(&data, 0, event->hw.last_period);
+		if (!armpmu_event_set_period(event))
+			continue;
+
+		if (perf_event_overflow(event, &data, regs))
+			m1_pmu_disable_event(event);
+	}
+
+	cpu_pmu->start(cpu_pmu);
+
+	return IRQ_HANDLED;
+}
+
+static u64 m1_pmu_read_counter(struct perf_event *event)
+{
+	return m1_pmu_read_hw_counter(event->hw.idx);
+}
+
+static void m1_pmu_write_counter(struct perf_event *event, u64 value)
+{
+	m1_pmu_write_hw_counter(value, event->hw.idx);
+	isb();
+}
+
+static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	unsigned long evtype = event->hw.config_base & M1_PMU_CFG_EVENT;
+	unsigned long affinity = m1_pmu_event_affinity[evtype];
+	int idx;
+
+	/*
+	 * Place the event on the first free counter that can count
+	 * this event.
+	 *
+	 * We could do a better job if we had a view of all the events
+	 * counting on the PMU at any given time, and by placing the
+	 * most constraining events first.
+	 */
+	for_each_set_bit(idx, &affinity, M1_PMU_NR_COUNTERS) {
+		if (!test_and_set_bit(idx, cpuc->used_mask))
+			return idx;
+	}
+
+	return -EAGAIN;
+}
+
+static void m1_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
+				   struct perf_event *event)
+{
+	clear_bit(event->hw.idx, cpuc->used_mask);
+}
+
+static void __m1_pmu_set_mode(u8 mode)
+{
+	u64 val;
+
+	val = read_sysreg_s(SYS_IMP_APL_PMCR0_EL1);
+	val &= ~(PMCR0_IMODE | PMCR0_IACT);
+	val |= FIELD_PREP(PMCR0_IMODE, mode);
+	write_sysreg_s(val, SYS_IMP_APL_PMCR0_EL1);
+	isb();
+}
+
+static void m1_pmu_start(struct arm_pmu *cpu_pmu)
+{
+	__m1_pmu_set_mode(PMCR0_IMODE_FIQ);
+}
+
+static void m1_pmu_stop(struct arm_pmu *cpu_pmu)
+{
+	__m1_pmu_set_mode(PMCR0_IMODE_OFF);
+}
+
+static int m1_pmu_map_event(struct perf_event *event)
+{
+	/*
+	 * Although the counters are 48bit wide, bit 47 is what
+	 * triggers the overflow interrupt. Advertise the counters
+	 * being 47bit wide to mimick the behaviour of the ARM PMU.
+	 */
+	event->hw.flags |= ARMPMU_EVT_47BIT;
+	return armpmu_map_event(event, &m1_pmu_perf_map, NULL, M1_PMU_CFG_EVENT);
+}
+
+static void m1_pmu_reset(void *info)
+{
+	int i;
+
+	__m1_pmu_set_mode(PMCR0_IMODE_OFF);
+
+	for (i = 0; i < M1_PMU_NR_COUNTERS; i++) {
+		m1_pmu_disable_counter(i);
+		m1_pmu_disable_counter_interrupt(i);
+		m1_pmu_write_hw_counter(0, i);
+	}
+
+	isb();
+}
+
+static int m1_pmu_set_event_filter(struct hw_perf_event *event,
+				   struct perf_event_attr *attr)
+{
+	unsigned long config_base = 0;
+
+	if (!attr->exclude_guest)
+		return -EINVAL;
+	if (!attr->exclude_kernel)
+		config_base |= M1_PMU_CFG_COUNT_KERNEL;
+	if (!attr->exclude_user)
+		config_base |= M1_PMU_CFG_COUNT_USER;
+
+	event->config_base = config_base;
+
+	return 0;
+}
+
+static int m1_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->handle_irq	  = m1_pmu_handle_irq;
+	cpu_pmu->enable		  = m1_pmu_enable_event;
+	cpu_pmu->disable	  = m1_pmu_disable_event;
+	cpu_pmu->read_counter	  = m1_pmu_read_counter;
+	cpu_pmu->write_counter	  = m1_pmu_write_counter;
+	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
+	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
+	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->stop		  = m1_pmu_stop;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
+
+	cpu_pmu->num_events	  = M1_PMU_NR_COUNTERS;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
+	return 0;
+}
+
+/* Device driver gunk */
+static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_icestorm_pmu";
+	return m1_pmu_init(cpu_pmu);
+}
+
+static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_firestorm_pmu";
+	return m1_pmu_init(cpu_pmu);
+}
+
+static const struct of_device_id m1_pmu_of_device_ids[] = {
+	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
+	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, m1_pmu_of_device_ids);
+
+static int m1_pmu_device_probe(struct platform_device *pdev)
+{
+	return arm_pmu_device_probe(pdev, m1_pmu_of_device_ids, NULL);
+}
+
+static struct platform_driver m1_pmu_driver = {
+	.driver		= {
+		.name			= "apple-m1-cpu-pmu",
+		.of_match_table		= m1_pmu_of_device_ids,
+		.suppress_bind_attrs	= true,
+	},
+	.probe		= m1_pmu_device_probe,
+};
+
+module_platform_driver(m1_pmu_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.30.2

