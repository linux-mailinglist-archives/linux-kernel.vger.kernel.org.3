Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9835A8758
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiHaUNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiHaUMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:12:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247F9286CE;
        Wed, 31 Aug 2022 13:12:52 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VK03Cv009124;
        Wed, 31 Aug 2022 20:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8UaAcdsSep4uV8uaXMURFWomBBOpmEtS8j6S/xj9pgg=;
 b=Rb9GNk9RjeyndqN8mYbDn1X1uq0wCMKYgBjS4y1AZ1IqjYl+XS2W4fUrt+1YVYPERLi5
 xbsCxNtYdtsEiwDLSXniIssRD+0J19u0bjS09Y7YLI9+RkCX/cheWQWb+IMHptIZJ8U8
 8s9DyjlEh3pfX6zXa5w4oo7lAieu2nZoREd+kB4wZl2FOZ7LV07J+OLczI/9H4JpQDv0
 AIrcT19C/xPii9HM6LW4pGrGqoiFYxqJamwd/zRySDmVynKPn7KLM58Hj/PQVuf3LiGx
 yR8fE/1Mh5gV70G+q4dwDiwPreZQBTVZLfMruBL3IKGjgSONY3VJxkFyCmEZgbmowGBq Dg== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jae9qgn6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 20:12:41 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27VK65I2030788;
        Wed, 31 Aug 2022 20:12:40 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 3j7aw9vkft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 20:12:40 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27VKCdib39584230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 20:12:39 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC155AC059;
        Wed, 31 Aug 2022 20:12:39 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1333FAC05F;
        Wed, 31 Aug 2022 20:12:39 +0000 (GMT)
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
Subject: [PATCH v4 2/2] iommu/s390: fix leak of s390_domain_device
Date:   Wed, 31 Aug 2022 16:12:36 -0400
Message-Id: <20220831201236.77595-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831201236.77595-1-mjrosato@linux.ibm.com>
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QHMWXiIgYlc2TrNwErWCpsynqGM0Hb-3
X-Proofpoint-GUID: QHMWXiIgYlc2TrNwErWCpsynqGM0Hb-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since allowing multiple domains to be attached via fa7e9ecc5e1c, it's now
possible that a kfree of s390_domain_device is missed, either because a
corresponding detach_dev was never called or because a repeat attach_dev
was called for the same device and domain pair (resulting in unnecessary
duplicates).  Check for duplicates during attach_dev and ensure the list
of s390_domain_device structures is cleared up when the domain is freed.

Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 1137d669e849..db4dfbcf161b 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -78,7 +78,17 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 static void s390_domain_free(struct iommu_domain *domain)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
+	struct s390_domain_device *domain_device, *tmp;
+	unsigned long flags;
 
+	/* Ensure all device entries are cleaned up */
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
+	list_for_each_entry_safe(domain_device, tmp, &s390_domain->devices,
+				 list) {
+		list_del(&domain_device->list);
+		kfree(domain_device);
+	}
+	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 	dma_cleanup_tables(s390_domain->dma_table);
 	kfree(s390_domain);
 }
@@ -88,7 +98,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
-	struct s390_domain_device *domain_device;
+	struct s390_domain_device *domain_device, *ddev;
 	unsigned long flags;
 	int cc, rc;
 
@@ -140,7 +150,16 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 		goto out_restore;
 	}
 	domain_device->zdev = zdev;
-	list_add(&domain_device->list, &s390_domain->devices);
+	/* If already attached don't add another instance */
+	list_for_each_entry(ddev, &s390_domain->devices, list) {
+		if (ddev->zdev == zdev) {
+			kfree(domain_device);
+			domain_device = NULL;
+			break;
+		}
+	}
+	if (domain_device)
+		list_add(&domain_device->list, &s390_domain->devices);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 	zdev->s390_domain = s390_domain;
 	mutex_unlock(&zdev->dma_domain_lock);
-- 
2.37.2

