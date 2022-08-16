Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD9D595331
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiHPG6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiHPG54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:57:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE88DE992E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660616447; x=1692152447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MvtxoyXdbD8IhpYSw22bukxIMLJ6r6tkTtWGcsAxUc8=;
  b=TYP5oaywmshxrErYdmjzU+hM8bL4gkmFHuG0dQJitEyS09Y8jUDYkAVW
   SuHoVs9kEomqasJwzpS/Z39BT4zekD7kpSMa3vd4v19oHchKsnGWpEQms
   rk9mnWN9lyr6fltN8ODxDOTnGzGo+uhTBWlCYAy3xRRF1oJB9Wu/7NQS7
   rWorgJiziYkBtvPAGE4J85EGFglzIrnIOjsxso8UJmHgGx3lL/hl2jGhZ
   yvpWw/PG1GYQGsS/AUnAwmm73YVlMwuP97EQ9DEVItBkKfIBx6uPV6QKX
   EFKpumE0u/hshjo5gR3/xd6hUrCTQoBJbYnuG/I7PoXhbwFhzdwSj5xjQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="378396205"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="378396205"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 19:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="934706641"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by fmsmga005.fm.intel.com with ESMTP; 15 Aug 2022 19:20:45 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, apopple@nvidia.com,
        linmiaohe@huawei.com, ying.huang@intel.com,
        songmuchun@bytedance.com, naoya.horiguchi@linux.dev,
        alex.sierra@amd.com, Haiyue Wang <haiyue.wang@intel.com>
Subject: [PATCH v6 0/2] fix follow_page related issues
Date:   Tue, 16 Aug 2022 10:20:59 +0800
Message-Id: <20220816022102.582865-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220812084921.409142-1-haiyue.wang@intel.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
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

v6: Simplify the multiple layers of conditionals for if {}

-               if (page) {
-                       err = !is_zone_device_page(page) ? page_to_nid(page)
-                                                        : -ENOENT;
-                       if (foll_flags & FOLL_GET)
-                               put_page(page);
-               } else {
-                       err = -ENOENT;
-               }
+               err = -ENOENT;
+               if (!page)
+                       goto set_status;
+
+               if (!is_zone_device_page(page))
+                       err = page_to_nid(page);
+
+               if (foll_flags & FOLL_GET)
+                       put_page(page);

v5: reword the commit message for FOLL_GET with more information.

v4: add '()' for the function for readability.
    add more words about the Non-LRU pages fix in commit message.

v3: Merge the fix for handling Non-LRU pages into one patch.
    Drop the break_ksm zone device page check.

v2: Add the Non-LRU pages fix with two patches, so that
    'mm: migration: fix the FOLL_GET' can be applied directly
    on linux-5.19 stable branch.

Haiyue Wang (2):
  mm: migration: fix the FOLL_GET failure on following huge page
  mm: fix the handling Non-LRU pages returned by follow_page

 mm/huge_memory.c |  4 ++--
 mm/ksm.c         | 12 +++++++++---
 mm/migrate.c     | 23 +++++++++++++++++------
 3 files changed, 28 insertions(+), 11 deletions(-)

-- 
2.37.2

