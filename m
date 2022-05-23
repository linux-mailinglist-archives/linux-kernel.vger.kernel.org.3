Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7F5530A29
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiEWHYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiEWHWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:22:19 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C1610575
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:14:03 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id t12so6660749vkt.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HDi9xEtp8+cj5bsf5JN5+R5BFytv9jkvX5VZGd9dnU0=;
        b=UxqkeG4TS7Vls3G5OKJGYepxuYjCZ6IqBoXYMtw9AN7M89IC4p4tPHJspPyVwwNDPz
         bYcgjDax771MYz9EiTay7QZhCfg2Pvkqx1v/ArsV2Sxu74SUvjVz2R6Eo8P7Gd8o/X5d
         FpFXd96eS2on1YHqFDjZE6a9RnvvkboSSOBSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HDi9xEtp8+cj5bsf5JN5+R5BFytv9jkvX5VZGd9dnU0=;
        b=FcBiM7bTgdjRDaYFlTXY2TuwgI9eVFhvTkTEmrRCJGqyPnnUkSV2dDSAX+5AtTmIWe
         k63tra1umI2weSfE8ZU/OHHW77WR36HJLyxACp5sZXR++LKodVFRjotfHr6odpTgWCUn
         X4/MJiZtOHE3KCufcAi8LJr+Lxr1B8fSpIgJ77QWvJ4Wny8hunM3h8vELIjfRTNUlR3Q
         61xmtOMZhSJLmuoLGyFsn1SliqoL+QtU7yxjL/J+YzGTYVklFHIMsX5iQcfdSNy7l6LK
         1AW/Akrt2839U/gMXFSe2UoJnsRuIkKAl+0jzH1E0ZogvyG/lEA2cupi8H7q29Cqg9+W
         hBeA==
X-Gm-Message-State: AOAM533Y0wwFIHHg9xoHRg6QBJZjv/gDdrS+yTx4ZamXvhLHXHiY0qRd
        Qjo9esEHo3a+TpFZHUkWxDcbm2OWBB5XiQ==
X-Google-Smtp-Source: ABdhPJxTXxgVtmCDvjsu+UF9iPAHjiAob+1BBg8pK++x+mFwZJSzqMQrBWqk7s5ILPFs5E8RXtjNgQ==
X-Received: by 2002:a05:6a00:8cb:b0:510:9ec4:8f85 with SMTP id s11-20020a056a0008cb00b005109ec48f85mr22585467pfu.24.1653289191034;
        Sun, 22 May 2022 23:59:51 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:76d5:494d:1690:d003])
        by smtp.gmail.com with ESMTPSA id m2-20020a629402000000b005180f4733a8sm3099527pfe.106.2022.05.22.23.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:59:50 -0700 (PDT)
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
Subject: [PATCH v3 1/3] Revert "squashfs: provide backing_dev_info in order to disable read-ahead"
Date:   Mon, 23 May 2022 14:59:09 +0800
Message-Id: <20220523065909.883444-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220523065909.883444-1-hsinyi@chromium.org>
References: <20220523065909.883444-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 6d594ba2ed28..32565dafa7f3 100644
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
2.36.1.124.g0e6072fb45-goog

