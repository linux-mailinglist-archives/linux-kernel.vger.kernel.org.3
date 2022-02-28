Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D864C7310
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiB1Rbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbiB1RaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:30:06 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D4751E7D;
        Mon, 28 Feb 2022 09:28:17 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21SFwZIj005113;
        Mon, 28 Feb 2022 11:28:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=kRquVZt2Nc4RgM42uE1tX7b+hLjImnlH6w2zpc+0P3g=;
 b=R+0E+ShZ+bskI8bP7JGw9RFuEMJH45i3rh/J66Y8EQ1CjzBZxZyT5BgZCgAdXnsmunze
 NSmDrbUNYUBDpxlUzCoCmP2FuuHTU0a5fbA/H124levd5zAi23WghZa93EfB9dLEbC0d
 68BdC0JgX/+EXJMOIbW6T5jjM91FeanlHS4V5PeA4esblBMF5M2yHfznGaWx0rk8q3xo
 yjgDCYTWlrzBTA72pqVwkF1H7j45I+77eRDCv7Nm5kYzcM/NMrH5/KydXLg2fdOinq71
 6ueu+n4+ntfD/ILwiTasFNoo85+FGQprlR3a9WhagdUcesZskhwhquRPvPQ9qa1rIbex jA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3efjg5thq9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Feb 2022 11:28:01 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 17:27:58 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 28 Feb 2022 17:27:58 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.213])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4547BB1A;
        Mon, 28 Feb 2022 17:27:58 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH V3 2/2] ASoC: audio_graph_card2: Add support for variable slot widths
Date:   Mon, 28 Feb 2022 17:27:54 +0000
Message-ID: <20220228172754.453783-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220228172754.453783-1-rf@opensource.cirrus.com>
References: <20220228172754.453783-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BG3ndA9ZM39saCFu_8Zg1TKOhGAPYTfq
X-Proofpoint-ORIG-GUID: BG3ndA9ZM39saCFu_8Zg1TKOhGAPYTfq
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some audio hardware cannot support the same slot width for all sample
widths, or a slot width equal to the sample width for all sample widths.
This is usually due either to limitations of the audio serial port or
system clocking restrictions.
A typical example would be:

- 16-bit samples in 16-bit slots
- 24-bit samples in 32-bit slots

The new dai-tdm-slot-width-map property allows setting a mapping of
sample widths and the corresponding tdm slot widths and slot counts.
Although the slot count is usually the same for all cases this does
allow for adding padding slots to maintain the same bitclk frequency.

The property is added to each endpoint node that needs the component
DAI to be told the TDM slot width and count.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/simple_card_utils.h     | 11 +++
 sound/soc/generic/audio-graph-card2.c |  4 ++
 sound/soc/generic/simple-card-utils.c | 97 +++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 5ee269c59aac..8faa649f712b 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -16,6 +16,12 @@
 #define asoc_simple_init_mic(card, sjack, prefix) \
 	asoc_simple_init_jack(card, sjack, 0, prefix, NULL)
 
