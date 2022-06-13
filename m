Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B122548223
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiFMIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiFMI2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:28:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AA5B85E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:28:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h1so4480772plf.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PWjwYzB1HNf+oPRDU2wDyWSO4j3cyp8KqyrOSYFXeuM=;
        b=R43F9PSPlNS3+j0fw+D4qLkyB2pNxxG+Kf9qvBKMGRcozIpC9qYPH9m/kxTrduFUZt
         Get7ZtYXGMS0lblH3PECs6OSbjvJQAeSIxK8WwtonC7AjhgAC8AMUSGLtH6Qo3XUmCbu
         CtNNhK/b0kQt0+tvXslyUKS2nSNroZsDd6aJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PWjwYzB1HNf+oPRDU2wDyWSO4j3cyp8KqyrOSYFXeuM=;
        b=Y+XCTcyqlIEA7dI9jDnhONHdpimQiaQzp8gRDrs7Ec5xDI/2fJLA+pO0aGHiO0mG2E
         JPrYZF5KIbwd1qsGkzM84DmzR9Nfn9N6eaxo3BdnAK5nFnZ5qitTIMsxF8mmfGmVCr4U
         /qtq922MbwQ4uXxfwFCgjIXsQDb2Vtr87sJRK9NRpk9bfgDqP/KpvQ0DGUdzu3CplP6a
         Hew1BwADygEvHSh/1fMpPCIjUpf+BIsfW/3Fu4XJ927OTMLJyAsisH9h8QW+rjh77Jb6
         hm3NLp3gUMBWw7w9afl48Qej0g+7cS+B58Z4kUlXgoBnTvNkL06DQdD69KW2u3/VabcC
         md9w==
X-Gm-Message-State: AOAM531m0JIRXPVnd0ZAMxFx8qxtTID7AiGOFNXSQpMuVdSxWQRdal5U
        RZS2EfZCmg+GG5V1bg/lY1bOAw==
X-Google-Smtp-Source: ABdhPJxGVyS1PPoBilRK9Z+DXulNdhuOawyV0hnMEGPXO44wPhWnP2DXLm8oOQeYEhn1M78QwqZJFg==
X-Received: by 2002:a17:902:7e84:b0:166:395c:4b68 with SMTP id z4-20020a1709027e8400b00166395c4b68mr58667443pla.8.1655108892769;
        Mon, 13 Jun 2022 01:28:12 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:79ca:e1d9:ad5:dc9e])
        by smtp.gmail.com with ESMTPSA id br8-20020a056a00440800b00518a473265csm4624906pfb.217.2022.06.13.01.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:28:12 -0700 (PDT)
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
Subject: [PATCH v6 2/3] squashfs: always build "file direct" version of page actor
Date:   Mon, 13 Jun 2022 16:28:01 +0800
Message-Id: <20220613082802.1301238-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220613082802.1301238-1-hsinyi@chromium.org>
References: <20220613082802.1301238-1-hsinyi@chromium.org>
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

From: Phillip Lougher <phillip@squashfs.org.uk>

Squashfs_readahead uses the "file direct" version of the page
actor, and so build it unconditionally.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v5->v6:
rebase content on top of the dependent series.
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

