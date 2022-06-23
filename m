Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6665D558A62
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiFWUxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiFWUxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A10D60F1D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656017620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SKr6IwB9oB2LzPFxK05h2N5R7Daz8qwDGxn0Mk5elPQ=;
        b=cZ/SsI/I9ZRQ2plr1eAtDx+Le+ZxupVAK4iDO5rnMlVzMa1GGaCdsJ/54Fu3xJvlStSiKO
        jTW9ZD5/thxyfl/0R53DnHtb/oMWpgDdtPfx0hmiDhrzhUXiNhzxp6d0/cw7U7NSepSrn0
        b5OSC6ewnDmaBbssZpWI0BD6aeMkktQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-S6TYGcl1M5iKX4IkK1V3Xg-1; Thu, 23 Jun 2022 16:53:35 -0400
X-MC-Unique: S6TYGcl1M5iKX4IkK1V3Xg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A7AD185A7B2;
        Thu, 23 Jun 2022 20:53:35 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BDD017452;
        Thu, 23 Jun 2022 20:53:33 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v1] mm/rmap: fix dereferencing invalid subpage pointer in try_to_migrate_one()
Date:   Thu, 23 Jun 2022 22:53:32 +0200
Message-Id: <20220623205332.319257-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subpage we calculate is an invalid pointer for device private pages,
because device private pages are mapped via non-present device private
entries, not ordinary present PTEs.

Let's just not compute broken pointers and fixup later. Move the proper
assignment of the correct subpage to the beginning of the function and
assert that we really only have a single page in our folio.

This currently results in a BUG when tying to compute anon_exclusive,
because:

[  528.727237] BUG: unable to handle page fault for address: ffffea1fffffffc0
[  528.739585] #PF: supervisor read access in kernel mode
[  528.745324] #PF: error_code(0x0000) - not-present page
[  528.751062] PGD 44eaf2067 P4D 44eaf2067 PUD 0
[  528.756026] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  528.760890] CPU: 120 PID: 18275 Comm: hmm-tests Not tainted 5.19.0-rc3-kfd-alex #257
[  528.769542] Hardware name: AMD Corporation BardPeak/BardPeak, BIOS RTY1002BDS 09/17/2021
[  528.778579] RIP: 0010:try_to_migrate_one+0x21a/0x1000
[  528.784225] Code: f6 48 89 c8 48 2b 05 45 d1 6a 01 48 c1 f8 06 48 29
c3 48 8b 45 a8 48 c1 e3 06 48 01 cb f6 41 18 01 48 89 85 50 ff ff ff 74
0b <4c> 8b 33 49 c1 ee 11 41 83 e6 01 48 8b bd 48 ff ff ff e8 3f 99 02
[  528.805194] RSP: 0000:ffffc90003cdfaa0 EFLAGS: 00010202
[  528.811027] RAX: 00007ffff7ff4000 RBX: ffffea1fffffffc0 RCX: ffffeaffffffffc0
[  528.818995] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003cdfaf8
[  528.826962] RBP: ffffc90003cdfb70 R08: 0000000000000000 R09: 0000000000000000
[  528.834930] R10: ffffc90003cdf910 R11: 0000000000000002 R12: ffff888194450540
[  528.842899] R13: ffff888160d057c0 R14: 0000000000000000 R15: 03ffffffffffffff
[  528.850865] FS:  00007ffff7fdb740(0000) GS:ffff8883b0600000(0000) knlGS:0000000000000000
[  528.859891] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  528.866308] CR2: ffffea1fffffffc0 CR3: 00000001562b4003 CR4: 0000000000770ee0
[  528.874275] PKRU: 55555554
[  528.877286] Call Trace:
[  528.880016]  <TASK>
[  528.882356]  ? lock_is_held_type+0xdf/0x130
[  528.887033]  rmap_walk_anon+0x167/0x410
[  528.891316]  try_to_migrate+0x90/0xd0
[  528.895405]  ? try_to_unmap_one+0xe10/0xe10
[  528.900074]  ? anon_vma_ctor+0x50/0x50
[  528.904260]  ? put_anon_vma+0x10/0x10
[  528.908347]  ? invalid_mkclean_vma+0x20/0x20
[  528.913114]  migrate_vma_setup+0x5f4/0x750
[  528.917691]  dmirror_devmem_fault+0x8c/0x250 [test_hmm]
[  528.923532]  do_swap_page+0xac0/0xe50
[  528.927623]  ? __lock_acquire+0x4b2/0x1ac0
[  528.932199]  __handle_mm_fault+0x949/0x1440
[  528.936876]  handle_mm_fault+0x13f/0x3e0
[  528.941256]  do_user_addr_fault+0x215/0x740
[  528.945928]  exc_page_fault+0x75/0x280
[  528.950115]  asm_exc_page_fault+0x27/0x30
[  528.954593] RIP: 0033:0x40366b
...

Fixes: 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
Reported-by: "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 5bcb334cd6f2..746c05acad27 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1899,8 +1899,23 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
-		subpage = folio_page(folio,
-				pte_pfn(*pvmw.pte) - folio_pfn(folio));
+		if (folio_is_zone_device(folio)) {
+			/*
+			 * Our PTE is a non-present device exclusive entry and
+			 * calculating the subpage as for the common case would
+			 * result in an invalid pointer.
+			 *
+			 * Since only PAGE_SIZE pages can currently be
+			 * migrated, just set it to page. This will need to be
+			 * changed when hugepage migrations to device private
+			 * memory are supported.
+			 */
+			VM_BUG_ON_FOLIO(folio_nr_pages(folio) > 1, folio);
+			subpage = &folio->page;
+		} else {
+			subpage = folio_page(folio,
+					pte_pfn(*pvmw.pte) - folio_pfn(folio));
+		}
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
 				 PageAnonExclusive(subpage);
@@ -1993,15 +2008,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			/*
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
-			 *
-			 * The assignment to subpage above was computed from a
-			 * swap PTE which results in an invalid pointer.
-			 * Since only PAGE_SIZE pages can currently be
-			 * migrated, just set it to page. This will need to be
-			 * changed when hugepage migrations to device private
-			 * memory are supported.
 			 */
-			subpage = &folio->page;
 		} else if (PageHWPoison(subpage)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
-- 
2.35.3

