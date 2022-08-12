Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ECB5912AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbiHLPMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238719AbiHLPMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:12:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C34FA50EB;
        Fri, 12 Aug 2022 08:12:48 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M46Vv6bPTz67bNK;
        Fri, 12 Aug 2022 23:08:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 17:12:46 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 16:12:45 +0100
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
Subject: [RFC PATCH 1/4] cxl: Add function to count regblocks of a given type.
Date:   Fri, 12 Aug 2022 16:12:11 +0100
Message-ID: <20220812151214.2025-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220812151214.2025-1-Jonathan.Cameron@huawei.com>
References: <20220812151214.2025-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

Until the recently release CXL 3.0 specification, there
was only ever one instance of any given register block pointed
to by the Register Block Locator DVSEC. Now, the specification allows
for multiple CXL PMU instances, each with their own register block.

To enable this add an index parameter to cxl_find_regblock()
and use that to implement cxl_count_regblock().

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c  |  2 +-
 drivers/cxl/core/port.c |  2 +-
 drivers/cxl/core/regs.c | 35 ++++++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h       |  3 ++-
 drivers/cxl/pci.c       |  2 +-
 5 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9240df53ed87..f29cdc9df330 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -49,7 +49,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 				  &lnkcap))
 		return 0;
 
-	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map, 0);
 	if (rc)
 		dev_dbg(&port->dev, "failed to find component registers\n");
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index bffde862de0b..1629c7a4033f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1235,7 +1235,7 @@ static resource_size_t find_component_registers(struct device *dev)
 
 	pdev = to_pci_dev(dev);
 
-	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map, 0);
 	return cxl_regmap_to_base(pdev, &map);
 }
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 39a129c57d40..2f651211d120 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -262,6 +262,7 @@ static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
  * @pdev: The CXL PCI device to enumerate.
  * @type: Register Block Indicator id
  * @map: Enumeration output, clobbered on error
+ * @index: Index into which particular instance of a regblock we want.
  *
  * Return: 0 if register block enumerated, negative error code otherwise
  *
@@ -269,9 +270,10 @@ static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
  * by @type.
  */
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-		      struct cxl_register_map *map)
+		      struct cxl_register_map *map, int index)
 {
 	u32 regloc_size, regblocks;
+	int instance = 0;
 	int regloc, i;
 
 	map->block_offset = U64_MAX;
@@ -294,11 +296,38 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 
 		cxl_decode_regblock(reg_lo, reg_hi, map);
 
-		if (map->reg_type == type)
-			return 0;
+		if (map->reg_type == type) {
+			if (index == instance)
+				return 0;
+			instance++;
+		}
 	}
 
 	map->block_offset = U64_MAX;
 	return -ENODEV;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
+
+/**
+ * cxl_count_regblock() - Count instances of a given regblock type.
+ * @pdev: The CXL PCI device to enumerate.
+ * @type: Register Block Indicator id
+ *
+ * Some regblocks may be repeated. Count how many instances.
+ *
+ * Return: count of matching regblocks.
+ */
+int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
+{
+	struct cxl_register_map map;
+	int rc, count = 0;
+
+	while (1) {
+		rc = cxl_find_regblock(pdev, type, &map, count);
+		if (rc)
+			return count;
+		count++;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, CXL);
+
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..5a1bcdbda654 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -216,8 +216,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 			struct cxl_register_map *map);
 
 enum cxl_regloc_type;
+int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-		      struct cxl_register_map *map);
+		      struct cxl_register_map *map, int index);
 void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length);
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faeb5d9d7a7a..1758380247ec 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -373,7 +373,7 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 {
 	int rc;
 
-	rc = cxl_find_regblock(pdev, type, map);
+	rc = cxl_find_regblock(pdev, type, map, 0);
 	if (rc)
 		return rc;
 
-- 
2.32.0

