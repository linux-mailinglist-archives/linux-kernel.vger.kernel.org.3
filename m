Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE724651CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351058AbhLAPke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:40:34 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33876 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1351041AbhLAPk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:40:29 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B19N0TT027321;
        Wed, 1 Dec 2021 09:36:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=S5BGIM+yEr7E/4o2p9g8HzUl42grKlCEoF6DI4iSlUs=;
 b=Uh1ybMhFPiaDyADWRN8BTDmgDpIdCjXFzoIGfYzSPdzQdTIBqNKQNJ7v7XV56moFQVLA
 Hg7GCkAHrm12lpQsaQL9WI3a/lFtWjCOJJ1DA4AEYFU7BdL6krfO4HU+1JbMgFhFSlqo
 uwSRCiMeV1GW3zwsuIldTbY29Bh0z6oPMMFC6L0+mEEMwqJp5aNfHoW+w/SV4/UFJW3X
 Dn4JTrTL29/84C2EMhOG7a71GI0rjiON22tKEESmg4SGErknOKyWmo8Be/Wjx9n/hwh5
 3Pt3lruTEjMvtU9b7YDW8mCobZxmUXa8Ib+NElhD9f8iB+vpDFlgWoq01CQKHDA0GPmB iA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cp6c88cwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Dec 2021 09:36:54 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 15:36:52 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 1 Dec 2021 15:36:52 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.14])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8019E2A9;
        Wed,  1 Dec 2021 15:36:51 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l42: Implement system suspend
Date:   Wed, 1 Dec 2021 15:36:48 +0000
Message-ID: <20211201153648.17259-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kImvmVbT5XJUOxDMtcbsrPVNm9RuAs7b
X-Proofpoint-GUID: kImvmVbT5XJUOxDMtcbsrPVNm9RuAs7b
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add system suspend functions to handle clean power-down on suspend and
restoring state on resume.

The jack state could change during suspend. Plug->unplug and unplug->plug
are straightforward because this looks no different from any other plug
state change. However, the jack could be unplugged and a different type
of jack plugged, and on resume the plug state would not have changed.
Some code changes are needed to the jack handling so that on resume a
plugged state will be re-evaluated instead of filtered out. In this case
there would not have been a previous unplug event to clear the reported
jack state so the full state of all jack type and button flags must be
reported.

