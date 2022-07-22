Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D4757E36C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiGVPId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbiGVPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:08:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3241A88F37
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:08:30 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MENVeq007256;
        Fri, 22 Jul 2022 15:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=nUADTmTOViYJUoOL2poj7e8y6wxZSdNyN8C0LFw6b6g=;
 b=jBMnBQW+COtoS2GvW0iAnVN1c3HVh6OsC0FB2in2/itjARvqTUEIrslu9Ia2P215FAr7
 CJnqEeMYEhKawmP7o9EICYAss5qGBlm/ntn9B3cWk95uMGQIRg0xUoixUbBMUJo+1ZaF
 yOstFb6iKRW6B8ti73+YNkT3h3L+jG99tM7XKJmq56UjPxUXalg/boe/XAxk4TAag5h3
 zuAJGfJyYbDC0htC9kUnQ7qLz8TPR8kCJiE4WBgJQFl7c+9mvXoJObO01fRCXOPXgDM0
 /k5mUWK932yeozN/RUqU9T4Iny3AIX3SJBeAOXFCWT3SvCuLp6rVwFLRktPfOPxXpaJv ww== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hfs5arsfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 15:08:19 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 26MF8FOB012573;
        Fri, 22 Jul 2022 15:08:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 3hc6rjn0k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jul 2022 15:08:15 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26MF8Fve012568;
        Fri, 22 Jul 2022 15:08:15 GMT
Received: from maow2-gv.ap.qualcomm.com (maow2-gv.qualcomm.com [10.232.193.133])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 26MF8Fbb012567;
        Fri, 22 Jul 2022 15:08:15 +0000
Received: by maow2-gv.ap.qualcomm.com (Postfix, from userid 399080)
        id 20E4E21029A4; Fri, 22 Jul 2022 23:08:14 +0800 (CST)
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     akpm@linux-foundation.org
Cc:     Kassey Li <quic_yingangl@quicinc.com>, minchan@kernel.org,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/page_owner.c: allow page_owner with given start_pfn/count
Date:   Fri, 22 Jul 2022 23:08:10 +0800
Message-Id: <20220722150810.27740-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EYlyzmaQTzIVM6rs4ixBFCEZUq27NRMJ
X-Proofpoint-ORIG-GUID: EYlyzmaQTzIVM6rs4ixBFCEZUq27NRMJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=763 phishscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207220064
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

by default, page_owner iterates all page from min_low_pfn to
max_pfn, this cost too much time if we want an alternative pfn range.

with this patch it allows user to set pfn range to dump the page_onwer.

Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 mm/page_owner.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index e4c6f3f1695b..79c634d11ee6 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -41,6 +41,39 @@ static depot_stack_handle_t dummy_handle;
 static depot_stack_handle_t failure_handle;
 static depot_stack_handle_t early_handle;
 
+static u64 start_pfn;
+static u64 end_pfn;
+
+static int debugfs_start_pfn_u64_set(void *data, u64 val)
+{
+	if (val < min_low_pfn || val > max_pfn)
+		return -EINVAL;
+	start_pfn = val;
+	return 0;
+}
+static int debugfs_start_pfn_u64_get(void *data, u64 *val)
+{
+	*val = start_pfn;
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(fops_start_pfn, debugfs_start_pfn_u64_get,
+	debugfs_start_pfn_u64_set, "%lld\n");
+
+static int debugfs_end_pfn_u64_set(void *data, u64 val)
+{
+	if (val > max_pfn || val < start_pfn)
+		return -EINVAL;
+	end_pfn = val;
+	return 0;
+}
+static int debugfs_end_pfn_u64_get(void *data, u64 *val)
+{
+	*val = end_pfn;
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(fops_end_pfn, debugfs_end_pfn_u64_get,
+	debugfs_end_pfn_u64_set, "%lld\n");
+
 static void init_early_allocated_pages(void);
 
 static int __init early_page_owner_param(char *buf)
@@ -497,7 +530,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		return -EINVAL;
 
 	page = NULL;
-	pfn = min_low_pfn + *ppos;
+	pfn = start_pfn + *ppos;
 
 	/* Find a valid PFN or the start of a MAX_ORDER_NR_PAGES area */
 	while (!pfn_valid(pfn) && (pfn & (MAX_ORDER_NR_PAGES - 1)) != 0)
@@ -506,7 +539,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	drain_all_pages(NULL);
 
 	/* Find an allocated page */
-	for (; pfn < max_pfn; pfn++) {
+	for (; pfn < end_pfn; pfn++) {
 		/*
 		 * If the new page is in a new MAX_ORDER_NR_PAGES area,
 		 * validate the area as existing, skip it if not
@@ -561,7 +594,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			continue;
 
 		/* Record the next PFN to read in the file offset */
-		*ppos = (pfn - min_low_pfn) + 1;
+		*ppos = (pfn - start_pfn) + 1;
 
 		return print_page_owner(buf, count, pfn, page,
 				page_owner, handle);
@@ -671,6 +704,12 @@ static int __init pageowner_init(void)
 
 	debugfs_create_file("page_owner", 0400, NULL, NULL,
 			    &proc_page_owner_operations);
+	debugfs_create_file("page_owner_start_pfn", 0644, NULL, NULL,
+				&fops_start_pfn);
+	debugfs_create_file("page_owner_end_pfn", 0644, NULL, NULL,
+				&fops_end_pfn);
+	start_pfn = min_low_pfn;
+	end_pfn = max_pfn;
 
 	return 0;
 }
-- 
2.17.1

