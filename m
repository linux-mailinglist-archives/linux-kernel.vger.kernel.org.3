Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37325912B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbiHLPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiHLPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:13:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2151A5705;
        Fri, 12 Aug 2022 08:13:18 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M46ck19TVz68778;
        Fri, 12 Aug 2022 23:13:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 12 Aug 2022 17:13:17 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 16:13:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <john.garry@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 2/4] cxl/pci: Find and register CXL PMU devices
Date:   Fri, 12 Aug 2022 16:12:12 +0100
Message-ID: <20220812151214.2025-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220812151214.2025-1-Jonathan.Cameron@huawei.com>
References: <20220812151214.2025-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CXL PMU devices can be found from entries in the Register
Locator DVSEC.

In order to register the minimum number of IRQ vectors necessary
to support all CPMUs found, separate the registration into two
steps.  First find the devices, and query the IRQs used and then
register the devices. Between these two steps, request the
IRQ vectors necessary and enable bus master support.

Future IRQ users for CXL type 3 devices (e.g. DOEs) will need to
follow a similar pattern the number of vectors necessary is known
before any parts of the driver stack rely on their availability.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---

Open questions
1) Is this IRQ vector 'count' / request then use approach flexible
   enough for other interrupt users on these devices.
2) Does hanging the CPMU off the PCI device make sense. These can
   occur in Switch upstream ports as well.
3) Naming.  It would be nice if the device naming indicated which
   EP these were associated with, but that wouldn't be inline
   with the rest of the CXL bus device naming.  What is best
   option here?
---
 drivers/cxl/core/Makefile |  1 +
 drivers/cxl/core/core.h   |  3 ++
 drivers/cxl/core/cpmu.c   | 67 ++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c   |  2 ++
 drivers/cxl/core/regs.c   | 29 +++++++++++++++
 drivers/cxl/cpmu.h        | 54 ++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         | 15 ++++++++
 drivers/cxl/cxlpci.h      |  1 +
 drivers/cxl/pci.c         | 76 ++++++++++++++++++++++++++++++++++++++-
 9 files changed, 247 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 79c7257f4107..1318e8a6830f 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -10,4 +10,5 @@ cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
+cxl_core-y += cpmu.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1d8f87be283f..d2b12cdfd61f 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -14,12 +14,14 @@ extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
+extern const struct device_type cxl_cpmu_type;
 extern const struct device_type cxl_region_type;
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
 #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
 #define CXL_REGION_TYPE(x) (&cxl_region_type)
 #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
 #define CXL_PMEM_REGION_TYPE(x) (&cxl_pmem_region_type)
+#define CXL_CPMU_TYPE(x) (&cxl_cpmu_region_type)
 int cxl_region_init(void);
 void cxl_region_exit(void);
 #else
@@ -37,6 +39,7 @@ static inline void cxl_region_exit(void)
 #define CXL_REGION_TYPE(x) NULL
 #define SET_CXL_REGION_ATTR(x)
 #define CXL_PMEM_REGION_TYPE(x) NULL
+#define CXL_CPMU_TYPE(x) NULL
 #endif
 
 struct cxl_send_command;
