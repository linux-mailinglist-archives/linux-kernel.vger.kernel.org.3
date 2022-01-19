Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5037C4936AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352765AbiASI6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352697AbiASI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:58:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7FFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:58:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 25-20020a05600c231900b003497473a9c4so12674801wmo.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atZNjpF7zYHFieT57+G/il+EXJIC24qqmVdOWfTnLb0=;
        b=MCfOHB39eiI7Ibv6QlI9vmOGN2kYCVo83wKPnwbjuKN0OXF/dTOBctqvn24nv+m7NM
         QleT/WXK3XEDSmxqrdspod/egtEM1prZVC6ignvd58slgR9DZI3pHLM/BGCdKzUont2w
         ylETD5GPc9DdXPjuzWgGqESTHv/3UnXAFza9ktN0wLJ0U9XSbEsFG4TSH1WluwaqcU/s
         VH8Gd9YTAbzcGfF62dtxeXLJVEimgXagrBd791G4Z2BA2i8ma19+2twwbGRXdLUBxwOI
         AN/oiwqYoXUMjmtUzY25qVViw8XKm6YjiAybPlxasgPO2RlOiF5hKRpPnd0YfHDrnJdt
         gDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atZNjpF7zYHFieT57+G/il+EXJIC24qqmVdOWfTnLb0=;
        b=FcK+VHBVRbRfry/Wd0NDwjCRmub0rDYN8aOvQjNI+bMtxHAaNZ13zucTHZCFoFBq07
         1wEAdwWuBLRw159Q7ScJ+6yPgKSXdigJcGJxjQ/Yx/P2/uemeHM4om8x3ssaFNpUOF7e
         G85zYj2Yyx5NlrpCsSgNDlTm/MDGslyKw4NNRCYvQVm1q9KsWxt5r6teg54MAhYx8Sbw
         dEcy2nH06TTdWzaoEOVWAE8wyAElv7u4PUDG5HjGqgzVRYxlAlNZeXeDWeXCA0LlXqPX
         g0917LhB1g8EpxUEbkzqEAfaOTtpoHHAiYcsr2X4eWJNFM4SpSSw8+DCfuafT6lzOsag
         MoJA==
X-Gm-Message-State: AOAM531rG4xOqBDFuZCsRkd7IWQsZ4v9eq//bHoDyx5oMUp3POYNGFAZ
        tC17RsVywLY9A9JSH0C6dnpVrw==
X-Google-Smtp-Source: ABdhPJzmkf+OyQ1JEXuiDkudNqk44IN+BPoqxtHCMujNDt+f5jOD2JQUIobApC/XPbCbA3MHGmz7dg==
X-Received: by 2002:a5d:6d04:: with SMTP id e4mr10237488wrq.273.1642582681580;
        Wed, 19 Jan 2022 00:58:01 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:ef34:de48:dc4e:ad87])
        by smtp.gmail.com with ESMTPSA id 10sm4491454wmc.44.2022.01.19.00.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 00:58:01 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     robh@kernel.org, lukasz.luba@arm.com, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH v6 2/5] powercap/drivers/dtpm: Add hierarchy creation
Date:   Wed, 19 Jan 2022 09:57:16 +0100
Message-Id: <20220119085719.1357874-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119085719.1357874-1-daniel.lezcano@linaro.org>
References: <20220119085719.1357874-1-daniel.lezcano@linaro.org>
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

In order to ensure a nice self-encapsulation, the DTPM subsys array
contains a couple of initialization functions, one to setup the DTPM
backend and one to initialize it up. With this approach, the DTPM
framework has a very few material to export.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig |   1 +
 drivers/powercap/dtpm.c  | 168 ++++++++++++++++++++++++++++++++++++++-
 include/linux/dtpm.h     |  15 ++++
 3 files changed, 181 insertions(+), 3 deletions(-)

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
index 0e5c93443c70..10032f7132c4 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -23,6 +23,7 @@
 #include <linux/powercap.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 
 #include "dtpm_subsys.h"
 
@@ -463,14 +464,175 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 	return 0;
 }
 
-static int __init init_dtpm(void)
+static struct dtpm *dtpm_setup_virtual(const struct dtpm_node *hierarchy,
+				       struct dtpm *parent)
 {
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
+	struct device_node *np;
+	int i, ret;
+
+	np = of_find_node_by_path(hierarchy->name);
+	if (!np) {
+		pr_err("Failed to find '%s'\n", hierarchy->name);
+		return ERR_PTR(-ENXIO);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
+
+		if (!dtpm_subsys[i]->setup)
+			continue;
+
+		ret = dtpm_subsys[i]->setup(parent, np);
+		if (ret) {
+			pr_err("Failed to setup '%s': %d\n", dtpm_subsys[i]->name, ret);
+			of_node_put(np);
+			return ERR_PTR(ret);
+		}
+	}
+
+	of_node_put(np);
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
+ *	[0] { .name = "topmost", type =  DTPM_NODE_VIRTUAL },
+ *	[1] { .name = "package", .type = DTPM_NODE_VIRTUAL, .parent = &hierarchy[0] },
+ *	[2] { .name = "/cpus/cpu0", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
+ *	[3] { .name = "/cpus/cpu1", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
+ *	[4] { .name = "/cpus/cpu2", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
+ *	[5] { .name = "/cpus/cpu3", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
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
+{
+	const struct of_device_id *match;
+	const struct dtpm_node *hierarchy;
+	struct device_node *np;
+	int i, ret;
+
+	if (pct)
+		return -EBUSY;
+
 	pct = powercap_register_control_type(NULL, "dtpm", NULL);
 	if (IS_ERR(pct)) {
 		pr_err("Failed to register control type\n");
-		return PTR_ERR(pct);
+		ret = PTR_ERR(pct);
+		goto out_pct;
+	}
+
+	ret = -ENODEV;
+	np = of_find_node_by_path("/");
+	if (!np)
+		goto out_err;
+
+	match = of_match_node(dtpm_match_table, np);
+
+	of_node_put(np);
+
+	if (!match)
+		goto out_err;
+
+	hierarchy = match->data;
+	if (!hierarchy) {
+		ret = -EFAULT;
+		goto out_err;
+	}
+
+	ret = dtpm_for_each_child(hierarchy, NULL, NULL);
+	if (ret)
+		goto out_err;
+	
+	for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
+
+		if (!dtpm_subsys[i]->init)
+			continue;
+
+		ret = dtpm_subsys[i]->init();
+		if (ret)
+			pr_info("Failed to initialze '%s': %d",
+				dtpm_subsys[i]->name, ret);
 	}
 
 	return 0;
+
+out_err:
+	powercap_unregister_control_type(pct);
+out_pct:
+	pct = NULL;
+	
+	return ret;
 }
-late_initcall(init_dtpm);
+EXPORT_SYMBOL_GPL(dtpm_create_hierarchy);
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index 506048158a50..f7a25c70dd4c 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -32,9 +32,23 @@ struct dtpm_ops {
 	void (*release)(struct dtpm *);
 };
 
+struct device_node;
+
 struct dtpm_subsys_ops {
 	const char *name;
 	int (*init)(void);
+	int (*setup)(struct dtpm *, struct device_node *);
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
 
 static inline struct dtpm *to_dtpm(struct powercap_zone *zone)
@@ -52,4 +66,5 @@ void dtpm_unregister(struct dtpm *dtpm);
 
 int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
 
+int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table);
 #endif
-- 
2.25.1

