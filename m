Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED18530AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiEWHVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiEWHUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:20:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3BA7355A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:12:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p8so12875023pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/ak3fxbDlmFRvOmVIgctXK5enM9fzzhqOEs66o/WZM=;
        b=BJYsjmLTVsLt/DTcxdKUZlCPRaGxYqNgQ3iPjE0uaCVFHbQ5IfcSm2bRKpCOy1sKyB
         P8SRFu76e4eKYu2KV3zIGjFcZQz/o/iMiGBWw6KU64KmqHFC1s2lZDKrqqSxtW6As6L0
         iXUZ6q4c8IEnzqZTeXStFgBDuLzkBwg/vZEYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/ak3fxbDlmFRvOmVIgctXK5enM9fzzhqOEs66o/WZM=;
        b=4qRhxMdCGFI3SOnHAWpd7O0lfYefwNganW1yPRMLl229Mqu4lMG575BpiOmra+41Om
         J7mFlv/mULcLhiR3DZPT7n/hw5JmMB9RpoRmxl2Gj80kuU5U3suyYU3k8fE/QZI1CKiT
         6OAxoEzqn8xZK9I1e0URtz8BIGjQ8kFDulabT/YKEk3p3WRYaJiQZheplrf2lWOOiJqI
         pP1ntYwkLb+ufqrePbmMjI/QOlYBLIY7xciA2TXnITeaZKyejjUtQ7j8aS9euzdwH8lx
         Eijxfxk65RKeqVxDkmLCn8HhMJHjb3vy2qQgMJDPbNbRVEDsYYa5D2yzJqSnI3I1XqLg
         cb6w==
X-Gm-Message-State: AOAM533k9oUMu16rNCffyd1z7FV3AqvpSDnk504aj5DBX40z4oqn+Hmz
        VNaJtIe31FEqbtVBUxKq3hM/JYd/nfZnFw==
X-Google-Smtp-Source: ABdhPJwEV3eRY3ezvap02NItAMRg3nkr6LiufW/9apHU0swp7gID6uukw67Oyat2knY8vtCPnx9gMw==
X-Received: by 2002:a05:6a00:a85:b0:506:b9e:7f43 with SMTP id b5-20020a056a000a8500b005060b9e7f43mr22302851pfl.5.1653289212266;
        Mon, 23 May 2022 00:00:12 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:76d5:494d:1690:d003])
        by smtp.gmail.com with ESMTPSA id m2-20020a629402000000b005180f4733a8sm3099527pfe.106.2022.05.23.00.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 00:00:11 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>
Cc:     Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] squashfs: implement readahead
Date:   Mon, 23 May 2022 14:59:13 +0800
Message-Id: <20220523065909.883444-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220523065909.883444-1-hsinyi@chromium.org>
References: <20220523065909.883444-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
- current batch of pages isn't in the same datablock or not enough in a
  datablock.
- decompressor error.
Otherwise pages will be marked as uptodate. The unhandled pages will be
updated by readpage later.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reported-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
---
v2->v3: Add checks on
- decompressed block size.
- fill zeros if the last page is not a full page.

v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromium.org/
v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
---
 fs/squashfs/file.c | 91 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index a8e495d8eb86..c311fc685fe4 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -39,6 +39,7 @@
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
 #include "squashfs.h"
+#include "page_actor.h"
 
 /*
  * Locate cache slot in range [offset, index] for specified inode.  If
@@ -495,7 +496,95 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	return 0;
 }
 
+static void squashfs_readahead(struct readahead_control *ractl)
+{
+	struct inode *inode = ractl->mapping->host;
+	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	size_t mask = (1UL << msblk->block_log) - 1;
+	size_t shift = msblk->block_log - PAGE_SHIFT;
+	loff_t start = readahead_pos(ractl) &~ mask;
+	size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
+	struct squashfs_page_actor *actor;
+	unsigned int nr_pages = 0;
+	struct page **pages;
+	u64 block = 0;
+	int bsize, res, i, index, bytes, expected;
+	int file_end = i_size_read(inode) >> msblk->block_log;
+	unsigned int max_pages = 1UL << shift;
+	void *pageaddr;
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
+		nr_pages = __readahead_batch(ractl, pages, max_pages);
+		if (!nr_pages)
+			break;
+
+		if (readahead_pos(ractl) >= i_size_read(inode) ||
+		    nr_pages < max_pages)
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
+		res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
+					 actor);
+
+		if (res == expected) {
+			/* Last page may have trailing bytes not filled */
+			bytes = res % PAGE_SIZE;
+			if (bytes) {
+				pageaddr = kmap_atomic(pages[nr_pages - 1]);
+				memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
+				kunmap_atomic(pageaddr);
+			}
+
+			for (i = 0; i < nr_pages; i++)
+				SetPageUptodate(pages[i]);
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
2.36.1.124.g0e6072fb45-goog

