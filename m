Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594B64AA0CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbiBDUDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbiBDT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F8C061753
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WDil5dypwvwr0pJhzlmwMCjRq+EI+jeEJkZckLIBlgY=; b=c0dzG4llF/3b84Bw55bDXwjWWG
        U2yxsxG8cTJvhBEwjBNYS4gPj3S2uOWmr3Bv2IZxy5kFyx415wC143anDVbiZFstnPdNlGWvh2l9J
        UC/J/tPK62ut1RJ7uBm09b8fm4VMmZNhTFnBCqP/vdUqPhelrD8FX5pOGV3fC1p0aA5Agi1UASqbK
        UMTEAbS76MFZDTrXAq3GEW6pN6Wal7tRucg1W0PoUFK+vbXmpu55ZP7Wmf2uz8m1PL2L9kUdBC5lm
        4kqXPSHrUXBA+xuTeicL1bgLidy7eacG+L+B+GqBo6Ul/PLCdtteCJXgjBMEwKHWX3M14wWj2D8Jv
        qkRnh9CA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jX-007Ln3-Eb; Fri, 04 Feb 2022 19:59:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 39/75] mm: Add folio_pgoff()
Date:   Fri,  4 Feb 2022 19:58:16 +0000
Message-Id: <20220204195852.1751729-40-willy@infradead.org>
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

This is the folio equivalent of page_to_pgoff().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cdb3f118603a..dddd660da24f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -703,6 +703,17 @@ static inline loff_t folio_file_pos(struct folio *folio)
 	return page_file_offset(&folio->page);
 }
 
+/*
+ * Get the offset in PAGE_SIZE (even for hugetlb folios).
+ * (TODO: hugetlb folios should have ->index in PAGE_SIZE)
+ */
+static inline pgoff_t folio_pgoff(struct folio *folio)
+{
+	if (unlikely(folio_test_hugetlb(folio)))
+		return hugetlb_basepage_index(&folio->page);
+	return folio->index;
+}
+
 extern pgoff_t linear_hugepage_index(struct vm_area_struct *vma,
 				     unsigned long address);
 
-- 
2.34.1

