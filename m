Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722F34BF785
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiBVMAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiBVMAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:17 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEF0156C62
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:51 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id w13so10898466wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAYVw6f87nBCDJGUCPz374Y+GRm8ih0aIXd7jYiegYk=;
        b=CQqzgB9yPbuTyePAU9nroBloxL1ZgVMRzSIxuE5V8cp8RnsAAmLD/DG4Y/U4+52JtP
         l0i4vxh63W11kE4hkrTnjovKpOEVgEa1OuzczjQflVozla893MxHxmTRZ5RSpbgYPPpu
         WWWCPTDJC6Ah2yvXr1BXpsOLIK8iBQlC1cLaVJyOHRuFnvHI0iZWvmwHpjWP3WmThslC
         Az2U5BLZUkpfGspnqVwzfcBt+TqzwaTTQGEBq8/AjQs0gqSr+1LZOL29qIt0ZY/0QuqW
         Hb/khWTEL9bGjL6XLp9XcEClJHUQYc66qWhLG2pBq4leI/6VB9v52SoFzyqpLgYHk4tN
         oqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAYVw6f87nBCDJGUCPz374Y+GRm8ih0aIXd7jYiegYk=;
        b=gO4ZkWdkchCycicTi5QT3RzDoJoWIWAqlHwJTdIm6siqRM3PFm8NBDU9WeUkG192RL
         Q7TpIPh8TD8Rj3CRAsB634jGxRPfZegEXhQLo31m6v2/PxNKqSrtrmmfX2dJOvSbiVH7
         SCrXONqDK0IaLht0GRetDrR7M1hWkcSKFpChHq6oHG6JRcozxSQsgW0d9IdR2Cptl7d+
         MEezeaWApT7bJUtdYwoGI/IilFH6aEOOVsHMkyOTReLbqRWri8GyWHbeJyCq7rLf53in
         OYYN9M/Qfm1yxYYI4AA3ZpRYLPxBRTokHYrlkq1aOCewsQkiapW5aOHjaFIwdxkndLi2
         SOcg==
X-Gm-Message-State: AOAM532ecnVBS6u3O19PE3Xk+Qfo1noCe8ulZUusLT3wRe/LyvnUCOum
        tiHFnzzOpBtUORoVdDNaMezUiQ==
X-Google-Smtp-Source: ABdhPJwhpijOE/o2mCXCiE9KnjdyQ6TxkwxS7wznSwBFTO06MlhP+grm26A3hMPj6+GwbD3L+uTUQg==
X-Received: by 2002:a05:600c:3650:b0:37b:dd89:2f01 with SMTP id y16-20020a05600c365000b0037bdd892f01mr3086611wmq.43.1645531190597;
        Tue, 22 Feb 2022 03:59:50 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:59:50 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/16] ASoC: codecs: tx-macro: fix accessing array out of bounds for enum type
Date:   Tue, 22 Feb 2022 11:59:20 +0000
Message-Id: <20220222115933.9114-4-srinivas.kandagatla@linaro.org>
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

Also few return value of put functions, so that change notifications are
sent correctly.

Fixes: c39667ddcfc5 ("ASoC: codecs: lpass-tx-macro: add support for lpass tx macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 094756544eed..f90786100d1a 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -998,7 +998,7 @@ static int tx_macro_dec_mode_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
-	ucontrol->value.integer.value[0] = tx->dec_mode[path];
+	ucontrol->value.enumerated.item[0] = tx->dec_mode[path];
 
 	return 0;
 }
@@ -1007,14 +1007,14 @@ static int tx_macro_dec_mode_put(struct snd_kcontrol *kcontrol,
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
@@ -1037,7 +1037,7 @@ static int tx_macro_set_bcs(struct snd_kcontrol *kcontrol,
 
 	tx->bcs_enable = value;
 
-	return 0;
+	return 1;
 }
 
 static int tx_macro_hw_params(struct snd_pcm_substream *substream,
-- 
2.21.0

