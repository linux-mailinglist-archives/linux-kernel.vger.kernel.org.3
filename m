Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EC849AD91
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444609AbiAYHZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:25:37 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47]:58051 "EHLO
        esa1.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1443900AbiAYHVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:21:50 -0500
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 02:21:42 EST
IronPort-SDR: Tt5KRiiNzwRLEImD11muCHZO8uJGCcRjIgpU3Rwcryhj7nP7t6x0HRskhPamZinmuHd4Kjgg/u
 8lu6ru5ztH3x/K+CV1Dtw9jFea2j59LvPJuvqT6AgWtXZJEizCE8ZaFOsSXrdIQ+pzFSUHKQoG
 CAMdFqum2rAu8PVLkULQLmLsxIQ0/GbhN1oEoOgjJ/lkU1xMpNN8mB/rwuegN5h3HVDVdVRnli
 2zJnUdlA9A+FZj3w26BPW25+MeCwI4MZYDgQRGCFl7jS0hmGRFWqf0S7+5lSYU6T3LRuxvY0HM
 ff1Q+xnzfH3Ak4kM2r6ncq3m
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="60525454"
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; 
   d="scan'208";a="60525454"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Jan 2022 16:14:12 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4D1FAE3E10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:11 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6E565EA178
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:10 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 357744007ED6C;
        Tue, 25 Jan 2022 16:14:10 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH 1/8] drivers: base: Add hardware prefetch control core driver
Date:   Tue, 25 Jan 2022 16:14:07 +0900
Message-Id: <20220125071414.811344-2-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver provides a register/unregister function to create the
sysfs interface with an attribute file named "prefetch_control" in
every CPU's cache/index[0,2] directory.

If the architecture has control of the CPU's hardware prefetcher
behavior, use this function to create sysfs. When registering, it is
necessary to provide what type of hardware prefetcher is supported
and how to read/write to the register.

Following patches add support for ARM64 and x86.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 drivers/base/pfctl.c  | 541 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pfctl.h |  42 ++++
 2 files changed, 583 insertions(+)
 create mode 100644 drivers/base/pfctl.c
 create mode 100644 include/linux/pfctl.h

