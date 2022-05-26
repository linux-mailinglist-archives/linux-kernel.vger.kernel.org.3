Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9AF5348A1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345923AbiEZCNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiEZCNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:13:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 326F78BD0A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:13:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E3421474;
        Wed, 25 May 2022 19:13:08 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.43.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 124103F70D;
        Wed, 25 May 2022 19:13:05 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/memory_hotplug: Drop 'reason' argument from check_pfn_span()
Date:   Thu, 26 May 2022 07:42:58 +0530
Message-Id: <20220526021258.4030749-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In check_pfn_span(), a 'reason' string is being used to recreate the caller
function name, while printing the warning message. It is really unnecessary
as the warning message could just be printed inside the caller depending on
the return code. Currently there are just two callers for check_pfn_span()
i.e  __add_pages() and __remove_pages(). Let's clean this up.

Cc: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V2:

- Fixed typo in commit message
- Dropped using 'ret' to capture check_pfn_span() return value in __add_pages()

Changes in V1:

https://lore.kernel.org/all/20220525033910.3781764-1-anshuman.khandual@arm.com/

 mm/memory_hotplug.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 416b38ca8def..3b24386e9276 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -220,8 +220,7 @@ static void release_memory_resource(struct resource *res)
 	kfree(res);
 }
 
-static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
-		const char *reason)
+static int check_pfn_span(unsigned long pfn, unsigned long nr_pages)
 {
 	/*
 	 * Disallow all operations smaller than a sub-section and only
@@ -238,12 +237,8 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 		min_align = PAGES_PER_SUBSECTION;
 	else
 		min_align = PAGES_PER_SECTION;
-	if (!IS_ALIGNED(pfn, min_align)
-			|| !IS_ALIGNED(nr_pages, min_align)) {
-		WARN(1, "Misaligned __%s_pages start: %#lx end: #%lx\n",
-				reason, pfn, pfn + nr_pages - 1);
+	if (!IS_ALIGNED(pfn, min_align) || !IS_ALIGNED(nr_pages, min_align))
 		return -EINVAL;
-	}
 	return 0;
 }
 
@@ -320,9 +315,10 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 		altmap->alloc = 0;
 	}
 
-	err = check_pfn_span(pfn, nr_pages, "add");
-	if (err)
-		return err;
+	if (check_pfn_span(pfn, nr_pages)) {
+		WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__, pfn, pfn + nr_pages - 1);
+		return -EINVAL;
+	}
 
 	for (; pfn < end_pfn; pfn += cur_nr_pages) {
 		/* Select all remaining pages up to the next section boundary */
@@ -518,8 +514,10 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
 
 	map_offset = vmem_altmap_offset(altmap);
 
-	if (check_pfn_span(pfn, nr_pages, "remove"))
+	if (check_pfn_span(pfn, nr_pages)) {
+		WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__, pfn, pfn + nr_pages - 1);
 		return;
+	}
 
 	for (; pfn < end_pfn; pfn += cur_nr_pages) {
 		cond_resched();
-- 
2.20.1

