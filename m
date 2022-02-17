Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF60C4BA596
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242998AbiBQQUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:20:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242992AbiBQQUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:20:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B690273740
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:19:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D79CFB81F89
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A88C340EF;
        Thu, 17 Feb 2022 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645114786;
        bh=nSqATp1Okb9kyoRb4k6ZZfys2TemnjaMTSvROPMwD2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SwYfuVTBYG66dOXn/JQYGulvLKlz18T2XNcQQmSXNJ8kwb7xKPFwbJSu1n8phefgv
         sktxsJsbNEWOIymTSS4IHCBMR91wGdUYi10+WUEXXTxnZtvTAPsFCEpgiosU5Yjyw5
         8qiCHNAXyVWRfFQZlWDgpBYwaCUtSJciJQAfVWEOF5Kuso0cmXZjpNNc4G0MFkFtUo
         rXPlCOdTi5ncUhfZKAZK927rLgXZBwIxC8nvRd9WIt7yd3vFjW3GwNPjUWJfoU7no/
         T0i4sSE8KsAXLY+aBEQgfMUJixsKHdSxE+CMpEQx1GfPtqytLweMakX1w0TNqAXjEt
         6TbN0s6kTyTNg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     rientjes@google.com, xhao@linux.alibaba.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 1/4] mm/damon: Implement a sysfs-based DAMON user interface
Date:   Thu, 17 Feb 2022 16:19:35 +0000
Message-Id: <20220217161938.8874-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217161938.8874-1-sj@kernel.org>
References: <20220217161938.8874-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON's debugfs-based user interface served very well, so far.  However,
it unnecessarily depends on debugfs, while DAMON is not aimed to be used
for only debugging.  Also, the interface receives multiple values via
one file.  For example, schemes file receives 18 values.  As a result,
it is not only hard to be used, but also difficult to be extended.
Especially, keeping backward compatibility of user space tools is
getting only challenging.  It would be better to implement another
reliable and flexible interface and deprecate the debugfs interface in
long term.

For the reason, this commit implements a stub of a part of the
sysfs-based new user interface of DAMON.  Specifically, this commit
implements only the sysfs control part for virtual address space
monitoring.  Commits for linking with DAMON and support of more features
that debugfs is currently providing will follow.

The idea of the new interface is, using directory hierarchies and making
one file for one value.  For a short example, users can do the virtual
address monitoring via the interface as below:

    # cd /sys/kernel/mm/damon/admin/
    # echo 1 > kdamonds/nr
    # echo 1 > kdamonds/0/contexts/nr
    # echo vaddr > kdamonds/0/contexts/0/damon_type
    # echo 1 > kdamonds/0/contexts/0/targets/nr
    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid
    # echo on > kdamonds/0/state

Main difference between DAMON_DBGFS and DAMON_SYSFS
---------------------------------------------------

DAMON debugfs interface allows multiple monitoring contexts, but it asks
users to turn those all on and off at once.  It's not a big problem but
makes the operation a little bit complex.  DAMON_SYSFS allows users to
turn on and off monitoring contexts individually.

The Hierarchy
-------------

In a glance, the files hierarchy of the sysfs interface will look like
below.

    /sys/kernel/mm/damon/admin
    │ kdamonds
    │ │ nr
    │ │ 0/
    │ │ │ state,pid
    │ │ │ contexts
    │ │ │ │ nr
    │ │ │ │ 0/
    │ │ │ │ │ damon_type
    │ │ │ │ │ monitoring_attrs/
    │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
    │ │ │ │ │ │ nr_regions/min,max
    │ │ │ │ │ targets/
    │ │ │ │ │ │ nr
    │ │ │ │ │ │ 0/
    │ │ │ │ │ │ │ pid
    │ │ │ │ │ │ │ regions/
    │ │ │ │ │ │ │ │ nr
    │ │ │ │ │ │ │ │ 0/
    │ │ │ │ │ │ │ │ │ start,end
    │ │ │ │ │ │ │ │ ...
    │ │ │ │ │ │ ...
    │ │ │ │ │ ...
    │ │ ...

Root
----

The root of the DAMON sysfs is /sys/kernel/mm/damon/, and it has one
directory named 'admin'.  The directory contains the interface for
privileged user space programs.  User space tools or deamons having root
permission could use this directory.  In a future, sibling directories
for non-root user space tools or deamons (we could allow them to do
monitong of their own virtual address space) or control of in-kernel
DAMON-based deamons could be created.

kdamonds/
---------

The monitoring-related information including request specifications and
results are called DAMON context.  DAMON executes a set of the contexts
with a kernel thread called kdamond (for now, only one context per
kdamond is supported), and multiple kdamonds could run in parallel.
This directory has files for controlling the kdamonds.

