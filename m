Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A7854F332
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380759AbiFQIjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380589AbiFQIiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:38:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A1669486
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:38:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w21so3644906pfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zopK+BvSuamYvb8kkpPXiSJpoMOkgUyTWgxXUH/cCsw=;
        b=GpjdkIbTWWbrZUCBW7rlQQdUuuBvKFDKBuLlaoY5VjEUH10jMZXq59WS6tJnFqEgfL
         c2058J9vJgcrlylt8KFriWP/rA4D2Tzv8GF0nE7LdoNrmnUfvxYWAlDgXRm62NqnITvI
         SgKeEyr4pOBraKH9bjFC+FgB/1ZzI5FGuLBG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zopK+BvSuamYvb8kkpPXiSJpoMOkgUyTWgxXUH/cCsw=;
        b=7cvpRwHFDlrW0+x+Nci/Rb+UlFUjjTIflbagZK/Iqe+s3oozSeZ9apNNejmy5IlxMW
         UzoeSfwOzuZJ4KALQjtDr4aqaFCkh+BuOgSet5eAKU6DxTbk0RpJmcOO8tFNNbMN/R4S
         Vh8/vKtSAEUEL7F4FD5YgzNaEod0kgMafKAsu/WJvk6EhLw+Hlmw2Ql+E+ws0smfUuK+
         EC/cJFH1nons05MinxNcW8tdPor7jyqKMb0Auw8N7osR9RcZUEsVyKHh2WvKh7t5MRzS
         DxT+YLtPirChLl95hXCKXiei6JtZ9Mz3rNb97UYRa+Hg+dNmpBraRLu1xUhSb4HIHLGi
         natQ==
X-Gm-Message-State: AJIora+AlPajBTc8rGpxN8OoLzle80/ceIXNnBWNFlGP+i6fA+upwldq
        8//TU98YhwaeMujgLqmnFsDp9Q==
X-Google-Smtp-Source: AGRyM1uPYLhqbv/0uKLCtUWT/6Sgfvzcvfo4kaPqSj6W9uUwVrFuRA9YUyKPuKXoe5ttY3bo9JJPng==
X-Received: by 2002:a05:6a00:1502:b0:51c:2991:f1c with SMTP id q2-20020a056a00150200b0051c29910f1cmr8765805pfu.37.1655455134146;
        Fri, 17 Jun 2022 01:38:54 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0dc:9427:fea8:f78a])
        by smtp.gmail.com with ESMTPSA id d12-20020a62f80c000000b005185407eda5sm3154103pfh.44.2022.06.17.01.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:38:53 -0700 (PDT)
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
Subject: [PATCH v7 2/4] squashfs: always build "file direct" version of page actor
Date:   Fri, 17 Jun 2022 16:38:11 +0800
Message-Id: <20220617083810.337573-3-hsinyi@chromium.org>
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

Squashfs_readahead uses the "file direct" version of the page
actor, and so build it unconditionally.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 fs/squashfs/Makefile     |  4 ++--
 fs/squashfs/page_actor.h | 46 ----------------------------------------
 2 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/fs/squashfs/Makefile b/fs/squashfs/Makefile
index 7bd9b8b856d0b..477c89a519ee8 100644
--- a/fs/squashfs/Makefile
+++ b/fs/squashfs/Makefile
@@ -5,9 +5,9 @@
 
 obj-$(CONFIG_SQUASHFS) += squashfs.o
 squashfs-y += block.o cache.o dir.o export.o file.o fragment.o id.o inode.o
-squashfs-y += namei.o super.o symlink.o decompressor.o
+squashfs-y += namei.o super.o symlink.o decompressor.o page_actor.o
 squashfs-$(CONFIG_SQUASHFS_FILE_CACHE) += file_cache.o
-squashfs-$(CONFIG_SQUASHFS_FILE_DIRECT) += file_direct.o page_actor.o
+squashfs-$(CONFIG_SQUASHFS_FILE_DIRECT) += file_direct.o
 squashfs-$(CONFIG_SQUASHFS_DECOMP_SINGLE) += decompressor_single.o
 squashfs-$(CONFIG_SQUASHFS_DECOMP_MULTI) += decompressor_multi.o
 squashfs-$(CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU) += decompressor_multi_percpu.o
diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
index 37523c54256fa..24841d28bc0fb 100644
--- a/fs/squashfs/page_actor.h
+++ b/fs/squashfs/page_actor.h
@@ -6,51 +6,6 @@
  * Phillip Lougher <phillip@squashfs.org.uk>
  */
 
-#ifndef CONFIG_SQUASHFS_FILE_DIRECT
-struct squashfs_page_actor {
-	void	**page;
-	int	pages;
-	int	length;
-	int	next_page;
-};
-
-static inline struct squashfs_page_actor *squashfs_page_actor_init(void **page,
-	int pages, int length)
-{
-	struct squashfs_page_actor *actor = kmalloc(sizeof(*actor), GFP_KERNEL);
-
-	if (actor == NULL)
-		return NULL;
-
-	actor->length = length ? : pages * PAGE_SIZE;
-	actor->page = page;
-	actor->pages = pages;
-	actor->next_page = 0;
-	return actor;
-}
-
-static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
-{
-	actor->next_page = 1;
-	return actor->page[0];
-}
-
-static inline void *squashfs_next_page(struct squashfs_page_actor *actor)
-{
-	return actor->next_page == actor->pages ? NULL :
-		actor->page[actor->next_page++];
-}
-
-static inline void squashfs_finish_page(struct squashfs_page_actor *actor)
-{
-	/* empty */
-}
-
-static inline void squashfs_actor_nobuff(struct squashfs_page_actor *actor)
-{
-	/* empty */
-}
-#else
 struct squashfs_page_actor {
 	union {
 		void		**buffer;
@@ -91,4 +46,3 @@ static inline void squashfs_actor_nobuff(struct squashfs_page_actor *actor)
 	actor->alloc_buffer = 0;
 }
 #endif
-#endif
-- 
2.36.1.476.g0c4daa206d-goog