Note that during system suspend any jack plug/unplug and button events
will not be reported or generate a system wakeup. If the plug state or
headset type has changed it will be reported after resume.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 212 ++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/cs42l42.h |   8 +-
 2 files changed, 209 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 43d98bdb5b5b..5abac0dc8e8b 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -47,7 +47,6 @@ static const struct reg_default cs42l42_reg_defaults[] = {
 	{ CS42L42_I2C_STRETCH,			0x03 },
 	{ CS42L42_I2C_TIMEOUT,			0xB7 },
 	{ CS42L42_PWR_CTL1,			0xFF },
-	{ CS42L42_PWR_CTL2,			0x84 },
 	{ CS42L42_PWR_CTL3,			0x20 },
 	{ CS42L42_RSENSE_CTL1,			0x40 },
 	{ CS42L42_RSENSE_CTL2,			0x00 },
@@ -331,6 +330,11 @@ static bool cs42l42_volatile_register(struct device *dev, unsigned int reg)
 	case CS42L42_DEVID_CD:
 	case CS42L42_DEVID_E:
 	case CS42L42_MCLK_STATUS:
+	/*
+	 * PWR_CTL2 must be volatile so it can be used as a canary bit to
+	 * detect a reset during system suspend.
+	 */
+	case CS42L42_PWR_CTL2:
 	case CS42L42_OSC_SWITCH_STATUS:
 	case CS42L42_TRSENSE_STATUS:
 	case CS42L42_HS_DET_STATUS:
@@ -550,7 +554,7 @@ static int cs42l42_set_jack(struct snd_soc_component *component, struct snd_soc_
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 
 	/* Prevent race with interrupt handler */
-	mutex_lock(&cs42l42->jack_detect_mutex);
+	mutex_lock(&cs42l42->irq_lock);
 	cs42l42->jack = jk;
 
 	if (jk) {
@@ -566,7 +570,7 @@ static int cs42l42_set_jack(struct snd_soc_component *component, struct snd_soc_
 			break;
 		}
 	}
-	mutex_unlock(&cs42l42->jack_detect_mutex);
+	mutex_unlock(&cs42l42->irq_lock);
 
 	return 0;
 }
@@ -1613,6 +1617,12 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	unsigned int i;
 	int report = 0;
 
+	mutex_lock(&cs42l42->irq_lock);
+
+	if (cs42l42->suspended) {
+		mutex_unlock(&cs42l42->irq_lock);
+		return IRQ_NONE;
+	}
 
 	/* Read sticky registers to clear interurpt */
 	for (i = 0; i < ARRAY_SIZE(stickies); i++) {
@@ -1635,9 +1645,12 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 		CS42L42_M_DETECT_FT_MASK |
 		CS42L42_M_HSBIAS_HIZ_MASK);
 
-	mutex_lock(&cs42l42->jack_detect_mutex);
-
-	/* Check auto-detect status */
+	/*
+	 * Check auto-detect status. During system suspend the jack could be
+	 * unplugged and a different type plugged. On resume there will not
+	 * have been a previous unplug event to clear the reported flags, so
+	 * here the full state of all flags must be reported.
+	 */
 	if ((~masks[5]) & irq_params_table[5].mask) {
 		if (stickies[5] & CS42L42_HSDET_AUTO_DONE_MASK) {
 			cs42l42_process_hs_type_detect(cs42l42);
@@ -1645,11 +1658,15 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 			case CS42L42_PLUG_CTIA:
 			case CS42L42_PLUG_OMTP:
 				snd_soc_jack_report(cs42l42->jack, SND_JACK_HEADSET,
-						    SND_JACK_HEADSET);
+						    SND_JACK_HEADSET |
+						    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+						    SND_JACK_BTN_2 | SND_JACK_BTN_3);
 				break;
 			case CS42L42_PLUG_HEADPHONE:
 				snd_soc_jack_report(cs42l42->jack, SND_JACK_HEADPHONE,
-						    SND_JACK_HEADPHONE);
+						    SND_JACK_HEADSET |
+						    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+						    SND_JACK_BTN_2 | SND_JACK_BTN_3);
 				break;
 			default:
 				break;
@@ -1705,7 +1722,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 		}
 	}
 
-	mutex_unlock(&cs42l42->jack_detect_mutex);
+	mutex_unlock(&cs42l42->irq_lock);
 
 	return IRQ_HANDLED;
 }
@@ -2053,8 +2070,9 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 		return -ENOMEM;
 
 	cs42l42->dev = &i2c_client->dev;
+	cs42l42->irq = i2c_client->irq;
 	i2c_set_clientdata(i2c_client, cs42l42);
-	mutex_init(&cs42l42->jack_detect_mutex);
+	mutex_init(&cs42l42->irq_lock);
 
 	cs42l42->regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
 	if (IS_ERR(cs42l42->regmap)) {
@@ -2210,6 +2228,179 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 	return 0;
 }
 
