Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53B856390D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiGASUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiGASUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:20:49 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75D419289
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:20:47 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id b24-20020a17090ae39800b001ecd48d4b29so3342896pjz.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6GC54vilG3PBiwkGwTl+yOvPSzuRxrdUCosq45LM1d0=;
        b=Utb842fVOIocfPQ75gRHeFe+90E5/O4EmhyODr5tmUH9vIrPDj66r3A3hGUhPtYdh8
         GgLUcdqD0UEljas/RF3UgIabOwrj4rbJJzmZy7T0ARlnra+o7c2xIJ670Vjgl+gt1Flr
         VKDHVG8HMKUbEbtB/s6BA1jA/3wSddgBNujEtdJ13V6qOZOoGt5WTBsJNa/sgZPzChvL
         BwLaKhKGowBFT8DaR1FfkrFwKz0IaMCg0d3TvUtbJNhIx8MbXmqUG4wjDDq4e3C4jzK6
         1fXWKkUH4WL1J/n+hCyYXLIh10w1u4ENd5Q+9o1oOM6/MvtN9aaTkS40/SCEDJsEO2Dq
         U2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6GC54vilG3PBiwkGwTl+yOvPSzuRxrdUCosq45LM1d0=;
        b=i3eSJzUlY4ASup7WXha81e3eCYHZtlicU1vERXhEWsnbl3X+CZYTn2duI05sxYEB6o
         bZH45R4G0TVctTNp2QjMFnJ+LBj4ZiYbWWJhbqivslyN0puvDXVEklnzIC0g1gdmakQF
         1/rsh8+mPcYXaGMIUsD7F17K67MISQ14Mk21BQ1V44CuteWKfQLvZeGsM+3FTz+a0AuB
         E4OculwE4jFXR3Fp2hetE/5y4R/BZihK8zQy5Bc4hh595GIf0foPL5vt8vjuc204Qk6g
         5qhuq9FTjUG/zDWiF4eATEezCwIPJc1zg6W8lE3WLu2FEHYz/mpZS28L0MQP6ytrWodC
         VPGQ==
X-Gm-Message-State: AJIora8R5+yw8/1vUgy0tOkSnJN764VY6NUBWnYKERvvAL9XyC25xMNA
        WJNj8Wk78vKGM9UBMgtMwdkM/ZQmA4C8ZQ==
X-Google-Smtp-Source: AGRyM1v4XmmuewbBk5mnRHqUwYvMAKIfChNpg+NisV3VoyvvpIgtS2JkxmAjE9DvaBSrXDX0Chs1kYd9cGm98Q==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:d2:b0:525:a508:d798 with SMTP id
 e18-20020a056a0000d200b00525a508d798mr21918546pfj.10.1656699647347; Fri, 01
 Jul 2022 11:20:47 -0700 (PDT)
Date:   Fri,  1 Jul 2022 18:20:41 +0000
Message-Id: <20220701182041.2134313-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] binder: fix redefinition of seq_file attributes
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Carlos Llamas <cmllamas@google.com>,
        kernel test robot <lkp@intel.com>
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

The patchset in [1] exported some definitions to binder_internal.h in
order to make the debugfs entries such as 'stats' and 'transaction_log'
available in a binderfs instance. However, the DEFINE_SHOW_ATTRIBUTE
macro expands into a static function/variable pair, which in turn get
redefined each time a source file includes this internal header.

This problem was made evident after a report from the kernel test robot
<lkp@intel.com> where several W=1 build warnings are seen in downstream
kernels. See the following example:

  include/../drivers/android/binder_internal.h:111:23: warning: 'binder_stats_fops' defined but not used [-Wunused-const-variable=]
     111 | DEFINE_SHOW_ATTRIBUTE(binder_stats);
         |                       ^~~~~~~~~~~~
  include/linux/seq_file.h:174:37: note: in definition of macro 'DEFINE_SHOW_ATTRIBUTE'
     174 | static const struct file_operations __name ## _fops = {                 \
         |                                     ^~~~~~

This patch fixes the above issues by moving back the definitions into
binder.c and instead creates an array of the debugfs entries which is
more convenient to share with binderfs and iterate through.

  [1] https://lore.kernel.org/all/20190903161655.107408-1-hridya@google.com/

Fixes: 0e13e452dafc ("binder: Add stats, state and transactions files")
Fixes: 03e2e07e3814 ("binder: Make transaction_log available in binderfs")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c          | 114 +++++++++++++++++++++---------
 drivers/android/binder_internal.h |  46 +++---------
 drivers/android/binderfs.c        |  47 +++---------
 3 files changed, 100 insertions(+), 107 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 362c0deb65f1..54ac94fed015 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -197,8 +197,32 @@ static inline void binder_stats_created(enum binder_stat_types type)
 	atomic_inc(&binder_stats.obj_created[type]);
 }
 
