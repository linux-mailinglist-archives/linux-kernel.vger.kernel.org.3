Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5AB5A6E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiH3URY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiH3UQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:16:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FC080EAC;
        Tue, 30 Aug 2022 13:16:17 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UJRRgh030586;
        Tue, 30 Aug 2022 20:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hWncNBBXEg57C/dgyYJZl0wv0Sf+9IyEHPf5gDc/olc=;
 b=ej3UGaBdZ4RwDL+HeSgwefkU2XmbSRaF0ubh2XzCxxBkwhFczs76324VUEn8RAxbQkd8
 APQHecs6sMdK1t2yUHNZxxRcOjESnRMYgO9/pbCzjbVddK5CF6ASxAlpVfDxHUMDZ1hP
 h60q/R4U4CwrC/2VCxSfi7oRQxFd5ONcoinZMDfWUqGWVbrYacFju/5GjfaVtQvHT9MA
 fq9ZR44+gy/WWIlKqD/5bgvE6pa4KzGqRTfrMirGiJfaPvaui0FCDYt9D0E4zNh3LwYO
 ybRjFJD4Ogboov62RyVn8rgLTcg84T6w7QkDHt9qutZ4EwTLjIdO4dh3BmW8Nxh2FhzT UA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9rqdhcy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 20:15:51 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27UK65tf000322;
        Tue, 30 Aug 2022 20:15:50 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3j7aw9kfjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 20:15:50 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27UKFnlL12583582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 20:15:49 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7118B136051;
        Tue, 30 Aug 2022 20:15:48 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22EE513604F;
        Tue, 30 Aug 2022 20:15:46 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.65.252.121])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 20:15:46 +0000 (GMT)
From:   Matthew Rosato <mjrosato@linux.ibm.com>
To:     iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] iommu/s390: Fix race with release_device ops
Date:   Tue, 30 Aug 2022 16:15:46 -0400
Message-Id: <20220830201546.18871-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K4heIS3r9LviJa3oN6_m1dKbopwgrCiy
X-Proofpoint-ORIG-GUID: K4heIS3r9LviJa3oN6_m1dKbopwgrCiy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
calls") s390-iommu is supposed to handle dynamic switching between IOMMU
domains and the DMA API handling.  However, this commit does not
sufficiently handle the case where the device is released via a call
to the release_device op as it may occur at the same time as an opposing
attach_dev or detach_dev since the group mutex is not held over
release_device.  This was observed if the device is deconfigured during a
small window during vfio-pci initialization and can result in WARNs and
potential kernel panics.

Handle this by tracking when the device is probed/released via
dev_iommu_priv_set/get().  Ensure that once the device is released only
release_device handles the re-init of the device DMA.

Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
Changes since v2:
- Relocate the list_empty and aperture chekcs in attach_dev to the
  their original locations so they are all done under a single
  acquisition of the spinlock (Heiko)
---
 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         |  1 +
 drivers/iommu/s390-iommu.c  | 39 ++++++++++++++++++++++++++++++++++---
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 7b4cdadbc023..080251e7b275 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -157,6 +157,7 @@ struct zpci_dev {
 	/* DMA stuff */
 	unsigned long	*dma_table;
 	spinlock_t	dma_table_lock;
+	struct mutex	dma_domain_lock; /* protects s390_domain value */
 	int		tlb_refresh;
 
 	spinlock_t	iommu_bitmap_lock;
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 73cdc5539384..973edd32ecc9 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -832,6 +832,7 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
 	kref_init(&zdev->kref);
 	mutex_init(&zdev->lock);
 	mutex_init(&zdev->kzdev_lock);
+	mutex_init(&zdev->dma_domain_lock);
 
 	rc = zpci_init_iommu(zdev);
 	if (rc)
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index c898bcbbce11..1137d669e849 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -99,6 +99,14 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	if (!domain_device)
 		return -ENOMEM;
 
+	/* Leave now if the device has already been released */
+	mutex_lock(&zdev->dma_domain_lock);
+	if (!dev_iommu_priv_get(dev)) {
+		mutex_unlock(&zdev->dma_domain_lock);
+		kfree(domain_device);
+		return 0;
+	}
+
 	if (zdev->dma_table && !zdev->s390_domain) {
 		cc = zpci_dma_exit_device(zdev);
 		if (cc) {
@@ -132,9 +140,10 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 		goto out_restore;
 	}
 	domain_device->zdev = zdev;
-	zdev->s390_domain = s390_domain;
 	list_add(&domain_device->list, &s390_domain->devices);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+	zdev->s390_domain = s390_domain;
+	mutex_unlock(&zdev->dma_domain_lock);
 
 	return 0;
 
@@ -147,6 +156,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 				   virt_to_phys(zdev->dma_table));
 	}
 out_free:
+	mutex_unlock(&zdev->dma_domain_lock);
 	kfree(domain_device);
 
 	return rc;
@@ -176,17 +186,22 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 	}
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
-	if (found && (zdev->s390_domain == s390_domain)) {
+	mutex_lock(&zdev->dma_domain_lock);
+	if (found && (zdev->s390_domain == s390_domain) &&
+	    dev_iommu_priv_get(dev)) {
 		zdev->s390_domain = NULL;
 		zpci_unregister_ioat(zdev, 0);
 		zpci_dma_init_device(zdev);
 	}
+	mutex_unlock(&zdev->dma_domain_lock);
 }
 
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 {
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 
+	dev_iommu_priv_set(dev, zdev);
+
 	return &zdev->iommu_dev;
 }
 
@@ -206,10 +221,28 @@ static void s390_iommu_release_device(struct device *dev)
 	 *
 	 * So let's call detach_dev from here if it hasn't been called before.
 	 */
-	if (zdev && zdev->s390_domain) {
+	if (zdev) {
+		/*
+		 * Clear priv to block further attaches for this device,
+		 * ensure detaches don't init DMA.  Hold the domain lock
+		 * to ensure that attach/detach get a consistent view of
+		 * whether or not the device is released.
+		 */
+		mutex_lock(&zdev->dma_domain_lock);
+		dev_iommu_priv_set(dev, NULL);
+		mutex_unlock(&zdev->dma_domain_lock);
+		/* Make sure this device is removed from the domain list */
 		domain = iommu_get_domain_for_dev(dev);
 		if (domain)
 			s390_iommu_detach_device(domain, dev);
+		/* Now ensure DMA is initialized from here */
+		mutex_lock(&zdev->dma_domain_lock);
+		if (zdev->s390_domain) {
+			zdev->s390_domain = NULL;
+			zpci_unregister_ioat(zdev, 0);
+			zpci_dma_init_device(zdev);
+		}
+		mutex_unlock(&zdev->dma_domain_lock);
 	}
 }
 
-- 
2.37.2

