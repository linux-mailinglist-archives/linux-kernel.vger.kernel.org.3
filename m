Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F434AA0A0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiBDUA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbiBDT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62001C061755
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NOZFCIAHs14S6ShgmEZTYVvlwYIX+9q1FzDwIHERWMU=; b=oSzUzWyoXWPtOg5IDBWJS2HMsY
        LIoT7FbLieUlfRoqAfRmp+S5USjt7whN6+vx0tWMS+rT4fg6TIwnpgzKT+bNASFMiG1xLjEbLMKyv
        jAIsN+Pk9H7Qm4nszlO4EIRKLGmVXTyTh7PJtSSHwOm4PIZqIyIR7N5jR+KWmC52n2bxR3Ya3oAYp
        n8SAiuLo9SRHmXntPDmrDZgennQCO60kdOCcqio2Bf+PkxbZLSjtFLTzM23uCWQ0IbLzNYAWRQd0V
        ElOzXete8NXsvVAxnbv+jsL9HJDTRxvcbjl1ijsgW7a1jj7pKS/B48lde/TSUGiGT3O/jXIzQVp4H
        Szz3ek6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jT-007Ll3-Nl; Fri, 04 Feb 2022 19:58:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/75] mm/gup: Increment the page refcount before the pincount
Date:   Fri,  4 Feb 2022 19:57:38 +0000
Message-Id: <20220204195852.1751729-2-willy@infradead.org>
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

We should always increase the refcount before doing anything else to
the page so that other page users see the elevated refcount first.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a9d4d724aef7..08020987dfc0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -220,18 +220,18 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
 		if (WARN_ON_ONCE(page_ref_count(page) <= 0))
 			return false;
 
-		if (hpage_pincount_available(page))
-			hpage_pincount_add(page, 1);
-		else
-			refs = GUP_PIN_COUNTING_BIAS;
-
 		/*
 		 * Similar to try_grab_compound_head(): even if using the
 		 * hpage_pincount_add/_sub() routines, be sure to
 		 * *also* increment the normal page refcount field at least
 		 * once, so that the page really is pinned.
 		 */
-		page_ref_add(page, refs);
+		if (hpage_pincount_available(page)) {
+			page_ref_add(page, 1);
+			hpage_pincount_add(page, 1);
+		} else {
+			page_ref_add(page, GUP_PIN_COUNTING_BIAS);
+		}
 
 		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED, 1);
 	}
-- 
2.34.1

