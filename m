Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFF855FB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiF2JHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiF2JHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:07:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9321429C93
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:07:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f190so8635978wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvRHpEuM0xL4Ig3rSMG67s5DNIqr9l5dziqEAdf8e6A=;
        b=eIulRGfsJ6WI4mlYvMyeshFZzNh5ZkRuw8+FjtEGvSZqCfeuFikmx6zqVCBqDuhQuL
         D4yTPfb5E8K1ZgKjLzh3cWURUI678wg3l8IBeS3fNte3PNmjZdggJHOT0yP2KMCUTJef
         fMJazeRRHA7/Y017u5jwLZvL12BrqT0b9JsBCdo9ZfDkxXRowOPG0z++mKex9cJZvBC0
         LeVhuYtJxX1s1bg2vaTqZ0rtm3Z8kzMz+0c9SNVnV+p6i/khpKQnwia0x25xTLLqi8Be
         bINQq8MoEcdS0MTj86f+Q2xZucwbpy6qN57ry5Iy94bJUc198r8yHebjVbOS9IX7oSpH
         Nw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvRHpEuM0xL4Ig3rSMG67s5DNIqr9l5dziqEAdf8e6A=;
        b=wodPZY2cAX02jAqvqnnijtjFRLSE4nHxCek4zJT6y08otnCe5H78E7MWnSFEpSP9Ui
         xezYwTXXSejcdh+lyet6Es2qlcBuQOi+ntA9J57hxCh1J0YCMs3kygeqtDpgQp0AVr7T
         fKMJZDWSxviAgy7jF/Gu137YBoqSE9fuQfoW1Miy75DkzU7219IPedgjH2H+yg4VIftj
         fi2IZGq5UOFmLFp1MZpsemuK3fAk5/nmQw/z5tGhpP8ce1q6+/LaB74MccWzxaIoM72m
         SD/ElIpYH9Ywf0VW6PwQHsqf7oV5xkPYf8C5BocRic9M1wfH07jdIduUwO1qLtJjAR+Y
         pmIw==
X-Gm-Message-State: AJIora9pazkEicz9IrHKKJPtXX8f62ERzSIcEKuSy8xdMsF3iTNgMJY1
        owzXoejwD7lBraL/Fp32mjtYAw==
X-Google-Smtp-Source: AGRyM1sqdcOO67Q4GH6190vNi8+fv2G1XQaln8hbux9UYguV5hoCwnddhrqxegcr9JjW9VuxxYfJbQ==
X-Received: by 2002:a7b:cf33:0:b0:3a0:5731:1055 with SMTP id m19-20020a7bcf33000000b003a057311055mr2425123wmg.140.1656493628061;
        Wed, 29 Jun 2022 02:07:08 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d530c000000b002185d79dc7fsm15993341wrv.75.2022.06.29.02.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:07:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] ASoC: codecs: wsa883x: add control, dapm widgets and map
Date:   Wed, 29 Jun 2022 10:06:43 +0100
Message-Id: <20220629090644.67982-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
References: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add controls, dapm widgets along with route.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 197 +++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 856709ec017e..800a4dd56b9e 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -473,6 +473,19 @@ enum wsa_port_ids {
 	WSA883X_PORT_VISENSE,
 };
 
