Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83762592999
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiHOGaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiHOGae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:30:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C13F1C
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:30:34 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F6UHRN006565;
        Mon, 15 Aug 2022 06:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=5B1oI9t/ePxiVEJXj7mwK7ywaoqoRX0LRp8fafTuWQc=;
 b=Q2xMu+bEGUNKxr4zh2XJ2LBxYGVNN8GxIAKIlc4amqO3OTDHby7RURRFLNuoe1Tocgns
 FcCLpeMjws9TczduYLTKmglCElqokXY8cAzPUfYrQEX/d9Du/4nIMkApsRT9ruzRjCc2
 nvCd1olAcA4mtWKbFHr7am2SLbymZvIYcCtJ7bsm9l1IYCCmfvnpHyVxtjoJWPO4dp4f
 8oYHEmILCDhug0TEeLQslBZ8zRP1CusOYDHsCwpwVpb7J177PWqfPSjrc8tNacQmp1ko
 89YeGC63wDZbb4lO19VBcH0hm3esuZ+1nnluNzIhJpBUwKTBelfn0mqf9upC3O6TnG3T 0g== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx467cc6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 06:30:16 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27F6UEIv016855;
        Mon, 15 Aug 2022 06:30:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 3hxnbrufwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Aug 2022 06:30:14 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27F6UDX9016849;
        Mon, 15 Aug 2022 06:30:13 GMT
Received: from maow2-gv.ap.qualcomm.com (maow2-gv.qualcomm.com [10.232.193.133])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 27F6UCP1016848;
        Mon, 15 Aug 2022 06:30:13 +0000
Received: by maow2-gv.ap.qualcomm.com (Postfix, from userid 399080)
        id 867F321000AE; Mon, 15 Aug 2022 14:30:11 +0800 (CST)
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     akpm@linux-foundation.org, vbabka@kernel.org
Cc:     Kassey Li <quic_yingangl@quicinc.com>, minchan@kernel.org,
        vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v7] mm/page_owner.c: add llseek for page_owner
Date:   Mon, 15 Aug 2022 14:30:10 +0800
Message-Id: <20220815063010.22462-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K5eckyAOSnBDay44CAOFk7Qbq_6SkeW9
X-Proofpoint-GUID: K5eckyAOSnBDay44CAOFk7Qbq_6SkeW9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=933
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208150024
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 Documentation/mm/page_owner.rst |  5 +++++
 mm/page_owner.c                 | 24 +++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
index f5c954afe97c..f18fd8907049 100644
--- a/Documentation/mm/page_owner.rst
+++ b/Documentation/mm/page_owner.rst
@@ -94,6 +94,11 @@ Usage
 	Page allocated via order XXX, ...
 	PFN XXX ...
 	// Detailed stack
+    By default, it will do full pfn dump, to start with a given pfn,
+    page_owner supports fseek.
+
+    FILE *fp = fopen("/sys/kernel/debug/page_owner", "r");
+    fseek(fp, pfn_start, SEEK_SET);
 
    The ``page_owner_sort`` tool ignores ``PFN`` rows, puts the remaining rows
    in buf, uses regexp to extract the page order value, counts the times
diff --git a/mm/page_owner.c b/mm/page_owner.c
index e4c6f3f1695b..c1a54e0e07dc 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -497,8 +497,10 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		return -EINVAL;
 
 	page = NULL;
-	pfn = min_low_pfn + *ppos;
-
+	if (*ppos == 0)
+		pfn = min_low_pfn;
+	else
+		pfn = *ppos;
 	/* Find a valid PFN or the start of a MAX_ORDER_NR_PAGES area */
 	while (!pfn_valid(pfn) && (pfn & (MAX_ORDER_NR_PAGES - 1)) != 0)
 		pfn++;
@@ -561,7 +563,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			continue;
 
 		/* Record the next PFN to read in the file offset */
-		*ppos = (pfn - min_low_pfn) + 1;
+		*ppos = pfn + 1;
 
 		return print_page_owner(buf, count, pfn, page,
 				page_owner, handle);
@@ -570,6 +572,21 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	return 0;
 }
 
+loff_t lseek_page_owner(struct file *file, loff_t offset, int orig)
+{
+	switch (orig) {
+	case SEEK_SET:
+		file->f_pos = offset;
+		break;
+	case SEEK_CUR:
+		file->f_pos += offset;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return file->f_pos;
+}
+
 static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 {
 	unsigned long pfn = zone->zone_start_pfn;
@@ -660,6 +677,7 @@ static void init_early_allocated_pages(void)
 
 static const struct file_operations proc_page_owner_operations = {
 	.read		= read_page_owner,
+	.llseek		= lseek_page_owner,
 };
 
 static int __init pageowner_init(void)
-- 
2.17.1

