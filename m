Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F12D529C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbiEQI2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243051AbiEQI2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:28:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0E634659
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:27:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x143so172377pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5RbQ3j9RMbZ/D6MAR7ISAUvOQDvpOlhf1s/Zk6REvQs=;
        b=cERWjiKZfw6WI/Su4knl08OFpy0v1f15tlBLnsXgpC5PzSp8bOebBCMkUcd5OCB9UD
         lIxv/+8BEnS2GfuwK7MqUOVhkyw9+22ami2fNlkkuviZhGeIVFudl94jcGgPWlxFoBv4
         HyTm/0jPE9VJ4tQ9d/oDOTxiG0k05DenlMHTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5RbQ3j9RMbZ/D6MAR7ISAUvOQDvpOlhf1s/Zk6REvQs=;
        b=uRqNRAaw+8XMu5nA/f5rX+Tmh725IpHGH4lmF6VUEMEYgB/CPJqZwQziwQlrYjehN3
         Rvm//L+r5v+1SWU7DScN+/iRAP+LnA2KiFanQLhllG3YuyWU2MxxLa62SleX3x2+WcAD
         y8+b5y5Kt5BmBX3jIP8v4e9Pgxl1nVyuG3ShRdoritv17AxSYk7TTwHbG9r3tlPr9ztb
         +qt5TnLZXhiqIN3i/ojn73HugwF1BSjbHSltst9k/N1YCHevIEM5DmXmrHcJqpCURsiU
         0IC7OA16oLMNk+H4ovyBa9wbe6OKQbuLnXCmjHOLwU/ROuDIBGq99BjdZfAS4sy/IUe1
         AuKg==
X-Gm-Message-State: AOAM530ETrvz7dB/6cWbdpsvHAuTfsT2NKi/SCyipAOXYST2KmaqIkHw
        gDYaaHQ9ODCvy77Ep28YvOEHeg==
X-Google-Smtp-Source: ABdhPJz4aF4dMhqEmu0GTfbz8WlmgQ+lpbplL1Gv3txGEhH2G1P5A91yfhnjV8d4iZYVkJ5sRaF/lw==
X-Received: by 2002:a05:6a00:164c:b0:50a:472a:6b0a with SMTP id m12-20020a056a00164c00b0050a472a6b0amr21308254pfc.77.1652776064207;
        Tue, 17 May 2022 01:27:44 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:beb2:ec58:2159:9a33])
        by smtp.gmail.com with ESMTPSA id k9-20020a628409000000b0050dc76281d3sm8615083pfd.173.2022.05.17.01.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 01:27:43 -0700 (PDT)
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
Subject: [PATCH v2 1/3] Revert "squashfs: provide backing_dev_info in order to disable read-ahead"
Date:   Tue, 17 May 2022 16:26:50 +0800
Message-Id: <20220517082650.2005840-2-hsinyi@chromium.org>
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

