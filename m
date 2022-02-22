Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D3F4BF796
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiBVMB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiBVMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFA81592AB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:00:04 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u1so32706913wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YmZEQ3ujH3Pl/PlsauuKASqPX6aha5wSkDNcz+GXFIs=;
        b=ZcSttheqZnwkIgV2EU86exfYjrFWaOGCDWXrMLKQ8kORkWiA8gaQCjNZk7zEtxkvwc
         BUbtMrKB1nEAK2jmQZvuLZrb0cwYMA12eF0ueiMTMakoKY8aUpBBD+mqwOYNaATSENF4
         sELx5pl6prlUVdzPKNa9yB3URLb2s4L6+tUIA4hUykhmidIrFyayNYhDiKQoDJuQ7LDr
         4aFJWt5v3fzyzdm100KtKwhoI+b/WfL5k+8CG8WTEqgUyDszA1CXsHTM6FVPope/3pzB
         Aly6MBZtia7ImgFjOU6LvPtrLc/ilDX5UibKm0jCCuYRzmyOIzpD/Lheev+vSOl5kZb/
         qQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YmZEQ3ujH3Pl/PlsauuKASqPX6aha5wSkDNcz+GXFIs=;
        b=lK09KCh8aNeDuj6AomLXxzZ3LglPdw7feYC35sMyLrf8c7AVcwvssRjoafS+eTpQgW
         85BNxeP0fUTjaGgamtic8lfEYHCl+PaLKrM8RdnkQnHBDkT9/cUHwA0ce4yxjJwpe/g0
         QTaUT25dAkA9AJn2YdV8ArkNwJaW0A+pMcAywKn5x7dkuBnJrRkEl7Dnoi5M36FeyeIC
         Evx4xHf/8PVYick6f9uaY5eZ2aclJdR+dtMVuS+JmZjkcfV4KsYTNRTOu1Y40SadUtAU
         CVASGgfWdnajFdC0223cMR5eEXZK/88KUYBB18Dfn80wA1I/9yVHMSFkAUoJosiXu5c8
         Hb9g==
X-Gm-Message-State: AOAM532UjehXRgwoaaBqvry74pGnaKv4jeI+FrOWip03dUwLM6U4/AgW
        FAyyk9FI04JFKMai7T7aLj3ntQ==
X-Google-Smtp-Source: ABdhPJxndahYnuQraQMbxX+OKEAxy1ZcBC0/LyfDFYD/2+U7rFud58FwmA390FMxfotlbCmKLdl1vg==
X-Received: by 2002:a5d:6546:0:b0:1e3:2236:e338 with SMTP id z6-20020a5d6546000000b001e32236e338mr18795796wrv.72.1645531203029;
        Tue, 22 Feb 2022 04:00:03 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 04:00:02 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 15/16] ASoC: codecs: wcd9335: fix tlv min max range
Date:   Tue, 22 Feb 2022 11:59:32 +0000
Message-Id: <20220222115933.9114-16-srinivas.kandagatla@linaro.org>
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

SOC_SINGLE_SX_TLV("... Volume", ..,  -84, 40, gain)

However with recent boundary checks added in commit 817f7c9335ec0
("ASoC: ops: Reject out of bounds values in snd_soc_put_volsw())
setting a value above 40 gain will fail.

So fix this min max range correctly to
SOC_SINGLE_SX_TLV("... Volume", ..,  0, 124, gain)
so that users can now set gain correctly

Fixes: 8c4f021d806a ("ASoC: wcd9335: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 1e60db4056ad..cf7bdd309f70 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -2254,50 +2254,50 @@ static int wcd9335_rx_hph_mode_put(struct snd_kcontrol *kc,
 static const struct snd_kcontrol_new wcd9335_snd_controls[] = {
 	/* -84dB min - 40dB max */
 	SOC_SINGLE_SX_TLV("RX0 Digital Volume", WCD9335_CDC_RX0_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
+		0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX1 Digital Volume", WCD9335_CDC_RX1_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
+		0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX2 Digital Volume", WCD9335_CDC_RX2_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
+		0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX3 Digital Volume", WCD9335_CDC_RX3_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
+		0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX4 Digital Volume", WCD9335_CDC_RX4_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
+		0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX5 Digital Volume", WCD9335_CDC_RX5_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
+		0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX6 Digital Volume", WCD9335_CDC_RX6_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
+		0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX7 Digital Volume", WCD9335_CDC_RX7_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
+		0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX8 Digital Volume", WCD9335_CDC_RX8_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
+		0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX0 Mix Digital Volume",
 			  WCD9335_CDC_RX0_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
+			  0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX1 Mix Digital Volume",
 			  WCD9335_CDC_RX1_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
+			  0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX2 Mix Digital Volume",
 			  WCD9335_CDC_RX2_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
+			  0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX3 Mix Digital Volume",
 			  WCD9335_CDC_RX3_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
+			  0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX4 Mix Digital Volume",
 			  WCD9335_CDC_RX4_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
+			  0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX5 Mix Digital Volume",
 			  WCD9335_CDC_RX5_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
+			  0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX6 Mix Digital Volume",
 			  WCD9335_CDC_RX6_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
+			  0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX7 Mix Digital Volume",
 			  WCD9335_CDC_RX7_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
+			  0, 0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("RX8 Mix Digital Volume",
 			  WCD9335_CDC_RX8_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
+			  0, 0, 124, digital_gain),
 	SOC_ENUM("RX INT0_1 HPF cut off", cf_int0_1_enum),
 	SOC_ENUM("RX INT0_2 HPF cut off", cf_int0_2_enum),
 	SOC_ENUM("RX INT1_1 HPF cut off", cf_int1_1_enum),
-- 
2.21.0

