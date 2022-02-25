Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C3C4C42F2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbiBYK6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiBYK6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:58:01 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4883F191406;
        Fri, 25 Feb 2022 02:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645786648; x=1677322648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SiHQCH1t2VGFpgGH5/43EAPqiUo7itw6h3cU99it5dk=;
  b=JcvfS97mG4ihk9zn8LRjisWMf2DqWJY1QZrqBXiR5nWc5U3pW4E7gmb5
   MbG29Ic/m0auYZygny0NuL+1fqiH8FEZHTZIfz0KqZgwGenz5xGTaVrDO
   cmDSw9m1c0Y+DNz1CB1XVsh4mudXXwByi33rsouLYvyy6vQUNvRWzKWwt
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Feb 2022 02:57:28 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 02:57:27 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 02:57:26 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 02:57:21 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v4 1/2] ASoC: codecs: Add power domains support in digital macro codecs
Date:   Fri, 25 Feb 2022 16:27:03 +0530
Message-ID: <1645786624-12311-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645786624-12311-1-git-send-email-quic_srivasam@quicinc.com>
References: <1645786624-12311-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for enabling required power domains in digital macro codecs.
macro and dcodec power domains are being requested as clocks by HLOS
in ADSP based architectures and ADSP internally handling as powerdomains.
In ADSP bypass case need to handle them as power domains explicitly.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/codecs/Kconfig              |  7 ++++
 sound/soc/codecs/Makefile             |  2 ++
 sound/soc/codecs/lpass-macro-common.c | 67 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/lpass-macro-common.h | 17 +++++++++
 sound/soc/codecs/lpass-rx-macro.c     | 13 ++++++-
 sound/soc/codecs/lpass-tx-macro.c     | 10 ++++++
 sound/soc/codecs/lpass-va-macro.c     | 11 +++++-
 sound/soc/qcom/Kconfig                |  1 +
 8 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/codecs/lpass-macro-common.c
 create mode 100644 sound/soc/codecs/lpass-macro-common.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c2627f7..4de029a 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -244,6 +244,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_WCD9335
 	imply SND_SOC_WCD934X
 	imply SND_SOC_WCD938X_SDW
+	imply SND_SOC_LPASS_MACRO_COMMON
 	imply SND_SOC_LPASS_RX_MACRO
 	imply SND_SOC_LPASS_TX_MACRO
 	imply SND_SOC_WL1273
@@ -2008,6 +2009,9 @@ config SND_SOC_TPA6130A2
 	tristate "Texas Instruments TPA6130A2 headphone amplifier"
 	depends on I2C
 
+config SND_SOC_LPASS_MACRO_COMMON
+        tristate
+
 config SND_SOC_LPASS_WSA_MACRO
 	depends on COMMON_CLK
 	select REGMAP_MMIO
@@ -2016,16 +2020,19 @@ config SND_SOC_LPASS_WSA_MACRO
 config SND_SOC_LPASS_VA_MACRO
 	depends on COMMON_CLK
 	select REGMAP_MMIO
+	select SND_SOC_LPASS_MACRO_COMMON
 	tristate "Qualcomm VA Macro in LPASS(Low Power Audio SubSystem)"
 
 config SND_SOC_LPASS_RX_MACRO
 	depends on COMMON_CLK
 	select REGMAP_MMIO
+	select SND_SOC_LPASS_MACRO_COMMON
 	tristate "Qualcomm RX Macro in LPASS(Low Power Audio SubSystem)"
 
 config SND_SOC_LPASS_TX_MACRO
 	depends on COMMON_CLK
 	select REGMAP_MMIO
+	select SND_SOC_LPASS_MACRO_COMMON
 	tristate "Qualcomm TX Macro in LPASS(Low Power Audio SubSystem)"
 
 endmenu
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index b4e11c3..c3c6059 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -112,6 +112,7 @@ snd-soc-l3-objs := l3.o
 snd-soc-lm4857-objs := lm4857.o
 snd-soc-lm49453-objs := lm49453.o
 snd-soc-lochnagar-sc-objs := lochnagar-sc.o
+snd-soc-lpass-macro-common-objs := lpass-macro-common.o
 snd-soc-lpass-rx-macro-objs := lpass-rx-macro.o
 snd-soc-lpass-tx-macro-objs := lpass-tx-macro.o
 snd-soc-lpass-wsa-macro-objs := lpass-wsa-macro.o