+static const char * const wsa_dev_mode_text[] = {
+	"speaker", "receiver", "ultrasound"
+};
+
+enum {
+	SPEAKER,
+	RECEIVER,
+	ULTRASOUND,
+};
+
+static const struct soc_enum wsa_dev_mode_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(wsa_dev_mode_text), wsa_dev_mode_text);
+
 /* 4 ports */
 static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA883X_MAX_SWR_PORTS] = {
 	{
@@ -1066,6 +1079,95 @@ static struct sdw_slave_ops wsa883x_slave_ops = {
 	.port_prep = wsa883x_port_prep,
 };
 
+static int wsa_dev_mode_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wsa883x_priv *wsa883x = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.enumerated.item[0] = wsa883x->dev_mode;
+
+	return 0;
+}
+
+static int wsa_dev_mode_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wsa883x_priv *wsa883x = snd_soc_component_get_drvdata(component);
+
+	if (wsa883x->dev_mode == ucontrol->value.enumerated.item[0])
+		return 0;
+
+	wsa883x->dev_mode = ucontrol->value.enumerated.item[0];
+
+	return 0;
+}
+
+static const DECLARE_TLV_DB_SCALE(pa_gain, -300, 150, -300);
+
+static int wsa883x_get_swr_port(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct wsa883x_priv *data = snd_soc_component_get_drvdata(comp);
+	struct soc_mixer_control *mixer = (struct soc_mixer_control *)kcontrol->private_value;
+	int portidx = mixer->reg;
+
+	ucontrol->value.integer.value[0] = data->port_enable[portidx];
+
+
+	return 0;
+}
+
+static int wsa883x_set_swr_port(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct wsa883x_priv *data = snd_soc_component_get_drvdata(comp);
+	struct soc_mixer_control *mixer = (struct soc_mixer_control *)kcontrol->private_value;
+	int portidx = mixer->reg;
+
+	if (ucontrol->value.integer.value[0]) {
+		if (data->port_enable[portidx])
+			return 0;
+
+		data->port_enable[portidx] = true;
+	} else {
+		if (!data->port_enable[portidx])
+			return 0;
+
+		data->port_enable[portidx] = false;
+	}
+
+	return 1;
+}
+
+static int wsa883x_get_comp_offset(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wsa883x_priv *wsa883x = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = wsa883x->comp_offset;
+
+	return 0;
+}
+
+static int wsa883x_set_comp_offset(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wsa883x_priv *wsa883x = snd_soc_component_get_drvdata(component);
+
+	if (wsa883x->comp_offset == ucontrol->value.integer.value[0])
+		return 0;
+
+	wsa883x->comp_offset = ucontrol->value.integer.value[0];
+
+	return 1;
+}
+
 static int wsa883x_codec_probe(struct snd_soc_component *comp)
 {
 	struct wsa883x_priv *wsa883x = snd_soc_component_get_drvdata(comp);
@@ -1075,9 +1177,104 @@ static int wsa883x_codec_probe(struct snd_soc_component *comp)
 	return 0;
 }
 
