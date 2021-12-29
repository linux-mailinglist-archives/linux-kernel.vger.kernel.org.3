Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB1B481097
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbhL2HJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhL2HJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:09:49 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74618C061574;
        Tue, 28 Dec 2021 23:09:49 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a9so42585298wrr.8;
        Tue, 28 Dec 2021 23:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ee3/Ct1G+mZzQD8p6bAGJfxmlHApZMCGVdI9a5DfxHc=;
        b=VjqeyP1IDih5o+n1wQblN72N3hdhvMr6/Cm3trtcg9PG5yN29SeoxPW1ICtI8wJeNP
         /Zm7BpbQwjpc4IKxVkZSkh2QHBQS2JAjUeVdDZyjtoR0Q1+zfrMPyxM/2hQp/Trx0fFX
         /OZw/2PPWo3utgdKD58fKoe08OPjeVPNO2iZn8IsQTdT84kUj1Cvrej1aChOYZKYP18o
         g93fJFFPJoxyiI3f4hJZx9106MDUvTZvZ3BrNpbUWDpMcu2BcDhSXCh7cyGUbKgTjROV
         fvczXQgldr5CAbWeRrA5hvJbz54hAcyqfo04LP676hqRAotsq754QO/rf5cttP65GOz3
         SKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ee3/Ct1G+mZzQD8p6bAGJfxmlHApZMCGVdI9a5DfxHc=;
        b=uUYBBBHeI9JX/EGFgeyqd+UbS4E8rodyY6cpEw8GzexrbTbwavvlYmOU+wdr8AypWB
         fQWCoOL9m0UNfhCF/CS2ClzZNky8bgyuHlfSgDBqQpU0jSOePkpWJANFPCjQ+VDoVnGQ
         M+DmWGWc9vM/2xnFhW3nEgCQxiGYXrMnQCqbb4GiAVZM31+F2BK3wp2oNpCLLtNyj+Z3
         htPPzfXqO6vLHNDmMbg2M1IMF1R//hhV4g3nHhHqp0OaPERTEuDP5opAHi4Xd1mu5IsE
         +ZNTGZLLWWUNE/1CHUZjZf5DftK2vhXkslqChuU7u2CosNp91O5M8pGranOfhf93ykQK
         26uQ==
X-Gm-Message-State: AOAM533jF0MLS8C7ll/PhaTzFGN1+AQUJG7glWIOFzHo0kCEdBEJ8f8M
        ewaChNOGiKJXs6UQgC5J30SX340CJt/0W0j58CUNpw==
X-Google-Smtp-Source: ABdhPJxf1SzzWoJyn1pial7eQY1+Pdnn8nufiqMGFLm/XWQGLh2FqKeMsG2/SNuuYi9JKb2o0igpcg==
X-Received: by 2002:adf:da51:: with SMTP id r17mr20483402wrl.389.1640761787893;
        Tue, 28 Dec 2021 23:09:47 -0800 (PST)
Received: from ownia.. ([103.105.48.220])
        by smtp.gmail.com with ESMTPSA id b2sm22515559wrd.35.2021.12.28.23.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 23:09:47 -0800 (PST)
From:   Weizhao Ouyang <o451686892@gmail.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>, christian.koenig@amd.com
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Weizhao Ouyang <o451686892@gmail.com>
Subject: [PATCH RESEND] dma-buf: heaps: Fix mutex lock area and generalize struct dma_heap_attachment
Date:   Wed, 29 Dec 2021 15:07:13 +0800
Message-Id: <20211229070713.218548-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix cma_heap_buffer mutex lock area to protect vmap_cnt and vaddr. And
move struct dma_heap_attachment to dma-heap.h so that vendor dma heaps
can use it, the same behaviour as struct dma_buf_attachment.

Fixes: a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the cma_heap implementation")
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
Resend to correct email addresses.

 drivers/dma-buf/heaps/cma_heap.c    | 25 ++++++++++---------------
 drivers/dma-buf/heaps/system_heap.c | 12 ++----------
 include/linux/dma-heap.h            | 15 +++++++++++++++
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 0c05b79870f9..23dad5b6421e 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -40,13 +40,6 @@ struct cma_heap_buffer {
 	void *vaddr;
 };
 
