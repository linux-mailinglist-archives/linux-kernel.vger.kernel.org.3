Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1614CB47A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiCCBrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiCCBrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:47:23 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467E01B6E05
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:46:39 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id v5so2891304qkj.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 17:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=J7xXuqfykwCtxVDAzhMeaJ1p1sPJc+/o/m7algVP+XU=;
        b=LxbbblGvWdIwXNSBF/l440APj7rIdhHp3HbEjtRK6L+Kc3gy9EQf03FaC5R/XK3LGt
         34+6YQzy7MKI31d2l4ru7+5wvpa769J89UtoUHyCqA5Ie7oOOiCDKaclgTDzvcrffmtY
         c9UFxxTh+n/E/3DBq+q/EkPPLLANyCX6Ia3dQWXwEEoyVZ3JhI3Q7+EUbKmZB1yob3Df
         rj0gVKG98Nkf10bdoTf43cIfwwYrZYe2ad6ExVNheohwS0HpAcOhkrg8ZTcIysb6Mt/T
         knGYfkxF547Jz/pqxpdhtzUHNHoXfblXEn+cJXM7zNjNPsNg/dmBmdaQRLKAg3AtQSNu
         FD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=J7xXuqfykwCtxVDAzhMeaJ1p1sPJc+/o/m7algVP+XU=;
        b=m0pj7y4vIVWKx8bl61St4VajlmxM+KfQgqymrqukq7y+YR7J5hq/T2tWVWLQsJcoF9
         kwmUlMKV9zYHmqDUlhHHQ1Ghs8wta9DC7U+6TmnrVXZeBTaGFovzbbukU0tJAX/1W+V+
         CDRr0mU8mR1BWonxJ4ZL3aFhqGLkqXvtzrvg6+qsLewglCHhr+P490M+zrJSWBHGbCmz
         2d8XKFnCfJMH96ASHh0x19MrI+sErzwZuI3sFSG30ZVH3kvfGR8cIxZqLRFtd5jQ04tD
         eF22+Qz2onNszJwj0U7xmkuv2KCoYvpdB8lAAQlVByFQ7pw7CkzY93yfqoYw0OQNpfs/
         BpTw==
X-Gm-Message-State: AOAM532TVF5SQqANeFBm3Ul9vOIiau+8mKrfQJu8hTT65SLn0ZXl7K4Y
        4TGftrtZii6YMt4Kl5FreePV6g==
X-Google-Smtp-Source: ABdhPJzSdm9kJNA7iq0MRCiU5ChVHuEyiGnzJ9xrtAreIygjRATU8KqqwoV0BFz8ybLGwsbBA4wiMw==
X-Received: by 2002:a37:5d4:0:b0:508:18c2:30c1 with SMTP id 203-20020a3705d4000000b0050818c230c1mr17681554qkf.376.1646271998161;
        Wed, 02 Mar 2022 17:46:38 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t66-20020ae9df45000000b0064915aff85fsm411000qkf.45.2022.03.02.17.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 17:46:37 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:46:35 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH mmotm] mm/thp: fix NR_FILE_MAPPED accounting in
 page_*_file_rmap()
Message-ID: <e02e52a1-8550-a57c-ed29-f51191ea2375@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_FILE_MAPPED accounting in mm/rmap.c (for /proc/meminfo "Mapped" and
/proc/vmstat "nr_mapped" and the memcg's memory.stat "mapped_file") is
slightly flawed for file or shmem huge pages.

It is well thought out, and looks convincing, but there's a racy case
when the careful counting in page_remove_file_rmap() (without page lock)
gets discarded.  So that in a workload like two "make -j20" kernel builds
under memory pressure, with cc1 on hugepage text, "Mapped" can easily
grow by a spurious 5MB or more on each iteration, ending up implausibly
bigger than most other numbers in /proc/meminfo.  And, hypothetically,
might grow to the point of seriously interfering in mm/vmscan.c's
heuristics, which do take NR_FILE_MAPPED into some consideration.

Fixed by moving the __mod_lruvec_page_state() down to where it will not
be missed before return (and I've grown a bit tired of that oft-repeated
but-not-everywhere comment on the __ness: it gets lost in the move here).

Does page_add_file_rmap() need the same change?  I suspect not, because
page lock is held in all relevant cases, and its skipping case looks safe;
but it's much easier to be sure, if we do make the same change.

Fixes: dd78fedde4b9 ("rmap: support file thp")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
If this were thought serious enough to backport (I don't feel strongly,
but it is something I keep in my own trees), it needs a little more care
near "out", because the mm/munlock series has removed some action there.

 mm/rmap.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1238,14 +1238,14 @@ void page_add_new_anon_rmap(struct page *page,
 void page_add_file_rmap(struct page *page,
 	struct vm_area_struct *vma, bool compound)
 {
-	int i, nr = 1;
+	int i, nr = 0;
 
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
 	lock_page_memcg(page);
 	if (compound && PageTransHuge(page)) {
 		int nr_pages = thp_nr_pages(page);
 
-		for (i = 0, nr = 0; i < nr_pages; i++) {
+		for (i = 0; i < nr_pages; i++) {
 			if (atomic_inc_and_test(&page[i]._mapcount))
 				nr++;
 		}
@@ -1262,11 +1262,12 @@ void page_add_file_rmap(struct page *page,
 			VM_WARN_ON_ONCE(!PageLocked(page));
 			SetPageDoubleMap(compound_head(page));
 		}
-		if (!atomic_inc_and_test(&page->_mapcount))
-			goto out;
+		if (atomic_inc_and_test(&page->_mapcount))
+			nr++;
 	}
-	__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
 out:
+	if (nr)
+		__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
 	unlock_page_memcg(page);
 
 	mlock_vma_page(page, vma, compound);
@@ -1274,7 +1275,7 @@ void page_add_file_rmap(struct page *page,
 
 static void page_remove_file_rmap(struct page *page, bool compound)
 {
-	int i, nr = 1;
+	int i, nr = 0;
 
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
 
@@ -1289,12 +1290,12 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 	if (compound && PageTransHuge(page)) {
 		int nr_pages = thp_nr_pages(page);
 
-		for (i = 0, nr = 0; i < nr_pages; i++) {
+		for (i = 0; i < nr_pages; i++) {
 			if (atomic_add_negative(-1, &page[i]._mapcount))
 				nr++;
 		}
 		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
-			return;
+			goto out;
 		if (PageSwapBacked(page))
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						-nr_pages);
@@ -1302,16 +1303,12 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
 						-nr_pages);
 	} else {
-		if (!atomic_add_negative(-1, &page->_mapcount))
-			return;
+		if (atomic_add_negative(-1, &page->_mapcount))
+			nr++;
 	}
-
-	/*
-	 * We use the irq-unsafe __{inc|mod}_lruvec_page_state because
-	 * these counters are not modified in interrupt context, and
-	 * pte lock(a spinlock) is held, which implies preemption disabled.
-	 */
-	__mod_lruvec_page_state(page, NR_FILE_MAPPED, -nr);
+out:
+	if (nr)
+		__mod_lruvec_page_state(page, NR_FILE_MAPPED, -nr);
 }
 
 static void page_remove_anon_compound_rmap(struct page *page)
