Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C8D5AF221
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbiIFRNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiIFRMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:12:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010B88D3E8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:02:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso7839387wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5cXkyzv8fGyxrlD42mVszMI8M5/gZNk4Pc54ztLL6XQ=;
        b=MIypjnmic7JjPeUDi5grO0kTunNZ+1CKPlsw8KWEfg2IsJdqr61ZK/XmyZkSV89YTD
         q2Li5pwWDDsZ39AUrVQ7wOOLn1tzukC55jQVmD32FhagZCr4eVR6et8HyZBOs0h5yd8c
         i25cTO43+vk3PPcwhIK5egBjLcVRsEi9ELgSF/00iauT3rfOXKI8sbYnWEA2pIeIMQQ+
         qtZVqcW5C9YL2w2CLsaenUap+8YHjPnwJVbAIWV5aWamc3OpQVDASzBvCRK9zKjYUiWv
         2YOaw6vx9BtpeaHnbHgVjcJzepS+nmFPuf3dxzaEqhY7z4cs8sM7es3eg2LcmSlxIXaC
         78Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5cXkyzv8fGyxrlD42mVszMI8M5/gZNk4Pc54ztLL6XQ=;
        b=lzX7xoMRyxBfyxirkCqFQFFezUOuh4xGAQByJOp7+O0gUXOTNDJ8+WXA2LiP6flW6L
         20qYhind50fufoZdZkWPk3KLxq6Yn3nXIZ6PQWd4nUihRKEIQPA3jVWHXdWqP/CHhUKV
         j1A9GEqyyWMJJ8eLzFMcXScvy0FlojYXl9gjZ1I6u/A1S802mk6BBLlcS0fgRwi8hcxu
         nCzLsL2vISCRpUIK2RD32zz4mFVkOeDMyVhUoVbETlLPK1YtgYN6I5tfWinKHhVvdQDK
         I4goi3HftlgIb7CeiWd+OElwjcyi1lSswfo1q+gdb2F+xKFRtEgO2R05xqh6tr4RgFV+
         GPrg==
X-Gm-Message-State: ACgBeo0S7seXXXO7hOnWJG/RCm7Qllj3itQCoYTdB9vwMFe89wbRtOg4
        Nhj/Q0Rd/vWLHVZBOa3iw5t06A==
X-Google-Smtp-Source: AA6agR4oCi3/Szpkd6bJCLAvjnsfXNZbwqML0O3tyhV9OOOUyXpqw2CscuFoHZJy6PtC8wG+yAnuNg==
X-Received: by 2002:a05:600c:3d05:b0:3a5:dd21:e201 with SMTP id bh5-20020a05600c3d0500b003a5dd21e201mr14384871wmb.132.1662483732330;
        Tue, 06 Sep 2022 10:02:12 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id x13-20020a1c7c0d000000b003a5ca627333sm21085967wmc.8.2022.09.06.10.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:02:11 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 05/12] ASoC: codecs: tx-macro: fix kcontrol put
Date:   Tue,  6 Sep 2022 18:01:05 +0100
Message-Id: <20220906170112.1984-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220906170112.1984-1-srinivas.kandagatla@linaro.org>
References: <20220906170112.1984-1-srinivas.kandagatla@linaro.org>
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

tx_macro_tx_mixer_put() and tx_macro_dec_mode_put() currently returns zero
eventhough it changes the value.
Fix this, so that change notifications are sent correctly.

Fixes: d207bdea0ca9 ("ASoC: codecs: lpass-tx-macro: add dapm widgets and route")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 5c03ef8d88b3..7f9370ed126f 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -822,17 +822,23 @@ static int tx_macro_tx_mixer_put(struct snd_kcontrol *kcontrol,
 	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
 
 	if (enable) {
+		if (tx->active_decimator[dai_id] == dec_id)
+			return 0;
+
 		set_bit(dec_id, &tx->active_ch_mask[dai_id]);
 		tx->active_ch_cnt[dai_id]++;
 		tx->active_decimator[dai_id] = dec_id;
 	} else {
+		if (tx->active_decimator[dai_id] == -1)
+			return 0;
+
 		tx->active_ch_cnt[dai_id]--;
 		clear_bit(dec_id, &tx->active_ch_mask[dai_id]);
 		tx->active_decimator[dai_id] = -1;
 	}
 	snd_soc_dapm_mixer_update_power(widget->dapm, kcontrol, enable, update);
 
-	return 0;
+	return 1;
 }
 
 static int tx_macro_enable_dec(struct snd_soc_dapm_widget *w,
@@ -1018,9 +1024,12 @@ static int tx_macro_dec_mode_put(struct snd_kcontrol *kcontrol,
 	int path = e->shift_l;
 	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
 
+	if (tx->dec_mode[path] == value)
+		return 0;
+
 	tx->dec_mode[path] = value;
 
-	return 0;
+	return 1;
 }
 
 static int tx_macro_get_bcs(struct snd_kcontrol *kcontrol,
-- 
2.21.0

