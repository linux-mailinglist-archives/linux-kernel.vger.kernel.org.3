Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9C4AA0D8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbiBDUEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbiBDUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:02:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFF9C06177F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uNHbiplzAhumMjir5hW/+5QrjINzxK7Ks9sjue7Fm7I=; b=Yu+bQPGiq4F1lldZgNWaep7jd4
        B0nyFdzn0XB98KUc65p6nAzFc7ffg4qx2FIt15K37OcLI3DCIKVJhV+KLwOCmLT85GxkMOGIxRBoP
        wD+Vw8+CL4sKwmaViXgSCwbJ2IdLKpJJNf00hceV2XOn2tOaABC6zWpVlTKMWDvmErj3vqC8F016L
        X+RjWgcRWm9IdfqK0zzP10ZtkWOdQmvQmcCmL4D1TRcFPgLAYxvBt3PaTvyAHWWS458syi4TEdXt0
        ExkyV0vflohQ4zlYlxa/pOya+T9IjPFvFYD7D87a9b0nBdMoSZFUQx5ymN4QMjjpGDPJHJIfJ5uWW
        j7Lf5hhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jU-007LlN-H4; Fri, 04 Feb 2022 19:59:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 11/75] mm/gup: Remove hpage_pincount_sub()
Date:   Fri,  4 Feb 2022 19:57:48 +0000
Message-Id: <20220204195852.1751729-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the assertion (and correct it to be a cheaper variant),
and inline the atomic_sub() operation.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 60168a09d52a..af623a139995 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -29,14 +29,6 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
 
-static void hpage_pincount_sub(struct page *page, int refs)
-{
-	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
-	VM_BUG_ON_PAGE(page != compound_head(page), page);
-
-	atomic_sub(refs, compound_pincount_ptr(page));
-}
-
 /* Equivalent to calling put_page() @refs times. */
 static void put_page_refs(struct page *page, int refs)
 {
@@ -169,12 +161,13 @@ __maybe_unused struct page *try_grab_compound_head(struct page *page,
 
 static void put_compound_head(struct page *page, int refs, unsigned int flags)
 {
+	VM_BUG_ON_PAGE(PageTail(page), page);
+
 	if (flags & FOLL_PIN) {
 		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
 				    refs);
-
 		if (hpage_pincount_available(page))
-			hpage_pincount_sub(page, refs);
+			atomic_sub(refs, compound_pincount_ptr(page));
 		else
 			refs *= GUP_PIN_COUNTING_BIAS;
 	}
-- 
2.34.1

