Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95B74936B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352690AbiASI6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352736AbiASI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:58:16 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B18C061755
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:58:15 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id h206-20020a1c21d7000000b0034d95625e1fso4676353wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WvX/s8bbTEktU4nVsA2bYW4MFssxw4eAYf+UAFIZXJk=;
        b=MrImzy9uu0iUhs/Xqm9UKJkxbxm5+Qqi8tQgEMF2ucgXP8LfgYA5r003iQkJ03ngW0
         T6EAqMxa+jwHT2kUV4UkZbAa9mPEmb2UJTiKGvT3X1Vqx/hDuUZFm3duOzuXEkaCtTg8
         Qhcakxx3behCG7oNL681AM7jxCA2D4LcsQ8j/2hVCjUWGBBZqn6iBdlEuaZRzfPJ2eXj
         Z9cWb20P7X0gv1LaQqIvqfHJTEMufI/VwH6OXs7HspX72zdeKrIiWS2iHify/xaKdI1j
         6qlonQq2+YjufnyKlRx7rn7ccCHjWdBHikstr8PneqP3fgB2Jl0YmTvTvDsUdfzsbCt9
         IZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WvX/s8bbTEktU4nVsA2bYW4MFssxw4eAYf+UAFIZXJk=;
        b=Zl/z9gECzHVdbbMNEmwLCWYNI95Cr5V/ngNhPqj1GTI8IJiqbkIO3kVtKcUO4hJThl
         btRUkoadBw6nSDQanpMBZ3PMlz6LyIzr6rWMHbjclq5nGyn6kBAJUMoDQD2dVP8KwwHI
         Fx7RKQX901VHAAwir5DbKBc8zUpbc9dBeG5hvGDlDH1SepJCAIbB5HuZc2owmEcitMOr
         4r3UtMUONKKe9ryo6zKLsqMtzw++oT0kQpuSfKtovX23+iwD5lmK7Ls8PYr4Xk9EHX9+
         ECwA/l8BtJYeOwmru/AMlJ20txlU12doAgoeKiMWgBSLq9JnD3c48ZMrG+6ZB5KBLEO8
         79FA==
X-Gm-Message-State: AOAM5300j3DtS2dl/Dlnu0zDjdkKcma2Si4ThZ+Bz3/AF0giqSqUkpji
        TwUp95hU28VzyALJRj5om20ybA==
X-Google-Smtp-Source: ABdhPJzS/HE6TlLSUbXmGDVdnyNVZFx19twADA65K11Gxt6VSWu7Z06pl2DSyoxEbb76fETADXeCTw==
X-Received: by 2002:a1c:7914:: with SMTP id l20mr2394454wme.26.1642582694514;
        Wed, 19 Jan 2022 00:58:14 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:ef34:de48:dc4e:ad87])
        by smtp.gmail.com with ESMTPSA id 10sm4491454wmc.44.2022.01.19.00.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 00:58:13 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     robh@kernel.org, lukasz.luba@arm.com, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v6 5/5] rockchip/soc/drivers: Add DTPM description for rk3399
Date:   Wed, 19 Jan 2022 09:57:19 +0100
Message-Id: <20220119085719.1357874-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119085719.1357874-1-daniel.lezcano@linaro.org>
References: <20220119085719.1357874-1-daniel.lezcano@linaro.org>
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

