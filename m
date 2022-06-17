Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE9854F333
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381151AbiFQIjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381141AbiFQIjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:39:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F93C69B4C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:39:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso3581828pja.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcQHcF0Ot6zJHxJE6BCq0SLAaPt9Vdx4j9mbahe8wSE=;
        b=gKMzClnTDfI8SUjMNX6fH7fhxMRMio7/lnouINYXTknvlSQGrGJcKIAZtWflN/Bohq
         qoxPsXVblEwF/jvueaJK163tba46YMu4zx8a5mAiAXDZn+N5vtObxQ9xc8Q6AghEOMJD
         W5f5AraAVihtPahuek9K4ljUWRatX40WkUMuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcQHcF0Ot6zJHxJE6BCq0SLAaPt9Vdx4j9mbahe8wSE=;
        b=AD5c2nL118BZZNVtAUpi/wL6UwotBh6bhj//897KmAdwKHca4V5H8ml38eCrgYlnlG
         GhkvoYqUQHjhxbs2z+4XfTYdi31eusJc7UenoTMCEhKnKCDnXxwMU4YxwJidkQHL2Nh1
         bhWHJK4DQ1JcujWEJochsN2sqcDPdrvSfSn6prAy4pFHA+R7cdK5sSvvEDyJVQHqUb0D
         HaJGj6ypmbZwtBeOkJCS1ZbqImiapUhFgEQFZBpBfTv9MAK+rM0bbcOv7KqY1zOE5os4
         AJ9rvoDW51R9gc2Olp402qZzYQy+pT3z1JkyUWgqwVdwrFW7wcW1DZDJwDxwIAq9CYHc
         TQHQ==
X-Gm-Message-State: AJIora9TRzVPe3KDlNA4UzBk47SFwaBNC+wads+2MwjMxXIs3BRA2yxh
        3s+Sj2cqaO7Qkx0NphKwJ90xtA==
X-Google-Smtp-Source: AGRyM1vXrobSvy6fvBmTMguR7jdxWtClLv8yNDivQ52V+DQBP9+yRJ7i0flqk2jWsoX1tcsWCsKVUA==
X-Received: by 2002:a17:902:d50e:b0:16a:13d:30ab with SMTP id b14-20020a170902d50e00b0016a013d30abmr3915658plg.31.1655455143450;
        Fri, 17 Jun 2022 01:39:03 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0dc:9427:fea8:f78a])
        by smtp.gmail.com with ESMTPSA id d12-20020a62f80c000000b005185407eda5sm3154103pfh.44.2022.06.17.01.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:39:03 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/4] squashfs: implement readahead
Date:   Fri, 17 Jun 2022 16:38:13 +0800
Message-Id: <20220617083810.337573-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220617083810.337573-1-hsinyi@chromium.org>
References: <20220617083810.337573-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reported-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/squashfs/file.c | 92 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 7f0904b203294..f0c64ee272d5d 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -39,6 +39,7 @@
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
 #include "squashfs.h"
+#include "page_actor.h"
 
 /*
  * Locate cache slot in range [offset, index] for specified inode.  If
@@ -496,7 +497,96 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	return res;
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
+		actor = squashfs_page_actor_init_special(msblk, pages, nr_pages,
+							 expected);
+		if (!actor)
+			goto skip_pages;
+
+		res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
+
+		kfree(actor);
+
+		if (res == expected) {
+			int bytes;
+
+			/* Last page (if present) may have trailing bytes not filled */
+			bytes = res % PAGE_SIZE;
+			if (pages[nr_pages - 1]->index == file_end && bytes)
+				memzero_page(pages[nr_pages - 1], bytes,
+					     PAGE_SIZE - bytes);
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
+	kfree(pages);
+	return;
+
+skip_pages:
+	for (i = 0; i < nr_pages; i++) {
+		unlock_page(pages[i]);
+		put_page(pages[i]);
+	}
+	kfree(pages);
+}
 
 const struct address_space_operations squashfs_aops = {
-	.read_folio = squashfs_read_folio
+	.read_folio = squashfs_read_folio,
+	.readahead = squashfs_readahead
 };
-- 
2.36.1.476.g0c4daa206d-goog

