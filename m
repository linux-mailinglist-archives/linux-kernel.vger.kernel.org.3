Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B28538D64
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245059AbiEaJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbiEaJEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:04:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C52E31DC6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:04:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D780423A;
        Tue, 31 May 2022 02:04:54 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6784E3F766;
        Tue, 31 May 2022 02:04:52 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] mm/memory_hotplug: Drop 'reason' argument from check_pfn_span()
Date:   Tue, 31 May 2022 14:34:41 +0530
Message-Id: <20220531090441.170650-1-anshuman.khandual@arm.com>
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
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V3:

- Combined both IS_ALIGNED() checks (pfn and nr_pages) as per David

Changes in V2:

https://lore.kernel.org/all/20220526021258.4030749-1-anshuman.khandual@arm.com/

- Fixed typo in commit message
- Dropped using 'ret' to capture check_pfn_span() return value in __add_pages()

Changes in V1:

https://lore.kernel.org/all/20220525033910.3781764-1-anshuman.khandual@arm.com/


 mm/memory_hotplug.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1213d0c67a53..1f1a730c4499 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -237,8 +237,7 @@ static void release_memory_resource(struct resource *res)
 	kfree(res);
 }
 
-static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
-		const char *reason)
+static int check_pfn_span(unsigned long pfn, unsigned long nr_pages)
 {
 	/*
 	 * Disallow all operations smaller than a sub-section and only
@@ -255,12 +254,8 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 		min_align = PAGES_PER_SUBSECTION;
 	else
 		min_align = PAGES_PER_SECTION;
-	if (!IS_ALIGNED(pfn, min_align)
-			|| !IS_ALIGNED(nr_pages, min_align)) {
-		WARN(1, "Misaligned __%s_pages start: %#lx end: #%lx\n",
-				reason, pfn, pfn + nr_pages - 1);
+	if (!IS_ALIGNED(pfn | nr_pages, min_align))
 		return -EINVAL;
-	}
 	return 0;
 }
 
@@ -337,9 +332,10 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
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
@@ -536,8 +532,10 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
 
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