diff --git a/drivers/cxl/core/cpmu.c b/drivers/cxl/core/cpmu.c
new file mode 100644
index 000000000000..2d17d4083c8f
--- /dev/null
+++ b/drivers/cxl/core/cpmu.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Huawei. All rights reserved. */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <cpmu.h>
+#include <cxl.h>
+
+static DEFINE_IDA(cpmu_ida);
+
+static void cxl_cpmu_release(struct device *dev)
+{
+	struct cxl_cpmu *cpmu = container_of(dev, struct cxl_cpmu, dev);
+
+	ida_free(&cpmu_ida, cpmu->id);
+	kfree(cpmu);
+}
+
+const struct device_type cxl_cpmu_type = {
+	.name = "cxl_cpmu",
+	.release = cxl_cpmu_release,
+};
+
+static void remove_dev(void *dev)
+{
+	device_del(dev);
+}
+
+int devm_cxl_cpmu_add(struct device *parent, struct cxl_cpmu_regs *regs, int index)
+{
+	struct cxl_cpmu *cpmu;
+	struct device *dev;
+	int rc;
+
+	cpmu = kzalloc(sizeof(*cpmu), GFP_KERNEL);
+	if (!cpmu)
+		return -ENOMEM;
+
+	cpmu->base = regs->cpmu;
+	dev = &cpmu->dev;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = parent;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_cpmu_type;
+	rc = ida_alloc(&cpmu_ida, GFP_KERNEL);
+	if (rc < 0)
+		goto err;
+	cpmu->id = rc;
+
+	rc = dev_set_name(dev, "cpmu%d", cpmu->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	return devm_add_action_or_reset(parent, remove_dev, dev);
+
+err:
+	put_device(&cpmu->dev);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_cpmu_add, CXL);
+
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1629c7a4033f..66bde8e2edb8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -55,6 +55,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_MEMORY_EXPANDER;
 	if (dev->type == CXL_REGION_TYPE())
 		return CXL_DEVICE_REGION;
+	if (dev->type == &cxl_cpmu_type)
+		return CXL_DEVICE_CPMU;
 	return 0;
 }
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 2f651211d120..1ba1a77ecbf1 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
+#include <cpmu.h>
 
 /**
  * DOC: cxl registers
@@ -331,3 +332,31 @@ int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, CXL);
 
+int cxl_map_cpmu_regs(struct pci_dev *pdev,
+		      struct cxl_cpmu_regs *regs,
+		      struct cxl_register_map *map)
+{
+	struct device *dev = &pdev->dev;
+	resource_size_t phys_addr;
+
+	phys_addr = pci_resource_start(pdev, map->barno) + map->block_offset;
+	regs->cpmu = devm_cxl_iomap_block(dev, phys_addr, CPMU_REGMAP_SIZE);
+	if (!regs->cpmu)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_map_cpmu_regs, CXL);
+
+int cxl_cpmu_get_irq(struct cxl_cpmu_regs *regs)
+{
+	int irq = -1;
+	u64 val;
+
+	val = readq(regs->cpmu + CPMU_CAP_REG);
+	if (FIELD_GET(CPMU_CAP_INT, val))
+		irq = FIELD_GET(CPMU_CAP_MSI_N_MSK, val);
+
+	return irq;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cpmu_get_irq, CXL);
diff --git a/drivers/cxl/cpmu.h b/drivers/cxl/cpmu.h
new file mode 100644
index 000000000000..880077bf0b9f
--- /dev/null
+++ b/drivers/cxl/cpmu.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright(c) 2022 Huawei
+ * CXL Specification rev 3.0 Setion 8.2.7 (CPMU Register Interface)
+ */
+#ifndef CXL_CPMU_H
+#define CXL_CPMU_H
+
+#define CPMU_CAP_REG			0x0
+#define   CPMU_CAP_NUM_COUNTERS_MSK		GENMASK_ULL(4, 0)
+#define   CPMU_CAP_COUNTER_WIDTH_MSK		GENMASK_ULL(15, 8)
+#define   CPMU_CAP_NUM_EVN_CAP_REG_SUP_MSK	GENMASK_ULL(24, 20)
+#define   CPMU_CAP_FILTERS_SUP_MSK		GENMASK_ULL(39, 32)
+#define   CPMU_CAP_MSI_N_MSK			GENMASK_ULL(47, 44)
+#define   CPMU_CAP_WRITEABLE_WHEN_FROZEN	BIT(48)
+#define   CPMU_CAP_FREEZE			BIT(49)
+#define   CPMU_CAP_INT				BIT(50)
+#define   CPMU_CAP_VERSION_MSK			GENMASK_ULL(63, 60)
+
+#define CPMU_OVERFLOW_REG		0x10
+#define CPMU_FREEZE_REG			0x18
+#define CPMU_EVENT_CAP_REG(n)		(0x100 + 8 * (n))
+#define   CPMU_EVENT_CAP_SUPPORTED_EVENTS_MSK	GENMASK_ULL(31, 0)
+#define   CPMU_EVENT_CAP_GROUP_ID_MSK		GENMASK_ULL(47, 32)
+#define   CPMU_EVENT_CAP_VENDOR_ID_MSK		GENMASK_ULL(63, 48)
+
+#define CPMU_COUNTER_CFG_REG(n)		(0x200 + 8 * (n))
+#define   CPMU_COUNTER_CFG_TYPE_MSK		GENMASK_ULL(1, 0)
+#define     CPMU_COUNTER_CFG_TYPE_FREE_RUN	0
+#define     CPMU_COUNTER_CFG_TYPE_FIXED_FUN	1
+#define     CPMU_COUNTER_CFG_TYPE_CONFIGURABLE	2
+#define   CPMU_COUNTER_CFG_ENABLE		BIT(8)
+#define   CPMU_COUNTER_CFG_INT_ON_OVRFLW	BIT(9)
+#define   CPMU_COUNTER_CFG_FREEZE_ON_OVRFLW	BIT(10)
+#define   CPMU_COUNTER_CFG_EDGE			BIT(11)
+#define   CPMU_COUNTER_CFG_INVERT		BIT(12)
+#define   CPMU_COUNTER_CFG_THRESHOLD_MSK	GENMASK_ULL(23, 16)
+#define   CPMU_COUNTER_CFG_EVENTS_MSK		GENMASK_ULL(55, 24)
+#define   CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK	GENMASK_ULL(63, 59)
+
+#define CPMU_FILTER_CFG_REG(n, f)	(0x400 + 4 * ((f) + (n) * 8))
+#define   CPMU_FILTER_CFG_VALUE_MSK		GENMASK(15, 0)
+
+#define CPMU_COUNTER_REG(n)			(0xc00 + 8 * (n))
+
+#define CPMU_REGMAP_SIZE 0xe00 /* Table 8-32 CXL 3.0 specification */
+struct cxl_cpmu {
+	struct device dev;
+	void __iomem *base;
+	int id;
+};
+
+#define to_cxl_cpmu(dev) container_of(dev, struct cxl_cpmu, dev)
+#endif
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5a1bcdbda654..2768e1677e2b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -166,6 +166,10 @@ struct cxl_regs {
 	struct_group_tagged(cxl_device_regs, device_regs,
 		void __iomem *status, *mbox, *memdev;
 	);
+
+	struct_group_tagged(cxl_cpmu_regs, cpmu_regs,
+		void __iomem *cpmu;
+	);
 };
 
 struct cxl_reg_map {
@@ -184,6 +188,10 @@ struct cxl_device_reg_map {
 	struct cxl_reg_map memdev;
 };
 
+struct cxl_cpmu_reg_map {
+	struct cxl_reg_map cpmu;
+};
+
 /**
  * struct cxl_register_map - DVSEC harvested register block mapping parameters
  * @base: virtual base of the register-block-BAR + @block_offset
@@ -201,6 +209,7 @@ struct cxl_register_map {
 	union {
 		struct cxl_component_reg_map component_map;
 		struct cxl_device_reg_map device_map;
+		struct cxl_cpmu_reg_map cpmu_map;
 	};
 };
 
@@ -219,6 +228,10 @@ enum cxl_regloc_type;
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map, int index);
+int cxl_map_cpmu_regs(struct pci_dev *pdev,
+		      struct cxl_cpmu_regs *regs,
+		      struct cxl_register_map *map);
+int cxl_cpmu_get_irq(struct cxl_cpmu_regs *regs);
 void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length);
 
@@ -626,6 +639,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_MEMORY_EXPANDER	5
 #define CXL_DEVICE_REGION		6
 #define CXL_DEVICE_PMEM_REGION		7
+#define CXL_DEVICE_CPMU			8
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
@@ -653,6 +667,7 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 }
 #endif
 
+int devm_cxl_cpmu_add(struct device *parent, struct cxl_cpmu_regs *regs, int idx);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index eec597dbe763..a842c3d1341a 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -59,6 +59,7 @@ enum cxl_regloc_type {
 	CXL_REGLOC_RBI_COMPONENT,
 	CXL_REGLOC_RBI_VIRT,
 	CXL_REGLOC_RBI_MEMDEV,
+	CXL_REGLOC_RBI_CPMU,
 	CXL_REGLOC_RBI_TYPES
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1758380247ec..e1276fdc8609 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -428,12 +428,39 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
 	}
 }
 
+static void cxl_pci_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
+static int cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds, int vectors)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int rc;
+
+	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
+				   PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (rc < 0)
+		return rc;
+	if (rc != vectors) {
+		pci_err(pdev, "Not enough interrupts; use polling where supported\n");
+		/* Some got allocated; clean them up */
+		cxl_pci_free_irq_vectors(pdev);
+		return -ENOSPC;
+	}
+
+	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct cxl_cpmu_regs *cpmu_regs_array = NULL;
 	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dev_state *cxlds;
