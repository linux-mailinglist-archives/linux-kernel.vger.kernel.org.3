Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62995A8757
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiHaUM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiHaUMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:12:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F794C2774;
        Wed, 31 Aug 2022 13:12:51 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VJoCwf022150;
        Wed, 31 Aug 2022 20:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=t2KcrvxT2E4IlMaQGptE2kb/DhxLdfg+hmehqxWfXWQ=;
 b=OB7B6i1W3RP/6435wRiND6spuels8MDVZiSXBiv68SjOjxjycKYmLNpdFjCTQMubfqOZ
 lHqzHnTdA1SRo/Jfi2P9OwTZRDa7mIcGIs2d2+kaimSQneiBO9/uas38mWqKtWnhRJN6
 t9+r6g+PZ66Kxuzl1f9xE78pK4JI8AOCwFHSgQhxqFt3hBh+TNA6a429KL5YvlOExhia
 0FPAmIC5/jDcNKXV+k5lTd8BZ5NRTo3oJDasbXhs3H6Vo0YGazSHA4dA1Nb9hrboDU36
 WpXXURW7rziw8imvqrqYavF8KKZG2lG1WUhUD0mfskrtb8FTLwvfIIAJW0Z2qKlhV0nW 6g== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jae518vfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 20:12:41 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27VK5GrM019094;
        Wed, 31 Aug 2022 20:12:40 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 3j7awa3q11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 20:12:40 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27VKCdTs61407552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 20:12:39 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F22FAAC059;
        Wed, 31 Aug 2022 20:12:38 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B3EDAC060;
        Wed, 31 Aug 2022 20:12:38 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.160.77.30])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 31 Aug 2022 20:12:38 +0000 (GMT)
From:   Matthew Rosato <mjrosato@linux.ibm.com>
To:     iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
Date:   Wed, 31 Aug 2022 16:12:35 -0400
Message-Id: <20220831201236.77595-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831201236.77595-1-mjrosato@linux.ibm.com>
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d4woSmgW6jzLnJeicPHVgzEci5xEpaUA
X-Proofpoint-GUID: d4woSmgW6jzLnJeicPHVgzEci5xEpaUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310097
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

