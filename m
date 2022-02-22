Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960204BF797
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiBVMBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiBVMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851A71598CB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:00:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h6so32694223wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pmndN/v1gfV2GMDQd7C0kB+ah/Uk4LJSxeSRIEDOEZE=;
        b=Rpb2UzY+Gi6K58Fex63hU24KXZBDztbcykj7Zq4FXVoEsMWWI4+I5fZMp1UeRoKQVz
         MuvlZJ1KqmhQU2HS2raT4pjapl7iq4W2yWte+IPxqy8sTvcX20BqHEO7xqvj79qJilnL
         nAUEJ5Uh8vFXtKSbnstYctwUSXeafnXBn5izOdGlATMHpQ4NYIYw9HK2xtnvAXMIGHrS
         H423otBZ7ZMfeqEX7eJ+uF+0BcNFQfO+MYceerE3Ov0rFdYaWKIEixon+efn11ncEhwO
         DlNHJy3rhGllfXwnys1ZGQj5B2mf2B71Sdc8RA1gRZdYCfY+BogP3X48NHTINHHpBPkJ
         xMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pmndN/v1gfV2GMDQd7C0kB+ah/Uk4LJSxeSRIEDOEZE=;
        b=q8nekJ5UZPADTdvU3P34x6zdGffpfwnzgk8T1/OC7MAgjlVt7J6iP2MCSQWWxKhzCS
         51/94JAj2BaJZSEmNJ6PKycGQ3oRHXhUpAXO0YsPNr4XN/r9bRThqC+CNEX3lbUodXPX
         1vG/dHanAw3dLMT9S4kLNAO9qNz5hAOYomfeTHZrD0BiQzkH+eLzSaZUlDiX/kagiayM
         S8WhYAOklfjWvwzSYn6xGGYHg36Qf76eA6R2XV9WdDWczPluKJ+Q+IY8yzS0wPIBHCmN
         7Xwi7xQJiH+VbNNopTlZwUxFfvzVzxLvMYRxmXUlGzSI6YK1X04GTKpqkhRxkVWC5Xl7
         2ZPw==
X-Gm-Message-State: AOAM533AdaIDgevHJA8ioG7zFg0pcJX4ZpZjHEuJWOBB+3IjzDYQLa8d
        rWQBKKyiasZtDa5aN/xY8Mt8Xg==
X-Google-Smtp-Source: ABdhPJztxT8/JwToFdxyy+VpFZDnnFcGv3rSeV10jPNkhYPb2XbdgZ4Ib8t1Dfd+5cG7E3O7BCeHjA==
X-Received: by 2002:a5d:64af:0:b0:1df:3cb8:3f42 with SMTP id m15-20020a5d64af000000b001df3cb83f42mr18912558wrp.24.1645531204162;
        Tue, 22 Feb 2022 04:00:04 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.04.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 04:00:03 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 16/16] ASoC: codecs: msm8916-wcd-digital: fix tlv min max range
Date:   Tue, 22 Feb 2022 11:59:33 +0000
Message-Id: <20220222115933.9114-17-srinivas.kandagatla@linaro.org>
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

Fixes: ef8a4757a6db ("ASoC: msm8916-wcd-digital: Add sidetone support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index fcc10c8bc625..b32803bf6f63 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -554,21 +554,21 @@ static const struct snd_kcontrol_new msm8916_wcd_digital_snd_controls[] = {
 	WCD_IIR_FILTER_CTL("IIR2 Band4", IIR2, BAND4),
 	WCD_IIR_FILTER_CTL("IIR2 Band5", IIR2, BAND5),
 	SOC_SINGLE_SX_TLV("IIR1 INP1 Volume", LPASS_CDC_IIR1_GAIN_B1_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR1 INP2 Volume", LPASS_CDC_IIR1_GAIN_B2_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR1 INP3 Volume", LPASS_CDC_IIR1_GAIN_B3_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR1 INP4 Volume", LPASS_CDC_IIR1_GAIN_B4_CTL,
 			0,  -84,	40, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR2 INP1 Volume", LPASS_CDC_IIR2_GAIN_B1_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR2 INP2 Volume", LPASS_CDC_IIR2_GAIN_B2_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR2 INP3 Volume", LPASS_CDC_IIR2_GAIN_B3_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR2 INP4 Volume", LPASS_CDC_IIR2_GAIN_B4_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 
 };
 
-- 
2.21.0