-struct binder_transaction_log binder_transaction_log;
-struct binder_transaction_log binder_transaction_log_failed;
+struct binder_transaction_log_entry {
+	int debug_id;
+	int debug_id_done;
+	int call_type;
+	int from_proc;
+	int from_thread;
+	int target_handle;
+	int to_proc;
+	int to_thread;
+	int to_node;
+	int data_size;
+	int offsets_size;
+	int return_error_line;
+	uint32_t return_error;
+	uint32_t return_error_param;
+	char context_name[BINDERFS_MAX_NAME + 1];
+};
+
+struct binder_transaction_log {
+	atomic_t cur;
+	bool full;
+	struct binder_transaction_log_entry entry[32];
+};
+
+static struct binder_transaction_log binder_transaction_log;
+static struct binder_transaction_log binder_transaction_log_failed;
 
 static struct binder_transaction_log_entry *binder_transaction_log_add(
 	struct binder_transaction_log *log)
@@ -6197,8 +6221,7 @@ static void print_binder_proc_stats(struct seq_file *m,
 	print_binder_stats(m, "  ", &proc->stats);
 }
 
-
-int binder_state_show(struct seq_file *m, void *unused)
+static int state_show(struct seq_file *m, void *unused)
 {
 	struct binder_proc *proc;
 	struct binder_node *node;
@@ -6237,7 +6260,7 @@ int binder_state_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
-int binder_stats_show(struct seq_file *m, void *unused)
+static int stats_show(struct seq_file *m, void *unused)
 {
 	struct binder_proc *proc;
 
@@ -6253,7 +6276,7 @@ int binder_stats_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
-int binder_transactions_show(struct seq_file *m, void *unused)
+static int transactions_show(struct seq_file *m, void *unused)
 {
 	struct binder_proc *proc;
 
@@ -6309,7 +6332,7 @@ static void print_binder_transaction_log_entry(struct seq_file *m,
 			"\n" : " (incomplete)\n");
 }
 
-int binder_transaction_log_show(struct seq_file *m, void *unused)
+static int transaction_log_show(struct seq_file *m, void *unused)
 {
 	struct binder_transaction_log *log = m->private;
 	unsigned int log_cur = atomic_read(&log->cur);
@@ -6341,6 +6364,45 @@ const struct file_operations binder_fops = {
 	.release = binder_release,
 };
 
+DEFINE_SHOW_ATTRIBUTE(state);
+DEFINE_SHOW_ATTRIBUTE(stats);
+DEFINE_SHOW_ATTRIBUTE(transactions);
+DEFINE_SHOW_ATTRIBUTE(transaction_log);
+
+const struct binder_debugfs_entry binder_debugfs_entries[] = {
+	{
+		.name = "state",
+		.mode = 0444,
+		.fops = &state_fops,
+		.data = NULL,
+	},
+	{
+		.name = "stats",
+		.mode = 0444,
+		.fops = &stats_fops,
+		.data = NULL,
+	},
+	{
+		.name = "transactions",
+		.mode = 0444,
+		.fops = &transactions_fops,
+		.data = NULL,
+	},
+	{
+		.name = "transaction_log",
+		.mode = 0444,
+		.fops = &transaction_log_fops,
+		.data = &binder_transaction_log,
+	},
+	{
+		.name = "failed_transaction_log",
+		.mode = 0444,
+		.fops = &transaction_log_fops,
+		.data = &binder_transaction_log_failed,
+	},
+	{} /* terminator */
+};
+
 static int __init init_binder_device(const char *name)
 {
 	int ret;
@@ -6386,36 +6448,18 @@ static int __init binder_init(void)
 	atomic_set(&binder_transaction_log_failed.cur, ~0U);
 
 	binder_debugfs_dir_entry_root = debugfs_create_dir("binder", NULL);
-	if (binder_debugfs_dir_entry_root)
+	if (binder_debugfs_dir_entry_root) {
+		const struct binder_debugfs_entry *db_entry;
+
+		binder_for_each_debugfs_entry(db_entry)
+			debugfs_create_file(db_entry->name,
+					    db_entry->mode,
+					    binder_debugfs_dir_entry_root,
+					    db_entry->data,
+					    db_entry->fops);
+
 		binder_debugfs_dir_entry_proc = debugfs_create_dir("proc",
 						 binder_debugfs_dir_entry_root);
-
-	if (binder_debugfs_dir_entry_root) {
-		debugfs_create_file("state",
-				    0444,
-				    binder_debugfs_dir_entry_root,
-				    NULL,
-				    &binder_state_fops);
-		debugfs_create_file("stats",
-				    0444,
-				    binder_debugfs_dir_entry_root,
-				    NULL,
-				    &binder_stats_fops);
-		debugfs_create_file("transactions",
-				    0444,
-				    binder_debugfs_dir_entry_root,
-				    NULL,
-				    &binder_transactions_fops);
-		debugfs_create_file("transaction_log",
-				    0444,
-				    binder_debugfs_dir_entry_root,
-				    &binder_transaction_log,
-				    &binder_transaction_log_fops);
-		debugfs_create_file("failed_transaction_log",
-				    0444,
-				    binder_debugfs_dir_entry_root,
-				    &binder_transaction_log_failed,
-				    &binder_transaction_log_fops);
 	}
 
 	if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 8dc0bccf8513..abe19d88c6ec 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -107,41 +107,19 @@ static inline int __init init_binderfs(void)
 }
 #endif
 
-int binder_stats_show(struct seq_file *m, void *unused);
-DEFINE_SHOW_ATTRIBUTE(binder_stats);
-
-int binder_state_show(struct seq_file *m, void *unused);
-DEFINE_SHOW_ATTRIBUTE(binder_state);
-
-int binder_transactions_show(struct seq_file *m, void *unused);
-DEFINE_SHOW_ATTRIBUTE(binder_transactions);
-
-int binder_transaction_log_show(struct seq_file *m, void *unused);
-DEFINE_SHOW_ATTRIBUTE(binder_transaction_log);
-
-struct binder_transaction_log_entry {
-	int debug_id;
-	int debug_id_done;
-	int call_type;
-	int from_proc;
-	int from_thread;
-	int target_handle;
-	int to_proc;
-	int to_thread;
-	int to_node;
-	int data_size;
-	int offsets_size;
-	int return_error_line;
-	uint32_t return_error;
-	uint32_t return_error_param;
-	char context_name[BINDERFS_MAX_NAME + 1];
+struct binder_debugfs_entry {
+	const char *name;
+	umode_t mode;
+	const struct file_operations *fops;
+	void *data;
 };
 
-struct binder_transaction_log {
-	atomic_t cur;
-	bool full;
-	struct binder_transaction_log_entry entry[32];
-};
+extern const struct binder_debugfs_entry binder_debugfs_entries[];
+
+#define binder_for_each_debugfs_entry(entry)	\
+	for ((entry) = binder_debugfs_entries;	\
+	     (entry)->name;			\
+	     (entry)++)
 
 enum binder_stat_types {
 	BINDER_STAT_PROC,
@@ -580,6 +558,4 @@ struct binder_object {
 	};
 };
 
-extern struct binder_transaction_log binder_transaction_log;
-extern struct binder_transaction_log binder_transaction_log_failed;
 #endif /* _LINUX_BINDER_INTERNAL_H */
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 6c5e94f6cb3a..588d753a7a19 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -629,6 +629,7 @@ static int init_binder_features(struct super_block *sb)
 static int init_binder_logs(struct super_block *sb)
 {
 	struct dentry *binder_logs_root_dir, *dentry, *proc_log_dir;
+	const struct binder_debugfs_entry *db_entry;
 	struct binderfs_info *info;
 	int ret = 0;
 
@@ -639,43 +640,15 @@ static int init_binder_logs(struct super_block *sb)
 		goto out;
 	}
 
-	dentry = binderfs_create_file(binder_logs_root_dir, "stats",
-				      &binder_stats_fops, NULL);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto out;
-	}
-
-	dentry = binderfs_create_file(binder_logs_root_dir, "state",
-				      &binder_state_fops, NULL);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto out;
-	}
-
-	dentry = binderfs_create_file(binder_logs_root_dir, "transactions",
-				      &binder_transactions_fops, NULL);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto out;
-	}
-
-	dentry = binderfs_create_file(binder_logs_root_dir,
-				      "transaction_log",
-				      &binder_transaction_log_fops,
-				      &binder_transaction_log);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto out;
-	}
-
-	dentry = binderfs_create_file(binder_logs_root_dir,
-				      "failed_transaction_log",
-				      &binder_transaction_log_fops,
-				      &binder_transaction_log_failed);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto out;
+	binder_for_each_debugfs_entry(db_entry) {
+		dentry = binderfs_create_file(binder_logs_root_dir,
+					      db_entry->name,
+					      db_entry->fops,
+					      db_entry->data);
+		if (IS_ERR(dentry)) {
+			ret = PTR_ERR(dentry);
+			goto out;
+		}
 	}
 
 	proc_log_dir = binderfs_create_dir(binder_logs_root_dir, "proc");
-- 
2.37.0.rc0.161.g10f37bed90-goog

