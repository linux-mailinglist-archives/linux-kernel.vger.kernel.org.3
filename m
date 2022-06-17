Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972DD54F334
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381230AbiFQIjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381199AbiFQIjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:39:31 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7D969730
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:39:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o6so3330506plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G086Dnit23XcYgqGZXR8d4QAiX5I5zPq+4/SqclxxJs=;
        b=VdbwQ4cd6v433oanoE0oyHKGpgJ6Sqwso/c30X2vOYB5aA4/iAtfKKyfVWc0dmgiXu
         CWjpdg0Kc8jVXkJVDW8W21xhw0scR/bhN55J5YUHztOeynl60wnyx6Yav+WWA1iL1NKy
         BrkUYqeLHVQqTyDE2xNlZuADrrmCANFnZj9WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G086Dnit23XcYgqGZXR8d4QAiX5I5zPq+4/SqclxxJs=;
        b=Fv5sxBpX7FldpH94LKUrBUSDDmToWmMJPU93F2C2YutdQNKbT2RvOnUfjEYiVEyQ3m
         l6KIJnCstNb73AineKZdNspSc0VJrRB2+kcWnPqAAINqUAICb+coPRW44RvgVvbnkUOT
         ldBVPFNF71xO4lrK0JFHvsF7AmQ0a0P0E3dH7JVMct1UdS08kZYkc31ISglipjyrQU5t
         asywondtSxjC4ciWmbqyH4kiYwNEWxI6INTjRqkzsBatU6zY58wa3eWmYNiVITmkGYms
         HL4CkupUZKvLW2CKN5DBt5nSt+GKOaggOB2SsvG2ZCcrPxo5rMV2TSJ2yc8CaPX8U8wZ
         uDtA==
X-Gm-Message-State: AJIora8Dj21Tg7jrP5G05Di3e7gWyDPnnPxHVMuYmvLdZm7wTIuMNGNz
        GB2tvuqmWqh2gSV+LMid63wi+Q==
X-Google-Smtp-Source: AGRyM1tPpQfuwZvZz9Xp+OlNElXn9z7cg7Ee0CHxsdUetFEHC3NVB1yjPycl87pTn/NmxdJo4O59hw==
X-Received: by 2002:a17:90b:388c:b0:1e2:f376:b8d with SMTP id mu12-20020a17090b388c00b001e2f3760b8dmr20205301pjb.148.1655455152985;
        Fri, 17 Jun 2022 01:39:12 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0dc:9427:fea8:f78a])
        by smtp.gmail.com with ESMTPSA id d12-20020a62f80c000000b005185407eda5sm3154103pfh.44.2022.06.17.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:39:12 -0700 (PDT)
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
Subject: [PATCH v7 4/4] squashfs: support reading fragments in readahead call
Date:   Fri, 17 Jun 2022 16:38:15 +0800
Message-Id: <20220617083810.337573-5-hsinyi@chromium.org>
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

From: Phillip Lougher <phillip@squashfs.org.uk>

This patch adds a function which can be used to read fragments in the
readahead call.

This function is necessary because filesystems built with the -tailends
(or -always-use-fragments) option may have fragments present which
cannot be currently handled.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 fs/squashfs/file.c | 47 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index f0c64ee272d5d..98e64fec75b77 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -497,6 +497,41 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	return res;
 }
 
+static int squashfs_readahead_fragment(struct page **page,
+	unsigned int pages, unsigned int expected)
+{
+	struct inode *inode = page[0]->mapping->host;
+	struct squashfs_cache_entry *buffer = squashfs_get_fragment(inode->i_sb,
+		squashfs_i(inode)->fragment_block,
+		squashfs_i(inode)->fragment_size);
+	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
+
+	if (buffer->error)
+		goto out;
+
+	expected += squashfs_i(inode)->fragment_offset;
+
+	for (n = 0; n < pages; n++) {
+		unsigned int base = (page[n]->index & mask) << PAGE_SHIFT;
+		unsigned int offset = base + squashfs_i(inode)->fragment_offset;
+
+		if (expected > offset) {
+			unsigned int avail = min_t(unsigned int, expected -
+				offset, PAGE_SIZE);
+
+			squashfs_fill_page(page[n], buffer, offset, avail);
+		}
+
+		unlock_page(page[n]);
+		put_page(page[n]);
+	}
+
+out:
+	squashfs_cache_put(buffer);
+	return buffer->error;
+}
+
 static void squashfs_readahead(struct readahead_control *ractl)
 {
 	struct inode *inode = ractl->mapping->host;
@@ -513,9 +548,6 @@ static void squashfs_readahead(struct readahead_control *ractl)
 
 	readahead_expand(ractl, start, (len | mask) + 1);
 
-	if (file_end == 0)
-		return;
-
 	pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
 	if (!pages)
 		return;
@@ -541,6 +573,15 @@ static void squashfs_readahead(struct readahead_control *ractl)
 			   (i_size_read(inode) & (msblk->block_size - 1)) :
 			    msblk->block_size;
 
+		if (index == file_end && squashfs_i(inode)->fragment_block !=
+						SQUASHFS_INVALID_BLK) {
+			res = squashfs_readahead_fragment(pages, nr_pages,
+							  expected);
+			if (res)
+				goto skip_pages;
+			continue;
+		}
+
 		bsize = read_blocklist(inode, index, &block);
 		if (bsize == 0)
 			goto skip_pages;
-- 
2.36.1.476.g0c4daa206d-goog