In the beginning, this directory has only one file, 'nr'.  Writing a
number (`N`) to the file creates the number of child directories named
`0` to `N-1`.  Each directory represents each kdamond.

kdamonds/<N>/
-------------

In each kdamond directory, two files (`state` and `pid`) and one
directory (`contexts`) reside.

Reading `state` returns `on` if the kdamond is currently running, or
`off` if it is not running.  Writing `on` or `off` makes the kdamond be
in the state.  If the state is `on`, reading `pid` shows the pid of the
kdamond thread.

`contexts` directory resembles `kdamonds`.  It contains files for
controlling the monitoring contexts that this kdamond will execute.

kdamonds/<N>/contexts/
----------------------

In the beginning, this directory has only one file, 'nr'.  Writing a
number (`N`) to the file creates the number of child directories named
as `0` to `N-1`.  Each directory represents each monitoring context.  At
the moment, only one context per kdamond is supported, so only `0` or
`1` can be written to the file.

contexts/<N>/
-------------

In each context directory, one file (`operations`) and two directories
(`monitoring_attrs` and `targets`) reside.

DAMON supports multiple types of monitoring operations, including those
for virtual address space and physical address space.  You can set and
show what type of monitoring operations you want to use with the context
by writing one of below keywords to, and reading the file.

- vaddr: Monitor virtual address spaces of specific processes

Files for specifying attributes of the monitoring including required
quality and efficiency of the monitoring are in `monitoring_attrs`
directory, while files for specifying to what memory regions the
monitoring should be done are in `targets` directory.

contexts/<N>/monitoring_attrs/
------------------------------

In this directory, you can show two directories, `intervals` and
`nr_regions`.

Under `intervals` directory, three files for DAMON's sampling interval
(`sample_us`), aggregation interval (`aggr_us`) and update interval
(`update_us`) exist.  You can set and get the values by writing to and
reading from the files.

Under `nr_regions` directory, two files for the lower-bound and
upper-bound of DAMON's monitoring regions (`min` and `max`,
respectively), which controls the monitoring overhead, reside.  You can
set and get the values by writing to and rading from the files.

For more details about the intervals and monitoring regions range,
please read the Design document[1].

[1] https://docs.kernel.org/vm/damon/design.html

contexts/<N>/targets/
---------------------

In the beginning, this directory has only one file, 'nr'.  Writing a
number (`N`) to the file creates the number of child directories named
`0` to `N-1`.  Each directory represents each monitoring target.

targets/<N>/
------------

In each target directory, one file (`pid`) exists.

You can make the context to monitor the virtual address space of a
process by writing the pid of the process to the file, and show what
process's virtual address space the context is set to monitor by reading
the file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig  |    7 +
 mm/damon/Makefile |    1 +
 mm/damon/sysfs.c  | 1100 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1108 insertions(+)
 create mode 100644 mm/damon/sysfs.c

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 01bad77ad7ae..9b559c76d6dd 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -52,6 +52,13 @@ config DAMON_VADDR_KUNIT_TEST
 
 	  If unsure, say N.
 
+config DAMON_SYSFS
+	bool "DAMON sysfs interface"
+	depends on DAMON && SYSFS
+	help
+	  This builds the sysfs interface for DAMON.  The user space can use
+	  the interface for arbitrary data access monitoring.
+
 config DAMON_DBGFS
 	bool "DAMON debugfs interface"
 	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index 03931472991a..d7e316ab9eb7 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -4,4 +4,5 @@ obj-$(CONFIG_DAMON)		:= core.o
 obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
 obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
