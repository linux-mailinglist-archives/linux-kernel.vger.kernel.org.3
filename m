Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF8C5449DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbiFILTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbiFILTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:19:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41248DDEE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:19:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z9so5489324wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZJSswCGWMaH9Gz+kOuAf6ytw6vrkr1yTN4Lg9FPtP0=;
        b=xBqrNg9KKVu6SZc1GxgXSEhR+1JZWXAkOge99tA0ORYzfEbChmi+5TViL7TUfnrJPb
         X2DGKMm1z56pyydomoMZS3qB1rGaH7FnuwyV89l79P6jDuAIrU5n+MWZRGq6+Vk2VY92
         8XE93wJE037IHOlwXYDm9CaBEhz9q5awUjOBK5I6YzOGhryDT+tvBh92Qn6tDBl8yxU8
         tX2O4xlYB1hDQKLsS0NQLcXXWW10Hd/o2EJR38JHI66cyzLK+QiqAagqP034HM1SGu8g
         5a8f8T7mHgEkjoDOlk0imBzW8SScWBkKuvOxlsNCTN4q5pbT7J1NjQy4oTALU224EhFg
         qRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZJSswCGWMaH9Gz+kOuAf6ytw6vrkr1yTN4Lg9FPtP0=;
        b=pUT3c5unvvWIO8srip/s6w3y//Y15Dvy9TTltJB74WHcwK9m4eO9jtT09lWCtoJRg/
         9k8GEPLCsAjh7LvwWfJ2QAHG7epTh2jXfcHusDYhWYgP1PBLCFxhRQbozwFy7qHPFjzK
         2Zw78yUdRE29XsGjbHCAtAFWCbY4Ax9Jh5d1mXT9dksaix0rqQKOkx4J3Wmmhy5mllan
         ITkwRoE2sV6pyn+EoMY4J5QaOXeGLf+3QLkZ4VVI0tLVSk4VvkBpfqDqDu/dPTI12a9e
         o33kUSkcXUF82L2V9W2eozhfq3w2HePTV1WOfOJh/n3G1q4bVNuhGGYtlu2WsuzoMkKt
         cKqQ==
X-Gm-Message-State: AOAM532AocMCF+sq7ubX9DoNP858VuSMlv6VIy73UCHQ2mkvAVc7LYFg
        hrIaUUZxZsE9NKg1V8vHPky3GQ==
X-Google-Smtp-Source: ABdhPJw9zn0RkOe5DdDX7WWpabkr6e5Ps+WJTiyo5lJVo1Rp0/Xgi4rkCipV2m0jY4nKsH4ucoVpSQ==
X-Received: by 2002:a05:600c:a0b:b0:39c:3551:b226 with SMTP id z11-20020a05600c0a0b00b0039c3551b226mr2746192wmp.201.1654773554158;
        Thu, 09 Jun 2022 04:19:14 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id o22-20020a1c7516000000b003942a244ed1sm26477850wmc.22.2022.06.09.04.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:19:13 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoC: codecs: wcd9335: move gains from SX_TLV to S8_TLV
Date:   Thu,  9 Jun 2022 12:19:01 +0100
Message-Id: <20220609111901.318047-3-srinivas.kandagatla@linaro.org>
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

Fixes: 8c4f021d806a ("ASoC: wcd9335: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 81 +++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 45 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 617a36a89dfe..6e9c93540f7a 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -2253,51 +2253,42 @@ static int wcd9335_rx_hph_mode_put(struct snd_kcontrol *kc,
 
 static const struct snd_kcontrol_new wcd9335_snd_controls[] = {
 	/* -84dB min - 40dB max */
-	SOC_SINGLE_SX_TLV("RX0 Digital Volume", WCD9335_CDC_RX0_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX1 Digital Volume", WCD9335_CDC_RX1_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX2 Digital Volume", WCD9335_CDC_RX2_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX3 Digital Volume", WCD9335_CDC_RX3_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX4 Digital Volume", WCD9335_CDC_RX4_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX5 Digital Volume", WCD9335_CDC_RX5_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX6 Digital Volume", WCD9335_CDC_RX6_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX7 Digital Volume", WCD9335_CDC_RX7_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX8 Digital Volume", WCD9335_CDC_RX8_RX_VOL_CTL,
-		0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX0 Mix Digital Volume",
-			  WCD9335_CDC_RX0_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX1 Mix Digital Volume",
-			  WCD9335_CDC_RX1_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX2 Mix Digital Volume",
-			  WCD9335_CDC_RX2_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX3 Mix Digital Volume",
-			  WCD9335_CDC_RX3_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX4 Mix Digital Volume",
-			  WCD9335_CDC_RX4_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX5 Mix Digital Volume",
-			  WCD9335_CDC_RX5_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX6 Mix Digital Volume",
-			  WCD9335_CDC_RX6_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX7 Mix Digital Volume",
-			  WCD9335_CDC_RX7_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
-	SOC_SINGLE_SX_TLV("RX8 Mix Digital Volume",
-			  WCD9335_CDC_RX8_RX_VOL_MIX_CTL,
-			  0, -84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX0 Digital Volume", WCD9335_CDC_RX0_RX_VOL_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX1 Digital Volume", WCD9335_CDC_RX1_RX_VOL_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX2 Digital Volume", WCD9335_CDC_RX2_RX_VOL_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX3 Digital Volume", WCD9335_CDC_RX3_RX_VOL_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX4 Digital Volume", WCD9335_CDC_RX4_RX_VOL_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX5 Digital Volume", WCD9335_CDC_RX5_RX_VOL_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX6 Digital Volume", WCD9335_CDC_RX6_RX_VOL_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX7 Digital Volume", WCD9335_CDC_RX7_RX_VOL_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX8 Digital Volume", WCD9335_CDC_RX8_RX_VOL_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX0 Mix Digital Volume", WCD9335_CDC_RX0_RX_VOL_MIX_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX1 Mix Digital Volume", WCD9335_CDC_RX1_RX_VOL_MIX_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX2 Mix Digital Volume", WCD9335_CDC_RX2_RX_VOL_MIX_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX3 Mix Digital Volume", WCD9335_CDC_RX3_RX_VOL_MIX_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX4 Mix Digital Volume", WCD9335_CDC_RX4_RX_VOL_MIX_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX5 Mix Digital Volume", WCD9335_CDC_RX5_RX_VOL_MIX_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX6 Mix Digital Volume", WCD9335_CDC_RX6_RX_VOL_MIX_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX7 Mix Digital Volume", WCD9335_CDC_RX7_RX_VOL_MIX_CTL,
+			-84, 40, digital_gain),
+	SOC_SINGLE_S8_TLV("RX8 Mix Digital Volume", WCD9335_CDC_RX8_RX_VOL_MIX_CTL,
+			-84, 40, digital_gain),
 	SOC_ENUM("RX INT0_1 HPF cut off", cf_int0_1_enum),
 	SOC_ENUM("RX INT0_2 HPF cut off", cf_int0_2_enum),
 	SOC_ENUM("RX INT1_1 HPF cut off", cf_int1_1_enum),
-- 
2.25.1

