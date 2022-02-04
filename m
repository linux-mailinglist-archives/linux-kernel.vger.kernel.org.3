Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2234AA0C8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbiBDUDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbiBDT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49358C06176C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gH/HpEmYfLdrfRbpayNzunExyTfpHfZmR6mgqsHCuL8=; b=lGH9rzl2ESM3Q3dNOnt6VwuOVC
        8AFCtiMUSFMDfuQWY84H7BB7UOgb+JtUvdVi7WWBzUay2+A2kp9xPrdVQgq2OMnou7ypFRQDtMitt
        lpOdYkgp8kYu4Tjal1LhNsif2pV9dWqqA4s1J2AvtiQive9tm6I0j0Vee7oQY5cIX3lhXr8K/npNF
        KFQ0k1msEU26yNkTxA6tZGxywWdHnIm2t2fKPctqhjoAEjS6iC+PYFvpJ9SwmQAQh+ITVX2GU48Dk
        BrxTfAgDOa/yDygKNWXKuUJUFGmfAUkXQDIUfkiyJ8r+rzhfhcRGuk5zFUR3FfSEW/tmvGrqei9on
        2h1QlSDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4ja-007Lps-Fu; Fri, 04 Feb 2022 19:59:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 61/75] mm/vmscan: Free non-shmem folios without splitting them
Date:   Fri,  4 Feb 2022 19:58:38 +0000
Message-Id: <20220204195852.1751729-62-willy@infradead.org>
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

We have to allocate memory in order to split a file-backed folio, so
it's not a good idea to split them in the memory freeing path.  It also
doesn't work for XFS because pages have an extra reference count from
page_has_private() and split_huge_page() expects that reference to have
already been removed.  Unfortunately, we still have to split shmem THPs
because we can't handle swapping out an entire THP yet.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e94e0b15a76..794cba8511f1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1732,8 +1732,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 				/* Adding to swap updated mapping */
 				mapping = page_mapping(page);
 			}
-		} else if (unlikely(PageTransHuge(page))) {
-			/* Split file THP */
+		} else if (PageSwapBacked(page) && PageTransHuge(page)) {
+			/* Split shmem THP */
 			if (split_folio_to_list(folio, page_list))
 				goto keep_locked;
 		}
-- 
2.34.1

