Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74453580A09
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 05:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiGZDio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 23:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiGZDik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:38:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EFD25E88;
        Mon, 25 Jul 2022 20:38:39 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LsMyG2YyMzkXTs;
        Tue, 26 Jul 2022 11:36:06 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 11:38:12 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Jul
 2022 11:38:12 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <lpieralisi@kernel.org>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jroedel@suse.de>,
        <robin.murphy@arm.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH v2 -next] ACPI/IORT: Fix build error implicit-function-declaration
Date:   Tue, 26 Jul 2022 11:35:20 +0800
Message-ID: <20220726033520.47865-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-,
will be failed, like this:

drivers/acpi/arm64/iort.c: In function ‘iort_get_rmr_sids’:
drivers/acpi/arm64/iort.c:1406:2: error: implicit declaration of function ‘iort_iommu_rmr_get_resv_regions’; did you mean ‘iort_iommu_get_resv_regions’? [-Werror=implicit-function-declaration]
  iort_iommu_rmr_get_resv_regions(iommu_fwnode, NULL, head);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  iort_iommu_get_resv_regions
cc1: some warnings being treated as errors
make[3]: *** [drivers/acpi/arm64/iort.o] Error 1

The function iort_iommu_rmr_get_resv_regions()
is declared under CONFIG_IOMMU_API, 
and the callers of iort_get_rmr_sids() and iort_put_rmr_sids()
would select IOMMU_API.

To fix this error, move the definitions to #ifdef CONFIG_IOMMU_API.

Fixes: e302eea8f497 ("ACPI/IORT: Add a helper to retrieve RMR info directly")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
Changes in v2:
 - change commit message to a max of 75 chars per line.

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

