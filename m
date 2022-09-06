Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5774F5AF217
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiIFRNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiIFRMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:12:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF558B9B0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:02:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b5so16416272wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=re8Z9fw7pUFDwz5t2E+fC5AN4inVQugZHn4dMfClz40=;
        b=yPFdT/Zllm622SFwnkd64Ui2kruuNrAfFuqcDOrHweA+yvDdrO39YO1EiQwIMDl2ih
         +8LV+TVZGQpbIM0+Va+NdxuOjMhbwnbB0/G7NX42DzUyBMKkhqmiHy5OTDomv1eV1kQp
         HfVYjRS3sJZdolJi10Ql4H0YLkjFEda9kpIis7EiRFCb4jicKJFR6tDTgPrH5hZ/82PS
         FShSosLeXqjdER4vZn4DBlyBXJT4TYSbdVLXgbnfgiCd+KKxH6Z0+8mgjIh7RE1KmuET
         Hf4o4y5jR0nwAFT74MXs/dGBv2ZdtEe9fdaP/o4+CNuhCG52X6JZd19oodsuu3NDJgBV
         kyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=re8Z9fw7pUFDwz5t2E+fC5AN4inVQugZHn4dMfClz40=;
        b=IsQlk748t9femlczmZy1G+3G2TJXgHuKxmkBfaJjCae6DL+KR5Dd3F6uoU3gCMlPT2
         ykK0wM3vVlo/sVWp6jUpP2od0Xex+U4rQW3BFAFYl1Fa9jac+PPW3gYPQ5QQJOeZVqSC
         6UiGJ+oAUaYBPp4xoNwP6vX9y/NR0u1m7Gg0PFJWmDxQUVb8mBsU1umG3vys2JNVIMHd
         jvyO11GsMQ4xbzoJO1VTOitygWvaEPDPpaej5wCiKeB1BRq12APz9QwKN0SMcZQttDfH
         2V3AHa03A2A3vcWQA3x6YWKdijDV8hDeYOQWLXzsWCAwooDeRFbg/1DfN0NvajrEOSSz
         JeSQ==
X-Gm-Message-State: ACgBeo2+yOuR7gtQHrtNZVIEk6M348H0JD5yb1ybmfVy+59/ZRhDjeGF
        dTAt3d87WwjYt2zD8r5o+eo+dg==
X-Google-Smtp-Source: AA6agR7zOZdnFhN2Lm6iYdOfoyXNKZSoQYHgG/WRNO3Em3C+1SiStwXoopbjwQyOCd8Gq4bllb3zYQ==
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id i15-20020a5d522f000000b00228dc7fb9a8mr1500645wra.617.1662483729998;
        Tue, 06 Sep 2022 10:02:09 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id x13-20020a1c7c0d000000b003a5ca627333sm21085967wmc.8.2022.09.06.10.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:02:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 03/12] ASoC: codecs: tx-macro: handle swr_reset correctly
Date:   Tue,  6 Sep 2022 18:01:03 +0100
Message-Id: <20220906170112.1984-4-srinivas.kandagatla@linaro.org>
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
runtime pm. Along with this remove a swr_reset redundant flag.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 55503ba480bb..c19bb19b717b 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -268,7 +268,6 @@ struct tx_macro {
 	struct clk *fsgen;
 	struct clk_hw hw;
 	bool dec_active[NUM_DECIMATORS];
-	bool reset_swr;
 	int tx_mclk_users;
 	u16 dmic_clk_div;
 	bool bcs_enable;
@@ -1702,18 +1701,14 @@ static int swclk_gate_enable(struct clk_hw *hw)
 	}
 
 	tx_macro_mclk_enable(tx, true);
-	if (tx->reset_swr)
-		regmap_update_bits(regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
-				   CDC_TX_SWR_RESET_MASK,
-				   CDC_TX_SWR_RESET_ENABLE);
+	regmap_update_bits(regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
+			   CDC_TX_SWR_RESET_MASK, CDC_TX_SWR_RESET_ENABLE);
 
 	regmap_update_bits(regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
 			   CDC_TX_SWR_CLK_EN_MASK,
 			   CDC_TX_SWR_CLK_ENABLE);
-	if (tx->reset_swr)
-		regmap_update_bits(regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
-				   CDC_TX_SWR_RESET_MASK, 0x0);
-	tx->reset_swr = false;
+	regmap_update_bits(regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
+			   CDC_TX_SWR_RESET_MASK, 0x0);
 
 	return 0;
 }
@@ -1855,7 +1850,6 @@ static int tx_macro_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, tx);
 
-	tx->reset_swr = true;
 	tx->dev = dev;
 
 	/* set MCLK and NPL rates */
@@ -1970,7 +1964,6 @@ static int __maybe_unused tx_macro_runtime_resume(struct device *dev)
 
 	regcache_cache_only(tx->regmap, false);
 	regcache_sync(tx->regmap);
-	tx->reset_swr = true;
 
 	return 0;
 err_fsgen:
-- 
2.21.0

