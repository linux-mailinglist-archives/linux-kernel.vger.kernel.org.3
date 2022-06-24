Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FF0558D90
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiFXCxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiFXCxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:53:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D658E25C51
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656039219; x=1687575219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dyatKl+uw3fFNQdVpp0JrZk8BbuYdjsdo/ZbC0KvS1w=;
  b=Z1ML8nd1syQz8qTjLuyi2A+TOdDYFm3TUi1rQ7nxg0KzTNOQE3Sej5F9
   JepxzrYGoQxPIOwI96szDv/sHUgpmkiHDWl3ciJcoj3mDSPzgZhuOG1cG
   5O+X9fv20512RYQ1wR74xwrKf/gRCLPzjLmaU/tQwZgicygwFYgV1/Byc
   2EPGgPjiqzrbrsgfo9FlxZMKs/dHK3BuD7avgpbk1DYaEZrKWpon8QDQP
   sgMSUMZlHoMrd/idfIi/MFJfORptxe+AyLNBbmIF7BYEUwzea/+CDJhLa
   JlpxxssuVZ1QdJl79BqhzV2qMeZJ2xxqOMkxUc+glzOVE/karKZypERBY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="279672730"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="279672730"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:53:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="593018090"
Received: from yxia2-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.214.143])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:53:37 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: [PATCH 4/7] migrate_pages(): fix failure counting for THP subpages retrying
Date:   Fri, 24 Jun 2022 10:53:06 +0800
Message-Id: <20220624025309.1033400-5-ying.huang@intel.com>
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

If THP is failed to be migrated for -ENOSYS and -ENOMEM, the THP will
be split into thp_split_pages, and after other pages are migrated,
pages in thp_split_pages will be migrated with no_subpage_counting ==
true, because its failure have been counted already.  If some pages in
thp_split_pages are retried during migration, we should not count
their failure if no_subpage_counting == true too.  This is done this
patch to fix the failure counting for THP subpages retrying.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 542533e4e3cf..61dab3025a1d 100644
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

