Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A1258CF76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244460AbiHHU6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbiHHU62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:58:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756FE18349
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:58:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f5668674cso86362767b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=wDFyY6i2iGLEz8VKfen0AcpNDNUS/ftqH90yGvpjBX4=;
        b=LA8mY4caRn3CQYC0RmBNTUqTCSho6YBEjR11snUjyzm5pz2SSY5Dnb+XGETs6DRx40
         zkYzdSo0GsgETEGQDSeiP39PP+R/vpCsZ9PoxbzKiGZXvzU34LJ98WAA3f7IBCWtUAnJ
         0lD3jgEClnvKuivQ4E1Hf799NBWiEOjPINAfREqgsIWnICrsKUg04Ct9SzC0mCXZOBDJ
         HE22ugUatr3LPBMYoNhr61FsK1javEAU1vOtVivQoBA6e+4O0sfqmQM4DTFr5sK1p8Ju
         M9q94q3DJxiQJUK6wBY9p2oTDmEMJCXrh8DNeV7Y9G934YB+dZzU0Hc64Yxhl9rFRoKp
         hCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=wDFyY6i2iGLEz8VKfen0AcpNDNUS/ftqH90yGvpjBX4=;
        b=Kkyx+mJ4MQCvSInYhXNen4xE3ZKANC6WBBldQHWL8R0q15c2BcHCYuVDmzikqiaR3t
         8gLrve0nPn0Z8Shdb0WS7+YGNQU71os5jIrM8mi2gVkRhEHL6VbzZK8ItkHoVUEnJjXB
         QJ9+vjqA2bYrhLm0ZcJ4aln/QJmqbkITFtMyOJL3iNx9fVlUKSIAWTWmKovDBaiGjIfp
         lFUo9znfO8GzPHPWdeM7MmfklhVTP5WhZItxDW20YgEfydf4Lwkx2w6Jg41YPkjLcuMg
         Gr9X+CSsy4p1xmhfBzsHU1n4nRKpfdW5H6Id75qUiOhAULmTNRR7Ch4SYAT4sE2vWc5G
         OfaA==
X-Gm-Message-State: ACgBeo0FVmlRchT6TTR1d4rg0l+J2lcZ/u+1DgnP3YiDGqrhUDqVHVNt
        IuA65E990Fz+kw1cb+L4/e08Tpmo0A==
X-Google-Smtp-Source: AA6agR4D+Dn4z/3kSEN+SSp9h+j1Qj+vvmpCiuqEdpwbARC0gR3x94+Yvd2RWB42xfoK7D5rWPW1hHDcuA==
X-Received: from khmel2.mtv.corp.google.com ([2620:15c:202:201:7a7b:6028:93de:3db7])
 (user=khmel job=sendgmr) by 2002:a25:a4c3:0:b0:67a:6056:9c7f with SMTP id
 g61-20020a25a4c3000000b0067a60569c7fmr19241626ybi.198.1659992306756; Mon, 08
 Aug 2022 13:58:26 -0700 (PDT)
Date:   Mon,  8 Aug 2022 13:58:22 -0700
Message-Id: <20220808205822.1350030-1-khmel@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH] squashfs: Customize squashfs metadata cache size
From:   Yury Khmel <khmel@google.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-kernel@vger.kernel.org, Yury Khmel <khmel@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It provides customization using module params.
In some use-cases reading metadata may take comparable time reading data
itself. Increasing the cache size in such cases helps to eliminate that
bottleneck and increase the overall performance.

Signed-off-by: Yury Khmel <khmel@google.com>
---
 fs/squashfs/file.c        |  4 ++--
 fs/squashfs/squashfs_fs.h |  2 +-
 fs/squashfs/super.c       | 12 +++++++++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 98e64fec75b7..fc8859741f59 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -207,7 +207,7 @@ static long long read_indexes(struct super_block *sb, int n,
  * to distribute these over the length of the file, entry[0] maps index x,
  * entry[1] maps index x + skip, entry[2] maps index x + 2 * skip, and so on.
  * The larger the file, the greater the skip factor.  The skip factor is
- * limited to the size of the metadata cache (SQUASHFS_CACHED_BLKS) to ensure
+ * limited to the size of the metadata cache (squashfs_cached_blks) to ensure
  * the number of metadata blocks that need to be read fits into the cache.
  * If the skip factor is limited in this way then the file will use multiple
  * slots.
@@ -216,7 +216,7 @@ static inline int calculate_skip(u64 blocks)
 {
 	u64 skip = blocks / ((SQUASHFS_META_ENTRIES + 1)
 		 * SQUASHFS_META_INDEXES);
-	return min((u64) SQUASHFS_CACHED_BLKS - 1, skip + 1);
+	return min((u64) squashfs_cached_blks() - 1, skip + 1);
 }
 
 
diff --git a/fs/squashfs/squashfs_fs.h b/fs/squashfs/squashfs_fs.h
index b3fdc8212c5f..b42aaf51de28 100644
--- a/fs/squashfs/squashfs_fs.h
+++ b/fs/squashfs/squashfs_fs.h
@@ -202,7 +202,7 @@ static inline int squashfs_block_size(__le32 raw)
 #define SQUASHFS_XATTR_OFFSET(A)	((unsigned int) ((A) & 0xffff))
 
 /* cached data constants for filesystem */
-#define SQUASHFS_CACHED_BLKS		8
+unsigned int squashfs_cached_blks(void);
 
 /* meta index cache */
 #define SQUASHFS_META_INDEXES	(SQUASHFS_METADATA_SIZE / sizeof(unsigned int))
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 32565dafa7f3..939a5eb017c2 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -27,6 +27,7 @@
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/magic.h>
 #include <linux/xattr.h>
 
@@ -85,6 +86,15 @@ static int squashfs_parse_param(struct fs_context *fc, struct fs_parameter *para
 	return 0;
 }
 
+static unsigned int cached_blks = 8;
+module_param(cached_blks, uint, 0644);
+MODULE_PARM_DESC(cached_blks, "Metadata squashfs cache size");
+
+unsigned int squashfs_cached_blks(void)
+{
+	return cached_blks;
+}
+
 static const struct squashfs_decompressor *supported_squashfs_filesystem(
 	struct fs_context *fc,
 	short major, short minor, short id)
@@ -246,7 +256,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	err = -ENOMEM;
 
 	msblk->block_cache = squashfs_cache_init("metadata",
-			SQUASHFS_CACHED_BLKS, SQUASHFS_METADATA_SIZE);
+			squashfs_cached_blks(), SQUASHFS_METADATA_SIZE);
 	if (msblk->block_cache == NULL)
 		goto failed_mount;
 
-- 
2.37.1.559.g78731f0fdb-goog

