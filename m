Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8A5927FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiHODLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiHODLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:11:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A47644D
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:11:04 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M5fPd5l01zmVlL;
        Mon, 15 Aug 2022 11:08:53 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 11:11:02 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>,
        <yi.zhang@huawei.com>, <wangbing6@huawei.com>,
        <zhongjubin@huawei.com>, <chenjianguo3@huawei.com>
Subject: [PATCH 1/2] squashfs: add the mount parameter theads=<single|multi|percpu>
Date:   Mon, 15 Aug 2022 11:10:59 +0800
Message-ID: <20220815031100.75243-2-nixiaoming@huawei.com>
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

Squashfs supports three decompression concurrency modes:
	Single-thread mode: concurrent reads are blocked and the memory overhead
is small.
	Multi-thread mode/percpu mode: reduces concurrent read blocking but
increases memory overhead.

The corresponding schema must be fixed at compile time. During mounting,
the concurrent decompression mode cannot be adjusted based on file read
blocking.

The mount parameter theads=<single|multi|percpu> is added to select
the concurrent decompression mode of a single SquashFS file system
image.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 fs/squashfs/Kconfig                     | 20 ++++++++++--
 fs/squashfs/decompressor_multi.c        | 28 +++++++++-------
 fs/squashfs/decompressor_multi_percpu.c | 37 +++++++++++++--------
 fs/squashfs/decompressor_single.c       | 23 ++++++++-----
 fs/squashfs/squashfs.h                  | 39 +++++++++++++++++++---
 fs/squashfs/squashfs_fs_sb.h            |  3 +-
 fs/squashfs/super.c                     | 58 ++++++++++++++++++++++++++++++++-
 7 files changed, 166 insertions(+), 42 deletions(-)

diff --git a/fs/squashfs/Kconfig b/fs/squashfs/Kconfig
index 916e78fabcaa..af9f8c41f2de 100644
--- a/fs/squashfs/Kconfig
+++ b/fs/squashfs/Kconfig
@@ -55,7 +55,7 @@ config SQUASHFS_FILE_DIRECT
 endchoice
 
 choice
-	prompt "Decompressor parallelisation options"
+	prompt "default Decompressor parallelisation options"
 	depends on SQUASHFS
 	help
 	  Squashfs now supports three parallelisation options for
@@ -64,8 +64,23 @@ choice
 
 	  If in doubt, select "Single threaded compression"
 
+	config SQUASHFS_DECOMP_DEFAULT_SINGLE
+	bool "Single threaded compression"
+	select SQUASHFS_DECOMP_SINGLE
+
+	config SQUASHFS_DECOMP_DEFAULT_MULTI
+	bool "Use multiple decompressors for parallel I/O"
+	select SQUASHFS_DECOMP_MULTI
+
+	config SQUASHFS_DECOMP_DEFAULT_PERCPU
+	bool "Use percpu multiple decompressors for parallel I/O"
+	select SQUASHFS_DECOMP_MULTI_PERCPU
+
+endchoice
+
 config SQUASHFS_DECOMP_SINGLE
 	bool "Single threaded compression"
+	depends on SQUASHFS
 	help
 	  Traditionally Squashfs has used single-threaded decompression.
 	  Only one block (data or metadata) can be decompressed at any
@@ -73,6 +88,7 @@ config SQUASHFS_DECOMP_SINGLE
 
 config SQUASHFS_DECOMP_MULTI
 	bool "Use multiple decompressors for parallel I/O"
+	depends on SQUASHFS
 	help
 	  By default Squashfs uses a single decompressor but it gives
 	  poor performance on parallel I/O workloads when using multiple CPU
@@ -87,6 +103,7 @@ config SQUASHFS_DECOMP_MULTI
 
 config SQUASHFS_DECOMP_MULTI_PERCPU
 	bool "Use percpu multiple decompressors for parallel I/O"
+	depends on SQUASHFS
 	help
 	  By default Squashfs uses a single decompressor but it gives
 	  poor performance on parallel I/O workloads when using multiple CPU