-struct dma_heap_attachment {
-	struct device *dev;
-	struct sg_table table;
-	struct list_head list;
-	bool mapped;
-};
-
 static int cma_heap_attach(struct dma_buf *dmabuf,
 			   struct dma_buf_attachment *attachment)
 {
@@ -58,7 +51,7 @@ static int cma_heap_attach(struct dma_buf *dmabuf,
 	if (!a)
 		return -ENOMEM;
 
-	ret = sg_alloc_table_from_pages(&a->table, buffer->pages,
+	ret = sg_alloc_table_from_pages(a->table, buffer->pages,
 					buffer->pagecount, 0,
 					buffer->pagecount << PAGE_SHIFT,
 					GFP_KERNEL);
@@ -90,7 +83,7 @@ static void cma_heap_detach(struct dma_buf *dmabuf,
 	list_del(&a->list);
 	mutex_unlock(&buffer->lock);
 
-	sg_free_table(&a->table);
+	sg_free_table(a->table);
 	kfree(a);
 }
 
@@ -98,12 +91,12 @@ static struct sg_table *cma_heap_map_dma_buf(struct dma_buf_attachment *attachme
 					     enum dma_data_direction direction)
 {
 	struct dma_heap_attachment *a = attachment->priv;
-	struct sg_table *table = &a->table;
+	struct sg_table *table = a->table;
 	int ret;
 
 	ret = dma_map_sgtable(attachment->dev, table, direction, 0);
 	if (ret)
-		return ERR_PTR(-ENOMEM);
+		return ERR_PTR(ret);
 	a->mapped = true;
 	return table;
 }
@@ -124,14 +117,15 @@ static int cma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 	struct cma_heap_buffer *buffer = dmabuf->priv;
 	struct dma_heap_attachment *a;
 
+	mutex_lock(&buffer->lock);
+
 	if (buffer->vmap_cnt)
 		invalidate_kernel_vmap_range(buffer->vaddr, buffer->len);
 
-	mutex_lock(&buffer->lock);
 	list_for_each_entry(a, &buffer->attachments, list) {
 		if (!a->mapped)
 			continue;
-		dma_sync_sgtable_for_cpu(a->dev, &a->table, direction);
+		dma_sync_sgtable_for_cpu(a->dev, a->table, direction);
 	}
 	mutex_unlock(&buffer->lock);
 
@@ -144,14 +138,15 @@ static int cma_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
 	struct cma_heap_buffer *buffer = dmabuf->priv;
 	struct dma_heap_attachment *a;
 
+	mutex_lock(&buffer->lock);
+
 	if (buffer->vmap_cnt)
 		flush_kernel_vmap_range(buffer->vaddr, buffer->len);
 
-	mutex_lock(&buffer->lock);
 	list_for_each_entry(a, &buffer->attachments, list) {
 		if (!a->mapped)
 			continue;
-		dma_sync_sgtable_for_device(a->dev, &a->table, direction);
+		dma_sync_sgtable_for_device(a->dev, a->table, direction);
 	}
 	mutex_unlock(&buffer->lock);
 
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index ab7fd896d2c4..aac8fc660ea6 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -17,7 +17,6 @@
 #include <linux/highmem.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -33,13 +32,6 @@ struct system_heap_buffer {
 	void *vaddr;
 };
 
-struct dma_heap_attachment {
-	struct device *dev;
-	struct sg_table *table;
-	struct list_head list;
-	bool mapped;
-};
-
 #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
 #define MID_ORDER_GFP (LOW_ORDER_GFP | __GFP_NOWARN)
 #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
@@ -68,7 +60,7 @@ static struct sg_table *dup_sg_table(struct sg_table *table)
 	ret = sg_alloc_table(new_table, table->orig_nents, GFP_KERNEL);
 	if (ret) {
 		kfree(new_table);
-		return ERR_PTR(-ENOMEM);
+		return ERR_PTR(ret);
 	}
 
 	new_sg = new_table->sgl;
@@ -94,7 +86,7 @@ static int system_heap_attach(struct dma_buf *dmabuf,
 	table = dup_sg_table(&buffer->sg_table);
 	if (IS_ERR(table)) {
 		kfree(a);
-		return -ENOMEM;
+		return PTR_ERR(table);
 	}
 
 	a->table = table;
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 0c05561cad6e..7d02aefe0e78 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -11,6 +11,7 @@
 
 #include <linux/cdev.h>
 #include <linux/types.h>
+#include <linux/scatterlist.h>
 
 struct dma_heap;
 
@@ -41,6 +42,20 @@ struct dma_heap_export_info {
 	void *priv;
 };
 
+/**
+ * struct dma_heap_attachment - holds device-heap attachment data
+ * @dev:	device attached to the heap
+ * @table:	sgtables for tracking the associated pages
+ * @list:	list of dma_heap_attachment
+ * @mapped:	true if attachment is actually mapped on the device
+ */
+struct dma_heap_attachment {
+	struct device *dev;
+	struct sg_table *table;
+	struct list_head list;
+	bool mapped;
+};
+
 /**
  * dma_heap_get_drvdata() - get per-heap driver data
  * @heap: DMA-Heap to retrieve private data for
-- 
2.32.0

