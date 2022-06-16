Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C6F54DD30
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359604AbiFPIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359726AbiFPIp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:45:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120E85D641;
        Thu, 16 Jun 2022 01:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9340361D7B;
        Thu, 16 Jun 2022 08:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B999CC341C5;
        Thu, 16 Jun 2022 08:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655369124;
        bh=5tR+ioR72vpql7is2gwJ+hptQLed7y7xYTKhidAvHsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amfwvka9a451GiXHyafk+zLs9L+9Te8mVlEPw1Zbr1R5H4MMMi6gj49ecUcVNucSU
         v9IVkPYVajwKYj+Y4Y6w2O5TzJ/HMU9Qn1FQpYha7f9iMLUz4nzyvUVVZ4255BKynf
         w65I+AO6iWtvHcnfJfVcOPmKB1A47Cmt24lYsgFBR0R4U9Hkni9DB2kzmMm0n5SwFc
         3xRMafqWtw7vT1Y7Yd9TwmAUbq1Xr2xPOAazf8etAETUMRSfS6ky+mkio4WoiVzk3j
         1dmvzR2DvL1u9ZZAJMRQw1ikAZEd8C0FXLhxwjhMDnjg+9EANZEqKUeIBet6A6qdjY
         otchBmcrV9GXw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH V4 02/20] rv: Add runtime reactors interface
Date:   Thu, 16 Jun 2022 10:44:44 +0200
Message-Id: <83874ccd86a34f6f2a4e6a8ca1fbe474685d6ba9.1655368610.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655368610.git.bristot@kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A runtime monitor can cause a reaction to the detection of an
exception on the model's execution. By default, the monitors have
tracing reactions, printing the monitor output via tracepoints.
But other reactions can be added (on-demand) via this interface.

The user interface resembles the kernel tracing interface and
presents these files:

"available_reactors"
  - Reading shows the available reactors, one per line.

   For example:
   [root@f32 rv]# cat available_reactors
   nop
   panic
   printk

 "reacting_on"
   - It is an on/off general switch for reactors, disabling
   all reactions.

 "monitors/MONITOR/reactors"
   - List available reactors, with the select reaction for the given
   MONITOR inside []. The default one is the nop (no operation)
   reactor.
   - Writing the name of a reactor enables it to the given
   MONITOR.

   For example:
   [root@f32 rv]# cat monitors/wip/reactors
   [nop]
   panic
   printk
   [root@f32 rv]# echo panic > monitors/wip/reactors
   [root@f32 rv]# cat monitors/wip/reactors
   nop
   [panic]
   printk

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/linux/rv.h            |  13 +
 kernel/trace/rv/Kconfig       |  14 +
 kernel/trace/rv/Makefile      |   1 +
 kernel/trace/rv/rv.c          |  18 +-
 kernel/trace/rv/rv.h          |  20 ++
 kernel/trace/rv/rv_reactors.c | 476 ++++++++++++++++++++++++++++++++++
 6 files changed, 540 insertions(+), 2 deletions(-)
 create mode 100644 kernel/trace/rv/rv_reactors.c

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 205e65f57637..1e48c6bb74bf 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -8,6 +8,13 @@
  */
 #ifndef _LINUX_RV_H
 #define _LINUX_RV_H
+
+struct rv_reactor {
+	char			*name;
+	char			*description;
+	void			(*react)(char *msg);
+};
+
 struct rv_monitor {
 	const char		*name;
 	const char		*description;
@@ -15,9 +22,15 @@ struct rv_monitor {
 	int			(*start)(void);
 	void			(*stop)(void);
 	void			(*reset)(void);
+	void			(*react)(char *msg);
+
 };
 
 extern bool monitoring_on;
 int rv_unregister_monitor(struct rv_monitor *monitor);
 int rv_register_monitor(struct rv_monitor *monitor);
+
+extern bool reacting_on;
+int rv_unregister_reactor(struct rv_reactor *reactor);
+int rv_register_reactor(struct rv_reactor *reactor);
 #endif /* _LINUX_RV_H */
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 6d127cdb00dd..560408fec0c8 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -10,3 +10,17 @@ menuconfig RV
 	  theorem proving). RV works by analyzing the trace of the system's
 	  actual execution, comparing it against a formal specification of
 	  the system behavior.
