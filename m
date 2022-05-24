Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A810532D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238954AbiEXP2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbiEXP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:28:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2838162127
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:28:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e28so25609325wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MuJUprVkec1LhN6o7SGN7yS6FtU75T+9Wd1DOyeL8ik=;
        b=cXViV63iRSsMqW3XAi/zQKnSpJARlA/rf5fRH6+kSetZovEs5U2oYe2hHvprEFaZFr
         vHgoIQ2/m6pWstO2paqiiTVf1lazwwki/PMZiHiAwFraMXiFSjb7z18b4hFHGOr7faY4
         qMQSahJsZlMtKLt4yxdownjKXhfxRs+b9tCxfa8ZTK4/ODqqAbnDW9GZ5YfaRk72rN9D
         Nkv+lT52o+aTj/2yun+3xAdvR4DxtZfe4ohuen7ZrwxA18kX4hmEp3EoKKt4DjMpC68e
         aLvca5iCRNTTJThD/PeYwqHLB0fAdmQi1qkDsDsw2RxTN11aY0cC3/ugEnClljCb4ZZF
         XJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MuJUprVkec1LhN6o7SGN7yS6FtU75T+9Wd1DOyeL8ik=;
        b=xmS1PH4FTtO6HfYsDeP3/sXC6OUER1LCSX2Ht9ezwvGL0OQnG6GBVsKX3gbsarbNTl
         0mndzkVJOWt+QZVAGk+ATBQoCaozxPVlbOl/cLxRo0wqcFRRv167HXlDNXNSdBIrldvJ
         tw7T9P9UQnjakpVryurcWDld12lUAM+3e6pXEhVZpiu9wedB2MPSsDSuiad5REzelvVW
         PIfjzE3lvPCX5O/+9u106vArS3x43hfPTRuBy580tjV4G/l/Y6FCYlud1TbPFm7O9Tgm
         QDSu+B9MlRZPEYCOTbRVOemRUbsyZib3plXxl9v+CVLv9QAnBY6ogBOqsN/6qo+EM8/X
         x4qg==
X-Gm-Message-State: AOAM530akKfVdJd/A2NC3dqsJI+Ol6VQpcZQAM+ojCdmLeM80I39iugq
        LQap+3jurQXuJ3LmEkbczxwHyg==
X-Google-Smtp-Source: ABdhPJwGvaG1N+rlSqIUh/89AyIZlqskmxR/ikdhIJdjlbxerIP+U4FECFmabv4sskd0a2Nbk5lnWQ==
X-Received: by 2002:a05:6000:178d:b0:20f:e7da:6a21 with SMTP id e13-20020a056000178d00b0020fe7da6a21mr6657054wrg.689.1653406084354;
        Tue, 24 May 2022 08:28:04 -0700 (PDT)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c1c9800b003974027722csm2703693wms.47.2022.05.24.08.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:28:03 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, Michael Kao <michael.kao@mediatek.com>,
        Ben Tseng <ben.tseng@mediatek.com>
Subject: [PATCH v7 1/6] thermal: mediatek: Relocate driver to mediatek folder
Date:   Tue, 24 May 2022 17:25:48 +0200
Message-Id: <20220524152552.246193-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524152552.246193-1-abailon@baylibre.com>
References: <20220524152552.246193-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

Add Mediatek proprietary folder to upstream more thermal zone and cooler
drivers. Relocate the original thermal controller driver to it and rename
as soc_temp.c to show its purpose more clearly.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
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
index e37691e0bf20..8669d7278055 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -410,16 +410,10 @@ config DA9062_THERMAL
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
index f0c36a1530d5..9ade39bdb525 100644
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
index 000000000000..592c849b9fed
--- /dev/null
+++ b/drivers/thermal/mediatek/Kconfig
@@ -0,0 +1,23 @@
+config MTK_THERMAL
+	tristate "MediaTek thermal drivers"
+	depends on THERMAL_OF
+	help
+	  This is the option for MediaTek thermal software
+	  solutions. Please enable corresponding options to
+	  get temperature information from thermal sensors or
+	  turn on throttle mechaisms for thermal mitigation.
+
+if MTK_THERMAL
+
+config MTK_SOC_THERMAL
+	tristate "Temperature sensor driver for MediaTek SoCs"
+	depends on HAS_IOMEM
+	depends on NVMEM
+	depends on RESET_CONTROLLER
+	help
+	  Enable this option if you want to get SoC temperature
+	  information for MediaTek platforms. This driver
+	  configures thermal controllers to collect temperature
+	  via AUXADC interface.
+
+endif
diff --git a/drivers/thermal/mediatek/Makefile b/drivers/thermal/mediatek/Makefile
new file mode 100644
index 000000000000..f75313ddce5e
--- /dev/null
+++ b/drivers/thermal/mediatek/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MTK_SOC_THERMAL)	+= soc_temp.o
diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mediatek/soc_temp.c
similarity index 100%
rename from drivers/thermal/mtk_thermal.c
rename to drivers/thermal/mediatek/soc_temp.c
-- 
2.35.1

