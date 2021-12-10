Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E6F47094B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbhLJSvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:51:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51202 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhLJSvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:51:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18229B8294B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296C3C00446;
        Fri, 10 Dec 2021 18:48:03 +0000 (UTC)
Date:   Fri, 10 Dec 2021 13:48:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>, Miaoqian Lin <linmq006@gmail.com>
Subject: [GIT PULL] tracing/tracefs: Updates for 5.16-rc5
Message-ID: <20211210134801.56e26614@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

tracing, ftrace and tracefs fixes:

 - Have tracefs honor the gid mount option

 - Have new files in tracefs inherit the parent ownership

 - Have direct_ops unregister when it has no more functions

 - Properly clean up the ops when unregistering multi direct ops

 - Add a sample module to test the multiple direct ops

 - Fix memory leak in error path of __create_synth_event()


Please pull the latest trace-v5.16-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.16-rc4

Tag SHA1: 36a0fd9345e7d94df3f661972dc2cdfec1994960
Head SHA1: c24be24aed405d64ebcf04526614c13b2adfb1d2


Jiri Olsa (3):
      ftrace: Use direct_ops hash in unregister_ftrace_direct
      ftrace: Add cleanup to unregister_ftrace_direct_multi
      ftrace/samples: Add module to test multi direct modify interface

Miaoqian Lin (1):
      tracing: Fix possible memory leak in __create_synth_event() error path

Steven Rostedt (VMware) (2):
      tracefs: Have new files inherit the ownership of their parent
      tracefs: Set all files to the same group ownership as the mount option

----
 fs/tracefs/inode.c                          |  76 ++++++++++++++
 kernel/trace/ftrace.c                       |   8 +-
 kernel/trace/trace_events_synth.c           |  11 +-
 samples/ftrace/Makefile                     |   1 +
 samples/ftrace/ftrace-direct-multi-modify.c | 152 ++++++++++++++++++++++++++++
 5 files changed, 242 insertions(+), 6 deletions(-)
 create mode 100644 samples/ftrace/ftrace-direct-multi-modify.c
---------------------------
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 925a621b432e..3616839c5c4b 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -161,6 +161,77 @@ struct tracefs_fs_info {
 	struct tracefs_mount_opts mount_opts;
 };
 
