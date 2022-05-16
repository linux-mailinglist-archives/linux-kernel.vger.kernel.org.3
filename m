Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F625282A6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242827AbiEPKwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242997AbiEPKv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:51:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C1F5FA3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:51:27 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v10so13703736pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5RbQ3j9RMbZ/D6MAR7ISAUvOQDvpOlhf1s/Zk6REvQs=;
        b=TZqROHTy4bHF74S5KUPgYAYiymslKKVBA7bRL3/HGi4JHQB8muBNwXApRa0cU+VWhS
         iDhqHMiS97n7lTt4aPXGafW1hSdMlSn0/MjzhUr5uDezSoKTsE2/fU3tuMWFAIQsDW57
         VoEjrIWGFnek4FgPEBYZGiUVXkUJq4gERo+VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5RbQ3j9RMbZ/D6MAR7ISAUvOQDvpOlhf1s/Zk6REvQs=;
        b=NY4D0S4P52g443q+yPJsifZfA7M3e/SORbkfxDTRpSZiDctDag4nmvlBf65KZKb2v5
         wfCjw5CMYeH59CRpXamgEa4ybn+OvRstoQPkODG1PMNx77/E8fZUWtWOzSQnqhldOFb5
         K4Agh1QeFTU13JQz1mlcCTDCaZMqgbpfMXVVgc8YkRr84ICWIZGkvGqyPbsOCFBYQaJb
         csEGBw2ay/XIFRPijO2b+NV+BY4IO4nHEA6XkpUKImLhcphi2Ywxp3hRiq6ntG0RQ+xV
         5Su7USuQAloUpfUs75bdjpsIqmet+cDYuXaLeVzhPIohFaXM1h07AM3yrL4qFajH2WG6
         p+0w==
X-Gm-Message-State: AOAM530J2B7g9KPDA1sxztjcgzvDy0I+G85w6W/D5SsUjFy0V/UqXm4q
        5w/PYgNcZsDNYSJbTEZuef7oetO7b5KfGw==
X-Google-Smtp-Source: ABdhPJyQ5XmFT7yQ/quMHs3G1SNLRmrs0Q+kvbBJA9PMECYOuXFf5iA+2PsREWr5Wz+K7aTd/M7V3Q==
X-Received: by 2002:a63:5522:0:b0:3c5:e4be:5a49 with SMTP id j34-20020a635522000000b003c5e4be5a49mr14595263pgb.26.1652698286995;
        Mon, 16 May 2022 03:51:26 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cdcb:c865:6f65:d875])
        by smtp.gmail.com with ESMTPSA id o14-20020a655bce000000b003db8dd388afsm6332778pgr.10.2022.05.16.03.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:51:26 -0700 (PDT)
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
Subject: [PATCH 1/2] Revert "squashfs: provide backing_dev_info in order to disable read-ahead"
Date:   Mon, 16 May 2022 18:51:01 +0800
Message-Id: <20220516105100.1412740-2-hsinyi@chromium.org>
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

This reverts commit 9eec1d897139e5de287af5d559a02b811b844d82.

Revert closing the readahead to squashfs since the readahead callback
for squashfs is implemented.

Suggested-by: Xiongwei Song <sxwjean@gmail.com>
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
2.36.0.550.gb090851708-goog

