Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAC7595334
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiHPG6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiHPG55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:57:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C01E992F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660616450; x=1692152450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OvL9/IKf/g+zRmxGRGIODU/Jn6YGizzjnlk8aW6h8us=;
  b=fKVzXYEkQUf7FpAeprSFq/o7lL+9br0kaum4XEKS+qf6J26kcN+VawIv
   y+woMpE059uLkr/5G/xFqjSTQmTS/g+zoZH460DK6bKFOfie/BYbjjtYk
   mXjemEKMnrwP7IG34dhPXteNVWAlvn4NmvGaO2YtqQnmYk8JTCiK7OCiY
   5ViG5gFz7kKof9kDSYBJtA7VraK5/Qou0/AfU6g3O2s6uSY6IoOaCoGCk
   sIu3t8vsjwt9MfeU/oGTJD0bh8EBllCSZy2I2q+Gxil4Y7dVPOXpAGOCk
   /VyQFX3hIbxwAtSj3WLsXPFiCmbFtXBbpfYyMekeAAdT8KS3sIhdLbkkx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="378396212"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="378396212"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 19:20:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="934706650"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by fmsmga005.fm.intel.com with ESMTP; 15 Aug 2022 19:20:47 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, apopple@nvidia.com,
        linmiaohe@huawei.com, ying.huang@intel.com,
        songmuchun@bytedance.com, naoya.horiguchi@linux.dev,
        alex.sierra@amd.com, Haiyue Wang <haiyue.wang@intel.com>
Subject: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on following huge page
Date:   Tue, 16 Aug 2022 10:21:00 +0800
Message-Id: <20220816022102.582865-2-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220816022102.582865-1-haiyue.wang@intel.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
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

