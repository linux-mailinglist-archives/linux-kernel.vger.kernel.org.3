Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741CD529858
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbiEQDjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiEQDjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:39:31 -0400
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 May 2022 20:39:28 PDT
Received: from p3plwbeout12-01.prod.phx3.secureserver.net (p3plsmtp12-01-2.prod.phx3.secureserver.net [173.201.192.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC1B46667
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:39:28 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id qo0onJ0i9sfAiqo0pnEve5; Mon, 16 May 2022 20:36:43 -0700
X-CMAE-Analysis: v=2.4 cv=ZYnYiuZA c=1 sm=1 tr=0 ts=6283184b
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=oZkIemNP1mAA:10 a=QyXUC8HyAAAA:8 a=FXvPX3liAAAA:8
 a=XPsDEoqG7ybQwvttNyoA:9 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  qo0onJ0i9sfAi
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=localhost.localdomain)
        by smtp12.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1nqo0n-0004Sd-I9; Tue, 17 May 2022 04:36:41 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     hsinyi@chromium.org
Cc:     Xiongwei.Song@windriver.com, akpm@linux-foundation.org,
        houtao1@huawei.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, miaoxie@huawei.com, phillip@squashfs.org.uk,
        squashfs-devel@lists.sourceforge.net, willy@infradead.org,
        yi.zhang@huawei.com, zhengliang6@huawei.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/2] squashfs: always build "file direct" version of page actor
Date:   Tue, 17 May 2022 04:35:57 +0100
Message-Id: <20220517033557.3492-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220516105100.1412740-1-hsinyi@chromium.org>
References: <20220516105100.1412740-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfLXFLpLlRfbfGXBeIXJRjWEIJMQTP/XFm/vMyPYOSe6SM0A23GT2mpoUz9+Zc8x4Soo2M0DUY2qw+DY5ySWQ8RAel8+bf53qo1n7d/9tJ6W91LlDDvtT
 Y8UxEsGHooRoeWuPtwlLz6hOpWq1+YSlAelThS/vS96T+KK8QGXT+t/ftHyKa32yaKlEY3Itg0zRamQ6MMvp7X3JM6O8MjXqb6I=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Squashfs_readahead uses the "file direct" version of the page
actor, and so build it unconditionally.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/Makefile     |  4 ++--
 fs/squashfs/page_actor.h | 41 ----------------------------------------
 2 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/fs/squashfs/Makefile b/fs/squashfs/Makefile
index 7bd9b8b856d0..477c89a519ee 100644
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
index 2e3073ace009..26e07373af8a 100644
--- a/fs/squashfs/page_actor.h
+++ b/fs/squashfs/page_actor.h
@@ -6,46 +6,6 @@
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
-#else
 struct squashfs_page_actor {
 	union {
 		void		**buffer;
@@ -76,4 +36,3 @@ static inline void squashfs_finish_page(struct squashfs_page_actor *actor)
 	actor->squashfs_finish_page(actor);
 }
 #endif
-#endif
-- 
2.34.1

