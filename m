Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE77469917
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbhLFOja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242092AbhLFOj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:39:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37113C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 06:36:01 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so10959282pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 06:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YBSobSiT3nkdJ4idcuxqZnR6uE8EhyHtyTzHAMWypJ4=;
        b=YUpXQhS9h80OLUkTpinObfHNbUVOxrp/gX8032EJMmkWxepMNXtESfhq7pWjcGcpoM
         eCvMHHaKCx8vTd0l+fF9XX13fY4auLHKpgsuQ/v2N2abhg5lG0AIx2gqGvbxzPRHHS89
         77cTiJzSnh510AjJ49A0sjizu0irs8FDYqa6VqB0OmmXyg00K1x9wuLQsxTqeuSQn4/N
         bFIxP6ShxnViwnvOpnZI2Yrhl4JyILJEtYC8Abf7tX9wBrKeqYk560BiikMEb5jncPIt
         T4qVELOsLPZybBRbOJtKhgvxkDL84Pk2thynvRrsxc47kzYEKhIWAiYeZlzf/M8BKtg7
         M49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YBSobSiT3nkdJ4idcuxqZnR6uE8EhyHtyTzHAMWypJ4=;
        b=vOhnp/9jutqT01XFTE3Y1zMi7eDwl6CSxkjvj5+aJIgPQzNK90G1cswVHI5uZrn9Ym
         BfAu6eyvCKB3J3vgvvGgKOLB3DCYzME8pRpEhMeFnko4k/vCpOd+2rF1aR1As1gvtzCj
         PVSsVhw5qjDf/WIJKTh5fpqKSIV2QMm3NyHganKfdumNNF4PmkMGUBVLLZCNxL0Hne9O
         bE+eAx1CurWLchfaqvdpK6c6Hzi7xPKs7+jrv/s4qckVOSiVRlQN4nlc4NLbmh2gabVD
         p20vUlVDpo8N28BGlDdLaTAQm/9gb2q4ew1NV8JUCdI8m0751V0ESQ1Tx3dzt7pbHLcc
         iLiA==
X-Gm-Message-State: AOAM531Eu/09Re9yH1Z+u+qV3jkdUumP3bpUyvdQFT0mz0mnv78gBg6U
        wtV/TYrAUaGJp4fN/9RTki0=
X-Google-Smtp-Source: ABdhPJzr+NkVGhYGf85kWBNdrRsEqHDR5fVdtGhRGlgCHeyfRDFOYbkWQvdx2bHLfe8Y0WoLhyqJOw==
X-Received: by 2002:a17:90b:388f:: with SMTP id mu15mr37417540pjb.30.1638801360639;
        Mon, 06 Dec 2021 06:36:00 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com. [45.33.61.207])
        by smtp.gmail.com with ESMTPSA id c3sm13458458pfv.67.2021.12.06.06.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 06:36:00 -0800 (PST)
From:   Huang Jianan <jnhuang95@gmail.com>
X-Google-Original-From: Huang Jianan <huangjianan@oppo.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org
Cc:     chao@kernel.org, linux-kernel@vger.kernel.org, guoweichao@oppo.com,
        guanyuwei@oppo.com, yh@oppo.com, zhangshiming@oppo.com,
        Huang Jianan <huangjianan@oppo.com>
Subject: [PATCH v7 3/3] erofs: add sysfs node to control sync decompression strategy
Date:   Mon,  6 Dec 2021 22:35:52 +0800
Message-Id: <20211206143552.8384-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Ya37jpMvLXVMSncO@B-P7TQMD6M-0146.local>
References: <Ya37jpMvLXVMSncO@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although readpage is a synchronous path, there will be no additional
kworker scheduling overhead in non-atomic contexts together with
dm-verity.

Let's add a sysfs node to disable sync decompression as an option.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
since v6:
- Clean up code.

since v4:
- Resend in a clean chain.

since v3:
- Clean up the sync decompressstrategy into a separate function.

since v2:
- Use enum to indicate sync decompression strategy.
- Add missing CONFIG_EROFS_FS_ZIP ifdef.

since v1:
- Leave auto default.
- Add a disable strategy for sync_decompress.

 Documentation/ABI/testing/sysfs-fs-erofs |  9 ++++++++
 fs/erofs/internal.h                      | 10 +++++++--
 fs/erofs/super.c                         |  2 +-
 fs/erofs/sysfs.c                         | 15 ++++++++++++++
 fs/erofs/zdata.c                         | 26 ++++++++++++++++++++----
 5 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index a9512594dc4c..05482374a741 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -5,3 +5,12 @@ Description:	Shows all enabled kernel features.
 		Supported features:
 		zero_padding, compr_cfgs, big_pcluster, chunked_file,
 		device_table, compr_head2, sb_chksum.
