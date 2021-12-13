Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1219473195
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbhLMQWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbhLMQWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:22:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A231C0617A1;
        Mon, 13 Dec 2021 08:22:03 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so11929684wmc.2;
        Mon, 13 Dec 2021 08:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6YER+BdZLVh9vSNswdDWSR9+jpZxoPtB4QqBlBxhsw=;
        b=GZEaAZkcT6FU/DjWgTBU031hRvI00IMhty+4sB3C2dclXSA4YBD7uRWH0Zfumh4lNr
         rxsEWjwo1ClOe8EYFV5cgB2EsPQMa2uZps2YJoqwuf51VOEbjr9GRHEHffeZ9tF28QV+
         UrjCwm2fuIsdQvFepPRsKweGkaYnPipBrWqZBgOjpIP+4Jweo4q0AFWHhYR4otIIPZAH
         0EXfenWzPwlCrhEOjeG6SGjYH5cuUWAV2Z4gJKR8Ne7o6pHgKqMqj40qWDKIL80dMy0h
         c4SDjTaeZ+C8YuCfBxxjJKR5afx5dc1sEa6aKFqWHO1+4WzeFVj9UxXdfMj1ShJOHyib
         cM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6YER+BdZLVh9vSNswdDWSR9+jpZxoPtB4QqBlBxhsw=;
        b=xa0unfophbzh6pxC6/TQgBIF28Dd2D9K8ViDk8vHJbMyI94gw3yYiGW5ZxLJvXeKjR
         Bvoefm40OUslhgQrYN61HbLfC9tvs7VhWd89/Q/5QRBpor0ZutCDgG47EbPPcZuAQD6c
         PL3pUTAtNB4iQ6IfQksvwSt3P5r0QUhDpngqSt+HrZpiIPVs9vaSZzs5bOT2NpRuJbIA
         1Gk9H8vK5KJXsTLPtvLd7HyrGGoB/sv3otQGVWMuI4ZjpmDJh6Dma+DBcTrAbkOAdLo3
         LLmFVKd/v7h+Rh1MXyAaepq50fSuZLuWJ1awneatS5u3sn7t425bCcagj0tpFxEiRegS
         siLg==
X-Gm-Message-State: AOAM531nc4Mh4Xj5ijnC4JVUU8jSV5YLUBipLTcqZE9nthAGvJ/xF/of
        lBFhxOs4BO/KSWBkUywLcGE=
X-Google-Smtp-Source: ABdhPJwYa+SklZbDZixva0JX7nYuSjTA9f2kn6umNChnE88vJwnsX09Jd8nicBCcxtqxZjiTJhfJiA==
X-Received: by 2002:a1c:6a04:: with SMTP id f4mr39007224wmc.56.1639412521673;
        Mon, 13 Dec 2021 08:22:01 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id j40sm7773271wms.16.2021.12.13.08.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:22:01 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] memory: tegra: Add Tegra234 support
Date:   Mon, 13 Dec 2021 17:21:48 +0100
Message-Id: <20211213162151.916523-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213162151.916523-1-thierry.reding@gmail.com>
References: <20211213162151.916523-1-thierry.reding@gmail.com>
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

