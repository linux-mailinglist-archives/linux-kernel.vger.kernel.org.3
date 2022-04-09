Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C704FA655
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbiDIJRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbiDIJPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:15:49 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B55FEFFAD;
        Sat,  9 Apr 2022 02:13:43 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.16.1.2) with ESMTP id 2399CL4v024715;
        Sat, 9 Apr 2022 04:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=6SZsbHE84DxHEUvJeSTRtxK6mNt5m5zgDH5kqcGVRCA=;
 b=LL2t/a+drr6ldE9YN5HEQdAJXzOHMFId6oVGaCoHO0qAoo1iLd+7MrTESXbrBurTsG5X
 3USxQ6ytzVSBoX5Y1M0Q2pWRKdAgqqvXd6pFUopbSCDKCK7LFGCiQS87GB2KqiTYNIu/
 ONXk4nvVxS5rCdOGKnrP4jkzqETTKmV7l9xybs6an2s7UoZZ5QMyjy9C5RTDnHFgEmIy
 5R1rOLIJMxbWor8GYhvZQLIG2uD7/umh5pM8SSYWh/25Ll1SQiraMY3wiK4Vup42kn5I
 U8T5dhshQonmiZjfONJrh1StzJ5P2OEpfhXHmk201Ir28Uc/G30CVykcDda3cs3Kw54T jg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fb6py80ws-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 09 Apr 2022 04:13:20 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 9 Apr
 2022 10:13:19 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Sat, 9 Apr 2022 10:13:19 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.156])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ECE07B1A;
        Sat,  9 Apr 2022 09:13:18 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v6 06/16] ALSA: hda: cs35l41: Add Boost type flag
Date:   Sat, 9 Apr 2022 10:13:05 +0100
Message-ID: <20220409091315.1663410-7-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409091315.1663410-1-tanureal@opensource.cirrus.com>
References: <20220409091315.1663410-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1Tv1COxXgAPmZChxEiyY38pJR3m0LjVi
X-Proofpoint-GUID: 1Tv1COxXgAPmZChxEiyY38pJR3m0LjVi
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace vspk_always_on by a enum that better characterizes the boost
type, as there is 3 types of boost hardware.
And with the new boost type other parts of the driver can better handle
the configuration of the chip.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 include/sound/cs35l41.h     |  9 ++++++--
 sound/pci/hda/cs35l41_hda.c | 43 +++++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index edff62dbe0cc..240141462e40 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -724,6 +724,12 @@
 #define CS35L41_SPI_MAX_FREQ		4000000
 #define CS35L41_REGSTRIDE		4
 
+enum cs35l41_boost_type {
+	CS35L41_INT_BOOST,
+	CS35L41_EXT_BOOST,
+	CS35L41_EXT_BOOST_NO_VSPK_SWITCH,
+};
+
 enum cs35l41_clk_ids {
 	CS35L41_CLKID_SCLK = 0,
 	CS35L41_CLKID_LRCLK = 1,
@@ -767,8 +773,7 @@ struct cs35l41_hw_cfg {
 	struct cs35l41_gpio_cfg gpio2;
 	unsigned int spk_pos;
 
-	/* Don't put the AMP in reset if VSPK can not be turned off */
-	bool vspk_always_on;
+	enum cs35l41_boost_type bst_type;
 };
 
 struct cs35l41_otp_packed_element_t {
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index f853530eb385..0dac622805c4 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -210,20 +210,30 @@ static const struct component_ops cs35l41_hda_comp_ops = {
 static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 {
 	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
-	bool internal_boost = false;
 	int ret;
 
 	if (!cs35l41->hw_cfg.valid)
 		return -EINVAL;
 
-	if (hw_cfg->vspk_always_on) {
+	switch (hw_cfg->bst_type) {
+	case CS35L41_INT_BOOST:
+		cs35l41->reg_seq = &cs35l41_hda_reg_seq_int_bst;
+		ret = cs35l41_boost_config(cs35l41->dev, cs35l41->regmap,
+					   hw_cfg->bst_ind, hw_cfg->bst_cap, hw_cfg->bst_ipk);
+		if (ret)
+			return ret;
+		break;
+	case CS35L41_EXT_BOOST:
+		cs35l41->reg_seq = &cs35l41_hda_reg_seq_ext_bst;
+		break;
+	case CS35L41_EXT_BOOST_NO_VSPK_SWITCH:
 		cs35l41->reg_seq = &cs35l41_hda_reg_seq_no_bst;
-		return 0;
+		break;
+	default:
+		dev_err(cs35l41->dev, "Boost type %d not supported\n", hw_cfg->bst_type);
+		return -EINVAL;
 	}
 
-	if (hw_cfg->bst_ind > 0 || hw_cfg->bst_cap > 0 || hw_cfg->bst_ipk > 0)
-		internal_boost = true;
-
 	if (hw_cfg->gpio1.valid) {
 		switch (hw_cfg->gpio1.func) {
 		case CS35L41_NOT_USED:
@@ -256,16 +266,6 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 
 	cs35l41_gpio_config(cs35l41->regmap, hw_cfg);
 
-	if (internal_boost) {
-		cs35l41->reg_seq = &cs35l41_hda_reg_seq_int_bst;
-		ret = cs35l41_boost_config(cs35l41->dev, cs35l41->regmap,
-					   hw_cfg->bst_ind, hw_cfg->bst_cap, hw_cfg->bst_ipk);
-		if (ret)
-			return ret;
-	} else {
-		cs35l41->reg_seq = &cs35l41_hda_reg_seq_ext_bst;
-	}
-
 	return cs35l41_hda_channel_map(cs35l41->dev, 0, NULL, 1, &hw_cfg->spk_pos);
 }
 
@@ -363,6 +363,11 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	else
 		hw_cfg->bst_cap = -1;
 
+	if (hw_cfg->bst_ind > 0 || hw_cfg->bst_cap > 0 || hw_cfg->bst_ipk > 0)
+		hw_cfg->bst_type = CS35L41_INT_BOOST;
+	else
+		hw_cfg->bst_type = CS35L41_EXT_BOOST;
+
 	hw_cfg->valid = true;
 	put_device(physdev);
 
@@ -388,7 +393,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	/* check I2C address to assign the index */
 	cs35l41->index = id == 0x40 ? 0 : 1;
 	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
-	cs35l41->hw_cfg.vspk_always_on = true;
+	cs35l41->hw_cfg.bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
 	cs35l41->hw_cfg.valid = true;
 	put_device(physdev);
 
@@ -515,7 +520,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	return 0;
 
 err:
-	if (!cs35l41->hw_cfg.vspk_always_on)
+	if (cs35l41->hw_cfg.bst_type != CS35L41_EXT_BOOST_NO_VSPK_SWITCH)
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 	gpiod_put(cs35l41->reset_gpio);
 
@@ -529,7 +534,7 @@ void cs35l41_hda_remove(struct device *dev)
 
 	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
 
-	if (!cs35l41->hw_cfg.vspk_always_on)
+	if (cs35l41->hw_cfg.bst_type != CS35L41_EXT_BOOST_NO_VSPK_SWITCH)
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 	gpiod_put(cs35l41->reset_gpio);
 }
-- 
2.35.1

