Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B690585898
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 06:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbiG3EZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 00:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiG3EZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 00:25:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B21F120BC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 21:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9lqr4PZyWhD9hoFrN8Igs1ekeXOVn9WRDM3RAtHu+m4=; b=GO350Yww1jvAcuN5cW7i9E+80D
        IevaHjyT3LMi+gQp86ckipKcHO9hrd3zQL5ATa40FEpHyiiKJq5rqRZsRk1u6573QzTQ9qnuDafBj
        6DpjRjx7AdzExR0+5nZiJqe090RVn8Pxot71K2Jr7FokOdT2NJdXaiVt/RB3jBhhQIu51oDzbMiAY
        p1kW9NMe1VmRjk0iGqg4uLlHxZ5FNhJ2Cc/qDVHxXp69cmNSjcNlF4C//E6RfMYX8kfOHEAE/CK8H
        tn1a3sN8dCpAI+25JpKWNP31HFrwBfAJfckWIuc3wly7v5avp209TYbckU4NlyKQmlomazF66hshi
        5WSZv4kA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oHe2T-005J2C-HY; Sat, 30 Jul 2022 04:25:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] shmem: Update folio if shmem_replace_page() updates the page
Date:   Sat, 30 Jul 2022 05:25:18 +0100
Message-Id: <20220730042518.1264767-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we allocate a new page, we need to make sure that our folio matches
that new page.  This will be solved by changing shmem_replace_page()
to shmem_replace_folio(), but this is the minimal fix.

Fixes: da08e9b79323 ("mm/shmem: convert shmem_swapin_page() to shmem_swapin_folio()")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index a6f565308133..bcc0a3c7b5bf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1771,6 +1771,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 
 	if (shmem_should_replace_folio(folio, gfp)) {
 		error = shmem_replace_page(&page, gfp, info, index);
+		folio = page_folio(page);
 		if (error)
 			goto failed;
 	}
-- 
2.35.1

