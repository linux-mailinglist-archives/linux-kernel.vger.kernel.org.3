Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7EC5282A7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiEPKwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243023AbiEPKvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:51:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9225FA3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:51:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g184so13744687pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JMk8CHB5bcq3ReSzg2cgECR0dlKU/tAyeAvoi2QnfNE=;
        b=OKNynNPjFwGSD1DaPCEF49HEOaVfWkiddIt3TLXpzovZPm0w32mw1+sI5jGIZ53iqU
         DL9zHg/3+jPPwXL2vHoPtL1DSdVsyH7bZNV/hZuu9cmfO6L1xO1Gfss1yn77yPBo7s1z
         +wJTDMciFy2TsqHd/skAMTirRIHnkR7xPShJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JMk8CHB5bcq3ReSzg2cgECR0dlKU/tAyeAvoi2QnfNE=;
        b=s2jc0+6SdbVTQd3AMorUAjyOUl/OR6TwQ/K7VAdQYACRTZj5MIrM9tCXVd/IUwsDGe
         uncmftGCqdvEnRF2xjkGiZ6fc3qBA/MZFuxoi/KvgBV3mJU8DcaRG9Su14LAf/ZqQBS2
         USXt7mmQVZJ0PHCFpFJDE2UYylnP26ajuz/2Emc4T0mAYtKKi3vvmq6g1tKQnyYi0TFB
         jOngHWknN+dpxwLh4BrFYqZiToqOnnw+MYT3rBc0Z9PPyGfeOx8t5wKhFdvQoPpyRBUr
         jHHORqsEX5/8eR4fOzv3ft70e9mK3eR6ruqdB9RohvBZ0cUVTmip11qWTpHbi4v82ALu
         YPsA==
X-Gm-Message-State: AOAM530h8i/7yFJEr3Qs+LgWF03JYRizu/9b3KWPg2aQCXgsndaXjXRw
        Kb5hIEoGHYbHKwAgHiD85JJEng==
X-Google-Smtp-Source: ABdhPJxLUCazJwseAQ0wLAS5elWc0Q0J8Q3r6TfTavcCh6mUPnQw7yZb7qUH+IJgOAbR/PLOnZFxKw==
X-Received: by 2002:a05:6a00:10cc:b0:506:e0:d6c3 with SMTP id d12-20020a056a0010cc00b0050600e0d6c3mr17147886pfu.33.1652698300335;
        Mon, 16 May 2022 03:51:40 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cdcb:c865:6f65:d875])
        by smtp.gmail.com with ESMTPSA id o14-20020a655bce000000b003db8dd388afsm6332778pgr.10.2022.05.16.03.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:51:40 -0700 (PDT)
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
Subject: [PATCH 2/2] squashfs: implement readahead
Date:   Mon, 16 May 2022 18:51:03 +0800
Message-Id: <20220516105100.1412740-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220516105100.1412740-1-hsinyi@chromium.org>
References: <20220516105100.1412740-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Otherwise pages will be marked as uptodate. The unhandled pages will be
updated by readpage later.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Note that this patch was not formally sent to the list before. It's
attached to email thread for discussion as it's still under development.

- v1:
The patch outline was suggested by Matthew. It went through a few
reviews by Matthew offline.

- v2:
https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m442435c149d411c5c9d8019cff5915419b04bf10
This is a resend of v1.

- v3:
https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m55a709e6ba5ec59fe95323a67a7f3d6b1953e470
Fix page actor size to avoid a crash from squashfs_decompress().
Suggested by Phillip Lougher[1]
[1] https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m687f82debb7667ff31982a05aef3eba081eb5039

- v4:
https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#mf93267690ec2e841dade6a494fe72c84b61328d9
Fix to free page after used. Suggested by Xiongwei Song[2]
Refactor the skip page logic to possible improve the performance.
Suggested by Phillip Lougher[3]
[2] https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m0e7b33d167b1ef0eb39b9f41c32ed3f80dfced18
[3] https://lore.kernel.org/linux-mm/Yn5Yij9pRPCzDozt@casper.infradead.org/t/#m1e0a8f8e4a98d79d14c81b66e197b6dc0a3b77a1
---
 fs/squashfs/file.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index a8e495d8eb86..91dfec792f4c 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -39,6 +39,7 @@
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
 #include "squashfs.h"
+#include "page_actor.h"
 
 /*
  * Locate cache slot in range [offset, index] for specified inode.  If
@@ -495,7 +496,83 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	return 0;
 }
 
+static void squashfs_readahead(struct readahead_control *ractl)
+{
+	struct inode *inode = ractl->mapping->host;
+	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	size_t mask = (1UL << msblk->block_log) - 1;
+	size_t shift = msblk->block_log - PAGE_SHIFT;
+	loff_t req_end = readahead_pos(ractl) + readahead_length(ractl);
+	loff_t start = readahead_pos(ractl) &~ mask;
+	size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
+	struct squashfs_page_actor *actor;
+	unsigned int nr_pages = 0;
+	struct page **pages;
+	u64 block = 0;
+	int bsize, res, i, index;
+	int file_end = i_size_read(inode) >> msblk->block_log;
+	unsigned int max_pages = 1UL << shift;
+
+	readahead_expand(ractl, start, (len | mask) + 1);
+
+	if (readahead_pos(ractl) + readahead_length(ractl) < req_end ||
+	    file_end == 0)
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
+		bsize = read_blocklist(inode, index, &block);
+		if (bsize == 0)
+			goto skip_pages;
+
+		res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
+					 actor);
+
+		if (res >= 0)
+			for (i = 0; i < nr_pages; i++)
+				SetPageUptodate(pages[i]);
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
 	.read_folio = squashfs_read_folio
+	.readahead = squashfs_readahead
 };
-- 
2.36.0.550.gb090851708-goog

