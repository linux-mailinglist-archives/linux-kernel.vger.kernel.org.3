Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A4C4BF78F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiBVMBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiBVMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8298C156C64
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s13so4184296wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FmiJNex1ot8tDEQkrlMDikI8ft3IlZn2sN6gtT8TTKk=;
        b=NFB3RliSVCvIj1utGaE/jSklWt1AArhvVYfiMhiGpoNLoRv65H7F7COpmVqkX/CmKk
         D88sHc4WmVJ5AQlccvWS/rDejHhplBiTj6CYQVahEKJFZ3MUNg8ByGToogl9GHCbs7St
         qQtjocyj7dMI/0dXBEN3DFVvFWAtlu4XysqdruQ3xlv9dmlLXdKshOrhekswoHG2Lq4X
         jlHzhyBFFuFWkLpxDFIgkBC6VrhbQwOQoqvRdiIwShMkD8mCCOow/iMu9Q7dVitNSGoD
         UmL+1Q58u6wBi5owCaGJSHaGtvutHULTfMpGF+n6lE15gKDVSaRdzFf47XnKRzKDypjs
         NwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FmiJNex1ot8tDEQkrlMDikI8ft3IlZn2sN6gtT8TTKk=;
        b=ZBcD3hRc5mCBUdmfPPSG4R5h/7xtOi7kinRARml9WB8wfYa0Qs0xp1bV1gnAKKpRH4
         f3vA4rA0OcSmkB3npOn42YmHYiJGcsV/8gXAS9BvDfP595VJkXm9CSSmMXnA8AY5Yhd5
         oXx7K72msHQyG20tQ4ryA+AZmn47QhBODgmXj95V6xrpKE4jn8f2nM6OcSAXJy0fGlE8
         RGk0a+Cl6SksD23f4zm1a2aP9dxa4QnSwOlwtyMIaECzDeDPgUxqP2Wp1e9SEX+Jv5av
         WUBn0pwzB0AVyHDWnGFQ+KYiyn+GT+U5t+z1fa0i59YJKyu7eCL4+jB3BOfglEBW3rp6
         vEoA==
X-Gm-Message-State: AOAM533oJmngvPft5lxJkztV2s9AtyzbOC2rI7/cFHVxnNNMj+8VAFhf
        St1HiU9pK0PJbIPHazbKEaoWaw==
X-Google-Smtp-Source: ABdhPJz4PUmhR2AT0PBVCIOTknderZ9Je7FIrmTupP/bK0KhlsEDdjeHurgqYXa+WjyF7LnxbZiDaw==
X-Received: by 2002:a05:6000:154c:b0:1ea:76b7:20c4 with SMTP id 12-20020a056000154c00b001ea76b720c4mr4529319wry.626.1645531197891;
        Tue, 22 Feb 2022 03:59:57 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:59:57 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/16] ASoC: codecs: rx-macro: fix tlv min max range
Date:   Tue, 22 Feb 2022 11:59:27 +0000
Message-Id: <20220222115933.9114-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
References: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
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

on Qualcomm codecs gain tlv control specifies min max range as both
negative to positive numbers like

SOC_SINGLE_S8_TLV("... Volume", ..,  -84, 40, gain)

However with recent boundary checks added in commit 817f7c9335ec0
("ASoC: ops: Reject out of bounds values in snd_soc_put_volsw())
setting a value above 40 gain will fail.

So fix this min max range correctly to
SOC_SINGLE_S8_TLV("... Volume", ..,  0, 124, gain)
so that users can now set gain correctly

Fixes: af3d54b99764 ("ASoC: codecs: lpass-rx-macro: add support for lpass rx macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 058d8634ce40..d31d4d45ba01 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2800,17 +2800,17 @@ static int rx_macro_iir_filter_info(struct snd_kcontrol *kcontrol,
 
 static const struct snd_kcontrol_new rx_macro_snd_controls[] = {
 	SOC_SINGLE_S8_TLV("RX_RX0 Digital Volume", CDC_RX_RX0_RX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX_RX1 Digital Volume", CDC_RX_RX1_RX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX_RX2 Digital Volume", CDC_RX_RX2_RX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX_RX0 Mix Digital Volume", CDC_RX_RX0_RX_VOL_MIX_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX_RX1 Mix Digital Volume", CDC_RX_RX1_RX_VOL_MIX_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX_RX2 Mix Digital Volume", CDC_RX_RX2_RX_VOL_MIX_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 
 	SOC_SINGLE_EXT("RX_COMP1 Switch", SND_SOC_NOPM, RX_MACRO_COMP1, 1, 0,
 		rx_macro_get_compander, rx_macro_set_compander),
@@ -2834,28 +2834,28 @@ static const struct snd_kcontrol_new rx_macro_snd_controls[] = {
 			rx_macro_aux_hpf_mode_put),
 
 	SOC_SINGLE_S8_TLV("IIR0 INP0 Volume",
-		CDC_RX_SIDETONE_IIR0_IIR_GAIN_B1_CTL, -84, 40,
+		CDC_RX_SIDETONE_IIR0_IIR_GAIN_B1_CTL, 0, 124,
 		digital_gain),
 	SOC_SINGLE_S8_TLV("IIR0 INP1 Volume",
-		CDC_RX_SIDETONE_IIR0_IIR_GAIN_B2_CTL, -84, 40,
+		CDC_RX_SIDETONE_IIR0_IIR_GAIN_B2_CTL, 0, 124,
 		digital_gain),
 	SOC_SINGLE_S8_TLV("IIR0 INP2 Volume",
-		CDC_RX_SIDETONE_IIR0_IIR_GAIN_B3_CTL, -84, 40,
+		CDC_RX_SIDETONE_IIR0_IIR_GAIN_B3_CTL, 0, 124,
 		digital_gain),
 	SOC_SINGLE_S8_TLV("IIR0 INP3 Volume",
-		CDC_RX_SIDETONE_IIR0_IIR_GAIN_B4_CTL, -84, 40,
+		CDC_RX_SIDETONE_IIR0_IIR_GAIN_B4_CTL, 0, 124,
 		digital_gain),
 	SOC_SINGLE_S8_TLV("IIR1 INP0 Volume",
-		CDC_RX_SIDETONE_IIR1_IIR_GAIN_B1_CTL, -84, 40,
+		CDC_RX_SIDETONE_IIR1_IIR_GAIN_B1_CTL, 0, 124,
 		digital_gain),
 	SOC_SINGLE_S8_TLV("IIR1 INP1 Volume",
-		CDC_RX_SIDETONE_IIR1_IIR_GAIN_B2_CTL, -84, 40,
+		CDC_RX_SIDETONE_IIR1_IIR_GAIN_B2_CTL, 0, 124,
 		digital_gain),
 	SOC_SINGLE_S8_TLV("IIR1 INP2 Volume",
-		CDC_RX_SIDETONE_IIR1_IIR_GAIN_B3_CTL, -84, 40,
+		CDC_RX_SIDETONE_IIR1_IIR_GAIN_B3_CTL, 0, 124,
 		digital_gain),
 	SOC_SINGLE_S8_TLV("IIR1 INP3 Volume",
-		CDC_RX_SIDETONE_IIR1_IIR_GAIN_B4_CTL, -84, 40,
+		CDC_RX_SIDETONE_IIR1_IIR_GAIN_B4_CTL, 0, 124,
 		digital_gain),
 
 	SOC_SINGLE("IIR1 Band1 Switch", CDC_RX_SIDETONE_IIR0_IIR_CTL,
-- 
2.21.0

