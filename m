Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74980549C55
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344879AbiFMS4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiFMSz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:55:27 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D829713CEB;
        Mon, 13 Jun 2022 08:59:53 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id DF704431EB;
        Mon, 13 Jun 2022 11:54:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1655135686;
        bh=cFkkDlybIJ5f0OhAldQCwzHkD51Q6ycCiV+lYTe5N48=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Gi6aKAV2pQMB9dU+kEqDcuwVTajjbiHADFKAE3QezSseZAGQYQLVvOzpBhyU0f35s
         zx3bItjo/LZUkRTti07wbN02IkZskEpgNowQ4Olc6VG5AC/IxSsLlrK0c8mARpQ3T3
         FReOdraYBjz3qNUwSDf+zSax+Kr+0t4rLInWtIH5hjEwaQ2hyX6YXr8Plb5XxJ4grh
         Zyq7XjN7t0CQAIzX9R8HDNAgVOWqZ17NjBF/P52ZnbrWBrGOLpj/ZbVgJx4U4qqt7O
         Hi58fATcIJTZgpO7S+gKmiauOu3DPAHAWF5CJIcPLxDLu4+KGBIUs117U+V8D7igMc
         DbF5qE22COtiw==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:54:31 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 10/20] block, blksnap: buffer in memory for the minimum data storage unit
Date:   Mon, 13 Jun 2022 18:53:03 +0300
Message-ID: <1655135593-1900-11-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.128.102) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50A536D7766
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct diff_buffer describes a buffer in memory for the minimum data
storage block of the original block device (struct chunk).
Buffer allocation and release functions allow to reduce the number of
allocations and releases of a large number of memory pages.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/diff_buffer.c | 146 ++++++++++++++++++++++++++++
 drivers/block/blksnap/diff_buffer.h |  78 +++++++++++++++
 2 files changed, 224 insertions(+)
 create mode 100644 drivers/block/blksnap/diff_buffer.c
 create mode 100644 drivers/block/blksnap/diff_buffer.h

