Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A618549C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiFMS4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345144AbiFMSz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:55:28 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D835DFC83A;
        Mon, 13 Jun 2022 08:59:53 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 93404431BA;
        Mon, 13 Jun 2022 11:54:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1655135672;
        bh=W10xpVk0OGxo4oeH2xmhjS+cejKCCMauR6pGCzmPWsk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Fi+NaPIqeIbnj59nB8aWiywHazX3I6myNG+Mx82itBn2Rdsouzkpl/oG58ochPns+
         aQdQe9QsYGTHXJtHJiwxOY74as+Xvo595kmv3ohlM2AQRc9QuiN9WnswSaye3n4NFC
         9c2v3IgxPf02ykCBGSQMnkmNKUsp7JudvPnZrsYV8WS3am47h7qt1mN4vKCLJwX8ds
         Cw4cjpX4Q+YCqMApIEfN63yaPQyYRF+FjTgz9oA/iLwL3NP2eB4oQ3mJvWDPaT3LJ0
         fUwcVrXTTm5ykvIHLL+8VxEDuZ8S6xZIee31lU/k97lNXvQXS18F1DNtaf2AoCfVuY
         nkhnFOJRkyvYA==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:54:24 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 08/20] block, blksnap: big buffer in the form of an array of pages
Date:   Mon, 13 Jun 2022 18:53:01 +0300
Message-ID: <1655135593-1900-9-git-send-email-sergei.shtepa@veeam.com>
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

Description of the struct big_buffer, which is used to store
sufficiently large amounts of data, such as a CBT map, and functions for
working with it. There are systems on which quite often the kmalloc()
memory allocation function of several hundred kilobytes ends with an
error code, and it is impossible to use virtual memory when handling an
I/O unit, since a page fault situation is possible. A simple array of
pages solves this problem.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/big_buffer.c | 218 +++++++++++++++++++++++++++++
 drivers/block/blksnap/big_buffer.h |  27 ++++
 2 files changed, 245 insertions(+)
 create mode 100644 drivers/block/blksnap/big_buffer.c
 create mode 100644 drivers/block/blksnap/big_buffer.h

