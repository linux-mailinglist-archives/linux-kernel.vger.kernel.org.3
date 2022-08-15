Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED27592A09
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbiHOHCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241254AbiHOHCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:02:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E09DEA0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660546951; x=1692082951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6y3vJM03inTN3n4fTtr3sj64MkkloN/gZvJBPW9m2l0=;
  b=dIrfVjlHj2h0aSKI+F0HK7c9chMOayaR3RY+VGYSPt/hyYglmEVlF+Wx
   pXmE+ebnDGGgzB2Q1nHfTmJ5aULsWbUJyvNpgBahg+HysHt15I5VqpF0X
   gXY3uBU2v3CZwn29/WC5egYTUwzANMnC30OWomydorZrUF5TF2akOZmNd
   4B3JH03EkUzf81Y9kJhxYbnQEBUyTFIY8iAKzBg1RXwugBVyZnp2w0cj5
   eeXs6i1jCioZUL7Dk2x1ueGD9ZQrkoCQUIqkhyXB1ZXu4m+w6M7LcoZGZ
   HnGsy+efy1CpD9OelA+iYuPUlejxYtFh7dX29X+XgBwoCBJ4raT5Xg3B1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="274960253"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="274960253"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 00:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="666566767"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2022 00:02:27 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, apopple@nvidia.com,
        linmiaohe@huawei.com, ying.huang@intel.com,
        songmuchun@bytedance.com, naoya.horiguchi@linux.dev,
        alex.sierra@amd.com, Haiyue Wang <haiyue.wang@intel.com>
Subject: [PATCH v5 1/2] mm: migration: fix the FOLL_GET failure on following huge page
Date:   Mon, 15 Aug 2022 15:02:39 +0800
Message-Id: <20220815070240.470469-2-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815070240.470469-1-haiyue.wang@intel.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220815070240.470469-1-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all huge page APIs support FOLL_GET option, so move_pages() syscall
will fail to get the page node information for some huge pages.

Like x86 on linux 5.19 with 1GB huge page API follow_huge_pud(), it will
return NULL page for FOLL_GET when calling move_pages() syscall with the
NULL 'nodes' parameter, the 'status' parameter has '-2' error in array.

Note: follow_huge_pud() now supports FOLL_GET in linux 6.0.
      Link: https://lore.kernel.org/all/20220714042420.1847125-3-naoya.horiguchi@linux.dev

But these huge page APIs don't support FOLL_GET:
  1. follow_huge_pud() in arch/s390/mm/hugetlbpage.c
  2. follow_huge_addr() in arch/ia64/mm/hugetlbpage.c
     It will cause WARN_ON_ONCE for FOLL_GET.
  3. follow_huge_pgd() in mm/hugetlb.c

This is an temporary solution to mitigate the side effect of the race
condition fix by calling follow_page() with FOLL_GET set for huge pages.

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

