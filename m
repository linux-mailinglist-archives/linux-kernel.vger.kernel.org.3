Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD715874FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiHBBME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiHBBMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:12:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C16B25EAC
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:11:59 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2720xhxu005342;
        Tue, 2 Aug 2022 01:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=+XCm5jSg8FjQE5YqGwyyuso1tjrDjKrNMsCGsTXDJYg=;
 b=QdWS/6iBAAklD4za1JISNXcob7ukHqpue2gGjpKs8lnatHhIzD/nkUklvAeGTby2b5oV
 mO9UY1QA1pl2XnZyohS5UQCyWCJgXxvtl1z+Y9+V9Lx+NureLsexK9/hEVVMtD3S8cJR
 rpw2cbFQ0s3GK8yRlWGgk0RdzAp79/Y2IIt8tvQLyQzYGeB512HYQWRpxrbXP88VvP93
 5OljZm50+3iK9AOagj+Feubp8ML4oYAgv5D7u7h6Rb124MCzL8kmVqOBcZEC/N0cJFem
 138k20VkXGzEtZVFDuww/hcAQR/gJtDh9uCKg2uyTm4L+TvmdhTG29ir3qtwlFakAfJ3 3A== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hphfbh0wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 01:11:46 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27216hJ5029661;
        Tue, 2 Aug 2022 01:06:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3hmwqnqv6k-1;
        Tue, 02 Aug 2022 01:06:43 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27216hXT029656;
        Tue, 2 Aug 2022 01:06:43 GMT
Received: from maow2-gv.ap.qualcomm.com (maow2-gv.qualcomm.com [10.232.193.133])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 27216gnm029653;
        Tue, 02 Aug 2022 01:06:43 +0000
Received: by maow2-gv.ap.qualcomm.com (Postfix, from userid 399080)
        id 9C66C21029A6; Tue,  2 Aug 2022 09:06:41 +0800 (CST)
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     akpm@linux-foundation.org, vbabka@kernel.org
Cc:     Kassey Li <quic_yingangl@quicinc.com>, minchan@kernel.org,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3] mm/page_owner.c: add llseek for page_owner
Date:   Tue,  2 Aug 2022 09:06:40 +0800
Message-Id: <20220802010640.26937-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OQB56bczKuKnXRj0Ch0ep3tLxqx5K73m
X-Proofpoint-ORIG-GUID: OQB56bczKuKnXRj0Ch0ep3tLxqx5K73m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_12,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=769 impostorscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020003
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is usage to dump a given cma region page_owner
instead of all page's.

This change allows to specify a ppos as start_pfn
by fseek.

Any invalid ppos will be skipped, so it did not
broken the origin dump feature.

Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 mm/page_owner.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index e4c6f3f1695b..231b1877af99 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -497,8 +497,8 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		return -EINVAL;
 
 	page = NULL;
-	pfn = min_low_pfn + *ppos;
 
+	pfn = *ppos;
 	/* Find a valid PFN or the start of a MAX_ORDER_NR_PAGES area */
 	while (!pfn_valid(pfn) && (pfn & (MAX_ORDER_NR_PAGES - 1)) != 0)
 		pfn++;
@@ -561,7 +561,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			continue;
 
 		/* Record the next PFN to read in the file offset */
-		*ppos = (pfn - min_low_pfn) + 1;
+		*ppos = pfn + 1;
 
 		return print_page_owner(buf, count, pfn, page,
 				page_owner, handle);
@@ -570,6 +570,21 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	return 0;
 }
 
+static loff_t llseek_page_owner(struct file *file, loff_t offset, int whence)
+{
+	loff_t retval = 0;
+	switch (whence) {
+		case SEEK_CUR:
+		case SEEK_SET:
+			file->f_pos = offset;
+			break;
+		default:
+			retval = -ENXIO;
+	}
+
+	return retval;
+}
+
 static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 {
 	unsigned long pfn = zone->zone_start_pfn;
@@ -660,6 +675,7 @@ static void init_early_allocated_pages(void)
 
 static const struct file_operations proc_page_owner_operations = {
 	.read		= read_page_owner,
+	.llseek 	= llseek_page_owner,
 };
 
 static int __init pageowner_init(void)
-- 
2.17.1

