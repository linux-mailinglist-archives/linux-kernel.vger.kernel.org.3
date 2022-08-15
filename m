Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AEE592759
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiHOBDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHOBDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:03:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAF4DFC2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660525419; x=1692061419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SnO+KuyY2Ig6pp+7jgz3mFNr913uLAxnryQVGv4z4qw=;
  b=TfgyAjTcLo34s2I8WfF5bBGn+TaA2C8c7VhMHpKpIe6ekij2VBVBVP1H
   p8Jq1lNeXQb4LPu3ODePz5njFjwTzAfOtS+MeSPvYB1G40DuOaOh29RGr
   bH6tYnWEQGH1btFSaYjdEvntyB7EWnI8l89g07/jbMOBQAM8cNXjelMps
   VL9Svp9oE4P9p80/yVleYN1fsezrvBn1WA5O0wLRIRu8mufxQmZq0gcZz
   kIH+BDKVN9D3DBKslknsgBOKLPjU2/2bBJXY4Q9Stxq5pS9ZxI7qOcLBv
   89oSxIqCN11oAhE7jlCuMvU7fzAB+42jE+b8GZrsjb7bMfrWz5S0L6otN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="355872161"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="355872161"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 18:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="695823581"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Aug 2022 18:03:36 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, linmiaohe@huawei.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, alex.sierra@amd.com,
        Haiyue Wang <haiyue.wang@intel.com>
Subject: [PATCH v3 1/2] mm: migration: fix the FOLL_GET failure on following huge page
Date:   Mon, 15 Aug 2022 09:03:48 +0800
Message-Id: <20220815010349.432313-2-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815010349.432313-1-haiyue.wang@intel.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220815010349.432313-1-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.37.2

