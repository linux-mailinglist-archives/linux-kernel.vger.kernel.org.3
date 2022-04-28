Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DB3513042
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiD1JvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348228AbiD1Jha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:37:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8291C9548D;
        Thu, 28 Apr 2022 02:34:15 -0700 (PDT)
X-UUID: ab291a0b36b04045804852b3720d6dec-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:fe1534ae-46b2-4522-8cc2-214e0d0887df,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:0059082f-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: ab291a0b36b04045804852b3720d6dec-20220428
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 139911879; Thu, 28 Apr 2022 17:34:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 17:34:08 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 17:34:08 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>
CC:     <aaronyu@google.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <julianbraha@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [v4 12/18] ASoC: mediatek: mt8186: support gpio control in platform driver
Date:   Thu, 28 Apr 2022 17:33:49 +0800
Message-ID: <20220428093355.16172-13-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio control for all audio interface separately.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/mediatek/mt8186/mt8186-afe-gpio.c | 244 ++++++++++++++++++++
 sound/soc/mediatek/mt8186/mt8186-afe-gpio.h |  19 ++
 2 files changed, 263 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-gpio.h

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
new file mode 100644
index 000000000000..5ba28095b7da
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// mt8186-afe-gpio.c  --  Mediatek 8186 afe gpio ctrl
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+
+#include <linux/gpio.h>
+#include <linux/pinctrl/consumer.h>
+
+#include "mt8186-afe-common.h"
+#include "mt8186-afe-gpio.h"
+
+struct pinctrl *aud_pinctrl;
+
+enum mt8186_afe_gpio {
+	MT8186_AFE_GPIO_CLK_MOSI_OFF,
+	MT8186_AFE_GPIO_CLK_MOSI_ON,
+	MT8186_AFE_GPIO_CLK_MISO_OFF,
+	MT8186_AFE_GPIO_CLK_MISO_ON,
+	MT8186_AFE_GPIO_DAT_MISO_OFF,
+	MT8186_AFE_GPIO_DAT_MISO_ON,
+	MT8186_AFE_GPIO_DAT_MOSI_OFF,
+	MT8186_AFE_GPIO_DAT_MOSI_ON,
+	MT8186_AFE_GPIO_I2S0_OFF,
+	MT8186_AFE_GPIO_I2S0_ON,
+	MT8186_AFE_GPIO_I2S1_OFF,
+	MT8186_AFE_GPIO_I2S1_ON,
+	MT8186_AFE_GPIO_I2S2_OFF,
+	MT8186_AFE_GPIO_I2S2_ON,
+	MT8186_AFE_GPIO_I2S3_OFF,
+	MT8186_AFE_GPIO_I2S3_ON,
+	MT8186_AFE_GPIO_TDM_OFF,
+	MT8186_AFE_GPIO_TDM_ON,
+	MT8186_AFE_GPIO_PCM_OFF,
+	MT8186_AFE_GPIO_PCM_ON,
+	MT8186_AFE_GPIO_GPIO_NUM
+};
+
+struct audio_gpio_attr {
+	const char *name;
+	bool gpio_prepare;
+	struct pinctrl_state *gpioctrl;
+};
+
+static struct audio_gpio_attr aud_gpios[MT8186_AFE_GPIO_GPIO_NUM] = {
+	[MT8186_AFE_GPIO_CLK_MOSI_OFF] = {"aud_clk_mosi_off", false, NULL},
+	[MT8186_AFE_GPIO_CLK_MOSI_ON] = {"aud_clk_mosi_on", false, NULL},
+	[MT8186_AFE_GPIO_CLK_MISO_OFF] = {"aud_clk_miso_off", false, NULL},
+	[MT8186_AFE_GPIO_CLK_MISO_ON] = {"aud_clk_miso_on", false, NULL},
+	[MT8186_AFE_GPIO_DAT_MISO_OFF] = {"aud_dat_miso_off", false, NULL},
+	[MT8186_AFE_GPIO_DAT_MISO_ON] = {"aud_dat_miso_on", false, NULL},
+	[MT8186_AFE_GPIO_DAT_MOSI_OFF] = {"aud_dat_mosi_off", false, NULL},
+	[MT8186_AFE_GPIO_DAT_MOSI_ON] = {"aud_dat_mosi_on", false, NULL},
+	[MT8186_AFE_GPIO_I2S0_OFF] = {"aud_gpio_i2s0_off", false, NULL},
+	[MT8186_AFE_GPIO_I2S0_ON] = {"aud_gpio_i2s0_on", false, NULL},
+	[MT8186_AFE_GPIO_I2S1_OFF] = {"aud_gpio_i2s1_off", false, NULL},
+	[MT8186_AFE_GPIO_I2S1_ON] = {"aud_gpio_i2s1_on", false, NULL},
+	[MT8186_AFE_GPIO_I2S2_OFF] = {"aud_gpio_i2s2_off", false, NULL},
+	[MT8186_AFE_GPIO_I2S2_ON] = {"aud_gpio_i2s2_on", false, NULL},
+	[MT8186_AFE_GPIO_I2S3_OFF] = {"aud_gpio_i2s3_off", false, NULL},
+	[MT8186_AFE_GPIO_I2S3_ON] = {"aud_gpio_i2s3_on", false, NULL},
+	[MT8186_AFE_GPIO_TDM_OFF] = {"aud_gpio_tdm_off", false, NULL},
+	[MT8186_AFE_GPIO_TDM_ON] = {"aud_gpio_tdm_on", false, NULL},
+	[MT8186_AFE_GPIO_PCM_OFF] = {"aud_gpio_pcm_off", false, NULL},
+	[MT8186_AFE_GPIO_PCM_ON] = {"aud_gpio_pcm_on", false, NULL},
+};
+
+static DEFINE_MUTEX(gpio_request_mutex);
+
+int mt8186_afe_gpio_init(struct device *dev)
+{
+	int i, j, ret;
+
+	aud_pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(aud_pinctrl)) {
+		ret = PTR_ERR(aud_pinctrl);
+		dev_err(dev, "%s(), ret %d, cannot get aud_pinctrl!\n",
+			__func__, ret);
+		return ret;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(aud_gpios); i++) {
+		aud_gpios[i].gpioctrl = pinctrl_lookup_state(aud_pinctrl,
+							     aud_gpios[i].name);
+		if (IS_ERR(aud_gpios[i].gpioctrl)) {
+			ret = PTR_ERR(aud_gpios[i].gpioctrl);
+			dev_info(dev, "%s(), pinctrl_lookup_state %s fail, ret %d\n",
+				 __func__, aud_gpios[i].name, ret);
+		} else {
+			aud_gpios[i].gpio_prepare = true;
+		}
+	}
+
+	/* gpio status init */
+	for (i = MT8186_DAI_ADDA; i <= MT8186_DAI_TDM_IN; i++) {
+		for (j = 0; j <= 1; j++)
+			mt8186_afe_gpio_request(dev, false, i, j);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt8186_afe_gpio_init);
+
+static int mt8186_afe_gpio_select(struct device *dev,
+				  enum mt8186_afe_gpio type)
+{
+	int ret = 0;
+
+	if (type < 0 || type >= MT8186_AFE_GPIO_GPIO_NUM) {
+		dev_err(dev, "%s(), error, invalid gpio type %d\n",
+			__func__, type);
+		return -EINVAL;
+	}
+
+	if (!aud_gpios[type].gpio_prepare) {
+		dev_err(dev, "%s(), error, gpio type %d not prepared\n",
+			__func__, type);
+		return -EIO;
+	}
+
+	ret = pinctrl_select_state(aud_pinctrl,
+				   aud_gpios[type].gpioctrl);
+	if (ret) {
+		dev_err(dev, "%s(), error, can not set gpio type %d\n",
+			__func__, type);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mt8186_afe_gpio_adda_dl(struct device *dev, bool enable)
+{
+	int ret;
+
+	if (enable) {
+		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MOSI_ON);
+		if (ret) {
+			dev_err(dev, "%s(), MOSI CLK ON slect fail!\n", __func__);
+			return ret;
+		}
+
+		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MOSI_ON);
+		if (ret) {
+			dev_err(dev, "%s(), MOSI DAT ON slect fail!\n", __func__);
+			return ret;
+		}
+	} else {
+		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MOSI_OFF);
+		if (ret) {
+			dev_err(dev, "%s(), MOSI DAT OFF slect fail!\n", __func__);
+			return ret;
+		}
+
+		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MOSI_OFF);
+		if (ret) {
+			dev_err(dev, "%s(), MOSI CLK ON slect fail!\n", __func__);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int mt8186_afe_gpio_adda_ul(struct device *dev, bool enable)
+{
+	int ret;
+
+	if (enable) {
+		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MISO_ON);
+		if (ret) {
+			dev_err(dev, "%s(), MISO CLK ON slect fail!\n", __func__);
+			return ret;
+		}
+
+		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MISO_ON);
+		if (ret) {
+			dev_err(dev, "%s(), MISO DAT ON slect fail!\n", __func__);
+			return ret;
+		}
+	} else {
+		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MISO_OFF);
+		if (ret) {
+			dev_err(dev, "%s(), MISO DAT OFF slect fail!\n", __func__);
+			return ret;
+		}
+
+		ret = mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MISO_OFF);
+		if (ret) {
+			dev_err(dev, "%s(), MISO CLK OFF slect fail!\n", __func__);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int mt8186_afe_gpio_request(struct device *dev, bool enable,
+			    int dai, int uplink)
+{
+	enum mt8186_afe_gpio sel;
+	int ret = -EINVAL;
+
+	mutex_lock(&gpio_request_mutex);
+
+	switch (dai) {
+	case MT8186_DAI_ADDA:
+		if (uplink)
+			ret = mt8186_afe_gpio_adda_ul(dev, enable);
+		else
+			ret = mt8186_afe_gpio_adda_dl(dev, enable);
+		goto unlock;
+	case MT8186_DAI_I2S_0:
+		sel = enable ? MT8186_AFE_GPIO_I2S0_ON : MT8186_AFE_GPIO_I2S0_OFF;
+		break;
+	case MT8186_DAI_I2S_1:
+		sel = enable ? MT8186_AFE_GPIO_I2S1_ON : MT8186_AFE_GPIO_I2S1_OFF;
+		break;
+	case MT8186_DAI_I2S_2:
+		sel = enable ? MT8186_AFE_GPIO_I2S2_ON : MT8186_AFE_GPIO_I2S2_OFF;
+		break;
+	case MT8186_DAI_I2S_3:
+		sel = enable ? MT8186_AFE_GPIO_I2S3_ON : MT8186_AFE_GPIO_I2S3_OFF;
+		break;
+	case MT8186_DAI_TDM_IN:
+		sel = enable ? MT8186_AFE_GPIO_TDM_ON : MT8186_AFE_GPIO_TDM_OFF;
+		break;
+	case MT8186_DAI_PCM:
+		sel = enable ? MT8186_AFE_GPIO_PCM_ON : MT8186_AFE_GPIO_PCM_OFF;
+		break;
+	default:
+		mutex_unlock(&gpio_request_mutex);
+		dev_err(dev, "%s(), invalid dai %d\n", __func__, dai);
+		goto unlock;
+	}
+
+	ret = mt8186_afe_gpio_select(dev, sel);
+
+unlock:
+	mutex_unlock(&gpio_request_mutex);
+
+	return ret;
+}
diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.h b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.h
new file mode 100644
index 000000000000..1ddc27838eb1
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * mt6833-afe-gpio.h  --  Mediatek 6833 afe gpio ctrl definition
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+ */
+
+#ifndef _MT8186_AFE_GPIO_H_
+#define _MT8186_AFE_GPIO_H_
+
+struct mtk_base_afe;
+
+int mt8186_afe_gpio_init(struct device *dev);
+
+int mt8186_afe_gpio_request(struct device *dev, bool enable,
+			    int dai, int uplink);
+
+#endif
-- 
2.25.1

