Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5D85927A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiHOB7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiHOB67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:58:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CEB12AB3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660528738; x=1692064738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SnO+KuyY2Ig6pp+7jgz3mFNr913uLAxnryQVGv4z4qw=;
  b=hCyKHYXYhw/Nc9/CtPAHJlapN9nORTQ2LxFWoE9suBqJBwkY79N5EyWj
   SKye5swHEgYPUqQlUI8vkUA8Jypx0lFKdk/pqyQerAHDSN1uQY+h2q0WX
   yoEwZYTliRAy/HK0syn7JAsDeljz4I4GAd0O59ocV1f7GfB5dKXnyN3j0
   +NKMO2kNBrJKpHioBEva5+XLU3evsr7H5HAsHR0MfK9Kch/xtoxfwg+YE
   C/42LTvgiJbu+QL02eAEcYAZBry/JTT3CSfn9aU6gL/GNVn4ekgdL9HME
   GbXxAfaix/Cn2hQu3Nhh5ZOtfc0ArElDiKVlPPZfUc33XbiW6N0HToZjL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="292667571"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="292667571"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 18:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="557132019"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2022 18:58:55 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, linmiaohe@huawei.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, alex.sierra@amd.com,
        Haiyue Wang <haiyue.wang@intel.com>
Subject: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure on following huge page
Date:   Mon, 15 Aug 2022 09:59:08 +0800
Message-Id: <20220815015909.439623-2-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815015909.439623-1-haiyue.wang@intel.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220815015909.439623-1-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all huge page APIs support FOLL_GET option, so the __NR_move_pages
will fail to get the page node information for huge page.

This is an temporary solution to mitigate the racing fix.

After supporting follow huge page by FOLL_GET is done, this fix can be
reverted safely.

Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_array racing with memory offline")
Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 mm/migrate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6a1597c92261..581dfaad9257 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1848,6 +1848,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 
 	for (i = 0; i < nr_pages; i++) {
 		unsigned long addr = (unsigned long)(*pages);
+		unsigned int foll_flags = FOLL_DUMP;
 		struct vm_area_struct *vma;
 		struct page *page;
 		int err = -EFAULT;
@@ -1856,8 +1857,12 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 		if (!vma)
 			goto set_status;
 
+		/* Not all huge page follow APIs support 'FOLL_GET' */
+		if (!is_vm_hugetlb_page(vma))
+			foll_flags |= FOLL_GET;
+
 		/* FOLL_DUMP to ignore special (like zero) pages */
-		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
+		page = follow_page(vma, addr, foll_flags);
 
 		err = PTR_ERR(page);
 		if (IS_ERR(page))
@@ -1865,7 +1870,8 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 
 		if (page && !is_zone_device_page(page)) {
 			err = page_to_nid(page);
-			put_page(page);
+			if (foll_flags & FOLL_GET)
+				put_page(page);
 		} else {
 			err = -ENOENT;
 		}
-- 
2.37.2

