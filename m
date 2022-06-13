Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F15548230
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiFMIj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbiFMI2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:28:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9305813CDE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:28:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d13so4472691plh.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkbtHcgR5KA0zD+x9oTUHYVWwacT9VRypGcZ4wLZpOg=;
        b=TgHg0MUizrXjDF8ad/OqkO0qwgk0KXix4D6xsPRARVAZQlAAVWz859Q5ieKtHCft7k
         owKsPdbZEYtxyqYnHeIU8IAIdCNROBeYACaOkl4nTS6uw/qiohVmL9V9uZH5xuikS3NX
         PEStaXJRZSd/GQq4pxH8f4CRA4aaZEi55S070=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkbtHcgR5KA0zD+x9oTUHYVWwacT9VRypGcZ4wLZpOg=;
        b=jB2kSDyKMKlCZbuQB0aDvZHeAahHrSb+OfKa3jYzGau+2aI7zr8ZPPRTqPo0+d9J/Q
         UHnfo4JuPEK2NzoP7lReo9EIT3J0LTSl9moPxOnklB5eI4HnNHEy9bbLWEcAFqp26ops
         iiFOhD0ZKTSj9H2kh4miQwleGICQo+J72VhN0TP8my/R9xWqT64lDgdpjj62mJX+px+x
         rXVOtxhlW2AQ65juCosLBgbIhujj639D7oDzSmwcSkh6VavxVuqWK0tR8xob9+RGFfhv
         eaAm2ooxDUuFxkfLUtj173VxFGFwpqinrE8UF2z0dSzcxIVP/eTf9SNggWYx1uZWmuMa
         PoCQ==
X-Gm-Message-State: AOAM530TURBb1FrM1BCOVDPnszjqd2ANrr1kQ4/gw1tyH2X/FBjIaC9I
        zgVjQHgKJYdUW5xk+Mu6GK88PA==
X-Google-Smtp-Source: ABdhPJwi2SCEgGhZ9I5onX8/zOrE1DLMbnkSlLcyHUO6ndmNQT89+0bno1W9+WZ49cCJAUst7NqxuA==
X-Received: by 2002:a17:90b:1192:b0:1e2:da25:4095 with SMTP id gk18-20020a17090b119200b001e2da254095mr14274601pjb.240.1655108890190;
        Mon, 13 Jun 2022 01:28:10 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:79ca:e1d9:ad5:dc9e])
        by smtp.gmail.com with ESMTPSA id br8-20020a056a00440800b00518a473265csm4624906pfb.217.2022.06.13.01.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:28:09 -0700 (PDT)
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
Subject: [PATCH v6 1/3] Revert "squashfs: provide backing_dev_info in order to disable read-ahead"
Date:   Mon, 13 Jun 2022 16:28:00 +0800
Message-Id: <20220613082802.1301238-2-hsinyi@chromium.org>
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