+
+if RV
+
+config RV_REACTORS
+	bool "Runtime verification reactors"
+	default y if RV
+	help
+	  Enables the online runtime verification reactors. A runtime
+	  monitor can cause a reaction to the detection of an exception
+	  on the model's execution. By default, the monitors have
+	  tracing reactions, printing the monitor output via tracepoints,
+	  but other reactions can be added (on-demand) via this interface.
+
+endif # RV
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index fd995379df67..8944274d9b41 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_RV) += rv.o
+obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 43af7b13187e..7576d492a974 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -362,8 +362,13 @@ static int create_monitor_dir(struct rv_monitor_def *mdef)
 		retval = -ENOMEM;
 		goto out_remove_root;
 	}
+#ifdef CONFIG_RV_REACTORS
+	retval = reactor_create_monitor_files(mdef);
+	if (retval)
+		goto out_remove_root;
+#endif
 
-	return retval;
+	return 0;
 
 out_remove_root:
 	rv_remove(mdef->root_d);
@@ -674,7 +679,11 @@ int rv_register_monitor(struct rv_monitor *monitor)
 
 	r->monitor = monitor;
 
-	create_monitor_dir(r);
+	retval = create_monitor_dir(r);
+	if (retval) {
+		kfree(r);
+		goto out_unlock;
+	}
 
 	list_add_tail(&r->list, &rv_monitors_list);
 
@@ -732,6 +741,11 @@ int __init rv_init_interface(void)
 	rv_create_file("monitoring_on", 0600, rv_root.root_dir, NULL,
 		       &monitoring_on_fops);
 
