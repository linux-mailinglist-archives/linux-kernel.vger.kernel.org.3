Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE8959E8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244942AbiHWRMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344887AbiHWRL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:11:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CE011B026
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661263105; x=1692799105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pCoa6Ugj2AJRPyPGUlNmHln305j0xDKrwGnvaLsDdR0=;
  b=NxmDAwNXChKMGciN5YBa8dyaY4+FKC7qMrVWETJIvwlxHYpMmh5n0tlD
   5WXsEM6EwL623C5R11gr/Wbr+W9R6+ch4WMZxNTQb6dQHtnPDjkfUw/Pz
   BrDpl8cPchyjEI6ukqetkSQrIWJ/rNmiYe/c4rfTjZeceU3ifzNucZSTm
   f2ZOyUtroWPjVuNkmisPbDj2mJDq9a3q6h33XCcyU7VsLv7hUF4hWrezg
   2yQ4IcY7dIw2LfYcwqY0RQnNBjOIduOT0GcwECl44HVNwUF2vp9rtZt0R
   KqxST7fBnAv5qYLTSz4FRY0+7PedcWRSjVIpcaUNTu9dOnlFduwDqNhP1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="357669573"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="357669573"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 06:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="638663353"
Received: from sse-cse-haiyue-nuc.sh.intel.com ([10.239.241.114])
  by orsmga008.jf.intel.com with ESMTP; 23 Aug 2022 06:58:22 -0700
From:   Haiyue Wang <haiyue.wang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, apopple@nvidia.com,
        linmiaohe@huawei.com, ying.huang@intel.com,
        songmuchun@bytedance.com, naoya.horiguchi@linux.dev,
        alex.sierra@amd.com, mike.kravetz@oracle.com,
        gerald.schaefer@linux.ibm.com, Haiyue Wang <haiyue.wang@intel.com>
Subject: [PATCH v7 0/2] fix follow_page related issues
Date:   Tue, 23 Aug 2022 21:58:39 +0800
Message-Id: <20220823135841.934465-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.37.2
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

v7: Drop the zone device page check for transparent page.

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

 mm/huge_memory.c |  2 +-
 mm/ksm.c         | 12 +++++++++---
 mm/migrate.c     | 23 +++++++++++++++++------
 3 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.37.2

