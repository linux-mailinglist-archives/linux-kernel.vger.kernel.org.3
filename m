Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FFE4B6129
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiBOCmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:42:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiBOCms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:42:48 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6373D11D7AC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:42:38 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id e16so17319029qtq.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=giPReZ8UhbPqkZLEqkAOxK4yInsc7PbE1m6SE66Te4Q=;
        b=btIELsE6p+AIrHoSPLSohcTUVe+luSKo9dd0AyNSjs7Ju9Xa9XzP3dnes8rgd8EOwp
         mm6tUMUxoPRUi6IiZyTjfcVWS1/wWYrOEJiRagFc0uLo1MraDS+RlIc43lg6+LoXvVZX
         4p4LFiGoHfzMTc4q3TgVGzbSDb8K9+QqdoZIbP9HQ7U5RXMwijNjwTcSe2Qw+GF3LUz0
         12psOMKrAo6jkpCt9p5nygK7/F9KKWOZimQoPlXIUCJjJUgT9SQpsXHB7j7TGRXaW/W9
         S9f+IR9MLXYuRPp/+mThEHeH2tlKRWEPKnc7IPr8zPOSY/a6A0U5WhX69BF+/lTw9vkR
         DTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=giPReZ8UhbPqkZLEqkAOxK4yInsc7PbE1m6SE66Te4Q=;
        b=HbR6nUTwTG3BTA/agdhSoiZSnPzPlxcqxvNsTnDRofyYfNB5/9BL2sgJ2MAUXYsRn0
         TZ/k9DGkR6HRM9lmd8pOmzEvzPifpRaSByaEhi1VbRe8a4BkQdQQ7J/D6g7z1rh4yStM
         zNYlF+7S+2HmUy12ZydNCQSzm/JtW1iV50amR8K1wtvF9dVbbDPVpVdA5ZzVLqm4wvqN
         y2BUXDkPmmldGM7f6XbeqqrGa+h80aNtUn8suZ63kt0aMjcVB5iOc4pg47XQ0C+SODJR
         bRQgeFm7yKsknzI5CM+gmdAC0l8WcVZenXa7xdCgzCKqOJS7p30D+cLpqYQUxHarPaM0
         MZjg==
X-Gm-Message-State: AOAM530MT+tGpr0o6HAI7tj0e66+asf31aGLwn9QQ6BRhHEFysB9eyZp
        at2IZPOebFyzBQbOIoTR/TDbYg==
X-Google-Smtp-Source: ABdhPJznFEk0d/fI+EPrzI5m8zqaIJocidCZFSgE1ynr0TcpDqCkqNNw84SymhENnH3FgBo3d8wQAw==
X-Received: by 2002:ac8:4e87:: with SMTP id 7mr1362080qtp.9.1644892956787;
        Mon, 14 Feb 2022 18:42:36 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c20sm19161403qtb.58.2022.02.14.18.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:42:36 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:42:33 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 13/13] mm/thp: shrink_page_list() avoid splitting VM_LOCKED
 THP
In-Reply-To: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
Message-ID: <531d13ee-bc7d-329a-9748-5e272f699d78@google.com>
References: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.8 commit 7751b2da6be0 ("vmscan: split file huge pages before paging
them out") inserted a split_huge_page_to_list() into shrink_page_list()
without considering the mlock case: no problem if the page has already
been marked as Mlocked (the !page_evictable check much higher up will
have skipped all this), but it has always been the case that races or
omissions in setting Mlocked can rely on page reclaim to detect this
and correct it before actually reclaiming - and that remains so, but
what a shame if a hugepage is needlessly split before discovering it.

It is surprising that page_check_references() returns PAGEREF_RECLAIM
when VM_LOCKED, but there was a good reason for that: try_to_unmap_one()
is where the condition is detected and corrected; and until now it could
not be done in page_referenced_one(), because that does not always have
the page locked.  Now that mlock's requirement for page lock has gone,
copy try_to_unmap_one()'s mlock restoration into page_referenced_one(),
and let page_check_references() return PAGEREF_ACTIVATE in this case.

But page_referenced_one() may find a pte mapping one part of a hugepage:
what hold should a pte mapped in a VM_LOCKED area exert over the entire
huge page?  That's debatable.  The approach taken here is to treat that
pte mapping in page_referenced_one() as if not VM_LOCKED, and if no
VM_LOCKED pmd mapping is found later in the walk, and lack of reference
permits, then PAGEREF_RECLAIM take it to attempted splitting as before.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
v2: same as v1.

 mm/rmap.c   | 7 +++++--
 mm/vmscan.c | 6 +++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 714bfdc72c7b..c7921c102bc0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -812,7 +812,10 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
-		if (vma->vm_flags & VM_LOCKED) {
+		if ((vma->vm_flags & VM_LOCKED) &&
+		    (!PageTransCompound(page) || !pvmw.pte)) {
+			/* Restore the mlock which got missed */
+			mlock_vma_page(page, vma, !pvmw.pte);
 			page_vma_mapped_walk_done(&pvmw);
 			pra->vm_flags |= VM_LOCKED;
 			return false; /* To break the loop */
@@ -851,7 +854,7 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 
 	if (referenced) {
 		pra->referenced++;
-		pra->vm_flags |= vma->vm_flags;
+		pra->vm_flags |= vma->vm_flags & ~VM_LOCKED;
 	}
 
 	if (!pra->mapcount)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 090bfb605ecf..a160efba3c73 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1386,11 +1386,11 @@ static enum page_references page_check_references(struct page *page,
 	referenced_page = TestClearPageReferenced(page);
 
 	/*
-	 * Mlock lost the isolation race with us.  Let try_to_unmap()
-	 * move the page to the unevictable list.
+	 * The supposedly reclaimable page was found to be in a VM_LOCKED vma.
+	 * Let the page, now marked Mlocked, be moved to the unevictable list.
 	 */
 	if (vm_flags & VM_LOCKED)
-		return PAGEREF_RECLAIM;
+		return PAGEREF_ACTIVATE;
 
 	if (referenced_ptes) {
 		/*
-- 
2.34.1

