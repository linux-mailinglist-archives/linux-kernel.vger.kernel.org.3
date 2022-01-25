Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6356249BA42
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451038AbiAYRVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587626AbiAYRSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:18:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B99DC0613E6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:18:40 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n8so25845353wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WvX/s8bbTEktU4nVsA2bYW4MFssxw4eAYf+UAFIZXJk=;
        b=aFEJkDCNwYf3UC4SHwZnnwU8qzZG3Oh8QnYPA/JKXnrv0rYkLvf3bzoymOYvF4vU70
         SI2n+ibZVnfwIru9Gk7Zm0EUAiyFchvKt1E6nXMpSqcx4+bigMXKDfT3kdFW19+Np0p/
         y28ICIzvDxjQ3R9MuxLDlgLLrbwVWY1d02jjnvsxKa8FLC7L+PdcEFTipUElG46Ij4gi
         +iCYApa2vfydHFRaAEjuQqoV0j+vT6nZb5is85rIby32x73+KsHtqRNKXRP8m8JGXPwv
         0p6oslZg8mXf0PmVU4I7H1u3A1RiiEafYAnkgdFbi4LSKcUNu/EIXo0QoOEfvK8KHNAG
         D8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WvX/s8bbTEktU4nVsA2bYW4MFssxw4eAYf+UAFIZXJk=;
        b=VZTE1RwCsRoa7TS8OxCYre1I6U6ekf+11rUkALrL6FRP2ellE1hbKsung2QAExIM1f
         zBmbKaQVKxE+uhv8Ct2HjQ2+xDMnLMdSSiyYKmvyrrWN5Kss2OYnfWAhxGGiCqapiQ8V
         RGEZrtGKRsyMLHtw7Xj791iyWCdgMxZ50Zb67TBs4VoP+Knq+ABY+PC1seJfwTqutrMG
         ND8M1YjVmeU8peoyh2vcNQiNbJTWloSDQjqUkaop4qswNA0y3o5PapjSTJdf7wMW26GU
         WS3sCrqEYcGCYtvWu0ZeTkNjhFSNhp/OYho8F8S2pDWJ8IV5IWLyfTh0BzSOE36x9lfy
         7vAw==
X-Gm-Message-State: AOAM5325ulsjmiFhhSYH5wOzaiN0qb6XUesiW+DyNazOs8/EUVkg4Anf
        QPlWV9+g6kxik/PMo8Z9ow72/g==
X-Google-Smtp-Source: ABdhPJwDB1k67p1xeoC/IyzRSlVdfgPPKVoaUXh0WUhoSf6YYRoGhugkBLidJ6Vcw6qWyAC3846+Yg==
X-Received: by 2002:a7b:c923:: with SMTP id h3mr3915978wml.122.1643131118487;
        Tue, 25 Jan 2022 09:18:38 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e])
        by smtp.gmail.com with ESMTPSA id t18sm17561901wri.34.2022.01.25.09.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:18:37 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     robh@kernel.org, lukasz.luba@arm.com, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v7 5/5] rockchip/soc/drivers: Add DTPM description for rk3399
Date:   Tue, 25 Jan 2022 18:18:09 +0100
Message-Id: <20220125171809.1273269-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220125171809.1273269-1-daniel.lezcano@linaro.org>
References: <20220125171809.1273269-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTPM framework does support now the hierarchy description.

The platform specific code can call the hierarchy creation function
with an array of struct dtpm_node pointing to their parent.

This patch provides a description of the big / Little CPUs and the
GPU and tie them together under a virtual 'package' name. Only rk3399 is
described now.

The description could be extended in the future with the memory
controller with devfreq.

The description is always a module and it describes the soft
dependencies. The userspace has to load the softdeps module in the
right order.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/soc/rockchip/Kconfig  |  8 +++++
 drivers/soc/rockchip/Makefile |  1 +
 drivers/soc/rockchip/dtpm.c   | 59 +++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 drivers/soc/rockchip/dtpm.c

diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index 25eb2c1e31bb..6dc017f02431 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -34,4 +34,12 @@ config ROCKCHIP_PM_DOMAINS
 
           If unsure, say N.
 
+config ROCKCHIP_DTPM
+	tristate "Rockchip DTPM hierarchy"
+	depends on DTPM && DRM_PANFROST && m
+	help
+	 Describe the hierarchy for the Dynamic Thermal Power
+	 Management tree on this platform. That will create all the
+	 power capping capable devices.
+
 endif
diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
index 875032f7344e..05f31a4e743c 100644
--- a/drivers/soc/rockchip/Makefile
+++ b/drivers/soc/rockchip/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_ROCKCHIP_GRF) += grf.o
 obj-$(CONFIG_ROCKCHIP_IODOMAIN) += io-domain.o
 obj-$(CONFIG_ROCKCHIP_PM_DOMAINS) += pm_domains.o
+obj-$(CONFIG_ROCKCHIP_DTPM) += dtpm.o
diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
new file mode 100644
index 000000000000..0b73a9cba954
--- /dev/null
+++ b/drivers/soc/rockchip/dtpm.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2021 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * DTPM hierarchy description
+ */
+#include <linux/dtpm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+static struct dtpm_node __initdata rk3399_hierarchy[] = {
+	[0]{ .name = "rk3399",
+	     .type = DTPM_NODE_VIRTUAL },
+	[1]{ .name = "package",
+	     .type = DTPM_NODE_VIRTUAL,
+	     .parent = &rk3399_hierarchy[0] },
+	[2]{ .name = "/cpus/cpu@0",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[3]{ .name = "/cpus/cpu@1",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[4]{ .name = "/cpus/cpu@2",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[5]{ .name = "/cpus/cpu@3",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[6]{ .name = "/cpus/cpu@100",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[7]{ .name = "/cpus/cpu@101",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[8]{ .name = "/gpu@ff9a0000",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[9]{ },
+};
+
+static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
+        { .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
+        {},
+};
+
+static int __init rockchip_dtpm_init(void)
+{
+	return dtpm_create_hierarchy(rockchip_dtpm_match_table);
+}
+module_init(rockchip_dtpm_init);
+
+MODULE_SOFTDEP("pre: panfrost cpufreq-dt");
+MODULE_DESCRIPTION("Rockchip DTPM driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:dtpm");
+MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org");
-- 
2.25.1