+static void change_gid(struct dentry *dentry, kgid_t gid)
+{
+	if (!dentry->d_inode)
+		return;
+	dentry->d_inode->i_gid = gid;
+}
+
+/*
+ * Taken from d_walk, but without he need for handling renames.
+ * Nothing can be renamed while walking the list, as tracefs
+ * does not support renames. This is only called when mounting
+ * or remounting the file system, to set all the files to
+ * the given gid.
+ */
+static void set_gid(struct dentry *parent, kgid_t gid)
+{
+	struct dentry *this_parent;
+	struct list_head *next;
+
+	this_parent = parent;
+	spin_lock(&this_parent->d_lock);
+
+	change_gid(this_parent, gid);
+repeat:
+	next = this_parent->d_subdirs.next;
+resume:
+	while (next != &this_parent->d_subdirs) {
+		struct list_head *tmp = next;
+		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
+		next = tmp->next;
+
+		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
+
+		change_gid(dentry, gid);
+
+		if (!list_empty(&dentry->d_subdirs)) {
+			spin_unlock(&this_parent->d_lock);
+			spin_release(&dentry->d_lock.dep_map, _RET_IP_);
+			this_parent = dentry;
+			spin_acquire(&this_parent->d_lock.dep_map, 0, 1, _RET_IP_);
+			goto repeat;
+		}
+		spin_unlock(&dentry->d_lock);
+	}
+	/*
+	 * All done at this level ... ascend and resume the search.
+	 */
+	rcu_read_lock();
+ascend:
+	if (this_parent != parent) {
+		struct dentry *child = this_parent;
+		this_parent = child->d_parent;
+
+		spin_unlock(&child->d_lock);
+		spin_lock(&this_parent->d_lock);
+
+		/* go into the first sibling still alive */
+		do {
+			next = child->d_child.next;
+			if (next == &this_parent->d_subdirs)
+				goto ascend;
+			child = list_entry(next, struct dentry, d_child);
+		} while (unlikely(child->d_flags & DCACHE_DENTRY_KILLED));
+		rcu_read_unlock();
+		goto resume;
+	}
+	rcu_read_unlock();
+	spin_unlock(&this_parent->d_lock);
+	return;
+}
+
 static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 {
 	substring_t args[MAX_OPT_ARGS];
@@ -193,6 +264,7 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 			if (!gid_valid(gid))
 				return -EINVAL;
 			opts->gid = gid;
+			set_gid(tracefs_mount->mnt_root, gid);
 			break;
 		case Opt_mode:
 			if (match_octal(&args[0], &option))
@@ -414,6 +486,8 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	inode->i_mode = mode;
 	inode->i_fop = fops ? fops : &tracefs_file_operations;
 	inode->i_private = data;
+	inode->i_uid = d_inode(dentry->d_parent)->i_uid;
+	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
 	d_instantiate(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
 	return end_creating(dentry);
@@ -436,6 +510,8 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUSR| S_IRGRP | S_IXUSR | S_IXGRP;
 	inode->i_op = ops;
 	inode->i_fop = &simple_dir_operations;
+	inode->i_uid = d_inode(dentry->d_parent)->i_uid;
+	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 30bc880c3849..be5f6b32a012 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5217,6 +5217,7 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 {
 	struct ftrace_direct_func *direct;
 	struct ftrace_func_entry *entry;
+	struct ftrace_hash *hash;
 	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
@@ -5225,7 +5226,8 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 	if (!entry)
 		goto out_unlock;
 
-	if (direct_functions->count == 1)
+	hash = direct_ops.func_hash->filter_hash;
+	if (hash->count == 1)
 		unregister_ftrace_function(&direct_ops);
 
 	ret = ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
@@ -5540,6 +5542,10 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	err = unregister_ftrace_function(ops);
 	remove_direct_functions_hash(hash, addr);
 	mutex_unlock(&direct_mutex);
+
+	/* cleanup for possible another register call */
+	ops->func = NULL;
+	ops->trampoline = 0;
 	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 22db3ce95e74..ca9c13b2ecf4 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1237,9 +1237,8 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 						  argv + consumed, &consumed,
 						  &field_version);
 			if (IS_ERR(field)) {
-				argv_free(argv);
 				ret = PTR_ERR(field);
-				goto err;
+				goto err_free_arg;
 			}
 
 			/*
@@ -1262,18 +1261,19 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 			if (cmd_version > 1 && n_fields_this_loop >= 1) {
 				synth_err(SYNTH_ERR_INVALID_CMD, errpos(field_str));
 				ret = -EINVAL;
-				goto err;
+				goto err_free_arg;
 			}
 
 			fields[n_fields++] = field;
 			if (n_fields == SYNTH_FIELDS_MAX) {
 				synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
 				ret = -EINVAL;
-				goto err;
+				goto err_free_arg;
 			}
 
 			n_fields_this_loop++;
 		}
+		argv_free(argv);
 
 		if (consumed < argc) {
 			synth_err(SYNTH_ERR_INVALID_CMD, 0);
@@ -1281,7 +1281,6 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 			goto err;
 		}
 
-		argv_free(argv);
 	}
 
 	if (n_fields == 0) {
@@ -1307,6 +1306,8 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	kfree(saved_fields);
 
 	return ret;
+ err_free_arg:
+	argv_free(argv);
  err:
 	for (i = 0; i < n_fields; i++)
 		free_synth_field(fields[i]);
diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
index b9198e2eef28..faf8cdb79c5f 100644
--- a/samples/ftrace/Makefile
+++ b/samples/ftrace/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace-direct-multi.o
+obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace-direct-multi-modify.o
 
 CFLAGS_sample-trace-array.o := -I$(src)
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
new file mode 100644
index 000000000000..91bc42a7adb9
--- /dev/null
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/ftrace.h>
+#include <asm/asm-offsets.h>
+
+void my_direct_func1(unsigned long ip)
+{
+	trace_printk("my direct func1 ip %lx\n", ip);
+}
+
+void my_direct_func2(unsigned long ip)
+{
+	trace_printk("my direct func2 ip %lx\n", ip);
+}
+
+extern void my_tramp1(void *);
+extern void my_tramp2(void *);
+
+#ifdef CONFIG_X86_64
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	pushq %rbp\n"
+"	movq %rsp, %rbp\n"
+"	pushq %rdi\n"
+"	movq 8(%rbp), %rdi\n"
+"	call my_direct_func1\n"
+"	popq %rdi\n"
+"	leave\n"
+"	ret\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+"	.type		my_tramp2, @function\n"
+"\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:"
+"	pushq %rbp\n"
+"	movq %rsp, %rbp\n"
+"	pushq %rdi\n"
+"	movq 8(%rbp), %rdi\n"
+"	call my_direct_func2\n"
+"	popq %rdi\n"
+"	leave\n"
+"	ret\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_X86_64 */
+
+#ifdef CONFIG_S390
+
+asm (
+"       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp1, @function\n"
+"       .globl          my_tramp1\n"
+"   my_tramp1:"
+"       lgr             %r1,%r15\n"
+"       stmg            %r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"       stg             %r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"       aghi            %r15,"__stringify(-STACK_FRAME_OVERHEAD)"\n"
+"       stg             %r1,"__stringify(__SF_BACKCHAIN)"(%r15)\n"
+"       lgr             %r2,%r0\n"
+"       brasl           %r14,my_direct_func1\n"
+"       aghi            %r15,"__stringify(STACK_FRAME_OVERHEAD)"\n"
+"       lmg             %r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"       lg              %r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"       lgr             %r1,%r0\n"
+"       br              %r1\n"
+"       .size           my_tramp1, .-my_tramp1\n"
+"\n"
+"       .type           my_tramp2, @function\n"
+"       .globl          my_tramp2\n"
+"   my_tramp2:"
+"       lgr             %r1,%r15\n"
+"       stmg            %r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"       stg             %r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"       aghi            %r15,"__stringify(-STACK_FRAME_OVERHEAD)"\n"
+"       stg             %r1,"__stringify(__SF_BACKCHAIN)"(%r15)\n"
+"       lgr             %r2,%r0\n"
+"       brasl           %r14,my_direct_func2\n"
+"       aghi            %r15,"__stringify(STACK_FRAME_OVERHEAD)"\n"
+"       lmg             %r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"       lg              %r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"       lgr             %r1,%r0\n"
+"       br              %r1\n"
+"       .size           my_tramp2, .-my_tramp2\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_S390 */
+
+static unsigned long my_tramp = (unsigned long)my_tramp1;
+static unsigned long tramps[2] = {
+	(unsigned long)my_tramp1,
+	(unsigned long)my_tramp2,
+};
+
+static struct ftrace_ops direct;
+
+static int simple_thread(void *arg)
+{
+	static int t;
+	int ret = 0;
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(2 * HZ);
+
+		if (ret)
+			continue;
+		t ^= 1;
+		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
+		if (!ret)
+			my_tramp = tramps[t];
+		WARN_ON_ONCE(ret);
+	}
+
+	return 0;
+}
+
+static struct task_struct *simple_tsk;
+
+static int __init ftrace_direct_multi_init(void)
+{
+	int ret;
+
+	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
+	ftrace_set_filter_ip(&direct, (unsigned long) schedule, 0, 0);
+
+	ret = register_ftrace_direct_multi(&direct, my_tramp);
+
+	if (!ret)
+		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
+	return ret;
+}
+
+static void __exit ftrace_direct_multi_exit(void)
+{
+	kthread_stop(simple_tsk);
+	unregister_ftrace_direct_multi(&direct, my_tramp);
+}
+
+module_init(ftrace_direct_multi_init);
+module_exit(ftrace_direct_multi_exit);
+
+MODULE_AUTHOR("Jiri Olsa");
+MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
+MODULE_LICENSE("GPL");
