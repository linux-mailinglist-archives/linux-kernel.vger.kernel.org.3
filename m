Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E442556AE0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbiGGV6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbiGGV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:58:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1364F95BE;
        Thu,  7 Jul 2022 14:58:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [98.59.227.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id A512320A8980;
        Thu,  7 Jul 2022 14:58:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A512320A8980
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657231112;
        bh=1VAir5NHQxI8UWFhYlpRVTEOaaQYJiPDRYand/igM1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WByESls780h+/5vX5pLYVphpy0mbNnxf74ND36j2R8BRmy601+DQsY3aE8jft2xV+
         N4eHnk7eRnP81Px7rQIEe1Wk2iTZ3a/+iKtePZZdIY8MMUBDhUQIZUNL6N6lUlQ2ds
         Brrvh8Kh9cfS6Q5gD1BHs6ble6VsAwhVbIcHucXU=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/7] tracing: Add tracing namespace API for systems to register with
Date:   Thu,  7 Jul 2022 14:58:24 -0700
Message-Id: <20220707215828.2021-4-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707215828.2021-1-beaub@linux.microsoft.com>
References: <20220707215828.2021-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User facing tracing systems, such as user_events and LTTng, sometimes
require multiple events with the same name, but from different
containers. This can cause event name conflicts and leak out details
of events not owned by the container.

To create a tracing namespace, run mkdir under the new tracefs directory
named "namespaces" (/sys/kernel/tracing/namespaces typically). This
directory largely works the same as "instances" where the new directory
will have files populated within it via the tracing system
automatically. The tracing systems will put their files under the "root"
directory, which is meant to be the directory that you can bind mount
out to containers. The "options" file is meant to allow operators to
configure the namespaces via the registered systems.

The tracing namespace allows those user facing systems to register with
the tracing namespace. When an operator creates a namespace directory
under /sys/kernel/tracing/namespaces the registered systems will have
their create operation run for that namespace. The systems can then create
files in the new directory used for tracing via user programs. These
files will then isolate events between each namespace the operator
creates.

Typically the system name of the event will have the tracing namespace
name appended onto the system name. For example, if a namespace
directory was created named "mygroup", then the system name would be
"<system_name>.mygroup". Since the system names are different for each
namespace, per-namespace recording/playback can be done by specifying the
per-namespace system name and the event name. However, this decision is
up to the registered tracing system for each namespace.

The operator can then bind mount each namespace directory into
containers. This provides isolation between events and containers, if
required. It's also possible for several containers to share an
isolation via bind mounts instead of having an isolation per-container.
With these files being isolated, different permissions can be added for
these files than normal tracefs files. This helps scenarios where
non-admin processes would like to trace, but currently cannot.

Link: https://lore.kernel.org/all/20220312010140.1880-1-beaub@linux.microsoft.com/

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/Kconfig           |  11 +
 kernel/trace/Makefile          |   1 +
 kernel/trace/trace.c           |  39 +++
 kernel/trace/trace_namespace.c | 567 +++++++++++++++++++++++++++++++++
 kernel/trace/trace_namespace.h |  57 ++++
 5 files changed, 675 insertions(+)
 create mode 100644 kernel/trace/trace_namespace.c
 create mode 100644 kernel/trace/trace_namespace.h

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 9bb54c0b3b2d..89550287275c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -777,6 +777,17 @@ config USER_EVENTS
 
 	  If in doubt, say N.
 
+config TRACE_NAMESPACE
+	bool "Tracing namespaces"
+	select TRACING
+	help
+	  Tracing namespaces are isolated directories within tracefs
+	  that can be used to isolate tracing events from other events
+	  and processes.  Typically this is most useful for user-defined
+	  trace events.
+
+	  If in doubt, say N.
+
 config HIST_TRIGGERS
 	bool "Histogram triggers"
 	depends on ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 0d261774d6f3..b88241164eb3 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_TRACE_EVENT_INJECT) += trace_events_inject.o
 obj-$(CONFIG_SYNTH_EVENTS) += trace_events_synth.o
 obj-$(CONFIG_HIST_TRIGGERS) += trace_events_hist.o
 obj-$(CONFIG_USER_EVENTS) += trace_events_user.o
+obj-$(CONFIG_TRACE_NAMESPACE) += trace_namespace.o
 obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o
 obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe.o
 obj-$(CONFIG_TRACEPOINTS) += error_report-traces.o
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f400800bc910..4fdc35db8d5f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -53,6 +53,10 @@
 #include "trace.h"
 #include "trace_output.h"
 
