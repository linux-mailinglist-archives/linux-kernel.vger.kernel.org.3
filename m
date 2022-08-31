Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C35A8756
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiHaUMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiHaUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:12:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDF2286CE;
        Wed, 31 Aug 2022 13:12:50 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VJnvY5021667;
        Wed, 31 Aug 2022 20:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=JLTNgFiDwX8JiagmE7RbrMieN0P5Q+gsHMUA5SyYvLQ=;
 b=PryCjWBRwI5OQFxuBR2+vmT4qjXDTU4cYfSf315WW0ayRZpLKxXVUwo/f1glNCaOgmiI
 DYRuG4qF/ooTMsx107zAMu/Lk92SLXCVMs85XQw3cchBVutU3QI6pHcTbrTFdV/zv/J5
 FM9nsdIn6w4Dm2LZPOoR+MM3c/rVxlq+zHFNVPTM72qxV6aQQ8R6B53MspniaFwM2zVW
 umxJNdRPyasfHoPqReGpu0l/4ac+LjO+9OJvy3VcqeRZuirPuQvPIuIhZBf1F2lB6BFP
 VGL8DIMbICtViM40x12Og/bbA4z3lJ/Ah3kGgkWqZdpqCb7r36XCs0uwnrvSFYEAEVWi hA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jae518vf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 20:12:40 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27VK61j7030692;
        Wed, 31 Aug 2022 20:12:38 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 3j7aw9vkfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 20:12:38 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27VKCcHl57672022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 20:12:38 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 287E7AC05F;
        Wed, 31 Aug 2022 20:12:38 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B419AC059;
        Wed, 31 Aug 2022 20:12:37 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.160.77.30])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 31 Aug 2022 20:12:37 +0000 (GMT)
From:   Matthew Rosato <mjrosato@linux.ibm.com>
To:     iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] iommu/s390: fixes related to repeat attach_dev calls
Date:   Wed, 31 Aug 2022 16:12:34 -0400
Message-Id: <20220831201236.77595-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0pXSEi-O0gJVAalf4W8rA_88dhO3dvlR
X-Proofpoint-GUID: 0pXSEi-O0gJVAalf4W8rA_88dhO3dvlR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=484
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

This series contains a few fixes related to supporting multiple unmanaged
iommu domains on s390.

Changelog since v3:
- add a 2nd patch to fix issues related to leaking s390_domain_device

Matthew Rosato (2):
  iommu/s390: Fix race with release_device ops
  iommu/s390: fix leak of s390_domain_device

 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         |  1 +
 drivers/iommu/s390-iommu.c  | 62 ++++++++++++++++++++++++++++++++++---
 3 files changed, 59 insertions(+), 5 deletions(-)

-- 
2.37.2

