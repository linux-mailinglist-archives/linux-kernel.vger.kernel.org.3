Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8E94C015D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiBVSc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbiBVScz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:32:55 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A826A12771
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f17so10241412wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7JyAd12ezNQnJ94i2wAgEHL19WtPs4b74x+OoJQPCY=;
        b=ZRF1c5KWu1lErY1nstOF8ndQJAhL3OMRzAu+M+DBn6wQu90FPCZWvWArtKYbBI9B0E
         I9/pQfiglr4/04Zc6rU58HkkAo8k2CAHxvLG3M7gJFbSYpsPBZqq8MhU64bN/TtC60zB
         7hDOi/CpZ4Ly278O2Z52mKbNDsbfwRfC1UZBWKNODDtc137sj8SPqBUDrNwtmP+blOVM
         BwBvwyWUjb7CaHr8BDgGLLxl68nVIGtrql+Qq/pmvl2glAxpEyUgYyvicuJtDQoOfHQn
         ixAuwvAK05NI100h0h8VNDjEzDknibdb/0M4l5h/x0awufU0zXh+JP1GB4acjrVOkwQC
         zHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7JyAd12ezNQnJ94i2wAgEHL19WtPs4b74x+OoJQPCY=;
        b=lFIw83yjS67SphT4SGtzI7v40rCHXEDBe3M6QQfWKPydDT9AVFe00iW3fwSH4jExZi
         XFQmD90xbZTm65C3MRwoiDOM/EbJjzyzUx1Nm2GbGcEbVkY7wS/UvVkbkn2zj4YTlGlo
         GmannAWkGgUx0870taI4tN0CoG54igPq5yIAnDucDJOmha9tIK8AOE/8vgNgJY4opeiD
         4dw6mzSQfoa3WvVLvPzFBjmFmuWkvaRFtiaDtuZ7zE82UCrASj/yxG7a22YM/GBR3b5s
         owSTuNW0NksUfBNQowhwHV1EBCZbn4MmJ99nZAgL83m87D6nsf/pP5JhqovYnhBFrq5/
         0kZw==
X-Gm-Message-State: AOAM531I+Xv+lZupOgUq4vh1ttJp9kH25h4VwdzkhyPUuPr1qCd3h46a
        VIWFNY1MBbMjjXlr1v0GPY6oXQ==
X-Google-Smtp-Source: ABdhPJzzZEScQ57B6/CcC6Fpa02neArlpb11/SFHUaZIBQjmk3T7P1DGV5DjJkeXijhoqkp+6cQtVw==
X-Received: by 2002:a05:6000:104f:b0:1e4:b53a:85d9 with SMTP id c15-20020a056000104f00b001e4b53a85d9mr20384283wrx.594.1645554748244;
        Tue, 22 Feb 2022 10:32:28 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id l28sm57642165wrz.90.2022.02.22.10.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:32:27 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/9] ASoC: codecs: rx-macro: fix accessing array out of bounds for enum type
Date:   Tue, 22 Feb 2022 18:32:05 +0000
Message-Id: <20220222183212.11580-3-srinivas.kandagatla@linaro.org>
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

Fixes: 4f692926f562 ("ASoC: codecs: lpass-rx-macro: add dapm widgets and route")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 32e85d2e9b90..3a3dc0539d92 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2272,7 +2272,7 @@ static int rx_macro_mux_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(widget->dapm);
 	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] =
+	ucontrol->value.enumerated.item[0] =
 			rx->rx_port_value[widget->shift];
 	return 0;
 }
@@ -2284,7 +2284,7 @@ static int rx_macro_mux_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(widget->dapm);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct snd_soc_dapm_update *update = NULL;
-	u32 rx_port_value = ucontrol->value.integer.value[0];
+	u32 rx_port_value = ucontrol->value.enumerated.item[0];
 	u32 aif_rst;
 	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
 
@@ -2396,7 +2396,7 @@ static int rx_macro_get_hph_pwr_mode(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] = rx->hph_pwr_mode;
+	ucontrol->value.enumerated.item[0] = rx->hph_pwr_mode;
 	return 0;
 }
 
@@ -2406,7 +2406,7 @@ static int rx_macro_put_hph_pwr_mode(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
 
-	rx->hph_pwr_mode = ucontrol->value.integer.value[0];
+	rx->hph_pwr_mode = ucontrol->value.enumerated.item[0];
 	return 0;
 }
 
-- 
2.21.0

