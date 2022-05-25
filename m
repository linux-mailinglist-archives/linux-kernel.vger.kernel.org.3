Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B77534307
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbiEYSdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343733AbiEYSdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:33:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2FFB2244
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dE/DLluMiNPsVmhAGFmujsjFgKe2VgiOhEAbM9opcsg=; b=D5mk4y7mqIrm/WfrhoXXCJ4gcg
        4Dq/9gzxlPAtT/AJGgUP47M+XTX1ltG/ktYBe1jYDkZmFpiGtnRMcwJHSbzj+FXHCJO+6A8MmxJ6X
        WBXkb+8WMJdLVp8SAzy8nBTsPHfJMLmmoHGtDd5R1IPJuYIwDWWRRHZgXqq9tgTCUASLw23PvRFnL
        seBTu62XIw1tcpp3L5x3qJIAT2S1XXUxUaq+dXqlp384ukd2zGsgmyKc1p3O6n/eowOXQLLai+pjb
        POv2LpgYHsHfqr6Q31WjPdgZ1G1dxOcTF8xzTmQsRkWdsTROMYbVHrvamaR2JTgz0K7FvgXC6HIAL
        hWcjes+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntvpD-000bSq-3b; Wed, 25 May 2022 18:33:39 +0000
Date:   Wed, 25 May 2022 19:33:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+5b96d55e5b54924c77ad@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in do_sync_mmap_readahead
Message-ID: <Yo52gzYYOpU0NwDo@casper.infradead.org>
References: <0000000000008cfbca05dfd6db81@google.com>
 <20220525095842.f97b64de9cbcc0e15d1257a6@linux-foundation.org>
 <Yo5uI9w7lll5B93r@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo5uI9w7lll5B93r@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 06:57:55PM +0100, Matthew Wilcox wrote:
> 
> Ohh, that makes sense.  We unlocked the mmap_sem, so the file is
> pinned, but the VMA isn't.  I'll whip up a patch.

#syz test

From 01a4917c4cfe400eb310eba4f2fa466d381623c1 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Wed, 25 May 2022 14:23:45 -0400
Subject: [PATCH] mm/filemap: Cache the value of vm_flags

After we have unlocked the mmap_lock for I/O, the file is pinned, but
the VMA is not.  Checking this flag after that can be a use-after-free.
It's not a terribly interesting use-after-free as it can only read one
bit, and it's used to decide whether to read 2MB or 4MB.  But it
upsets the automated tools and it's generally bad practice anyway,
so let's fix it.

Reported-by: syzbot+5b96d55e5b54924c77ad@syzkaller.appspotmail.com
Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9a1eef6c5d35..61dd39990fda 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2991,11 +2991,12 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct address_space *mapping = file->f_mapping;
 	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
 	struct file *fpin = NULL;
+	unsigned long vm_flags = vmf->vma->vm_flags;
 	unsigned int mmap_miss;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Use the readahead code, even if readahead is disabled */
-	if (vmf->vma->vm_flags & VM_HUGEPAGE) {
+	if (vm_flags & VM_HUGEPAGE) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
 		ra->size = HPAGE_PMD_NR;
@@ -3003,7 +3004,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		 * Fetch two PMD folios, so we get the chance to actually
 		 * readahead, unless we've been told not to.
 		 */
-		if (!(vmf->vma->vm_flags & VM_RAND_READ))
+		if (!(vm_flags & VM_RAND_READ))
 			ra->size *= 2;
 		ra->async_size = HPAGE_PMD_NR;
 		page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
@@ -3012,12 +3013,12 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 #endif
 
 	/* If we don't want any read-ahead, don't bother */
-	if (vmf->vma->vm_flags & VM_RAND_READ)
+	if (vm_flags & VM_RAND_READ)
 		return fpin;
 	if (!ra->ra_pages)
 		return fpin;
 
-	if (vmf->vma->vm_flags & VM_SEQ_READ) {
+	if (vm_flags & VM_SEQ_READ) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_sync_ra(&ractl, ra->ra_pages);
 		return fpin;
-- 
2.34.1

