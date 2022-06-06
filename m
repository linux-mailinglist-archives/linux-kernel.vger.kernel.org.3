Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7978C53EA58
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbiFFPDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbiFFPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:03:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EC61A43D0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:03:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p8so12922104pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVK/jozl1uAfEzK6vleMbKcySwChksKYsG5Iw08IS/c=;
        b=Oxd/anO5WtkVJUJUgToYwFGiGcM0uJJsObud5uRjsZD734hCJCXzwYzEeQISgp71My
         3mGUbBcR7ZEpbzr4bYMhTomrpQoIarU3oHkHDIAQXTYdIneSuMqhogsSNW8tD2KxwBd8
         V472zawpFjB3cIohTPsvNj9VlZyY94WZGKSYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVK/jozl1uAfEzK6vleMbKcySwChksKYsG5Iw08IS/c=;
        b=lhMfRjvRwDELU1zCeQi/Bu/m0AvhVidXo48HS8B1cnmUFbzDcYqb65ZRm1J1w2uRIp
         rQLyghJh8fWFYKT293y5+Kqd0PsA/vl7hYam5i10TAvsPCcJ05JKjPfmW2f0hRS/hPsg
         XtdRwGYzXSThDDdwfAR6oQOMvGpAzGCg1i5GlAiAx+WzEUTYLujieHemXKZNdYNXbAJz
         4MAO3rMvzE/GsG0jDwe+vTRAqeOC58dtYKE8RawvGk/bywXQ2JNQeHj72nKyioLazu/+
         4V4ip9/Tueg/WeES3oSBQexhkpezJR0qI9MI/RQzgx1HjJyFhrZCisHYCLJ72HHtLsCJ
         xwvQ==
X-Gm-Message-State: AOAM533kSzFxWplTCfU5b13pLa2q4HF+yjYUcGw5ll2ZrQdXoSqzzSAR
        8tqc25esCWndC+0I0oMuDQnUNw==
X-Google-Smtp-Source: ABdhPJzSAIABYaN16VMQB1hldKycOjrImKiWwTvNsL3jcjjJ0ONvT8gnKk77CzvvBg2ZGDkPEC9TGw==
X-Received: by 2002:a63:fa15:0:b0:3fd:9170:9496 with SMTP id y21-20020a63fa15000000b003fd91709496mr7945484pgh.162.1654527796764;
        Mon, 06 Jun 2022 08:03:16 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0a:5e4:e24:c8c4])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7998d000000b0050dc76281ecsm7468864pfh.198.2022.06.06.08.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:03:16 -0700 (PDT)
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
Subject: [PATCH v5 2/3] squashfs: always build "file direct" version of page actor
Date:   Mon,  6 Jun 2022 23:03:04 +0800
Message-Id: <20220606150305.1883410-3-hsinyi@chromium.org>
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

From: Phillip Lougher <phillip@squashfs.org.uk>

Squashfs_readahead uses the "file direct" version of the page
actor, and so build it unconditionally.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
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
2.36.1.255.ge46751e96f-goog

