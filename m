Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8DD58051B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiGYUML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbiGYUMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5938D2127B;
        Mon, 25 Jul 2022 13:12:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B98A2610E7;
        Mon, 25 Jul 2022 20:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E59DC341D3;
        Mon, 25 Jul 2022 20:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658779920;
        bh=3HSJiiSXXQMEekMmOQ6/ljkRYp4cNQsA20mqRGnD0FA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTSFQ3lrkmh/vJ8MJ7ebN0UYPop/APCuLpmQZvC9dk83LNSKLdjK4heu6ZlBkQOam
         owmVemaLgxFXT/Bed8/qnvCo2ouK7Jn7+6rFtXNJAwfCHAa0mavtVJzOgI+i9RtwZH
         uvagCngdgXcCAYPM2zi2YDfieDL1YVnvwMygJ4tFUpxebQlVFQJOH7/OV5SWqe1SIV
         U4CUhIS+KPzHvZUKabAfIdcyB1ahwqpuTdkMP4RrjCR2u9BqsQWj67vvIhpcB+7mex
         eXQyxUXbIsP49dFNp7YJCshCPUsKkAVu3g7rWkxG2yj+xFowWBcr5DnJS33t5804vo
         +VjbH1FcXv17g==
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
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH V7 02/16] rv: Add runtime reactors interface
Date:   Mon, 25 Jul 2022 22:11:14 +0200
Message-Id: <516e8767f20f47b185b7dc0dceb1f1d3abb36dce.1658778484.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1658778484.git.bristot@kernel.org>
References: <cover.1658778484.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
     # cat available_reactors
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
     # cat monitors/wip/reactors
     [nop]
     panic
     printk
     # echo panic > monitors/wip/reactors
     # cat monitors/wip/reactors
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
Cc: Tao Zhou <tao.zhou@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/linux/rv.h            |  17 ++
 kernel/trace/rv/Kconfig       |  11 +
 kernel/trace/rv/Makefile      |   1 +
 kernel/trace/rv/rv.c          |   9 +
 kernel/trace/rv/rv.h          |  35 +++
 kernel/trace/rv/rv_reactors.c | 506 ++++++++++++++++++++++++++++++++++
 6 files changed, 579 insertions(+)
 create mode 100644 kernel/trace/rv/rv_reactors.c

diff --git a/include/linux/rv.h b/include/linux/rv.h
index d8fa9e8be94a..dcce56987cf7 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -24,6 +24,14 @@
 union rv_task_monitor {
 };
 
+#ifdef CONFIG_RV_REACTORS
+struct rv_reactor {
+	const char		*name;
+	const char		*description;
+	void			(*react)(char *msg);
+};
+#endif
+
 struct rv_monitor {
 	const char		*name;
 	const char		*description;
@@ -31,6 +39,9 @@ struct rv_monitor {
 	int			(*enable)(void);
 	void			(*disable)(void);
 	void			(*reset)(void);
+#ifdef CONFIG_RV_REACTORS
+	void			(*react)(char *msg);
+#endif
 };
 
 bool rv_monitoring_on(void);
@@ -39,5 +50,11 @@ int rv_register_monitor(struct rv_monitor *monitor);
 int rv_get_task_monitor_slot(void);
 void rv_put_task_monitor_slot(int slot);
 
+#ifdef CONFIG_RV_REACTORS
+bool rv_reacting_on(void);
+int rv_unregister_reactor(struct rv_reactor *reactor);
+int rv_register_reactor(struct rv_reactor *reactor);
+#endif /* CONFIG_RV_REACTORS */
+
 #endif /* CONFIG_RV */
 #endif /* _LINUX_RV_H */
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 6d127cdb00dd..3eb5d48ab4f6 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -10,3 +10,14 @@ menuconfig RV
 	  theorem proving). RV works by analyzing the trace of the system's
 	  actual execution, comparing it against a formal specification of
 	  the system behavior.
+
+config RV_REACTORS
+	bool "Runtime verification reactors"
+	default y
+	depends on RV
+	help
+	  Enables the online runtime verification reactors. A runtime
+	  monitor can cause a reaction to the detection of an exception
+	  on the model's execution. By default, the monitors have
+	  tracing reactions, printing the monitor output via tracepoints,
+	  but other reactions can be added (on-demand) via this interface.
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index fd995379df67..8944274d9b41 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_RV) += rv.o
+obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index aee71bc8287d..3771c61aa846 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -354,6 +354,10 @@ static int create_monitor_dir(struct rv_monitor_def *mdef)
 		goto out_remove_root;
 	}
 
+	retval = reactor_populate_monitor(mdef);
+	if (retval)
+		goto out_remove_root;
+
 	return 0;
 
 out_remove_root:
