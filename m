Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6061A4C015F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiBVSdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiBVSc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:32:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21CDCFB94
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d17so241027wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QZz8ASXss+gfpOAKkDwr+gWAwAdXQYtNmwvaBY30o0=;
        b=PUVWweJs2/2O32Gy46OrYrDIIpF+i7Om8rp92BVlIoi95NIXn7DzXPWS1FCmqdRmJ9
         Fq11XK6G3DlSILHq7jq67p6QqaohcX3UDv2bm2LINSWHyZ10UaVCmGixyryIblgZgdbo
         ahZ83ghJDir0lwMemh0wyNjXy4K4vMxd//ito95JwUZBtSFcYoJxLgIStaqu5inIVQc8
         ad/75IsjnGZ6/OaHYcS3j4h2TDZoOocwvqGuuxRyWs8S19+b+PPlC/88JbAGzZD4BtbE
         GfvAbJBVjGvdLnbqOPlHEZIBdl8/tdHNwqGJCM5ADUKprNSFGQfYPIfaS/5akfHq5gRc
         9sRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QZz8ASXss+gfpOAKkDwr+gWAwAdXQYtNmwvaBY30o0=;
        b=foUIC0YD5jDXdDJ6AtspEPi7O1Dmbfz9abLzdzCqezsKjCyxu4NS4lI+3cjcPbig3q
         SeoLIypQGIv9tKUk6hN7jVtBhW0TiTomK60sajepkRYXhwfqsTY6oJa0xgxMewuP762z
         qZGqdfTz6hsfXk5g6d2l5wYZrHpVtWjjOTHFzujaKFJ83q9eloD+YXpBlIIq/Eq9X3lZ
         exfJW+RNmlXrmmMn+CJrtp1KpR+iWTcyG+tFFX/tdXAfb3WyQ2fq9MlrSmlhi+C7X77I
         E6GGzBBQVbbNJ4njFOtUqWiERzqJn+UcXunjrLWtR9hdo9vsJj68D8HzH+dF2a5UbxQ2
         EYNg==
X-Gm-Message-State: AOAM530J9YF2+AZlh6tv4Iz3N9l5lbXxJvmdkmaBJJLFNQwSdBmjqfQA
        CQs/pLVSRK21ky/yxiiqtfjVWA9h5f59Ug==
X-Google-Smtp-Source: ABdhPJyxTDVpwUPAosm4aHtqCWhd+dyKFZGHxVAsLjrwCuLfN5Ne4PJ6ODBR/1iomV5X/XXdO5Vq/A==
X-Received: by 2002:a5d:46d2:0:b0:1e4:a653:e010 with SMTP id g18-20020a5d46d2000000b001e4a653e010mr21743448wrs.77.1645554750328;
        Tue, 22 Feb 2022 10:32:30 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id l28sm57642165wrz.90.2022.02.22.10.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:32:29 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/9] ASoC: codecs: va-macro: fix accessing array out of bounds for enum type
Date:   Tue, 22 Feb 2022 18:32:07 +0000
Message-Id: <20220222183212.11580-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
References: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
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
index 11147e35689b..e14c277e6a8b 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -780,7 +780,7 @@ static int va_macro_dec_mode_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
-	ucontrol->value.integer.value[0] = va->dec_mode[path];
+	ucontrol->value.enumerated.item[0] = va->dec_mode[path];
 
 	return 0;
 }
@@ -789,7 +789,7 @@ static int va_macro_dec_mode_put(struct snd_kcontrol *kcontrol,
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