diff --git a/drivers/block/blksnap/diff_buffer.c b/drivers/block/blksnap/diff_buffer.c
new file mode 100644
index 000000000000..8f9532a4922b
--- /dev/null
+++ b/drivers/block/blksnap/diff_buffer.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-diff-buffer: " fmt
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+#include "memory_checker.h"
+#endif
+#include "params.h"
+#include "diff_buffer.h"
+#include "diff_area.h"
+
+void diff_buffer_free(struct diff_buffer *diff_buffer)
+{
+	size_t inx = 0;
+	struct page *page;
+
+	if (unlikely(!diff_buffer))
+		return;
+
+	for (inx = 0; inx < diff_buffer->page_count; inx++) {
+		page = diff_buffer->pages[inx];
+		if (page) {
+			__free_page(page);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+			memory_object_dec(memory_object_page);
+#endif
+		}
+	}
+
+	kfree(diff_buffer);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_dec(memory_object_diff_buffer);
+#endif
+}
+
+struct diff_buffer *diff_buffer_new(size_t page_count, size_t buffer_size,
+				    gfp_t gfp_mask)
+{
+	struct diff_buffer *diff_buffer;
+	size_t inx = 0;
+	struct page *page;
+
+	if (unlikely(page_count <= 0))
+		return NULL;
+
+	/*
+	 * In case of overflow, it is better to get a null pointer
+	 * than a pointer to some memory area. Therefore + 1.
+	 */
+	diff_buffer = kzalloc(sizeof(struct diff_buffer) +
+				      (page_count + 1) * sizeof(struct page *),
+			      gfp_mask);
+	if (!diff_buffer)
+		return NULL;
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_inc(memory_object_diff_buffer);
+#endif
+	INIT_LIST_HEAD(&diff_buffer->link);
+	diff_buffer->size = buffer_size;
+	diff_buffer->page_count = page_count;
+
+	for (inx = 0; inx < page_count; inx++) {
+		page = alloc_page(gfp_mask);
+		if (!page)
+			goto fail;
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+		memory_object_inc(memory_object_page);
+#endif
+		diff_buffer->pages[inx] = page;
+	}
+	return diff_buffer;
+fail:
+	diff_buffer_free(diff_buffer);
+	return NULL;
+}
+
+struct diff_buffer *diff_buffer_take(struct diff_area *diff_area,
+				     const bool is_nowait)
+{
+	struct diff_buffer *diff_buffer = NULL;
+	sector_t chunk_sectors;
+	size_t page_count;
+	size_t buffer_size;
+
+	spin_lock(&diff_area->free_diff_buffers_lock);
+	diff_buffer = list_first_entry_or_null(&diff_area->free_diff_buffers,
+					       struct diff_buffer, link);
+	if (diff_buffer) {
+		list_del(&diff_buffer->link);
+		atomic_dec(&diff_area->free_diff_buffers_count);
+	}
+	spin_unlock(&diff_area->free_diff_buffers_lock);
+
+	/* Return free buffer if it was found in a pool */
+	if (diff_buffer)
+		return diff_buffer;
+
+	/* Allocate new buffer */
+	chunk_sectors = diff_area_chunk_sectors(diff_area);
+	page_count = round_up(chunk_sectors, SECTOR_IN_PAGE) / SECTOR_IN_PAGE;
+	buffer_size = chunk_sectors << SECTOR_SHIFT;
+
+	diff_buffer =
+		diff_buffer_new(page_count, buffer_size,
+				is_nowait ? (GFP_NOIO | GFP_NOWAIT) : GFP_NOIO);
+	if (unlikely(!diff_buffer)) {
+		if (is_nowait)
+			return ERR_PTR(-EAGAIN);
+		else
+			return ERR_PTR(-ENOMEM);
+	}
+
+	return diff_buffer;
+}
+
+void diff_buffer_release(struct diff_area *diff_area,
+			 struct diff_buffer *diff_buffer)
+{
+	if (atomic_read(&diff_area->free_diff_buffers_count) >
+	    free_diff_buffer_pool_size) {
+		diff_buffer_free(diff_buffer);
+		return;
+	}
+	spin_lock(&diff_area->free_diff_buffers_lock);
+	list_add_tail(&diff_buffer->link, &diff_area->free_diff_buffers);
+	atomic_inc(&diff_area->free_diff_buffers_count);
+	spin_unlock(&diff_area->free_diff_buffers_lock);
+}
+
+void diff_buffer_cleanup(struct diff_area *diff_area)
+{
+	struct diff_buffer *diff_buffer = NULL;
+
+	do {
+		spin_lock(&diff_area->free_diff_buffers_lock);
+		diff_buffer =
+			list_first_entry_or_null(&diff_area->free_diff_buffers,
+						 struct diff_buffer, link);
+		if (diff_buffer) {
+			list_del(&diff_buffer->link);
+			atomic_dec(&diff_area->free_diff_buffers_count);
+		}
+		spin_unlock(&diff_area->free_diff_buffers_lock);
+
+		if (diff_buffer)
+			diff_buffer_free(diff_buffer);
+	} while (diff_buffer);
+}
diff --git a/drivers/block/blksnap/diff_buffer.h b/drivers/block/blksnap/diff_buffer.h
new file mode 100644
index 000000000000..1d504e445d59
--- /dev/null
+++ b/drivers/block/blksnap/diff_buffer.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/blkdev.h>
+
+struct diff_area;
+
+/**
+ * struct diff_buffer - Difference buffer.
+ * @link:
+ *	The list header allows to create a pool of the diff_buffer structures.
+ * @size:
+ *	Count of bytes in the buffer.
+ * @page_count:
+ *	The number of pages reserved for the buffer.
+ * @pages:
+ *	An array of pointers to pages.
+ *
+ * Describes the memory buffer for a chunk in the memory.
+ */
+struct diff_buffer {
+	struct list_head link;
+	size_t size;
+	size_t page_count;
+	struct page *pages[0];
+};
+
+/**
+ * struct diff_buffer_iter - Iterator for &struct diff_buffer.
+ * @page:
+ *      A pointer to the current page.
+ * @offset:
+ *      The offset in bytes in the current page.
+ * @bytes:
+ *      The number of bytes that can be read or written from the current page.
+ *
+ * It is convenient to use when copying data from or to &struct bio_vec.
+ */
+struct diff_buffer_iter {
+	struct page *page;
+	size_t offset;
+	size_t bytes;
+};
+
+#define SECTOR_IN_PAGE (1 << (PAGE_SHIFT - SECTOR_SHIFT))
+
+static inline bool diff_buffer_iter_get(struct diff_buffer *diff_buffer,
+					sector_t ofs,
+					struct diff_buffer_iter *iter)
+{
+	size_t page_inx;
+
+	if (diff_buffer->size <= (ofs << SECTOR_SHIFT))
+		return false;
+
+	page_inx = ofs >> (PAGE_SHIFT - SECTOR_SHIFT);
+
+	iter->page = diff_buffer->pages[page_inx];
+	iter->offset = (size_t)(ofs & (SECTOR_IN_PAGE - 1)) << SECTOR_SHIFT;
+	/*
+	 * The size cannot exceed the size of the page, taking into account
+	 * the offset in this page.
+	 * But at the same time it is unacceptable to go beyond the allocated
+	 * buffer.
+	 */
+	iter->bytes = min_t(size_t, (PAGE_SIZE - iter->offset),
+			    (diff_buffer->size - (ofs << SECTOR_SHIFT)));
+
+	return true;
+};
+
+struct diff_buffer *diff_buffer_take(struct diff_area *diff_area,
+				     const bool is_nowait);
+void diff_buffer_release(struct diff_area *diff_area,
+			 struct diff_buffer *diff_buffer);
+void diff_buffer_cleanup(struct diff_area *diff_area);
-- 
2.20.1

