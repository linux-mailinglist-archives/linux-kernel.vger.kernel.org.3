Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA61590DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiHLItV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbiHLItM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:49:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EAEA9242
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660294149; x=1691830149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+nxW0bEQ9sv51ybHeEN8SKdGEjqYmcdcOKMXIfq1QOk=;
  b=bQMzTJW/miXpv3xHcoC4aXrfYS+qotPTts7dF79qPrMkccTd2ctDffSB
   4nIRAKzuRv2tP/PUAjxqqFe0OjSHofeK3pbHr/2qZTzrl0ymPYEkBemLb
   /OeYZ0nv3E0xo5kPP1Yr45nIkaYnqQZzjnA1yjShhf98/Q6TuweJEPMEu
   WnYmjDydJ321tI+VY8yb2NkYvDXyomdXJUWpraS0Zl8R6HhEN6vD/evnw
   lGt4w8+GgEJR526DYhUNO9Ef1je7v5S7Df3XrZqsMW3q8XWaKuV4lGAYX
   59ZerqeJtGAeLZdUVKb6eBKgaWXLqvVah3YKt9Z9/StNQtISb7kj5mLeP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="290309761"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="290309761"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 01:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="748128925"
Received: from unknown (HELO dsg-bmc-sherry-3.sh.intel.com) ([10.239.138.101])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2022 01:49:07 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, linmiaohe@huawei.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, Haiyue Wang <haiyue.wang@intel.com>
Subject: [PATCH v1] mm: migration: fix the FOLL_GET failure on following huge page
Date:   Fri, 12 Aug 2022 16:49:21 +0800
Message-Id: <20220812084921.409142-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.37.1

