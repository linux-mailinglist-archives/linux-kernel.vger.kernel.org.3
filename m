Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E053A2D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352135AbiFAKjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352117AbiFAKjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:39:35 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002547CDCC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:39:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 187so1592212pfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVK/jozl1uAfEzK6vleMbKcySwChksKYsG5Iw08IS/c=;
        b=C78pEyOpmxImWyrV8RjqLJf8nPmlGYFD0fqdmXSu3XWNvntM2agBp44iozoainWKJ3
         Axaui0YVALbQSEnR8rjEVrFcjCX26PCWreT1waD7QsntpteG59FKz9Mnrrnuu3nB9eve
         oCddJpnbDynKK9HCCW91lnavxEvDNpWEdylgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVK/jozl1uAfEzK6vleMbKcySwChksKYsG5Iw08IS/c=;
        b=A5AjWdry73xiEKwKoloqwEFZNMOJqKE9OjNwdG/2V8QONu6+Z69E+suylsZg1TMT5a
         hpyFtqOrVdegNHGQQQmWoncMZ2YR9QD6t0lRsYA49fNP7pMOVKv/DzuPKFkbo5dm3HMD
         nqF1KrFpSzzDBH83M3OBtE7ovRzi/MsPnc0tK/abnJpBT3lUeSNyWo5LwTZrvPeFupyf
         MLyXfSUCF9avtG4wARDswq1wEDVUBBDxSkQSTFBw3x++/piciQOVm+b+sGqHQJQRYcf8
         JnnsdBqhFxPc84m43C2J8EyFihRW7TO+ELbBza0etr/Z9nD5Qt/Z0MS5fJNZhJYAfoYR
         MWaQ==
X-Gm-Message-State: AOAM532jD9wR0/qiG9bxvvOPx+nEeLTpl3dJtDAKUSzGQAlbsev6bVdY
        ySvsIIZPF3OAiZi7+I47DdbpwA==
X-Google-Smtp-Source: ABdhPJxPBOFPDzYcJlTD535ykPd7L0x0pOe9kzUL+ouANmI7/8e7l2tiHiElnHP5BQ4D4XG6GTHbZA==
X-Received: by 2002:a65:6b94:0:b0:3fb:16f4:3620 with SMTP id d20-20020a656b94000000b003fb16f43620mr26218963pgw.464.1654079973429;
        Wed, 01 Jun 2022 03:39:33 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b00163bfaf0b17sm1183867plr.233.2022.06.01.03.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:39:32 -0700 (PDT)
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
Subject: [PATCH v4 2/3] squashfs: always build "file direct" version of page actor
Date:   Wed,  1 Jun 2022 18:39:21 +0800
Message-Id: <20220601103922.1338320-3-hsinyi@chromium.org>
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

