Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B8C5AF213
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiIFRNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiIFRMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:12:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE3F8B998
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:02:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c131-20020a1c3589000000b003a84b160addso9301923wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=o0P1+3onPALss8FANURKxZf2V/C5gu77caRyuTxUF1M=;
        b=CDZiTQMg7oOWT2r9wR7w87/5OMpP1or67RAL2mG41wRRa44pSsvbtsWh1JUCARAf/h
         Cpja7ZiJm4/KYQ+LNPbu31hQkZdp4qWuV1LaO6qw0LYvQ4V0pYj1Tm7ajDGOoK1lJBL/
         dPOzf7HSRYI3GOwQNDrvdUgRSPpcsUh2LrO8k9VYSAdjgSKyAnVvQs2FableUt/G2lCa
         R9/QXSxQB13nTQnTvYwAbFs4Hu+Cq/iNGfyOWqgeOMRUkUQ6u10Ek7br3zgz75HiRZxa
         5OvgLo7aryroEgQu/K3YWYYDJtgLXG99de+iwY0xzjfknL+dDOR4TnpMsnbKaGIEaDrJ
         VIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=o0P1+3onPALss8FANURKxZf2V/C5gu77caRyuTxUF1M=;
        b=0eQg3ZUlSTpx09vqGZ96nzaFx6V5nR/7V85jMQ5egfJ1BPGEjiS4BhkSGYKGeM5vjk
         VdIvKgMefxxq2sXoWQWE7abKbDskECosjcB57phg3Kv6q/UEFIPD8/DKJnky9/3mArov
         Hz8/x2f6Q54x+OD7bSRQ3GYZ2TkWW7Say+FnbAkf7ekHdIt/mUhn4Oxfuw1A41kRQUeY
         vgboIPR1FEde3yUcLAOuufkN1eDGQMrywp/UVEmx0+mtRIGOg+suPyCST/3610KrC83u
         thfZ17P1VVmYgbVu/+ED5L5CGqP64nimjfxAWM9lBD26Zs7Gw2ajrcJs153KZ2tIajw9
         yldA==
X-Gm-Message-State: ACgBeo1zBJCcm8apOcUf/0RuLU9PKmwR4c3D2YpCgkCdb9h3/DCpib3I
        xlx9ak3akgT69kjwz4YEjnqKuw==
X-Google-Smtp-Source: AA6agR6VpOzB0Itr+rg5xE7PPQuRZomvY8IgzkLTzCP1+j+vvOz+tkUL1ogAUVmyHNfkbseryXgsfQ==
X-Received: by 2002:a05:600c:1d89:b0:3a5:c1db:21c6 with SMTP id p9-20020a05600c1d8900b003a5c1db21c6mr13786582wms.174.1662483727802;
        Tue, 06 Sep 2022 10:02:07 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id x13-20020a1c7c0d000000b003a5ca627333sm21085967wmc.8.2022.09.06.10.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:02:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 01/12] ASoC: codecs: wsa-macro: handle swr_reset correctly
Date:   Tue,  6 Sep 2022 18:01:01 +0100
Message-Id: <20220906170112.1984-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220906170112.1984-1-srinivas.kandagatla@linaro.org>
References: <20220906170112.1984-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset soundwire block on frame sync generation clock reset.
Without this we are hitting read/write timeouts randomly during
runtime pm.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 27da6c6c3c5a..130d25b334ff 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -338,7 +338,6 @@ struct wsa_macro {
 	int ec_hq[WSA_MACRO_RX1 + 1];
 	u16 prim_int_users[WSA_MACRO_RX1 + 1];
 	u16 wsa_mclk_users;
-	bool reset_swr;
 	unsigned long active_ch_mask[WSA_MACRO_MAX_DAIS];
 	unsigned long active_ch_cnt[WSA_MACRO_MAX_DAIS];
 	int rx_port_value[WSA_MACRO_RX_MAX];
@@ -2271,23 +2270,16 @@ static int wsa_swrm_clock(struct wsa_macro *wsa, bool enable)
 		wsa_macro_mclk_enable(wsa, true);
 
 		/* reset swr ip */
-		if (wsa->reset_swr)
-			regmap_update_bits(regmap,
-					   CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
-					   CDC_WSA_SWR_RST_EN_MASK,
-					   CDC_WSA_SWR_RST_ENABLE);
+		regmap_update_bits(regmap, CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
+				   CDC_WSA_SWR_RST_EN_MASK, CDC_WSA_SWR_RST_ENABLE);
 
 		regmap_update_bits(regmap, CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
 				   CDC_WSA_SWR_CLK_EN_MASK,
 				   CDC_WSA_SWR_CLK_ENABLE);
 
 		/* Bring out of reset */
-		if (wsa->reset_swr)
-			regmap_update_bits(regmap,
-					   CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
-					   CDC_WSA_SWR_RST_EN_MASK,
-					   CDC_WSA_SWR_RST_DISABLE);
-		wsa->reset_swr = false;
+		regmap_update_bits(regmap, CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
+				   CDC_WSA_SWR_RST_EN_MASK, CDC_WSA_SWR_RST_DISABLE);
 	} else {
 		regmap_update_bits(regmap, CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
 				   CDC_WSA_SWR_CLK_EN_MASK, 0);
@@ -2431,7 +2423,6 @@ static int wsa_macro_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, wsa);
 
-	wsa->reset_swr = true;
 	wsa->dev = dev;
 
 	/* set MCLK and NPL rates */
-- 
2.21.0

