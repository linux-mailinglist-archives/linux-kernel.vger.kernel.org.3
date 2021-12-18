Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2A8479AE5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 14:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhLRNAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 08:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbhLRNAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 08:00:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376C4C06173F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 05:00:35 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v7so2061769wrv.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 05:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ex98898ORuSQfXO3nt1xbryRupEWOc+Ws7IWvi7Y958=;
        b=MSiX8872aULjxwwWkBGaY+6CBTB4Bk8og4GFTKrZcV/QR7h9Rib64/2uVR6t/iTRNM
         pWwECd2NZ7wsGlKxsobev/zTSah25gQzRty9YfL4JF2qZQE/yr/+2LyBKqswZLrz0x1V
         G3iM+/TXQR2kAdgQ9kjs0PeoHUJMrVTPEK1dtmTpT6CQ2ykfW04SYDVK2YcvQO/Ko9BL
         zbskONb+0IxVZKhEEuAsI1zBjWtLdQMf1iBfwPVV21B0l3DRSkp/p7s0cZ+sJCmf5/Zo
         N5ChbsSQrWozpzDLGQNEOClloAuIys7jA4GFvF2cWphyJqmsQxLJ0B2/RSvzsaQ7oLTR
         GTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ex98898ORuSQfXO3nt1xbryRupEWOc+Ws7IWvi7Y958=;
        b=LY2kDVl3HwwDucxj+rs+56xnCK18ZjkM7epZuk0ro/hg2wk8rHkuS358Jdf0QaUkWF
         RuCwNyFtQZ80Ic6Lp9nsSp4xfIRLXZQyhBWXxW1serzp1bcgRLolnNzjIEZz+pcgP4up
         wkI/xDY8S2BDwEhK5ClpkeV0dJp85GlmxcFao2/3ZyxaEaTmAsWhBtujxN3tzF//lvGV
         wVyj54kxii8eGIzDTxwqIcSbT1To+JP6GMCQ1ckv6J6E5Z2tYdryLVL07tSO5A/GZVx3
         89mdqg99BHc025PmisHgdv9dZGdZ0JMX8xC45Dxu2/nArKVNxX/kckCZt4MEBNHOkwHj
         y7lw==
X-Gm-Message-State: AOAM5323lckl0jijMvPduQSNQiZjBOvDASHCIPT9UtY3RsaUX/kx5GYF
        gSGZ1LiodKjRjHKs3zOxEWoiNj4IsLUxXA==
X-Google-Smtp-Source: ABdhPJx1TFiCgA5HbwOo6OFSCSrP6j7DJZt+8Gf9pGtTd265i0qCfhzr2/PgJeD4Vo/417lUWht0IA==
X-Received: by 2002:adf:cd8a:: with SMTP id q10mr6060897wrj.164.1639832433691;
        Sat, 18 Dec 2021 05:00:33 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:1f0f:c9b8:ee5c:5c2f])
        by smtp.gmail.com with ESMTPSA id j16sm1465785wms.12.2021.12.18.05.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 05:00:33 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, robh@kernel.org, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH v5 2/6] powercap/drivers/dtpm: Add hierarchy creation
Date:   Sat, 18 Dec 2021 14:00:10 +0100
Message-Id: <20211218130014.4037640-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTPM framework is available but without a way to configure it.

This change provides a way to create a hierarchy of DTPM node where
the power consumption reflects the sum of the children's power
consumption.

It is up to the platform to specify an array of dtpm nodes where each
element has a pointer to its parent, except the top most one. The type
of the node gives the indication of which initialization callback to
call. At this time, we can create a virtual node, where its purpose is
to be a parent in the hierarchy, and a DT node where the name
describes its path.