@@ -96,7 +113,6 @@ config SQUASHFS_DECOMP_MULTI_PERCPU
 	  decompressor per core.  It uses percpu variables to ensure
 	  decompression is load-balanced across the cores.
 
-endchoice
 
 config SQUASHFS_XATTR
 	bool "Squashfs XATTR support"
diff --git a/fs/squashfs/decompressor_multi.c b/fs/squashfs/decompressor_multi.c
index db9f12a3ea05..7b2723b77e75 100644
--- a/fs/squashfs/decompressor_multi.c
+++ b/fs/squashfs/decompressor_multi.c
@@ -29,13 +29,12 @@
 #define MAX_DECOMPRESSOR	(num_online_cpus() * 2)
 
 
-int squashfs_max_decompressors(void)
+static int squashfs_max_decompressors_multi(void)
 {
 	return MAX_DECOMPRESSOR;
 }
 
-
-struct squashfs_stream {
+struct squashfs_stream_multi {
 	void			*comp_opts;
 	struct list_head	strm_list;
 	struct mutex		mutex;
@@ -51,7 +50,7 @@ struct decomp_stream {
 
 
 static void put_decomp_stream(struct decomp_stream *decomp_strm,
-				struct squashfs_stream *stream)
+				struct squashfs_stream_multi *stream)
 {
 	mutex_lock(&stream->mutex);
 	list_add(&decomp_strm->list, &stream->strm_list);
@@ -59,10 +58,10 @@ static void put_decomp_stream(struct decomp_stream *decomp_strm,
 	wake_up(&stream->wait);
 }
 
-void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
+static void *squashfs_decompressor_create_multi(struct squashfs_sb_info *msblk,
 				void *comp_opts)
 {
-	struct squashfs_stream *stream;
+	struct squashfs_stream_multi *stream;
 	struct decomp_stream *decomp_strm = NULL;
 	int err = -ENOMEM;
 
@@ -103,9 +102,9 @@ void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 }
 
 
-void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
+static void squashfs_decompressor_destroy_multi(struct squashfs_sb_info *msblk)
 {
-	struct squashfs_stream *stream = msblk->stream;
+	struct squashfs_stream_multi *stream = msblk->stream;
 	if (stream) {
 		struct decomp_stream *decomp_strm;
 
@@ -125,7 +124,7 @@ void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 
 
 static struct decomp_stream *get_decomp_stream(struct squashfs_sb_info *msblk,
-					struct squashfs_stream *stream)
+					struct squashfs_stream_multi *stream)
 {
 	struct decomp_stream *decomp_strm;
 
@@ -180,12 +179,12 @@ static struct decomp_stream *get_decomp_stream(struct squashfs_sb_info *msblk,
 }
 
 
-int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
+static int squashfs_decompress_multi(struct squashfs_sb_info *msblk, struct bio *bio,
 			int offset, int length,
 			struct squashfs_page_actor *output)
 {
 	int res;
-	struct squashfs_stream *stream = msblk->stream;
+	struct squashfs_stream_multi *stream = msblk->stream;
 	struct decomp_stream *decomp_stream = get_decomp_stream(msblk, stream);
 	res = msblk->decompressor->decompress(msblk, decomp_stream->stream,
 		bio, offset, length, output);
@@ -195,3 +194,10 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
 			msblk->decompressor->name);
 	return res;
 }
+
+const struct squashfs_decompressor_thread_ops squashfs_decompressor_multi = {
+	.create = squashfs_decompressor_create_multi,
+	.destroy = squashfs_decompressor_destroy_multi,
+	.decompress = squashfs_decompress_multi,
+	.max_decompressors = squashfs_max_decompressors_multi,
+};
diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
index b881b9283b7f..2d540bb13970 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -20,19 +20,19 @@
  * variables, one thread per cpu core.
  */
 
-struct squashfs_stream {
+struct squashfs_stream_percpu {
 	void			*stream;
 	local_lock_t	lock;
 };
 
-void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
+static void *squashfs_decompressor_create_percpu(struct squashfs_sb_info *msblk,
 						void *comp_opts)
 {
-	struct squashfs_stream *stream;
-	struct squashfs_stream __percpu *percpu;
+	struct squashfs_stream_percpu *stream;
+	struct squashfs_stream_percpu __percpu *percpu;
 	int err, cpu;
 
-	percpu = alloc_percpu(struct squashfs_stream);
+	percpu = alloc_percpu(struct squashfs_stream_percpu);
 	if (percpu == NULL)
 		return ERR_PTR(-ENOMEM);
 
@@ -59,11 +59,11 @@ void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 	return ERR_PTR(err);
 }
 
-void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
+static void squashfs_decompressor_destroy_percpu(struct squashfs_sb_info *msblk)
 {
-	struct squashfs_stream __percpu *percpu =
-			(struct squashfs_stream __percpu *) msblk->stream;
-	struct squashfs_stream *stream;
+	struct squashfs_stream_percpu __percpu *percpu =
+			(struct squashfs_stream_percpu __percpu *) msblk->stream;
+	struct squashfs_stream_percpu *stream;
 	int cpu;
 
 	if (msblk->stream) {
@@ -75,19 +75,21 @@ void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 	}
 }
 
-int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
+static int squashfs_decompress_percpu(struct squashfs_sb_info *msblk, struct bio *bio,
 	int offset, int length, struct squashfs_page_actor *output)
 {
-	struct squashfs_stream *stream;
+	struct squashfs_stream_percpu *stream;
 	int res;
 
-	local_lock(&msblk->stream->lock);
+	preempt_disable();
 	stream = this_cpu_ptr(msblk->stream);
+	local_lock(&stream->lock);
 
 	res = msblk->decompressor->decompress(msblk, stream->stream, bio,
 					      offset, length, output);
 
-	local_unlock(&msblk->stream->lock);
+	local_unlock(&stream->lock);
+	preempt_enable();
 
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
@@ -96,7 +98,14 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
 	return res;
 }
 
-int squashfs_max_decompressors(void)
+static int squashfs_max_decompressors_percpu(void)
 {
 	return num_possible_cpus();
 }
+
+const struct squashfs_decompressor_thread_ops squashfs_decompressor_percpu = {
+	.create = squashfs_decompressor_create_percpu,
+	.destroy = squashfs_decompressor_destroy_percpu,
+	.decompress = squashfs_decompress_percpu,
+	.max_decompressors = squashfs_max_decompressors_percpu,
+};
diff --git a/fs/squashfs/decompressor_single.c b/fs/squashfs/decompressor_single.c
index 4eb3d083d45e..41449de0ea4c 100644
--- a/fs/squashfs/decompressor_single.c
+++ b/fs/squashfs/decompressor_single.c
@@ -19,15 +19,15 @@
  * decompressor framework
  */
 
-struct squashfs_stream {
+struct squashfs_stream_single {
 	void		*stream;
 	struct mutex	mutex;
 };
 
-void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
+static void *squashfs_decompressor_create_single(struct squashfs_sb_info *msblk,
 						void *comp_opts)
 {
-	struct squashfs_stream *stream;
+	struct squashfs_stream_single *stream;
 	int err = -ENOMEM;
 
 	stream = kmalloc(sizeof(*stream), GFP_KERNEL);
@@ -49,9 +49,9 @@ void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 	return ERR_PTR(err);
 }
 
-void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
+static void squashfs_decompressor_destroy_single(struct squashfs_sb_info *msblk)
 {
-	struct squashfs_stream *stream = msblk->stream;
+	struct squashfs_stream_single *stream = msblk->stream;
 
 	if (stream) {
 		msblk->decompressor->free(stream->stream);
@@ -59,12 +59,12 @@ void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 	}
 }
 
-int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
+static int squashfs_decompress_single(struct squashfs_sb_info *msblk, struct bio *bio,
 			int offset, int length,
 			struct squashfs_page_actor *output)
 {
 	int res;
-	struct squashfs_stream *stream = msblk->stream;
+	struct squashfs_stream_single *stream = msblk->stream;
 
 	mutex_lock(&stream->mutex);
 	res = msblk->decompressor->decompress(msblk, stream->stream, bio,
@@ -78,7 +78,14 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
 	return res;
 }
 
-int squashfs_max_decompressors(void)
+static int squashfs_max_decompressors_single(void)
 {
 	return 1;
 }
+
+const struct squashfs_decompressor_thread_ops squashfs_decompressor_single = {
+	.create = squashfs_decompressor_create_single,
+	.destroy = squashfs_decompressor_destroy_single,
+	.decompress = squashfs_decompress_single,
+	.max_decompressors = squashfs_max_decompressors_single,
+};
diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index 9783e01c8100..514cba134f11 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -38,11 +38,40 @@ extern const struct squashfs_decompressor *squashfs_lookup_decompressor(int);
 extern void *squashfs_decompressor_setup(struct super_block *, unsigned short);
 
 /* decompressor_xxx.c */
-extern void *squashfs_decompressor_create(struct squashfs_sb_info *, void *);
-extern void squashfs_decompressor_destroy(struct squashfs_sb_info *);
-extern int squashfs_decompress(struct squashfs_sb_info *, struct bio *,
-				int, int, struct squashfs_page_actor *);
-extern int squashfs_max_decompressors(void);
+
+struct squashfs_decompressor_thread_ops {
+	void * (*create)(struct squashfs_sb_info *msblk, void *comp_opts);
+	void (*destroy)(struct squashfs_sb_info *msblk);
+	int (*decompress)(struct squashfs_sb_info *msblk, struct bio *bio,
+			  int offset, int length, struct squashfs_page_actor *output);
+	int (*max_decompressors)(void);
+};
+
+#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
+extern const struct squashfs_decompressor_thread_ops squashfs_decompressor_single;
+#endif
+#ifdef CONFIG_SQUASHFS_DECOMP_MULTI
+extern const struct squashfs_decompressor_thread_ops squashfs_decompressor_multi;
+#endif
+#ifdef CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
+extern const struct squashfs_decompressor_thread_ops squashfs_decompressor_percpu;
+#endif
+
+static inline void *squashfs_decompressor_create(struct squashfs_sb_info *msblk, void *comp_opts)
+{
+	return msblk->thread_ops->create(msblk, comp_opts);
+}
+
+static inline void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
+{
+	msblk->thread_ops->destroy(msblk);
+}
+
+static inline int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
+				      int offset, int length, struct squashfs_page_actor *output)
+{
+	return msblk->thread_ops->decompress(msblk, bio, offset, length, output);
+}
 
 /* export.c */
 extern __le64 *squashfs_read_inode_lookup_table(struct super_block *, u64, u64,
diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
index 1e90c2575f9b..f1e5dad8ae0a 100644
--- a/fs/squashfs/squashfs_fs_sb.h
+++ b/fs/squashfs/squashfs_fs_sb.h
@@ -53,7 +53,7 @@ struct squashfs_sb_info {
 	__le64					*xattr_id_table;
 	struct mutex				meta_index_mutex;
 	struct meta_index			*meta_index;
-	struct squashfs_stream			*stream;
+	void					*stream;
 	__le64					*inode_lookup_table;
 	u64					inode_table;
 	u64					directory_table;
@@ -66,5 +66,6 @@ struct squashfs_sb_info {
 	int					xattr_ids;
 	unsigned int				ids;
 	bool					panic_on_errors;
+	const struct squashfs_decompressor_thread_ops *thread_ops;
 };
 #endif
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 32565dafa7f3..6fd44683a84b 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -47,10 +47,12 @@ enum Opt_errors {
 
 enum squashfs_param {
 	Opt_errors,
+	Opt_threads,
 };
 
 struct squashfs_mount_opts {
 	enum Opt_errors errors;
+	const struct squashfs_decompressor_thread_ops *thread_ops;
 };
 
 static const struct constant_table squashfs_param_errors[] = {
@@ -61,9 +63,33 @@ static const struct constant_table squashfs_param_errors[] = {
 
 static const struct fs_parameter_spec squashfs_fs_parameters[] = {
 	fsparam_enum("errors", Opt_errors, squashfs_param_errors),
+	fsparam_string("threads", Opt_threads),
 	{}
 };
 
+static int squashfs_parse_param_threads(const char *str, struct squashfs_mount_opts *opts)
+{
+#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
+	if (strcmp(str, "single") == 0) {
+		opts->thread_ops = &squashfs_decompressor_single;
+		return 0;
+	}
+#endif
+#ifdef CONFIG_SQUASHFS_DECOMP_MULTI
+	if (strcmp(str, "multi") == 0) {
+		opts->thread_ops = &squashfs_decompressor_multi;
+		return 0;
+	}
+#endif
+#ifdef CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
+	if (strcmp(str, "percpu") == 0) {
+		opts->thread_ops = &squashfs_decompressor_percpu;
+		return 0;
+	}
+#endif
+	return -EINVAL;
+}
+
 static int squashfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct squashfs_mount_opts *opts = fc->fs_private;
@@ -78,6 +104,10 @@ static int squashfs_parse_param(struct fs_context *fc, struct fs_parameter *para
 	case Opt_errors:
 		opts->errors = result.uint_32;
 		break;
+	case Opt_threads:
+		if (squashfs_parse_param_threads(param->string, opts) != 0)
+			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -167,6 +197,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 			       sb->s_bdev);
 		goto failed_mount;
 	}
+	msblk->thread_ops = opts->thread_ops;
 
 	/* Check the MAJOR & MINOR versions and lookup compression type */
 	msblk->decompressor = supported_squashfs_filesystem(
@@ -252,7 +283,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Allocate read_page block */
 	msblk->read_page = squashfs_cache_init("data",
-		squashfs_max_decompressors(), msblk->block_size);
+		msblk->thread_ops->max_decompressors(), msblk->block_size);
 	if (msblk->read_page == NULL) {
 		errorf(fc, "Failed to allocate read_page block");
 		goto failed_mount;
@@ -435,6 +466,24 @@ static int squashfs_show_options(struct seq_file *s, struct dentry *root)
 	else
 		seq_puts(s, ",errors=continue");
 
+#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
+	if (msblk->thread_ops == &squashfs_decompressor_single) {
+		seq_puts(s, ",threads=single");
+		return 0;
+	}
+#endif
+#ifdef CONFIG_SQUASHFS_DECOMP_MULTI
+	if (msblk->thread_ops == &squashfs_decompressor_multi) {
+		seq_puts(s, ",threads=multi");
+		return 0;
+	}
+#endif
+#ifdef CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
+	if (msblk->thread_ops == &squashfs_decompressor_percpu) {
+		seq_puts(s, ",threads=percpu");
+		return 0;
+	}
+#endif
 	return 0;
 }
 
@@ -446,6 +495,13 @@ static int squashfs_init_fs_context(struct fs_context *fc)
 	if (!opts)
 		return -ENOMEM;
 
+#ifdef CONFIG_SQUASHFS_DECOMP_DEFAULT_SINGLE
+	opts->thread_ops = &squashfs_decompressor_single;
+#elif defined(CONFIG_SQUASHFS_DECOMP_DEFAULT_MULTI)
+	opts->thread_ops = &squashfs_decompressor_multi,
+#elif defined(CONFIG_SQUASHFS_DECOMP_DEFAULT_PERCPU)
+	opts->thread_ops = &squashfs_decompressor_percpu;
+#endif
 	fc->fs_private = opts;
 	fc->ops = &squashfs_context_ops;
 	return 0;
-- 
2.12.3

