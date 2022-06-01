Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDBE53A2D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352159AbiFAKjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352141AbiFAKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:39:44 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB417CDCC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:39:42 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id n20so657748vkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wfh9GMNAtQ8X7OUdTqnBOAOW/iUKoStIjgn9vMh3x8A=;
        b=J4DFyJFooJ1/aFuihbbPDsZUg/rHDSDYYB/zizL1l+XlzXtXYJdHboF7hjsiktBIub
         UpUo4fe91c62KQ2wCh8Q+E45OrEt+KX8PYpsHsOkh2E9Aoh7GxZ5QNGR2Z1BR7K4Ed3k
         +5Tfy0rfFvGXQkPL4dqf8dbHmppQCXzaLme0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfh9GMNAtQ8X7OUdTqnBOAOW/iUKoStIjgn9vMh3x8A=;
        b=RzMZ+wL27A1gQhwiymGpRSWfGksuqL8PBZbDGmrs8EDGNxhLGXFjBpekOGuV+XsihL
         KcUvriSlOCmtgGY0XXoHx7ZEgfwmyL+hKujkmZT/Z6P6UMOZEVsxd0CxjyKW0+rLfMG7
         PpITQylNP9Yi55bG4jGV4w6AdPdnvLK91U52sWJ2t6X/fmUOglZDSKee8UV4XJDQlf5m
         Vjn3rDRXTfecEU0Htu3I75FeLTf9RCLzt1P6+bV/H/jiF9OFD1+7eD3jUIykHLN3r0et
         zd3JROuRUtGfh5SC/UVq+gPqXx6TjmLVNZxky+tFo2EHMGQbdEji5PNVLUXRz4HIaqwj
         gDOA==
X-Gm-Message-State: AOAM530/gb92XwjUdrnUzRXNHskC1GO+UTpBYEQ+OF/uX+dxInbqb5Cr
        jXjQS19IDY9XOhly19qSRMjvoq+8s8PW3g==
X-Google-Smtp-Source: ABdhPJzGikxQY4QeEMbejEgnYu1+SViSz+uEqFU1v5hBzeBBzAFeuZfr9bzWJJED51l9pR4HX5nyZA==
X-Received: by 2002:a17:902:9044:b0:15d:1c51:5bef with SMTP id w4-20020a170902904400b0015d1c515befmr65260044plz.170.1654079970845;
        Wed, 01 Jun 2022 03:39:30 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b00163bfaf0b17sm1183867plr.233.2022.06.01.03.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:39:30 -0700 (PDT)
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
Subject: [PATCH v4 1/3] Revert "squashfs: provide backing_dev_info in order to disable read-ahead"
Date:   Wed,  1 Jun 2022 18:39:20 +0800
Message-Id: <20220601103922.1338320-2-hsinyi@chromium.org>
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
2.36.1.255.ge46751e96f-goog