In order to ensure a nice self-encapsulation, the DTPM table
descriptors contains a couple of initialization functions, one to
setup the DTPM backend and one to initialize it up. With this
approach, the DTPM framework has a very few material to export.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig    |   1 +
 drivers/powercap/dtpm.c     | 155 ++++++++++++++++++++++++++++++++++--
 drivers/powercap/dtpm_cpu.c |   2 +-
 include/linux/dtpm.h        |  21 ++++-
 4 files changed, 171 insertions(+), 8 deletions(-)

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 8242e8c5ed77..b1ca339957e3 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -46,6 +46,7 @@ config IDLE_INJECT
 
 config DTPM
 	bool "Power capping for Dynamic Thermal Power Management (EXPERIMENTAL)"
+	depends on OF
 	help
 	  This enables support for the power capping for the dynamic
 	  thermal power management userspace engine.
diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 0fe70687c198..1611c86de5f5 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -23,6 +23,7 @@
 #include <linux/powercap.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 
 #define DTPM_POWER_LIMIT_FLAG 0
 
@@ -461,19 +462,163 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 	return 0;
 }
 
-static int __init init_dtpm(void)
+static struct dtpm *dtpm_setup_virtual(const struct dtpm_node *hierarchy,
+				       struct dtpm *parent)
+{
+	struct dtpm *dtpm;
+	int ret;
+
+	dtpm = kzalloc(sizeof(*dtpm), GFP_KERNEL);
+	if (!dtpm)
+		return ERR_PTR(-ENOMEM);
+	dtpm_init(dtpm, NULL);
+
+	ret = dtpm_register(hierarchy->name, dtpm, parent);
+	if (ret) {
+		pr_err("Failed to register dtpm node '%s': %d\n",
+		       hierarchy->name, ret);
+		kfree(dtpm);
+		return ERR_PTR(ret);
+	}
+
+	return dtpm;
+}
+
+static struct dtpm *dtpm_setup_dt(const struct dtpm_node *hierarchy,
+				  struct dtpm *parent)
+{
+	struct dtpm_descr *dtpm_descr;
+	struct device_node *np;
+	int ret;
+
+	np = of_find_node_by_path(hierarchy->name);
+	if (!np) {
+		pr_err("Failed to find '%s'\n", hierarchy->name);
+		return ERR_PTR(-ENXIO);
+	}
+
+	for_each_dtpm_table(dtpm_descr) {
+
+		ret = dtpm_descr->setup(parent, np);
+		if (ret) {
+			pr_err("Failed to setup '%s': %d\n", hierarchy->name, ret);
+			of_node_put(np);
+			return ERR_PTR(ret);
+		}
+
+		of_node_put(np);
+	}
+
+	/*
+	 * By returning a NULL pointer, we let know the caller there
+	 * is no child for us as we are a leaf of the tree
+	 */
+	return NULL;
+}
+
+typedef struct dtpm * (*dtpm_node_callback_t)(const struct dtpm_node *, struct dtpm *);
+
+dtpm_node_callback_t dtpm_node_callback[] = {
+	[DTPM_NODE_VIRTUAL] = dtpm_setup_virtual,
+	[DTPM_NODE_DT] = dtpm_setup_dt,
+};
+
+static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
+			       const struct dtpm_node *it, struct dtpm *parent)
+{
+	struct dtpm *dtpm;
+	int i, ret;
+
+	for (i = 0; hierarchy[i].name; i++) {
+
+		if (hierarchy[i].parent != it)
+			continue;
+
+		dtpm = dtpm_node_callback[hierarchy[i].type](&hierarchy[i], parent);
+		if (!dtpm || IS_ERR(dtpm))
+			continue;
+
+		ret = dtpm_for_each_child(hierarchy, &hierarchy[i], dtpm);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * dtpm_create_hierarchy - Create the dtpm hierarchy
+ * @hierarchy: An array of struct dtpm_node describing the hierarchy
+ *
+ * The function is called by the platform specific code with the
+ * description of the different node in the hierarchy. It creates the
+ * tree in the sysfs filesystem under the powercap dtpm entry.
+ *
+ * The expected tree has the format:
+ *
+ * struct dtpm_node hierarchy[] = {
+ *	[0] { .name = "topmost" },
+ *      [1] { .name = "package", .parent = &hierarchy[0] },
+ *      [2] { .name = "/cpus/cpu0", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
+ *      [3] { .name = "/cpus/cpu1", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
+ *      [4] { .name = "/cpus/cpu2", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
+ *      [5] { .name = "/cpus/cpu3", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
+ *	[6] { }
+ * };
+ *
+ * The last element is always an empty one and marks the end of the
+ * array.
+ *
+ * Return: zero on success, a negative value in case of error. Errors
+ * are reported back from the underlying functions.
+ */
+int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 {
+	const struct of_device_id *match;
+	const struct dtpm_node *hierarchy;
 	struct dtpm_descr *dtpm_descr;
+	struct device_node *np;
+	int ret;
+
+	np = of_find_node_by_path("/");
+	if (!np)
+		return -ENODEV;
+
+	match = of_match_node(dtpm_match_table, np);
 
+	of_node_put(np);
+
+	if (!match)
+		return -ENODEV;
+
+	hierarchy = match->data;
+	if (!hierarchy)
+		return -EFAULT;
+
+	ret = dtpm_for_each_child(hierarchy, NULL, NULL);
+	if (ret)
+		return ret;
+	
+	for_each_dtpm_table(dtpm_descr) {
+
+		if (!dtpm_descr->init)
+			continue;
+
+		dtpm_descr->init();
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dtpm_create_hierarchy);
+
+static int __init init_dtpm(void)
+{
 	pct = powercap_register_control_type(NULL, "dtpm", NULL);
 	if (IS_ERR(pct)) {
 		pr_err("Failed to register control type\n");
 		return PTR_ERR(pct);
 	}
 
-	for_each_dtpm_table(dtpm_descr)
-		dtpm_descr->init();
-
 	return 0;
 }
-late_initcall(init_dtpm);
+fs_initcall_sync(init_dtpm);
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index b740866b228d..6bffb44c75aa 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -269,4 +269,4 @@ static int __init dtpm_cpu_init(void)
 	return 0;
 }
 
-DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init);
+DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init, NULL);
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index d37e5d06a357..5a6b31eaf7e4 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -32,23 +32,39 @@ struct dtpm_ops {
 	void (*release)(struct dtpm *);
 };
 
+struct device_node;
+
 typedef int (*dtpm_init_t)(void);
+typedef int (*dtpm_setup_t)(struct dtpm *, struct device_node *);
 
 struct dtpm_descr {
 	dtpm_init_t init;
+	dtpm_setup_t setup;
+};
+
+enum DTPM_NODE_TYPE {
+	DTPM_NODE_VIRTUAL = 0,
+	DTPM_NODE_DT,
+};
+
+struct dtpm_node {
+	enum DTPM_NODE_TYPE type;
+	const char *name;
+	struct dtpm_node *parent;
 };
 
 /* Init section thermal table */
 extern struct dtpm_descr __dtpm_table[];
 extern struct dtpm_descr __dtpm_table_end[];
 
-#define DTPM_TABLE_ENTRY(name, __init)				\
+#define DTPM_TABLE_ENTRY(name, __init, __setup)			\
 	static struct dtpm_descr __dtpm_table_entry_##name	\
 	__used __section("__dtpm_table") = {			\
 		.init = __init,					\
+		.setup = __setup,				\
 	}
 
-#define DTPM_DECLARE(name, init)	DTPM_TABLE_ENTRY(name, init)
+#define DTPM_DECLARE(name, init, setup)	DTPM_TABLE_ENTRY(name, init, setup)
 
 #define for_each_dtpm_table(__dtpm)	\
 	for (__dtpm = __dtpm_table;	\
@@ -70,4 +86,5 @@ void dtpm_unregister(struct dtpm *dtpm);
 
 int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
 
+int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table);
 #endif
-- 
2.25.1

