Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C6B596B34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiHQIPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiHQIOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:14:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F74D4F5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660724068; x=1692260068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DKaFW9nCQZCfgbnugNhK3BHbzcTIAzrfbLSevgdOECU=;
  b=hOJLViGJDeG0qBsrnrzllQvV86KvQYgUKIdQaTeYo1JOKXpXCHlZgvBf
   d1JpoC0HHwa/4cSm4shQEdMH3dyPHzhXp1XALW9uYHHfJWnLUNmwy3dOa
   BX7urKtZJ6WEiCi/6UQcbHQBIKCNnaP+Wt83G+ao6ZirdmctS0BAOONR4
   zq6tMZe2F2b73evJWWnCagyVQBQY84a9PQR81QSgNmn+sROXGqEC1J/k4
   TT0jM0VXHDkNTqKJTEbb9I+nMDakm94eqQF7lnjRPC2L7X52Nmievp9fh
   T77Nh/VKjup1uhrWxX+ssy6cSC3TPx1aMz9qn+3a1sUhpQAbDM2UZT4Zl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293228809"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293228809"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583668098"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.172])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:25 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V3 3/8] migrate_pages(): fix THP failure counting for -ENOMEM
Date:   Wed, 17 Aug 2022 16:14:03 +0800
Message-Id: <20220817081408.513338-4-ying.huang@intel.com>
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

In unmap_and_move(), if the new THP cannot be allocated, -ENOMEM will
be returned, and migrate_pages() will try to split the THP unless
"reason" is MR_NUMA_MISPLACED (that is, nosplit == true).  But when
nosplit == true, the THP migration failure will not be counted.  This
is incorrect.  So in this patch, the THP migration failure will be
counted for -ENOMEM regardless of nosplit is true or false.  The
nr_failed counting isn't fixed because it's not used.  Added some
comments for it per Baolin's suggestion.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 19a9b26af7e2..ae55f08e72ce 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1494,11 +1494,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
@@ -1514,6 +1514,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 * the caller otherwise the page refcnt will be leaked.
 				 */
 				list_splice_init(&thp_split_pages, from);
+				/* nr_failed isn't updated for not used */
 				nr_thp_failed += thp_retry;
 				goto out;
 			case -EAGAIN:
-- 
2.30.2