@@ -676,6 +677,7 @@ obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
 obj-$(CONFIG_SND_SOC_MAX98504)	+= snd-soc-max98504.o
 obj-$(CONFIG_SND_SOC_SIMPLE_AMPLIFIER)	+= snd-soc-simple-amplifier.o
 obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
+obj-$(CONFIG_SND_SOC_LPASS_MACRO_COMMON)	+= snd-soc-lpass-macro-common.o
 obj-$(CONFIG_SND_SOC_LPASS_WSA_MACRO)	+= snd-soc-lpass-wsa-macro.o
 obj-$(CONFIG_SND_SOC_LPASS_VA_MACRO)	+= snd-soc-lpass-va-macro.o
 obj-$(CONFIG_SND_SOC_LPASS_RX_MACRO)	+= snd-soc-lpass-rx-macro.o
diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpass-macro-common.c
new file mode 100644
index 0000000..6cede75
--- /dev/null
+++ b/sound/soc/codecs/lpass-macro-common.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2022, The Linux Foundation. All rights reserved.
+
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+
+#include "lpass-macro-common.h"
+
+struct lpass_macro *lpass_macro_pds_init(struct device *dev)
+{
+	struct lpass_macro *l_pds;
+	int ret;
+
+	if (!of_find_property(dev->of_node, "power-domains", NULL))
+		return NULL;
+
+	l_pds = devm_kzalloc(dev, sizeof(*l_pds), GFP_KERNEL);
+	if (!l_pds)
+		return ERR_PTR(-ENOMEM);
+
+	l_pds->macro_pd = dev_pm_domain_attach_by_name(dev, "macro");
+	if (IS_ERR_OR_NULL(l_pds->macro_pd))
+		return NULL;
+
+	ret = pm_runtime_get_sync(l_pds->macro_pd);
+	if (ret < 0) {
+		pm_runtime_put_noidle(l_pds->macro_pd);
+		goto macro_err;
+	}
+
+	l_pds->dcodec_pd = dev_pm_domain_attach_by_name(dev, "dcodec");
+	if (IS_ERR_OR_NULL(l_pds->dcodec_pd))
+		goto dcodec_err;
+
+	ret = pm_runtime_get_sync(l_pds->dcodec_pd);
+	if (ret < 0) {
+		pm_runtime_put_noidle(l_pds->dcodec_pd);
+		goto dcodec_sync_err;
+	}
+	return l_pds;
+
+dcodec_sync_err:
+	dev_pm_domain_detach(l_pds->dcodec_pd, false);
+dcodec_err:
+	pm_runtime_put(l_pds->macro_pd);
+macro_err:
+	dev_pm_domain_detach(l_pds->macro_pd, false);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(lpass_macro_pds_init);
+
+void lpass_macro_pds_exit(struct lpass_macro *pds)
+{
+	pm_runtime_put(pds->macro_pd);
+	dev_pm_domain_detach(pds->macro_pd, false);
+	pm_runtime_put(pds->dcodec_pd);
+	dev_pm_domain_detach(pds->dcodec_pd, false);
+}
+EXPORT_SYMBOL_GPL(lpass_macro_pds_exit);
+
+MODULE_DESCRIPTION("Common macro driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
new file mode 100644
index 0000000..f2cbf9f
--- /dev/null
+++ b/sound/soc/codecs/lpass-macro-common.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __LPASS_MACRO_COMMON_H__
+#define __LPASS_MACRO_COMMON_H__
+
+struct lpass_macro {
+	struct device *macro_pd;
+	struct device *dcodec_pd;
+};
+
+struct lpass_macro *lpass_macro_pds_init(struct device *dev);
+void lpass_macro_pds_exit(struct lpass_macro *pds);
+
+#endif /* __LPASS_MACRO_COMMON_H__ */
diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 29d214f..4ba5876 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -14,6 +14,8 @@
 #include <linux/of_clk.h>
 #include <linux/clk-provider.h>
 
+#include "lpass-macro-common.h"
+
 #define CDC_RX_TOP_TOP_CFG0		(0x0000)
 #define CDC_RX_TOP_SWR_CTRL		(0x0008)
 #define CDC_RX_TOP_DEBUG		(0x000C)
@@ -606,7 +608,7 @@ struct rx_macro {
 	int is_softclip_on;
 	int is_aux_hpf_on;
 	int softclip_clk_users;
-
+	struct lpass_macro *pds;
 	struct regmap *regmap;
 	struct clk_bulk_data clks[RX_NUM_CLKS_MAX];
 	struct clk_hw hw;
@@ -3537,6 +3539,12 @@ static int rx_macro_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	rx->pds = lpass_macro_pds_init(dev);
+	if (!rx->pds) {
+		dev_err(dev, "Enabling power domains failed in %s\n", __func__);
+		return ret;
+	}
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -3575,6 +3583,9 @@ static int rx_macro_remove(struct platform_device *pdev)
 
 	of_clk_del_provider(pdev->dev.of_node);
 	clk_bulk_disable_unprepare(RX_NUM_CLKS_MAX, rx->clks);
+
+	lpass_macro_pds_exit(rx->pds);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 9c96ab1..7938bf3 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -13,6 +13,8 @@
 #include <linux/of_clk.h>
 #include <linux/clk-provider.h>
 
+#include "lpass-macro-common.h"
+
 #define CDC_TX_CLK_RST_CTRL_MCLK_CONTROL (0x0000)
 #define CDC_TX_MCLK_EN_MASK		BIT(0)
 #define CDC_TX_MCLK_ENABLE		BIT(0)
@@ -266,6 +268,7 @@ struct tx_macro {
 	u16 dmic_clk_div;
 	bool bcs_enable;
 	int dec_mode[NUM_DECIMATORS];
+	struct lpass_macro *pds;
 	bool bcs_clk_en;
 };
 #define to_tx_macro(_hw) container_of(_hw, struct tx_macro, hw)
@@ -1802,6 +1805,11 @@ static int tx_macro_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	tx->pds = lpass_macro_pds_init(dev);
+	if (!tx->pds) {
+		dev_err(dev, "Enabling power domains failed in %s\n", __func__);
+		return ret;
+	}
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -1859,6 +1867,8 @@ static int tx_macro_remove(struct platform_device *pdev)
 
 	clk_bulk_disable_unprepare(TX_NUM_CLKS_MAX, tx->clks);
 
+	lpass_macro_pds_exit(tx->pds);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 11147e3..748ef44 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -15,6 +15,8 @@
 #include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 
+#include "lpass-macro-common.h"
+
 /* VA macro registers */
 #define CDC_VA_CLK_RST_CTRL_MCLK_CONTROL	(0x0000)
 #define CDC_VA_MCLK_CONTROL_EN			BIT(0)
@@ -195,6 +197,7 @@ struct va_macro {
 	struct regmap *regmap;
 	struct clk_bulk_data clks[VA_NUM_CLKS_MAX];
 	struct clk_hw hw;
+	struct lpass_macro *pds;
 
 	s32 dmic_0_1_clk_cnt;
 	s32 dmic_2_3_clk_cnt;
@@ -1413,7 +1416,11 @@ static int va_macro_probe(struct platform_device *pdev)
 		dev_err(dev, "Error getting VA Clocks (%d)\n", ret);
 		return ret;
 	}
-
+	va->pds = lpass_macro_pds_init(dev);
+	if (!va->pds) {
+		dev_err(dev, "Enabling power domains failed %s\n", __func__);
+		return ret;
+	}
 	ret = of_property_read_u32(dev->of_node, "qcom,dmic-sample-rate",
 				   &sample_rate);
 	if (ret) {
@@ -1468,6 +1475,8 @@ static int va_macro_remove(struct platform_device *pdev)
 
 	clk_bulk_disable_unprepare(VA_NUM_CLKS_MAX, va->clks);
 
+	lpass_macro_pds_exit(va->pds);
+
 	return 0;
 }
 
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 52db003..6ffd51a 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -194,6 +194,7 @@ config SND_SOC_SC7280
 	select SND_SOC_LPASS_SC7280
 	select SND_SOC_MAX98357A
 	select SND_SOC_WCD938X
+	select SND_SOC_LPASS_MACRO_COMMON
 	select SND_SOC_LPASS_RX_MACRO
 	select SND_SOC_LPASS_TX_MACRO
 	help
-- 
2.7.4