+#ifdef CONFIG_TRACE_NAMESPACE
+#include "trace_namespace.h"
+#endif
+
 /*
  * On boot up, the ring buffer is set to the minimum size, so that
  * we do not waste memory on systems that are not using tracing.
@@ -9079,6 +9083,10 @@ static const struct file_operations buffer_percent_fops = {
 
 static struct dentry *trace_instance_dir;
 
+#ifdef CONFIG_TRACE_NAMESPACE
+static struct dentry *trace_namespace_dir;
+#endif
+
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 
@@ -9321,6 +9329,18 @@ static int instance_mkdir(const char *name)
 	return ret;
 }
 
+#ifdef CONFIG_TRACE_NAMESPACE
+static int namespace_mkdir(const char *name)
+{
+	return trace_namespace_add(name);
+}
+
+static int namespace_rmdir(const char *name)
+{
+	return trace_namespace_remove(name);
+}
+#endif
+
 /**
  * trace_array_get_by_name - Create/Lookup a trace array, given its name.
  * @name: The name of the trace array to be looked up/created.
@@ -9472,6 +9492,21 @@ static __init void create_trace_instances(struct dentry *d_tracer)
 	mutex_unlock(&event_mutex);
 }
 
+#ifdef CONFIG_TRACE_NAMESPACE
+static __init void create_trace_namespaces(struct dentry *d_tracer)
+{
+	trace_namespace_dir = tracefs_create_namespace_dir("namespaces",
+							   d_tracer,
+							   namespace_mkdir,
+							   namespace_rmdir);
+
+	if (MEM_FAIL(!trace_instance_dir, "Failed to create namespaces directory\n"))
+		return;
+
+	trace_namespace_init(trace_namespace_dir);
+}
+#endif
+
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 {
@@ -9760,6 +9795,10 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 
 	create_trace_instances(NULL);
 
+#ifdef CONFIG_TRACE_NAMESPACE
+	create_trace_namespaces(NULL);
+#endif
+
 	update_tracer_options(&global_trace);
 }
 
diff --git a/kernel/trace/trace_namespace.c b/kernel/trace/trace_namespace.c
new file mode 100644
index 000000000000..934649e4db49
--- /dev/null
+++ b/kernel/trace/trace_namespace.c
@@ -0,0 +1,567 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Microsoft Corporation.
+ *
+ * Authors:
+ *   Beau Belgrave <beaub@linux.microsoft.com>
+ */
+
+#include <linux/dcache.h>
+#include <linux/idr.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/refcount.h>
+#include <linux/tracefs.h>
+#include "trace.h"
+#include "trace_namespace.h"
+
+static struct dentry *root_namespace_dir;
+#define TRACE_ROOT_DIR_NAME "root"
+#define TRACE_OPTIONS_NAME "options"
+
+static LIST_HEAD(namespace_systems);
+static LIST_HEAD(namespace_groups);
+static DEFINE_IDR(namespace_idr);
+
+/*
+ * Stores a registered system operations.
+ */
+struct namespace_system {
+	struct list_head link;
+	struct trace_namespace_operations *ops;
+};
+
+/*
+ * Stores namespace specific data about the group. The group can either
+ * be looked up by name or the id of the trace_namespace property.
+ */
+struct namespace_group {
+	struct list_head link;
+	struct trace_namespace ns;
+	refcount_t refcnt;
+	struct dentry *trace_dir;
+	struct dentry *trace_options;
+};
+
+/* Current parsing group to allow using trace_parse_run_command */
+static struct namespace_group *parsing_group;
+
+#define TRACE_NS_FROM_GROUP(group) (&(group)->ns)
+
+/*
+ * Runs the parse operation for each registered system for the group.
+ */
+static int namespace_systems_parse(struct namespace_group *group,
+				   const char *command)
+{
+	struct list_head *head = &namespace_systems;
+	struct namespace_system *system;
+	struct trace_namespace *ns;
+	int ret = -ENODEV;
+
+	ns = TRACE_NS_FROM_GROUP(group);
+
+	list_for_each_entry(system, head, link) {
+		ret = system->ops->parse(ns, command);
+
+		if (!ret || ret != -ECANCELED)
+			break;
+	}
+
+	if (ret == -ECANCELED)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+
+/*
+ * Runs the is_busy operation for each registered system for the group.
+ */
+static bool namespace_systems_busy(struct namespace_group *group)
+{
+	struct list_head *head = &namespace_systems;
+	struct namespace_system *system;
+	struct trace_namespace *ns;
+
+	ns = TRACE_NS_FROM_GROUP(group);
+
+	list_for_each_entry(system, head, link)
+		if (system->ops->is_busy(ns))
+			return true;
+
+	return false;
+}
+
+/*
+ * Runs the remove operation for each registered system for the group.
+ *
+ * NOTE: If a system has a failure it does not stop the other systems from
+ * having their remove operation run for the group.
+ */
+static int namespace_systems_remove(struct namespace_group *group, int max)
+{
+	struct list_head *head = &namespace_systems;
+	struct namespace_system *system;
+	struct trace_namespace *ns;
+	int error, ret = 0, i = 0;
+
+	ns = TRACE_NS_FROM_GROUP(group);
+
+	list_for_each_entry(system, head, link) {
+		error = system->ops->remove(ns);
+		i++;
+
+		/* Save last error (if not no entity), but keep removing */
+		if (error && error != -ENOENT)
+			ret = error;
+
+		if (max != -1 && i >= max)
+			break;
+	}
+
+	return ret;
+}
+
+/*
+ * Runs the create operation for each registered system for the group.
+ *
+ * NOTE: If a system has a failure, then the previously successful systems
+ * will have their remove operation run for the group.
+ */
+static int namespace_systems_create(struct namespace_group *group)
+{
+	struct list_head *head = &namespace_systems;
+	struct namespace_system *system;
+	struct trace_namespace *ns;
+	int ret = 0, count = 0;
+
+	ns = TRACE_NS_FROM_GROUP(group);
+
+	list_for_each_entry(system, head, link) {
+		ret = system->ops->create(ns);
+
+		if (ret)
+			break;
+
+		count++;
+	}
+
+	/* If we had a failure, remove systems that were created */
+	if (ret)
+		namespace_systems_remove(group, count);
+
+	return ret;
+}
+
+/*
+ * Release a previously acquired reference to a namespace group.
+ */
+static __always_inline
+void namespace_group_release(struct namespace_group *group)
+{
+	refcount_dec(&group->refcnt);
+}
+
+/*
+ * Lookups up a namespace group by ID and increments the ref count.
+ */
+static struct namespace_group *namespace_group_ref(int id)
+{
+	struct namespace_group *group;
+
+	mutex_lock(&event_mutex);
+
+	group = idr_find(&namespace_idr, id);
+
+	if (group)
+		refcount_inc(&group->refcnt);
+
+	mutex_unlock(&event_mutex);
+
+	return group;
+}
+
+/*
+ * Lookups up a namespace group by name, without increasing the ref count.
+ */
+static struct namespace_group *namespace_group_find(const char *name)
+{
+	struct list_head *head = &namespace_groups;
+	struct namespace_group *group;
+	struct trace_namespace *ns;
+
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(group, head, link) {
+		ns = TRACE_NS_FROM_GROUP(group);
+
+		if (!strcmp(ns->name, name))
+			return group;
+	}
+
+	return NULL;
+}
+
+/*
+ * Frees group resources and removes the directory of a namespace.
+ */
+static void namespace_group_destroy(struct namespace_group *group)
+{
+	struct trace_namespace *ns = TRACE_NS_FROM_GROUP(group);
+
+	lockdep_assert_held(&event_mutex);
+
+	if (ns->id > 0)
+		idr_remove(&namespace_idr, ns->id);
+
+	if (ns->dir)
+		tracefs_remove(ns->dir);
+
+	if (group->trace_options)
+		tracefs_remove(group->trace_options);
+
+	if (group->trace_dir)
+		tracefs_remove(group->trace_dir);
+
+	kfree(ns->name);
+	kfree(group);
+}
+
+void *group_options_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&event_mutex);
+
+	return seq_list_start(&namespace_systems, *pos);
+}
+
+void *group_options_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &namespace_systems, pos);
+}
+
+void group_options_seq_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&event_mutex);
+}
+
+static int group_options_seq_show(struct seq_file *m, void *v)
+{
+	struct namespace_system *system = v;
+	struct namespace_group *group = m->private;
+
+	if (system && system->ops && group)
+		return system->ops->show(TRACE_NS_FROM_GROUP(group), m);
+
+	return 0;
+}
+
+static const struct seq_operations group_options_seq_op = {
+	.start  = group_options_seq_start,
+	.next   = group_options_seq_next,
+	.stop   = group_options_seq_stop,
+	.show   = group_options_seq_show
+};
+
+/*
+ * Gets the group associated with the current seq_file.
+ */
+static struct namespace_group *seq_file_namespace_group(struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+
+	if (!seq)
+		return NULL;
+
+	return seq->private;
+}
+
+static int group_options_open(struct inode *node, struct file *file)
+{
+	struct namespace_group *group;
+	int ret;
+
+	group = namespace_group_ref((int)(uintptr_t)node->i_private);
+
+	if (!group)
+		return -ENOENT;
+
+	ret = seq_open(file, &group_options_seq_op);
+
+	if (!ret) {
+		/* Chain group into seq_file private data */
+		struct seq_file *seq = file->private_data;
+
+		seq->private = group;
+	}
+
+	return ret;
+}
+
+static int group_options_parse(const char *command)
+{
+	return namespace_systems_parse(parsing_group, command);
+}
+
+static ssize_t group_options_write(struct file *file, const char __user *buffer,				   size_t count, loff_t *ppos)
+{
+	struct namespace_group *group = seq_file_namespace_group(file);
+	int ret;
+
+	if (!group)
+		return -EINVAL;
+
+	mutex_lock(&event_mutex);
+
+	/* Set group to use for commands */
+	parsing_group = group;
+
+	ret = trace_parse_run_command(file, buffer, count, ppos,
+				      group_options_parse);
+
+	parsing_group = NULL;
+
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+static int group_options_release(struct inode *node, struct file *file)
+{
+	struct namespace_group *group = seq_file_namespace_group(file);
+
+	if (group)
+		namespace_group_release(group);
+
+	return seq_release(node, file);
+}
+
+static const struct file_operations group_options_fops = {
+	.open = group_options_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = group_options_release,
+	.write = group_options_write,
+};
+
+/*
+ * Creates a group that tracks the name and directory of a namespace.
+ */
+static struct namespace_group *namespace_group_create(const char *name)
+{
+	struct namespace_group *group;
+	struct trace_namespace *ns;
+
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+
+	if (!group)
+		goto error;
+
+	refcount_set(&group->refcnt, 1);
+
+	ns = TRACE_NS_FROM_GROUP(group);
+	ns->name = kstrdup(name, GFP_KERNEL);
+
+	if (!ns->name)
+		goto error;
+
+	/*
+	 * 0 is reserved for non-namespace lookups for systems to use.
+	 * If this were not the case, systems would have to pivot code
+	 * between namespace cases and non-namespace cases.
+	 *
+	 * Cyclic is used here to reduce the chances of the same id being
+	 * using very quickly. This allows for less chance of a id lookup
+	 * to get the wrong namespace during file open cases.
+	 */
+	ns->id = idr_alloc_cyclic(&namespace_idr, group, 1, 0, GFP_KERNEL);
+
+	if (ns->id < 0)
+		goto error;
+
+	group->trace_dir = tracefs_create_dir(ns->name, root_namespace_dir);
+
+	if (!group->trace_dir)
+		goto error;
+
+	group->trace_options = tracefs_create_file(TRACE_OPTIONS_NAME,
+						   TRACE_MODE_WRITE,
+						   group->trace_dir,
+						   (void *)(uintptr_t)ns->id,
+						   &group_options_fops);
+
+	if (!group->trace_options)
+		goto error;
+
+	ns->dir = tracefs_create_dir(TRACE_ROOT_DIR_NAME, group->trace_dir);
+
+	if (!ns->dir)
+		goto error;
+
+	return group;
+error:
+	if (group)
+		namespace_group_destroy(group);
+
+	return NULL;
+}
+
+/**
+ * trace_namespace_register - register a system for tracing namespaces.
+ * @ops: operations to perform for each namespace
+ *
+ * Registers a system that runs operations for each namespace on the system.
+ * This will fail if not all operations are not specified.
+ */
+int trace_namespace_register(struct trace_namespace_operations *ops)
+{
+	struct namespace_system *system;
+
+	if (!ops->create || !ops->remove || !ops->is_busy ||
+	    !ops->parse || !ops->show)
+		return -EINVAL;
+
+	system = kmalloc(sizeof(*system), GFP_KERNEL);
+
+	if (!system)
+		return -ENOMEM;
+
+	system->ops = ops;
+
+	mutex_lock(&event_mutex);
+
+	list_add(&system->link, &namespace_systems);
+
+	mutex_unlock(&event_mutex);
+
+	return 0;
+}
+
+/**
+ * trace_namespace_init - configures namespaces to be used on the system.
+ * @dir: directory to use for namespaces
+ *
+ * Configures the directory to be used for namespaces.
+ *
+ * NOTE: Can only be called once.
+ */
+int trace_namespace_init(struct dentry *dir)
+{
+	int ret = 0;
+
+	mutex_lock(&event_mutex);
+
+	if (root_namespace_dir) {
+		pr_warn("trace namespace init called more than once\n");
+		ret = -EEXIST;
+		goto out;
+	}
+
+	root_namespace_dir = dir;
+out:
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+/**
+ * trace_namespace_add - adds a trace namespace to the system.
+ * @name: name of the namespace
+ *
+ * Adds a new trace namespace to the system. This can fail if the
+ * namespace already exists or internal errors within sub-systems registered
+ * for namespaces.
+ */
+int trace_namespace_add(const char *name)
+{
+	struct namespace_group *group;
+	int ret = 0;
+
+	mutex_lock(&event_mutex);
+
+	if (!root_namespace_dir) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* Ensure we don't already have this group */
+	group = namespace_group_find(name);
+
+	if (group) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	/* Create the group */
+	group = namespace_group_create(name);
+
+	if (!group) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Notify the systems of a new group */
+	ret = namespace_systems_create(group);
+
+	if (!ret)
+		list_add(&group->link, &namespace_groups);
+out:
+	/* Ensure we cleanup on failure */
+	if (ret && group)
+		namespace_group_destroy(group);
+
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+/**
+ * trace_namespace_remove - remove a trace namespace from the system.
+ * @name: name of the namespace
+ *
+ * Removes an existing trace namespace from the system. This can fail if
+ * the namespace doesn't exist, the namespace is busy, or internal errors
+ * within sub-systems registered for namespaces.
+ */
+int trace_namespace_remove(const char *name)
+{
+	struct namespace_group *group;
+	int ret = 0;
+
+	mutex_lock(&event_mutex);
+
+	if (!root_namespace_dir) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	group = namespace_group_find(name);
+
+	if (!group) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	if (refcount_read(&group->refcnt) != 1) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (namespace_systems_busy(group)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = namespace_systems_remove(group, -1);
+
+	if (!ret) {
+		list_del(&group->link);
+
+		namespace_group_destroy(group);
+	}
+
+out:
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
diff --git a/kernel/trace/trace_namespace.h b/kernel/trace/trace_namespace.h
new file mode 100644
index 000000000000..644e2d6c4802
--- /dev/null
+++ b/kernel/trace/trace_namespace.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_KERNEL_TRACE_NAMESPACE_H
+#define _LINUX_KERNEL_TRACE_NAMESPACE_H
+
+/**
+ * struct trace_namespace - Trace namespace information
+ *
+ * @name: Unique name of the namespace, can be used for event system names,
+ *  etc.
+ * @dir: Directory of the namespace, can be used for creating system files.
+ * @id: Id of the namespace, can be used for looking up associated data by
+ *  namespace. NOTE: 0 is reserved for non-namespace lookups for systems.
+ */
+struct trace_namespace {
+	const char *name;
+	struct dentry *dir;
+	int id;
+};
+
+/**
+ * struct trace_namespace_operations - Methods to run for each trace namespace
+ *
+ * These methods must be set for each system using trace namespaces.
+ *
+ * @create: Run when a trace namespace is being created. Systems create files
+ *  for the namespace with appropriate options. Return 0 if successful.
+ * @is_busy: Check whether the system is busy within the namespace. Return
+ *  true if it is busy, otherwise false.
+ * @remove: Removes the namespace from the system. Return 0 if successful,
+ *  return -ENOENT if the namespace is not within the system. All other return
+ *  values are treated as errors.
+ * @parse: Parses a command to configure a namespace. Return 0 if successful,
+ *  return -ECANCELED if the command is not for your system. All other return
+ *  values are treated as errors.
+ * @show: Shows the configured options for the namespace. This is run when a
+ *  user reads the options of the namespace.
+ *
+ * NOTE: These methods are called while holding event_mutex.
+ */
+struct trace_namespace_operations {
+	int (*create)(struct trace_namespace *ns);
+	int (*remove)(struct trace_namespace *ns);
+	int (*parse)(struct trace_namespace *ns, const char *command);
+	int (*show)(struct trace_namespace *ns, struct seq_file *m);
+	bool (*is_busy)(struct trace_namespace *ns);
+};
+
+int trace_namespace_register(struct trace_namespace_operations *ops);
+
+int trace_namespace_init(struct dentry *dir);
+
+int trace_namespace_add(const char *name);
+
+int trace_namespace_remove(const char *name);
+
+#endif /* _LINUX_KERNEL_TRACE_NAMESPACE_H */
-- 
2.25.1

