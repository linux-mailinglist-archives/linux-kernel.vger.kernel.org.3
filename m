Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AF253E8B5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiFFPDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbiFFPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:03:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C076D1D08AD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:03:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so2025625pjg.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78qlS0+VzMo9YnbPE8S51ZKOVHUk72X1BTb4Y0KDRy4=;
        b=em8v3f6IPRDCDduD4h0KpWCx4D9FyrCgpGffTuHZLi/MLHUDKn/o23wxP90AQnNC57
         72ErI/a8d3rwXKMsRhqB0p5BXIFLsOIqF7HZcyj7OCogfV81tkggLBafj2kdyX6C0zuN
         SsVBcexcgsRUES6LchEm33Lkc1bT0v06qGr10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78qlS0+VzMo9YnbPE8S51ZKOVHUk72X1BTb4Y0KDRy4=;
        b=U5SzT75mMm4C2IPlriNDHQUHKW/R5SRfrBg6AWpJbarsDOWqHHnNMXOvlj40q/T3lc
         /wjsntgvV1yoNaQTuSgUmd7LKwd/3UVn5CcPjRc6lE2ZOvVxuPW2j4Zsnxa2ahqXwqoY
         YGVmvirTmJR4sr+FrzP+HjsuRsZJwwWGgkPmWkHs9wL5bTu6bha4kT6BUR4SUzIk2E0m
         JwC3toW3n6B/jL78glP1fDxxw8ZPUl0iXtUdmm9OwmZa/Sx1wwMqhEX9lTPQE/f/XwQI
         6W0+TbUypUg5Tw0g0jizdRX4gV4SSEREvCdPn4spWe6NY7q/okKxRZRAmsE9K8c1hT8e
         25Yg==
X-Gm-Message-State: AOAM533vKTBHfJqGCjK2BgiZ1rYQkjtrRAFvXwxqNgfvQbNsivbaOplh
        CQLbvl2JwNjVPNt+TTx+aAxf+Q==
X-Google-Smtp-Source: ABdhPJzBGeo49gx5Piq2s8WNtXs8Dv8AMd8JEeGehwBIELwlmnaoWhNZHOitb6G5zWU0YW52xIWhtA==
X-Received: by 2002:a17:90b:38c8:b0:1e8:5202:f6d4 with SMTP id nn8-20020a17090b38c800b001e85202f6d4mr14524346pjb.149.1654527799750;
        Mon, 06 Jun 2022 08:03:19 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0a:5e4:e24:c8c4])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7998d000000b0050dc76281ecsm7468864pfh.198.2022.06.06.08.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:03:19 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] squashfs: implement readahead
Date:   Mon,  6 Jun 2022 23:03:05 +0800
Message-Id: <20220606150305.1883410-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220606150305.1883410-1-hsinyi@chromium.org>
References: <20220606150305.1883410-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement readahead callback for squashfs. It will read datablocks
which cover pages in readahead request. For a few cases it will
not mark page as uptodate, including:
- file end is 0.
- zero filled blocks.
- current batch of pages isn't in the same datablock.
- decompressor error.
Otherwise pages will be marked as uptodate. The unhandled pages will be
updated by readpage later.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reported-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Andrew Morton <akpm@linux-foundation.org>
---
v4->v5:
- Handle short file cases reported by Marek and Matthew.
- Fix checkpatch error reported by Andrew.

v4: https://lore.kernel.org/lkml/20220601103922.1338320-4-hsinyi@chromium.org/
v3: https://lore.kernel.org/lkml/20220523065909.883444-4-hsinyi@chromium.org/
v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromium.org/
v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
---
 fs/squashfs/file.c | 124 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index a8e495d8eb86..fbd096cd15f4 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -39,6 +39,7 @@
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
 #include "squashfs.h"
