Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D540A53AB13
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355558AbiFAQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350575AbiFAQdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:33:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B38059B85
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:33:20 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251Ftn2C012580;
        Wed, 1 Jun 2022 16:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7vE2Qwr7p4el325+n6Yzgeqvi+thJCao+cwF1Iqhjng=;
 b=oLZ0Gkz7B+ZHfFMY7xcLjHYGMUDxEt3mCGmZ50duteQ7s7h9lFUAyrbCyB7NjGdM6T6N
 I8b3bMTJ6d7OjseeSwqrejDzJvXm6spIYpr604hPNIVMX8ZALffFSacxOlCaF2mv2Wgy
 FaPtzRceVxbDZA2VxOsd/eSbWZx7ur8LsoekAxa0DHc7PgGV+mQqpmNMWAMPC6Qg9i1J
 GNR6+/GeL0cOFOPramivNVmtIzKtSbfCOk4zkty1S9KuV4ERnngKP3fIZYwHuk5LP5M7
 30NAyvSKaUe67NJ0UCZdvUFJU27cmZUxSdh2mxqJIebnZ+izfFFn1n87i1ptazlDA+m6 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ge9djbx6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 16:33:05 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 251FYcYj014394;
        Wed, 1 Jun 2022 16:33:05 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ge9djbx5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 16:33:05 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 251G7Z50025471;
        Wed, 1 Jun 2022 16:33:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3gbcae5v7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 16:33:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 251GWxl644761414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jun 2022 16:32:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC90842047;
        Wed,  1 Jun 2022 16:32:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DB184203F;
        Wed,  1 Jun 2022 16:32:56 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.43.94.137])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  1 Jun 2022 16:32:55 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Wed, 01 Jun 2022 22:02:54 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] resource: re-factor page_is_ram()
Date:   Wed,  1 Jun 2022 22:02:43 +0530
Message-Id: <20220601163243.3806231-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KOLdGCwCmzhxQ9tw99YTmfyN9rUA2-XT
X-Proofpoint-GUID: HLf-KffkVr4JaTrfWUaQNbklY0TRzOk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_05,2022-06-01_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently page_is_ram() relies on walk_system_ram_range() that performs a walk
on kernel iomem resources hierarchy with a dummy callback __is_ram(). Before
calling find_next_iomem_res(), walk_system_ram_range() does some book-keeping
which can be avoided for page_is_ram() use-case.

Hence this patch proposes to update page_is_ram() to directly call
find_next_iomem_res() with minimal book-keeping needed.

To avoid allocating a 'struct resource' the patch also updates
find_next_iomem_res() to not return -EINVAL in case 'res == NULL'. Instead
out 'struct resource *res' is only populated when its not NULL.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 kernel/resource.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 34eaee179689..ecf6b9a50adc 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -311,7 +311,7 @@ EXPORT_SYMBOL(release_resource);
  *
  * If a resource is found, returns 0 and @*res is overwritten with the part
  * of the resource that's within [@start..@end]; if none is found, returns
- * -ENODEV.  Returns -EINVAL for invalid parameters.
+ * -ENODEV.
  *
  * @start:	start address of the resource searched for
  * @end:	end address of same resource
@@ -328,9 +328,6 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 {
 	struct resource *p;
 
-	if (!res)
-		return -EINVAL;
-
 	if (start >= end)
 		return -EINVAL;
 
@@ -356,7 +353,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 		break;
 	}
 
-	if (p) {
+	if (p && res) {
 		/* copy data */
 		*res = (struct resource) {
 			.start = max(start, p->start),
@@ -474,18 +471,18 @@ int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
 	return ret;
 }
 
-static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
-{
-	return 1;
-}
-
 /*
  * This generic page_is_ram() returns true if specified address is
  * registered as System RAM in iomem_resource list.
  */
 int __weak page_is_ram(unsigned long pfn)
 {
-	return walk_system_ram_range(pfn, 1, NULL, __is_ram) == 1;
+	const resource_size_t pfn_res = PFN_PHYS(pfn);
+
+	return find_next_iomem_res(pfn_res,
+				   pfn_res + 1,
+				   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+				   IORES_DESC_NONE, NULL) == 0;
 }
 EXPORT_SYMBOL_GPL(page_is_ram);
 
-- 
2.35.3

