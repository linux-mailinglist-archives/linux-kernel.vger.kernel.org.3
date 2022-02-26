Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2C64C5747
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiBZSK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiBZSKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:10:24 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF0F48E51;
        Sat, 26 Feb 2022 10:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645898989; x=1677434989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=8jsgR++8rmaLFZ12rdrrLTKL5qu8WErMRXqCWZ3sPpc=;
  b=iIbOj4Yn8w7VlEzzvqlgxIGI2VgqhVDWz+sRRgiJvUPYFRG4LTA4NDd3
   b1wPa4ZB75jwbIgtHn3jTuFkHPm6vojM2x1M6oKjPZYWrwxrkRXDiq91q
   ofHEOAFmeEQ7Q5HI/oW/J//gezbQeRoMcAFBRXFfqMpvRM/WJRX7b0dMC
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Feb 2022 10:09:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 10:09:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 26 Feb 2022 10:09:47 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 26 Feb 2022 10:09:42 -0800
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
Subject: [PATCH v5 1/2] ASoC: codecs: Add power domains support in digital macro codecs
Date:   Sat, 26 Feb 2022 23:39:18 +0530
Message-ID: <1645898959-11231-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645898959-11231-1-git-send-email-quic_srivasam@quicinc.com>
References: <1645898959-11231-1-git-send-email-quic_srivasam@quicinc.com>
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
 sound/soc/codecs/lpass-rx-macro.c     | 10 +++++-
 sound/soc/codecs/lpass-tx-macro.c     |  9 +++++
 sound/soc/codecs/lpass-va-macro.c     | 10 ++++++
 sound/soc/qcom/Kconfig                |  1 +
 8 files changed, 122 insertions(+), 1 deletion(-)
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
index 67bec5b..6884ae5 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -15,6 +15,8 @@
 #include <linux/of_clk.h>
 #include <linux/clk-provider.h>
 
+#include "lpass-macro-common.h"
+
 #define CDC_RX_TOP_TOP_CFG0		(0x0000)
 #define CDC_RX_TOP_SWR_CTRL		(0x0008)
 #define CDC_RX_TOP_DEBUG		(0x000C)
@@ -607,7 +609,7 @@ struct rx_macro {
 	int is_softclip_on;
 	int is_aux_hpf_on;
 	int softclip_clk_users;
-
+	struct lpass_macro *pds;
 	struct regmap *regmap;
 	struct clk *mclk;
 	struct clk *npl;
@@ -3559,6 +3561,10 @@ static int rx_macro_probe(struct platform_device *pdev)
 	if (IS_ERR(rx->fsgen))
 		return PTR_ERR(rx->fsgen);
 
+	rx->pds = lpass_macro_pds_init(dev);
+	if (IS_ERR(rx->pds))
+		return PTR_ERR(rx->pds);
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -3639,6 +3645,8 @@ static int rx_macro_remove(struct platform_device *pdev)
 	clk_disable_unprepare(rx->macro);
 	clk_disable_unprepare(rx->dcodec);
 
+	lpass_macro_pds_exit(rx->pds);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index f2f0d1c..b492d598 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -14,6 +14,8 @@
 #include <linux/of_clk.h>
 #include <linux/clk-provider.h>
 
+#include "lpass-macro-common.h"
+
 #define CDC_TX_CLK_RST_CTRL_MCLK_CONTROL (0x0000)
 #define CDC_TX_MCLK_EN_MASK		BIT(0)
 #define CDC_TX_MCLK_ENABLE		BIT(0)
@@ -271,6 +273,7 @@ struct tx_macro {
 	u16 dmic_clk_div;
 	bool bcs_enable;
 	int dec_mode[NUM_DECIMATORS];
+	struct lpass_macro *pds;
 	bool bcs_clk_en;
 };
 #define to_tx_macro(_hw) container_of(_hw, struct tx_macro, hw)
@@ -1820,6 +1823,10 @@ static int tx_macro_probe(struct platform_device *pdev)
 	if (IS_ERR(tx->fsgen))
 		return PTR_ERR(tx->fsgen);
 
+	tx->pds = lpass_macro_pds_init(dev);
+	if (IS_ERR(tx->pds))
+		return PTR_ERR(tx->pds);
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -1957,6 +1964,8 @@ static int __maybe_unused tx_macro_runtime_resume(struct device *dev)
 	regcache_sync(tx->regmap);
 	tx->reset_swr = true;
 
+	lpass_macro_pds_exit(tx->pds);
+
 	return 0;
 err_fsgen:
 	clk_disable_unprepare(tx->npl);
diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 34aeee5..300f4f6 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -16,6 +16,8 @@
 #include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 
+#include "lpass-macro-common.h"
+
 /* VA macro registers */
 #define CDC_VA_CLK_RST_CTRL_MCLK_CONTROL	(0x0000)
 #define CDC_VA_MCLK_CONTROL_EN			BIT(0)
@@ -198,6 +200,7 @@ struct va_macro {
 	struct clk *macro;
 	struct clk *dcodec;
 	struct clk_hw hw;
+	struct lpass_macro *pds;
 
 	s32 dmic_0_1_clk_cnt;
 	s32 dmic_2_3_clk_cnt;
@@ -1420,6 +1423,10 @@ static int va_macro_probe(struct platform_device *pdev)
 	if (IS_ERR(va->mclk))
 		return PTR_ERR(va->mclk);
 
+	va->pds = lpass_macro_pds_init(dev);
+	if (IS_ERR(va->pds))
+		return PTR_ERR(va->pds);
+
 	ret = of_property_read_u32(dev->of_node, "qcom,dmic-sample-rate",
 				   &sample_rate);
 	if (ret) {
@@ -1524,6 +1531,9 @@ static int __maybe_unused va_macro_runtime_resume(struct device *dev)
 
 	regcache_cache_only(va->regmap, false);
 	regcache_sync(va->regmap);
+
+	lpass_macro_pds_exit(va->pds);
+
 	return 0;
 }
 
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index ae99833..0cd0dae 100644
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

