Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E61488F51
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbiAJE1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238718AbiAJEZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:25:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F573C06118C
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sKOYhN/P0cXC4qhPysyjZBfoAmLRLRFdOpaxGNZHEz8=; b=PJspN4WZf/k+qjE/mGfGFFrgkY
        cA9Kf5HN8fC0T5MXeLaNiI+h4JFXcp/9uKj/3uMyuTO3+G9NY0mZ3v0iR+rS7St765/En7TFFYyaK
        afHgj6DavPUc5K/Gsvjr8ejQPe2KTJly2O5vES3UKprH4ErwcIuKqvQP9L6OXTEv598D/7XyE9ljw
        8hMsHnVRf1L1j0kB+nF0cImF8Sw9s2rRq0e6wHGDOJ1gVRMGSTi/oKvvNaCPc+7DovYWH/cF8mhFs
        r0XVqQPnvjqP4glZTdD9RFs9qMq2qgOLgKuwdzz8EG0OLCYNN7CpZuOPMKe/A7VZvKgLI4LWkuluJ
        33unxJwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE8-0025wg-GU; Mon, 10 Jan 2022 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 08/28] gup: Handle page split race more efficiently
Date:   Mon, 10 Jan 2022 04:23:46 +0000
Message-Id: <20220110042406.499429-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we hit the page split race, the current code returns NULL which will
presumably trigger a retry under the mmap_lock.  This isn't necessary;
we can just retry the compound_head() lookup.  This is a very minor
optimisation of an unlikely path, but conceptually it matches (eg)
the page cache RCU-protected lookup.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index afb638a30e44..dbb1b54d0def 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -68,7 +68,10 @@ static void put_page_refs(struct page *page, int refs)
  */
 static inline struct page *try_get_compound_head(struct page *page, int refs)
 {
-	struct page *head = compound_head(page);
+	struct page *head;
+
+retry:
+	head = compound_head(page);
 
 	if (WARN_ON_ONCE(page_ref_count(head) < 0))
 		return NULL;
@@ -86,7 +89,7 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
 	 */
 	if (unlikely(compound_head(page) != head)) {
 		put_page_refs(head, refs);
-		return NULL;
+		goto retry;
 	}
 
 	return head;
-- 
2.33.0

