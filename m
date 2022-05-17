Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DE8529F69
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344188AbiEQK3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbiEQK3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:29:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32C11CA
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:29:29 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HAMC7S028896;
        Tue, 17 May 2022 10:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=K771XREqVjhON5S7y+Xj5nxm98y25hiqCAHk1+Djnbo=;
 b=fw2qcmJjDFPzRZ8yAitfu90PfQIKJ0sEBkWcBHzHbGPr63yCSV1nPzl0dU1z/eYMvDm8
 CxsELqI5wUGB396oOAMufx4zOFyfYdDwsD4HOqkySLyPtFn27ykygNHid29UQmG8uGoZ
 MFudfploClTIDTaknANlPE3oplY3hSr2dH0sPgkxZBb8dpEY9evZZZ6B2RVi7jpuDLfj
 Py5jKrx286e4AsjxnHrkBokmpQFZmrsAH4QOzbk2gs06bzwv9ilMeyM4qu3wDGWjJmVd
 2hU/iCcRBsJO0FNjKmii+gJG/FijWvDVSrTA+aUc/Q3sT6ALK0xfSTEqw27GG7lsEnoP BQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g49w103jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 10:29:17 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HAMPq7031053;
        Tue, 17 May 2022 10:29:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3g2428u75u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 10:29:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HATDxu55247302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 10:29:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E36EDAE045;
        Tue, 17 May 2022 10:29:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2A93AE051;
        Tue, 17 May 2022 10:29:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 May 2022 10:29:12 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH v2] iommu/dma: Fix check for error return from iommu_map_sg_atomic()
Date:   Tue, 17 May 2022 12:29:12 +0200
Message-Id: <20220517102912.2115228-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4cVzg46uX1vm_vJ7q99rxN78cGXE8FIC
X-Proofpoint-ORIG-GUID: 4cVzg46uX1vm_vJ7q99rxN78cGXE8FIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_01,2022-05-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxlogscore=968 lowpriorityscore=0 spamscore=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __iommu_dma_alloc_noncontiguous() the return value of
iommu_map_sg_atomic() is treated as an error if it is smaller than size.
Before upstream commit ad8f36e4b6b1 ("iommu: return full error code from
iommu_map_sg[_atomic]()") this simply checked if the requested size was
successfully mapped.

After that commit iommu_map_sg_atomic() may also return a negative
error value. In principle this too would be covered by the existing
check. There is one problem however, as size is of type size_t while the
return type of iommu_map_sg_atomic() is now of type ssize_t the latter gets
converted to size_t and negative error values end up as very large
positive values making the check succeed even if an error was returned.
Fix this by casting size to ssize_t.

Fixes: ad8f36e4b6b1 ("iommu: return full error code from iommu_map_sg[_atomic]()")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v1 -> v2:
- Don't needlessly add a local variable

 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09f6e1c0f9c0..80db2aa5458c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -814,7 +814,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 	}
 
 	if (iommu_map_sg_atomic(domain, iova, sgt->sgl, sgt->orig_nents, ioprot)
-			< size)
+			< (ssize_t)size)
 		goto out_free_sg;
 
 	sgt->sgl->dma_address = iova;
-- 
2.32.0

