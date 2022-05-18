Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E055252B282
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiERGbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiERGbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:31:31 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE75AE59
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:31:30 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="52853254"
X-IronPort-AV: E=Sophos;i="5.91,234,1647270000"; 
   d="scan'208";a="52853254"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 18 May 2022 15:31:23 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3AC93E5B1E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:23 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6CAF2D0434
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:22 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id ECDB8400C1BB9;
        Wed, 18 May 2022 15:31:21 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, mchehab+huawei@kernel.org, eugenis@google.com,
        tony.luck@intel.com, pcc@google.com, peterz@infradead.org,
        marcos@orca.pet, conor.dooley@microchip.com,
        nicolas.ferre@microchip.com, marcan@marcan.st,
        linus.walleij@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v4 1/8] drivers: base: Add hardware prefetch control core driver
Date:   Wed, 18 May 2022 15:30:25 +0900
Message-Id: <20220518063032.2377351-2-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
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

Adds a register/unregister function to provide sysfs interface to
control CPU's hardware prefetch behavior. It creates the
"prefetch_control" sysfs directory and some attributes.

Attributes are hardware dependent, so it must be implemented for each
hardware. If CPU has a hardware prefetch behavior, call this function
to create sysfs.

Following patches add support for A64FX and x86.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 drivers/base/pfctl.c  | 180 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pfctl.h |  14 ++++
 2 files changed, 194 insertions(+)
 create mode 100644 drivers/base/pfctl.c
 create mode 100644 include/linux/pfctl.h

diff --git a/drivers/base/pfctl.c b/drivers/base/pfctl.c
new file mode 100644
index 000000000000..08ee8faaf277
--- /dev/null
+++ b/drivers/base/pfctl.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hardware prefetch control support via sysfs.
+ *
+ * Copyright 2022 FUJITSU LIMITED
+ *
+ * See Documentation/ABI/testing/sysfs-devices-system-cpu for more information.
+ */
+
+#include <linux/cacheinfo.h>
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/pfctl.h>
+#include <linux/slab.h>
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+const struct pfctl_group *pgroups;
+enum cpuhp_state hp_online;
+
+static struct device_attribute **
+get_pfctl_attribute(unsigned int level, enum cache_type type)
+{
+	int i;
+
+	for (i = 0; pgroups[i].attrs; i++)
+		if ((level == pgroups[i].level) && (type == pgroups[i].type))
+			return pgroups[i].attrs;
+
+	return NULL;
+}
+
+static int remove_pfctl_attr(struct device *index_dev, void *data)
+{
+	struct cacheinfo *leaf = dev_get_drvdata(index_dev);
+	struct device_attribute **attrs;
+	struct device *pfctl_dev;
+	int i;
+
+	attrs = get_pfctl_attribute(leaf->level, leaf->type);
+	if (!attrs)
+		return 0;
+
+	pfctl_dev = device_find_child_by_name(index_dev, "prefetch_control");
+	if (!pfctl_dev)
+		return 0;
+
+	for (i = 0; attrs[i]; i++)
+		device_remove_file(pfctl_dev, attrs[i]);
+
+	device_unregister(pfctl_dev);
+	put_device(pfctl_dev);
+
+	pfctl_dev = NULL;
+
+	return 0;
+}
+
+static int create_pfctl_attr(struct device *index_dev, void *data)
+{
+	struct cacheinfo *leaf = dev_get_drvdata(index_dev);
+	struct device_attribute **attrs;
+	struct device *pfctl_dev;
+	int i, err;
+
+	attrs = get_pfctl_attribute(leaf->level, leaf->type);
+	if (!attrs)
+		return 0;
+
+	pfctl_dev = cpu_device_create(index_dev, NULL, NULL,
+				      "prefetch_control");
+	if (IS_ERR(pfctl_dev))
+		return PTR_ERR(pfctl_dev);
+
+	for (i = 0; attrs[i]; i++) {
+		err = device_create_file(pfctl_dev, attrs[i]);
+		if (err) {
+			while (--i >= 0)
+				device_remove_file(pfctl_dev, attrs[i]);
+
+			device_unregister(pfctl_dev);
+			pfctl_dev = NULL;
+
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int pfctl_online(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+	struct device *cache_dev;
+	int ret;
+
+	cache_dev = device_find_child_by_name(cpu_dev, "cache");
+	if (!cache_dev)
+		return -ENODEV;
+
+	ret = device_for_each_child(cache_dev, NULL, create_pfctl_attr);
+	if (ret < 0)
+		device_for_each_child(cache_dev, NULL, remove_pfctl_attr);
+
+	put_device(cache_dev);
+
+	return ret;
+}
+
+static int pfctl_prepare_down(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+	struct device *cache_dev;
+
+	cache_dev = device_find_child_by_name(cpu_dev, "cache");
+	if (!cache_dev)
+		return 0;
+
+	device_for_each_child(cache_dev, NULL, remove_pfctl_attr);
+
+	put_device(cache_dev);
+
+	return 0;
+}
+
+/**
+ * pfctl_register_attrs - register a Hardware Prefetch Control attributes
+ * @pfctl_groups: pfctl_groups contains device attribute group to control the
+ *                hardware prefetch register.
+ *
+ * Note: Call this function after the cache device is initialized because it
+ * requires access to the cache device. (e.g. Call at the late_initcall)
+ *
+ * Context: Any context.
+ * Return: 0 on success, negative error code on failure.
+ */
+int pfctl_register_attrs(const struct pfctl_group *pfctl_groups)
+{
+	int ret;
+
+	if (pgroups)
+		return -EEXIST;
+
+	pgroups = pfctl_groups;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "base/pfctl:online",
+				pfctl_online, pfctl_prepare_down);
+	if (ret < 0) {
+		pr_err("failed to register hotplug callbacks\n");
+		pgroups = NULL;
+		return ret;
+	}
+
+	hp_online = ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pfctl_register_attrs);
+
+/**
+ * pfctl_unregister_attrs - unregister the Hardware Prefetch Control driver
+ * @pfctl_groups: Used to verify that this function is called by the same driver
+ *                that called pfctl_register_attrs.
+ *
+ * Context: Any context.
+ * Return: nothing.
+ */
+void pfctl_unregister_attrs(const struct pfctl_group *pfctl_groups)
+{
+	if (!pgroups || (pfctl_groups != pgroups))
+		return;
+
+	cpuhp_remove_state(hp_online);
+
+	pgroups = NULL;
+}
+EXPORT_SYMBOL_GPL(pfctl_unregister_attrs);
diff --git a/include/linux/pfctl.h b/include/linux/pfctl.h
new file mode 100644
index 000000000000..ecdab78be09f
--- /dev/null
+++ b/include/linux/pfctl.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PFCTL_H
+#define _LINUX_PFCTL_H
+
+struct pfctl_group {
+	unsigned int		level;
+	enum cache_type		type;
+	struct device_attribute	**attrs;
+};
+
+int pfctl_register_attrs(const struct pfctl_group *pfctl_groups);
+void pfctl_unregister_attrs(const struct pfctl_group *pfctl_groups);
+
+#endif
-- 
2.27.0

