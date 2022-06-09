Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9715449DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242816AbiFILTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiFILTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:19:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D891634BAB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:19:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u8so27617968wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FO/y+Xl/nYjfPPEc3rgv0RHcVSPJe5N+/mRzl5i3y4A=;
        b=oRimfVOLAMrzs3W4YI/uKTBmUgOn+kEn6h8yO7geBYuYouI0PRDInPVmnoYza+uhxq
         TfwfOgtR4i5iEJE1EErXzjMZ9XsLl/oqXnUQU4hP6wXwWbssD/+E9pPARTeztBcz+Unf
         IWrPDkciy4/thi6XRxUQw2qMeGZpNxw/kUc1pcR5ZqN/WXzNIe3WR3CZRtPO45dNJBh/
         RfXBEZxt4gMythKe8BXYXXWbPCsq/HwpTTqdd3G37ThyY0ne9IgsgZhW7Sb7j2rePUBH
         +veIxj8bCbN8xateH9AUonm9ZoVyYt4d4zH9NtljCP+nRwvyGsVDuXy2c+XrU7Aj8rEG
         CkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FO/y+Xl/nYjfPPEc3rgv0RHcVSPJe5N+/mRzl5i3y4A=;
        b=f4x0b7pfZ5a8isMCoBVCcN6OoXHP9NFrT6o/sGSsVLiMOPFR4jmXE+1SZGLMiHFqKh
         O/PCNcfVxyLGMVE2e1F0wb4/tFwqrkAhVniapp9xFrgFKGeZCHdKTUeK89PK7/prMiOT
         g/dnxFATqW6oGDiGftXHV9hywtBGn9dWRnwMdR1EASTfzvbCyjEuU4xniS9VQt6T6yk0
         0qPxTV6S9M2oQEcEG8gWylVvVSZJUGYgIeOSIv/ZG1mmVecmUvN0NVz3xk3fMOua1ZkV
         2cXoJPjiOPAOdRKxx/brJBK/HW1SR5Xhm/Ov/Bj9yp82y2LQCMY62VeILmjvI7nhupX0
         ZolA==
X-Gm-Message-State: AOAM530Pr6gjoOq8quj05CpmV8cLzi82a8n1DDhfybuKk8Hh0ubEcWO1
        PpxRd+6qowGhGg04T2XulkXICg==
X-Google-Smtp-Source: ABdhPJy99C7EmQWXmN9ew1aJ94+Hohh4bCwC8l9VmgHJhn5iP6k+nPZ/sxc4E1j+oR6ZgP/euv5X1Q==
X-Received: by 2002:a05:6000:1683:b0:218:54a2:71cc with SMTP id y3-20020a056000168300b0021854a271ccmr12335075wrd.417.1654773552426;
        Thu, 09 Jun 2022 04:19:12 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id o22-20020a1c7516000000b003942a244ed1sm26477850wmc.22.2022.06.09.04.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:19:10 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: codecs: msm8916-wcd-digital: move gains from SX_TLV to S8_TLV
Date:   Thu,  9 Jun 2022 12:19:00 +0100
Message-Id: <20220609111901.318047-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609111901.318047-1-srinivas.kandagatla@linaro.org>
References: <20220609111901.318047-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move all the digital gains form using SX_TLV to S8_TLV, these gains are
actually 8 bit gains with 7th signed bit and ranges from -84dB to +40dB

rest of the Qualcomm wcd codecs uses these properly.

