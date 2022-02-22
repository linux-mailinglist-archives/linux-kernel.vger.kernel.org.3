Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30784C0165
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiBVSdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiBVSc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:32:58 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE913B3E6B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:32 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p9so35078032wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pJUEubD8UMpBZteKL+cVLlZyMNg5UU9numn2ZyAs5ps=;
        b=JIVjPZX+CZlzxYoovRe150vIu193GQdJn3n2+d7YaMqvZ/CXwAuZeTFikwrq+ift7s
         AyVTcP32EyjgeoVodaWS80wh2q2Eu54pK39w38+RhTpjZeHKrmPJgzQhdQz9YBTtvjL1
         lZfA2hE9/bzt2t3Zm0dNv1HErSSOqo81KE7b1/lSvO0X8dFvUCWic5udoXaGJpKd+aW3
         CYt8IoPnu6grnaBZy6HgevnnFgPArT3kqa/tueutiQbPjcOd0n1T0ZX5QcZCYkSgbaGz
         8NACenIIFGmqY/78XG5z37ShvtUBVc2KY6gSR6Pqa+x5ri8zwhYU9fqGFVdfOtNkvmLD
         JipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJUEubD8UMpBZteKL+cVLlZyMNg5UU9numn2ZyAs5ps=;
        b=7Krbwf4Wl/ACakOrWQ/diNLg/44MyhMJZd/DrLKs7q0Y1q/64ZF3vJGK8egdtTvah9
         lOBNy7GjavBgXEjbGZUxTXyAPKzhQgkIxxy02j92snbkR72PcT0X5rHhpV6doo/wMlYT
         hf7mQCNF1S8M3SXfo6cKn4Vj8ZGpYAZfG32cBEi82PEs2deoqtc14sa8uNYZD2l8xwhh
         VI6Lnq+iaY0ZmNtI3Q80nO8PvSYPN09STmOR1I54AYyS5MfKVY3Qcl5z9Obj6hUq8mLM
         2cltsOCN7JTXJKlz4SdycYP/C2LcHup84gjYveZuyddriLdU7c16M5gC1h1R0nkYaeQm
         wUMQ==
X-Gm-Message-State: AOAM531O3sw0TtTlxIgLizev9HNizvOrzIle7sIJn4ahCi09v+UM6tTP
        VHiInE2tfULJPB0Zq+fqRNUcgw==
X-Google-Smtp-Source: ABdhPJzMsf+fs7MdsLfjKZHb5fhJT1XI6B8Km4xMkkbBk+s0Mqk9MZGbT93a2y+fvAq7lAINJUKLvw==
X-Received: by 2002:adf:ec03:0:b0:1e4:98f6:2563 with SMTP id x3-20020adfec03000000b001e498f62563mr20446293wrn.168.1645554751362;
        Tue, 22 Feb 2022 10:32:31 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id l28sm57642165wrz.90.2022.02.22.10.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:32:30 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 5/9] ASoC: codecs: wsa-macro: fix accessing array out of bounds for enum type
Date:   Tue, 22 Feb 2022 18:32:08 +0000
Message-Id: <20220222183212.11580-6-srinivas.kandagatla@linaro.org>
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

Also fix return value of put function, so that change notifications are
sent correctly.

Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 69d2915f40d8..ddde17e2dc35 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1805,7 +1805,7 @@ static int wsa_macro_ear_spkr_pa_gain_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] = wsa->ear_spkr_gain;
+	ucontrol->value.enumerated.item[0] = wsa->ear_spkr_gain;
 
 	return 0;
 }
@@ -1816,7 +1816,7 @@ static int wsa_macro_ear_spkr_pa_gain_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	wsa->ear_spkr_gain =  ucontrol->value.integer.value[0];
+	wsa->ear_spkr_gain =  ucontrol->value.enumerated.item[0];
 
 	return 0;
 }
@@ -1830,7 +1830,7 @@ static int wsa_macro_rx_mux_get(struct snd_kcontrol *kcontrol,
 				snd_soc_dapm_to_component(widget->dapm);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] =
+	ucontrol->value.enumerated.item[0] =
 			wsa->rx_port_value[widget->shift];
 	return 0;
 }
@@ -1844,7 +1844,7 @@ static int wsa_macro_rx_mux_put(struct snd_kcontrol *kcontrol,
 				snd_soc_dapm_to_component(widget->dapm);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct snd_soc_dapm_update *update = NULL;
-	u32 rx_port_value = ucontrol->value.integer.value[0];
+	u32 rx_port_value = ucontrol->value.enumerated.item[0];
 	u32 bit_input;
 	u32 aif_rst;
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
@@ -1887,7 +1887,7 @@ static int wsa_macro_rx_mux_put(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_mux_update_power(widget->dapm, kcontrol,
 					rx_port_value, e, update);
-	return 0;
+	return 1;
 }
 
 static int wsa_macro_soft_clip_enable_get(struct snd_kcontrol *kcontrol,
-- 
2.21.0

