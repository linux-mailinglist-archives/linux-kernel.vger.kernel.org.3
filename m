Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA8F4D3B5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiCIUvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiCIUvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:51:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6936DF73
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cn2boYkpsosN2sSXsMfN7mrvhF8Vo2LhemlChC0Qc3k=; b=LpnqzIoFvkyM+J5uj8FfL4JOAy
        Vw235F34JYw8rY+69to0tcelj4ZjksoF6xyOvghpPZwQowijVhCsvwJ75SzlFBFpoOGyxGebYYNdE
        7jOcxkkLMd5y5GpgFgfWy75S/+U/IerkREOV3wghDONx1Gd+QkHG4qI6uAOtoGxt9SNVhMnoDjsq8
        YhYj5yFIkMeodFF85uSaagg/YYViCsd6YnImLYi20hWs68PLBDfbch/kqSVgb4NqrcwxUwJQ/n3xF
        uCpCCc4c5v9vnkRxNBdlNWoD/wSRSQU/BH1eA3tAuyrlxACIfsWwuYVTxSDLpjlyUXewkV9xZuWKA
        cvcm4xfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nS3GY-00HUtF-9T; Wed, 09 Mar 2022 20:50:38 +0000
Date:   Wed, 9 Mar 2022 20:50:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC] Free up a page flag
Message-ID: <YikTHqjv4S6ZQ3Fv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're always running out of page flags.  Here's an attempt to free one
up for the next time somebody wants one.

It's based on the idea that neither PageReserved nor PageSlab need
(most) other flags in the flags word.  So instead of encoding PG_slab and
PG_reserved as their own flags, we can use a magic flag (tentatively named
xyzzy because I suck at naming) to indicate that it's one of these two,
and then reuse some other flags to specify which one it is.

Here's patch 1/2 which just converts PG_slab.  There should be another
one which converts PG_reserved, but it's a bit of work and I thought it
best to get feedback on this before spending more time on it.

It's "wrong" in a number of ways, including the fact that slab doesn't
actually need the atomic versions of Set and Clear; it always uses
__folio_set_slab() and __folio_clear_slab(), but I thought it was a good
idea to illustrate how one could do the atomic flag updates if necessary.
I'm tempted to say "Oh, you shouldn't", but PG_reserved is set in an
atomic manner today, even though it probably doesn't need to be.

I don't think there are any other existing flags that we can reclaim
using this technique, but maybe there are others who would love their
own flag that can be used in this manner.

It compiles, but I didn't boot it.

From 62c98e780d4929f1a51165562c955cfdee6cfa01 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Wed, 9 Mar 2022 14:48:23 -0500
Subject: [PATCH] PG_xyzzy

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 51 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1c3b6e5c8bfd..15ba61996a78 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -107,7 +107,7 @@ enum pageflags {
 	PG_workingset,
 	PG_waiters,		/* Page has waiters, check its waitqueue. Must be bit #7 and in the same byte as "PG_locked" */
 	PG_error,
-	PG_slab,
+	PG_xyzzy,		/* Magic.  The other flags change meaning */
 	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use*/
 	PG_arch_1,
 	PG_reserved,
@@ -140,6 +140,9 @@ enum pageflags {
 #endif
 	__NR_PAGEFLAGS,
 
+	/* xyzzy flags */
+	PG_slab = PG_owner_priv_1,
+
 	PG_readahead = PG_reclaim,
 
 	/* Filesystems */
@@ -425,10 +428,54 @@ PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
 	TESTCLEARFLAG(Active, active, PF_HEAD)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
 	TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
-__PAGEFLAG(Slab, slab, PF_NO_TAIL)
 __PAGEFLAG(SlobFree, slob_free, PF_NO_TAIL)
 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)	   /* Used by some filesystems */
 
+#define XYZZY(name)		((1UL << PG_xyzzy) | (1UL << PG_##name))
+
+static __always_inline bool folio_test_slab(struct folio *folio)
+{
+	return (*folio_flags(folio, 0) & XYZZY(slab)) == XYZZY(slab);
+}
+
+static __always_inline bool PageSlab(struct page *page)
+{
+	return folio_test_slab(page_folio(page));
+}
+
+static __always_inline void folio_set_slab(struct folio *folio)
+{
+	unsigned long flags, *p = folio_flags(folio, 0);
+
+	do {
+		flags = READ_ONCE(*p);
+	} while (cmpxchg(p, flags, flags | XYZZY(slab)) != flags);
+}
+
+static __always_inline void folio_clear_slab(struct folio *folio)
+{
+	unsigned long flags, *p = folio_flags(folio, 0);
+
+	do {
+		flags = READ_ONCE(*p);
+	} while (cmpxchg(p, flags, flags & ~XYZZY(slab)) != flags);
+}
+
+static __always_inline void __folio_set_slab(struct folio *folio)
+{
+	*folio_flags(folio, 0) |= XYZZY(slab);
+}
+
+static __always_inline void __SetPageSlab(struct page *page)
+{
+	page->flags |= XYZZY(slab);
+}
+
+static __always_inline void __folio_clear_slab(struct folio *folio)
+{
+	*folio_flags(folio, 0) &= ~XYZZY(slab);
+}
+
 /* Xen */
 PAGEFLAG(Pinned, pinned, PF_NO_COMPOUND)
 	TESTSCFLAG(Pinned, pinned, PF_NO_COMPOUND)
-- 
2.34.1


