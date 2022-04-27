Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09035511D83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbiD0PMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239070AbiD0PK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608B63207D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:48 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R6M8vh014103;
        Wed, 27 Apr 2022 10:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=L3AtVzyrL+S7RqXnsAyqRbofsvewTEW2B4uNt/5hepA=;
 b=EcyOR2I8lVX0VkLiWQt1z1Ooc8ASxv01gQdak6lDCTslXOSdgsfh11pw1waeQfOGERLv
 MLFfLzctxVz34TqaSlUWd6SCFyeWAIGBxZqpguJuQepgFsG8VLGiw9vCw9UouXxFdpvc
 Hf3W44D587UUqRNSgZ3SEvTqIjvCQVae0NRBJ3oDnXMLzxna9K2BMGxdgoT40U+bjPEQ
 IW7kSjL/GCPrpfaMS3i6EGdDvmKtokuny0vIfXVSQrGeZx0eGkTCmegxIUrGk/4m6QRj
 Kt6yKvz5GwfNV0r8SZNRPoczVOO/XTyYh1BZSAPnkG8OMZ3mYglDDTcPXriGT8rJZdYb 9A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:25 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:23 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F1CDD46C;
        Wed, 27 Apr 2022 15:07:22 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 04/26] ALSA: hda: cs35l41: Add Support for Interrupts
Date:   Wed, 27 Apr 2022 16:06:58 +0100
Message-ID: <20220427150720.9194-5-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: PHlP4tbbLUvqSOguW-YeQiLX3XVNmBQQ
X-Proofpoint-ORIG-GUID: PHlP4tbbLUvqSOguW-YeQiLX3XVNmBQQ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

The CS35L41 can produce interrupts on error.

