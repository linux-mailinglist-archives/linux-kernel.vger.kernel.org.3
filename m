Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101C24C2AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiBXLSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbiBXLSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:18:03 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D547915A23A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:33 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id p9so2411489wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zE6/nZIDlJdrpc8fSPwZfEWaQMFLh+eWf0SbooVP2Cs=;
        b=y0wC2iSaTfuMnX+xZjLGomf6N3YABPJaIUbLdMN9PI7FX2tlh9OC9gex041qeCWkbE
         tkveBABwMnZVwGABeOznGoCqZv58ce7PD3oaDmsf9SX3QmE2it0VbRyMxID1sCLM7YSF
         PenArZceaij7jQy2DdwKAaQGbPqplbjWiSQb5QzQ/x4CERjEaG1TSzJn5dsJohZT11rv
         sgcZtn1mTdI3gUFuUJSUlGusNXqjl456Nnc1iRA5iq7AzR1cnxCh7pkjFue/Yj4A/Ux6
         Kfk7OxE0R/ReiW34BRYX4Uds99Sn7KSPy1ZA5EKxGk9/IyDAxwG4O7JJfGypS8JMTLw+
         tLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zE6/nZIDlJdrpc8fSPwZfEWaQMFLh+eWf0SbooVP2Cs=;
        b=MQ5m9Nc5b1OUYG8jFeYt0pIvoJaSxY8iQcLApLwNbER+Np/68ytn6tYZCZy8OmUo9L
         xG2WxSxMN6haSLohFojymjPiEbm5mtSMyYvN8WGcsXoibEZLviYOXBGvYaU9LfA7yDk4
         MWwxVrWXMGvX0pcpaWtDYTdMej4lukN8KGVFCXaArUQVy6yDn/mElfHasj19Wsj5/4Hr
         UgUQyYSEs9D5vwZh/OZERMwILhvagZntPCCw/Me+Y4V6b1HwNIEzTxy9km1a3HKKIPeo
         9DXb16wIFUoM8BRYHxls4mpIbpDYLWt1GdXcJZocnN3tJAC3n9kCs9hlZ99b9JGpS2x7
         GMmA==
X-Gm-Message-State: AOAM530CUx4mV4IOG/roaIe/JaOsBiSvxG+PBRy/P3PBvsxb30UVy/5D
        SJL5CKOHUgiMRTetKQsUZopBdA==
X-Google-Smtp-Source: ABdhPJw3NfB3x04KEBXGRKtfaIopOFoSnpJaNQZBGPeNyhHXjJQxGlGlxdY1AzUUWu4ZgFrUhRwcgQ==
X-Received: by 2002:adf:fb06:0:b0:1e6:8b27:f1ea with SMTP id c6-20020adffb06000000b001e68b27f1eamr1803259wrr.353.1645701452462;
        Thu, 24 Feb 2022 03:17:32 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:31 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 09/16] ASoC: codecs: rx-macro: setup soundwire clks correctly
Date:   Thu, 24 Feb 2022 11:17:11 +0000
Message-Id: <20220224111718.6264-10-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/lpass-rx-macro.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 83b570403c59..a2f49a21678b 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3430,6 +3430,13 @@ static int rx_macro_component_probe(struct snd_soc_component *component)
 static int swclk_gate_enable(struct clk_hw *hw)
 {
 	struct rx_macro *rx = to_rx_macro(hw);
+	int ret;
+
+	ret = clk_prepare_enable(rx->mclk);
+	if (ret) {
+		dev_err(rx->dev, "unable to prepare mclk\n");
+		return ret;
+	}
 
 	rx_macro_mclk_enable(rx, true);
 	if (rx->reset_swr)
@@ -3456,6 +3463,7 @@ static void swclk_gate_disable(struct clk_hw *hw)
 			   CDC_RX_SWR_CLK_EN_MASK, 0);
 
 	rx_macro_mclk_enable(rx, false);
+	clk_disable_unprepare(rx->mclk);
 }
 
 static int swclk_gate_is_enabled(struct clk_hw *hw)
@@ -3492,7 +3500,7 @@ static int rx_macro_register_mclk_output(struct rx_macro *rx)
 	struct clk_init_data init;
 	int ret;
 
-	parent_clk_name = __clk_get_name(rx->mclk);
+	parent_clk_name = __clk_get_name(rx->npl);
 
 	init.name = clk_name;
 	init.ops = &swclk_gate_ops;
-- 
2.21.0

