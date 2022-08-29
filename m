Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4A15A431D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiH2GWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiH2GWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:22:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD09F422E9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:22:15 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id l3so7008382plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=b+Dj/bON9YWCztdnm4HWQ6GsSjE/m0eim3jpo/IdprA=;
        b=Vgag9ye8/cj8OQQ/WD3Xzj4cmkBHWbyAMZwLa6XYXsEU5LAHrt1TZ/+KRMKS2tjS+9
         bMpASJMzHz5y0ZqT50cZEFFMUVy6SYkgUTmxPWbz0E79QfOf1lJFJE5mWxiE8JgaX0Cv
         jVshMDe26qCyV6LI+ZTc1YYtZIDVraQzAbI/uE+mjPRXJV26R/BrZwPINfQdxjh1a5NA
         qazDJoJaP4tNxIfD4LqUdZyD4UAv0W+3R0GngaNme7otbEYfc5Xyb2Tg8N6CO9bc3MHQ
         rG7r1AjV23mDM6P5WJ/y0WI4Q4jC0BNQ9ZqMuToRTQtvNIH1HLwHyHSW3c79bda+ZKG9
         VIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=b+Dj/bON9YWCztdnm4HWQ6GsSjE/m0eim3jpo/IdprA=;
        b=p3Q2ed32VTAVnZ4qziufos8cI3/a3rSeEZkQkcpqVTXVST4ccDNIc3i+Ij5TTBvaCi
         +XWyBPsGNrjIzMtn8mjP80DIxuh24u5kWgl2s9LZOa5v/hsOxkoO8N16ykwyDVxaXOfS
         5dHJf9RYoIttcXRTtJ2w1O5HObuMvY2pPsvD1NdfGXwV+w06wyw92CC+GnA63msuxmJu
         Gm1ypm1UgRkRKrpj2W9p7hYctI1SkZ5nvf4jObpNrmT0P/U3nPdQOa78IT/3e/mZ6+aZ
         hXdDDnkac+sHJyviCUOvV8mJWkBd8xFATfIKWN3XjDpjDZiVs8tOG5QjUjRyFqHK/9EK
         XaJQ==
X-Gm-Message-State: ACgBeo2l3RrexC1GdaCcu9dMhU3wU9346Yel1EXDh0x0ocBYUCzvg6pB
        bsosVkQbmanz+IFUZufqlrtsIA==
X-Google-Smtp-Source: AA6agR42s0ebdoR2tjV0nFljUGrv+b/FZ0816d85HA0saeWsRNPNT4/cAeIS1CmrfOSjfLudNIua2g==
X-Received: by 2002:a17:90a:474b:b0:1fd:62c3:62ef with SMTP id y11-20020a17090a474b00b001fd62c362efmr15286181pjg.8.1661754135316;
        Sun, 28 Aug 2022 23:22:15 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id mp10-20020a17090b190a00b001f333fab3d6sm5817972pjb.18.2022.08.28.23.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 23:22:14 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/3] soc: sifive: l2 cache: Rename SiFive L2 cache to composible cache.
Date:   Mon, 29 Aug 2022 06:22:01 +0000
Message-Id: <20220829062202.3287-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220829062202.3287-1-zong.li@sifive.com>
References: <20220829062202.3287-1-zong.li@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greentime Hu <greentime.hu@sifive.com>

Since composible cache may be L3 cache if pL2 cache exists, we should use
its original name composible cache to prevent confusion.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/soc/sifive/Kconfig           |   7 +-
 drivers/soc/sifive/Makefile          |   2 +-
 drivers/soc/sifive/sifive_ccache.c   | 221 +++++++++++++++++++++++++
 drivers/soc/sifive/sifive_l2_cache.c | 237 ---------------------------
 include/soc/sifive/sifive_ccache.h   |  16 ++
 include/soc/sifive/sifive_l2_cache.h |  16 --
 6 files changed, 242 insertions(+), 257 deletions(-)
 create mode 100644 drivers/soc/sifive/sifive_ccache.c
 delete mode 100644 drivers/soc/sifive/sifive_l2_cache.c
 create mode 100644 include/soc/sifive/sifive_ccache.h
 delete mode 100644 include/soc/sifive/sifive_l2_cache.h

diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
index 58cf8c40d08d..3d65d2771f9a 100644
--- a/drivers/soc/sifive/Kconfig
+++ b/drivers/soc/sifive/Kconfig
@@ -2,9 +2,10 @@
 
 if SOC_SIFIVE
 
-config SIFIVE_L2
-	bool "Sifive L2 Cache controller"
+config SIFIVE_CCACHE
+	bool "Sifive composable Cache controller"
+	default y
 	help
-	  Support for the L2 cache controller on SiFive platforms.
+	  Support for the composable cache controller on SiFive platforms.
 
 endif
diff --git a/drivers/soc/sifive/Makefile b/drivers/soc/sifive/Makefile
index b5caff77938f..1f5dc339bf82 100644
--- a/drivers/soc/sifive/Makefile
+++ b/drivers/soc/sifive/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_SIFIVE_L2)	+= sifive_l2_cache.o
+obj-$(CONFIG_SIFIVE_CCACHE)	+= sifive_ccache.o
diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
new file mode 100644
index 000000000000..46ce33db7d30
--- /dev/null
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiFive composable cache controller Driver
+ *
+ * Copyright (C) 2018-2019 SiFive, Inc.
+ *
+ */
+#include <linux/debugfs.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/device.h>
+#include <asm/cacheinfo.h>
+#include <soc/sifive/sifive_ccache.h>
+
+#define SIFIVE_CCACHE_DIRECCFIX_LOW 0x100
+#define SIFIVE_CCACHE_DIRECCFIX_HIGH 0x104
+#define SIFIVE_CCACHE_DIRECCFIX_COUNT 0x108
+
+#define SIFIVE_CCACHE_DATECCFIX_LOW 0x140
+#define SIFIVE_CCACHE_DATECCFIX_HIGH 0x144
+#define SIFIVE_CCACHE_DATECCFIX_COUNT 0x148
+
+#define SIFIVE_CCACHE_DATECCFAIL_LOW 0x160
+#define SIFIVE_CCACHE_DATECCFAIL_HIGH 0x164
+#define SIFIVE_CCACHE_DATECCFAIL_COUNT 0x168
+
+#define SIFIVE_CCACHE_CONFIG 0x00
+#define SIFIVE_CCACHE_WAYENABLE 0x08
+#define SIFIVE_CCACHE_ECCINJECTERR 0x40
+
+#define SIFIVE_CCACHE_MAX_ECCINTR 3
+
+static void __iomem *ccache_base;
+static int level;
+static int g_irq[SIFIVE_CCACHE_MAX_ECCINTR];
+static struct riscv_cacheinfo_ops ccache_cache_ops;
+
+enum {
+	DIR_CORR = 0,
+	DATA_CORR,
+	DATA_UNCORR,
+};
+
+#ifdef CONFIG_DEBUG_FS
+static struct dentry *sifive_test;
+
+static ssize_t ccache_write(struct file *file, const char __user *data,
+			size_t count, loff_t *ppos)
+{
+	unsigned int val;
+
+	if (kstrtouint_from_user(data, count, 0, &val))
+		return -EINVAL;
+	if ((val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
+		writel(val, ccache_base + SIFIVE_CCACHE_ECCINJECTERR);
+	else
+		return -EINVAL;
+	return count;
+}
+
+static const struct file_operations ccache_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = ccache_write
+};
+
+static void setup_sifive_debug(void)
+{
+	sifive_test = debugfs_create_dir("sifive_ccache_cache", NULL);
+
+	debugfs_create_file("sifive_debug_inject_error", 0200,
+			    sifive_test, NULL, &ccache_fops);
+}
+#endif
+
+static void ccache_config_read(void)
+{
+	u32 regval, val;
+
+	regval = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
+	val = regval & 0xFF;
+	pr_info("CCACHE: No. of Banks in the cache: %d\n", val);
+	val = (regval & 0xFF00) >> 8;
+	pr_info("CCACHE: No. of ways per bank: %d\n", val);
+	val = (regval & 0xFF0000) >> 16;
+	pr_info("CCACHE: Sets per bank: %llu\n", (uint64_t)1 << val);
+	val = (regval & 0xFF000000) >> 24;
+	pr_info("CCACHE: Bytes per cache block: %llu\n", (uint64_t)1 << val);
+
+	regval = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
+	pr_info("CCACHE: Index of the largest way enabled: %d\n", regval);
+}
+
+static const struct of_device_id sifive_ccache_ids[] = {
+	{ .compatible = "sifive,fu540-c000-ccache" },
+	{ .compatible = "sifive,ccache0" },
+	{ /* end of table */ },
+};
+
+static ATOMIC_NOTIFIER_HEAD(ccache_err_chain);
+
+int register_sifive_ccache_error_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&ccache_err_chain, nb);
+}
+EXPORT_SYMBOL_GPL(register_sifive_ccache_error_notifier);
+
+int unregister_sifive_ccache_error_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&ccache_err_chain, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_sifive_ccache_error_notifier);
+
+static int ccache_largest_wayenabled(void)
+{
+	return readl(ccache_base + SIFIVE_CCACHE_WAYENABLE) & 0xFF;
+}
+
+static ssize_t number_of_ways_enabled_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	return sprintf(buf, "%u\n", ccache_largest_wayenabled());
+}
+
+static DEVICE_ATTR_RO(number_of_ways_enabled);
+
+static struct attribute *priv_attrs[] = {
+	&dev_attr_number_of_ways_enabled.attr,
+	NULL,
+};
+
+static const struct attribute_group priv_attr_group = {
+	.attrs = priv_attrs,
+};
+
+static const struct attribute_group *ccache_get_priv_group(struct cacheinfo *this_leaf)
+{
+	/* We want to use private group for composable cache only */
+	if (this_leaf->level == level)
+		return &priv_attr_group;
+	else
+		return NULL;
+}
+
+static irqreturn_t ccache_int_handler(int irq, void *device)
+{
+	unsigned int add_h, add_l;
+
+	if (irq == g_irq[DIR_CORR]) {
+		add_h = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_HIGH);
+		add_l = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_LOW);
+		pr_err("CCACHE: DirError @ 0x%08X.%08X\n", add_h, add_l);
+		/* Reading this register clears the DirError interrupt sig */
+		readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_COUNT);
+		atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CCACHE_ERR_TYPE_CE,
+					   "DirECCFix");
+	}
+	if (irq == g_irq[DATA_CORR]) {
+		add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_HIGH);
+		add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_LOW);
+		pr_err("CCACHE: DataError @ 0x%08X.%08X\n", add_h, add_l);
+		/* Reading this register clears the DataError interrupt sig */
+		readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_COUNT);
+		atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CCACHE_ERR_TYPE_CE,
+					   "DatECCFix");
+	}
+	if (irq == g_irq[DATA_UNCORR]) {
+		add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_HIGH);
+		add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_LOW);
+		pr_err("CCACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l);
+		/* Reading this register clears the DataFail interrupt sig */
+		readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_COUNT);
+		atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CCACHE_ERR_TYPE_UE,
+					   "DatECCFail");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int __init sifive_ccache_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+	int i, rc;
+
+	np = of_find_matching_node(NULL, sifive_ccache_ids);
+	if (!np)
+		return -ENODEV;
+
+	if (of_address_to_resource(np, 0, &res))
+		return -ENODEV;
+
+	if (of_property_read_u32(np, "cache-level", &level))
+		return -ENODEV;
+
+	ccache_base = ioremap(res.start, resource_size(&res));
+	if (!ccache_base)
+		return -ENOMEM;
+
+	for (i = 0; i < SIFIVE_CCACHE_MAX_ECCINTR; i++) {
+		g_irq[i] = irq_of_parse_and_map(np, i);
+		rc = request_irq(g_irq[i], ccache_int_handler, 0, "ccache_ecc", NULL);
+		if (rc) {
+			pr_err("CCACHE: Could not request IRQ %d\n", g_irq[i]);
+			return rc;
+		}
+	}
+
+	ccache_config_read();
+
+	ccache_cache_ops.get_priv_group = ccache_get_priv_group;
+	riscv_set_cacheinfo_ops(&ccache_cache_ops);
+
+#ifdef CONFIG_DEBUG_FS
+	setup_sifive_debug();
+#endif
+	return 0;
+}
+device_initcall(sifive_ccache_init);
diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
deleted file mode 100644
index 59640a1d0b28..000000000000
--- a/drivers/soc/sifive/sifive_l2_cache.c
+++ /dev/null
@@ -1,237 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * SiFive L2 cache controller Driver
- *
- * Copyright (C) 2018-2019 SiFive, Inc.
- *
- */
-#include <linux/debugfs.h>
-#include <linux/interrupt.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/device.h>
-#include <asm/cacheinfo.h>
-#include <soc/sifive/sifive_l2_cache.h>
-
-#define SIFIVE_L2_DIRECCFIX_LOW 0x100
-#define SIFIVE_L2_DIRECCFIX_HIGH 0x104
-#define SIFIVE_L2_DIRECCFIX_COUNT 0x108
-
-#define SIFIVE_L2_DIRECCFAIL_LOW 0x120
-#define SIFIVE_L2_DIRECCFAIL_HIGH 0x124
-#define SIFIVE_L2_DIRECCFAIL_COUNT 0x128
-
-#define SIFIVE_L2_DATECCFIX_LOW 0x140
-#define SIFIVE_L2_DATECCFIX_HIGH 0x144
-#define SIFIVE_L2_DATECCFIX_COUNT 0x148
-
-#define SIFIVE_L2_DATECCFAIL_LOW 0x160
-#define SIFIVE_L2_DATECCFAIL_HIGH 0x164
-#define SIFIVE_L2_DATECCFAIL_COUNT 0x168
-
-#define SIFIVE_L2_CONFIG 0x00
-#define SIFIVE_L2_WAYENABLE 0x08
-#define SIFIVE_L2_ECCINJECTERR 0x40
-
-#define SIFIVE_L2_MAX_ECCINTR 4
-
-static void __iomem *l2_base;
-static int g_irq[SIFIVE_L2_MAX_ECCINTR];
-static struct riscv_cacheinfo_ops l2_cache_ops;
-
-enum {
-	DIR_CORR = 0,
-	DATA_CORR,
-	DATA_UNCORR,
-	DIR_UNCORR,
-};
-
-#ifdef CONFIG_DEBUG_FS
-static struct dentry *sifive_test;
-
-static ssize_t l2_write(struct file *file, const char __user *data,
-			size_t count, loff_t *ppos)
-{
-	unsigned int val;
-
-	if (kstrtouint_from_user(data, count, 0, &val))
-		return -EINVAL;
-	if ((val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
-		writel(val, l2_base + SIFIVE_L2_ECCINJECTERR);
-	else
-		return -EINVAL;
-	return count;
-}
-
-static const struct file_operations l2_fops = {
-	.owner = THIS_MODULE,
-	.open = simple_open,
-	.write = l2_write
-};
-
-static void setup_sifive_debug(void)
-{
-	sifive_test = debugfs_create_dir("sifive_l2_cache", NULL);
-
-	debugfs_create_file("sifive_debug_inject_error", 0200,
-			    sifive_test, NULL, &l2_fops);
-}
-#endif
-
-static void l2_config_read(void)
-{
-	u32 regval, val;
-
-	regval = readl(l2_base + SIFIVE_L2_CONFIG);
-	val = regval & 0xFF;
-	pr_info("L2CACHE: No. of Banks in the cache: %d\n", val);
-	val = (regval & 0xFF00) >> 8;
-	pr_info("L2CACHE: No. of ways per bank: %d\n", val);
-	val = (regval & 0xFF0000) >> 16;
-	pr_info("L2CACHE: Sets per bank: %llu\n", (uint64_t)1 << val);
-	val = (regval & 0xFF000000) >> 24;
-	pr_info("L2CACHE: Bytes per cache block: %llu\n", (uint64_t)1 << val);
-
-	regval = readl(l2_base + SIFIVE_L2_WAYENABLE);
-	pr_info("L2CACHE: Index of the largest way enabled: %d\n", regval);
-}
-
-static const struct of_device_id sifive_l2_ids[] = {
-	{ .compatible = "sifive,fu540-c000-ccache" },
-	{ .compatible = "sifive,fu740-c000-ccache" },
-	{ /* end of table */ },
-};
-
-static ATOMIC_NOTIFIER_HEAD(l2_err_chain);
-
-int register_sifive_l2_error_notifier(struct notifier_block *nb)
-{
-	return atomic_notifier_chain_register(&l2_err_chain, nb);
-}
-EXPORT_SYMBOL_GPL(register_sifive_l2_error_notifier);
-
-int unregister_sifive_l2_error_notifier(struct notifier_block *nb)
-{
-	return atomic_notifier_chain_unregister(&l2_err_chain, nb);
-}
-EXPORT_SYMBOL_GPL(unregister_sifive_l2_error_notifier);
-
-static int l2_largest_wayenabled(void)
-{
-	return readl(l2_base + SIFIVE_L2_WAYENABLE) & 0xFF;
-}
-
-static ssize_t number_of_ways_enabled_show(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
-{
-	return sprintf(buf, "%u\n", l2_largest_wayenabled());
-}
-
-static DEVICE_ATTR_RO(number_of_ways_enabled);
-
-static struct attribute *priv_attrs[] = {
-	&dev_attr_number_of_ways_enabled.attr,
-	NULL,
-};
-
-static const struct attribute_group priv_attr_group = {
-	.attrs = priv_attrs,
-};
-
-static const struct attribute_group *l2_get_priv_group(struct cacheinfo *this_leaf)
-{
-	/* We want to use private group for L2 cache only */
-	if (this_leaf->level == 2)
-		return &priv_attr_group;
-	else
-		return NULL;
-}
-
-static irqreturn_t l2_int_handler(int irq, void *device)
-{
-	unsigned int add_h, add_l;
-
-	if (irq == g_irq[DIR_CORR]) {
-		add_h = readl(l2_base + SIFIVE_L2_DIRECCFIX_HIGH);
-		add_l = readl(l2_base + SIFIVE_L2_DIRECCFIX_LOW);
-		pr_err("L2CACHE: DirError @ 0x%08X.%08X\n", add_h, add_l);
-		/* Reading this register clears the DirError interrupt sig */
-		readl(l2_base + SIFIVE_L2_DIRECCFIX_COUNT);
-		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
-					   "DirECCFix");
-	}
-	if (irq == g_irq[DIR_UNCORR]) {
-		add_h = readl(l2_base + SIFIVE_L2_DIRECCFAIL_HIGH);
-		add_l = readl(l2_base + SIFIVE_L2_DIRECCFAIL_LOW);
-		/* Reading this register clears the DirFail interrupt sig */
-		readl(l2_base + SIFIVE_L2_DIRECCFAIL_COUNT);
-		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_UE,
-					   "DirECCFail");
-		panic("L2CACHE: DirFail @ 0x%08X.%08X\n", add_h, add_l);
-	}
-	if (irq == g_irq[DATA_CORR]) {
-		add_h = readl(l2_base + SIFIVE_L2_DATECCFIX_HIGH);
-		add_l = readl(l2_base + SIFIVE_L2_DATECCFIX_LOW);
-		pr_err("L2CACHE: DataError @ 0x%08X.%08X\n", add_h, add_l);
-		/* Reading this register clears the DataError interrupt sig */
-		readl(l2_base + SIFIVE_L2_DATECCFIX_COUNT);
-		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
-					   "DatECCFix");
-	}
-	if (irq == g_irq[DATA_UNCORR]) {
-		add_h = readl(l2_base + SIFIVE_L2_DATECCFAIL_HIGH);
-		add_l = readl(l2_base + SIFIVE_L2_DATECCFAIL_LOW);
-		pr_err("L2CACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l);
-		/* Reading this register clears the DataFail interrupt sig */
-		readl(l2_base + SIFIVE_L2_DATECCFAIL_COUNT);
-		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_UE,
-					   "DatECCFail");
-	}
-
-	return IRQ_HANDLED;
-}
-
-static int __init sifive_l2_init(void)
-{
-	struct device_node *np;
-	struct resource res;
-	int i, rc, intr_num;
-
-	np = of_find_matching_node(NULL, sifive_l2_ids);
-	if (!np)
-		return -ENODEV;
-
-	if (of_address_to_resource(np, 0, &res))
-		return -ENODEV;
-
-	l2_base = ioremap(res.start, resource_size(&res));
-	if (!l2_base)
-		return -ENOMEM;
-
-	intr_num = of_property_count_u32_elems(np, "interrupts");
-	if (!intr_num) {
-		pr_err("L2CACHE: no interrupts property\n");
-		return -ENODEV;
-	}
-
-	for (i = 0; i < intr_num; i++) {
-		g_irq[i] = irq_of_parse_and_map(np, i);
-		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
-		if (rc) {
-			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
-			return rc;
-		}
-	}
-
-	l2_config_read();
-
-	l2_cache_ops.get_priv_group = l2_get_priv_group;
-	riscv_set_cacheinfo_ops(&l2_cache_ops);
-
-#ifdef CONFIG_DEBUG_FS
-	setup_sifive_debug();
-#endif
-	return 0;
-}
-device_initcall(sifive_l2_init);
diff --git a/include/soc/sifive/sifive_ccache.h b/include/soc/sifive/sifive_ccache.h
new file mode 100644
index 000000000000..16576d678ea8
--- /dev/null
+++ b/include/soc/sifive/sifive_ccache.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SiFive composable Cache Controller header file
+ *
+ */
+
+#ifndef __SOC_SIFIVE_CCACHE_H
+#define __SOC_SIFIVE_CCACHE_H
+
+extern int register_sifive_ccache_error_notifier(struct notifier_block *nb);
+extern int unregister_sifive_ccache_error_notifier(struct notifier_block *nb);
+
+#define SIFIVE_CCACHE_ERR_TYPE_CE 0
+#define SIFIVE_CCACHE_ERR_TYPE_UE 1
+
+#endif /* __SOC_SIFIVE_CCACHE_H */
diff --git a/include/soc/sifive/sifive_l2_cache.h b/include/soc/sifive/sifive_l2_cache.h
deleted file mode 100644
index 92ade10ed67e..000000000000
--- a/include/soc/sifive/sifive_l2_cache.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * SiFive L2 Cache Controller header file
- *
- */
-
-#ifndef __SOC_SIFIVE_L2_CACHE_H
-#define __SOC_SIFIVE_L2_CACHE_H
-
-extern int register_sifive_l2_error_notifier(struct notifier_block *nb);
-extern int unregister_sifive_l2_error_notifier(struct notifier_block *nb);
-
-#define SIFIVE_L2_ERR_TYPE_CE 0
-#define SIFIVE_L2_ERR_TYPE_UE 1
-
-#endif /* __SOC_SIFIVE_L2_CACHE_H */
-- 
2.17.1

