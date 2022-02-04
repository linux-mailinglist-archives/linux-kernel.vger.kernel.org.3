Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3C84AA0DE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbiBDUE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiBDUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:03:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE850C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5ceAUAT4Vee+0EAbCvwnmoDPrxJaboihVhPCOhlPlTw=; b=dJrhAaMhXwdxCqG26FeGweR8mm
        L0SDMW76URQW9r23SaCMTH4uqr6bbrlu+EtT+yQWvwua7WnHV09au1fBqDpdaf2HOJi3I3RCdYmwW
        tZrSc70x45edae/jMdUrN4537YtY4PhS8CqwvKgdJ0iBipEnSN31zcMLIXp8CHqdXJmYIqtzQUPmW
        l5J2uGR4uHUScjMHgVmaDN7Xc5Urt6/iAJaCtun7zkbiQ2ULMcx+z7M7W0DC1sOmqbGyJsAin0cLu
        bOvrGeHOzhB7osBdTfd7ksGfgmQynhdkb/6XiHmLp/qvgnKUEZEsOA8OzT9MdHJa/2rqxY0bgG+RC
        G3JVsbRg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jU-007LlD-2y; Fri, 04 Feb 2022 19:59:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 06/75] mm/gup: Change the calling convention for compound_next()
Date:   Fri,  4 Feb 2022 19:57:43 +0000
Message-Id: <20220204195852.1751729-7-willy@infradead.org>
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

Return the head page instead of storing it to a passed parameter.
Reorder the arguments to match the calling function's arguments.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 75a0a1fd4c2a..7e4bdae83e9b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -270,9 +270,8 @@ static inline struct page *compound_range_next(struct page *start,
 	return page;
 }
 
-static inline void compound_next(unsigned long i, unsigned long npages,
-				 struct page **list, struct page **head,
-				 unsigned int *ntails)
+static inline struct page *compound_next(struct page **list,
+		unsigned long npages, unsigned long i, unsigned int *ntails)
 {
 	struct page *page;
 	unsigned int nr;
@@ -283,8 +282,8 @@ static inline void compound_next(unsigned long i, unsigned long npages,
 			break;
 	}
 
-	*head = page;
 	*ntails = nr - i;
+	return page;
 }
 
 /**
@@ -322,7 +321,7 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 	}
 
 	for (index = 0; index < npages; index += ntails) {
-		compound_next(index, npages, pages, &head, &ntails);
+		head = compound_next(pages, npages, index, &ntails);
 		/*
 		 * Checking PageDirty at this point may race with
 		 * clear_page_dirty_for_io(), but that's OK. Two key
@@ -411,7 +410,7 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 		return;
 
 	for (index = 0; index < npages; index += ntails) {
-		compound_next(index, npages, pages, &head, &ntails);
+		head = compound_next(pages, npages, index, &ntails);
 		put_compound_head(head, ntails, FOLL_PIN);
 	}
 }
-- 
2.34.1

