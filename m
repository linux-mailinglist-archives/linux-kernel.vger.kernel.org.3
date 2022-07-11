Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539A356D8CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiGKIum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiGKIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:50:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2062F19C3F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657529412; x=1689065412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RJQzdlyWZrxxXfyYtTiwuvRSPwvEeRLnDLri6vLxLHk=;
  b=TOKpT6pR1U1LzB7XBa1oHctWh6EiPL/5ri70cGYABs8BcFFDFp3iB+4a
   HiXiO2+cDY1rRBCtgzaOT9vPWbM0cl9Y3gNYawoHRzujwZF+wk5QacpJv
   rtF7WYOAq16RoPBKtrcb8xnj6pLIowHeJ6MdPQsZGs1wYDI2GFkK9gOx0
   8RKKSDZ1fnZXW5vNTwHIE8jI/fi28osh6yBcB6Lx8/oof8SKatdPWeERT
   1GE3h94GHpV+2RK3hj4AZ/aipC0AuDwjqPSA34QFSEvxxCVw/7wFeY+UI
   zBzpqBw++Eq3vcWcLC30m5HMiW5g1o6p5c7YF1Xt/IQ+z7XrVHbQPY+GY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="284637847"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="284637847"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 01:50:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="652374146"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.5.168])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 01:50:09 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V2 4/7] migrate_pages(): fix failure counting for THP subpages retrying
Date:   Mon, 11 Jul 2022 16:49:45 +0800
Message-Id: <20220711084948.274787-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711084948.274787-1-ying.huang@intel.com>
References: <20220711084948.274787-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 38e2c789a9c3..4bceba143db0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1477,7 +1477,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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

