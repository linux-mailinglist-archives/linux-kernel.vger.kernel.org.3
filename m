Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89FC4C2AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiBXLS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbiBXLSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:18:01 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BFE15A23A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so1062772wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9GMeWI1tNkbi4OC/4dfJqIUQ1pnya35dc/9sZ3BiKI4=;
        b=s2cKWb6EDkhhedxiJav26MCdH3kvZL4oXoyUzVMDonmIlmWO8HCeGGC/4VuT+12jqv
         Xx+8Gkx3sK87+vHG1TQp6IZ1deqaUQIJCfaqJSjOXZqK1TG8CH11fJnor5dYAgAE8YyV
         H5sP0w3jdVZNugAAyib2SRUfEQOrcGRRXkIIBphxMDA3SLNEd8Jn8h7B+IX/kMMe46xr
         qt4551B+yXJMx+Kg6Jy+WFujN8b3Qv5z3Lx6bpcaNoSLPPSnbSdIjxjMCtof6ehq6F1D
         AVIP7oRMiFnh9E1I4/V6zlZy1HvfW4dhn2EzQ3A+wY801E4gUs6gHyCCPG5vhMUVEG6e
         YydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9GMeWI1tNkbi4OC/4dfJqIUQ1pnya35dc/9sZ3BiKI4=;
        b=hhDFTMnQBFwPbOxR+4Wz96tMFNhMUx//FY1F52uSOLo7B3VkYKSeuc73TDTTkSTVuy
         iKv5LQdhfZ50sXg4dsBTnmck/7Ux3uwRjiZf9LPyVBDatxtwuKsJgfJlvTANVB6b6NDu
         ibnlgSDMQ7Y2cB0HX/d3KAjnsQx0LbT6u4BGpBes0tKDPBqfV16Wx+oLtyLDRFawx3Jy
         zSGpBoVK1QE4VdM5Ve+41ha0fk7D+PP0dNDK601K+RAnpZEWjB5RGuhBChZfeZNMe+EO
         Bew884XGJNZ9+CEdT4+p2iMRXjvbxwoHB5tv4sC865+r0laS9QXpIU6ntXLaT6fJ052N
         nyXA==
X-Gm-Message-State: AOAM533yWlbA16j3kcH0bCAZgBOpfoz8v+SnVKT26FX0jvrrGwx/ThKB
        0kk3wUvU432SrEeVXN+CpW+fbg==
X-Google-Smtp-Source: ABdhPJwOYHMnZNvU9zDMlws3RLTrnptEO39DLfuc1HloQdZsLISrYC/aqj4jFlONbQulW1YEZbcU0Q==
X-Received: by 2002:a05:600c:4f54:b0:37b:fe6a:ea9c with SMTP id m20-20020a05600c4f5400b0037bfe6aea9cmr1900585wmq.169.1645701450266;
        Thu, 24 Feb 2022 03:17:30 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:29 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 07/16] ASoC: codecs: wsa-macro: setup soundwire clks correctly
Date:   Thu, 24 Feb 2022 11:17:09 +0000
Message-Id: <20220224111718.6264-8-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/lpass-wsa-macro.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index ac5f94fff0a9..2586d6350f20 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2260,6 +2260,13 @@ static int wsa_swrm_clock(struct wsa_macro *wsa, bool enable)
 	struct regmap *regmap = wsa->regmap;
 
 	if (enable) {
+		int ret;
+
+		ret = clk_prepare_enable(wsa->mclk);
+		if (ret) {
+			dev_err(wsa->dev, "failed to enable mclk\n");
+			return ret;
+		}
 		wsa_macro_mclk_enable(wsa, true);
 
 		/* reset swr ip */
@@ -2284,6 +2291,7 @@ static int wsa_swrm_clock(struct wsa_macro *wsa, bool enable)
 		regmap_update_bits(regmap, CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
 				   CDC_WSA_SWR_CLK_EN_MASK, 0);
 		wsa_macro_mclk_enable(wsa, false);
+		clk_disable_unprepare(wsa->mclk);
 	}
 
 	return 0;
@@ -2354,7 +2362,7 @@ static int wsa_macro_register_mclk_output(struct wsa_macro *wsa)
 	struct clk_init_data init;
 	int ret;
 
-	parent_clk_name = __clk_get_name(wsa->mclk);
+	parent_clk_name = __clk_get_name(wsa->npl);
 
 	init.name = clk_name;
 	init.ops = &swclk_gate_ops;
-- 
2.21.0