@@ -730,6 +734,7 @@ int rv_unregister_monitor(struct rv_monitor *monitor)
 int __init rv_init_interface(void)
 {
 	struct dentry *tmp;
+	int retval;
 
 	rv_root.root_dir = rv_create_dir("rv", NULL);
 	if (!rv_root.root_dir)
@@ -754,6 +759,10 @@ int __init rv_init_interface(void)
 	if (!tmp)
 		goto out_err;
 
+	retval = init_rv_reactors(rv_root.root_dir);
+	if (retval)
+		goto out_err;
+
 	WRITE_ONCE(monitoring_on, true);
 	/* monitoring_on */
 	smp_wmb();
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 47643840116e..a284a369fee0 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -18,13 +18,27 @@ struct rv_interface {
 #define rv_remove			tracefs_remove
 
 #define MAX_RV_MONITOR_NAME_SIZE	32
+#define MAX_RV_REACTOR_NAME_SIZE	32
 
 extern struct mutex rv_interface_lock;
 
+#ifdef CONFIG_RV_REACTORS
+struct rv_reactor_def {
+	struct list_head	list;
+	struct rv_reactor	*reactor;
+	/* protected by the monitor interface lock */
+	int			counter;
+};
+#endif
+
 struct rv_monitor_def {
 	struct list_head	list;
 	struct rv_monitor	*monitor;
 	struct dentry		*root_d;
+#ifdef CONFIG_RV_REACTORS
+	struct rv_reactor_def	*rdef;
+	bool			reacting;
+#endif
 	bool			task_monitor;
 };
 
@@ -32,3 +46,24 @@ struct dentry *get_monitors_root(void);
 int init_rv_monitors(struct dentry *root_dir);
 int rv_disable_monitor(struct rv_monitor_def *mdef);
 int rv_enable_monitor(struct rv_monitor_def *mdef);
+
+#ifdef CONFIG_RV_REACTORS
+int reactor_populate_monitor(struct rv_monitor_def *mdef);
+void reactor_cleanup_monitor(struct rv_monitor_def *mdef);
+int init_rv_reactors(struct dentry *root_dir);
+#else
+static inline int reactor_populate_monitor(struct rv_monitor_def *mdef)
+{
+	return 0;
+}
+
+static inline void reactor_cleanup_monitor(struct rv_monitor_def *mdef)
+{
+	return;
+}
+
+static inline int init_rv_reactors(struct dentry *root_dir)
+{
+	return 0;
+}
+#endif
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
new file mode 100644
index 000000000000..ef93cd5b4f82
--- /dev/null
+++ b/kernel/trace/rv/rv_reactors.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
+ *
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
+ *      # cat available_reactors
+ *      nop
+ *      panic
+ *      printk
+ *
+ *  "reacting_on"
+ *    - It is an on/off general switch for reactors, disabling
+ *    all reactions.
+ *
+ *  "monitors/MONITOR/reactors"
+ *    - List available reactors, with the select reaction for the given
+ *    MONITOR inside []. The default one is the nop (no operation)
+ *    reactor.
+ *    - Writing the name of an reactor enables it to the given
+ *    MONITOR.
+ *
+ *    For example:
+ *      # cat monitors/wip/reactors
+ *      [nop]
+ *      panic
+ *      printk
+ *      # echo panic > monitors/wip/reactors
+ *      # cat monitors/wip/reactors
+ *      nop
+ *      [panic]
+ *      printk
+ */
+
+#include <linux/slab.h>
+
+#include "rv.h"
+
+/*
+ * Interface for the reactor register.
+ */
+static LIST_HEAD(rv_reactors_list);
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
+ * available_reactors seq definition.
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
+ * Monitor's reactor file.
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
+ * available_reactors seq definition.
+ */
+static const struct seq_operations monitor_reactors_seq_ops = {
+	.start	= reactors_start,
+	.next	= reactors_next,
+	.stop	= reactors_stop,
+	.show	= monitor_reactor_show
+};
+
+static void monitor_swap_reactors(struct rv_monitor_def *mdef, struct rv_reactor_def *rdef,
+				    bool reacting)
+{
+	bool monitor_enabled;
+
+	/* nothing to do */
+	if (mdef->rdef == rdef)
+		return;
+
+	monitor_enabled = mdef->monitor->enabled;
+	if (monitor_enabled)
+		rv_disable_monitor(mdef);
+
+	/* swap reactor's usage */
+	mdef->rdef->counter--;
+	rdef->counter++;
+
+	mdef->rdef = rdef;
+	mdef->reacting = reacting;
+	mdef->monitor->react = rdef->reactor->react;
+
+	if (monitor_enabled)
+		rv_enable_monitor(mdef);
+}
+
+static ssize_t
+monitor_reactors_write(struct file *file, const char __user *user_buf,
+		      size_t count, loff_t *ppos)
+{
+	char buff[MAX_RV_REACTOR_NAME_SIZE + 2];
+	struct rv_monitor_def *mdef;
+	struct rv_reactor_def *rdef;
+	struct seq_file *seq_f;
+	int retval = -EINVAL;
+	bool enable;
+	char *ptr;
+	int len;
+
+	if (count < 1 || count > MAX_RV_REACTOR_NAME_SIZE + 1)
+		return -EINVAL;
+
+	memset(buff, 0, sizeof(buff));
+
+	retval = simple_write_to_buffer(buff, sizeof(buff) - 1, ppos, user_buf, count);
+	if (retval < 0)
+		return -EFAULT;
+
+	ptr = strim(buff);
+
+	len = strlen(ptr);
+	if (!len)
+		return count;
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
+	list_for_each_entry(rdef, &rv_reactors_list, list) {
+		if (strcmp(ptr, rdef->reactor->name) != 0)
+			continue;
+
+		if (rdef == get_reactor_rdef_by_name("nop"))
+			enable = false;
+		else
+			enable = true;
+
+		monitor_swap_reactors(mdef, rdef, enable);
+
+		retval = count;
+		break;
+	}
+
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
+	struct rv_monitor_def *mdef = inode->i_private;
+	struct seq_file *seq_f;
+	int ret;
+
+	ret = seq_open(file, &monitor_reactors_seq_ops);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * seq_open stores the seq_file on the file->private data.
+	 */
+	seq_f = file->private_data;
+
+	/*
+	 * Copy the create file "private" data to the seq_file private data.
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
+			pr_info("Reactor %s is already registered\n", reactor->name);
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
+ * @reactor:	The rv_reactor to be registered.
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
+ * @reactor:	The rv_reactor to be unregistered.
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
+static bool __read_mostly reacting_on;
+
+/**
+ * rv_reacting_on - checks if reacting is on
+ *
+ * Returns 1 if on, 0 otherwise.
+ */
+bool rv_reacting_on(void)
+{
+	/* reacting_on */
+	smp_rmb();
+	return READ_ONCE(reacting_on);
+}
+
+static ssize_t reacting_on_read_data(struct file *filp,
+				     char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	char *buff;
+
+	buff = rv_reacting_on() ? "1\n" : "0\n";
+
+	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff)+1);
+}
+
+static void turn_reacting_off(void)
+{
+	WRITE_ONCE(reacting_on, false);
+	/* reacting_on */
+	smp_wmb();
+}
+
+static void turn_reacting_on(void)
+{
+	WRITE_ONCE(reacting_on, true);
+	/* reacting_on */
+	smp_wmb();
+}
+
+static ssize_t reacting_on_write_data(struct file *filp, const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	int retval;
+	bool val;
+
+	retval = kstrtobool_from_user(user_buf, count, &val);
+	if (retval)
+		return retval;
+
+	mutex_lock(&rv_interface_lock);
+
+	if (val)
+		turn_reacting_on();
+	else
+		turn_reacting_off();
+
+	/*
+	 * Wait for the execution of all current events to notice
+	 * the change before returning to user-space.
+	 */
+	tracepoint_synchronize_unregister();
+
+	mutex_unlock(&rv_interface_lock);
+
+	return count;
+}
+
+static const struct file_operations reacting_on_fops = {
+	.open   = simple_open,
+	.llseek = no_llseek,
+	.write  = reacting_on_write_data,
+	.read   = reacting_on_read_data,
+};
+
+/**
+ * reactor_populate_monitor - creates per monitor reactors file
+ * @mdef:	monitor's definition.
+ *
+ * Returns 0 if successful, error otherwise.
+ */
+int reactor_populate_monitor(struct rv_monitor_def *mdef)
+{
+	struct dentry *tmp;
+
+	tmp = rv_create_file("reactors", RV_MODE_WRITE, mdef->root_d, mdef, &monitor_reactors_ops);
+	if (!tmp)
+		return -ENOMEM;
+
+	/*
+	 * Configure as the rv_nop reactor.
+	 */
+	mdef->rdef = get_reactor_rdef_by_name("nop");
+	mdef->rdef->counter++;
+	mdef->reacting = false;
+
+	return 0;
+}
+
+/**
+ * reactor_cleanup_monitor - cleanup a monitor reference
+ * @mdef:       monitor's definition.
+ */
+void reactor_cleanup_monitor(struct rv_monitor_def *mdef)
+{
+	mdef->rdef->counter--;
+}
+
+/*
+ * Nop reactor register
+ */
+static void rv_nop_reaction(char *msg)
+{
+}
+
+static struct rv_reactor rv_nop = {
+	.name = "nop",
+	.description = "no-operation reactor: do nothing.",
+	.react = rv_nop_reaction
+};
+
+int init_rv_reactors(struct dentry *root_dir)
+{
+	struct dentry *available, *reacting;
+	int retval;
+
+	available = rv_create_file("available_reactors", RV_MODE_READ, root_dir, NULL,
+				   &available_reactors_ops);
+	if (!available)
+		goto out_err;
+
+	reacting = rv_create_file("reacting_on", RV_MODE_WRITE, root_dir, NULL, &reacting_on_fops);
+	if (!reacting)
+		goto rm_available;
+
+	retval = __rv_register_reactor(&rv_nop);
+	if (retval)
+		goto rm_reacting;
+
+	turn_reacting_on();
+
+	return 0;
+
+rm_reacting:
+	rv_remove(reacting);
+rm_available:
+	rv_remove(available);
+out_err:
+	return -ENOMEM;
+}
-- 
2.35.1

