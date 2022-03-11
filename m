Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B184D5F66
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347847AbiCKKXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347820AbiCKKXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:23:39 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 02:22:34 PST
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95E6B5D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:22:34 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="45621046"
X-IronPort-AV: E=Sophos;i="5.90,173,1643641200"; 
   d="scan'208";a="45621046"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Mar 2022 19:21:27 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D0011C68A4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:26 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 08F8AF36ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:26 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id BA77A406139C9;
        Fri, 11 Mar 2022 19:21:25 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v2 1/8] drivers: base: Add hardware prefetch control core driver
Date:   Fri, 11 Mar 2022 19:19:33 +0900
Message-Id: <20220311101940.3403607-2-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver adds the register/unregister function to create the
"prefetch_control" directory and some attribute files in every CPU's
cache/index[0,2] directory.

Each attribute file exists depending on kind of processor and cache
level. For example, on an INTEL_FAM6_BROADWELL_X:

    /sys/devices/system/cpu/cpu0/cache/index0/prefetch_control
        hardware_prefetcher_enable
        ip_prefetcher_enable

    /sys/devices/system/cpu/cpu0/cache/index2/prefetch_control
        adjacent_cache_line_prefetcher_enable
        hardware_prefetcher_enable

If the architecture has control of the CPU's hardware prefetcher
behavior, use this function to create sysfs. When registering, it is
necessary to provide what type of hardware prefetcher is supported
and how to read/write to the register.

Following patches add support for ARM64 and x86.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 drivers/base/pfctl.c  | 412 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pfctl.h |  41 +++++
 2 files changed, 453 insertions(+)
 create mode 100644 drivers/base/pfctl.c
 create mode 100644 include/linux/pfctl.h

