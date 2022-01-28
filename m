Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D16749FE2D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350237AbiA1Qga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350198AbiA1QgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:36:22 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE64C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:36:22 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s9so11920953wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99dERtWOZtbIzdgryv5Ia92S7CWD3+jik7G8TWPvHK4=;
        b=M56W1cYQkxO416lN+jHB1tezGrT0pfoCHG+V30MKezZeGa1pynMj+KMFaFb+TC3xtR
         QMogfQHJDufhRqxBR6KnAJ+xQF7iDAHcaL6BHjZb6W/t92XCBNdgp5zou1XR178MrL4z
         s5FbTVaCgtijqYCITJBmcuM2L2B5PwH9jDR/fAJrnrdt0vx//WVR71e2M8M8NCYLjDbW
         h+w/tXk883nHnYyi9FXF9ylMdrOSRfI7SARFZKXXO11REESQ44wxz971S/YF4HYsH792
         W7EZTGUfv9qcua4OiCgY61fRq35io87LL5TW8Ovtjzq3anlJRGCuSS2YRqLemAlcSh1Q
         I5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99dERtWOZtbIzdgryv5Ia92S7CWD3+jik7G8TWPvHK4=;
        b=lwzcV+GrjTxfeNQkIRBYLxcUPqVNY1Z95wEN0huDpM8dTVwjMgQaEOQPVhvSMP0Lpl
         5TdMcHT+i/8AErfLHQLReijsiVuY6vPg0EkOsNhojcYAmPY6sGcU66rwyL/b/YPlCJyY
         SBNJ1+mAlEKxAGfhMBmIHb0hUGSp+6vP85UfoFQYOUhGy00ziKHyPe9YknCpQX9zIgHm
         DZ+HD2iN6v+1PzbejvJTBNGKjmcUOHJZ5nSdx8ddzeaVi5fobpbpUU6RPwX6QKuRhYtt
         zqHP+hXqAnE9wZjFyUDG4TK9+BsW6Rf/Uf6GhyHodLAByWuNrZEWQJjyqE0ZcgHKB/4B
         Al3A==
X-Gm-Message-State: AOAM531ZMr4uf8o+VLs6vEYL4DslBzKpv596D0laFEAAUXy6TWhQAGWq
        A1Sty0Ny8tTquxAdtfQqaMiQug==
X-Google-Smtp-Source: ABdhPJwxf8JZPd4soZH8tiFA70PMwbDqUAwzX9iu+50eMktnT6hbnD1to8hEQRhEd71OIDQlFPrA1g==
X-Received: by 2002:adf:f141:: with SMTP id y1mr7683089wro.104.1643387780869;
        Fri, 28 Jan 2022 08:36:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:f39:b962:8b8e:9851])
        by smtp.gmail.com with ESMTPSA id m6sm5734745wrw.54.2022.01.28.08.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:36:20 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, robh@kernel.org, lukasz.luba@arm.com,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v8 5/5] rockchip/soc/drivers: Add DTPM description for rk3399
Date:   Fri, 28 Jan 2022 17:35:37 +0100
Message-Id: <20220128163537.212248-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128163537.212248-1-daniel.lezcano@linaro.org>
References: <20220128163537.212248-1-daniel.lezcano@linaro.org>
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
Reviewed-by; Heiko Stuebner <heiko@sntech.de>
---
Changelog:
   V8:
   - Add '/* sentinel */' in the last array entry
   - Remove Panfrost dependency in the dtpm rockchip module's Kconfig

   V7:
   - No changes

   V6:
   - Made rk3399 always as a module and added module softdeps

   V5:
   - Module creation
---
drivers/soc/rockchip/Kconfig  |  8 +++++
 drivers/soc/rockchip/Makefile |  1 +
 drivers/soc/rockchip/dtpm.c   | 59 +++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 drivers/soc/rockchip/dtpm.c

diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index 25eb2c1e31bb..156ac0e0c8fe 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -34,4 +34,12 @@ config ROCKCHIP_PM_DOMAINS
 
           If unsure, say N.
 
+config ROCKCHIP_DTPM
+	tristate "Rockchip DTPM hierarchy"
+	depends on DTPM && m
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
index 000000000000..ebebb748488b
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
+	[9]{ /* sentinel */ }
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

