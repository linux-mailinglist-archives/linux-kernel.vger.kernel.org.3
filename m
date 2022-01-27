Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDEB49DD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbiA0I4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:56:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43588 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbiA0I40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:56:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0505561B27
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EE1C340E4;
        Thu, 27 Jan 2022 08:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643273785;
        bh=lNqF3mJPDGw233av00HH2FDJ+SSvpcSySTuoi9rmynY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sJub49UhZPTd7ncg8oXuofMZCo6X6gobjlkjNoRy1y+1HXcBHY+U6J8JKdChxUTlV
         R0xl4kpRAEkFcrTPU6gRBfYM2BxXOpQfX0BtpGfzuTwNcRpzrCWaJ3MmUQBMghVCTG
         OJFATAVFmYipeykdrlEZh2HYxm7jdb1pXj5tnJIhqIMdphYOG3rB3n7imGJu7/k7J/
         rn77s05xi4g8Zw3XSc5a2YXu5jj4cgL2/P/zPqnr5yAe0MevN/qqGNbO6QJsGtTWR5
         RE2fUvXkZAa2V4Huqd6ilml4no4fCJ25F1FDH8W5K0+EfZI6s0cKz6wMJ2deM3cgez
         XB8H56ynUjqzg==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [RFC PATCH 2/3] mm/secretmem: use __GFP_UNMAPPED to allocate pages
Date:   Thu, 27 Jan 2022 10:56:07 +0200
Message-Id: <20220127085608.306306-3-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127085608.306306-1-rppt@kernel.org>
References: <20220127085608.306306-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Currently secertmem explicitly removes allocated pages from the direct map.
This fragments direct map because allocated pages may reside in different
pageblocks.

Use __GFP_UNMAPPED to utilize caching of unmapped pages done by the page
allocator.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/secretmem.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 22b310adb53d..878ef004d7a7 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -63,16 +63,10 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 retry:
 	page = find_lock_page(mapping, offset);
 	if (!page) {
-		page = alloc_page(gfp | __GFP_ZERO);
+		page = alloc_page(gfp | __GFP_ZERO | __GFP_UNMAPPED);
 		if (!page)
 			return VM_FAULT_OOM;
 
-		err = set_direct_map_invalid_noflush(page);
-		if (err) {
-			put_page(page);
-			return vmf_error(err);
-		}
-
 		__SetPageUptodate(page);
 		err = add_to_page_cache_lru(page, mapping, offset, gfp);
 		if (unlikely(err)) {
-- 
2.34.1

