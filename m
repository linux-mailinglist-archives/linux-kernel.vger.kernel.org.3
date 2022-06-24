Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4780C558D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiFXCxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiFXCxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:53:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D392E9D2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656039217; x=1687575217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zkfooEuAcL1s/GMfIWYGeryZUxTknJxESw3mSAR4BLA=;
  b=LXo/4aZewFsFDElFuqMINljESYzYdijT/Qen49/5pEcIvJm5oQnq8kCp
   0BPnbAHEA8jEwnPyWqiQE7sfbi6tDsTDpbMLg45phvSHWvi0wpEi+ctBA
   tvPXmyoTH11WTBNTsvxn4AWcjbzNAoA1rfBWMvGsohGacwlLRD0ISsq12
   vuVTx+I1UIm6K7aJwmhHfNKsFG6ZYbHJR9aAkQsHYjLFWaAnKOZQVrhmX
   bKe1mSgwEv3sa/+/NwXe18ofZMsZByW8pxHIgc8lOuEn6nk/jzIDBntyq
   lqDuvKSDDLlOFEr1HIR5u20ff89LUA8cc/yks9NBkmH/KuRdKPUPBxdWy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="279672724"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="279672724"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:53:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="593018084"
Received: from yxia2-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.214.143])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:53:35 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: [PATCH 3/7] migrate_pages(): fix THP failure counting for -ENOMEM
Date:   Fri, 24 Jun 2022 10:53:05 +0800
Message-Id: <20220624025309.1033400-4-ying.huang@intel.com>
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

In unmap_and_move(), if the new THP cannot be allocated, -ENOMEM will
be returned, and migrate_pages() will try to split the THP unless
"reason" is MR_NUMA_MISPLACED (that is, nosplit == true).  But when
nosplit == true, the THP migration failure will not be counted.  This
is incorrect.  So in this patch, the THP migration failure will be
counted for -ENOMEM regardless of nosplit is true or false.  The
nr_failed counting is fixed too, although that is not used actually.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 82444e7df9f1..542533e4e3cf 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1425,11 +1425,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				/*
 				 * When memory is low, don't bother to try to migrate
 				 * other pages, just exit.
-				 * THP NUMA faulting doesn't split THP to retry.
 				 */
-				if (is_thp && !nosplit) {
+				if (is_thp) {
 					nr_thp_failed++;
-					if (!try_split_thp(page, &thp_split_pages)) {
+					/* THP NUMA faulting doesn't split THP to retry. */
+					if (!nosplit && !try_split_thp(page, &thp_split_pages)) {
 						nr_thp_split++;
 						goto retry;
 					}
@@ -1446,6 +1446,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 */
 				list_splice_init(&thp_split_pages, from);
 				nr_thp_failed += thp_retry;
+				if (!no_subpage_counting)
+					nr_failed += retry;
 				goto out;
 			case -EAGAIN:
 				if (is_thp)
-- 
2.30.2

