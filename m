Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D454BF786
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiBVMAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiBVMAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:19 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273A5156C65
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:53 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so226009wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/RMewZRNdO9Wc+5bCNqy1Hhh9vonM3PUYPjxzgWe6c=;
        b=SanxqFiRWVCfz2tMk6aRuN8EEWVdZcWBZqQ/p98luZkdfvMRIOd/tTpvxbWWTEU53M
         +K2TVExVtW+/JyRFknezKVtcO5x12s/Yn17Y9baJmceusyiSFROq1sIowVFwhAXaQjre
         J/bQdVKvT3CfbuacjV/caOuz/9GQLYDwX4q3y4G4KTC7uVgy29Bt5TEv41mAKt1uV0bD
         bu8hEpEzxqK5v0nBIJfN3ilaTQ+3BGT49GMN7JYKt76nx3cJViR9l+yyEIWABmRTFw9e
         lHwVf1OhEGAGt+5qkdF0ggw+czKMt2L7rJZvogJtHTRbqr5DM8A0aPvizAnMNJi9TJxz
         ztEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/RMewZRNdO9Wc+5bCNqy1Hhh9vonM3PUYPjxzgWe6c=;
        b=GcA311oGPa5rDFWTSY63dKT4+5IVxpV4e8IjnrrRx7+pslaAt7bJqwlCTuppmp3qX0
         yWZtkUTHa5mQvIkc45K9Dsf/l+JRtUoJiyOu2MUw6gtXHTZS9FCC/at0HmvbSIFon3bu
         0VaKdugxbUHfyXoMd+G3oc9MEWECJHsA8/qtdqX5ceqG/fkYwqSFcb6JqyAhU7ebYUPi
         2gxkfwVL6yU5FLGLFabX/MCKL3tU9drGHVnikdZm1InJHQUN50MaR5hJMoPaG7vgnbZr
         5fLa+8Uq3qKORrFPPmueVM6u87ToqJ8wnag6oBWXTUpgegmhjPYLo2/VlUT+xZ4XErG3
         dWUA==
X-Gm-Message-State: AOAM5307RMboT52NMeyDxBTiIshKotJNkBEG/jy9YLlUXlZHjG1x3EYk
        Oe6F/nJyRZ1kcgkuNIkgxGS1oQ==
X-Google-Smtp-Source: ABdhPJxzgULSLUP2pqn4tukUw2n0gKmU+1hjzQ8HM08B5i+0uUMqJIsF0uL6zc5my2JKVFxfGP6fJQ==
X-Received: by 2002:a05:600c:354c:b0:380:dec4:10ac with SMTP id i12-20020a05600c354c00b00380dec410acmr1382242wmq.62.1645531191766;
        Tue, 22 Feb 2022 03:59:51 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:59:51 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/16] ASoC: codecs: va-macro: fix accessing array out of bounds for enum type
Date:   Tue, 22 Feb 2022 11:59:21 +0000
Message-Id: <20220222115933.9114-5-srinivas.kandagatla@linaro.org>
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

Accessing enums using integer would result in array out of bounds access
on platforms like aarch64 where sizeof(long) is 8 compared to enum size
which is 4 bytes.

Fixes: 908e6b1df26e ("ASoC: codecs: lpass-va-macro: Add support to VA Macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 803e4dca0538..0fd0139e8229 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -781,7 +781,7 @@ static int va_macro_dec_mode_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
-	ucontrol->value.integer.value[0] = va->dec_mode[path];
+	ucontrol->value.enumerated.item[0] = va->dec_mode[path];
 
 	return 0;
 }
@@ -790,7 +790,7 @@ static int va_macro_dec_mode_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 	struct va_macro *va = snd_soc_component_get_drvdata(comp);
-- 
2.21.0

