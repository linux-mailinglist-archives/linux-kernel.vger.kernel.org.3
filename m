Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CFC596B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiHQIPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiHQIOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:14:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB2F69F79
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660724073; x=1692260073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MlvM1YeTzqz/XZ0HlO1MJjt5fs4jtidIiLiwDXYc78E=;
  b=lIVfq3imm5wfxPaSvx3ngsNs/DIREq0O7HapkVPNw1CQ16MDnKi7SHM8
   q9f4VWnLYwjMbeDUezHs39ZcqtrJDW7sfF+PwR2PNM53GS8VecRyas05s
   fDbGXO5dYUNLWyfrZGfbdde17ORvNU2LpvSXXO3WuHCXvEv00CmwEjuu8
   4nmYfCdiue4PvN7qB+kuMLDvPSwCBCL9lgAASckPudfQYS8CGMHsYeLqn
   1B3do1cQ+8/WLUOjF63Jjk01x0FTFWrN+CfuEEMV3SD3bZ5K4Ir9u4K4b
   KLgth6eJ3wtVrj29y3LsEsdmmsApAurm4rAclzrvHwZPMYFHOafE2fjKZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293228828"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293228828"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583668126"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.172])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:30 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V3 5/8] migrate_pages(): fix failure counting for THP on -ENOSYS
Date:   Wed, 17 Aug 2022 16:14:05 +0800
Message-Id: <20220817081408.513338-6-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817081408.513338-1-ying.huang@intel.com>
References: <20220817081408.513338-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If THP or hugetlbfs page migration isn't supported, unmap_and_move()
or unmap_and_move_huge_page() will return -ENOSYS.  For THP, splitting
will be tried, but if splitting doesn't succeed, the THP will be left
in "from" list wrongly.  If some other pages are retried, the THP
migration failure will counted again.  This is fixed via moving the
failure THP from "from" to "ret_pages".

Another issue of the original code is that the unsupported failure
processing isn't consistent between THP and hugetlbfs page.  Make them
consistent in this patch to make the code easier to be understood too.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 0018b5191799..0223673e42d1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1260,10 +1260,8 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	 * tables or check whether the hugepage is pmd-based or not before
 	 * kicking migration.
 	 */
-	if (!hugepage_migration_supported(page_hstate(hpage))) {
-		list_move_tail(&hpage->lru, ret);
+	if (!hugepage_migration_supported(page_hstate(hpage)))
 		return -ENOSYS;
-	}
 
 	if (page_count(hpage) == 1) {
 		/* page was freed from under us. So we are done. */
@@ -1460,6 +1458,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			 *		 page will be put back
 			 *	-EAGAIN: stay on the from list
 			 *	-ENOMEM: stay on the from list
+			 *	-ENOSYS: stay on the from list
 			 *	Other errno: put on ret_pages list then splice to
 			 *		     from list
 			 */
@@ -1489,6 +1488,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				}
 
 				nr_failed_pages += nr_subpages;
+				list_move_tail(&page->lru, &ret_pages);
 				break;
 			case -ENOMEM:
 				/*
-- 
2.30.2