diff --git a/drivers/base/pfctl.c b/drivers/base/pfctl.c
new file mode 100644
index 000000000000..9335d513f55f
--- /dev/null
+++ b/drivers/base/pfctl.c
@@ -0,0 +1,412 @@
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
+static DEFINE_PER_CPU(struct device *, cache_device_pcpu);
+#define per_cpu_cache_device(cpu) (per_cpu(cache_device_pcpu, cpu))
+
+struct pfctl_driver *pdriver;
+enum cpuhp_state hp_online;
+
+static const char dist_auto_string[] = "auto";
+
+static bool prefetcher_is_available(unsigned int level, enum cache_type type,
+				    int prefetcher)
+{
+	if ((level == 1) && (type == CACHE_TYPE_DATA)) {
+		if (pdriver->supported_l1d_prefetcher & prefetcher)
+			return true;
+	} else if ((level == 2) && (type == CACHE_TYPE_UNIFIED)) {
+		if (pdriver->supported_l2_prefetcher & prefetcher)
+			return true;
+	}
+
+	return false;
+}
+
+#define pfctl_enable_show(prefetcher, pattr)				\
+static ssize_t								\
+prefetcher##_enable_show(struct device *dev,				\
+			 struct device_attribute *attr, char *buf)	\
+{									\
+	int ret;							\
+	u64 val;							\
+	unsigned int cpu;						\
+	struct cacheinfo *this_leaf = dev_get_drvdata(dev->parent);	\
+									\
+	cpu = dev->parent->parent->parent->id;				\
+									\
+	ret = pdriver->read_pfreg(pattr, cpu, this_leaf->level, &val);	\
+	if (ret < 0)							\
+		return ret;						\
+									\
+	if ((val == PFCTL_ENABLE_VAL) || (val == PFCTL_DISABLE_VAL))	\
+		return sysfs_emit(buf, "%llu\n", val);			\
+	else								\
+		return -EINVAL;						\
+}
+
+pfctl_enable_show(hardware_prefetcher, HWPF_ENABLE);
+pfctl_enable_show(ip_prefetcher, IPPF_ENABLE);
+pfctl_enable_show(adjacent_cache_line_prefetcher, ACLPF_ENABLE);
+pfctl_enable_show(stream_detect_prefetcher, SDPF_ENABLE);
+
+static ssize_t
+stream_detect_prefetcher_strong_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int ret;
+	u64 val;
+	unsigned int cpu;
+	struct cacheinfo *this_leaf = dev_get_drvdata(dev->parent);
+
+	cpu = dev->parent->parent->parent->id;
+
+	ret = pdriver->read_pfreg(SDPF_STRONG, cpu, this_leaf->level, &val);
+	if (ret < 0)
+		return ret;
+
+	if ((val == PFCTL_STRONG_VAL) || (val == PFCTL_WEAK_VAL))
+		return sysfs_emit(buf, "%llu\n", val);
+	else
+		return -EINVAL;
+
+}
+
+static ssize_t
+stream_detect_prefetcher_dist_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	int ret;
+	u64 val;
+	unsigned int cpu;
+	struct cacheinfo *this_leaf = dev_get_drvdata(dev->parent);
+
+	cpu = dev->parent->parent->parent->id;
+
+	ret = pdriver->read_pfreg(SDPF_DIST, cpu, this_leaf->level, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val == PFCTL_DIST_AUTO_VAL)
+		return sysfs_emit(buf, "%s\n", dist_auto_string);
+	else
+		return sysfs_emit(buf, "%llu\n", val);
+}
+
+#define pfctl_enable_store(prefetcher, pattr)				\
+static ssize_t								\
+prefetcher##_enable_store(struct device *dev,				\
+			  struct device_attribute *attr,		\
+			  const char *buf, size_t count)		\
+{									\
+	int ret;							\
+	u64 val;							\
+	unsigned int cpu;						\
+	struct cacheinfo *this_leaf = dev_get_drvdata(dev->parent);	\
+									\
+	ret = kstrtoull(buf, 10, &val);					\
+	if (ret < 0)							\
+		return -EINVAL;						\
+									\
+	if ((val != PFCTL_ENABLE_VAL) && (val != PFCTL_DISABLE_VAL))	\
+		return -EINVAL;						\
+									\
+	cpu = dev->parent->parent->parent->id;				\
+									\
+	ret = pdriver->write_pfreg(pattr, cpu, this_leaf->level, val);	\
+	if (ret < 0)							\
+		return ret;						\
+									\
+	return count;							\
+}
+
+pfctl_enable_store(hardware_prefetcher, HWPF_ENABLE);
+pfctl_enable_store(ip_prefetcher, IPPF_ENABLE);
+pfctl_enable_store(adjacent_cache_line_prefetcher, ACLPF_ENABLE);
+pfctl_enable_store(stream_detect_prefetcher, SDPF_ENABLE);
+
+static ssize_t
+stream_detect_prefetcher_strong_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	int ret;
+	u64 val;
+	unsigned int cpu;
+	struct cacheinfo *this_leaf = dev_get_drvdata(dev->parent);
+
+	ret = kstrtoull(buf, 10, &val);
+	if (ret < 0)
+		return -EINVAL;
+
+	if ((val != PFCTL_STRONG_VAL) && (val != PFCTL_WEAK_VAL))
+		return -EINVAL;
+
+	cpu = dev->parent->parent->parent->id;
+
+	ret = pdriver->write_pfreg(SDPF_STRONG, cpu, this_leaf->level, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t
+stream_detect_prefetcher_dist_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int ret;
+	u64 val;
+	unsigned int cpu;
+	struct cacheinfo *this_leaf = dev_get_drvdata(dev->parent);
+
+	if (sysfs_streq(buf, dist_auto_string)) {
+		val = PFCTL_DIST_AUTO_VAL;
+	} else {
+		ret = kstrtoull(buf, 10, &val);
+		if (ret < 0)
+			return -EINVAL;
+	}
+
+	cpu = dev->parent->parent->parent->id;
+
+	ret = pdriver->write_pfreg(SDPF_DIST, cpu, this_leaf->level, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_ADMIN_RW(hardware_prefetcher_enable);
+static DEVICE_ATTR_ADMIN_RW(ip_prefetcher_enable);
+static DEVICE_ATTR_ADMIN_RW(adjacent_cache_line_prefetcher_enable);
+static DEVICE_ATTR_ADMIN_RW(stream_detect_prefetcher_enable);
+static DEVICE_ATTR_ADMIN_RW(stream_detect_prefetcher_strong);
+static DEVICE_ATTR_ADMIN_RW(stream_detect_prefetcher_dist);
+
+static umode_t
+pfctl_attrs_is_visible(struct kobject *kobj, struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cacheinfo *this_leaf = dev_get_drvdata(dev->parent);
+	umode_t mode = attr->mode;
+
+	if ((attr == &dev_attr_hardware_prefetcher_enable.attr) &&
+	    (prefetcher_is_available(this_leaf->level, this_leaf->type, HWPF)))
+		return mode;
+
+	if ((attr == &dev_attr_ip_prefetcher_enable.attr) &&
+	    (prefetcher_is_available(this_leaf->level, this_leaf->type, IPPF)))
+		return mode;
+
+	if ((attr == &dev_attr_adjacent_cache_line_prefetcher_enable.attr) &&
+	    (prefetcher_is_available(this_leaf->level, this_leaf->type, ACLPF)))
+		return mode;
+
+	if (((attr == &dev_attr_stream_detect_prefetcher_enable.attr) ||
+	     (attr == &dev_attr_stream_detect_prefetcher_strong.attr) ||
+	     (attr == &dev_attr_stream_detect_prefetcher_dist.attr)) &&
+	    (prefetcher_is_available(this_leaf->level, this_leaf->type, SDPF)))
+		return mode;
+
+	return 0;
+}
+
+static struct attribute *pfctl_attrs[] = {
+	&dev_attr_hardware_prefetcher_enable.attr,
+	&dev_attr_ip_prefetcher_enable.attr,
+	&dev_attr_adjacent_cache_line_prefetcher_enable.attr,
+	&dev_attr_stream_detect_prefetcher_enable.attr,
+	&dev_attr_stream_detect_prefetcher_strong.attr,
+	&dev_attr_stream_detect_prefetcher_dist.attr,
+	NULL,
+};
+
+static const struct attribute_group pfctl_group = {
+	.attrs = pfctl_attrs,
+	.is_visible = pfctl_attrs_is_visible,
+};
+
+static const struct attribute_group *pfctl_groups[] = {
+	&pfctl_group,
+	NULL,
+};
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
+static int _remove_pfctl_attr(struct device *dev, void *data)
+{
+	struct cacheinfo *leaf = dev_get_drvdata(dev);
+	struct device *pfctl_dev;
+
+	if (!prefetcher_is_available(leaf->level, leaf->type, ANYPF))
+		return 0;
+
+	pfctl_dev = device_find_child_by_name(dev, "prefetch_control");
+	if (!pfctl_dev)
+		return 0;
+
+	device_unregister(pfctl_dev);
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
+static int _create_pfctl_attr(struct device *dev, void *data)
+{
+	struct cacheinfo *leaf = dev_get_drvdata(dev);
+	struct device *pfctl_dev;
+
+	if (!prefetcher_is_available(leaf->level, leaf->type, ANYPF))
+		return 0;
+
+	pfctl_dev = cpu_device_create(dev, NULL, pfctl_groups,
+				      "prefetch_control");
+	if (IS_ERR(pfctl_dev))
+		return PTR_ERR(pfctl_dev);
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
index 000000000000..607442606a95
--- /dev/null
+++ b/include/linux/pfctl.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PFCTL_H
+#define _LINUX_PFCTL_H
+
+#define PFCTL_ENABLE_VAL		1
+#define PFCTL_DISABLE_VAL		0
+#define PFCTL_STRONG_VAL		1
+#define PFCTL_WEAK_VAL			0
+#define PFCTL_DIST_AUTO_VAL		0
+
+enum pfctl_attr {
+	HWPF_ENABLE,
+	IPPF_ENABLE,
+	ACLPF_ENABLE,
+	SDPF_ENABLE,
+	SDPF_STRONG,
+	SDPF_DIST,
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
+	int (*read_pfreg)(enum pfctl_attr pattr, unsigned int cpu,
+			  unsigned int level, u64 *val);
+	int (*write_pfreg)(enum pfctl_attr pattr, unsigned int cpu,
+			   unsigned int level, u64 val);
+};
+
+int pfctl_register_driver(struct pfctl_driver *driver_data);
+void pfctl_unregister_driver(struct pfctl_driver *driver_data);
+
+#endif
-- 
2.27.0