+#ifdef CONFIG_RV_REACTORS
+	init_rv_reactors(rv_root.root_dir);
+	reacting_on = true;
+#endif
+
 	monitoring_on = true;
 
 	return 0;
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 0796867a7b1e..6d43f52d72a9 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -15,14 +15,28 @@ struct rv_interface {
 #define rv_remove			tracefs_remove
 
 #define MAX_RV_MONITOR_NAME_SIZE	32
+#define MAX_RV_REACTOR_NAME_SIZE	32
 
 extern struct mutex rv_interface_lock;
 
+#ifdef CONFIG_RV_REACTORS
+struct rv_reactor_def {
+	struct list_head list;
+	struct rv_reactor *reactor;
+	/* protected by the monitor interface lock */
+	int counter;
+};
+#endif
+
 struct rv_monitor_def {
 	struct list_head list;
 	struct rv_monitor *monitor;
+#ifdef CONFIG_RV_REACTORS
+	struct rv_reactor_def *rdef;
+#endif
 	struct dentry *root_d;
 	bool enabled;
+	bool reacting;
 	bool task_monitor;
 };
 
@@ -32,3 +46,9 @@ void reset_all_monitors(void);
 int init_rv_monitors(struct dentry *root_dir);
 int get_task_monitor_slot(void);
 void put_task_monitor_slot(int slot);
+
+#ifdef CONFIG_RV_REACTORS
+extern bool reacting_on;
+int reactor_create_monitor_files(struct rv_monitor_def *mdef);
+int init_rv_reactors(struct dentry *root_dir);
+#endif
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
new file mode 100644
index 000000000000..bfe54d6996cc
--- /dev/null
+++ b/kernel/trace/rv/rv_reactors.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Runtime reactor interface.
+ *
+ * A runtime monitor can cause a reaction to the detection of an
+ * exception on the model's execution. By default, the monitors have
+ * tracing reactions, printing the monitor output via tracepoints.
+ * But other reactions can be added (on-demand) via this interface.
+ *
+ * == Registering reactors ==
+ *
+ * The struct rv_reactor defines a callback function to be executed
+ * in case of a model exception happens. The callback function
+ * receives a message to be (optionally) printed before executing
+ * the reaction.
+ *
+ * A RV reactor is registered via:
+ *   int rv_register_reactor(struct rv_reactor *reactor)
+ * And unregistered via:
+ *   int rv_unregister_reactor(struct rv_reactor *reactor)
+ *
+ * These functions are exported to modules, enabling reactors to be
+ * dynamically loaded.
+ *
+ * == User interface ==
+ *
+ * The user interface resembles the kernel tracing interface and
+ * presents these files:
+ *
+ *  "available_reactors"
+ *    - List the available reactors, one per line.
+ *
+ *    For example:
+ *    [root@f32 rv]# cat available_reactors
+ *    nop
+ *    panic
+ *    printk
+ *
+ *  "reacting_on"
+ *    - It is an on/off general switch for reactors, disabling
+ *    all reactions.
+ *
+ *  "monitors/MONITOR/reactors"
+ *    - List available reactors, with the select reaction for the given
+ *    MONITOR inside []. The defaul one is the nop (no operation)
+ *    reactor.
+ *    - Writing the name of an reactor enables it to the given
+ *    MONITOR.
+ *
+ *    For example:
+ *    [root@f32 rv]# cat monitors/wip/reactors
+ *    [nop]
+ *    panic
+ *    printk
+ *    [root@f32 rv]# echo panic > monitors/wip/reactors
+ *    [root@f32 rv]# cat monitors/wip/reactors
+ *    nop
+ *    [panic]
+ *    printk
+ *
+ * Copyright (C) 2019-2022 Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+
+#include <linux/slab.h>
+
+#include "rv.h"
+
+bool __read_mostly reacting_on;
+
+/*
+ * Interface for the reactor register.
+ */
+LIST_HEAD(rv_reactors_list);
+
+static struct rv_reactor_def *get_reactor_rdef_by_name(char *name)
+{
+	struct rv_reactor_def *r;
+
+	list_for_each_entry(r, &rv_reactors_list, list) {
+		if (strcmp(name, r->reactor->name) == 0)
+			return r;
+	}
+	return NULL;
+}
+
+/*
+ * Available reactors seq functions.
+ */
+static int reactors_show(struct seq_file *m, void *p)
+{
+	struct rv_reactor_def *rea_def = p;
+
+	seq_printf(m, "%s\n", rea_def->reactor->name);
+	return 0;
+}
+
+static void reactors_stop(struct seq_file *m, void *p)
+{
+	mutex_unlock(&rv_interface_lock);
+}
+
+static void *reactors_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&rv_interface_lock);
+	return seq_list_start(&rv_reactors_list, *pos);
+}
+
+static void *reactors_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	return seq_list_next(p, &rv_reactors_list, pos);
+}
+
+/*
+ * available reactors seq definition.
+ */
+static const struct seq_operations available_reactors_seq_ops = {
+	.start	= reactors_start,
+	.next	= reactors_next,
+	.stop	= reactors_stop,
+	.show	= reactors_show
+};
+
+/*
+ * available_reactors interface.
+ */
+static int available_reactors_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &available_reactors_seq_ops);
+};
+
+static const struct file_operations available_reactors_ops = {
+	.open    = available_reactors_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release
+};
+
+/*
+ * Monitor reactor file.
+ */
+static int monitor_reactor_show(struct seq_file *m, void *p)
+{
+	struct rv_monitor_def *mdef = m->private;
+	struct rv_reactor_def *rdef = p;
+
+	if (mdef->rdef == rdef)
+		seq_printf(m, "[%s]\n", rdef->reactor->name);
+	else
+		seq_printf(m, "%s\n", rdef->reactor->name);
+	return 0;
+}
+
+/*
+ * available reactors seq definition.
+ */
+static const struct seq_operations monitor_reactors_seq_ops = {
+	.start	= reactors_start,
+	.next	= reactors_next,
+	.stop	= reactors_stop,
+	.show	= monitor_reactor_show
+};
+
+static ssize_t
+monitor_reactors_write(struct file *file, const char __user *user_buf,
+		      size_t count, loff_t *ppos)
+{
+	char buff[MAX_RV_REACTOR_NAME_SIZE+1];
+	struct rv_monitor_def *mdef;
+	struct rv_reactor_def *rdef;
+	struct seq_file *seq_f;
+	int retval = -EINVAL;
+	char *ptr = buff;
+	int len;
+
+	if (count < 1 || count > MAX_RV_REACTOR_NAME_SIZE+1)
+		return -EINVAL;
+
+	memset(buff, 0, sizeof(buff));
+
+	retval = simple_write_to_buffer(buff, sizeof(buff)-1, ppos, user_buf,
+					count);
+	if (!retval)
+		return -EFAULT;
+
+	len = strlen(ptr);
+	if (!len)
+		return count;
+	/*
+	 * remove the \n
+	 */
+	ptr[len-1] = '\0';
+
+	/*
+	 * See monitor_reactors_open()
+	 */
+	seq_f = file->private_data;
+	mdef = seq_f->private;
+
+	mutex_lock(&rv_interface_lock);
+
+	retval = -EINVAL;
+
+	/*
+	 * nop special case: disable reacting.
+	 */
+	if (strcmp(ptr, "nop") == 0) {
+
+		if (mdef->monitor->enabled)
+			mdef->monitor->stop();
+
+		mdef->rdef = get_reactor_rdef_by_name("nop");
+		mdef->reacting = false;
+		mdef->monitor->react = NULL;
+
+		if (mdef->monitor->enabled)
+			mdef->monitor->start();
+
+		retval = count;
+		goto unlock;
+	}
+
+	list_for_each_entry(rdef, &rv_reactors_list, list) {
+		if (strcmp(ptr, rdef->reactor->name) == 0) {
+			/*
+			 * found!
+			 */
+			if (mdef->monitor->enabled)
+				mdef->monitor->stop();
+
+			mdef->rdef = rdef;
+			mdef->reacting = true;
+			mdef->monitor->react = rdef->reactor->react;
+
+			if (mdef->monitor->enabled)
+				mdef->monitor->start();
+
+			retval = count;
+			break;
+		}
+	}
+
+unlock:
+	mutex_unlock(&rv_interface_lock);
+
+	return retval;
+}
+
+/*
+ * available_reactors interface.
+ */
+static int monitor_reactors_open(struct inode *inode, struct file *file)
+{
+	/*
+	 * create file "private" info is stored in the inode->i_private
+	 */
+	struct rv_monitor_def *mdef = inode->i_private;
+	struct seq_file *seq_f;
+	int ret;
+
+
+	ret = seq_open(file, &monitor_reactors_seq_ops);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * seq_open stores the seq_file on the file->private data.
+	 */
+	seq_f = file->private_data;
+	/*
+	 * Copy the create file "private" data to the seq_file
+	 * private data.
+	 */
+	seq_f->private = mdef;
+
+	return 0;
+};
+
+static const struct file_operations monitor_reactors_ops = {
+	.open    = monitor_reactors_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+	.write = monitor_reactors_write
+};
+
+static int __rv_register_reactor(struct rv_reactor *reactor)
+{
+	struct rv_reactor_def *r;
+
+	list_for_each_entry(r, &rv_reactors_list, list) {
+		if (strcmp(reactor->name, r->reactor->name) == 0) {
+			pr_info("Reactor %s is already registered\n",
+				reactor->name);
+			return -EINVAL;
+		}
+	}
+
+	r = kzalloc(sizeof(struct rv_reactor_def), GFP_KERNEL);
+	if (!r)
+		return -ENOMEM;
+
+	r->reactor = reactor;
+	r->counter = 0;
+
+	list_add_tail(&r->list, &rv_reactors_list);
+
+	return 0;
+}
+
+/**
+ * rv_register_reactor - register a rv reactor.
+ * @reactor:    The rv_reactor to be registered.
+ *
+ * Returns 0 if successful, error otherwise.
+ */
+int rv_register_reactor(struct rv_reactor *reactor)
+{
+	int retval = 0;
+
+	if (strlen(reactor->name) >= MAX_RV_REACTOR_NAME_SIZE) {
+		pr_info("Reactor %s has a name longer than %d\n",
+			reactor->name, MAX_RV_MONITOR_NAME_SIZE);
+		return -EINVAL;
+	}
+
+	mutex_lock(&rv_interface_lock);
+	retval = __rv_register_reactor(reactor);
+	mutex_unlock(&rv_interface_lock);
+	return retval;
+}
+
+/**
+ * rv_unregister_reactor - unregister a rv reactor.
+ * @reactor:    The rv_reactor to be unregistered.
+ *
+ * Returns 0 if successful, error otherwise.
+ */
+int rv_unregister_reactor(struct rv_reactor *reactor)
+{
+	struct rv_reactor_def *ptr, *next;
+
+	mutex_lock(&rv_interface_lock);
+
+	list_for_each_entry_safe(ptr, next, &rv_reactors_list, list) {
+		if (strcmp(reactor->name, ptr->reactor->name) == 0) {
+
+			if (!ptr->counter) {
+				list_del(&ptr->list);
+			} else {
+				printk(KERN_WARNING
+				       "rv: the rv_reactor %s is in use by %d monitor(s)\n",
+				       ptr->reactor->name, ptr->counter);
+				printk(KERN_WARNING "rv: the rv_reactor %s cannot be removed\n",
+				       ptr->reactor->name);
+				return -EBUSY;
+			}
+
+		}
+	}
+
+	mutex_unlock(&rv_interface_lock);
+	return 0;
+}
+
+/*
+ * reacting_on interface.
+ */
+static ssize_t reacting_on_read_data(struct file *filp,
+				     char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	char buff[4];
+
+	memset(buff, 0, sizeof(buff));
+
+	mutex_lock(&rv_interface_lock);
+	sprintf(buff, "%d\n", reacting_on);
+	mutex_unlock(&rv_interface_lock);
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       buff, strlen(buff)+1);
+}
+
+static void turn_reacting_off(void)
+{
+	reacting_on = false;
+}
+
+static void turn_reacting_on(void)
+{
+	reacting_on = true;
+}
+
+static ssize_t
+reacting_on_write_data(struct file *filp, const char __user *user_buf,
+		       size_t count, loff_t *ppos)
+{
+	int retval;
+	u64 val;
+
+	retval = kstrtoull_from_user(user_buf, count, 10, &val);
+	if (retval)
+		return retval;
+
+	retval = count;
+
+	mutex_lock(&rv_interface_lock);
+
+	switch (val) {
+	case 0:
+		turn_reacting_off();
+		break;
+	case 1:
+		turn_reacting_on();
+		break;
+	default:
+		retval = -EINVAL;
+	}
+
+	mutex_unlock(&rv_interface_lock);
+
+	return retval;
+}
+
+static const struct file_operations reacting_on_fops = {
+	.open   = simple_open,
+	.llseek = no_llseek,
+	.write  = reacting_on_write_data,
+	.read   = reacting_on_read_data,
+};
+
+
+int reactor_create_monitor_files(struct rv_monitor_def *mdef)
+{
+	struct dentry *tmp;
+
+	tmp = rv_create_file("reactors", 0400, mdef->root_d, mdef,
+			     &monitor_reactors_ops);
+	if (!tmp)
+		return -ENOMEM;
+
+	/*
+	 * Configure as the rv_nop reactor.
+	 */
+	mdef->rdef = get_reactor_rdef_by_name("nop");
+	mdef->reacting = false;
+
+	return 0;
+}
+
+/*
+ * None reactor register
+ */
+static void rv_nop_reaction(char *msg)
+{
+}
+
+struct rv_reactor rv_nop = {
+	.name = "nop",
+	.description = "no-operation reactor: do nothing.",
+	.react = rv_nop_reaction
+};
+
+/*
+ * This section collects the rv/ root dir files and folders.
+ */
+int init_rv_reactors(struct dentry *root_dir)
+{
+	rv_create_file("available_reactors", 0400, root_dir, NULL,
+		       &available_reactors_ops);
+	rv_create_file("reacting_on", 0600, root_dir, NULL, &reacting_on_fops);
+
+	__rv_register_reactor(&rv_nop);
+
+	return 0;
+}
-- 
2.35.1