+struct asoc_simple_tdm_width_map {
+	u8 sample_bits;
+	u8 slot_count;
+	u16 slot_width;
+};
+
 struct asoc_simple_dai {
 	const char *name;
 	unsigned int sysclk;
@@ -26,6 +32,8 @@ struct asoc_simple_dai {
 	unsigned int rx_slot_mask;
 	struct clk *clk;
 	bool clk_fixed;
+	struct asoc_simple_tdm_width_map *tdm_width_map;
+	int n_tdm_widths;
 };
 
 struct asoc_simple_data {
@@ -132,6 +140,9 @@ int asoc_simple_parse_daifmt(struct device *dev,
 			     struct device_node *codec,
 			     char *prefix,
 			     unsigned int *retfmt);
+int asoc_simple_parse_tdm_width_map(struct device *dev, struct device_node *np,
+				    struct asoc_simple_dai *dai);
+
 __printf(3, 4)
 int asoc_simple_set_dailink_name(struct device *dev,
 				 struct snd_soc_dai_link *dai_link,
diff --git a/sound/soc/generic/audio-graph-card2.c b/sound/soc/generic/audio-graph-card2.c
index c3947347dda3..c0f3907a01fd 100644
--- a/sound/soc/generic/audio-graph-card2.c
+++ b/sound/soc/generic/audio-graph-card2.c
@@ -503,6 +503,10 @@ static int __graph_parse_node(struct asoc_simple_priv *priv,
 	if (ret < 0)
 		return ret;
 
+	ret = asoc_simple_parse_tdm_width_map(dev, ep, dai);
+	if (ret < 0)
+		return ret;
+
 	ret = asoc_simple_parse_clk(dev, ep, dai, dlc);
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index a4babfb63175..14c8b3a74c2d 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -12,6 +12,7 @@
 #include <linux/of_gpio.h>
 #include <linux/of_graph.h>
 #include <sound/jack.h>
+#include <sound/pcm_params.h>
 #include <sound/simple_card_utils.h>
 
 void asoc_simple_convert_fixup(struct asoc_simple_data *data,
@@ -87,6 +88,51 @@ int asoc_simple_parse_daifmt(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_parse_daifmt);
 
+int asoc_simple_parse_tdm_width_map(struct device *dev, struct device_node *np,
+				    struct asoc_simple_dai *dai)
+{
+	u32 *array_values, *p;
+	int n, i, ret;
+
+	if (!of_property_read_bool(np, "dai-tdm-slot-width-map"))
+		return 0;
+
+	n = of_property_count_elems_of_size(np, "dai-tdm-slot-width-map", sizeof(u32));
+	if (n % 3) {
+		dev_err(dev, "Invalid number of cells for dai-tdm-slot-width-map\n");
+		return -EINVAL;
+	}
+
+	dai->tdm_width_map = devm_kcalloc(dev, n, sizeof(*dai->tdm_width_map), GFP_KERNEL);
+	if (!dai->tdm_width_map)
+		return -ENOMEM;
+
+	array_values = kcalloc(n, sizeof(*array_values), GFP_KERNEL);
+	if (!array_values)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, "dai-tdm-slot-width-map", array_values, n);
+	if (ret < 0) {
+		dev_err(dev, "Could not read dai-tdm-slot-width-map: %d\n", ret);
+		goto out;
+	}
+
+	p = array_values;
+	for (i = 0; i < n / 3; ++i) {
+		dai->tdm_width_map[i].sample_bits = *p++;
+		dai->tdm_width_map[i].slot_width = *p++;
+		dai->tdm_width_map[i].slot_count = *p++;
+	}
+
+	dai->n_tdm_widths = i;
+	ret = 0;
+out:
+	kfree(array_values);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_parse_tdm_width_map);
+
 int asoc_simple_set_dailink_name(struct device *dev,
 				 struct snd_soc_dai_link *dai_link,
 				 const char *fmt, ...)
@@ -309,6 +355,42 @@ static int asoc_simple_set_clk_rate(struct device *dev,
 	return clk_set_rate(simple_dai->clk, rate);
 }
 
+static int asoc_simple_set_tdm(struct snd_soc_dai *dai,
+				struct asoc_simple_dai *simple_dai,
+				struct snd_pcm_hw_params *params)
+{
+	int sample_bits = params_width(params);
+	int slot_width = simple_dai->slot_width;
+	int slot_count = simple_dai->slots;
+	int i, ret;
+
+	if (!simple_dai || !simple_dai->tdm_width_map)
+		return 0;
+
+	if (slot_width == 0)
+		slot_width = sample_bits;
+
+	for (i = 0; i < simple_dai->n_tdm_widths; ++i) {
+		if (simple_dai->tdm_width_map[i].sample_bits == sample_bits) {
+			slot_width = simple_dai->tdm_width_map[i].slot_width;
+			slot_count = simple_dai->tdm_width_map[i].slot_count;
+			break;
+		}
+	}
+
+	ret = snd_soc_dai_set_tdm_slot(dai,
+				       simple_dai->tx_slot_mask,
+				       simple_dai->rx_slot_mask,
+				       slot_count,
+				       slot_width);
+	if (ret && ret != -ENOTSUPP) {
+		dev_err(dai->dev, "simple-card: set_tdm_slot error: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 int asoc_simple_hw_params(struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params)
 {
@@ -362,6 +444,21 @@ int asoc_simple_hw_params(struct snd_pcm_substream *substream,
 				return ret;
 		}
 	}
+
+	for_each_prop_dai_codec(props, i, pdai) {
+		sdai = asoc_rtd_to_codec(rtd, i);
+		ret = asoc_simple_set_tdm(sdai, pdai, params);
+		if (ret < 0)
+			return ret;
+	}
+
+	for_each_prop_dai_cpu(props, i, pdai) {
+		sdai = asoc_rtd_to_cpu(rtd, i);
+		ret = asoc_simple_set_tdm(sdai, pdai, params);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_hw_params);
-- 
2.30.2

