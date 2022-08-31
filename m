Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286735A75B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiHaF1u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 Aug 2022 01:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaF1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:27:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B03AB07D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:27:47 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27V0pjRe002560
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:27:46 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j9hpwp297-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:27:46 -0700
Received: from twshared2273.16.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 22:27:44 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 209EFC44FB53; Tue, 30 Aug 2022 22:27:39 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <songliubraving@fb.com>, Song Liu <song@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/vmalloc: Extend find_vmap_lowest_match_check with extra arguments
Date:   Tue, 30 Aug 2022 22:27:34 -0700
Message-ID: <20220831052734.3423079-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WYxidV84ob5_UFWUm7tjoAZbMEnrpCkY
X-Proofpoint-GUID: WYxidV84ob5_UFWUm7tjoAZbMEnrpCkY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_01,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_vmap_lowest_match() is now able to handle different roots. Make
similar changes to find_vmap_lowest_match_check() and
find_vmap_lowest_linear_match() to handle different trees.

Fixes: f9863be49312 ("mm/vmalloc: extend __alloc_vmap_area() with extra arguments")
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 mm/vmalloc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index dd6cdb201195..088b421601c4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1300,12 +1300,12 @@ find_vmap_lowest_match(struct rb_root *root, unsigned long size,
 #include <linux/random.h>
 
 static struct vmap_area *
-find_vmap_lowest_linear_match(unsigned long size,
+find_vmap_lowest_linear_match(struct list_head *head, unsigned long size,
 	unsigned long align, unsigned long vstart)
 {
 	struct vmap_area *va;
 
-	list_for_each_entry(va, &free_vmap_area_list, list) {
+	list_for_each_entry(va, head, list) {
 		if (!is_within_this_va(va, size, align, vstart))
 			continue;
 
@@ -1316,7 +1316,8 @@ find_vmap_lowest_linear_match(unsigned long size,
 }
 
 static void
-find_vmap_lowest_match_check(unsigned long size, unsigned long align)
+find_vmap_lowest_match_check(struct rb_root *root, struct list_head *head,
+			     unsigned long size, unsigned long align)
 {
 	struct vmap_area *va_1, *va_2;
 	unsigned long vstart;
@@ -1325,8 +1326,8 @@ find_vmap_lowest_match_check(unsigned long size, unsigned long align)
 	get_random_bytes(&rnd, sizeof(rnd));
 	vstart = VMALLOC_START + rnd;
 
-	va_1 = find_vmap_lowest_match(size, align, vstart, false);
-	va_2 = find_vmap_lowest_linear_match(size, align, vstart);
+	va_1 = find_vmap_lowest_match(root, size, align, vstart, false);
+	va_2 = find_vmap_lowest_linear_match(head, size, align, vstart);
 
 	if (va_1 != va_2)
 		pr_emerg("not lowest: t: 0x%p, l: 0x%p, v: 0x%lx\n",
@@ -1513,7 +1514,7 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
 		return vend;
 
 #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
-	find_vmap_lowest_match_check(size, align);
+	find_vmap_lowest_match_check(root, head, size, align);
 #endif
 
 	return nva_start_addr;
-- 
2.30.2

