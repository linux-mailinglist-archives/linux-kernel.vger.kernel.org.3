Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7D4BF793
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiBVMBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiBVMAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:30 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644E3158DAA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:00:03 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s13so4184633wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KcD87WuVqOE7wlGnuGasxFMiIGXUTo8Tdbjfbz+gy5A=;
        b=x1SxOjEVDF/UusL/0LmmHYeP0Ofgtl2s6OI52+vXm+z6+SMO49T6Id0LmiWeUHvsDH
         SpTiR+thuI4SqWpu2ywNUvbEfT1kEJJB8NtRY3bAZTJpg5aVcM4vc2G4SItQhBR5rr1b
         Xx00hhIXMj+QrW19dcIzCIXRL5hDOSDKGIkSFrjH9hqd3LCeWKhyWXoK1qQTJCc77P9D
         lr6ShwJhp2T/tmanl6XbQEDs/o1U5rbhgpT6m430LS2DnjIr8IBAbJLuNWbloc8wMBGc
         UwdTqrsM/NkXi4PZRZXO46e9uUiarx856HcPfqfr2VHsrlhhFShpwOPEzcFQobtvEx5P
         eWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KcD87WuVqOE7wlGnuGasxFMiIGXUTo8Tdbjfbz+gy5A=;
        b=QPFoPxeFIXY/jacq7HFisLEcilXGund4GIVm3/GYDbeedrcCpUX73vz9un/pqpUw4p
         DxaE60BPKWrTDoXJCZvT/NTflE1oaxKSVU2B6Uv/tubM5vs845IcM5SoLWi4KVJnmkH1
         l3qImnYK36g6J7Z6SsQSZgdyPQU+SF4NV+gGQTAJdAxhcPcdLUuszCcFh4BGz1ZHmpP4
         daBC827kHNP/GCWh+xEYK0NYr7w+1BO925P3iOXk6+XR/Ei91gxpgj5LX79Yjlx2MKzS
         Szf74/3KmXNc+9eItn6WoVCD1GoKqr3Dr5BHITW3h5bjNHzzNv5J42hqHCYZfrWr2zM4
         v8Ew==
X-Gm-Message-State: AOAM530LOJOD2FcoD6KfZc+7/Xp/VvmMnr+aVYRlnrpdSd5NDc1xUiaf
        G0/J7RWHMFl8Kz/DWCDk7UCy6w==
X-Google-Smtp-Source: ABdhPJxmeBWo72PiNWEHoBgszTA9DNaXGtpZ+YmdIUWLfk09iBTb+c6uKkES/taiEMzmaAR2NhJlpA==
X-Received: by 2002:a05:6000:2ae:b0:1ea:78a3:fe7e with SMTP id l14-20020a05600002ae00b001ea78a3fe7emr4284839wry.682.1645531201945;
        Tue, 22 Feb 2022 04:00:01 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.04.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 04:00:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 14/16] ASoC: codecs: wcd938x: fix tlv min max range
Date:   Tue, 22 Feb 2022 11:59:31 +0000
Message-Id: <20220222115933.9114-15-srinivas.kandagatla@linaro.org>
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

