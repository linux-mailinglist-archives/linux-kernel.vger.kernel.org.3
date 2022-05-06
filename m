Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0151D8F7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392465AbiEFN1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392445AbiEFN1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:27:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33D469729;
        Fri,  6 May 2022 06:23:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso3810934wmq.1;
        Fri, 06 May 2022 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Haj+pN6JlXocxjPEnNzE2m0NqLyZQmn83EhQMLGbRWo=;
        b=WRUROltatrMECKYrCYeUq5TSl75j4AsvjghB2KUd/R8VL1hjYAdffn7Ny7kLmgyyiA
         eJD2ZjrxqwmPYb8MboyTS4UBISnXi3KESXKT6unurnNMtprA2T50Bw7zdGdoeO5VNEJL
         o5H7lNZmW+CZx+SRnHj1Istn0+hFZPhCwB3Gx1b1zoDpw7IjdCb2d+OEcYptnUJC3meZ
         EjnmW6H1s4O53tzAL7UReUnM0BbeRsLT5cDZiafc2mYVtyZLFjfDSIx6TavUeT3eEOfD
         zpGLOe01nwTcL6RcPUUXaPQq09qb7IHg1Qssehs7p/xmRrKsqC3GRPY8q38s9K46unST
         dvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Haj+pN6JlXocxjPEnNzE2m0NqLyZQmn83EhQMLGbRWo=;
        b=d4tZyu5EQWl6WPnJ5xetBPccCRXerE4jSANjJSmK1r++LtYpBLmC7foW4zo3cw1sMI
         DGOr7xo7DMblRoTGIbh+wCjFgVLl71OU+8H+fjdQDuBkXa83aTy3yI35fphQqVFg5X5x
         X8JGQTrBtHUaTyWUOme5ojkHTrkopEsMBti2Ru1bH/VwEXd16LENq/CP2KoqJLJaps6l
         G9N2m26BFdSUqR3ANnzH+CNhdk+CRaB7+pEGNN5GGLcJ8X7nQlv9Xj53mc5bpCsP+1lS
         4dlTfkzFRqf8JqP8ffMD61Z+U70+0sgUIldQNPeMzYFHDkhRyPkClOUWB8OvvnfT1QYg
         IYjw==
X-Gm-Message-State: AOAM532lhRLKy8MaV3Wg42CRGh39b+MRGrjd3C9Knwp2kgudQUYylxcr
        jjmtWGo/C18gnTB9OwQJuIawFPu9X+o=
X-Google-Smtp-Source: ABdhPJxi3busQ743jN6os0VE9WDErOUuMMXg7V8gGNQgL5xizSsYLFVGYafPCd+F1yzwLZ0mj2M4Vw==
X-Received: by 2002:a05:600c:4187:b0:394:4cf8:7c61 with SMTP id p7-20020a05600c418700b003944cf87c61mr3339880wmh.119.1651843396215;
        Fri, 06 May 2022 06:23:16 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id p33-20020a05600c1da100b0038ec8b633fesm4108848wms.1.2022.05.06.06.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 06:23:15 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] memory: tegra: Add Tegra234 support
Date:   Fri,  6 May 2022 15:23:09 +0200
Message-Id: <20220506132312.3910637-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132312.3910637-1-thierry.reding@gmail.com>
References: <20220506132312.3910637-1-thierry.reding@gmail.com>
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

