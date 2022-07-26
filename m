Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63475814A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbiGZNz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiGZNzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:55:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4173665D8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:55:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so8215507wmm.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRSOiGoOrC3t6wEy50JVXbhAW+sBGO47FPfpEcofjB8=;
        b=Q+lQXfSdOYweTtKJzxbiF6vBOxH9h8OdLAHXNf/n0nG6zsCHE8AIpH+/efmpIfnSRc
         Pb5WdypcpBZ0VfseNJOCz0myvzz0WKHSKRRcoqBOFOBq5i52ipO0k9/3pxvi+IQz0VrO
         o+9cd6Vn18+wEWbiluJSex6r/LS/g08vtVCxyAAEupZ3hFGT2vkq4G2mNkugcwK+qF/K
         I59oL2bZApaGz0jb724KWJihbYPcW1O2rfbp/Qu9jezJSuKlTXOrWnri+jBOwmjCW3ez
         FMJTJdXozKK+IlM/hsHcqwmnOt3jEt6F29jaq05vpEaxSKzbPLiYAkeEReFg1fzDhoTC
         xNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRSOiGoOrC3t6wEy50JVXbhAW+sBGO47FPfpEcofjB8=;
        b=UbIGgelNRBk7M3aZuuiqcrKkBWN8B7rE/cu9OFi1MaeCMHSkarnkjpY75ixSA6MYAu
         DimwbUfnQ7RNCU2V9VE151SzQ15hP/RrBjIGxSSDJQHrMcnoTGHVZ7Clos/qWNfkgCz1
         b44umG9FvuLvkAQ64VGBWIMsyMVfBt7EYEt2Tx6RAOgTTwD4z9N+DzRQuG6EztE3ou/n
         +3fgrqnKjx5FVg3AVy6u3YFEGw/k7G18bz6+8XogLOHtTNNXZHR2PbJcUHEY71d9JxVK
         oAIAL97kMLbgbPrpWI8MxSZUqjm58NKM5U3WTHzp3duxNFbn0p7ieW5Kd2JXLOTgtk7F
         U/Ag==
X-Gm-Message-State: AJIora9a5atySPgaU13Ec1TJJPtInhS/ZmiL4EKTAI8yNfdV0stv2BLT
        GyozMu+z0o+XUuVy7Aa32x1HNQ==
X-Google-Smtp-Source: AGRyM1sZyxeaEgHhGQ13XRG2/v6xEMkLueksUGhv81nQ0+a33FhA+AF4RlQf1XcXAmF6X3BM1I5mRA==
X-Received: by 2002:a05:600c:3c91:b0:3a3:5230:1a6d with SMTP id bg17-20020a05600c3c9100b003a352301a6dmr8742885wmb.11.1658843717838;
        Tue, 26 Jul 2022 06:55:17 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d13-20020adf9c8d000000b0021e4c3b2967sm15244670wre.65.2022.07.26.06.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:55:17 -0700 (PDT)
From:   Balsam CHIHI <bchihi@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: [PATCH v8 1/6] thermal: mediatek: Relocate driver to mediatek folder
Date:   Tue, 26 Jul 2022 15:55:01 +0200
Message-Id: <20220726135506.485108-2-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726135506.485108-1-bchihi@baylibre.com>
References: <20220726135506.485108-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Mediatek proprietary folder to upstream more thermal zone and cooler
drivers. Relocate the original thermal controller driver to it and rename
as soc_temp.c to show its purpose more clearly.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 drivers/thermal/Kconfig                       | 14 ++++-------
 drivers/thermal/Makefile                      |  2 +-
 drivers/thermal/mediatek/Kconfig              | 23 +++++++++++++++++++
 drivers/thermal/mediatek/Makefile             |  1 +
 .../{mtk_thermal.c => mediatek/soc_temp.c}    |  0
 5 files changed, 29 insertions(+), 11 deletions(-)
 create mode 100644 drivers/thermal/mediatek/Kconfig
 create mode 100644 drivers/thermal/mediatek/Makefile
 rename drivers/thermal/{mtk_thermal.c => mediatek/soc_temp.c} (100%)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0e5cc948373c..ecba8d6e313b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -412,16 +412,10 @@ config DA9062_THERMAL
 	  zone.
 	  Compatible with the DA9062 and DA9061 PMICs.
 
-config MTK_THERMAL
-	tristate "Temperature sensor driver for mediatek SoCs"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on HAS_IOMEM
-	depends on NVMEM || NVMEM=n
-	depends on RESET_CONTROLLER
-	default y
-	help
-	  Enable this option if you want to have support for thermal management
-	  controller present in Mediatek SoCs
+menu "Mediatek thermal drivers"
+depends on ARCH_MEDIATEK || COMPILE_TEST
+source "drivers/thermal/mediatek/Kconfig"
+endmenu
 
 config AMLOGIC_THERMAL
 	tristate "Amlogic Thermal Support"
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index def8e1a0399c..3c00e864ad55 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -55,7 +55,7 @@ obj-y				+= st/
 obj-$(CONFIG_QCOM_TSENS)	+= qcom/
 obj-y				+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
-obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
+obj-$(CONFIG_MTK_THERMAL)	+= mediatek/
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
new file mode 100644
index 000000000000..9c41e9079fc3
--- /dev/null
+++ b/drivers/thermal/mediatek/Kconfig
@@ -0,0 +1,23 @@
+config MTK_THERMAL
+	tristate "MediaTek thermal drivers"
+	depends on THERMAL_OF
+	help
+		This is the option for MediaTek thermal software
+		solutions. Please enable corresponding options to
+		get temperature information from thermal sensors or
+		turn on throttle mechaisms for thermal mitigation.
+
+if MTK_THERMAL
+
+config MTK_SOC_THERMAL
+	tristate "Temperature sensor driver for MediaTek SoCs"
+	depends on HAS_IOMEM
+	depends on NVMEM
+	depends on RESET_CONTROLLER
+	help
+		Enable this option if you want to get SoC temperature
+		information for MediaTek platforms. This driver
+		configures thermal controllers to collect temperature
+		via AUXADC interface.
+
+endif
diff --git a/drivers/thermal/mediatek/Makefile b/drivers/thermal/mediatek/Makefile
new file mode 100644
index 000000000000..4b4cb04a358f
--- /dev/null
+++ b/drivers/thermal/mediatek/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MTK_SOC_THERMAL)		+= soc_temp.o
diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mediatek/soc_temp.c
similarity index 100%
rename from drivers/thermal/mtk_thermal.c
rename to drivers/thermal/mediatek/soc_temp.c
-- 
2.34.1

