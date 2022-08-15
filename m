Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097A35927FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiHODLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiHODLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:11:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF6C6468
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:11:04 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M5fPf00lyzmVlM;
        Mon, 15 Aug 2022 11:08:53 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 11:11:03 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>,
        <yi.zhang@huawei.com>, <wangbing6@huawei.com>,
        <zhongjubin@huawei.com>, <chenjianguo3@huawei.com>
Subject: [PATCH 2/2] squashfs: Allows users to configure the number of decompression threads.
Date:   Mon, 15 Aug 2022 11:11:00 +0800
Message-ID: <20220815031100.75243-3-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220815031100.75243-1-nixiaoming@huawei.com>
References: <20220815031100.75243-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum number of threads in the decompressor_multi.c file is fixed
and cannot be adjusted according to user needs.
Therefore, the mount parameter needs to be added to allow users to
configure the number of threads as required.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 fs/squashfs/Kconfig              |  4 +++-
 fs/squashfs/decompressor_multi.c |  4 ++--
 fs/squashfs/squashfs_fs_sb.h     |  1 +
 fs/squashfs/super.c              | 45 ++++++++++++++++++++++++++++------------
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/fs/squashfs/Kconfig b/fs/squashfs/Kconfig
index af9f8c41f2de..3f42b4099dc7 100644
--- a/fs/squashfs/Kconfig
+++ b/fs/squashfs/Kconfig
@@ -99,7 +99,9 @@ config SQUASHFS_DECOMP_MULTI
 
 	  This decompressor implementation uses up to two parallel
 	  decompressors per core.  It dynamically allocates decompressors
-	  on a demand basis.
+	  on a demand basis.  You can also set the number of threads by setting threads=<number> of
+	  the mount parameter.
+
 
 config SQUASHFS_DECOMP_MULTI_PERCPU
 	bool "Use percpu multiple decompressors for parallel I/O"
diff --git a/fs/squashfs/decompressor_multi.c b/fs/squashfs/decompressor_multi.c
index 7b2723b77e75..6d1cea325cca 100644
--- a/fs/squashfs/decompressor_multi.c
+++ b/fs/squashfs/decompressor_multi.c
@@ -144,7 +144,7 @@ static struct decomp_stream *get_decomp_stream(struct squashfs_sb_info *msblk,
 		 * If there is no available decomp and already full,
 		 * let's wait for releasing decomp from other users.
 		 */
-		if (stream->avail_decomp >= MAX_DECOMPRESSOR)
+		if (stream->avail_decomp >= msblk->max_thread_num)
 			goto wait;
 
 		/* Let's allocate new decomp */
@@ -160,7 +160,7 @@ static struct decomp_stream *get_decomp_stream(struct squashfs_sb_info *msblk,
 		}
 
 		stream->avail_decomp++;
-		WARN_ON(stream->avail_decomp > MAX_DECOMPRESSOR);
+		WARN_ON(stream->avail_decomp > msblk->max_thread_num);
 
 		mutex_unlock(&stream->mutex);
 		break;
diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
index f1e5dad8ae0a..659082e9e51d 100644
--- a/fs/squashfs/squashfs_fs_sb.h
+++ b/fs/squashfs/squashfs_fs_sb.h
@@ -67,5 +67,6 @@ struct squashfs_sb_info {
 	unsigned int				ids;
 	bool					panic_on_errors;
 	const struct squashfs_decompressor_thread_ops *thread_ops;
+	int					max_thread_num;
 };
 #endif
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 6fd44683a84b..f3533e20d0b7 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -53,6 +53,7 @@ enum squashfs_param {
 struct squashfs_mount_opts {
 	enum Opt_errors errors;
 	const struct squashfs_decompressor_thread_ops *thread_ops;
+	int thread_num;
 };
 
 static const struct constant_table squashfs_param_errors[] = {
@@ -69,6 +70,8 @@ static const struct fs_parameter_spec squashfs_fs_parameters[] = {
 
 static int squashfs_parse_param_threads(const char *str, struct squashfs_mount_opts *opts)
 {
+	unsigned long num;
+	int ret;
 #ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
 	if (strcmp(str, "single") == 0) {
 		opts->thread_ops = &squashfs_decompressor_single;
@@ -87,7 +90,24 @@ static int squashfs_parse_param_threads(const char *str, struct squashfs_mount_o
 		return 0;
 	}
 #endif
+	ret = kstrtoul(str, 0, &num);
+	if (ret != 0 || num == 0)
+		return -EINVAL;
+#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
+	if (num == 1) {
+		opts->thread_ops = &squashfs_decompressor_single;
+		return 0;
+	}
+#endif
+#ifdef CONFIG_SQUASHFS_DECOMP_MULTI
+	opts->thread_ops = &squashfs_decompressor_multi;
+	if (num > opts->thread_ops->max_decompressors())
+		num = opts->thread_ops->max_decompressors();
+	opts->thread_num = (int)num;
+	return 0;
+#else
 	return -EINVAL;
+#endif
 }
 
 static int squashfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
@@ -198,6 +218,11 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto failed_mount;
 	}
 	msblk->thread_ops = opts->thread_ops;
+	if (opts->thread_num == 0) {
+		msblk->max_thread_num = opts->thread_ops->max_decompressors();
+	} else {
+		msblk->max_thread_num = opts->thread_num;
+	}
 
 	/* Check the MAJOR & MINOR versions and lookup compression type */
 	msblk->decompressor = supported_squashfs_filesystem(
@@ -283,7 +308,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Allocate read_page block */
 	msblk->read_page = squashfs_cache_init("data",
-		msblk->thread_ops->max_decompressors(), msblk->block_size);
+		msblk->max_thread_num, msblk->block_size);
 	if (msblk->read_page == NULL) {
 		errorf(fc, "Failed to allocate read_page block");
 		goto failed_mount;
@@ -466,24 +491,17 @@ static int squashfs_show_options(struct seq_file *s, struct dentry *root)
 	else
 		seq_puts(s, ",errors=continue");
 
-#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
-	if (msblk->thread_ops == &squashfs_decompressor_single) {
-		seq_puts(s, ",threads=single");
-		return 0;
-	}
-#endif
-#ifdef CONFIG_SQUASHFS_DECOMP_MULTI
-	if (msblk->thread_ops == &squashfs_decompressor_multi) {
-		seq_puts(s, ",threads=multi");
-		return 0;
-	}
-#endif
 #ifdef CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
+	/*
+	 * thread=percpu and thread=<number> have different configuration effects.
+	 * the parameters need to be treated differently when they are displayed.
+	 */
 	if (msblk->thread_ops == &squashfs_decompressor_percpu) {
 		seq_puts(s, ",threads=percpu");
 		return 0;
 	}
 #endif
+	seq_printf(s, ",threads=%u", msblk->max_thread_num);
 	return 0;
 }
 
@@ -502,6 +520,7 @@ static int squashfs_init_fs_context(struct fs_context *fc)
 #elif defined(CONFIG_SQUASHFS_DECOMP_DEFAULT_PERCPU)
 	opts->thread_ops = &squashfs_decompressor_percpu;
 #endif
+	opts->thread_num = 0;
 	fc->fs_private = opts;
 	fc->ops = &squashfs_context_ops;
 	return 0;
-- 
2.12.3

