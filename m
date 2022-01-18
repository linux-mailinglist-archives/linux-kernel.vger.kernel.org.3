Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B5049247F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbiARLRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:17:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiARLRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:17:52 -0500
Date:   Tue, 18 Jan 2022 11:17:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642504670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpz27nfKACYRUaIYip2+IdJ6LpoPtBsrfT14g5rL/0w=;
        b=kHy2O5jtoehScTssy/QpZx3YdEbNbxWa1PfdN+hJsxGKN2XS2wXuz5gQz8G1ZRhIdCzf/g
        FOeYZ4XtoIPeqj3l67xBDjU3TyhUaPS8TZFN8oNNo/fL4cs0K70tnJD8vXmbx+VLw0Y1Kw
        nU0hjsFUSTInSidfbNiaWGjCr+gt6O8lbfYO688nUDYUjFpXp4YP/i+ICv2dgyDkVG5dRq
        MY95wGEbKgJ/tk/jxqcRtCjwz5/WKOVHj65V6FbrCT9vJIr62IVu0VOkrBpwtz9p0jyDRi
        V1QeiTrKGDoRAPVyY6HWN8hd/74CpTEGrXk8qXUMTpGFw022cE1/DjeSYHp7sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642504670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpz27nfKACYRUaIYip2+IdJ6LpoPtBsrfT14g5rL/0w=;
        b=lwhE1ahzA5D2px5WSBnqfYUYOM6GOdH4RQDgbEuNrXtENpzw1zdo4iDMtpDB+82MXaJNYP
        0mBRjGXwzgB8YpAg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Add IMC uncore support for ADL
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1642111554-118524-1-git-send-email-kan.liang@linux.intel.com>
References: <1642111554-118524-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164250466988.16921.3231510959947282979.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5a4487f9ef5ef2fdb3215cadf0a9c3e5e8678634
Gitweb:        https://git.kernel.org/tip/5a4487f9ef5ef2fdb3215cadf0a9c3e5e8678634
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 13 Jan 2022 14:05:54 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Jan 2022 12:09:49 +01:00

perf/x86/intel/uncore: Add IMC uncore support for ADL

Current ADL uncore code only supports the legacy IMC (memory controller)
free-running counters. Besides the free-running counters, ADL also
supports several general purpose-counters.

The general-purpose counters can also be accessed via MMIO but in a
different location. Factor out __uncore_imc_init_box() with offset as a
parameter. The function can be shared between ADL and TGL.

The event format and the layout of the control registers are a little
bit different from other uncore counters.

The intel_generic_uncore_mmio_enable_event() can be shared with client
IMC uncore. Expose the function.

Add more PCI IDs for ADL machines.

Fixes: 772ed05f3c5c ("perf/x86/intel/uncore: Add Alder Lake support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1642111554-118524-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c           |   2 +-
 arch/x86/events/intel/uncore.h           |   3 +-
 arch/x86/events/intel/uncore_discovery.c |   4 +-
 arch/x86/events/intel/uncore_discovery.h |   2 +-
 arch/x86/events/intel/uncore_snb.c       | 214 +++++++++++++++++++++-
 5 files changed, 220 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index f1ba6ab..e497da9 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1762,7 +1762,7 @@ static const struct intel_uncore_init_fun rkl_uncore_init __initconst = {
 
 static const struct intel_uncore_init_fun adl_uncore_init __initconst = {
 	.cpu_init = adl_uncore_cpu_init,
-	.mmio_init = tgl_uncore_mmio_init,
+	.mmio_init = adl_uncore_mmio_init,
 };
 
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index b968798..2adeaf4 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -584,10 +584,11 @@ void snb_uncore_cpu_init(void);
 void nhm_uncore_cpu_init(void);
 void skl_uncore_cpu_init(void);
 void icl_uncore_cpu_init(void);
-void adl_uncore_cpu_init(void);
 void tgl_uncore_cpu_init(void);
+void adl_uncore_cpu_init(void);
 void tgl_uncore_mmio_init(void);
 void tgl_l_uncore_mmio_init(void);
+void adl_uncore_mmio_init(void);
 int snb_pci2phy_map_init(int devid);
 
 /* uncore_snbep.c */
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 3049c64..6ddadb4 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -494,8 +494,8 @@ void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box)
 	writel(0, box->io_addr);
 }
 
-static void intel_generic_uncore_mmio_enable_event(struct intel_uncore_box *box,
-					     struct perf_event *event)
+void intel_generic_uncore_mmio_enable_event(struct intel_uncore_box *box,
+					    struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 6d73561..cfaf558 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -139,6 +139,8 @@ void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box);
 void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box);
 void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
 					     struct perf_event *event);
+void intel_generic_uncore_mmio_enable_event(struct intel_uncore_box *box,
+					    struct perf_event *event);
 
 void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box);
 void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box);
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 0f63706..f698a55 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Nehalem/SandBridge/Haswell/Broadwell/Skylake uncore support */
 #include "uncore.h"
