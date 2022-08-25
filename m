Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4B65A12E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241931AbiHYODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHYOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:02:59 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774AC81B11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:02:54 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661436172; bh=PCDuP/emdbOrjDqBGMDvA3MxPbkFeQu07VmM0kChmGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kX0d3xmSOxwdAWkd8HaT8AyTqnbip/ZMAXN0kert+xkt4DX9cgtL7rP4bb4me81rF
         gZmH4ypxdZwEMJYMIAa6+k3pVbQtNgKIC8MDbrXuZlT3AWzTrC92N+doQOAMaCzuNh
         xa68nQhKtVAfgLZ3v1ulN+7AxmoClwTNvwBZXx5c=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     navada@ti.com, shenghao-ding@ti.com, asyrus@ti.com,
        raphael-xu@ti.com,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Kitt <steve@sk2.org>, Dan Murphy <dmurphy@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH 4/5] ASoC: tas2764: Add IRQ handling
Date:   Thu, 25 Aug 2022 16:02:40 +0200
Message-Id: <20220825140241.53963-5-povik+lin@cutebit.org>
In-Reply-To: <20220825140241.53963-1-povik+lin@cutebit.org>
References: <20220825140241.53963-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an IRQ handler which logs detected faults (but doesn't do anything
else).

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/tas2764.c | 93 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tas2764.h | 19 ++++++++
 2 files changed, 112 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 39902f77a2e0..e99a46fb503f 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -31,6 +31,7 @@ struct tas2764_priv {
 	struct gpio_desc *sdz_gpio;
 	struct regmap *regmap;
 	struct device *dev;
+	int irq;
 	
 	int v_sense_slot;
 	int i_sense_slot;
@@ -39,6 +40,57 @@ struct tas2764_priv {
 	bool unmuted;
 };
 
+static const char *tas2764_int_ltch0_msgs[8] = {
+	"fault: over temperature", /* INT_LTCH0 & BIT(0) */
+	"fault: over current",
+	"fault: bad TDM clock",
+	"limiter active",
+	"fault: PVDD below limiter inflection point",
+	"fault: limiter max attenuation",
+	"fault: BOP infinite hold",
+	"fault: BOP mute", /* INT_LTCH0 & BIT(7) */
+};
+
+static const unsigned int tas2764_int_readout_regs[6] = {
+	TAS2764_INT_LTCH0,
+	TAS2764_INT_LTCH1,
+	TAS2764_INT_LTCH1_0,
+	TAS2764_INT_LTCH2,
+	TAS2764_INT_LTCH3,
+	TAS2764_INT_LTCH4,
+};
+
+static irqreturn_t tas2764_irq(int irq, void *data)
+{
+	struct tas2764_priv *tas2764 = data;
+	u8 latched[6] = {0, 0, 0, 0, 0, 0};
+	int ret = IRQ_NONE;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(latched); i++)
+		latched[i] = snd_soc_component_read(tas2764->component,
+						    tas2764_int_readout_regs[i]);
+
+	for (i = 0; i < 8; i++) {
+		if (latched[0] & BIT(i)) {
+			dev_crit_ratelimited(tas2764->dev, "%s\n",
+					     tas2764_int_ltch0_msgs[i]);
+			ret = IRQ_HANDLED;
+		}
+	}
+
+	if (latched[0]) {
+		dev_err_ratelimited(tas2764->dev, "other context to the fault: %02x,%02x,%02x,%02x,%02x",
+				    latched[1], latched[2], latched[3], latched[4], latched[5]);
+		snd_soc_component_update_bits(tas2764->component,
+					      TAS2764_INT_CLK_CFG,
+					      TAS2764_INT_CLK_CFG_IRQZ_CLR,
+					      TAS2764_INT_CLK_CFG_IRQZ_CLR);
+	}
+
+	return ret;
+}
+
 static void tas2764_reset(struct tas2764_priv *tas2764)
 {
 	if (tas2764->reset_gpio) {
@@ -497,6 +549,34 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 
 	tas2764_reset(tas2764);
 
+	if (tas2764->irq) {
+		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0, 0xff);
+		if (ret < 0)
+			return ret;
+
+		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK1, 0xff);
+		if (ret < 0)
+			return ret;
+
+		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK2, 0xff);
+		if (ret < 0)
+			return ret;
+
+		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK3, 0xff);
+		if (ret < 0)
+			return ret;
+
+		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK4, 0xff);
+		if (ret < 0)
+			return ret;
+
+		ret = devm_request_threaded_irq(tas2764->dev, tas2764->irq, NULL, tas2764_irq,
+						IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW,
+						"tas2764", tas2764);
+		if (ret)
+			dev_warn(tas2764->dev, "failed to request IRQ: %d\n", ret);
+	}
+
 	ret = snd_soc_component_update_bits(tas2764->component, TAS2764_TDM_CFG5,
 					    TAS2764_TDM_CFG5_VSNS_ENABLE, 0);
 	if (ret < 0)
@@ -559,9 +639,21 @@ static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
 	},
 };
 
+static bool tas2764_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TAS2764_INT_LTCH0 ... TAS2764_INT_LTCH4:
+	case TAS2764_INT_CLK_CFG:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct regmap_config tas2764_i2c_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
+	.volatile_reg = tas2764_volatile_register,
 	.reg_defaults = tas2764_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(tas2764_reg_defaults),
 	.cache_type = REGCACHE_RBTREE,
@@ -615,6 +707,7 @@ static int tas2764_i2c_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	tas2764->dev = &client->dev;
+	tas2764->irq = client->irq;
 	i2c_set_clientdata(client, tas2764);
 	dev_set_drvdata(&client->dev, tas2764);
 
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index f015f22a083b..960b337ed0fc 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -87,4 +87,23 @@
 #define TAS2764_TDM_CFG6_ISNS_ENABLE	BIT(6)
 #define TAS2764_TDM_CFG6_50_MASK	GENMASK(5, 0)
 
+/* Interrupt Masks */
+#define TAS2764_INT_MASK0               TAS2764_REG(0x0, 0x3b)
+#define TAS2764_INT_MASK1               TAS2764_REG(0x0, 0x3c)
+#define TAS2764_INT_MASK2               TAS2764_REG(0x0, 0x40)
+#define TAS2764_INT_MASK3               TAS2764_REG(0x0, 0x41)
+#define TAS2764_INT_MASK4               TAS2764_REG(0x0, 0x3d)
+
+/* Latched Fault Registers */
+#define TAS2764_INT_LTCH0               TAS2764_REG(0x0, 0x49)
+#define TAS2764_INT_LTCH1               TAS2764_REG(0x0, 0x4a)
+#define TAS2764_INT_LTCH1_0             TAS2764_REG(0x0, 0x4b)
+#define TAS2764_INT_LTCH2               TAS2764_REG(0x0, 0x4f)
+#define TAS2764_INT_LTCH3               TAS2764_REG(0x0, 0x50)
+#define TAS2764_INT_LTCH4               TAS2764_REG(0x0, 0x51)
+
+/* Clock/IRQ Settings */
+#define TAS2764_INT_CLK_CFG             TAS2764_REG(0x0, 0x5c)
+#define TAS2764_INT_CLK_CFG_IRQZ_CLR    BIT(2)
+
 #endif /* __TAS2764__ */
-- 
2.33.0

