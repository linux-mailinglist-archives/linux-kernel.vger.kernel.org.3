Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3CE56B444
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiGHIOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbiGHIOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:14:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD56F7392C;
        Fri,  8 Jul 2022 01:14:40 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2688CH29017346;
        Fri, 8 Jul 2022 08:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KjwhQRkfiywh2HTVFoTtksOCx5nrgNL3/4qAheIYzs0=;
 b=WVQdenRVrLfitup3WLMCy/4R5lBAYQKgBrcPvA23aZBvXbCNEd9++jIW1OFa42WVW9h3
 ZpC1XmR/5fpZr7dvkUNZRmcpldfQlx0/pJeM7FZDazEOhBHw9yDBaHlyegiK21j72YuP
 p/RgQyjA/x6WAdT8UpdVt/1P4/TL4UGD9iQkdNNSQ20T8EHGmVXbxk8QRLrGSqrJZp9c
 XvjIgW2NGfMScKTTHvvV/W8u0vN1v2ES/bvVj86WZvHPPxKcv1dL+dXhS2eWnH9oMC/H
 6KFouBEOi7hsJDt/khoHn5Q97YPuH6FDBu1lZz7E2pLc6wtzKW266E1QmTAJGgLwVlIC Lw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h6guy81jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 08:14:25 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26884vMM018005;
        Fri, 8 Jul 2022 08:14:22 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3h4uwp2qb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 08:14:22 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2688CxWg22544650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Jul 2022 08:12:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9356942041;
        Fri,  8 Jul 2022 08:14:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C3B442042;
        Fri,  8 Jul 2022 08:14:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jul 2022 08:14:19 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     mjrosato@linux.ibm.com
Cc:     baolu.lu@linux.intel.com, gerald.schaefer@linux.ibm.com,
        iommu@lists.linux.dev, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, robin.murphy@arm.com,
        schnelle@linux.ibm.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, will@kernel.org
Subject: [PATCH] iommu/s390: fail probe for non-pci device
Date:   Fri,  8 Jul 2022 10:14:18 +0200
Message-Id: <20220708081418.2691301-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4c25e3ad-0eb6-5c41-48b2-7c10e745bd5d@linux.ibm.com>
References: <4c25e3ad-0eb6-5c41-48b2-7c10e745bd5d@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CPljTlbL3W45HRul6XZibOWR73EZbyAn
X-Proofpoint-GUID: CPljTlbL3W45HRul6XZibOWR73EZbyAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207080030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Rosato <mjrosato@linux.ibm.com>

s390-iommu only supports pci_bus_type today

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index dd957145fb81..762f892b4ec3 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -185,7 +185,12 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 {
-	struct zpci_dev *zdev = to_zpci_dev(dev);
+	struct zpci_dev *zdev;
+
+	if (!dev_is_pci(dev))
+		return ERR_PTR(-ENODEV);
+
+	zdev = to_zpci_dev(dev);
 
 	return &zdev->iommu_dev;
 }
-- 
2.34.1