+#include "uncore_discovery.h"
 
 /* Uncore IMC PCI IDs */
 #define PCI_DEVICE_ID_INTEL_SNB_IMC		0x0100
@@ -64,6 +65,20 @@
 #define PCI_DEVICE_ID_INTEL_RKL_2_IMC		0x4c53
 #define PCI_DEVICE_ID_INTEL_ADL_1_IMC		0x4660
 #define PCI_DEVICE_ID_INTEL_ADL_2_IMC		0x4641
+#define PCI_DEVICE_ID_INTEL_ADL_3_IMC		0x4601
+#define PCI_DEVICE_ID_INTEL_ADL_4_IMC		0x4602
+#define PCI_DEVICE_ID_INTEL_ADL_5_IMC		0x4609
+#define PCI_DEVICE_ID_INTEL_ADL_6_IMC		0x460a
+#define PCI_DEVICE_ID_INTEL_ADL_7_IMC		0x4621
+#define PCI_DEVICE_ID_INTEL_ADL_8_IMC		0x4623
+#define PCI_DEVICE_ID_INTEL_ADL_9_IMC		0x4629
+#define PCI_DEVICE_ID_INTEL_ADL_10_IMC		0x4637
+#define PCI_DEVICE_ID_INTEL_ADL_11_IMC		0x463b
+#define PCI_DEVICE_ID_INTEL_ADL_12_IMC		0x4648
+#define PCI_DEVICE_ID_INTEL_ADL_13_IMC		0x4649
+#define PCI_DEVICE_ID_INTEL_ADL_14_IMC		0x4650
+#define PCI_DEVICE_ID_INTEL_ADL_15_IMC		0x4668
+#define PCI_DEVICE_ID_INTEL_ADL_16_IMC		0x4670
 
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
@@ -155,6 +170,7 @@
 
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
+DEFINE_UNCORE_FORMAT_ATTR(chmask, chmask, "config:8-11");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
 DEFINE_UNCORE_FORMAT_ATTR(cmask5, cmask, "config:24-28");
@@ -1334,6 +1350,62 @@ static const struct pci_device_id tgl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_2_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_4_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_5_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_6_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_7_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_8_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_9_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_10_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_11_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_12_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_13_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_14_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_15_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_16_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ }
 };
 
@@ -1390,7 +1462,8 @@ static struct pci_dev *tgl_uncore_get_mc_dev(void)
 #define TGL_UNCORE_MMIO_IMC_MEM_OFFSET		0x10000
 #define TGL_UNCORE_PCI_IMC_MAP_SIZE		0xe000
 
-static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
+static void __uncore_imc_init_box(struct intel_uncore_box *box,
+				  unsigned int base_offset)
 {
 	struct pci_dev *pdev = tgl_uncore_get_mc_dev();
 	struct intel_uncore_pmu *pmu = box->pmu;
@@ -1417,11 +1490,17 @@ static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 	addr |= ((resource_size_t)mch_bar << 32);
 #endif
 
+	addr += base_offset;
 	box->io_addr = ioremap(addr, type->mmio_map_size);
 	if (!box->io_addr)
 		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
 }
 
+static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
+{
+	__uncore_imc_init_box(box, 0);
+}
+
 static struct intel_uncore_ops tgl_uncore_imc_freerunning_ops = {
 	.init_box	= tgl_uncore_imc_freerunning_init_box,
 	.exit_box	= uncore_mmio_exit_box,
@@ -1469,3 +1548,136 @@ void tgl_uncore_mmio_init(void)
 }
 
 /* end of Tiger Lake MMIO uncore support */
