Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF4470631
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbhLJQvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243970AbhLJQv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:51:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A26C061746;
        Fri, 10 Dec 2021 08:47:52 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso9453201wms.3;
        Fri, 10 Dec 2021 08:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6YER+BdZLVh9vSNswdDWSR9+jpZxoPtB4QqBlBxhsw=;
        b=Ph/sQCv30MJpDjmClA7xuzmDyn1dgm0pUUQQDumKE+hSKvUnuRzeuLrRACiF8jBoY5
         DrE/7WZno1Km6LgXXk8rtqgUhtriSsd/nv3+7D+xjAAmB7rSb0n/UnTJfaWyw1WHaY6B
         0tK/9zRLOBckSWJCazPEYWSrsC0omcsjBQr8eDK5zSKqPDfMHpiJnF7j2qtd+a6WouPq
         4dQblAoOsfXx/wnaGZlZt/CeC5xFT/+tObPgtFRlZTRJulolmIkuNsdo5WdpT3njPOIk
         UG9KaWPjfYm6AWek9hQp41qZTgpKygRzhVn8y+UScEK/npHKeQIVfCPYcXENJCMRxegh
         hTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6YER+BdZLVh9vSNswdDWSR9+jpZxoPtB4QqBlBxhsw=;
        b=lErKfBnhLSxzm5WEZt6PsINPy1h/1YsCpxTRfa3t5Z8S1Ch6re3j6tv4tbrIAI8/tP
         Rx5O/zhUXZ4372Wa6/uL0TJXoddgM9ngkpcJiVA1mLcQkkWcJBE/5M5FVhkmlnFTVAF3
         SK0kH3ODnZ8B3Jue4umVxEGAwxKWSxJ2RfWv1kok7HkicwOjw1H68CTPlLzxONjt/49F
         AHf6I5rWlh3DOZe9bXPPqAoexsq4JJXtlOE4vw5gYAlGJYK0A/Bna+cLZJiO4tn+Hid8
         P5XXjBGZjM1N6qXfCwv934kS6lAbFOAP/aPxb6hGihADjUUP8jKX4AaIlqDBHGXH8mmU
         LvmQ==
X-Gm-Message-State: AOAM532eQ5qD6mLPs6n8BKo+7WXeha79CAli4pHjbumzViHCF0MA3NIE
        OOycWp27xHSWlErtASqJqEaOSVgDmvUiGQ==
X-Google-Smtp-Source: ABdhPJzr+1O7WBWqBWagrFvezSPLMDzgMRKHwFawdfgNAEsC4XDjdhtsvIJrvVgbPESEQwAZVB0MUQ==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr17895586wma.121.1639154871386;
        Fri, 10 Dec 2021 08:47:51 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id m125sm11980308wmm.39.2021.12.10.08.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:47:50 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] memory: tegra: Add Tegra234 support
Date:   Fri, 10 Dec 2021 17:47:38 +0100
Message-Id: <20211210164741.881161-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210164741.881161-1-thierry.reding@gmail.com>
References: <20211210164741.881161-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The memory controller and external memory controller found on Tegra234
is similar to the version found on earlier SoCs but supports a number of
new memory clients.

Add initial memory client definitions for the Tegra234 so that the SMMU
stream ID override registers can be properly programmed at boot time.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/Makefile       |  1 +
 drivers/memory/tegra/mc.c           |  3 ++
 drivers/memory/tegra/mc.h           |  7 ++-
 drivers/memory/tegra/tegra186-emc.c |  3 ++
 drivers/memory/tegra/tegra234.c     | 81 +++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 drivers/memory/tegra/tegra234.c

diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
index c992e87782d2..1df0b43e40b1 100644
--- a/drivers/memory/tegra/Makefile
+++ b/drivers/memory/tegra/Makefile
@@ -9,6 +9,7 @@ tegra-mc-$(CONFIG_ARCH_TEGRA_132_SOC) += tegra124.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_194_SOC) += tegra186.o tegra194.o
+tegra-mc-$(CONFIG_ARCH_TEGRA_194_SOC) += tegra186.o tegra234.o
 
 obj-$(CONFIG_TEGRA_MC) += tegra-mc.o
 
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 44b4a4080920..bf3abb6d8354 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -44,6 +44,9 @@ static const struct of_device_id tegra_mc_of_match[] = {
 #endif
 #ifdef CONFIG_ARCH_TEGRA_194_SOC
 	{ .compatible = "nvidia,tegra194-mc", .data = &tegra194_mc_soc },
+#endif
+#ifdef CONFIG_ARCH_TEGRA_234_SOC
+	{ .compatible = "nvidia,tegra234-mc", .data = &tegra234_mc_soc },
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 1e492989c363..062886e94c04 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -137,6 +137,10 @@ extern const struct tegra_mc_soc tegra186_mc_soc;
 extern const struct tegra_mc_soc tegra194_mc_soc;
 #endif
 
+#ifdef CONFIG_ARCH_TEGRA_234_SOC
+extern const struct tegra_mc_soc tegra234_mc_soc;
+#endif
+
 #if defined(CONFIG_ARCH_TEGRA_3x_SOC) || \
     defined(CONFIG_ARCH_TEGRA_114_SOC) || \
     defined(CONFIG_ARCH_TEGRA_124_SOC) || \
@@ -147,7 +151,8 @@ extern const struct tegra_mc_ops tegra30_mc_ops;
 #endif
 
 #if defined(CONFIG_ARCH_TEGRA_186_SOC) || \
-    defined(CONFIG_ARCH_TEGRA_194_SOC)
+    defined(CONFIG_ARCH_TEGRA_194_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_234_SOC)
 extern const struct tegra_mc_ops tegra186_mc_ops;
 #endif
 
diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 746c4ef2c0af..54b47ca33483 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -272,6 +272,9 @@ static const struct of_device_id tegra186_emc_of_match[] = {
 #endif
 #if defined(CONFIG_ARCH_TEGRA_194_SOC)
 	{ .compatible = "nvidia,tegra194-emc" },
+#endif
+#if defined(CONFIG_ARCH_TEGRA_234_SOC)
+	{ .compatible = "nvidia,tegra234-emc" },
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
new file mode 100644
index 000000000000..45efc5139960
--- /dev/null
+++ b/drivers/memory/tegra/tegra234.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#include <soc/tegra/mc.h>
+
+#include <dt-bindings/memory/tegra234-mc.h>
+
+#include "mc.h"
+
+static const struct tegra_mc_client tegra234_mc_clients[] = {
+	{
+		.id = TEGRA234_MEMORY_CLIENT_SDMMCRAB,
+		.name = "sdmmcrab",
+		.sid = TEGRA234_SID_SDMMC4,
+		.regs = {
+			.sid = {
+				.override = 0x318,
+				.security = 0x31c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_SDMMCWAB,
+		.name = "sdmmcwab",
+		.sid = TEGRA234_SID_SDMMC4,
+		.regs = {
+			.sid = {
+				.override = 0x338,
+				.security = 0x33c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_BPMPR,
+		.name = "bpmpr",
+		.sid = TEGRA234_SID_BPMP,
+		.regs = {
+			.sid = {
+				.override = 0x498,
+				.security = 0x49c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_BPMPW,
+		.name = "bpmpw",
+		.sid = TEGRA234_SID_BPMP,
+		.regs = {
+			.sid = {
+				.override = 0x4a0,
+				.security = 0x4a4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_BPMPDMAR,
+		.name = "bpmpdmar",
+		.sid = TEGRA234_SID_BPMP,
+		.regs = {
+			.sid = {
+				.override = 0x4a8,
+				.security = 0x4ac,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_BPMPDMAW,
+		.name = "bpmpdmaw",
+		.sid = TEGRA234_SID_BPMP,
+		.regs = {
+			.sid = {
+				.override = 0x4b0,
+				.security = 0x4b4,
+			},
+		},
+	},
+};
+
+const struct tegra_mc_soc tegra234_mc_soc = {
+	.num_clients = ARRAY_SIZE(tegra234_mc_clients),
+	.clients = tegra234_mc_clients,
+	.num_address_bits = 40,
+	.ops = &tegra186_mc_ops,
+};
-- 
2.34.1

