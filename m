Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBDF561A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiF3Mgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiF3Mgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:36:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52953B294
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:36:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso2157744wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nCSOjH1PuVz7ePXYoaMNJhxlzN8X+wOXCrrgiX6Y81E=;
        b=MtYVdhYetN7Bd35GsZbA5nac6CSxeMCF5wY5tOcm+FKgAcrWM8HUeoYSPDNgC9jWOG
         sLQkCl3wq8zXGkCIrlkeMTVAcRONm699mIRHlgnxyhdfezZKoKEdE7pNxtHWSL3VfbxP
         6ujrCzvHO7OQzEDHGXPd+43AD39cScbJtLftOCk6ATNjZnKIKefRhz3faWtD2Wyri544
         OuHoJJC08ZZnHtcHuRaNxrCzluvGQQ4HULdAPs/PR9wiFlQf2oh/UET4bwHsbjtyqIkf
         ulZouAgJvJ9XMCLkSZAJ8Jr/FcQBukc/CXiI8tTwu3BQEcFydgOiFLcb2AaxALjXW7zc
         huiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nCSOjH1PuVz7ePXYoaMNJhxlzN8X+wOXCrrgiX6Y81E=;
        b=BTEKMNZLoYrmLZUO8AJApJmJJ3y7y/FdXG36UxHIOi/F6nS9cjh7yUAqpJf9Osd4VW
         qF7Y9orlncrmDbSL/pmD/2/CvKIIbK5Q7t62J/QWWCdcSoDfyH48ahOd01Wiv+l8lBQV
         HSoAKk7icBpEzc/M0/oAknkzUqdKyqf7sITkJlmZjsuUxeOTuYnhcW4omFu6CjFTBQcA
         dA3YjU2rL5CNuRXMk+Pkn7m3H7MMR9cSuJGjsS84U0gFq3wBn3KeTKn8suT7feYkRwY7
         z/k+sQHTSogBFUw9dcaFjjOEHsgoJd0fBRRJrS+tnYEBVzyQYujbQHTZsaxOGPl5rZ3m
         E7Sg==
X-Gm-Message-State: AJIora8IwMEUR39gOMJLZAx5xBX0L/rmJzfqYZCJltaJRFlhe9LybC06
        j31rDgw9+tHCVVcuGSmptrMvcQ==
X-Google-Smtp-Source: AGRyM1vnV+qyq94vbIlHHTuN9r1agP/6Tx4U8p9Gh8Ce0+IUEaZtDJH/LazctjXg9922LcB67IFT6Q==
X-Received: by 2002:a7b:c155:0:b0:3a0:43a2:e1e1 with SMTP id z21-20020a7bc155000000b003a043a2e1e1mr12207682wmi.160.1656592599505;
        Thu, 30 Jun 2022 05:36:39 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b0039ee391a024sm2477290wms.14.2022.06.30.05.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 05:36:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3] ASoC: codecs: wsa883x: add control, dapm widgets and map
Date:   Thu, 30 Jun 2022 13:36:33 +0100
Message-Id: <20220630123633.8047-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
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
Changes since v2:
	- updated dev mode text entries to start with Capital letter

 sound/soc/codecs/wsa883x.c | 200 +++++++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 856709ec017e..e8f519e89213 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -473,6 +473,19 @@ enum wsa_port_ids {
 	WSA883X_PORT_VISENSE,
 };
 
+static const char * const wsa_dev_mode_text[] = {
+	"Speaker", "Receiver", "Ultrasound"
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
@@ -1066,6 +1079,94 @@ static struct sdw_slave_ops wsa883x_slave_ops = {
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
+	return 1;
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
@@ -1075,9 +1176,108 @@ static int wsa883x_codec_probe(struct snd_soc_component *comp)
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
+		switch (wsa883x->dev_mode) {
+		case RECEIVER:
+			snd_soc_component_write_field(component, WSA883X_CDC_PATH_MODE,
+						      WSA883X_RXD_MODE_MASK,
+						      WSA883X_RXD_MODE_HIFI);
+			snd_soc_component_write_field(component, WSA883X_SPKR_PWM_CLK_CTL,
+						      WSA883X_SPKR_PWM_FREQ_SEL_MASK,
+						      WSA883X_SPKR_PWM_FREQ_F600KHZ);
+			snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
+						       WSA883X_DRE_PROG_DELAY_MASK, 0x0);
+			break;
+		case SPEAKER:
+			snd_soc_component_write_field(component, WSA883X_CDC_PATH_MODE,
+						      WSA883X_RXD_MODE_MASK,
+						      WSA883X_RXD_MODE_NORMAL);
+			snd_soc_component_write_field(component, WSA883X_SPKR_PWM_CLK_CTL,
+						      WSA883X_SPKR_PWM_FREQ_SEL_MASK,
+						      WSA883X_SPKR_PWM_FREQ_F300KHZ);
+			snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
+						       WSA883X_DRE_PROG_DELAY_MASK, 0x9);
+		default:
+			break;
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
+	SOC_SINGLE_RANGE_TLV("PA Volume", WSA883X_DRE_CTL_1, 1,
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

