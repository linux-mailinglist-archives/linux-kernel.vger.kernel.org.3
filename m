Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2393A51303B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiD1Ju3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348202AbiD1JhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:37:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727339548D;
        Thu, 28 Apr 2022 02:34:07 -0700 (PDT)
X-UUID: 053f44590f574fb2bc8e3409babe6c73-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:83ac89d3-c167-43b1-afda-26da7783dbbe,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham
        ,ACTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:83ac89d3-c167-43b1-afda-26da7783dbbe,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D
        ,ACTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:3257082f-6199-437e-8ab4-9920b4bc5b76,C
        OID:ec183970c4e3,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 053f44590f574fb2bc8e3409babe6c73-20220428
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 613116741; Thu, 28 Apr 2022 17:34:00 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 17:33:59 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 17:33:59 +0800
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
Subject: [v4 03/18] ASoC: mediatek: mt8186: support audsys clock control
Date:   Thu, 28 Apr 2022 17:33:40 +0800
Message-ID: <20220428093355.16172-4-jiaxin.yu@mediatek.com>
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

Add mt8186 audio cg control. Audio clock gates are registered to
CCF for reference count and clock parent management.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8186/mt8186-audsys-clk.c | 150 ++++++++++++++++++
 sound/soc/mediatek/mt8186/mt8186-audsys-clk.h |  15 ++
 .../soc/mediatek/mt8186/mt8186-audsys-clkid.h |  45 ++++++
 3 files changed, 210 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-audsys-clk.c
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-audsys-clk.h
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-audsys-clkid.h