+static int wsa883x_spkr_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wsa883x_priv *wsa883x = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (wsa883x->dev_mode == RECEIVER) {
+			snd_soc_component_write_field(component, WSA883X_CDC_PATH_MODE,
+						      WSA883X_RXD_MODE_MASK,
+						      WSA883X_RXD_MODE_HIFI);
+			snd_soc_component_write_field(component, WSA883X_SPKR_PWM_CLK_CTL,
+						      WSA883X_SPKR_PWM_FREQ_SEL_MASK,
+						      WSA883X_SPKR_PWM_FREQ_F600KHZ);
+			snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
+						       WSA883X_DRE_PROG_DELAY_MASK, 0x0);
+		} else if (wsa883x->dev_mode == SPEAKER) {
+			snd_soc_component_write_field(component, WSA883X_CDC_PATH_MODE,
+						      WSA883X_RXD_MODE_MASK,
+						      WSA883X_RXD_MODE_NORMAL);
+			snd_soc_component_write_field(component, WSA883X_SPKR_PWM_CLK_CTL,
+						      WSA883X_SPKR_PWM_FREQ_SEL_MASK,
+						      WSA883X_SPKR_PWM_FREQ_F300KHZ);
+			snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
+						       WSA883X_DRE_PROG_DELAY_MASK, 0x9);
+		}
+
+		snd_soc_component_write_field(component, WSA883X_DRE_CTL_1,
+					      WSA883X_DRE_GAIN_EN_MASK,
+					      WSA883X_DRE_GAIN_FROM_CSR);
+		if (wsa883x->port_enable[WSA883X_PORT_COMP])
+			snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
+						      WSA883X_DRE_OFFSET_MASK,
+						      wsa883x->comp_offset);
+		snd_soc_component_write_field(component, WSA883X_VBAT_ADC_FLT_CTL,
+					      WSA883X_VBAT_ADC_COEF_SEL_MASK,
+					      WSA883X_VBAT_ADC_COEF_F_1DIV16);
+		snd_soc_component_write_field(component, WSA883X_VBAT_ADC_FLT_CTL,
+					      WSA883X_VBAT_ADC_FLT_EN_MASK, 0x1);
+		snd_soc_component_write_field(component, WSA883X_PDM_WD_CTL,
+					      WSA883X_PDM_EN_MASK,
+					      WSA883X_PDM_ENABLE);
+		snd_soc_component_write_field(component, WSA883X_PA_FSM_CTL,
+					      WSA883X_GLOBAL_PA_EN_MASK,
+					      WSA883X_GLOBAL_PA_ENABLE);
+
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_component_write_field(component, WSA883X_VBAT_ADC_FLT_CTL,
+					      WSA883X_VBAT_ADC_FLT_EN_MASK, 0x0);
+		snd_soc_component_write_field(component, WSA883X_VBAT_ADC_FLT_CTL,
+					      WSA883X_VBAT_ADC_COEF_SEL_MASK,
+					      WSA883X_VBAT_ADC_COEF_F_1DIV2);
+		snd_soc_component_write_field(component, WSA883X_PA_FSM_CTL,
+					      WSA883X_GLOBAL_PA_EN_MASK, 0);
+		snd_soc_component_write_field(component, WSA883X_PDM_WD_CTL,
+					      WSA883X_PDM_EN_MASK, 0);
+		break;
+	}
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget wsa883x_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("IN"),
+	SND_SOC_DAPM_SPK("SPKR", wsa883x_spkr_event),
+};
+
+static const struct snd_kcontrol_new wsa883x_snd_controls[] = {
+	SOC_SINGLE_RANGE_TLV("PA Gain", WSA883X_DRE_CTL_1, 1,
+			     0x0, 0x1f, 1, pa_gain),
+	SOC_ENUM_EXT("WSA MODE", wsa_dev_mode_enum,
+		     wsa_dev_mode_get, wsa_dev_mode_put),
+	SOC_SINGLE_EXT("COMP Offset", SND_SOC_NOPM, 0, 4, 0,
+		       wsa883x_get_comp_offset, wsa883x_set_comp_offset),
+	SOC_SINGLE_EXT("DAC Switch", WSA883X_PORT_DAC, 0, 1, 0,
+		       wsa883x_get_swr_port, wsa883x_set_swr_port),
+	SOC_SINGLE_EXT("COMP Switch", WSA883X_PORT_COMP, 0, 1, 0,
+		       wsa883x_get_swr_port, wsa883x_set_swr_port),
+	SOC_SINGLE_EXT("BOOST Switch", WSA883X_PORT_BOOST, 0, 1, 0,
+		       wsa883x_get_swr_port, wsa883x_set_swr_port),
+	SOC_SINGLE_EXT("VISENSE Switch", WSA883X_PORT_VISENSE, 0, 1, 0,
+		       wsa883x_get_swr_port, wsa883x_set_swr_port),
+};
+
+static const struct snd_soc_dapm_route wsa883x_audio_map[] = {
+	{"SPKR", NULL, "IN"},
+};
+
 static const struct snd_soc_component_driver wsa883x_component_drv = {
 	.name = "WSA883x",
 	.probe = wsa883x_codec_probe,
+	.controls = wsa883x_snd_controls,
+	.num_controls = ARRAY_SIZE(wsa883x_snd_controls),
+	.dapm_widgets = wsa883x_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wsa883x_dapm_widgets),
+	.dapm_routes = wsa883x_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(wsa883x_audio_map),
 };
 
 static int wsa883x_hw_params(struct snd_pcm_substream *substream,
-- 
2.25.1

