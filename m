Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36525583945
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiG1HLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiG1HK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:10:58 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8781DD132;
        Thu, 28 Jul 2022 00:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658992257; x=1690528257;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=R4lt1h/LtXD8XZCgX0MqvcNhHlPUrXLCVf+2J1eJ5RA=;
  b=LUl4HB7awGDJO7ZT3dM+uFHqZqZhXyvs8bFO2qZfgODoMVUVv84Vv2F1
   NB6HxFc5Sfxm8Qb/Xg+5kJevT+3FQMbKgP/msxqtt3a5TSDB9v1V9MLOE
   XxysGtHps01KqlPSHpxZRWmrWMuuMZM9yO0ucXEziyEKDEmH/+80Bke4O
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Jul 2022 00:10:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 00:10:56 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Jul 2022 00:10:55 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Jul 2022 00:10:50 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH] ASoC: qcom: SC7280: Add support for external DMIC bias supply
Date:   Thu, 28 Jul 2022 12:40:33 +0530
Message-ID: <1658992233-28372-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update SC7280 machine driver for enabling external mic bias supply,
Which is required for villager rev boards.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 sound/soc/qcom/sc7280.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index da7469a..6404e94 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -33,6 +33,7 @@ struct sc7280_snd_data {
 	struct snd_soc_jack hdmi_jack;
 	bool jack_setup;
 	bool stream_prepared[LPASS_MAX_PORTS];
+	struct regulator *vdd_supply;
 };
 
 static void sc7280_jack_free(struct snd_jack *jack)
@@ -345,6 +346,24 @@ static int sc7280_snd_startup(struct snd_pcm_substream *substream)
 	return ret;
 }
 
+static int sc7280_dmic_micbias(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_card *card = w->dapm->card;
+	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(card);
+	int ret = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		ret = regulator_enable(data->vdd_supply);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		ret = regulator_disable(data->vdd_supply);
+		break;
+	}
+	return ret;
+}
+
 static const struct snd_soc_ops sc7280_ops = {
 	.startup = sc7280_snd_startup,
 	.hw_params = sc7280_snd_hw_params,
@@ -356,6 +375,7 @@ static const struct snd_soc_ops sc7280_ops = {
 static const struct snd_soc_dapm_widget sc7280_snd_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("PMIC BIAS", sc7280_dmic_micbias),
 };
 
 static int sc7280_snd_platform_probe(struct platform_device *pdev)
@@ -389,6 +409,10 @@ static int sc7280_snd_platform_probe(struct platform_device *pdev)
 		link->ops = &sc7280_ops;
 	}
 
+	data->vdd_supply = devm_regulator_get(dev, "vdd-dmic-bias");
+	if (IS_ERR(data->vdd_supply)
+		return PTR_ERR(data->vdd_supply);
+
 	return devm_snd_soc_register_card(dev, card);
 }
 
-- 
2.7.4

