Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFC64B58A2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357140AbiBNRfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:35:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357095AbiBNRfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:35:09 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9DA65420
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:34:59 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JyB7v1KYzz67drY;
        Tue, 15 Feb 2022 01:30:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 18:34:57 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 17:34:54 +0000
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <hch@lst.de>,
        <chenxiang66@hisilicon.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v5 3/5] iommu: Allow iommu_change_dev_def_domain() realloc same default domain type
Date:   Tue, 15 Feb 2022 01:29:04 +0800
Message-ID: <1644859746-20279-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1644859746-20279-1-git-send-email-john.garry@huawei.com>
References: <1644859746-20279-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow iommu_change_dev_def_domain() to create a new default domain, keeping
the same as current.

Also remove comment about the function purpose, which will become stale.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iommu.c | 49 ++++++++++++++++++++++---------------------
 include/linux/iommu.h |  1 +
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5e7ed969b870..df9ffd76c184 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3124,6 +3124,7 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
 
+
 /*
  * Changes the default domain of an iommu group that has *only* one device
  *
@@ -3134,10 +3135,6 @@ EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
  *
  * Returns 0 on success and error code on failure
  *
- * Note:
- * 1. Presently, this function is called only when user requests to change the
- *    group's default domain type through /sys/kernel/iommu_groups/<grp_id>/type
- *    Please take a closer look if intended to use for other purposes.
  */
 static int iommu_change_dev_def_domain(struct iommu_group *group,
 				       struct device *prev_dev, int type)
@@ -3190,28 +3187,32 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 		goto out;
 	}
 
-	dev_def_dom = iommu_get_def_domain_type(dev);
-	if (!type) {
+	if (type == __IOMMU_DOMAIN_SAME) {
+		type = prev_dom->type;
+	} else {
+		dev_def_dom = iommu_get_def_domain_type(dev);
+		if (!type) {
+			/*
+			 * If the user hasn't requested any specific type of domain and
+			 * if the device supports both the domains, then default to the
+			 * domain the device was booted with
+			 */
+			type = dev_def_dom ? : iommu_def_domain_type;
+		} else if (dev_def_dom && type != dev_def_dom) {
+			dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
+					    iommu_domain_type_str(type));
+			ret = -EINVAL;
+			goto out;
+		}
+
 		/*
-		 * If the user hasn't requested any specific type of domain and
-		 * if the device supports both the domains, then default to the
-		 * domain the device was booted with
+		 * Switch to a new domain only if the requested domain type is different
+		 * from the existing default domain type
 		 */
-		type = dev_def_dom ? : iommu_def_domain_type;
-	} else if (dev_def_dom && type != dev_def_dom) {
-		dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
-				    iommu_domain_type_str(type));
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/*
-	 * Switch to a new domain only if the requested domain type is different
-	 * from the existing default domain type
-	 */
-	if (prev_dom->type == type) {
-		ret = 0;
-		goto out;
+		if (prev_dom->type == type) {
+			ret = 0;
+			goto out;
+		}
 	}
 
 	/* We can bring up a flush queue without tearing down the domain */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index de0c57a567c8..d242fccc7c2d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -62,6 +62,7 @@ struct iommu_domain_geometry {
 					      implementation              */
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
 #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
+#define __IOMMU_DOMAIN_SAME	(1U << 4)  /* Keep same type (internal)   */
 
 /*
  * This are the possible domain-types
-- 
2.26.2

