Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E444BF790
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiBVMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiBVMAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BD1156C6F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:00:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id w13so10898935wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/v7fSBOaCbI8QU+K0IcaQnfo96v3GrLJ30LztRsyJ5g=;
        b=MNCET+QlGmQPanpZT4PW8Xckp97SRYGXNmqWF8PHeTF+q/fMJ3EjRHoltz4BANS63a
         36raoLXF48uS0eRqLHydIP69Jeoa5vGquoluLa1pPQkVH8UY6SiqEj0/LbslxpX+quXv
         VCBj+sTZA67FDJB4xmxwNRb2RKexFd9R0R4sSK2j+3hcYa6fYB7CYb7wxIHQX6xHSYRc
         G6xj9c97QI6G0+ZFzjuQ4f6COeQTWLSsMRQ/wLryyDvZiTnoE6b089OWuadmMpY6v59O
         yYtu5KrrKShNzIjtz02d1CXu8XYmSIeAbv5MpcB+FEesO4T4/6kFgBNfDejyWTOMu56m
         ZjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/v7fSBOaCbI8QU+K0IcaQnfo96v3GrLJ30LztRsyJ5g=;
        b=UarUzuxHTLI/V6QotXMXS6E91bJXY0kn18gYRX0ftVMmA676O/65gfAtDHQlQ+j7jp
         wTdN8LNVb7osvPLsbRbhaIlVtxILnpG6PhqrYlJz0r0bHY9JNMSG1Ec5fdFddqAKolFp
         EHi/qa9bMIREIzLl5iswibNEaXzloxwss+Yp6YZMNj7vQLsXngtGyYWOWlzQS5OCmCV9
         6pLvOX+hh4rQB529htWwbjmLLCSOHVEStJt7mauT3jg1S29oSPdxVRjDVS6tv/yR0/r/
         FXYYOk35Ct153nWaR0Z3/So4CogTs1KrPcG/+UxGn4D4JmGKXPiy5Jplx+xrFfki53o1
         LHUw==
X-Gm-Message-State: AOAM532fgWQdlyaR+jzN6VbukiTTem1juHl/LOinMFKlCLUV8pPM81B5
        jyVGo5/ly4WND2tdpXzIte/oww==
X-Google-Smtp-Source: ABdhPJxm5KxVyTSngzgUaBGqqhFnBKRzEk5moazJ/aSxsnm0IlLurKgepYu3YSWeNUtxyAZEFPtoMw==
X-Received: by 2002:a1c:5451:0:b0:37c:71d:5c40 with SMTP id p17-20020a1c5451000000b0037c071d5c40mr3092013wmi.1.1645531199996;
        Tue, 22 Feb 2022 03:59:59 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:59:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 12/16] ASoC: codecs: va-macro: fix tlv min max range
Date:   Tue, 22 Feb 2022 11:59:29 +0000
Message-Id: <20220222115933.9114-13-srinivas.kandagatla@linaro.org>
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

Fixes: 908e6b1df26e ("ASoC: codecs: lpass-va-macro: Add support to VA Macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 0fd0139e8229..555675690166 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1256,13 +1256,13 @@ static const struct soc_enum dec_mode_mux_enum[] = {
 
 static const struct snd_kcontrol_new va_macro_snd_controls[] = {
 	SOC_SINGLE_S8_TLV("VA_DEC0 Volume", CDC_VA_TX0_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("VA_DEC1 Volume", CDC_VA_TX1_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("VA_DEC2 Volume", CDC_VA_TX2_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("VA_DEC3 Volume", CDC_VA_TX3_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 
 	SOC_ENUM_EXT("VA_DEC0 MODE", dec_mode_mux_enum[0],
 		     va_macro_dec_mode_get, va_macro_dec_mode_put),
-- 
2.21.0