+#include "page_actor.h"
 
 /*
  * Locate cache slot in range [offset, index] for specified inode.  If
@@ -495,7 +496,128 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	return 0;
 }
 
+static void squashfs_readahead(struct readahead_control *ractl)
+{
+	struct inode *inode = ractl->mapping->host;
+	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	size_t mask = (1UL << msblk->block_log) - 1;
+	unsigned short shift = msblk->block_log - PAGE_SHIFT;
+	loff_t start = readahead_pos(ractl) & ~mask;
+	size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
+	struct squashfs_page_actor *actor;
+	unsigned int nr_pages = 0;
+	struct page **pages;
+	int i, file_end = i_size_read(inode) >> msblk->block_log;
+	unsigned int max_pages = 1UL << shift;
+
+	readahead_expand(ractl, start, (len | mask) + 1);
+
+	if (file_end == 0)
+		return;
+
+	pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
+	if (!pages)
+		return;
+
+	actor = squashfs_page_actor_init_special(pages, max_pages, 0);
+	if (!actor)
+		goto out;
+
+	for (;;) {
+		pgoff_t index;
+		int res, bsize;
+		u64 block = 0;
+		unsigned int expected;
+
+		nr_pages = __readahead_batch(ractl, pages, max_pages);
+		if (!nr_pages)
+			break;
+
+		if (readahead_pos(ractl) >= i_size_read(inode))
+			goto skip_pages;
+
+		index = pages[0]->index >> shift;
+		if ((pages[nr_pages - 1]->index >> shift) != index)
+			goto skip_pages;
+
+		expected = index == file_end ?
+			   (i_size_read(inode) & (msblk->block_size - 1)) :
+			    msblk->block_size;
+
+		bsize = read_blocklist(inode, index, &block);
+		if (bsize == 0)
+			goto skip_pages;
+
+		if (nr_pages < max_pages) {
+			struct squashfs_cache_entry *buffer;
+			unsigned int block_mask = max_pages - 1;
+			int offset = pages[0]->index - (pages[0]->index & ~block_mask);
+
+			buffer = squashfs_get_datablock(inode->i_sb, block,
+							bsize);
+			if (buffer->error) {
+				squashfs_cache_put(buffer);
+				goto skip_pages;
+			}
+
+			expected -= offset * PAGE_SIZE;
+			for (i = 0; i < nr_pages && expected > 0; i++,
+						expected -= PAGE_SIZE, offset++) {
+				int avail = min_t(int, expected, PAGE_SIZE);
+
+				squashfs_fill_page(pages[i], buffer,
+						offset * PAGE_SIZE, avail);
+				unlock_page(pages[i]);
+			}
+
+			squashfs_cache_put(buffer);
+			continue;
+		}
+
+		res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
+					 actor);
+
+		if (res == expected) {
+			int bytes;
+
+			/* Last page may have trailing bytes not filled */
+			bytes = res % PAGE_SIZE;
+			if (bytes) {
+				void *pageaddr;
+
+				pageaddr = kmap_atomic(pages[nr_pages - 1]);
+				memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
+				kunmap_atomic(pageaddr);
+			}
+
+			for (i = 0; i < nr_pages; i++) {
+				flush_dcache_page(pages[i]);
+				SetPageUptodate(pages[i]);
+			}
+		}
+
+		for (i = 0; i < nr_pages; i++) {
+			unlock_page(pages[i]);
+			put_page(pages[i]);
+		}
+	}
+
+	kfree(actor);
+	kfree(pages);
+	return;
+
+skip_pages:
+	for (i = 0; i < nr_pages; i++) {
+		unlock_page(pages[i]);
+		put_page(pages[i]);
+	}
+
+	kfree(actor);
+out:
+	kfree(pages);
+}
 
 const struct address_space_operations squashfs_aops = {
-	.read_folio = squashfs_read_folio
+	.read_folio = squashfs_read_folio,
+	.readahead = squashfs_readahead
 };
-- 
2.36.1.255.ge46751e96f-goog