+
+What:		/sys/fs/erofs/<disk>/sync_decompress
+Date:		November 2021
+Contact:	"Huang Jianan" <huangjianan@oppo.com>
+Description:	Control strategy of sync decompression
+		- 0 (default, auto): enable for readpage, and enable for
+				     readahead on atomic contexts only,
+		- 1 (force on): enable for readpage and readahead.
+		- 2 (force off): disable for all situations.
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 43f0332fa489..8e70435629e5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -56,12 +56,18 @@ struct erofs_device_info {
 	u32 mapped_blkaddr;
 };
 
+enum {
+	EROFS_SYNC_DECOMPRESS_AUTO,
+	EROFS_SYNC_DECOMPRESS_FORCE_ON,
+	EROFS_SYNC_DECOMPRESS_FORCE_OFF
+};
+
 struct erofs_mount_opts {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
-	/* strategy of sync decompression (false - auto, true - force on) */
-	bool readahead_sync_decompress;
+	/* strategy of sync decompression (0 - auto, 1 - force on, 2 - force off) */
+	unsigned int sync_decompress;
 
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index abc1da5d1719..58f381f80205 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -423,7 +423,7 @@ static void erofs_default_options(struct erofs_fs_context *ctx)
 #ifdef CONFIG_EROFS_FS_ZIP
 	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
 	ctx->opt.max_sync_decompress_pages = 3;
-	ctx->opt.readahead_sync_decompress = false;
+	ctx->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
 	set_opt(&ctx->opt, XATTR_USER);
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index ca18c5dce493..5d999015eead 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -16,6 +16,7 @@ enum {
 
 enum {
 	struct_erofs_sb_info,
+	struct_erofs_mount_opts,
 };
 
 struct erofs_attr {
@@ -55,7 +56,14 @@ static struct erofs_attr erofs_attr_##_name = {			\
 
 #define ATTR_LIST(name) (&erofs_attr_##name.attr)
 
+#ifdef CONFIG_EROFS_FS_ZIP
+EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
+#endif
+
 static struct attribute *erofs_attrs[] = {
+#ifdef CONFIG_EROFS_FS_ZIP
+	ATTR_LIST(sync_decompress),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs);
@@ -86,6 +94,8 @@ static unsigned char *__struct_ptr(struct erofs_sb_info *sbi,
 {
 	if (struct_type == struct_erofs_sb_info)
 		return (unsigned char *)sbi + offset;
+	if (struct_type == struct_erofs_mount_opts)
+		return (unsigned char *)&sbi->opt + offset;
 	return NULL;
 }
 
@@ -132,6 +142,11 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 			return ret;
 		if (t > UINT_MAX)
 			return -EINVAL;
+#ifdef CONFIG_EROFS_FS_ZIP
+		if (!strcmp(a->attr.name, "sync_decompress") &&
+		    (t > EROFS_SYNC_DECOMPRESS_FORCE_OFF))
+			return -EINVAL;
+#endif
 		*(unsigned int *)ptr = t;
 		return len;
 	case attr_pointer_bool:
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 9a249bfc2770..bc765d8a6dc2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -762,6 +762,21 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	goto out;
 }
 
+static bool z_erofs_get_sync_decompress_policy(struct erofs_sb_info *sbi,
+				       unsigned int readahead_pages)
+{
+	/* auto: enable for readpage, disable for readahead */
+	if ((sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO) &&
+	    !readahead_pages)
+		return true;
+
+	if ((sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_FORCE_ON) &&
+	    (readahead_pages <= sbi->opt.max_sync_decompress_pages))
+		return true;
+
+	return false;
+}
+
 static void z_erofs_decompressqueue_work(struct work_struct *work);
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       bool sync, int bios)
@@ -784,7 +799,9 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 	/* Use workqueue and sync decompression for atomic contexts only */
 	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
-		sbi->opt.readahead_sync_decompress = true;
+		/* enable sync decompression for readahead */
+		if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
+			sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
 		return;
 	}
 	z_erofs_decompressqueue_work(&io->u.work);
@@ -1435,6 +1452,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 static int z_erofs_readpage(struct file *file, struct page *page)
 {
 	struct inode *const inode = page->mapping->host;
+	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *pagepool = NULL;
 	int err;
@@ -1450,7 +1468,8 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(inode->i_sb, &f, &pagepool, true);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
+			 z_erofs_get_sync_decompress_policy(sbi, 0));
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1501,8 +1520,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_collector_end(&f.clt);
 
 	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
-			 sbi->opt.readahead_sync_decompress &&
-			 nr_pages <= sbi->opt.max_sync_decompress_pages);
+			 z_erofs_get_sync_decompress_policy(sbi, nr_pages));
 	if (f.map.mpage)
 		put_page(f.map.mpage);
 	erofs_release_pages(&pagepool);
-- 
2.25.1