Fixes: ef8a4757a6db ("ASoC: msm8916-wcd-digital: Add sidetone support")
Fixes: 150db8c5afa1 ("ASoC: codecs: Add msm8916-wcd digital codec")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 46 +++++++++++++-------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 20a07c92b2fc..098a58990f07 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -328,8 +328,8 @@ static const struct snd_kcontrol_new rx1_mix2_inp1_mux = SOC_DAPM_ENUM(
 static const struct snd_kcontrol_new rx2_mix2_inp1_mux = SOC_DAPM_ENUM(
 				"RX2 MIX2 INP1 Mux", rx2_mix2_inp1_chain_enum);
 
-/* Digital Gain control -38.4 dB to +38.4 dB in 0.3 dB steps */
-static const DECLARE_TLV_DB_SCALE(digital_gain, -3840, 30, 0);
+/* Digital Gain control -84 dB to +40 dB in 1 dB steps */
+static const DECLARE_TLV_DB_SCALE(digital_gain, -8400, 100, -8400);
 
 /* Cutoff Freq for High Pass Filter at -3dB */
 static const char * const hpf_cutoff_text[] = {
@@ -510,15 +510,15 @@ static int wcd_iir_filter_info(struct snd_kcontrol *kcontrol,
 
 static const struct snd_kcontrol_new msm8916_wcd_digital_snd_controls[] = {
 	SOC_SINGLE_S8_TLV("RX1 Digital Volume", LPASS_CDC_RX1_VOL_CTL_B2_CTL,
-			  -128, 127, digital_gain),
+			-84, 40, digital_gain),
 	SOC_SINGLE_S8_TLV("RX2 Digital Volume", LPASS_CDC_RX2_VOL_CTL_B2_CTL,
-			  -128, 127, digital_gain),
+			-84, 40, digital_gain),
 	SOC_SINGLE_S8_TLV("RX3 Digital Volume", LPASS_CDC_RX3_VOL_CTL_B2_CTL,
-			  -128, 127, digital_gain),
+			-84, 40, digital_gain),
 	SOC_SINGLE_S8_TLV("TX1 Digital Volume", LPASS_CDC_TX1_VOL_CTL_GAIN,
-			  -128, 127, digital_gain),
+			-84, 40, digital_gain),
 	SOC_SINGLE_S8_TLV("TX2 Digital Volume", LPASS_CDC_TX2_VOL_CTL_GAIN,
-			  -128, 127, digital_gain),
+			-84, 40, digital_gain),
 	SOC_ENUM("TX1 HPF Cutoff", tx1_hpf_cutoff_enum),
 	SOC_ENUM("TX2 HPF Cutoff", tx2_hpf_cutoff_enum),
 	SOC_SINGLE("TX1 HPF Switch", LPASS_CDC_TX1_MUX_CTL, 3, 1, 0),
@@ -553,22 +553,22 @@ static const struct snd_kcontrol_new msm8916_wcd_digital_snd_controls[] = {
 	WCD_IIR_FILTER_CTL("IIR2 Band3", IIR2, BAND3),
 	WCD_IIR_FILTER_CTL("IIR2 Band4", IIR2, BAND4),
 	WCD_IIR_FILTER_CTL("IIR2 Band5", IIR2, BAND5),
-	SOC_SINGLE_SX_TLV("IIR1 INP1 Volume", LPASS_CDC_IIR1_GAIN_B1_CTL,
-			0,  -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("IIR1 INP2 Volume", LPASS_CDC_IIR1_GAIN_B2_CTL,
-			0,  -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("IIR1 INP3 Volume", LPASS_CDC_IIR1_GAIN_B3_CTL,
-			0,  -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("IIR1 INP4 Volume", LPASS_CDC_IIR1_GAIN_B4_CTL,
-			0,  -84,	40, digital_gain),
-	SOC_SINGLE_SX_TLV("IIR2 INP1 Volume", LPASS_CDC_IIR2_GAIN_B1_CTL,
-			0,  -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("IIR2 INP2 Volume", LPASS_CDC_IIR2_GAIN_B2_CTL,
-			0,  -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("IIR2 INP3 Volume", LPASS_CDC_IIR2_GAIN_B3_CTL,
-			0,  -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("IIR2 INP4 Volume", LPASS_CDC_IIR2_GAIN_B4_CTL,
-			0,  -84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("IIR1 INP1 Volume", LPASS_CDC_IIR1_GAIN_B1_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("IIR1 INP2 Volume", LPASS_CDC_IIR1_GAIN_B2_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("IIR1 INP3 Volume", LPASS_CDC_IIR1_GAIN_B3_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("IIR1 INP4 Volume", LPASS_CDC_IIR1_GAIN_B4_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("IIR2 INP1 Volume", LPASS_CDC_IIR2_GAIN_B1_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("IIR2 INP2 Volume", LPASS_CDC_IIR2_GAIN_B2_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("IIR2 INP3 Volume", LPASS_CDC_IIR2_GAIN_B3_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("IIR2 INP4 Volume", LPASS_CDC_IIR2_GAIN_B4_CTL,
+			-84, 40, digital_gain),
 
 };
 
-- 
2.25.1