-	int rc;
+	int i, rc, cpmu_count;
+	int max_interrupt = -1;
 
 	/*
 	 * Double check the anonymous union trickery in struct cxl_regs
@@ -494,6 +521,53 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	/*
+	 * Before registering sub devices that use interrupts, the maximum
+	 * interrupt used on the device should be established to allow the correct
+	 * number of irq vectors to be requested. Separate the registration process
+	 * into before / after interrupt vector request.
+	 */
+	cpmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_CPMU);
+	if (cpmu_count) {
+		cpmu_regs_array = kmalloc_array(cpmu_count, sizeof(cpmu_regs_array),
+						GFP_KERNEL);
+		if (!cpmu_regs_array)
+			return -ENOMEM;
+	}
+	/* Pass one - just enough to find out what interrupts are used */
+	for (i = 0; i < cpmu_count; i++) {
+		int irq;
+
+		rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_CPMU, &map, i);
+		if (rc) {
+			kfree(cpmu_regs_array);
+			return rc;
+		}
+
+		rc = cxl_map_cpmu_regs(pdev, &cpmu_regs_array[i], &map);
+		if (rc) {
+			kfree(cpmu_regs_array);
+			return rc;
+		}
+
+		irq = cxl_cpmu_get_irq(&cpmu_regs_array[i]);
+		max_interrupt = max(max_interrupt, irq);
+	}
+
+	if (max_interrupt >= 0) {
+		pci_set_master(pdev);
+		rc = cxl_alloc_irq_vectors(cxlds, max_interrupt + 1);
+		if (rc) {
+			kfree(cpmu_regs_array);
+			return rc;
+		}
+	}
+
+	/* Pass 2 - register the CPMU instances */
+	for (i = 0; i < cpmu_count; i++)
+		devm_cxl_cpmu_add(cxlds->dev, &cpmu_regs_array[i], i);
+	kfree(cpmu_regs_array);
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
-- 
2.32.0

