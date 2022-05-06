Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2443251D8EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392430AbiEFN0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352745AbiEFN0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:26:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD48689B3;
        Fri,  6 May 2022 06:22:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u3so10048509wrg.3;
        Fri, 06 May 2022 06:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Haj+pN6JlXocxjPEnNzE2m0NqLyZQmn83EhQMLGbRWo=;
        b=DMOza813W8huQfb3i5WTrsdE3XdP7MSFqKsvqeg5g3izBMaMjmaIvM56RdHFGi/4rL
         zf0tgZf2J7L+JIEeoYQx1UTYx7c6/opgV3DmDgV4ZxC/M/p2yRvr5/TvyP2ZFwPL9hxu
         iOpl/3XHwd4oeRezu3kd2HI/SUG0TpX6ra+MIFB3Bpw1WnwJ+RZRluG2yaF68NTfOTsh
         y8x4tKwFIZEnZVjpzyE6yJ9pK4xwXcCELfuz/YD9t8FGzK+seGUngTyGKJUks27vpKgU
         txtM5O01sVlffu/i9Ohp53yokAQA4LCQ/e3qLljSVubUdCF4OsE/jhKnR+zrQGI4wqXD
         yryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Haj+pN6JlXocxjPEnNzE2m0NqLyZQmn83EhQMLGbRWo=;
        b=dcVNd6NBeinygGurCw5mPNvwY6Afz6CFPpA9n+k0Tln415YkD0/+0t1uUD05td6+TD
         PAlCvZGrpCTRb/ceDwKqGEScYr0sp/7ZE25P5L+ZghQTVDhF+YpbOFe6s/CxUlbNZ8VE
         PslOgqp5QHe0pXfUrde+/4BYxKN81M4OqnCfZHtM2XUDGeEdxs9L1Jb90aVBk9wRnhp6
         sPlzlRYGXkXtYWhEIfcsIHofdFfO65amEFxuVHWln/R/LwTRUUnzL4RI8w+gzdgi2har
         2b8kGxm0gLvobAQKAxjo5szgFP1YyXEsnFcloj2SLoXl0eF1pwjOLSlMPdbBLMKDMTFL
         uqbw==
X-Gm-Message-State: AOAM532VdKZtRg7cFF1yTguvxoNDT73HXCkre721y2u+2Z6BSp46MNTR
        /U6ks+Fn4AIqaPYDVU45Dnc=
X-Google-Smtp-Source: ABdhPJx7w3nSQ9K4ad7pmFncFAJIsXASVSvFd4DPeQ7DQr8TiluwbBT9dwym34WjvWw4XkBWWoxorg==
X-Received: by 2002:a5d:64ed:0:b0:20c:7407:681e with SMTP id g13-20020a5d64ed000000b0020c7407681emr2780665wri.408.1651843357930;
        Fri, 06 May 2022 06:22:37 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c17-20020a7bc011000000b003942a244f40sm9240703wmb.25.2022.05.06.06.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 06:22:37 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] memory: tegra: Add Tegra234 support
Date:   Fri,  6 May 2022 15:22:26 +0200
Message-Id: <20220506132230.3910539-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132230.3910539-1-thierry.reding@gmail.com>
References: <20220506132230.3910539-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/memory/tegra/Makefile       |  2 +
 drivers/memory/tegra/mc.c           |  3 ++
 drivers/memory/tegra/mc.h           |  7 ++-
 drivers/memory/tegra/tegra186-emc.c |  3 ++
 drivers/memory/tegra/tegra234.c     | 81 +++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 drivers/memory/tegra/tegra234.c

diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
index c992e87782d2..0750847dac3c 100644
--- a/drivers/memory/tegra/Makefile
+++ b/drivers/memory/tegra/Makefile
@@ -9,6 +9,7 @@ tegra-mc-$(CONFIG_ARCH_TEGRA_132_SOC) += tegra124.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_194_SOC) += tegra186.o tegra194.o
+tegra-mc-$(CONFIG_ARCH_TEGRA_234_SOC) += tegra186.o tegra234.o
 
 obj-$(CONFIG_TEGRA_MC) += tegra-mc.o
 
@@ -19,5 +20,6 @@ obj-$(CONFIG_TEGRA210_EMC_TABLE) += tegra210-emc-table.o
 obj-$(CONFIG_TEGRA210_EMC) += tegra210-emc.o
 obj-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186-emc.o
 obj-$(CONFIG_ARCH_TEGRA_194_SOC) += tegra186-emc.o
+obj-$(CONFIG_ARCH_TEGRA_234_SOC) += tegra186-emc.o
 
 tegra210-emc-y := tegra210-emc-core.o tegra210-emc-cc-r21021.o
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
2.35.1

