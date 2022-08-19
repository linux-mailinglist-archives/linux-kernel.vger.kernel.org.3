Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C215999AD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345441AbiHSKNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346395AbiHSKNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:13:20 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AB9109
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:13:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMfcxWM_1660903986;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMfcxWM_1660903986)
          by smtp.aliyun-inc.com;
          Fri, 19 Aug 2022 18:13:07 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm/hugetlb: add FOLL_MIGRATION validation before waiting for a migration entry
Date:   Fri, 19 Aug 2022 18:12:58 +0800
Message-Id: <0ec5d75781452af85e6226e1b5940ff557c6f5e7.1660902741.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
References: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
References: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hugetlb should keep the same logics with normal page when waiting
for a migration pte entry, that means we should also validate if
the FOLL_MIGRATION flag is set before waiting for a migration pte entry
of a hugetlb page.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/hugetlb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index efb53ba..fac1b33 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7000,6 +7000,11 @@ struct page * __weak
 			goto out;
 		}
 	} else {
+		if (!(flags & FOLL_MIGRATION)) {
+			page = NULL;
+			goto out;
+		}
+
 		if (is_hugetlb_entry_migration(pte)) {
 			spin_unlock(ptl);
 			__migration_entry_wait_huge((pte_t *)pmd, ptl);
@@ -7038,6 +7043,11 @@ struct page * __weak
 			goto out;
 		}
 	} else {
+		if (!(flags & FOLL_MIGRATION)) {
+			page = NULL;
+			goto out;
+		}
+
 		if (is_hugetlb_entry_migration(pte)) {
 			spin_unlock(ptl);
 			__migration_entry_wait(mm, (pte_t *)pud, ptl);
-- 
1.8.3.1

