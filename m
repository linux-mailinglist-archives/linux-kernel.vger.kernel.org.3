Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D7559ED8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiHWUlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiHWUlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:41:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF316167;
        Tue, 23 Aug 2022 13:31:28 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NK0GOI001294;
        Tue, 23 Aug 2022 20:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=FKM60fJlGLKRdC+rmbAw7ksKrcnJg6/pKQyfM89661M=;
 b=L2TJtD9+Y17MBCHX17GjAc1lExJqTdD4I3BE3RrlzwH8XwEbY0XeKhc6/DbDhheMpTb7
 x/zqHLt2fs/e+bzUdaS0W67ITi0Me/jg65nzcSnV0Ydj6d59icxR8tyyvqD041reDpHJ
 nm4DxxTXIFTG51rhPF5EDcNIkRTUi1rd/BIn5rkRlTqYegPSjYr1kti2nA6m/uQBjabq
 lF/iLmx/lxFR7dQpzeie5tVzUTsrEV5EPO6/xygs7eJXtRlV0LnFcd/W+0YZmzmb0aEi
 ayWnc9zFX6nY32fWn4bLl9CYFAM27ncWheoievfRuykhcCwj0X4QzCuW1hhqcNafRF1p EA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j55j315tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 20:31:07 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27NKKC7D014375;
        Tue, 23 Aug 2022 20:31:06 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 3j2q8a56mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 20:31:06 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27NKV5pf197266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 20:31:05 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7876AC05B;
        Tue, 23 Aug 2022 20:31:05 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 960DDAC05E;
        Tue, 23 Aug 2022 20:31:02 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown [9.211.112.122])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Aug 2022 20:31:02 +0000 (GMT)
From:   Matthew Rosato <mjrosato@linux.ibm.com>
To:     iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/s390: Fix race with release_device ops
Date:   Tue, 23 Aug 2022 16:30:59 -0400
Message-Id: <20220823203059.81919-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 374vwlYuwWgMcaC7CIP8PbHj_xIBDiOV
X-Proofpoint-GUID: 374vwlYuwWgMcaC7CIP8PbHj_xIBDiOV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_07,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1011
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208230075
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
 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         |  1 +
 drivers/iommu/s390-iommu.c  | 68 ++++++++++++++++++++++++++++---------
 3 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 7b4cdadbc023..1295b6900e4b 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -157,6 +157,7 @@ struct zpci_dev {
 	/* DMA stuff */
 	unsigned long	*dma_table;
 	spinlock_t	dma_table_lock;
+	spinlock_t	dma_domain_lock;
 	int		tlb_refresh;
 
 	spinlock_t	iommu_bitmap_lock;
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 73cdc5539384..61901c1be3cc 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -832,6 +832,7 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
 	kref_init(&zdev->kref);
 	mutex_init(&zdev->lock);
 	mutex_init(&zdev->kzdev_lock);
+	spin_lock_init(&zdev->dma_domain_lock);
 
 	rc = zpci_init_iommu(zdev);
 	if (rc)
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index c898bcbbce11..513a7ebd23b3 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -90,15 +90,39 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 	struct s390_domain_device *domain_device;
 	unsigned long flags;
-	int cc, rc;
+	int cc, rc = 0;
 
 	if (!zdev)
 		return -ENODEV;
 
+	/* First check compatibility */
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
+	/* First device defines the DMA range limits */
+	if (list_empty(&s390_domain->devices)) {
+		domain->geometry.aperture_start = zdev->start_dma;
+		domain->geometry.aperture_end = zdev->end_dma;
+		domain->geometry.force_aperture = true;
+	/* Allow only devices with identical DMA range limits */
+	} else if (domain->geometry.aperture_start != zdev->start_dma ||
+		   domain->geometry.aperture_end != zdev->end_dma) {
+		rc = -EINVAL;
+	}
+	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+	if (rc)
+		return rc;
+
 	domain_device = kzalloc(sizeof(*domain_device), GFP_KERNEL);
 	if (!domain_device)
 		return -ENOMEM;
 
+	/* Leave now if the device has already been released */
+	spin_lock_irqsave(&zdev->dma_domain_lock, flags);
+	if (!dev_iommu_priv_get(dev)) {
+		spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
+		kfree(domain_device);
+		return 0;
+	}
+
 	if (zdev->dma_table && !zdev->s390_domain) {
 		cc = zpci_dma_exit_device(zdev);
 		if (cc) {
@@ -117,22 +141,11 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 		rc = -EIO;
 		goto out_restore;
 	}
+	zdev->s390_domain = s390_domain;
+	spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	/* First device defines the DMA range limits */
-	if (list_empty(&s390_domain->devices)) {
-		domain->geometry.aperture_start = zdev->start_dma;
-		domain->geometry.aperture_end = zdev->end_dma;
-		domain->geometry.force_aperture = true;
-	/* Allow only devices with identical DMA range limits */
-	} else if (domain->geometry.aperture_start != zdev->start_dma ||
-		   domain->geometry.aperture_end != zdev->end_dma) {
-		rc = -EINVAL;
-		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
-		goto out_restore;
-	}
 	domain_device->zdev = zdev;
-	zdev->s390_domain = s390_domain;
 	list_add(&domain_device->list, &s390_domain->devices);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
@@ -147,6 +160,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 				   virt_to_phys(zdev->dma_table));
 	}
 out_free:
+	spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
 	kfree(domain_device);
 
 	return rc;
@@ -176,17 +190,22 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 	}
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
-	if (found && (zdev->s390_domain == s390_domain)) {
+	spin_lock_irqsave(&zdev->dma_domain_lock, flags);
+	if (found && (zdev->s390_domain == s390_domain) &&
+	    dev_iommu_priv_get(dev)) {
 		zdev->s390_domain = NULL;
 		zpci_unregister_ioat(zdev, 0);
 		zpci_dma_init_device(zdev);
 	}
+	spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
 }
 
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 {
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 
+	dev_iommu_priv_set(dev, zdev);
+
 	return &zdev->iommu_dev;
 }
 
@@ -194,6 +213,7 @@ static void s390_iommu_release_device(struct device *dev)
 {
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 	struct iommu_domain *domain;
+	unsigned long flags;
 
 	/*
 	 * This is a workaround for a scenario where the IOMMU API common code
@@ -206,10 +226,26 @@ static void s390_iommu_release_device(struct device *dev)
 	 *
 	 * So let's call detach_dev from here if it hasn't been called before.
 	 */
-	if (zdev && zdev->s390_domain) {
+	if (zdev) {
+		/*
+		 * Clear priv to block further attaches for this device,
+		 * ensure detaches don't init DMA
+		 */
+		spin_lock_irqsave(&zdev->dma_domain_lock, flags);
+		dev_iommu_priv_set(dev, NULL);
+		spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
+		/* Make sure this device is removed from the domain list */
 		domain = iommu_get_domain_for_dev(dev);
 		if (domain)
 			s390_iommu_detach_device(domain, dev);
+		/* Now ensure DMA is initialized from here */
+		spin_lock_irqsave(&zdev->dma_domain_lock, flags);
+		if (zdev->s390_domain) {
+			zdev->s390_domain = NULL;
+			zpci_unregister_ioat(zdev, 0);
+			zpci_dma_init_device(zdev);
+		}
+		spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
 	}
 }
 
-- 
2.31.1