+/* Suspend sequence from datasheet */
+static const struct reg_sequence __maybe_unused cs42l42_suspend_seq[] = {
+	REG_SEQ0(CS42L42_MIC_DET_CTL1,		0x9f),
+	REG_SEQ0(CS42L42_ADC_OVFL_INT_MASK,	0x01),
+	REG_SEQ0(CS42L42_MIXER_INT_MASK,	0x0F),
+	REG_SEQ0(CS42L42_SRC_INT_MASK,		0x0F),
+	REG_SEQ0(CS42L42_ASP_RX_INT_MASK,	0x1F),
+	REG_SEQ0(CS42L42_ASP_TX_INT_MASK,	0x0F),
+	REG_SEQ0(CS42L42_CODEC_INT_MASK,	0x03),
+	REG_SEQ0(CS42L42_SRCPL_INT_MASK,	0x7F),
+	REG_SEQ0(CS42L42_VPMON_INT_MASK,	0x01),
+	REG_SEQ0(CS42L42_PLL_LOCK_INT_MASK,	0x01),
+	REG_SEQ0(CS42L42_TSRS_PLUG_INT_MASK,	0x0F),
+	REG_SEQ0(CS42L42_WAKE_CTL,		0xE1),
+	REG_SEQ0(CS42L42_DET_INT1_MASK,		0xE0),
+	REG_SEQ0(CS42L42_DET_INT2_MASK,		0xFF),
+	REG_SEQ0(CS42L42_MIXER_CHA_VOL,		0x3f),
+	REG_SEQ0(CS42L42_MIXER_ADC_VOL,		0x3f),
+	REG_SEQ0(CS42L42_MIXER_CHB_VOL,		0x3f),
+	REG_SEQ0(CS42L42_HP_CTL,		0x0f),
+	REG_SEQ0(CS42L42_ASP_RX_DAI0_EN,	0x00),
+	REG_SEQ0(CS42L42_ASP_CLK_CFG,		0x00),
+	REG_SEQ0(CS42L42_HSDET_CTL2,		0x00),
+	REG_SEQ0(CS42L42_PWR_CTL1,		0xfe),
+	REG_SEQ0(CS42L42_PWR_CTL2,		0x8c),
+	REG_SEQ0(CS42L42_DAC_CTL2,		0x02),
+	REG_SEQ0(CS42L42_HS_CLAMP_DISABLE,	0x00),
+	REG_SEQ0(CS42L42_MISC_DET_CTL,		0x03),
+	REG_SEQ0(CS42L42_TIPSENSE_CTL,		0x02),
+	REG_SEQ0(CS42L42_HSBIAS_SC_AUTOCTL,	0x03),
+	REG_SEQ0(CS42L42_PWR_CTL1,		0xff),
+};
+
+static const struct reg_sequence __maybe_unused cs42l42_suspend_post_seq[] = {
+	REG_SEQ0(CS42L42_PWR_CTL2,		0x9c),
+};
+
+static int __maybe_unused cs42l42_suspend(struct device *dev)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
+	unsigned int reg;
+	int ret;
+
+	if (cs42l42->irq >= 0)
+		disable_irq(cs42l42->irq);
+
+	/*
+	 * Wait for threaded irq handler to be idle and stop it processing
+	 * future interrupts. This ensures a safe disable if the interrupt
+	 * is shared.
+	 */
+	mutex_lock(&cs42l42->irq_lock);
+	cs42l42->suspended = true;
+
+	/* Clear any previous PDN_DONE */
+	regmap_read(cs42l42->regmap, CS42L42_CODEC_STATUS, &reg);
+
+	/* Preserve cached values so they can be restored. */
+	regmap_multi_reg_write_bypassed(cs42l42->regmap,
+					cs42l42_suspend_seq,
+					ARRAY_SIZE(cs42l42_suspend_seq));
+
+	/* The cached address page register value is now stale */
+	regcache_drop_region(cs42l42->regmap, CS42L42_PAGE_REGISTER, CS42L42_PAGE_REGISTER);
+
+	/* Wait for power-down complete */
+	msleep(CS42L42_PDN_DONE_TIME_MS);
+	ret = regmap_read_poll_timeout(cs42l42->regmap, CS42L42_CODEC_STATUS, reg,
+				       (reg & CS42L42_PDN_DONE_MASK),
+				       CS42L42_PDN_DONE_POLL_US,
+				       CS42L42_PDN_DONE_TIMEOUT_US);
+	if (ret)
+		dev_warn(dev, "Failed to get PDN_DONE: %d\n", ret);
+
+	regmap_multi_reg_write_bypassed(cs42l42->regmap,
+					cs42l42_suspend_post_seq,
+					ARRAY_SIZE(cs42l42_suspend_post_seq));
+	msleep(CS42L42_FILT_DISCHARGE_TIME_MS);
+
+	/* The cached address page register value is now stale */
+	regcache_drop_region(cs42l42->regmap, CS42L42_PAGE_REGISTER, CS42L42_PAGE_REGISTER);
+
+	regcache_cache_only(cs42l42->regmap, true);
+
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
+
+	mutex_unlock(&cs42l42->irq_lock);
+
+	dev_dbg(dev, "System suspended\n");
+
+	return 0;
+}
+
+static int __maybe_unused cs42l42_resume(struct device *dev)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&cs42l42->irq_lock);
+
+	/*
+	 * If jack was unplugged and re-plugged during suspend it could have
+	 * changed type but the tip-sense state hasn't changed. Force a
+	 * plugged state to be re-evaluated if it is still plugged.
+	 */
+	if (cs42l42->plug_state != CS42L42_TS_UNPLUG)
+		cs42l42->plug_state = CS42L42_TS_TRANS;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
+	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
+
+	regcache_cache_only(cs42l42->regmap, false);
+
+	if (cs42l42->reset_gpio) {
+		/* Registers have reset to defaults */
+		regcache_mark_dirty(cs42l42->regmap);
+	} else {
+		/*
+		 * Only call regcache_mark_dirty() if cs42l42 reset, so
+		 * regcache_sync() writes all non-default cached values.
+		 * If it didn't reset we don't want to filter out syncing
+		 * dirty cache entries that have default value.
+		 * DISCHARGE_FILT==1 after suspend. If the cs42l42 reset
+		 * it will now be 0.
+		 */
+		ret = regmap_read(cs42l42->regmap, CS42L42_PWR_CTL2, &val);
+		if (ret) {
+			dev_err(dev, "failed to read PWR_CTL2: %d\n", ret);
+			goto err;
+		}
+
+		if ((val & CS42L42_DISCHARGE_FILT_MASK) == 0) {
+			dev_dbg(dev, "Has reset in suspend\n");
+			regcache_mark_dirty(cs42l42->regmap);
+		} else {
+			dev_dbg(dev, "Did not reset in suspend\n");
+		}
+	}
+
+	/* Sync LATCH_TO_VP first so the VP domain registers sync correctly */
+	regcache_sync_region(cs42l42->regmap, CS42L42_MIC_DET_CTL1, CS42L42_MIC_DET_CTL1);
+	regcache_sync(cs42l42->regmap);
+
+	cs42l42->suspended = false;
+	mutex_unlock(&cs42l42->irq_lock);
+
+	if (cs42l42->irq >= 0)
+		enable_irq(cs42l42->irq);
+
+	dev_dbg(dev, "System resumed\n");
+
+	return 0;
+err:
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
+
+	mutex_unlock(&cs42l42->irq_lock);
+
+	return ret;
+}
+
+static const struct dev_pm_ops cs42l42_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(cs42l42_suspend, cs42l42_resume)
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id cs42l42_of_match[] = {
 	{ .compatible = "cirrus,cs42l42", },
@@ -2236,6 +2427,7 @@ MODULE_DEVICE_TABLE(i2c, cs42l42_id);
 static struct i2c_driver cs42l42_i2c_driver = {
 	.driver = {
 		.name = "cs42l42",
+		.pm = &cs42l42_pm_ops,
 		.of_match_table = of_match_ptr(cs42l42_of_match),
 		.acpi_match_table = ACPI_PTR(cs42l42_acpi_match),
 		},
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 9fff183dce8e..b497ca1618c2 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -826,6 +826,10 @@
 #define CS42L42_PLL_LOCK_POLL_US	250
 #define CS42L42_PLL_LOCK_TIMEOUT_US	1250
 #define CS42L42_HP_ADC_EN_TIME_US	20000
+#define CS42L42_PDN_DONE_POLL_US	1000
+#define CS42L42_PDN_DONE_TIMEOUT_US	200000
+#define CS42L42_PDN_DONE_TIME_MS	100
+#define CS42L42_FILT_DISCHARGE_TIME_MS	46
 
 static const char *const cs42l42_supply_names[CS42L42_NUM_SUPPLIES] = {
 	"VA",
@@ -842,7 +846,8 @@ struct  cs42l42_private {
 	struct gpio_desc *reset_gpio;
 	struct completion pdn_done;
 	struct snd_soc_jack *jack;
-	struct mutex jack_detect_mutex;
+	int irq;
+	struct mutex irq_lock;
 	int pll_config;
 	int bclk;
 	u32 sclk;
@@ -860,6 +865,7 @@ struct  cs42l42_private {
 	u8 hs_bias_sense_en;
 	u8 stream_use;
 	bool hp_adc_up_pending;
+	bool suspended;
 };
 
 #endif /* __CS42L42_H__ */
-- 
2.11.0

