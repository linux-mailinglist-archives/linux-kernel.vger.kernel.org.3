Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87EF57CA3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbiGUMFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiGUMFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:05:21 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A2410D0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 05:05:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VK03.nE_1658405115;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VK03.nE_1658405115)
          by smtp.aliyun-inc.com;
          Thu, 21 Jul 2022 20:05:15 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     ying.huang@intel.com, ziy@nvidia.com, shy828301@gmail.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: migrate: Do not retry 10 times for the subpages of fail-to-migrate THP
Date:   Thu, 21 Jul 2022 20:05:08 +0800
Message-Id: <1658405108-100658-1-git-send-email-baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If THP is failed to migrate due to -ENOSYS or -ENOMEM case, the THP will
be split, and the subpages of fail-to-migrate THP will be tried to migrate
again, so we should not account the retry counter in the second loop, since
we already accounted 'nr_thp_failed' in the first loop.

Moreover we also do not need retry 10 times for -EAGAIN case for the subpages
of fail-to-migrate THP in the second loop, since we already regarded the
THP as migration failure, and save some migration time (for the worst case,
will try 512 * 10 times) according to previous discussion [1].

[1] https://lore.kernel.org/linux-mm/87r13a7n04.fsf@yhuang6-desk2.ccr.corp.intel.com/

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Note, this patch is based on the patch set [1] from Huang Ying.
[1] https://lore.kernel.org/linux-mm/20220711084948.274787-1-ying.huang@intel.com/
---
 mm/migrate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8429206..e36a084 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1507,7 +1507,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			case -EAGAIN:
 				if (is_thp)
 					thp_retry++;
-				else
+				else if (!no_subpage_counting)
 					retry++;
 				nr_retry_pages += nr_subpages;
 				break;
@@ -1533,8 +1533,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			}
 		}
 	}
-	if (!no_subpage_counting)
-		nr_failed += retry;
+	nr_failed += retry;
 	nr_thp_failed += thp_retry;
 	nr_failed_pages += nr_retry_pages;
 	/*
-- 
1.8.3.1

