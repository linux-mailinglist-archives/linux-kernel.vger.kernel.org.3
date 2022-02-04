Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4735A4AA0BF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiBDUC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiBDT73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A36EC061779
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xKDtj4Q84Gq7/YHT/PKaEW9z5qqF6GR8UZ/VCfCl7TU=; b=XfTVy4sw//5kdMO3xZZ3P6Z2bO
        14u6Kb0KFFjOf5zHE/t1/MRiYjQgFnWv5RKnWhKqczWO0I2QrEwXz+L6f/dvFfFH6pQHY/GBHPF+y
        ZbfFBjB0pJlL2inmBCXICMhr1bdaPypNblv8tVv66OQ4KSPB7znDj12kdQPD5Ud/0NSu+H94Gk5FB
        sgI04Js+VWtL+O6kCHtggx7rnGp76c4MJfk83xulw8u/+Nmampsx++B9pKK7/XqxgzQXRlqFwirMG
        ItxiYOYVQTw1CCbYiWW5Cyq0Qzni1eYiI/RocEmSHMRXA56XtdMEPLMRfjm919uMnHDBOH/b3NuBv
        H2rl7v0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jc-007Lru-DZ; Fri, 04 Feb 2022 19:59:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 74/75] mm/filemap: Support VM_HUGEPAGE for file mappings
Date:   Fri,  4 Feb 2022 19:58:51 +0000
Message-Id: <20220204195852.1751729-75-willy@infradead.org>
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

If the VM_HUGEPAGE flag is set, attempt to allocate PMD-sized folios
during readahead, even if we have no history of readahead being
successful.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index fe764225ae99..7608ee030662 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2995,6 +2995,24 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	/* Use the readahead code, even if readahead is disabled */
+	if (vmf->vma->vm_flags & VM_HUGEPAGE) {
+		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
+		ra->size = HPAGE_PMD_NR;
+		/*
+		 * Fetch two PMD folios, so we get the chance to actually
+		 * readahead, unless we've been told not to.
+		 */
+		if (!(vmf->vma->vm_flags & VM_RAND_READ))
+			ra->size *= 2;
+		ra->async_size = HPAGE_PMD_NR;
+		page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
+		return fpin;
+	}
+#endif
+
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
 		return fpin;
-- 
2.34.1

