Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FC157F4DA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 13:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiGXL4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 07:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXL4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 07:56:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DE71758D;
        Sun, 24 Jul 2022 04:56:34 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LrM7J6jNJzGp6J;
        Sun, 24 Jul 2022 19:55:24 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Jul 2022 19:56:32 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Jul
 2022 19:56:31 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <lpieralisi@kernel.org>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jroedel@suse.de>,
        <robin.murphy@arm.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] ACPI/IORT: Fix build error implicit-function-declaration
Date:   Sun, 24 Jul 2022 19:54:23 +0800
Message-ID: <20220724115423.212932-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_ACPI_IORT=y and CONFIG_IOMMU_API is not set,
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-, will be failed, like this:

drivers/acpi/arm64/iort.c: In function ‘iort_get_rmr_sids’:
drivers/acpi/arm64/iort.c:1406:2: error: implicit declaration of function ‘iort_iommu_rmr_get_resv_regions’; did you mean ‘iort_iommu_get_resv_regions’? [-Werror=implicit-function-declaration]
  iort_iommu_rmr_get_resv_regions(iommu_fwnode, NULL, head);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  iort_iommu_get_resv_regions
cc1: some warnings being treated as errors
make[3]: *** [drivers/acpi/arm64/iort.o] Error 1

The function iort_iommu_rmr_get_resv_regions() is declared at #ifdef CONFIG_IOMMU_API area, and the callers of  iort_get_rmr_sids() and iort_put_rmr_sids() would select IOMMU_API.
To fix this error, move the definitions to #ifdef CONFIG_IOMMU_API area.

Fixes: e302eea8f497 ("ACPI/IORT: Add a helper to retrieve RMR info directly")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/acpi/arm64/iort.c | 56 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index cd1349d3544e..ca2aed86b540 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1162,6 +1162,34 @@ void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 	iort_iommu_rmr_get_resv_regions(fwspec->iommu_fwnode, dev, head);
 }
 
+/**
+ * iort_get_rmr_sids - Retrieve IORT RMR node reserved regions with
+ *                     associated StreamIDs information.
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @head: Resereved region list
+ */
+void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *head)
+{
+	iort_iommu_rmr_get_resv_regions(iommu_fwnode, NULL, head);
+}
+EXPORT_SYMBOL_GPL(iort_get_rmr_sids);
+
+/**
+ * iort_put_rmr_sids - Free memory allocated for RMR reserved regions.
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @head: Resereved region list
+ */
+void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *head)
+{
+	struct iommu_resv_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, head, list)
+		entry->free(NULL, entry);
+}
+EXPORT_SYMBOL_GPL(iort_put_rmr_sids);
+
 static inline bool iort_iommu_driver_enabled(u8 type)
 {
 	switch (type) {
@@ -1394,34 +1422,6 @@ int iort_dma_get_ranges(struct device *dev, u64 *size)
 		return nc_dma_get_range(dev, size);
 }
 
-/**
- * iort_get_rmr_sids - Retrieve IORT RMR node reserved regions with
- *                     associated StreamIDs information.
- * @iommu_fwnode: fwnode associated with IOMMU
- * @head: Resereved region list
- */
-void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
-		       struct list_head *head)
-{
-	iort_iommu_rmr_get_resv_regions(iommu_fwnode, NULL, head);
-}
-EXPORT_SYMBOL_GPL(iort_get_rmr_sids);
-
-/**
- * iort_put_rmr_sids - Free memory allocated for RMR reserved regions.
- * @iommu_fwnode: fwnode associated with IOMMU
- * @head: Resereved region list
- */
-void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
-		       struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		entry->free(NULL, entry);
-}
-EXPORT_SYMBOL_GPL(iort_put_rmr_sids);
-
 static void __init acpi_iort_register_irq(int hwirq, const char *name,
 					  int trigger,
 					  struct resource *res)
-- 
2.17.1