diff --git a/drivers/block/blksnap/big_buffer.c b/drivers/block/blksnap/big_buffer.c
new file mode 100644
index 000000000000..bcefc09653e4
--- /dev/null
+++ b/drivers/block/blksnap/big_buffer.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+#include "memory_checker.h"
+#endif
+#include "big_buffer.h"
+
+static inline size_t page_count_calc(size_t buffer_size)
+{
+	size_t page_count = buffer_size / PAGE_SIZE;
+
+	if (buffer_size & (PAGE_SIZE - 1))
+		page_count += 1;
+	return page_count;
+}
+
+struct big_buffer *big_buffer_alloc(size_t buffer_size, int gfp_opt)
+{
+	int res = 0;
+	struct big_buffer *bbuff;
+	size_t count;
+	size_t inx;
+
+	count = page_count_calc(buffer_size);
+
+	bbuff = kzalloc(sizeof(struct big_buffer) + count * sizeof(void *),
+			gfp_opt);
+	if (bbuff == NULL)
+		return NULL;
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_inc(memory_object_big_buffer);
+#endif
+	bbuff->pg_cnt = count;
+	for (inx = 0; inx < bbuff->pg_cnt; ++inx) {
+		struct page *pg = alloc_page(gfp_opt);
+
+		if (!pg) {
+			res = -ENOMEM;
+			break;
+		}
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+		memory_object_inc(memory_object_page);
+#endif
+		bbuff->pg[inx] = page_address(pg);
+	}
+
+	if (res) {
+		big_buffer_free(bbuff);
+		return NULL;
+	}
+
+	return bbuff;
+}
+
+void big_buffer_free(struct big_buffer *bbuff)
+{
+	size_t inx;
+	size_t count = bbuff->pg_cnt;
+
+	if (bbuff == NULL)
+		return;
+
+	for (inx = 0; inx < count; ++inx)
+		if (bbuff->pg[inx] != NULL) {
+			free_page((unsigned long)bbuff->pg[inx]);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+			memory_object_dec(memory_object_page);
+#endif
+		}
+
+	kfree(bbuff);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_dec(memory_object_big_buffer);
+#endif
+}
+
+size_t big_buffer_copy_to_user(char __user *dst_user, size_t offset,
+			       struct big_buffer *bbuff, size_t length)
+{
+	size_t left_data_length;
+	int page_inx = offset / PAGE_SIZE;
+	size_t processed_len = 0;
+	size_t unordered = offset & (PAGE_SIZE - 1);
+
+	if (unordered) { //first
+		size_t page_len =
+			min_t(size_t, (PAGE_SIZE - unordered), length);
+
+		left_data_length =
+			copy_to_user(dst_user + processed_len,
+				     bbuff->pg[page_inx] + unordered, page_len);
+		if (left_data_length) {
+			pr_err("Failed to copy data from big_buffer to user buffer\n");
+			return processed_len;
+		}
+
+		++page_inx;
+		processed_len += page_len;
+	}
+
+	while ((processed_len < length) && (page_inx < bbuff->pg_cnt)) {
+		size_t page_len =
+			min_t(size_t, PAGE_SIZE, (length - processed_len));
+
+		left_data_length = copy_to_user(dst_user + processed_len,
+						bbuff->pg[page_inx], page_len);
+		if (left_data_length) {
+			pr_err("Failed to copy data from big_buffer to user buffer\n");
+			break;
+		}
+
+		++page_inx;
+		processed_len += page_len;
+	}
+
+	return processed_len;
+}
+
+size_t big_buffer_copy_from_user(const char __user *src_user, size_t offset,
+				 struct big_buffer *bbuff, size_t length)
+{
+	size_t left_data_length;
+	int page_inx = offset / PAGE_SIZE;
+	size_t processed_len = 0;
+	size_t unordered = offset & (PAGE_SIZE - 1);
+
+	if (unordered) { //first
+		size_t page_len =
+			min_t(size_t, (PAGE_SIZE - unordered), length);
+
+		left_data_length =
+			copy_from_user(bbuff->pg[page_inx] + unordered,
+				       src_user + processed_len, page_len);
+		if (left_data_length) {
+			pr_err("Failed to copy data from user buffer to big_buffer\n");
+			return processed_len;
+		}
+
+		++page_inx;
+		processed_len += page_len;
+	}
+
+	while ((processed_len < length) && (page_inx < bbuff->pg_cnt)) {
+		size_t page_len =
+			min_t(size_t, PAGE_SIZE, (length - processed_len));
+
+		left_data_length =
+			copy_from_user(bbuff->pg[page_inx],
+				       src_user + processed_len, page_len);
+		if (left_data_length) {
+			pr_err("Failed to copy data from user buffer to big_buffer\n");
+			break;
+		}
+
+		++page_inx;
+		processed_len += page_len;
+	}
+
+	return processed_len;
+}
+
+void *big_buffer_get_element(struct big_buffer *bbuff, size_t index,
+			     size_t sizeof_element)
+{
+	size_t elements_in_page = PAGE_SIZE / sizeof_element;
+	size_t pg_inx = index / elements_in_page;
+	size_t pg_ofs = (index - (pg_inx * elements_in_page)) * sizeof_element;
+
+	if (pg_inx >= bbuff->pg_cnt)
+		return NULL;
+
+	return bbuff->pg[pg_inx] + pg_ofs;
+}
+
+void big_buffer_memset(struct big_buffer *bbuff, int value)
+{
+	size_t inx;
+
+	for (inx = 0; inx < bbuff->pg_cnt; ++inx)
+		memset(bbuff->pg[inx], value, PAGE_SIZE);
+}
+
+void big_buffer_memcpy(struct big_buffer *dst, struct big_buffer *src)
+{
+	size_t inx;
+	size_t count = min_t(size_t, dst->pg_cnt, src->pg_cnt);
+
+	for (inx = 0; inx < count; ++inx)
+		memcpy(dst->pg[inx], src->pg[inx], PAGE_SIZE);
+}
+
+int big_buffer_byte_get(struct big_buffer *bbuff, size_t inx, u8 *value)
+{
+	size_t page_inx = inx >> PAGE_SHIFT;
+	size_t byte_pos = inx & (PAGE_SIZE - 1);
+
+	if (page_inx >= bbuff->pg_cnt)
+		return -ENODATA;
+
+	*value = bbuff->pg[page_inx][byte_pos];
+
+	return 0;
+}
+
+int big_buffer_byte_set(struct big_buffer *bbuff, size_t inx, u8 value)
+{
+	size_t page_inx = inx >> PAGE_SHIFT;
+	size_t byte_pos = inx & (PAGE_SIZE - 1);
+
+	if (page_inx >= bbuff->pg_cnt)
+		return -ENODATA;
+
+	bbuff->pg[page_inx][byte_pos] = value;
+
+	return 0;
+}
diff --git a/drivers/block/blksnap/big_buffer.h b/drivers/block/blksnap/big_buffer.h
new file mode 100644
index 000000000000..4519d5f11c8e
--- /dev/null
+++ b/drivers/block/blksnap/big_buffer.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+#include <linux/mm.h>
+
+struct big_buffer {
+	size_t pg_cnt;
+	u8 *pg[0];
+};
+
+struct big_buffer *big_buffer_alloc(size_t count, int gfp_opt);
+void big_buffer_free(struct big_buffer *bbuff);
+
+size_t big_buffer_copy_to_user(char __user *dst_user_buffer, size_t offset,
+			       struct big_buffer *bbuff, size_t length);
+size_t big_buffer_copy_from_user(const char __user *src_user_buffer,
+				 size_t offset, struct big_buffer *bbuff,
+				 size_t length);
+
+void *big_buffer_get_element(struct big_buffer *bbuff, size_t index,
+			     size_t sizeof_element);
+
+void big_buffer_memset(struct big_buffer *bbuff, int value);
+void big_buffer_memcpy(struct big_buffer *dst, struct big_buffer *src);
+
+//byte access
+int big_buffer_byte_get(struct big_buffer *bbuff, size_t inx, u8 *value);
+int big_buffer_byte_set(struct big_buffer *bbuff, size_t inx, u8 value);
-- 
2.20.1

