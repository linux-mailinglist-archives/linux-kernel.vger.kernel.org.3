Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334EB4AB510
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353733AbiBGGhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbiBGGdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:33:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDACC0401C3
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/czcrmGZ5Lo0qcMzS6TZro4gdhOrCfP1KvQi7PFqQEo=; b=LH3yYlJbFcYdKZGh5fpbD5cyA8
        Vi9YtoYPhluVROnMSefSrKmKevym2zgEQKzyNBtBGvATAe8VUR48cN4jBD5HMQTW1fkjFIgPvwP5k
        Umggu+ttp3KvRZuWB3YwritEyZctL73XUgIeIp84kFtqqjAVIa1nHL8eZdb/s3ZeWRajN43MS0PCv
        7jKw3NdrrVnL32Dz4gC+yVCvZgLrqkRqvZhvVQJLq0in2Z7OUlUeyHCGVsYNZ+6qndUu2qyEBA7BI
        rDRygKQ3epdxXbnGqU4DVbdYEhlInkWtKtvTWpGbVnkcAst6M2ZI1N5itTfd9ygTLnRkdKiTiOYnm
        ALEETTxQ==;
Received: from [2001:4bb8:188:3efc:2cbe:55d7:bb63:46d2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGxaA-0099KB-Ir; Mon, 07 Feb 2022 06:33:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: [PATCH 4/8] mm: move free_devmap_managed_page to memremap.c
Date:   Mon,  7 Feb 2022 07:32:45 +0100
Message-Id: <20220207063249.1833066-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207063249.1833066-1-hch@lst.de>
References: <20220207063249.1833066-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_devmap_managed_page has nothing to do with the code in swap.c,
move it to live with the rest of the code for devmap handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mm.h |  1 -
 mm/memremap.c      | 21 +++++++++++++++++++++
 mm/swap.c          | 23 -----------------------
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b46174989b086..91dd0bc786a9ec 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1092,7 +1092,6 @@ static inline bool is_zone_movable_page(const struct page *page)
 }
 
 #ifdef CONFIG_DEV_PAGEMAP_OPS
-void free_devmap_managed_page(struct page *page);
 DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
 
 static inline bool page_is_devmap_managed(struct page *page)
diff --git a/mm/memremap.c b/mm/memremap.c
index 5f04a0709e436e..55d23e9f5c04ec 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -501,4 +501,25 @@ void free_devmap_managed_page(struct page *page)
 	page->mapping = NULL;
 	page->pgmap->ops->page_free(page);
 }
+
+void put_devmap_managed_page(struct page *page)
+{
+	int count;
+
+	if (WARN_ON_ONCE(!page_is_devmap_managed(page)))
+		return;
+
+	count = page_ref_dec_return(page);
+
+	/*
+	 * devmap page refcounts are 1-based, rather than 0-based: if
+	 * refcount is 1, then the page is free and the refcount is
+	 * stable because nobody holds a reference on the page.
+	 */
+	if (count == 1)
+		free_devmap_managed_page(page);
+	else if (!count)
+		__put_page(page);
+}
+EXPORT_SYMBOL(put_devmap_managed_page);
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
diff --git a/mm/swap.c b/mm/swap.c
index bcf3ac288b56d5..08058f74cae23e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1153,26 +1153,3 @@ void __init swap_setup(void)
 	 * _really_ don't want to cluster much more
 	 */
 }
-
-#ifdef CONFIG_DEV_PAGEMAP_OPS
-void put_devmap_managed_page(struct page *page)
-{
-	int count;
-
-	if (WARN_ON_ONCE(!page_is_devmap_managed(page)))
-		return;
-
-	count = page_ref_dec_return(page);
-
-	/*
-	 * devmap page refcounts are 1-based, rather than 0-based: if
-	 * refcount is 1, then the page is free and the refcount is
-	 * stable because nobody holds a reference on the page.
-	 */
-	if (count == 1)
-		free_devmap_managed_page(page);
-	else if (!count)
-		__put_page(page);
-}
-EXPORT_SYMBOL(put_devmap_managed_page);
-#endif
-- 
2.30.2

