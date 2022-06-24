Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1574558D91
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiFXCxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiFXCxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:53:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1B951E61
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656039221; x=1687575221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B27oFNEx1h03uzrh6vOGjjj8DzLgj+BCfNPDGu9pWbA=;
  b=DiDTYVWbXz7soCvqp/x5rZamQZq63U8LDKGjw3UAhRsnd+uv/DT/RGw/
   tlLHG7dDCs4/S1yOkeLF1vq29KEQKO9dIrwuxB8eIlIOtUQ6fUrfhpjRU
   421+q1OqeYyFL+mTnFUmrB6FhSHrxm3e9rCl6DQu5rG/WfetpE+aH1IWj
   I00o8oms26zRkIebWbLjcpnt4rQV4Bc4KWsInVwLo7N82XtcW7CNbj9qk
   GYEw9J3fuwWcXSFgnJtxK+weGlb5A+vwuPFFWiHu34xTTgWhqwmj0BOP8
   GPYxrh2g+5Jdh3pu0bxhn7d7uDYERdo9z+YvhYSDFIhgyutvwB6W4Opp5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="279672739"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="279672739"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:53:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="593018097"
Received: from yxia2-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.214.143])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:53:39 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: [PATCH 5/7] migrate_pages(): fix failure counting for THP on -ENOSYS
Date:   Fri, 24 Jun 2022 10:53:07 +0800
Message-Id: <20220624025309.1033400-6-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220624025309.1033400-1-ying.huang@intel.com>
References: <20220624025309.1033400-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 61dab3025a1d..9d1883d5927f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1191,10 +1191,8 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
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
@@ -1391,6 +1389,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			 *		 page will be put back
 			 *	-EAGAIN: stay on the from list
 			 *	-ENOMEM: stay on the from list
+			 *	-ENOSYS: stay on the from list
 			 *	Other errno: put on ret_pages list then splice to
 			 *		     from list
 			 */
@@ -1420,6 +1419,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				}
 
 				nr_failed_pages += nr_subpages;
+				list_move_tail(&page->lru, &ret_pages);
 				break;
 			case -ENOMEM:
 				/*
-- 
2.30.2