+
+/* Alder Lake MMIO uncore support */
+#define ADL_UNCORE_IMC_BASE			0xd900
+#define ADL_UNCORE_IMC_MAP_SIZE			0x200
+#define ADL_UNCORE_IMC_CTR			0xe8
+#define ADL_UNCORE_IMC_CTRL			0xd0
+#define ADL_UNCORE_IMC_GLOBAL_CTL		0xc0
+#define ADL_UNCORE_IMC_BOX_CTL			0xc4
+#define ADL_UNCORE_IMC_FREERUNNING_BASE		0xd800
+#define ADL_UNCORE_IMC_FREERUNNING_MAP_SIZE	0x100
+
+#define ADL_UNCORE_IMC_CTL_FRZ			(1 << 0)
+#define ADL_UNCORE_IMC_CTL_RST_CTRL		(1 << 1)
+#define ADL_UNCORE_IMC_CTL_RST_CTRS		(1 << 2)
+#define ADL_UNCORE_IMC_CTL_INT			(ADL_UNCORE_IMC_CTL_RST_CTRL | \
+						ADL_UNCORE_IMC_CTL_RST_CTRS)
+
+static void adl_uncore_imc_init_box(struct intel_uncore_box *box)
+{
+	__uncore_imc_init_box(box, ADL_UNCORE_IMC_BASE);
+
+	/* The global control in MC1 can control both MCs. */
+	if (box->io_addr && (box->pmu->pmu_idx == 1))
+		writel(ADL_UNCORE_IMC_CTL_INT, box->io_addr + ADL_UNCORE_IMC_GLOBAL_CTL);
+}
+
+static void adl_uncore_mmio_disable_box(struct intel_uncore_box *box)
+{
+	if (!box->io_addr)
+		return;
+
+	writel(ADL_UNCORE_IMC_CTL_FRZ, box->io_addr + uncore_mmio_box_ctl(box));
+}
+
+static void adl_uncore_mmio_enable_box(struct intel_uncore_box *box)
+{
+	if (!box->io_addr)
+		return;
+
+	writel(0, box->io_addr + uncore_mmio_box_ctl(box));
+}
+
+static struct intel_uncore_ops adl_uncore_mmio_ops = {
+	.init_box	= adl_uncore_imc_init_box,
+	.exit_box	= uncore_mmio_exit_box,
+	.disable_box	= adl_uncore_mmio_disable_box,
+	.enable_box	= adl_uncore_mmio_enable_box,
+	.disable_event	= intel_generic_uncore_mmio_disable_event,
+	.enable_event	= intel_generic_uncore_mmio_enable_event,
+	.read_counter	= uncore_mmio_read_counter,
+};
+
+#define ADL_UNC_CTL_CHMASK_MASK			0x00000f00
+#define ADL_UNC_IMC_EVENT_MASK			(SNB_UNC_CTL_EV_SEL_MASK | \
+						 ADL_UNC_CTL_CHMASK_MASK | \
+						 SNB_UNC_CTL_EDGE_DET)
+
+static struct attribute *adl_uncore_imc_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_chmask.attr,
+	&format_attr_edge.attr,
+	NULL,
+};
+
+static const struct attribute_group adl_uncore_imc_format_group = {
+	.name		= "format",
+	.attrs		= adl_uncore_imc_formats_attr,
+};
+
+static struct intel_uncore_type adl_uncore_imc = {
+	.name		= "imc",
+	.num_counters   = 5,
+	.num_boxes	= 2,
+	.perf_ctr_bits	= 64,
+	.perf_ctr	= ADL_UNCORE_IMC_CTR,
+	.event_ctl	= ADL_UNCORE_IMC_CTRL,
+	.event_mask	= ADL_UNC_IMC_EVENT_MASK,
+	.box_ctl	= ADL_UNCORE_IMC_BOX_CTL,
+	.mmio_offset	= 0,
+	.mmio_map_size	= ADL_UNCORE_IMC_MAP_SIZE,
+	.ops		= &adl_uncore_mmio_ops,
+	.format_group	= &adl_uncore_imc_format_group,
+};
+
+enum perf_adl_uncore_imc_freerunning_types {
+	ADL_MMIO_UNCORE_IMC_DATA_TOTAL,
+	ADL_MMIO_UNCORE_IMC_DATA_READ,
+	ADL_MMIO_UNCORE_IMC_DATA_WRITE,
+	ADL_MMIO_UNCORE_IMC_FREERUNNING_TYPE_MAX
+};
+
+static struct freerunning_counters adl_uncore_imc_freerunning[] = {
+	[ADL_MMIO_UNCORE_IMC_DATA_TOTAL]	= { 0x40, 0x0, 0x0, 1, 64 },
+	[ADL_MMIO_UNCORE_IMC_DATA_READ]		= { 0x58, 0x0, 0x0, 1, 64 },
+	[ADL_MMIO_UNCORE_IMC_DATA_WRITE]	= { 0xA0, 0x0, 0x0, 1, 64 },
+};
+
+static void adl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
+{
+	__uncore_imc_init_box(box, ADL_UNCORE_IMC_FREERUNNING_BASE);
+}
+
+static struct intel_uncore_ops adl_uncore_imc_freerunning_ops = {
+	.init_box	= adl_uncore_imc_freerunning_init_box,
+	.exit_box	= uncore_mmio_exit_box,
+	.read_counter	= uncore_mmio_read_counter,
+	.hw_config	= uncore_freerunning_hw_config,
+};
+
+static struct intel_uncore_type adl_uncore_imc_free_running = {
+	.name			= "imc_free_running",
+	.num_counters		= 3,
+	.num_boxes		= 2,
+	.num_freerunning_types	= ADL_MMIO_UNCORE_IMC_FREERUNNING_TYPE_MAX,
+	.mmio_map_size		= ADL_UNCORE_IMC_FREERUNNING_MAP_SIZE,
+	.freerunning		= adl_uncore_imc_freerunning,
+	.ops			= &adl_uncore_imc_freerunning_ops,
+	.event_descs		= tgl_uncore_imc_events,
+	.format_group		= &tgl_uncore_imc_format_group,
+};
+
+static struct intel_uncore_type *adl_mmio_uncores[] = {
+	&adl_uncore_imc,
+	&adl_uncore_imc_free_running,
+	NULL
+};
+
+void adl_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = adl_mmio_uncores;
+}
+
+/* end of Alder Lake MMIO uncore support */
