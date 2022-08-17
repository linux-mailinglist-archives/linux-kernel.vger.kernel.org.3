Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA314596B21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiHQIPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbiHQIOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:14:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ACF543CB
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660724071; x=1692260071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yhmojqv78CNeejAgfGN/fV62nXwRC1Wfl6ID7EB6l2s=;
  b=gl9DlfyrauDE25KEHLHtO2JpIBQIKRWO6xnABB0epK46bTuosluMr2dG
   4Au/lJ29XGGLGO6PBagd3d1uTa2Emnz8g/gR//+sLQkt85ow9VuT0+Gvp
   bxGX4Zd10p8+eN32t8poVS/vmq/Thmfew0B+30MMX78dvNdHY36i+glLS
   HvI+tFYga/22hmLwus5SrCLvHEY4ss43OinYNErpItiZGGVWYt/yuFG1a
   tCf9jafLoViiGkjuOr7/A6F7/5n7pcpPuZffmnZMrww/mhPR/2y7KfwQA
   Vn1cH8lhho7UPpl0Ni9om7YQbSs7xOzkPEHWD4BO8EcBIwVOYaAXOmlHH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293228818"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293228818"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583668113"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.172])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:28 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V3 4/8] migrate_pages(): fix failure counting for THP subpages retrying
Date:   Wed, 17 Aug 2022 16:14:04 +0800
Message-Id: <20220817081408.513338-5-ying.huang@intel.com>
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

If THP is failed to be migrated for -ENOSYS and -ENOMEM, the THP will
be split into thp_split_pages, and after other pages are migrated,
pages in thp_split_pages will be migrated with no_subpage_counting ==
true, because its failure have been counted already.  If some pages in
thp_split_pages are retried during migration, we should not count
their failure if no_subpage_counting == true too.  This is done this
patch to fix the failure counting for THP subpages retrying.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ae55f08e72ce..0018b5191799 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1545,7 +1545,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			}
 		}
 	}
-	nr_failed += retry;
+	if (!no_subpage_counting)
+		nr_failed += retry;
 	nr_thp_failed += thp_retry;
 	/*
 	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
-- 
2.30.2

