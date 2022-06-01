Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB3F53A2D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352150AbiFAKjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352120AbiFAKjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:39:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3117CDF3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:39:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y196so1599399pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pt3emh9sRv27GcQGoBsy8VqQGPtdBSzil539OvyNfVQ=;
        b=npgk1ZKmueI5lZFFzNwkrfAGR35TrhiHe4Bt8ftRQ7yumNW8F6tPSmv7mEhm6/tuF1
         7KJLx0nwVtdymcisO3+aXt05FKhJ5TbtRgzZihTNkGr/JGrnvVP58/6M3kQoKvJVXwya
         dbJBblmhBe8tx8v5Ukuu9w4JvI8rSw1qLt5Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pt3emh9sRv27GcQGoBsy8VqQGPtdBSzil539OvyNfVQ=;
        b=bi9osYxP96W8OBuFlIZrsR+b9BA5t6Y5T7LttIGzi+b6LehuKI18aIAev/9ifPO4b2
         op983gRQlXBRJLazkYi2zJF2ZHkT3ClSEQGgI3vb6d/qLNx5e+L0GexIEKnewGzb/jTz
         Gkyl48LD8FDiRTc/HfTkFAmWjDL35QJB5LRaKACnvc+BL7xKoJw5IbTnV9R52StCnfNl
         hz0+WxfrcZnCtOFcKzbb3uTVkbdCH+RqOMFfKKTGhV6RAXBCw9olgYi8igRcSYskBNRL
         dBF5q/vZ8I6o/uZsQp3iLfbYRbLjZhoIfd8lKBC/Own6ZQUKuHawTM/+j2zB7IzDM4kQ
         RJBQ==
X-Gm-Message-State: AOAM530qxuIINcOMhO06EeyNG69muhtmEn1TTc+Jq9zNdD5FZwwakiwn
        jp1qtDTJX93lCNlGLFKwOGlSFpK6v7WqMA==
X-Google-Smtp-Source: ABdhPJyTATonbx8DBaAETQIhbDZDdB/jypUUcYIpqGWAzeXLbC2fOMCBWG9ub55OlJpr43hOQgu0SQ==
X-Received: by 2002:a63:894a:0:b0:3fc:a724:578c with SMTP id v71-20020a63894a000000b003fca724578cmr1936274pgd.499.1654079976036;
        Wed, 01 Jun 2022 03:39:36 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b00163bfaf0b17sm1183867plr.233.2022.06.01.03.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:39:35 -0700 (PDT)
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
Subject: [PATCH v4 3/3] squashfs: implement readahead
Date:   Wed,  1 Jun 2022 18:39:22 +0800
Message-Id: <20220601103922.1338320-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601103922.1338320-1-hsinyi@chromium.org>
References: <20220601103922.1338320-1-hsinyi@chromium.org>
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
v3->v4: Fix a few variable type and their locations.
v3: https://lore.kernel.org/lkml/20220523065909.883444-4-hsinyi@chromium.org/
v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromium.org/
v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
---
 fs/squashfs/file.c | 97 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index a8e495d8eb86..df7ad4b3e99c 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -39,6 +39,7 @@
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
 #include "squashfs.h"
+#include "page_actor.h"
 
 /*
  * Locate cache slot in range [offset, index] for specified inode.  If
@@ -495,7 +496,101 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	return 0;
 }
 
+static void squashfs_readahead(struct readahead_control *ractl)
+{
+	struct inode *inode = ractl->mapping->host;
+	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	size_t mask = (1UL << msblk->block_log) - 1;
+	unsigned short shift = msblk->block_log - PAGE_SHIFT;
+	loff_t start = readahead_pos(ractl) &~ mask;
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
2.36.1.255.ge46751e96f-goog

