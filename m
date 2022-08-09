Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F295258D211
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiHICrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiHICrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:47:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240EDEA0
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 19:47:43 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2792iq9R032199;
        Tue, 9 Aug 2022 02:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=NDL5eqQWb493Q35OIi+aiikJfYXEG7IvNW4qAU80DAM=;
 b=C1gq2N9Gr5Bv23OIn2UOEcFWM12IL5VBydRpfI6WzW1P+RZWAp/ARqrQHVfcNFblEkle
 jEN1117wOmAgjIrE+DoGKfqPnvqOMIxae5dgvdCgx5RAjNw+Cnbq8xo3N5EUwb2Sq6Z3
 Ww4x5dA93Sb7cb9ofR8QrfvGcEri8FoSmiKeu4YomUIRtQAWlaZEIEcFV4wEfTTzouFl
 7h45xJFDlE75EbHHNGmraMTgCBLQbsETSKdfVJszvhMr+Xctl0VgISd35MF0VrISiUP/
 x5JAvS+crxEXL7SRajlOdWXRMduFznodK0mmG5J4oCwXKMAhM7PXGD9hLHyRoCvObvsv Cw== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hudun83df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 02:47:31 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2792lSN0014090;
        Tue, 9 Aug 2022 02:47:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3hshcpr0q1-1;
        Tue, 09 Aug 2022 02:47:28 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2792lSGc014083;
        Tue, 9 Aug 2022 02:47:28 GMT
Received: from maow2-gv.ap.qualcomm.com (maow2-gv.qualcomm.com [10.232.193.133])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 2792lR36014080;
        Tue, 09 Aug 2022 02:47:28 +0000
Received: by maow2-gv.ap.qualcomm.com (Postfix, from userid 399080)
        id 7B79A21029A4; Tue,  9 Aug 2022 10:47:26 +0800 (CST)
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     akpm@linux-foundation.org, vbabka@kernel.org
Cc:     Kassey Li <quic_yingangl@quicinc.com>, minchan@kernel.org,
        vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v5] mm/page_owner.c: add llseek for page_owner
Date:   Tue,  9 Aug 2022 10:47:25 +0800
Message-Id: <20220809024725.31980-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: stfFisL2DWbhsuVwzePPS6p4677Jx-5d
X-Proofpoint-ORIG-GUID: stfFisL2DWbhsuVwzePPS6p4677Jx-5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_14,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208090012
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
 Documentation/vm/page_owner.rst | 6 ++++++
 mm/internal.h                   | 5 +++++
 mm/page_owner.c                 | 9 ++++++---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index f5c954afe97c..8d33d976da8a 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -95,6 +95,12 @@ Usage
 	PFN XXX ...
 	// Detailed stack
 
+   By default, it will do full pfn dump, to start with a given pfn,
+   page_owner supports fseek.
+
+   FILE *fp = fopen("/sys/kernel/debug/page_owner", "r");
+   fseek(fp, pfn_start, SEEK_SET);
+
    The ``page_owner_sort`` tool ignores ``PFN`` rows, puts the remaining rows
    in buf, uses regexp to extract the page order value, counts the times
    and pages of buf, and finally sorts them according to the parameter(s).
diff --git a/mm/internal.h b/mm/internal.h
index c0f8fbe0445b..1ad8f86e6e33 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -189,6 +189,11 @@ extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason
  */
 extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
 
+/*
+ * in mm/page_owner.c:
+ */
+extern loff_t mem_lseek(struct file *, loff_t, int);
+
 /*
  * in mm/page_alloc.c
  */
diff --git a/mm/page_owner.c b/mm/page_owner.c
index e4c6f3f1695b..dcbe05e206e1 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -497,8 +497,10 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		return -EINVAL;
 
 	page = NULL;
-	pfn = min_low_pfn + *ppos;
-
+	if (*ppos == 0)
+		pfn= min_low_pfn;
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
@@ -660,6 +662,7 @@ static void init_early_allocated_pages(void)
 
 static const struct file_operations proc_page_owner_operations = {
 	.read		= read_page_owner,
+	.llseek 	= mem_lseek,
 };
 
 static int __init pageowner_init(void)
-- 
2.17.1

