Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680AD54F330
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380462AbiFQIiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380589AbiFQIiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:38:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AC5692BA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:38:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso2724707pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkbtHcgR5KA0zD+x9oTUHYVWwacT9VRypGcZ4wLZpOg=;
        b=IQFp5xvBUij3vF6RFgONUsdI4F7LxAqN3ZtrQJPeUNxo+8zjmXF0j0NLkeatzKk0Mu
         Defn/MOopf+Tt0LZJhZgRZHPpDV16Far+cgOJxrI7ZBIjwr2nsEfcGhxQyeciQWOJJk9
         92AbvVtuk7PzI/PoFh5iu1MlFb2Rm7mCnC7lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkbtHcgR5KA0zD+x9oTUHYVWwacT9VRypGcZ4wLZpOg=;
        b=kDXT5zJkwFVohODJt+aKBPerLV/L/cjxYJYMFhoz8nFol0RdIV9fu09k/q/VH188WG
         n20LDP1qVjOWjjiBxr7+2HnlAvJUuL9lo+yFzxFscgf1YX9OrM7mSlNOgtrbRd34st6r
         sh02SI6yMDC1w57uty2FwGZgIvgFloVVrzrNJFCiD1PSOpdHH4ksOgn4F4mJcu+abXbQ
         Hau3Dz7ok/0wKca6v4qJW6vjuyUoMrgKtZ4ByO1kYoU7dWplXGCHrj3+6bzVieInfYg5
         QO+QuYGIco/eJChq18jNaJuDfiJ9RaGTaQRUVAgveZXq3zc+Dac9aL0jwsUstcXrUIUM
         nV3A==
X-Gm-Message-State: AJIora9gPbHMMNczc2og4w+nvWsih96Xb4j057flbl72GtwVeSjCGBl5
        IhiYzO6FT8ZMSrO2qQBTAscEFA==
X-Google-Smtp-Source: AGRyM1s7VdOCGqUQpIDER4YWqjxPf/Ek4KvwYv/N24Zykvnrz2Rw2pxH86XQrvXmIMf1TkI7KpHZxg==
X-Received: by 2002:a17:902:930c:b0:167:8960:2c39 with SMTP id bc12-20020a170902930c00b0016789602c39mr8426893plb.33.1655455121565;
        Fri, 17 Jun 2022 01:38:41 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0dc:9427:fea8:f78a])
        by smtp.gmail.com with ESMTPSA id d12-20020a62f80c000000b005185407eda5sm3154103pfh.44.2022.06.17.01.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:38:41 -0700 (PDT)
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
Subject: [PATCH v7 1/4] Revert "squashfs: provide backing_dev_info in order to disable read-ahead"
Date:   Fri, 17 Jun 2022 16:38:09 +0800
Message-Id: <20220617083810.337573-2-hsinyi@chromium.org>
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

This reverts commit 9eec1d897139e5de287af5d559a02b811b844d82.

Revert closing the readahead to squashfs since the readahead callback
for squashfs is implemented.

Suggested-by: Xiongwei Song <Xiongwei.Song@windriver.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 fs/squashfs/super.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 6d594ba2ed28f..32565dafa7f3b 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -29,7 +29,6 @@
 #include <linux/module.h>
 #include <linux/magic.h>
 #include <linux/xattr.h>
-#include <linux/backing-dev.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
@@ -113,24 +112,6 @@ static const struct squashfs_decompressor *supported_squashfs_filesystem(
 	return decompressor;
 }
 
-static int squashfs_bdi_init(struct super_block *sb)
-{
-	int err;
-	unsigned int major = MAJOR(sb->s_dev);
-	unsigned int minor = MINOR(sb->s_dev);
-
-	bdi_put(sb->s_bdi);
-	sb->s_bdi = &noop_backing_dev_info;
-
-	err = super_setup_bdi_name(sb, "squashfs_%u_%u", major, minor);
-	if (err)
-		return err;
-
-	sb->s_bdi->ra_pages = 0;
-	sb->s_bdi->io_pages = 0;
-
-	return 0;
-}
 
 static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
@@ -146,20 +127,6 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	TRACE("Entered squashfs_fill_superblock\n");
 
-	/*
-	 * squashfs provides 'backing_dev_info' in order to disable read-ahead. For
-	 * squashfs, I/O is not deferred, it is done immediately in read_folio,
-	 * which means the user would always have to wait their own I/O. So the effect
-	 * of readahead is very weak for squashfs. squashfs_bdi_init will set
-	 * sb->s_bdi->ra_pages and sb->s_bdi->io_pages to 0 and close readahead for
-	 * squashfs.
-	 */
-	err = squashfs_bdi_init(sb);
-	if (err) {
-		errorf(fc, "squashfs init bdi failed");
-		return err;
-	}
-
 	sb->s_fs_info = kzalloc(sizeof(*msblk), GFP_KERNEL);
 	if (sb->s_fs_info == NULL) {
 		ERROR("Failed to allocate squashfs_sb_info\n");
-- 
2.36.1.476.g0c4daa206d-goog

