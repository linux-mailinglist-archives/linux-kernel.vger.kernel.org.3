Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDA94BF783
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiBVMA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiBVMAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF440156C60
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:49 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so225887wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HYM5KhvV8cAY2xeJWd0M65Y2tn1Q2u3N1GUicP98cl8=;
        b=RX6X4lmjUY/h74tOHBTweptlgfLuFmBZXV8kDh2RmGzLeHzQ1u8tX6ZCvYEtccu4xQ
         HDE9G6MNBk9HNR+SajG7pQzZdjFm0r67Nunqg/UVJnUCN2CbZpLjLDUlDFZtZnYjNzfq
         Z3zwno2Ykj4Sld3+FXEO0uOwjcVctBiD0cvjfm+O/+WywJgfmbAUvej5JRLmwvqJ7EN4
         S2oaW8N4IX+XJtROIFJSlARsVfqzcBW/5U0cHVTULCTgfbDMCB6hJt54sDFM+Z4ws3WN
         4fY5UycCJvCdpNSsRatWPKCJ/qwZILJzH9jmJPjjVdWjuXBA7FDNZsZ8FLGwGLK3M9E+
         mzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYM5KhvV8cAY2xeJWd0M65Y2tn1Q2u3N1GUicP98cl8=;
        b=m6VWIiWBkdaj5Ao/F1dUYkYmYOLSw052QlY6QIZNheDNWveCGPCGr1j96kjUWsGfVM
         Y6Pc7PTQA13G3z9RulRfmuDLq3BOuxzBsID6RgwWThDUF41JSkWMoi7re6ULERPg//Is
         FR+yrWNHRQGNf62zGChxhPFjEFBiOMoFHcEAUIp70ZU8P5APczKo1IA/3n9V/l/Pcm3A
         taS5ioMQjIQl4hUbA1WDVOJX1cs2D3VDDATDUTGMhAHP5nIj+MZPPVjHkZlbrd2DqoNB
         Wwx8f05nM0Tq7IW6Ppcq2IiY4gWZ7uhRgnk+PtmNnQdi1MR4/R+VZbhelIANdZ3f9bmi
         Qn4A==
X-Gm-Message-State: AOAM530/lqllCjbpMJZatVrEla8nLMtuwSPfufngpEULgVqh3ZnCtR5C
        M1DAbMcO1mJerxudx1D+N//Dqg==
X-Google-Smtp-Source: ABdhPJzLhrz3DxbtX9yGvLu3mqXzHXSgCBONoNArMwvkRmF9SNZLw5cuOed4dssa5O1/3S/74GG3Aw==
X-Received: by 2002:a05:600c:2e02:b0:380:d7dc:5530 with SMTP id o2-20020a05600c2e0200b00380d7dc5530mr1856598wmf.115.1645531188467;
        Tue, 22 Feb 2022 03:59:48 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:59:48 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/16] ASoC: codecs: rx-macro: fix accessing compander for aux
Date:   Tue, 22 Feb 2022 11:59:18 +0000
Message-Id: <20220222115933.9114-2-srinivas.kandagatla@linaro.org>
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

AUX interpolator does not have compander, so check before accessing
compander data for this.

Without this checkan array of out bounds access will be made in
comp_enabled[] array.

Fixes: 4f692926f562 ("ASoC: codecs: lpass-rx-macro: add dapm widgets and route")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index fadf3c99c89d..a7f86b094a4f 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2040,6 +2040,10 @@ static int rx_macro_load_compander_coeff(struct snd_soc_component *component,
 	int i;
 	int hph_pwr_mode;
 
+	/* AUX does not have compander */
+	if (comp == INTERP_AUX)
+		return 0;
+
 	if (!rx->comp_enabled[comp])
 		return 0;
 
-- 
2.21.0