diff --git a/drivers/base/pfctl.c b/drivers/base/pfctl.c
new file mode 100644
index 000000000000..4bc3c2826d69
--- /dev/null
+++ b/drivers/base/pfctl.c
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 FUJITSU LIMITED
+ *
+ * This driver provides tunable sysfs interface for Hardware Prefetch Control.
+ * See Documentation/ABI/testing/sysfs-devices-system-cpu for more information.
+ *
+ * This code provides architecture-independent functions such as create and
+ * remove attribute file.
+ * The implementation of reads and writes to the Hardware Prefetch Control
+ * register is architecture-dependent. Therefore, each architecture register
+ * a callback to read and write the register via pfctl_register_driver().
+ */
+
+#include <linux/cacheinfo.h>
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/pfctl.h>
+#include <linux/parser.h>
+#include <linux/slab.h>
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+enum {
+	OPT_HWPF_ENABLE,
+	OPT_IPPF_ENABLE,
+	OPT_ACLPF_ENABLE,
+	OPT_SDPF_ENABLE,
+	OPT_SDPF_DIST,
+	OPT_SDPF_DIST_AUTO,
+	OPT_SDPF_STRONG,
+	OPT_ERR,
+};
+
+static const char hwpf_enable_fmt[]	= "hardware_prefetcher_enable=%s";
+static const char ippf_enable_fmt[]	= "ip_prefetcher_enable=%s";
+static const char aclpf_enable_fmt[]	=
+	"adjacent_cache_line_prefetcher_enable=%s";
+static const char sdpf_enable_fmt[]	= "stream_detect_prefetcher_enable=%s";
+static const char sdpf_dist_fmt[]	= "stream_detect_prefetcher_dist=%d";
+static const char sdpf_dist_auto_fmt[]	= "stream_detect_prefetcher_dist=%s";
+static const char sdpf_strong_fmt[]	= "stream_detect_prefetcher_strong=%s";
+
+static const match_table_t pfctl_opt_tokens = {
+	{OPT_HWPF_ENABLE,	hwpf_enable_fmt},
+	{OPT_IPPF_ENABLE,	ippf_enable_fmt},
+	{OPT_ACLPF_ENABLE,	aclpf_enable_fmt},
+	{OPT_SDPF_ENABLE,	sdpf_enable_fmt},
+	{OPT_SDPF_DIST,		sdpf_dist_fmt},
+	{OPT_SDPF_DIST_AUTO,	sdpf_dist_auto_fmt},
+	{OPT_SDPF_STRONG,	sdpf_strong_fmt},
+	{OPT_ERR,		NULL},
+};
+
+static DEFINE_PER_CPU(struct device *, cache_device_pcpu);
+#define per_cpu_cache_device(cpu) (per_cpu(cache_device_pcpu, cpu))
+
+struct pfctl_driver *pdriver;
+enum cpuhp_state hp_online;
+
+static bool prefetcher_is_available(unsigned int level, enum cache_type type,
+				    int prefetcher)
+{
+	if ((level == 1) && (type == CACHE_TYPE_DATA))
+		if (pdriver->supported_l1d_prefetcher & prefetcher)
+			return true;
+		else
+			return false;
+	else if ((level == 2) &&
+		 (type == CACHE_TYPE_UNIFIED))
+		if (pdriver->supported_l2_prefetcher & prefetcher)
+			return true;
+		else
+			return false;
+	else
+		return false;
+}
+
+static int parse_prefetch_options(struct prefetcher_options *opts,
+				  const char *buf, unsigned int level,
+				  enum cache_type type)
+{
+	char *options, *sep_opt, *p;
+	substring_t args[MAX_OPT_ARGS];
+	int opt_mask = 0;
+	int token;
+	int ret = 0;
+
+	options = kstrdup(buf, GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	sep_opt = strstrip(options);
+	while ((p = strsep(&sep_opt, " ")) != NULL) {
+		unsigned int val;
+
+		if (!*p)
+			continue;
+
+		token = match_token(p, pfctl_opt_tokens, args);
+		opt_mask |= token;
+
+		switch (token) {
+		case OPT_HWPF_ENABLE:
+			if (!prefetcher_is_available(level, type, HWPF)) {
+				pr_err("Unsupported parameter: '%s'\n", p);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			if (!strcmp(p, "enable")) {
+				opts->hwpf_enable = PFCTL_ENABLE_VAL;
+			} else if (!strcmp(p, "disable")) {
+				opts->hwpf_enable = PFCTL_DISABLE_VAL;
+			} else {
+				pr_err("Invalid value: '%s'\n", p);
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+
+			kfree(p);
+			break;
+		case OPT_IPPF_ENABLE:
+			if (!prefetcher_is_available(level, type, IPPF)) {
+				pr_err("Unsupported parameter: '%s'\n", p);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			if (!strcmp(p, "enable")) {
+				opts->ippf_enable = PFCTL_ENABLE_VAL;
+			} else if (!strcmp(p, "disable")) {
+				opts->ippf_enable = PFCTL_DISABLE_VAL;
+			} else {
+				pr_err("Invalid value: '%s'\n", p);
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+
+			kfree(p);
+			break;
+		case OPT_ACLPF_ENABLE:
+			if (!prefetcher_is_available(level, type, ACLPF)) {
+				pr_err("Unsupported parameter: '%s'\n", p);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			if (!strcmp(p, "enable")) {
+				opts->aclpf_enable = PFCTL_ENABLE_VAL;
+			} else if (!strcmp(p, "disable")) {
+				opts->aclpf_enable = PFCTL_DISABLE_VAL;
+			} else {
+				pr_err("Invalid value: '%s'\n", p);
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+
+			kfree(p);
+			break;
+		case OPT_SDPF_ENABLE:
+			if (!prefetcher_is_available(level, type, SDPF)) {
+				pr_err("Unsupported parameter: '%s'\n", p);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			if (!strcmp(p, "enable")) {
+				opts->sdpf_enable = PFCTL_ENABLE_VAL;
+			} else if (!strcmp(p, "disable")) {
+				opts->sdpf_enable = PFCTL_DISABLE_VAL;
+			} else {
+				pr_err("Invalid value: '%s'\n", p);
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+
+			kfree(p);
+			break;
+		case OPT_SDPF_DIST:
+			if (!prefetcher_is_available(level, type, SDPF)) {
+				pr_err("Unsupported parameter: '%s'\n", p);
+				ret = -EINVAL;
+				goto out;
+			}
+			ret = match_uint(args, &val);
+			if (ret < 0) {
+				pr_err("Invalid value: '%s'\n", p);
+				goto out;
+			}
+
+			opts->sdpf_dist = val;
+			break;
+		case OPT_SDPF_DIST_AUTO:
+			if (!prefetcher_is_available(level, type, SDPF)) {
+				pr_err("Unsupported parameter: '%s'\n", p);
+				ret = -EINVAL;
+				goto out;
+			}
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			if (!strcmp(p, "auto")) {
+				opts->sdpf_dist = PFCTL_DIST_AUTO_VAL;
+			} else {
+				pr_err("Invalid value: '%s'\n", p);
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+
+			kfree(p);
+			break;
+		case OPT_SDPF_STRONG:
+			if (!prefetcher_is_available(level, type, SDPF)) {
+				pr_err("Unsupported parameter: '%s'\n", p);
+				ret = -EINVAL;
+				goto out;
+			}
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			if (!strcmp(p, "strong")) {
+				opts->sdpf_strong = PFCTL_STRONG_VAL;
+			} else if (!strcmp(p, "weak")) {
+				opts->sdpf_strong = PFCTL_WEAK_VAL;
+			} else {
+				pr_err("Invalid value: '%s'\n", p);
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+
+			kfree(p);
+			break;
+		default:
+			pr_err("Unknown parameter or missing value '%s'\n", p);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+out:
+	kfree(options);
+	return ret;
+}
+
+static ssize_t prefetch_control_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int ret;
+	unsigned int cpu;
+	ssize_t len = 0;
+	struct prefetcher_options opts;
+	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
+
+	cpu = dev->parent->parent->id;
+
+	ret = pdriver->read_pfreg(cpu, this_leaf->level, &opts);
+	if (ret < 0)
+		return ret;
+
+	if (prefetcher_is_available(this_leaf->level, this_leaf->type, HWPF)) {
+		if (opts.hwpf_enable == PFCTL_ENABLE_VAL)
+			len += sysfs_emit_at(buf, len, hwpf_enable_fmt,
+					     "enable");
+		else
+			len += sysfs_emit_at(buf, len, hwpf_enable_fmt,
+					     "disable");
+		len += sysfs_emit_at(buf, len, "\n");
+	}
+
+	if (prefetcher_is_available(this_leaf->level, this_leaf->type, IPPF)) {
+		if (opts.ippf_enable == PFCTL_ENABLE_VAL)
+			len += sysfs_emit_at(buf, len, ippf_enable_fmt,
+					     "enable");
+		else
+			len += sysfs_emit_at(buf, len, ippf_enable_fmt,
+					     "disable");
+		len += sysfs_emit_at(buf, len, "\n");
+	}
+
+	if (prefetcher_is_available(this_leaf->level, this_leaf->type, ACLPF)) {
+		if (opts.aclpf_enable == PFCTL_ENABLE_VAL)
+			len += sysfs_emit_at(buf, len, aclpf_enable_fmt,
+					     "enable");
+		else
+			len += sysfs_emit_at(buf, len, aclpf_enable_fmt,
+					     "disable");
+		len += sysfs_emit_at(buf, len, "\n");
+	}
+
+	if (prefetcher_is_available(this_leaf->level, this_leaf->type, SDPF)) {
+		if (opts.sdpf_enable == PFCTL_ENABLE_VAL)
+			len += sysfs_emit_at(buf, len, sdpf_enable_fmt,
+					     "enable");
+		else
+			len += sysfs_emit_at(buf, len, sdpf_enable_fmt,
+					     "disable");
+		len += sysfs_emit_at(buf, len, "\n");
+
+		if (opts.sdpf_dist == PFCTL_DIST_AUTO_VAL)
+			len += sysfs_emit_at(buf, len, sdpf_dist_auto_fmt,
+					     "auto");
+		else
+			len += sysfs_emit_at(buf, len, sdpf_dist_fmt,
+					     opts.sdpf_dist);
+		len += sysfs_emit_at(buf, len, "\n");
+
+		if (opts.sdpf_strong == PFCTL_STRONG_VAL)
+			len += sysfs_emit_at(buf, len, sdpf_strong_fmt,
+					     "strong");
+		else
+			len += sysfs_emit_at(buf, len, sdpf_strong_fmt,
+					     "weak");
+		len += sysfs_emit_at(buf, len, "\n");
+	}
+
+	return len;
+}
+
+static ssize_t prefetch_control_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	int ret;
+	unsigned int cpu;
+	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
+	struct prefetcher_options opts = {
+		.hwpf_enable	= PFCTL_PARAM_UNSET,
+		.ippf_enable	= PFCTL_PARAM_UNSET,
+		.aclpf_enable	= PFCTL_PARAM_UNSET,
+		.sdpf_enable	= PFCTL_PARAM_UNSET,
+		.sdpf_dist	= PFCTL_PARAM_UNSET,
+		.sdpf_strong	= PFCTL_PARAM_UNSET,
+	};
+
+	cpu = dev->parent->parent->id;
+
+	ret = parse_prefetch_options(&opts, buf, this_leaf->level,
+				     this_leaf->type);
+	if (ret < 0)
+		return ret;
+
+	ret = pdriver->write_pfreg(cpu, this_leaf->level, &opts);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_ADMIN_RW(prefetch_control);
+
+static int find_cache_device(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+	struct device *cache_dev;
+
+	cache_dev = device_find_child_by_name(cpu_dev, "cache");
+	if (!cache_dev)
+		return -ENODEV;
+	per_cpu_cache_device(cpu) = cache_dev;
+
+	return 0;
+}
+
+static int _create_pfctl_attr(struct device *dev, void *data)
+{
+	int ret;
+	struct cacheinfo *leaf = dev_get_drvdata(dev);
+
+	if (!prefetcher_is_available(leaf->level, leaf->type, ANYPF))
+		return 0;
+
+	ret = sysfs_create_file(&dev->kobj, &dev_attr_prefetch_control.attr);
+	if (ret < 0) {
+		pr_err("sysfs_create_file failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int create_pfctl_attr(unsigned int cpu)
+{
+	int ret;
+	struct device *cache_dev = per_cpu_cache_device(cpu);
+
+	if (!cache_dev)
+		return -ENODEV;
+
+	ret = device_for_each_child(cache_dev, NULL, _create_pfctl_attr);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int _remove_pfctl_attr(struct device *dev, void *data)
+{
+	struct cacheinfo *leaf = dev_get_drvdata(dev);
+
+	if (!prefetcher_is_available(leaf->level, leaf->type, ANYPF))
+		return 0;
+
+	sysfs_remove_file(&dev->kobj, &dev_attr_prefetch_control.attr);
+
+	return 0;
+}
+
+static void remove_pfctl_attr(unsigned int cpu)
+{
+	struct device *cache_dev = per_cpu_cache_device(cpu);
+
+	if (!cache_dev)
+		return;
+
+	device_for_each_child(cache_dev, NULL, _remove_pfctl_attr);
+}
+
+static int pfctl_online(unsigned int cpu)
+{
+	int ret;
+
+	ret = find_cache_device(cpu);
+	if (ret < 0)
+		return ret;
+
+	ret = create_pfctl_attr(cpu);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int pfctl_prepare_down(unsigned int cpu)
+{
+	remove_pfctl_attr(cpu);
+
+	return 0;
+}
+
+/**
+ * pfctl_register_driver - register a Hardware Prefetch Control driver
+ * @driver_data: struct pfctl_driver must contain the supported prefetcher type
+ *               and function pointer for reading and writing hardware prefetch
+ *               register. If these are not defined this function return error.
+ *
+ * Note: This function must be called after the cache device is initialized
+ * because it requires access to the cache device.
+ * (e.g. Call at the late_initcall)
+ *
+ * Context: Any context.
+ * Return: 0 on success, negative error code on failure.
+ */
+int pfctl_register_driver(struct pfctl_driver *driver_data)
+{
+	int ret;
+
+	if (pdriver)
+		return -EEXIST;
+
+	if ((driver_data->supported_l1d_prefetcher == 0) &&
+	    (driver_data->supported_l2_prefetcher == 0))
+		return -EINVAL;
+
+	if (!driver_data->read_pfreg || !driver_data->write_pfreg)
+		return -EINVAL;
+
+	pdriver = driver_data;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "base/pfctl:online",
+				pfctl_online, pfctl_prepare_down);
+	if (ret < 0) {
+		pr_err("failed to register hotplug callbacks\n");
+		pdriver = NULL;
+		return ret;
+	}
+
+	hp_online = ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pfctl_register_driver);
+
+/**
+ * pfctl_unregister_driver - unregister the Hardware Prefetch Control driver
+ * @driver_data: Used to verify that this function is called by the driver that
+ *               called pfctl_register_driver by determining if driver_data is
+ *               the same.
+ *
+ * Context: Any context.
+ * Return: nothing.
+ */
+void pfctl_unregister_driver(struct pfctl_driver *driver_data)
+{
+	if (!pdriver || (driver_data != pdriver))
+		return;
+
+	cpuhp_remove_state(hp_online);
+
+	pdriver = NULL;
+}
+EXPORT_SYMBOL_GPL(pfctl_unregister_driver);
diff --git a/include/linux/pfctl.h b/include/linux/pfctl.h
new file mode 100644
index 000000000000..7a05e2f4a4f7
--- /dev/null
+++ b/include/linux/pfctl.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PFCTL_H
+#define _LINUX_PFCTL_H
+
+#define PFCTL_ENABLE_VAL		0
+#define PFCTL_DISABLE_VAL		1
+#define PFCTL_DIST_AUTO_VAL		0
+#define PFCTL_STRONG_VAL		0
+#define PFCTL_WEAK_VAL			1
+#define PFCTL_PARAM_UNSET		-1
+
+struct prefetcher_options {
+	int hwpf_enable;
+	int ippf_enable;
+	int aclpf_enable;
+	int sdpf_enable;
+	int sdpf_dist;
+	int sdpf_strong;
+};
+
+enum prefetcher {
+	HWPF	= BIT(0), /* Hardware Prefetcher */
+	IPPF	= BIT(1), /* IP Prefetcher */
+	ACLPF	= BIT(2), /* Adjacent Cache Line Prefetcher */
+	SDPF	= BIT(3), /* Stream Detect Prefetcher */
+	ANYPF	= HWPF|IPPF|ACLPF|SDPF,
+};
+
+struct pfctl_driver {
+	unsigned int supported_l1d_prefetcher;
+	unsigned int supported_l2_prefetcher;
+
+	int (*read_pfreg)(unsigned int cpu, unsigned int level,
+			  struct prefetcher_options *opt);
+	int (*write_pfreg)(unsigned int cpu, unsigned int level,
+			   struct prefetcher_options *opt);
+};
+
+int pfctl_register_driver(struct pfctl_driver *driver_data);
+void pfctl_unregister_driver(struct pfctl_driver *driver_data);
+
+#endif
-- 
2.27.0

