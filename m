Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ABC58E485
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiHJBcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiHJBce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:32:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A186AA3B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:32:33 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A16QW8017125;
        Wed, 10 Aug 2022 01:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=0TaMadHaWCi9+mkS7MPh/IpcAd/LeTbwsq5Cbob7Ieg=;
 b=VmXllawIyAQfTgUT0dEC4eIhIrYE6GS05yk5PISKE0hdCT3ODhhnoLRJqXYWxQT7q/Gf
 ZzsSfJ4q8SZZuNmIq0TRUXwxqKMy8m6nDTpLgXuXQk+alJwGOcWKrUi9FAZpGGbpu6+O
 UcD0jukIvDoDyXAFGxFNdbfpvhD7qOj4rg/MqrvmLl6fcLrabWAOjCjrxtQ6+E+9tHBj
 t+Eh4D+Mc1+mF50bLv5/c9U4n5vMyIw/n/hzZtt8MRkCM0RHuraBPfZPFIL9DqpnDnyy
 Je/+I+qslNl/4kAYzUhdI75tYddUIAzy5ok3tpuE8zbxdnYd3R9mxH2mzjDhqWVcfaIY XA== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwqe0s40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 01:32:24 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27A1WMsn019869;
        Wed, 10 Aug 2022 01:32:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3hshcntksh-1;
        Wed, 10 Aug 2022 01:32:22 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27A1WLbP019864;
        Wed, 10 Aug 2022 01:32:21 GMT
Received: from maow2-gv.ap.qualcomm.com (maow2-gv.qualcomm.com [10.232.193.133])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 27A1WLZS019862;
        Wed, 10 Aug 2022 01:32:21 +0000
Received: by maow2-gv.ap.qualcomm.com (Postfix, from userid 399080)
        id EE6F221029A4; Wed, 10 Aug 2022 09:32:19 +0800 (CST)
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     akpm@linux-foundation.org, vbabka@kernel.org
Cc:     Kassey Li <quic_yingangl@quicinc.com>, minchan@kernel.org,
        vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v6] mm/page_owner.c: add llseek for page_owner
Date:   Wed, 10 Aug 2022 09:32:18 +0800
Message-Id: <20220810013218.27416-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1JB7qkCbm5CSr-IodJRyN2v5pY907gv5
X-Proofpoint-ORIG-GUID: 1JB7qkCbm5CSr-IodJRyN2v5pY907gv5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_01,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100003
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
 Documentation/vm/page_owner.rst |  6 ++++++
 mm/page_owner.c                 | 10 +++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

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
diff --git a/mm/page_owner.c b/mm/page_owner.c
index e4c6f3f1695b..33832b5908e6 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -13,6 +13,7 @@
 #include <linux/memcontrol.h>
 #include <linux/sched/clock.h>
 
+#include "../fs/proc/internal.h"
 #include "internal.h"
 
 /*
@@ -497,8 +498,10 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
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
@@ -561,7 +564,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			continue;
 
 		/* Record the next PFN to read in the file offset */
-		*ppos = (pfn - min_low_pfn) + 1;
+		*ppos = pfn + 1;
 
 		return print_page_owner(buf, count, pfn, page,
 				page_owner, handle);
@@ -660,6 +663,7 @@ static void init_early_allocated_pages(void)
 
 static const struct file_operations proc_page_owner_operations = {
 	.read		= read_page_owner,
+	.llseek		= mem_lseek,
 };
 
 static int __init pageowner_init(void)
-- 
2.17.1