Fixes: 1cde8b822332 ("ASoC: wcd934x: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 62 +++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index ab580f37cf00..5e45d5eec7c2 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3996,83 +3996,83 @@ static const struct snd_kcontrol_new wcd934x_snd_controls[] = {
 	SOC_SINGLE_TLV("ADC4 Volume", WCD934X_ANA_AMIC4, 0, 20, 0, analog_gain),
 
 	SOC_SINGLE_S8_TLV("RX0 Digital Volume", WCD934X_CDC_RX0_RX_VOL_CTL,
-			  -84, 40, digital_gain), /* -84dB min - 40dB max */
+			  0, 124, digital_gain), /* -84dB min - 40dB max */
 	SOC_SINGLE_S8_TLV("RX1 Digital Volume", WCD934X_CDC_RX1_RX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX2 Digital Volume", WCD934X_CDC_RX2_RX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX3 Digital Volume", WCD934X_CDC_RX3_RX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX4 Digital Volume", WCD934X_CDC_RX4_RX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX7 Digital Volume", WCD934X_CDC_RX7_RX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX8 Digital Volume", WCD934X_CDC_RX8_RX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX0 Mix Digital Volume",
 			  WCD934X_CDC_RX0_RX_VOL_MIX_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX1 Mix Digital Volume",
 			  WCD934X_CDC_RX1_RX_VOL_MIX_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX2 Mix Digital Volume",
 			  WCD934X_CDC_RX2_RX_VOL_MIX_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX3 Mix Digital Volume",
 			  WCD934X_CDC_RX3_RX_VOL_MIX_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX4 Mix Digital Volume",
 			  WCD934X_CDC_RX4_RX_VOL_MIX_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX7 Mix Digital Volume",
 			  WCD934X_CDC_RX7_RX_VOL_MIX_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("RX8 Mix Digital Volume",
 			  WCD934X_CDC_RX8_RX_VOL_MIX_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 
 	SOC_SINGLE_S8_TLV("DEC0 Volume", WCD934X_CDC_TX0_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("DEC1 Volume", WCD934X_CDC_TX1_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("DEC2 Volume", WCD934X_CDC_TX2_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("DEC3 Volume", WCD934X_CDC_TX3_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("DEC4 Volume", WCD934X_CDC_TX4_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("DEC5 Volume", WCD934X_CDC_TX5_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("DEC6 Volume", WCD934X_CDC_TX6_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("DEC7 Volume", WCD934X_CDC_TX7_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("DEC8 Volume", WCD934X_CDC_TX8_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 
 	SOC_SINGLE_S8_TLV("IIR0 INP0 Volume",
-			  WCD934X_CDC_SIDETONE_IIR0_IIR_GAIN_B1_CTL, -84, 40,
+			  WCD934X_CDC_SIDETONE_IIR0_IIR_GAIN_B1_CTL, 0, 124,
 			  digital_gain),
 	SOC_SINGLE_S8_TLV("IIR0 INP1 Volume",
-			  WCD934X_CDC_SIDETONE_IIR0_IIR_GAIN_B2_CTL, -84, 40,
+			  WCD934X_CDC_SIDETONE_IIR0_IIR_GAIN_B2_CTL, 0, 124,
 			  digital_gain),
 	SOC_SINGLE_S8_TLV("IIR0 INP2 Volume",
-			  WCD934X_CDC_SIDETONE_IIR0_IIR_GAIN_B3_CTL, -84, 40,
+			  WCD934X_CDC_SIDETONE_IIR0_IIR_GAIN_B3_CTL, 0, 124,
 			  digital_gain),
 	SOC_SINGLE_S8_TLV("IIR0 INP3 Volume",
-			  WCD934X_CDC_SIDETONE_IIR0_IIR_GAIN_B4_CTL, -84, 40,
+			  WCD934X_CDC_SIDETONE_IIR0_IIR_GAIN_B4_CTL, 0, 124,
 			  digital_gain),
 	SOC_SINGLE_S8_TLV("IIR1 INP0 Volume",
-			  WCD934X_CDC_SIDETONE_IIR1_IIR_GAIN_B1_CTL, -84, 40,
+			  WCD934X_CDC_SIDETONE_IIR1_IIR_GAIN_B1_CTL, 0, 124,
 			  digital_gain),
 	SOC_SINGLE_S8_TLV("IIR1 INP1 Volume",
-			  WCD934X_CDC_SIDETONE_IIR1_IIR_GAIN_B2_CTL, -84, 40,
+			  WCD934X_CDC_SIDETONE_IIR1_IIR_GAIN_B2_CTL, 0, 124,
 			  digital_gain),
 	SOC_SINGLE_S8_TLV("IIR1 INP2 Volume",
-			  WCD934X_CDC_SIDETONE_IIR1_IIR_GAIN_B3_CTL, -84, 40,
+			  WCD934X_CDC_SIDETONE_IIR1_IIR_GAIN_B3_CTL, 0, 124,
 			  digital_gain),
 	SOC_SINGLE_S8_TLV("IIR1 INP3 Volume",
-			  WCD934X_CDC_SIDETONE_IIR1_IIR_GAIN_B4_CTL, -84, 40,
+			  WCD934X_CDC_SIDETONE_IIR1_IIR_GAIN_B4_CTL, 0, 124,
 			  digital_gain),
 
 	SOC_ENUM("TX0 HPF cut off", cf_dec0_enum),
-- 
2.21.0

