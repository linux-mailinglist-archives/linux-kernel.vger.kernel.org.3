Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185CE582722
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiG0Mz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiG0MzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:55:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD002528D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:55:23 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R9R6q4007474;
        Wed, 27 Jul 2022 12:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=sfEOyX4vOKyoQkguP4YsmAKm9zYOliqxQHruCHv5I3c=;
 b=mZ8mWFR+BQjYKml1oyn7PPRZ23Pb8Y1lL8NJzAG7flECqqewcxtdHFXYiyam+d8ohYZa
 RW41zi+oWl3z5aT2IDd01GCLo+QeQoupeKhYASuvVA8cvHI2PonULKKpkAs0615Yj+64
 yAmFrY2vgbouCX9T8nNQWZfYyGa4RCcF2KI3Wj+ZxV3feS+Qn66qkFHAZJyVzDgh0jRA
 8DQTifdetoDgqGQN3+7UUVyY2Wjt4uCqqcbyh7CiXISBsYWaCbQTR0a/Rl6teOPlkx6i
 /Vz0BCFmYs6m6Younzfi+NgHTZLTMgWUBbEmhUOwbMUS8NmonMXlSpVMhrxxqY7x8dTx NA== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hk1b9rhg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 12:55:15 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 26RCtCc9003186;
        Wed, 27 Jul 2022 12:55:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3hk4du05gg-1;
        Wed, 27 Jul 2022 12:55:12 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26RCtCUW003173;
        Wed, 27 Jul 2022 12:55:12 GMT
Received: from maow2-gv.ap.qualcomm.com (maow2-gv.qualcomm.com [10.232.193.133])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 26RCtBde003133;
        Wed, 27 Jul 2022 12:55:12 +0000
Received: by maow2-gv.ap.qualcomm.com (Postfix, from userid 399080)
        id 90C442102E3E; Wed, 27 Jul 2022 20:55:10 +0800 (CST)
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     akpm@linux-foundation.org, vbabka@kernel.org
Cc:     minchan@kernel.org, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        quic_yingangl@quicinc.com
Subject: [PATCH v2] mm/page_owner.c: add llseek for page_owner
Date:   Wed, 27 Jul 2022 20:55:08 +0800
Message-Id: <20220727125508.5154-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i8KHuKGyBc9Z0gNGUD60ZxbguDa5-0iu
X-Proofpoint-GUID: i8KHuKGyBc9Z0gNGUD60ZxbguDa5-0iu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_03,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 mlxlogscore=766 bulkscore=0 phishscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270052
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
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

Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 mm/page_owner.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index e4c6f3f1695b..f0bc75421de0 100644
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
 
+loff_t llseek_page_owner(struct file *file, loff_t offset, int whence)
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
@@ -658,8 +673,11 @@ static void init_early_allocated_pages(void)
 		init_zones_in_node(pgdat);
 }
 
+
+
 static const struct file_operations proc_page_owner_operations = {
 	.read		= read_page_owner,
+	.llseek 	= llseek_page_owner,
 };
 
 static int __init pageowner_init(void)
-- 
2.17.1