When the interrupts occur, the driver will report
the error, but errors will only be fixed after playback
finishes.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 include/sound/cs35l41.h     |  54 +++++++++++++++
 sound/pci/hda/Kconfig       |   2 +
 sound/pci/hda/cs35l41_hda.c | 134 +++++++++++++++++++++++++++++++++++-
 sound/pci/hda/cs35l41_hda.h |   2 +
 4 files changed, 191 insertions(+), 1 deletion(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index dbe8d9c0191b..8e4b125c81c8 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -691,6 +691,13 @@
 #define CS35L41_TEMP_WARN_ERR_RLS	0x20
 #define CS35L41_TEMP_ERR_RLS		0x40
 
+#define CS35L41_AMP_SHORT_ERR_RLS_SHIFT	1
+#define CS35L41_BST_SHORT_ERR_RLS_SHIFT	2
+#define CS35L41_BST_OVP_ERR_RLS_SHIFT	3
+#define CS35L41_BST_UVP_ERR_RLS_SHIFT	4
+#define CS35L41_TEMP_WARN_ERR_RLS_SHIFT	5
+#define CS35L41_TEMP_ERR_RLS_SHIFT	6
+
 #define CS35L41_INT1_MASK_DEFAULT	0x7FFCFE3F
 #define CS35L41_INT1_UNMASK_PUP		0xFEFFFFFF
 #define CS35L41_INT1_UNMASK_PDN		0xFF7FFFFF
@@ -794,6 +801,53 @@ struct cs35l41_otp_map_element_t {
 	u32 word_offset;
 };
 
+/*
+ * IRQs
+ */
+#define CS35L41_IRQ(_irq, _name, _hand)		\
+	{					\
+		.irq = CS35L41_ ## _irq ## _IRQ,\
+		.name = _name,			\
+		.handler = _hand,		\
+	}
+
+struct cs35l41_irq {
+	int irq;
+	const char *name;
+	irqreturn_t (*handler)(int irq, void *data);
+};
+
+#define CS35L41_REG_IRQ(_reg, _irq)					\
+	[CS35L41_ ## _irq ## _IRQ] = {					\
+		.reg_offset = (CS35L41_ ## _reg) - CS35L41_IRQ1_STATUS1,\
+		.mask = CS35L41_ ## _irq ## _MASK			\
+	}
+
+/* (0x0000E010) CS35L41_IRQ1_STATUS1 */
+#define CS35L41_BST_OVP_ERR_SHIFT		6
+#define CS35L41_BST_OVP_ERR_MASK		BIT(CS35L41_BST_OVP_ERR_SHIFT)
+#define CS35L41_BST_DCM_UVP_ERR_SHIFT		7
+#define CS35L41_BST_DCM_UVP_ERR_MASK		BIT(CS35L41_BST_DCM_UVP_ERR_SHIFT)
+#define CS35L41_BST_SHORT_ERR_SHIFT		8
+#define CS35L41_BST_SHORT_ERR_MASK		BIT(CS35L41_BST_SHORT_ERR_SHIFT)
+#define CS35L41_TEMP_WARN_SHIFT			15
+#define CS35L41_TEMP_WARN_MASK			BIT(CS35L41_TEMP_WARN_SHIFT)
+#define CS35L41_TEMP_ERR_SHIFT			17
+#define CS35L41_TEMP_ERR_MASK			BIT(CS35L41_TEMP_ERR_SHIFT)
+#define CS35L41_AMP_SHORT_ERR_SHIFT		31
+#define CS35L41_AMP_SHORT_ERR_MASK		BIT(CS35L41_AMP_SHORT_ERR_SHIFT)
+
+enum cs35l41_irq_list {
+	CS35L41_BST_OVP_ERR_IRQ,
+	CS35L41_BST_DCM_UVP_ERR_IRQ,
+	CS35L41_BST_SHORT_ERR_IRQ,
+	CS35L41_TEMP_WARN_IRQ,
+	CS35L41_TEMP_ERR_IRQ,
+	CS35L41_AMP_SHORT_ERR_IRQ,
+
+	CS35L41_NUM_IRQ
+};
+
 extern struct regmap_config cs35l41_regmap_i2c;
 extern struct regmap_config cs35l41_regmap_spi;
 
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 9f6c99c1d87b..79ade4787d95 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -102,6 +102,7 @@ config SND_HDA_SCODEC_CS35L41_I2C
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L41_LIB
 	select SND_HDA_SCODEC_CS35L41
+	select REGMAP_IRQ
 	help
 	  Say Y or M here to include CS35L41 I2C HD-audio side codec support
 	  in snd-hda-intel driver, such as ALC287.
@@ -117,6 +118,7 @@ config SND_HDA_SCODEC_CS35L41_SPI
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L41_LIB
 	select SND_HDA_SCODEC_CS35L41
+	select REGMAP_IRQ
 	help
 	  Say Y or M here to include CS35L41 SPI HD-audio side codec support
 	  in snd-hda-intel driver, such as ALC287.
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 96c3e541696d..bd52e0c2c772 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -32,6 +32,21 @@ static const struct reg_sequence cs35l41_hda_mute[] = {
 	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, // AMP_VOL_PCM Mute
 };
 
+/* Protection release cycle to get the speaker out of Safe-Mode */
+static void cs35l41_error_release(struct device *dev, struct regmap *regmap, unsigned int mask)
+{
+	regmap_write(regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
+	regmap_set_bits(regmap, CS35L41_PROTECT_REL_ERR_IGN, mask);
+	regmap_clear_bits(regmap, CS35L41_PROTECT_REL_ERR_IGN, mask);
+}
+
+/* Clear all errors to release safe mode. Global Enable must be cleared first. */
+static void cs35l41_irq_release(struct cs35l41_hda *cs35l41)
+{
+	cs35l41_error_release(cs35l41->dev, cs35l41->regmap, cs35l41->irq_errors);
+	cs35l41->irq_errors = 0;
+}
+
 static void cs35l41_hda_playback_hook(struct device *dev, int action)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
@@ -58,6 +73,7 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 					 CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
 		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
 			regmap_write(reg, CS35L41_GPIO1_CTRL1, 0x00000001);
+		cs35l41_irq_release(cs35l41);
 		break;
 	default:
 		dev_warn(cs35l41->dev, "Playback action not supported: %d\n", action);
@@ -110,10 +126,101 @@ static const struct component_ops cs35l41_hda_comp_ops = {
 	.unbind = cs35l41_hda_unbind,
 };
 
+static irqreturn_t cs35l41_bst_short_err(int irq, void *data)
+{
+	struct cs35l41_hda *cs35l41 = data;
+
+	dev_crit_ratelimited(cs35l41->dev, "LBST Error\n");
+	set_bit(CS35L41_BST_SHORT_ERR_RLS_SHIFT, &cs35l41->irq_errors);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cs35l41_bst_dcm_uvp_err(int irq, void *data)
+{
+	struct cs35l41_hda *cs35l41 = data;
+
+	dev_crit_ratelimited(cs35l41->dev, "DCM VBST Under Voltage Error\n");
+	set_bit(CS35L41_BST_UVP_ERR_RLS_SHIFT, &cs35l41->irq_errors);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cs35l41_bst_ovp_err(int irq, void *data)
+{
+	struct cs35l41_hda *cs35l41 = data;
+
+	dev_crit_ratelimited(cs35l41->dev, "VBST Over Voltage error\n");
+	set_bit(CS35L41_BST_OVP_ERR_RLS_SHIFT, &cs35l41->irq_errors);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cs35l41_temp_err(int irq, void *data)
+{
+	struct cs35l41_hda *cs35l41 = data;
+
+	dev_crit_ratelimited(cs35l41->dev, "Over temperature error\n");
+	set_bit(CS35L41_TEMP_ERR_RLS_SHIFT, &cs35l41->irq_errors);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cs35l41_temp_warn(int irq, void *data)
+{
+	struct cs35l41_hda *cs35l41 = data;
+
+	dev_crit_ratelimited(cs35l41->dev, "Over temperature warning\n");
+	set_bit(CS35L41_TEMP_WARN_ERR_RLS_SHIFT, &cs35l41->irq_errors);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cs35l41_amp_short(int irq, void *data)
+{
+	struct cs35l41_hda *cs35l41 = data;
+
+	dev_crit_ratelimited(cs35l41->dev, "Amp short error\n");
+	set_bit(CS35L41_AMP_SHORT_ERR_RLS_SHIFT, &cs35l41->irq_errors);
+
+	return IRQ_HANDLED;
+}
+
+static const struct cs35l41_irq cs35l41_irqs[] = {
+	CS35L41_IRQ(BST_OVP_ERR, "Boost Overvoltage Error", cs35l41_bst_ovp_err),
+	CS35L41_IRQ(BST_DCM_UVP_ERR, "Boost Undervoltage Error", cs35l41_bst_dcm_uvp_err),
+	CS35L41_IRQ(BST_SHORT_ERR, "Boost Inductor Short Error", cs35l41_bst_short_err),
+	CS35L41_IRQ(TEMP_WARN, "Temperature Warning", cs35l41_temp_warn),
+	CS35L41_IRQ(TEMP_ERR, "Temperature Error", cs35l41_temp_err),
+	CS35L41_IRQ(AMP_SHORT_ERR, "Amp Short", cs35l41_amp_short),
+};
+
+static const struct regmap_irq cs35l41_reg_irqs[] = {
+	CS35L41_REG_IRQ(IRQ1_STATUS1, BST_OVP_ERR),
+	CS35L41_REG_IRQ(IRQ1_STATUS1, BST_DCM_UVP_ERR),
+	CS35L41_REG_IRQ(IRQ1_STATUS1, BST_SHORT_ERR),
+	CS35L41_REG_IRQ(IRQ1_STATUS1, TEMP_WARN),
+	CS35L41_REG_IRQ(IRQ1_STATUS1, TEMP_ERR),
+	CS35L41_REG_IRQ(IRQ1_STATUS1, AMP_SHORT_ERR),
+};
+
+static const struct regmap_irq_chip cs35l41_regmap_irq_chip = {
+	.name = "cs35l41 IRQ1 Controller",
+	.status_base = CS35L41_IRQ1_STATUS1,
+	.mask_base = CS35L41_IRQ1_MASK1,
+	.ack_base = CS35L41_IRQ1_STATUS1,
+	.num_regs = 4,
+	.irqs = cs35l41_reg_irqs,
+	.num_irqs = ARRAY_SIZE(cs35l41_reg_irqs),
+};
+
 static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 {
 	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
+	bool using_irq = false;
+	int irq, irq_pol;
 	int ret;
+	int i;
 
 	if (!cs35l41->hw_cfg.valid)
 		return -EINVAL;
@@ -145,6 +252,7 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 		case CS35L41_NOT_USED:
 			break;
 		case CS35L41_INTERRUPT:
+			using_irq = true;
 			break;
 		default:
 			dev_err(cs35l41->dev, "Invalid GPIO2 function %d\n", hw_cfg->gpio2.func);
@@ -152,7 +260,28 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 		}
 	}
 
-	cs35l41_gpio_config(cs35l41->regmap, hw_cfg);
+	irq_pol = cs35l41_gpio_config(cs35l41->regmap, hw_cfg);
+
+	if (cs35l41->irq && using_irq) {
+		ret = devm_regmap_add_irq_chip(cs35l41->dev, cs35l41->regmap, cs35l41->irq,
+					       IRQF_ONESHOT | IRQF_SHARED | irq_pol,
+					       0, &cs35l41_regmap_irq_chip, &cs35l41->irq_data);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < ARRAY_SIZE(cs35l41_irqs); i++) {
+			irq = regmap_irq_get_virq(cs35l41->irq_data, cs35l41_irqs[i].irq);
+			if (irq < 0)
+				return irq;
+
+			ret = devm_request_threaded_irq(cs35l41->dev, irq, NULL,
+							cs35l41_irqs[i].handler,
+							IRQF_ONESHOT | IRQF_SHARED | irq_pol,
+							cs35l41_irqs[i].name, cs35l41);
+			if (ret)
+				return ret;
+		}
+	}
 
 	return cs35l41_hda_channel_map(cs35l41->dev, 0, NULL, 1, &hw_cfg->spk_pos);
 }
@@ -296,6 +425,9 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	struct cs35l41_hda *cs35l41;
 	int ret;
 
+	BUILD_BUG_ON(ARRAY_SIZE(cs35l41_irqs) != ARRAY_SIZE(cs35l41_reg_irqs));
+	BUILD_BUG_ON(ARRAY_SIZE(cs35l41_irqs) != CS35L41_NUM_IRQ);
+
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index 44d9204ffdf1..c486e4a5bb24 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -35,6 +35,8 @@ struct cs35l41_hda {
 
 	int irq;
 	int index;
+	unsigned volatile long irq_errors;
+	struct regmap_irq_chip_data *irq_data;
 };
 
 int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
-- 
2.32.0