+obj-$(CONFIG_DAMON_SYSFS)	+= sysfs.o
 obj-$(CONFIG_DAMON_RECLAIM)	+= reclaim.o
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
new file mode 100644
index 000000000000..59bdc7268dc6
--- /dev/null
+++ b/mm/damon/sysfs.c
@@ -0,0 +1,1100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAMON sysfs Interface
+ *
+ * Copyright (c) 2022 SeongJae Park <sj@kernel.org>
+ */
+
+#include <linux/damon.h>
+#include <linux/kobject.h>
+#include <linux/pid.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+static DEFINE_MUTEX(damon_sysfs_lock);
+
+/*
+ * unsigned long range directory
+ */
+
+struct damon_sysfs_ul_range {
+	struct kobject kobj;
+	unsigned long min;
+	unsigned long max;
+};
+
+static struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
+		unsigned long min,
+		unsigned long max)
+{
+	struct damon_sysfs_ul_range *range = kmalloc(sizeof(*range),
+			GFP_KERNEL);
+
+	if (!range)
+		return NULL;
+	range->kobj = (struct kobject){};
+	range->min = min;
+	range->max = max;
+
+	return range;
+}
+
+static ssize_t damon_sysfs_ul_range_min_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+
+	return sysfs_emit(buf, "%lu\n", range->min);
+}
+
+static ssize_t damon_sysfs_ul_range_min_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+	unsigned long min;
+	int err;
+
+	err = kstrtoul(buf, 0, &min);
+	if (err)
+		return -EINVAL;
+
+	range->min = min;
+	return count;
+}
+
+static ssize_t damon_sysfs_ul_range_max_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+
+	return sysfs_emit(buf, "%lu\n", range->max);
+}
+
+static ssize_t damon_sysfs_ul_range_max_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+	unsigned long max;
+	int err;
+
+	err = kstrtoul(buf, 0, &max);
+	if (err)
+		return -EINVAL;
+
+	range->max = max;
+	return count;
+}
+
+static void damon_sysfs_ul_range_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_ul_range, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_ul_range_min_attr =
+		__ATTR(min, 0600, damon_sysfs_ul_range_min_show,
+				damon_sysfs_ul_range_min_store);
+
+static struct kobj_attribute damon_sysfs_ul_range_max_attr =
+		__ATTR(max, 0600, damon_sysfs_ul_range_max_show,
+				damon_sysfs_ul_range_max_store);
+
+static struct attribute *damon_sysfs_ul_range_attrs[] = {
+	&damon_sysfs_ul_range_min_attr.attr,
+	&damon_sysfs_ul_range_max_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_ul_range);
+
+static struct kobj_type damon_sysfs_ul_range_ktype = {
+	.release = damon_sysfs_ul_range_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_ul_range_groups,
+};
+
+/*
+ * target directory
+ */
+
+struct damon_sysfs_target {
+	struct kobject kobj;
+	int pid;
+};
+
+static struct damon_sysfs_target *damon_sysfs_target_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_target), GFP_KERNEL);
+}
+
+static ssize_t damon_sysfs_target_pid_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_target *target = container_of(kobj,
+			struct damon_sysfs_target, kobj);
+
+	return sysfs_emit(buf, "%d\n", target->pid);
+}
+
+static ssize_t damon_sysfs_target_pid_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_target *target = container_of(kobj,
+			struct damon_sysfs_target, kobj);
+	int err = kstrtoint(buf, 0, &target->pid);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static void damon_sysfs_target_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_target, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_target_pid_attr = __ATTR(pid, 0600,
+		damon_sysfs_target_pid_show, damon_sysfs_target_pid_store);
+
+static struct attribute *damon_sysfs_target_attrs[] = {
+	&damon_sysfs_target_pid_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_target);
+
+static struct kobj_type damon_sysfs_target_ktype = {
+	.release = damon_sysfs_target_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_target_groups,
+};
+
+/*
+ * targets directory
+ */
+
+struct damon_sysfs_targets {
+	struct kobject kobj;
+	struct damon_sysfs_target **targets_arr;
+	int nr_targets;
+};
+
+static struct damon_sysfs_targets *damon_sysfs_targets_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_targets), GFP_KERNEL);
+}
+
+static void damon_sysfs_targets_rm_dirs(struct damon_sysfs_targets *targets)
+{
+	struct damon_sysfs_target **targets_arr = targets->targets_arr;
+	int i;
+
+	for (i = 0; i < targets->nr_targets; i++)
+		kobject_put(&targets_arr[i]->kobj);
+	kfree(targets_arr);
+	targets->targets_arr = NULL;
+	targets->nr_targets = 0;
+}
+
+static int damon_sysfs_targets_add_dirs(struct damon_sysfs_targets *targets,
+		int nr_targets)
+{
+	struct damon_sysfs_target **targets_arr, *target;
+	int err, i;
+
+	damon_sysfs_targets_rm_dirs(targets);
+	if (!nr_targets)
+		return 0;
+
+	targets_arr = kmalloc_array(nr_targets, sizeof(*targets_arr),
+			GFP_KERNEL);
+	if (!targets_arr)
+		return -ENOMEM;
+	targets->targets_arr = targets_arr;
+
+	for (i = 0; i < nr_targets; i++) {
+		target = damon_sysfs_target_alloc();
+		if (!target) {
+			damon_sysfs_targets_rm_dirs(targets);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&target->kobj,
+				&damon_sysfs_target_ktype, &targets->kobj,
+				"%d", i);
+		if (err) {
+			kfree(target);
+			damon_sysfs_targets_rm_dirs(targets);
+			return err;
+		}
+
+		targets_arr[i] = target;
+		targets->nr_targets++;
+	}
+	return 0;
+}
+
+static ssize_t damon_sysfs_targets_nr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_targets *targets = container_of(kobj,
+			struct damon_sysfs_targets, kobj);
+
+	return sysfs_emit(buf, "%d\n", targets->nr_targets);
+}
+
+static ssize_t damon_sysfs_targets_nr_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_targets *targets = container_of(kobj,
+			struct damon_sysfs_targets, kobj);
+	int nr;
+	int err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_targets_add_dirs(targets, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static void damon_sysfs_targets_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_targets, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_targets_nr_attr = __ATTR(nr, 0600,
+		damon_sysfs_targets_nr_show, damon_sysfs_targets_nr_store);
+
+static struct attribute *damon_sysfs_targets_attrs[] = {
+	&damon_sysfs_targets_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_targets);
+
+static struct kobj_type damon_sysfs_targets_ktype = {
+	.release = damon_sysfs_targets_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_targets_groups,
+};
+
+/*
+ * intervals directory
+ */
+
+struct damon_sysfs_intervals {
+	struct kobject kobj;
+	unsigned long sample_us;
+	unsigned long aggr_us;
+	unsigned long update_us;
+};
+
+static struct damon_sysfs_intervals *damon_sysfs_intervals_alloc(
+		unsigned long sample_us, unsigned long aggr_us,
+		unsigned long update_us)
+{
+	struct damon_sysfs_intervals *intervals = kmalloc(sizeof(*intervals),
+			GFP_KERNEL);
+
+	if (!intervals)
+		return NULL;
+
+	intervals->kobj = (struct kobject){};
+	intervals->sample_us = sample_us;
+	intervals->aggr_us = aggr_us;
+	intervals->update_us = update_us;
+	return intervals;
+}
+
+static ssize_t damon_sysfs_intervals_sample_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals *intervals = container_of(kobj,
+			struct damon_sysfs_intervals, kobj);
+
+	return sysfs_emit(buf, "%lu\n", intervals->sample_us);
+}
+
+static ssize_t damon_sysfs_intervals_sample_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals *intervals = container_of(kobj,
+			struct damon_sysfs_intervals, kobj);
+	unsigned long us;
+	int err = kstrtoul(buf, 0, &us);
+
+	if (err)
+		return -EINVAL;
+
+	intervals->sample_us = us;
+	return count;
+}
+
+static ssize_t damon_sysfs_intervals_aggr_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals *intervals = container_of(kobj,
+			struct damon_sysfs_intervals, kobj);
+
+	return sysfs_emit(buf, "%lu\n", intervals->aggr_us);
+}
+
+static ssize_t damon_sysfs_intervals_aggr_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals *intervals = container_of(kobj,
+			struct damon_sysfs_intervals, kobj);
+	unsigned long us;
+	int err = kstrtoul(buf, 0, &us);
+
+	if (err)
+		return -EINVAL;
+
+	intervals->aggr_us = us;
+	return count;
+}
+
+static ssize_t damon_sysfs_intervals_update_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals *intervals = container_of(kobj,
+			struct damon_sysfs_intervals, kobj);
+
+	return sysfs_emit(buf, "%lu\n", intervals->update_us);
+}
+
+static ssize_t damon_sysfs_intervals_update_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals *intervals = container_of(kobj,
+			struct damon_sysfs_intervals, kobj);
+	unsigned long us;
+	int err = kstrtoul(buf, 0, &us);
+
+	if (err)
+		return -EINVAL;
+
+	intervals->update_us = us;
+	return count;
+}
+
+static void damon_sysfs_intervals_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_intervals, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_intervals_sample_us_attr =
+		__ATTR(sample_us, 0600,
+				damon_sysfs_intervals_sample_us_show,
+				damon_sysfs_intervals_sample_us_store);
+
+static struct kobj_attribute damon_sysfs_intervals_aggr_us_attr =
+		__ATTR(aggr_us, 0600,
+				damon_sysfs_intervals_aggr_us_show,
+				damon_sysfs_intervals_aggr_us_store);
+
+static struct kobj_attribute damon_sysfs_intervals_update_us_attr =
+		__ATTR(update_us, 0600,
+				damon_sysfs_intervals_update_us_show,
+				damon_sysfs_intervals_update_us_store);
+
+static struct attribute *damon_sysfs_intervals_attrs[] = {
+	&damon_sysfs_intervals_sample_us_attr.attr,
+	&damon_sysfs_intervals_aggr_us_attr.attr,
+	&damon_sysfs_intervals_update_us_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_intervals);
+
+static struct kobj_type damon_sysfs_intervals_ktype = {
+	.release = damon_sysfs_intervals_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_intervals_groups,
+};
+
+/*
+ * monitoring_attrs directory
+ */
+
+struct damon_sysfs_attrs {
+	struct kobject kobj;
+	struct damon_sysfs_intervals *intervals;
+	struct damon_sysfs_ul_range *nr_regions;
+};
+
+static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
+{
+	struct damon_sysfs_attrs *attrs = kmalloc(sizeof(*attrs), GFP_KERNEL);
+
+	if (!attrs)
+		return NULL;
+	attrs->kobj = (struct kobject){};
+	return attrs;
+}
+
+static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
+{
+	struct damon_sysfs_intervals *intervals;
+	struct damon_sysfs_ul_range *nr_regions_range;
+	int err;
+
+	intervals = damon_sysfs_intervals_alloc(5000, 100000, 60000000);
+	if (!intervals)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(&intervals->kobj,
+			&damon_sysfs_intervals_ktype, &attrs->kobj,
+			"intervals");
+	if (err) {
+		kfree(intervals);
+		return err;
+	}
+	attrs->intervals = intervals;
+
+	nr_regions_range = damon_sysfs_ul_range_alloc(10, 1000);
+	if (!nr_regions_range)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(&nr_regions_range->kobj,
+			&damon_sysfs_ul_range_ktype, &attrs->kobj,
+			"nr_regions");
+	if (err) {
+		kfree(nr_regions_range);
+		kobject_put(&intervals->kobj);
+		return err;
+	}
+	attrs->nr_regions = nr_regions_range;
+
+	return 0;
+}
+
+static void damon_sysfs_attrs_rm_dirs(struct damon_sysfs_attrs *attrs)
+{
+	kobject_put(&attrs->nr_regions->kobj);
+	kobject_put(&attrs->intervals->kobj);
+}
+
+static void damon_sysfs_attrs_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_attrs, kobj));
+}
+
+static struct attribute *damon_sysfs_attrs_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_attrs);
+
+static struct kobj_type damon_sysfs_attrs_ktype = {
+	.release = damon_sysfs_attrs_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_attrs_groups,
+};
+
+/*
+ * context directory
+ */
+
+static const char * const damon_sysfs_ops_strs[] = {
+	"vaddr\n",
+	"paddr\n",
+};
+
+struct damon_sysfs_context {
+	struct kobject kobj;
+	enum damon_ops_id ops_id;
+	struct damon_sysfs_attrs *attrs;
+	struct damon_sysfs_targets *targets;
+};
+
+static struct damon_sysfs_context *damon_sysfs_context_alloc(
+		enum damon_ops_id ops_id)
+{
+	struct damon_sysfs_context *context = kmalloc(sizeof(*context),
+				GFP_KERNEL);
+
+	if (!context)
+		return NULL;
+	context->kobj = (struct kobject){};
+	context->ops_id = ops_id;
+	return context;
+}
+
+static int damon_sysfs_context_add_dirs(struct damon_sysfs_context *context)
+{
+	struct damon_sysfs_attrs *attrs;
+	struct damon_sysfs_targets *targets;
+	int err;
+
+	/* add monitoring_attrs directory */
+	attrs = damon_sysfs_attrs_alloc();
+	if (!attrs)
+		return -ENOMEM;
+	err = kobject_init_and_add(&attrs->kobj, &damon_sysfs_attrs_ktype,
+			&context->kobj, "monitoring_attrs");
+	if (err) {
+		kfree(attrs);
+		return err;
+	}
+	err = damon_sysfs_attrs_add_dirs(attrs);
+	if (err)
+		goto put_attrs_out;
+
+	/* add targets directory */
+	targets = damon_sysfs_targets_alloc();
+	if (!targets) {
+		err = -ENOMEM;
+		goto put_attrs_out;
+	}
+	err = kobject_init_and_add(&targets->kobj, &damon_sysfs_targets_ktype,
+			&context->kobj, "targets");
+	if (err) {
+		kfree(targets);
+		goto put_attrs_out;
+	}
+
+	context->attrs = attrs;
+	context->targets = targets;
+	return err;
+
+put_attrs_out:
+	kobject_put(&attrs->kobj);
+	return err;
+}
+
+static void damon_sysfs_context_rm_dirs(struct damon_sysfs_context *context)
+{
+	damon_sysfs_attrs_rm_dirs(context->attrs);
+	kobject_put(&context->attrs->kobj);
+	damon_sysfs_targets_rm_dirs(context->targets);
+	kobject_put(&context->targets->kobj);
+}
+
+static ssize_t damon_sysfs_context_operations_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_context *context = container_of(kobj,
+			struct damon_sysfs_context, kobj);
+
+	return sysfs_emit(buf, "%s\n", damon_sysfs_ops_strs[context->ops_id]);
+}
+
+static ssize_t damon_sysfs_context_operations_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_context *context = container_of(kobj,
+			struct damon_sysfs_context, kobj);
+
+	if (!strncmp(buf, damon_sysfs_ops_strs[DAMON_OPS_VADDR], count))
+		context->ops_id = DAMON_OPS_VADDR;
+	else if (!strncmp(buf, damon_sysfs_ops_strs[DAMON_OPS_PADDR], count))
+		context->ops_id = DAMON_OPS_PADDR;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static void damon_sysfs_context_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_context, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_context_operations_attr = __ATTR(
+		operations, 0600, damon_sysfs_context_operations_show,
+		damon_sysfs_context_operations_store);
+
+static struct attribute *damon_sysfs_context_attrs[] = {
+	&damon_sysfs_context_operations_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_context);
+
+static struct kobj_type damon_sysfs_context_ktype = {
+	.release = damon_sysfs_context_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_context_groups,
+};
+
+/*
+ * contexts directory
+ */
+
+struct damon_sysfs_contexts {
+	struct kobject kobj;
+	struct damon_sysfs_context **contexts_arr;
+	int nr;
+};
+
+static struct damon_sysfs_contexts *damon_sysfs_contexts_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_contexts), GFP_KERNEL);
+}
+
+static void damon_sysfs_contexts_rm_dirs(struct damon_sysfs_contexts *contexts)
+{
+	struct damon_sysfs_context **contexts_arr = contexts->contexts_arr;
+	int i;
+
+	for (i = 0; i < contexts->nr; i++) {
+		damon_sysfs_context_rm_dirs(contexts_arr[i]);
+		kobject_put(&contexts_arr[i]->kobj);
+	}
+	kfree(contexts_arr);
+	contexts->contexts_arr = NULL;
+	contexts->nr = 0;
+}
+
+static int damon_sysfs_contexts_add_dirs(struct damon_sysfs_contexts *contexts,
+		int nr_contexts)
+{
+	struct damon_sysfs_context **contexts_arr, *context;
+	int err, i;
+
+	damon_sysfs_contexts_rm_dirs(contexts);
+	if (!nr_contexts)
+		return 0;
+
+	contexts_arr = kmalloc_array(nr_contexts, sizeof(*contexts_arr),
+			GFP_KERNEL);
+	if (!contexts_arr)
+		return -ENOMEM;
+	contexts->contexts_arr = contexts_arr;
+
+	for (i = 0; i < nr_contexts; i++) {
+		context = damon_sysfs_context_alloc(DAMON_OPS_VADDR);
+		if (!context) {
+			damon_sysfs_contexts_rm_dirs(contexts);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&context->kobj,
+				&damon_sysfs_context_ktype, &contexts->kobj,
+				"%d", i);
+		if (err) {
+			kfree(context);
+			damon_sysfs_contexts_rm_dirs(contexts);
+			return err;
+		}
+
+		err = damon_sysfs_context_add_dirs(context);
+		if (err) {
+			kobject_put(&context->kobj);
+			damon_sysfs_contexts_rm_dirs(contexts);
+			return err;
+		}
+
+		contexts_arr[i] = context;
+		contexts->nr++;
+	}
+	return 0;
+}
+
+static ssize_t damon_sysfs_contexts_nr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_contexts *contexts = container_of(kobj,
+			struct damon_sysfs_contexts, kobj);
+
+	return sysfs_emit(buf, "%d\n", contexts->nr);
+}
+
+static ssize_t damon_sysfs_contexts_nr_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_contexts *contexts = container_of(kobj,
+			struct damon_sysfs_contexts, kobj);
+	int nr, err;
+
+	err = kstrtoint(buf, 0, &nr);
+	if (err)
+		return err;
+	if (nr < 0 || 1 < nr)
+		return -EINVAL;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_contexts_add_dirs(contexts, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static void damon_sysfs_contexts_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_contexts, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_contexts_nr_attr = __ATTR(nr, 0600,
+		damon_sysfs_contexts_nr_show, damon_sysfs_contexts_nr_store);
+
+static struct attribute *damon_sysfs_contexts_attrs[] = {
+	&damon_sysfs_contexts_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_contexts);
+
+static struct kobj_type damon_sysfs_contexts_ktype = {
+	.release = damon_sysfs_contexts_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_contexts_groups,
+};
+
+/*
+ * kdamond directory
+ */
+
+struct damon_sysfs_kdamond {
+	struct kobject kobj;
+	struct damon_sysfs_contexts *contexts;
+	int pid;
+	struct damon_ctx *damon_ctx;
+};
+
+static struct damon_sysfs_kdamond *damon_sysfs_kdamond_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_kdamond), GFP_KERNEL);
+}
+
+static int damon_sysfs_kdamond_add_dirs(struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_sysfs_contexts *contexts;
+	int err;
+
+	contexts = damon_sysfs_contexts_alloc();
+	if (!contexts)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(&contexts->kobj,
+			&damon_sysfs_contexts_ktype, &kdamond->kobj,
+			"contexts");
+	if (err) {
+		kfree(contexts);
+		return err;
+	}
+	kdamond->contexts = contexts;
+
+	return err;
+}
+
+static void damon_sysfs_kdamond_rm_dirs(struct damon_sysfs_kdamond *kdamond)
+{
+	damon_sysfs_contexts_rm_dirs(kdamond->contexts);
+	kobject_put(&kdamond->contexts->kobj);
+}
+
+static ssize_t damon_sysfs_kdamond_state_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	/* TODO: Link with DAMON */
+	return sysfs_emit(buf, "off\n");
+}
+
+static ssize_t damon_sysfs_kdamond_state_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	/* TODO: Link with DAMON */
+	return count;
+}
+
+static ssize_t damon_sysfs_kdamond_pid_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+	struct damon_ctx *ctx;
+	int pid;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	ctx = kdamond->damon_ctx;
+	if (!ctx) {
+		pid = -1;
+		goto out;
+	}
+	mutex_lock(&ctx->kdamond_lock);
+	if (!ctx->kdamond) {
+		pid = -1;
+		goto unlock_kdamond_lock_out;
+	}
+	pid = ctx->kdamond->pid;
+
+unlock_kdamond_lock_out:
+	mutex_unlock(&ctx->kdamond_lock);
+out:
+	mutex_unlock(&damon_sysfs_lock);
+	return sysfs_emit(buf, "%d\n", pid);
+}
+
+static void damon_sysfs_kdamond_release(struct kobject *kobj)
+{
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+
+	if (kdamond->damon_ctx)
+		damon_destroy_ctx(kdamond->damon_ctx);
+	kfree(container_of(kobj, struct damon_sysfs_kdamond, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_kdamond_state_attr =
+	__ATTR(state, 0600, damon_sysfs_kdamond_state_show,
+		damon_sysfs_kdamond_state_store);
+
+static struct kobj_attribute damon_sysfs_kdamond_pid_attr = __ATTR(pid, 0400,
+		damon_sysfs_kdamond_pid_show, NULL);
+
+static struct attribute *damon_sysfs_kdamond_attrs[] = {
+	&damon_sysfs_kdamond_state_attr.attr,
+	&damon_sysfs_kdamond_pid_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_kdamond);
+
+static struct kobj_type damon_sysfs_kdamond_ktype = {
+	.release = damon_sysfs_kdamond_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_kdamond_groups,
+};
+
+/*
+ * kdamonds directory
+ */
+
+struct damon_sysfs_kdamonds {
+	struct kobject kobj;
+	struct damon_sysfs_kdamond **kdamonds_arr;
+	int nr;
+};
+
+static struct damon_sysfs_kdamonds *damon_sysfs_kdamonds_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_kdamonds), GFP_KERNEL);
+}
+
+static void damon_sysfs_kdamonds_rm_dirs(struct damon_sysfs_kdamonds *kdamonds)
+{
+	struct damon_sysfs_kdamond **kdamonds_arr = kdamonds->kdamonds_arr;
+	int i;
+
+	for (i = 0; i < kdamonds->nr; i++) {
+		damon_sysfs_kdamond_rm_dirs(kdamonds_arr[i]);
+		kobject_put(&kdamonds_arr[i]->kobj);
+	}
+	kfree(kdamonds_arr);
+	kdamonds->kdamonds_arr = NULL;
+	kdamonds->nr = 0;
+}
+
+int damon_sysfs_nr_running_ctxs(struct damon_sysfs_kdamond **kdamonds,
+		int nr_kdamonds)
+{
+	int nr_running_ctxs = 0;
+	int i;
+
+	for (i = 0; i < nr_kdamonds; i++) {
+		struct damon_ctx *ctx;
+
+		ctx = kdamonds[i]->damon_ctx;
+		if (!ctx)
+			continue;
+		mutex_lock(&ctx->kdamond_lock);
+		if (ctx->kdamond)
+			nr_running_ctxs++;
+		mutex_unlock(&ctx->kdamond_lock);
+	}
+	return nr_running_ctxs;
+}
+
+static int damon_sysfs_kdamonds_add_dirs(struct damon_sysfs_kdamonds *kdamonds,
+		int nr_kdamonds)
+{
+	struct damon_sysfs_kdamond **kdamonds_arr, *kdamond;
+	int err, i;
+
+	if (damon_sysfs_nr_running_ctxs(kdamonds->kdamonds_arr, kdamonds->nr))
+		return -EBUSY;
+
+	damon_sysfs_kdamonds_rm_dirs(kdamonds);
+	if (!nr_kdamonds)
+		return 0;
+
+	kdamonds_arr = kmalloc_array(nr_kdamonds, sizeof(*kdamonds_arr),
+			GFP_KERNEL);
+	if (!kdamonds_arr)
+		return -ENOMEM;
+	kdamonds->kdamonds_arr = kdamonds_arr;
+
+	for (i = 0; i < nr_kdamonds; i++) {
+		kdamond = damon_sysfs_kdamond_alloc();
+		if (!kdamond) {
+			damon_sysfs_kdamonds_rm_dirs(kdamonds);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&kdamond->kobj,
+				&damon_sysfs_kdamond_ktype, &kdamonds->kobj,
+				"%d", i);
+		if (err) {
+			damon_sysfs_kdamonds_rm_dirs(kdamonds);
+			kfree(kdamond);
+			return err;
+		}
+
+		err = damon_sysfs_kdamond_add_dirs(kdamond);
+		if (err) {
+			kobject_put(&kdamond->kobj);
+			damon_sysfs_kdamonds_rm_dirs(kdamonds);
+			return err;
+		}
+
+		kdamonds_arr[i] = kdamond;
+		kdamonds->nr++;
+	}
+	return 0;
+}
+
+static ssize_t damon_sysfs_kdamonds_nr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_kdamonds *kdamonds = container_of(kobj,
+			struct damon_sysfs_kdamonds, kobj);
+
+	return sysfs_emit(buf, "%d\n", kdamonds->nr);
+}
+
+static ssize_t damon_sysfs_kdamonds_nr_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_kdamonds *kdamonds = container_of(kobj,
+			struct damon_sysfs_kdamonds, kobj);
+	int nr, err;
+
+	err = kstrtoint(buf, 0, &nr);
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_kdamonds_add_dirs(kdamonds, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static void damon_sysfs_kdamonds_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_kdamonds, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_kdamonds_nr_attr = __ATTR(nr, 0600,
+		damon_sysfs_kdamonds_nr_show, damon_sysfs_kdamonds_nr_store);
+
+static struct attribute *damon_sysfs_kdamonds_attrs[] = {
+	&damon_sysfs_kdamonds_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_kdamonds);
+
+static struct kobj_type damon_sysfs_kdamonds_ktype = {
+	.release = damon_sysfs_kdamonds_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_kdamonds_groups,
+};
+
+/*
+ * damon user interface directory
+ */
+
+struct damon_sysfs_ui_dir {
+	struct kobject kobj;
+	struct damon_sysfs_kdamonds *kdamonds;
+};
+
+static struct damon_sysfs_ui_dir *damon_sysfs_ui_dir_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_ui_dir), GFP_KERNEL);
+}
+
+static int damon_sysfs_ui_dir_add_dirs(struct damon_sysfs_ui_dir *ui_dir)
+{
+	struct damon_sysfs_kdamonds *kdamonds;
+	int err;
+
+	kdamonds = damon_sysfs_kdamonds_alloc();
+	if (!kdamonds)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(&kdamonds->kobj,
+			&damon_sysfs_kdamonds_ktype, &ui_dir->kobj,
+			"kdamonds");
+	if (err) {
+		kfree(kdamonds);
+		return err;
+	}
+	ui_dir->kdamonds = kdamonds;
+	return err;
+}
+
+static void damon_sysfs_ui_dir_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_ui_dir, kobj));
+}
+
+static struct attribute *damon_sysfs_ui_dir_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_ui_dir);
+
+static struct kobj_type damon_sysfs_ui_dir_ktype = {
+	.release = damon_sysfs_ui_dir_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_ui_dir_groups,
+};
+
+static int __init damon_sysfs_init(void)
+{
+	struct kobject *damon_sysfs_root;
+	struct damon_sysfs_ui_dir *admin;
+	int err;
+
+	damon_sysfs_root = kobject_create_and_add("damon", mm_kobj);
+	if (!damon_sysfs_root)
+		return -ENOMEM;
+
+	admin = damon_sysfs_ui_dir_alloc();
+	if (!admin) {
+		kobject_put(damon_sysfs_root);
+		return -ENOMEM;
+	}
+	err = kobject_init_and_add(&admin->kobj, &damon_sysfs_ui_dir_ktype,
+			damon_sysfs_root, "admin");
+	if (err) {
+		kobject_put(&admin->kobj);
+		kobject_put(damon_sysfs_root);
+		return err;
+	}
+
+	err = damon_sysfs_ui_dir_add_dirs(admin);
+	if (err) {
+		kobject_put(&admin->kobj);
+		kobject_put(damon_sysfs_root);
+		return err;
+	}
+
+	return 0;
+}
+subsys_initcall(damon_sysfs_init);
-- 
2.17.1

