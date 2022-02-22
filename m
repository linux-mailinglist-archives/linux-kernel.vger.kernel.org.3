Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DD84C0164
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiBVSdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiBVSc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:32:56 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE195E16A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p14-20020a05600c1d8e00b0037f881182a8so2633795wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUoqmx1Ywbc+tqd2GvIO663zQffqPunv+0z/Zs4V7Gs=;
        b=aSdNImbOjNhtLdxQBITj50ZagnfribzgmqnjcSU+5VA32tXHznQ0f6KsVc3i7B84L3
         BXF0c5YRa4/QvyygttsC+cm5BfIU77kwq2VedJCBG/Qg3Sd1FGo0KA3TC3MHUk7vrXpV
         LxuvL3T2Y+d1LOY39dDWjAXponQL8x4ALTe6Rqob/m7c9zySZ2t5L5KOroeH3WmHKeyw
         CEFCjPKHrVkmEs8SvqRMycmIdYwQWhrcmgFRc6vd9Py+OI5SXqo4AeaIdzSUP2YbOG29
         U95yQXtC2fxWPEehrUNhUek5TA06g+qGzT0sS/vZltX8QdDU9pD9ZridBAJN0Aww2v2B
         BZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUoqmx1Ywbc+tqd2GvIO663zQffqPunv+0z/Zs4V7Gs=;
        b=ZNTwi9I7W+u8t0a8M9K+AERWH0gwW1t7AvtlZr8tEuIopcsf+aRsIzB6li4ZsGpxgF
         scEjeHdnbO0MKDcSw5ls6wV6onrKxuwdjoyjz6l55jwrLaTCQ3yGU2Hcz8QZjCad+qjZ
         FFC8oJAKKUo9uhUO3GicRa2LTPfRwjTbB97XNBc6hH55wpeoO/qoZIoZBc2TnbjioOlA
         2WPsfKlfYRNRPyEmsMlpzWusW/Cj+3Zh1mJF6xYO1EQVUl4V13O3drXIZ6fBU7DxEMTQ
         jnXmIA7VaZVvC8cwcDfItVfvmWF6W30JaK1QI5TmUqcjUO0QjGlubppll+tWkJgkGLPz
         VPew==
X-Gm-Message-State: AOAM530PLAuXxh4ldLDe+/pzZ3hbcA/k9azHedEmHe6/N4kZ4FhFQ05f
        QkR7DAwJ+Utht8YbJCAJuXBi4Q==
X-Google-Smtp-Source: ABdhPJxBe9KWmKY4uNCJTcsJ69pn0Df4nH0t+gILLI62HOXElU6N4yV8HIXFDDF5ISzjRAHqXemhAg==
X-Received: by 2002:a05:600c:290:b0:37f:a999:e9a6 with SMTP id 16-20020a05600c029000b0037fa999e9a6mr4286281wmk.9.1645554749357;
        Tue, 22 Feb 2022 10:32:29 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id l28sm57642165wrz.90.2022.02.22.10.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:32:28 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/9] ASoC: codecs: tx-macro: fix accessing array out of bounds for enum type
Date:   Tue, 22 Feb 2022 18:32:06 +0000
Message-Id: <20220222183212.11580-4-srinivas.kandagatla@linaro.org>
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

Also few return value of put functions, so that change notifications are
sent correctly.

Fixes: c39667ddcfc5 ("ASoC: codecs: lpass-tx-macro: add support for lpass tx macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 9c96ab1bf84f..7347d79a6329 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -997,7 +997,7 @@ static int tx_macro_dec_mode_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
-	ucontrol->value.integer.value[0] = tx->dec_mode[path];
+	ucontrol->value.enumerated.item[0] = tx->dec_mode[path];
 
 	return 0;
 }
@@ -1006,14 +1006,14 @@ static int tx_macro_dec_mode_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
 
 	tx->dec_mode[path] = value;
 
-	return 0;
+	return 1;
 }
 
 static int tx_macro_get_bcs(struct snd_kcontrol *kcontrol,
@@ -1036,7 +1036,7 @@ static int tx_macro_set_bcs(struct snd_kcontrol *kcontrol,
 
 	tx->bcs_enable = value;
 
-	return 0;
+	return 1;
 }
 
 static int tx_macro_hw_params(struct snd_pcm_substream *substream,
-- 
2.21.0