diff --git a/sound/soc/mediatek/mt8186/mt8186-audsys-clk.c b/sound/soc/mediatek/mt8186/mt8186-audsys-clk.c
new file mode 100644
index 000000000000..578969ca91c8
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-audsys-clk.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// mt8186-audsys-clk.h  --  Mediatek 8186 audsys clock control
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include "mt8186-afe-common.h"
+#include "mt8186-audsys-clk.h"
+#include "mt8186-audsys-clkid.h"
+#include "mt8186-reg.h"
+
+struct afe_gate {
+	int id;
+	const char *name;
+	const char *parent_name;
+	int reg;
+	u8 bit;
+	const struct clk_ops *ops;
+	unsigned long flags;
+	u8 cg_flags;
+};
+
+#define GATE_AFE_FLAGS(_id, _name, _parent, _reg, _bit, _flags, _cgflags) {\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.reg = _reg,					\
+		.bit = _bit,					\
+		.flags = _flags,				\
+		.cg_flags = _cgflags,				\
+	}
+
+#define GATE_AFE(_id, _name, _parent, _reg, _bit)		\
+	GATE_AFE_FLAGS(_id, _name, _parent, _reg, _bit,		\
+		       CLK_SET_RATE_PARENT, CLK_GATE_SET_TO_DISABLE)
+
+#define GATE_AUD0(_id, _name, _parent, _bit)			\
+	GATE_AFE(_id, _name, _parent, AUDIO_TOP_CON0, _bit)
+
+#define GATE_AUD1(_id, _name, _parent, _bit)			\
+	GATE_AFE(_id, _name, _parent, AUDIO_TOP_CON1, _bit)
+
+#define GATE_AUD2(_id, _name, _parent, _bit)			\
+	GATE_AFE(_id, _name, _parent, AUDIO_TOP_CON2, _bit)
+
+static const struct afe_gate aud_clks[CLK_AUD_NR_CLK] = {
+	/* AUD0 */
+	GATE_AUD0(CLK_AUD_AFE, "aud_afe_clk", "top_audio", 2),
+	GATE_AUD0(CLK_AUD_22M, "aud_apll22m_clk", "top_aud_engen1", 8),
+	GATE_AUD0(CLK_AUD_24M, "aud_apll24m_clk", "top_aud_engen2", 9),
+	GATE_AUD0(CLK_AUD_APLL2_TUNER, "aud_apll2_tuner_clk", "top_aud_engen2", 18),
+	GATE_AUD0(CLK_AUD_APLL_TUNER, "aud_apll_tuner_clk", "top_aud_engen1", 19),
+	GATE_AUD0(CLK_AUD_TDM, "aud_tdm_clk", "top_aud_1", 20),
+	GATE_AUD0(CLK_AUD_ADC, "aud_adc_clk", "top_audio", 24),
+	GATE_AUD0(CLK_AUD_DAC, "aud_dac_clk", "top_audio", 25),
+	GATE_AUD0(CLK_AUD_DAC_PREDIS, "aud_dac_predis_clk", "top_audio", 26),
+	GATE_AUD0(CLK_AUD_TML, "aud_tml_clk", "top_audio", 27),
+	GATE_AUD0(CLK_AUD_NLE, "aud_nle_clk", "top_audio", 28),
+
+	/* AUD1 */
+	GATE_AUD1(CLK_AUD_I2S1_BCLK, "aud_i2s1_bclk", "top_audio", 4),
+	GATE_AUD1(CLK_AUD_I2S2_BCLK, "aud_i2s2_bclk", "top_audio", 5),
+	GATE_AUD1(CLK_AUD_I2S3_BCLK, "aud_i2s3_bclk", "top_audio", 6),
+	GATE_AUD1(CLK_AUD_I2S4_BCLK, "aud_i2s4_bclk", "top_audio", 7),
+	GATE_AUD1(CLK_AUD_CONNSYS_I2S_ASRC, "aud_connsys_i2s_asrc", "top_audio", 12),
+	GATE_AUD1(CLK_AUD_GENERAL1_ASRC, "aud_general1_asrc", "top_audio", 13),
+	GATE_AUD1(CLK_AUD_GENERAL2_ASRC, "aud_general2_asrc", "top_audio", 14),
+	GATE_AUD1(CLK_AUD_DAC_HIRES, "aud_dac_hires_clk", "top_audio_h", 15),
+	GATE_AUD1(CLK_AUD_ADC_HIRES, "aud_adc_hires_clk", "top_audio_h", 16),
+	GATE_AUD1(CLK_AUD_ADC_HIRES_TML, "aud_adc_hires_tml", "top_audio_h", 17),
+	GATE_AUD1(CLK_AUD_ADDA6_ADC, "aud_adda6_adc", "top_audio", 20),
+	GATE_AUD1(CLK_AUD_ADDA6_ADC_HIRES, "aud_adda6_adc_hires", "top_audio_h", 21),
+	GATE_AUD1(CLK_AUD_3RD_DAC, "aud_3rd_dac", "top_audio", 28),
+	GATE_AUD1(CLK_AUD_3RD_DAC_PREDIS, "aud_3rd_dac_predis", "top_audio", 29),
+	GATE_AUD1(CLK_AUD_3RD_DAC_TML, "aud_3rd_dac_tml", "top_audio", 30),
+	GATE_AUD1(CLK_AUD_3RD_DAC_HIRES, "aud_3rd_dac_hires", "top_audio_h", 31),
+
+	/* AUD2 */
+	GATE_AUD2(CLK_AUD_ETDM_IN1_BCLK, "aud_etdm_in1_bclk", "top_audio", 23),
+	GATE_AUD2(CLK_AUD_ETDM_OUT1_BCLK, "aud_etdm_out1_bclk", "top_audio", 24),
+};
+
+int mt8186_audsys_clk_register(struct mtk_base_afe *afe)
+{
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	struct clk *clk;
+	struct clk_lookup *cl;
+	int i;
+
+	afe_priv->lookup = devm_kcalloc(afe->dev, CLK_AUD_NR_CLK,
+					sizeof(*afe_priv->lookup),
+					GFP_KERNEL);
+
+	if (!afe_priv->lookup)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(aud_clks); i++) {
+		const struct afe_gate *gate = &aud_clks[i];
+
+		clk = clk_register_gate(afe->dev, gate->name, gate->parent_name,
+					gate->flags, afe->base_addr + gate->reg,
+					gate->bit, gate->cg_flags, NULL);
+
+		if (IS_ERR(clk)) {
+			dev_err(afe->dev, "Failed to register clk %s: %ld\n",
+				gate->name, PTR_ERR(clk));
+			continue;
+		}
+
+		/* add clk_lookup for devm_clk_get(SND_SOC_DAPM_CLOCK_SUPPLY) */
+		cl = kzalloc(sizeof(*cl), GFP_KERNEL);
+		if (!cl)
+			return -ENOMEM;
+
+		cl->clk = clk;
+		cl->con_id = gate->name;
+		cl->dev_id = dev_name(afe->dev);
+		clkdev_add(cl);
+
+		afe_priv->lookup[i] = cl;
+	}
+
+	return 0;
+}
+
+void mt8186_audsys_clk_unregister(struct mtk_base_afe *afe)
+{
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	struct clk *clk;
+	struct clk_lookup *cl;
+	int i;
+
+	if (!afe_priv)
+		return;
+
+	for (i = 0; i < CLK_AUD_NR_CLK; i++) {
+		cl = afe_priv->lookup[i];
+		if (!cl)
+			continue;
+
+		clk = cl->clk;
+		clk_unregister_gate(clk);
+
+		clkdev_drop(cl);
+	}
+}
diff --git a/sound/soc/mediatek/mt8186/mt8186-audsys-clk.h b/sound/soc/mediatek/mt8186/mt8186-audsys-clk.h
new file mode 100644
index 000000000000..b8d6a06e11e8
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-audsys-clk.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * mt8186-audsys-clk.h  --  Mediatek 8186 audsys clock definition
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Trevor Wu <trevor.wu@mediatek.com>
+ */
+
+#ifndef _MT8186_AUDSYS_CLK_H_
+#define _MT8186_AUDSYS_CLK_H_
+
+int mt8186_audsys_clk_register(struct mtk_base_afe *afe);
+void mt8186_audsys_clk_unregister(struct mtk_base_afe *afe);
+
+#endif
diff --git a/sound/soc/mediatek/mt8186/mt8186-audsys-clkid.h b/sound/soc/mediatek/mt8186/mt8186-audsys-clkid.h
new file mode 100644
index 000000000000..3ce5937c1823
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-audsys-clkid.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * mt8186-audsys-clkid.h  --  Mediatek 8186 audsys clock id definition
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+ */
+
+#ifndef _MT8186_AUDSYS_CLKID_H_
+#define _MT8186_AUDSYS_CLKID_H_
+
+enum{
+	CLK_AUD_AFE,
+	CLK_AUD_22M,
+	CLK_AUD_24M,
+	CLK_AUD_APLL2_TUNER,
+	CLK_AUD_APLL_TUNER,
+	CLK_AUD_TDM,
+	CLK_AUD_ADC,
+	CLK_AUD_DAC,
+	CLK_AUD_DAC_PREDIS,
+	CLK_AUD_TML,
+	CLK_AUD_NLE,
+	CLK_AUD_I2S1_BCLK,
+	CLK_AUD_I2S2_BCLK,
+	CLK_AUD_I2S3_BCLK,
+	CLK_AUD_I2S4_BCLK,
+	CLK_AUD_CONNSYS_I2S_ASRC,
+	CLK_AUD_GENERAL1_ASRC,
+	CLK_AUD_GENERAL2_ASRC,
+	CLK_AUD_DAC_HIRES,
+	CLK_AUD_ADC_HIRES,
+	CLK_AUD_ADC_HIRES_TML,
+	CLK_AUD_ADDA6_ADC,
+	CLK_AUD_ADDA6_ADC_HIRES,
+	CLK_AUD_3RD_DAC,
+	CLK_AUD_3RD_DAC_PREDIS,
+	CLK_AUD_3RD_DAC_TML,
+	CLK_AUD_3RD_DAC_HIRES,
+	CLK_AUD_ETDM_IN1_BCLK,
+	CLK_AUD_ETDM_OUT1_BCLK,
+	CLK_AUD_NR_CLK,
+};
+
+#endif
-- 
2.25.1

