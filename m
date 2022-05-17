Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9644529C70
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiEQI2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243213AbiEQI2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:28:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B81C35840
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:28:02 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q15so331442pgr.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+R+fxU+HB5gKOLIq4R9U6MpMKxamVRAqOnvuBWzswog=;
        b=m3EFejuWwJKbr8acWHYt1jcKH1XPKtFgaFUPy58b25qXx9yCAoCuerpQi4PbWKF27G
         hGHiDFPzoph/KDl9JYmlHIYxwQqIt1ZjhgiRd6QDvDvAZSXs808vVl3+58ngkfAoA8rl
         ISEXhRBLuWXeOyCpeTrupazy1U4QHKCuRDBUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+R+fxU+HB5gKOLIq4R9U6MpMKxamVRAqOnvuBWzswog=;
        b=UHbBO/YX756DNIgWsHgTZ9keHsWYCqQUwoxV80r1pyHx6tSBQrMzRnS6mjOxLgcuMm
         sJhhcDyLfteuyMUSf1nZkrKAmAB0BBbnO7V3byen4g2xyZQB3lsvZ3TxvMjX+aOpJ4Ha
         yrsSYDdU9DOAPOMSOQUjdjs2XkzvbAN6q0rHUMemdEsNRGBZ2ZoUKjEvvCcUQopwo2Jc
         BJvUGkQeh242kJKl7ULGc958W5AwSmSNGzKvPf0XNJ8bJ/DaLEPtXlB7Qc/X93p9b78j
         eQQKdgZl2Zhzu1FpwkSjpb1d6X+0ncRFrloTj+DuaQGpuDTZR5ZKQBfuXNAaj7M9+I5P
         Kg5w==
X-Gm-Message-State: AOAM531sHhT5W3uFnUkgjA+6KYOBYvkfsHTDbgDH57ZhyobRGEwxIF2g
        MiDB5QES7FdxfDrXum1DFzcqug==
X-Google-Smtp-Source: ABdhPJxTRQM6mw43bwjZ0jYUndKgxmKDCioKQ+bdLyU0Z5Ic7AFcCEZavy5zlfYApCDIc7k2AI2kQA==
X-Received: by 2002:a05:6a00:f85:b0:518:10e1:86b with SMTP id ct5-20020a056a000f8500b0051810e1086bmr97209pfb.34.1652776081745;
        Tue, 17 May 2022 01:28:01 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:beb2:ec58:2159:9a33])
        by smtp.gmail.com with ESMTPSA id k9-20020a628409000000b0050dc76281d3sm8615083pfd.173.2022.05.17.01.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 01:28:01 -0700 (PDT)
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
Subject: [PATCH v2 2/3] squashfs: always build "file direct" version of page actor
Date:   Tue, 17 May 2022 16:26:52 +0800
Message-Id: <20220517082650.2005840-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220517082650.2005840-1-hsinyi@chromium.org>
References: <20220517082650.2005840-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.36.0.550.gb090851708-goog

