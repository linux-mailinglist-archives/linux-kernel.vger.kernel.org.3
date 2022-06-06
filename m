Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7268B53EAC1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiFFPDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbiFFPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:03:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C254C194BFB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:03:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t2so12319496pld.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wfh9GMNAtQ8X7OUdTqnBOAOW/iUKoStIjgn9vMh3x8A=;
        b=LaLT54OgNexxdzg/yLo+8HWrcnL5T3ORpjIOiHtIXU2JyIhOTdsGH+E15HjVrNeXQd
         /tSuP/hsZnGDYXMxqh3LOfmj2UIsf+95G6/X4WIBAAXMU4Oqy0mJzzinjNrg1YiDVsxp
         mJzADlX1yQqXsd9ypgmarYUEXLEkXxxB47+u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfh9GMNAtQ8X7OUdTqnBOAOW/iUKoStIjgn9vMh3x8A=;
        b=8JaKgbkR8EYqUwH2aqxx2AXhqy/w++IE2BYGQAbrLgvvUvkGcnubYdnVxMe1S2nSQz
         BIoxEatbr4d+xNuYOjDfWkJFKr4nEmWVM6+sY/5tTI04zWSlATcWhaJdsabep37p8Slb
         wTD1bCm+dzjci/z8VhQN1LHigItOc43UWRD/X5pJ0VGNJbauRYYepKSvRfTiCE5MQs7L
         U4j77twXrs6PuUY6TlnfXIdhj31co0DvPeIsiqt7LAqC+9+qIKxmjgUCxftVno8+f11M
         3zybblSCEkCPk4/N/0WOS9uqlWhMvpTToTHrwm7AYOl5rxdBJjtg59QAE9nNZQTPhd/h
         ztcg==
X-Gm-Message-State: AOAM530xnQJfL9y97j4d47u4oNZdVaxTjSQ0pORM+p93T8zVpsQJluLT
        Aj5m7QUfgCgODfyCl5u0t9CAepZfPup+lg==
X-Google-Smtp-Source: ABdhPJxdTTxiaTKy/Feszuj1SsDP1FIjhPd7kiMqbWGTUZqv/v0u2v6oRGzVVWwnaSvf/uwM6Y6RRg==
X-Received: by 2002:a17:902:cec8:b0:163:e4c1:b302 with SMTP id d8-20020a170902cec800b00163e4c1b302mr24732302plg.123.1654527794024;
        Mon, 06 Jun 2022 08:03:14 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0a:5e4:e24:c8c4])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7998d000000b0050dc76281ecsm7468864pfh.198.2022.06.06.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:03:13 -0700 (PDT)
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
Subject: [PATCH v5 1/3] Revert "squashfs: provide backing_dev_info in order to disable read-ahead"
Date:   Mon,  6 Jun 2022 23:03:03 +0800
Message-Id: <20220606150305.1883410-2-hsinyi@chromium.org>
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

