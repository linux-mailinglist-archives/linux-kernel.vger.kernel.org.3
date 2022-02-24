Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CDE4C2AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiBXLSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiBXLSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:18:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC2E16C4F6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:32 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b5so1475628wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8veggn84WTDPG1EzzuuowEnBUzJbPrvW+5/W0Ult+cg=;
        b=NpUHOi8Obu4FUugi29GayDY/BGYAT6n6DPvbj68hPa0y/lkD0LmhRybNRPTyKjS6I4
         kCob7oaYOr8zNOk/y+b40DUFGtMqAnRgPFPJYH3G88zh13zD9zvNvMCMxkUyV+/8FTbm
         aefSjdGmOZJR23tmid51Uz5YoY9kGuuxrnlGstgnLQJuxTGyn6v4rQQhwQQa1PVaIctv
         pMbq6bsZoC5/hzxTmYykE7F4B/9l5qpqy+WOv/JLEngGa/b3UNpZrrOjYkBXA5ShN2bh
         5pj/6ZdLV4CxYkv2X8Q7ray6R+WYyNJ2FdUTp2r0xeKlkR1qTfEjNzbXtt5YEcLzg6Rs
         cVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8veggn84WTDPG1EzzuuowEnBUzJbPrvW+5/W0Ult+cg=;
        b=g9GbpOI5jYKy9lOHhhnsjbXPd+exeowVT6q8a6NINuSkIuePcxH9+d60b39rkyQJHJ
         Jl3MRAea5tiLC9dyWX6dfAxUsIG7cSN7onuk0gdYwdoq4RMV/n8HeG5FdMyZlaQa4S55
         eswODyKEsLPyNFfPE0+0Nj3MFnUWzIsnAk6LsyhKU77HD1V8Ya9ghP2N19/rrsjkAKNN
         YtIE84sIqqFiB6K5V7s4SNNKMc54URL7XlUctO7fB8Y0HO+YpKwpCowtbZDet3rBFLUQ
         tt0Hi5Bbhdw9MUqY2pGgv5/++D/yqMpvBk0ccgvD9sEyEUsnEK68vUk8nBwhjsM7/YwI
         ESMA==
X-Gm-Message-State: AOAM5324JBFFCfUXkqT3iSqQAmfgrshlvdCEpA4otDD9UBYglkc1GWyt
        5HxeH34RykZIemTRh/e3Fg+rLg==
X-Google-Smtp-Source: ABdhPJxKj97YqBBS+rvtIhUx243DLI4rxm9/PBcoPfDt8qdKLDowWWEZ8Pr+d5o7uGgTXgoB2rLhhQ==
X-Received: by 2002:a05:6000:2c4:b0:1ea:910c:151c with SMTP id o4-20020a05600002c400b001ea910c151cmr1797216wry.92.1645701451345;
        Thu, 24 Feb 2022 03:17:31 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:30 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 08/16] ASoC: codecs: tx-macro: setup soundwire clks correctly
Date:   Thu, 24 Feb 2022 11:17:10 +0000
Message-Id: <20220224111718.6264-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220224111718.6264-1-srinivas.kandagatla@linaro.org>
References: <20220224111718.6264-1-srinivas.kandagatla@linaro.org>
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

For SoundWire Frame sync to be generated correctly we need both MCLK
and MCLKx2 (npl). Without pm runtime enabled these two clocks will remain on,
however after adding pm runtime support its possible that NPl clock could be
turned off even when SoundWire controller is active.

Fix this by enabling mclk and npl clk when SoundWire clks are enabled.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 920b6e93fbaa..b32235a9e1e5 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1696,6 +1696,13 @@ static int swclk_gate_enable(struct clk_hw *hw)
 {
 	struct tx_macro *tx = to_tx_macro(hw);
 	struct regmap *regmap = tx->regmap;
+	int ret;
+
+	ret = clk_prepare_enable(tx->mclk);
+	if (ret) {
+		dev_err(tx->dev, "failed to enable mclk\n");
+		return ret;
+	}
 
 	tx_macro_mclk_enable(tx, true);
 	if (tx->reset_swr)
@@ -1723,6 +1730,7 @@ static void swclk_gate_disable(struct clk_hw *hw)
 			   CDC_TX_SWR_CLK_EN_MASK, 0x0);
 
 	tx_macro_mclk_enable(tx, false);
+	clk_disable_unprepare(tx->mclk);
 }
 
 static int swclk_gate_is_enabled(struct clk_hw *hw)
@@ -1759,7 +1767,7 @@ static int tx_macro_register_mclk_output(struct tx_macro *tx)
 	struct clk_init_data init;
 	int ret;
 
-	parent_clk_name = __clk_get_name(tx->mclk);
+	parent_clk_name = __clk_get_name(tx->npl);
 
 	init.name = clk_name;
 	init.ops = &swclk_gate_ops;
-- 
2.21.0

