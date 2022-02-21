Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AFD4BDC5B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358772AbiBUNLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:11:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358708AbiBUNL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:11:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289451EEE8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j22so924381wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=to/0VQRxET3KlmX/g/6lkGwzP14Y4zFtNFsg8ymenlA=;
        b=mbzV2rMh2TIubzZRZpZTj5cmoESg5T8lu0MMvfc1S98Psy4yiSSn4zn54E+r2mQPJu
         vCSzoIucJ27el+jkSLan/J2VU8veKAGCYUQUEovYVIXeZ8CYklNabYfZILeOtgcfXS8F
         EUMSjGIkqebrpIiIyGifTRr1p2NqmschAolxTVT3np5RVssz03nz3ybbxEDUHzp4ecNu
         2fQerpohucN1tYDjjF89HccRxQHoiYRQmEUhxbSAC7ClcQNrme0R1rEtqsd+p6efDXZE
         qkXvaPwMsBGNEWqdXarP1ItkvdRYcSLf1icCdmNNSJIjnx7SaJ0dYoI4p5YpqxeqHoiY
         bPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=to/0VQRxET3KlmX/g/6lkGwzP14Y4zFtNFsg8ymenlA=;
        b=3bMHQaw2sK726dMU/LI7XQl6FrSz205AytklxGTtrKkGkoL2pUxqyeFW/MxpPYGEf3
         3kHFQQy/IMdd0jPeke9Bnq0skAOWBszNw7QJt0t9wxYptI9HYdE85Q/A+0h83kjsHOOA
         4L2oIz9KGBHSsPYxVUvR20xaJIiZQKyxHGlg8BY8lV6GnwnOzjvTF0XrOwuNNOJrFAb9
         eNOnW1TzSH1oIafR4oEDyh1EPWJXb2V9K7J2iOfFLQRu6Sc9sJQhZSXGQU3xdzdokQip
         ueBjoH78c4b50hr6OFJ0IKvpeh6Xt6uaYzleO70JKw+jF0856KeRCgko3mvB+4lLDAeL
         bBOQ==
X-Gm-Message-State: AOAM532yf5NsDMOmeRYZ6Df+FrMJKbGeUWTSew4eETkU1FosCPxQm8vb
        cJmCeI6OlBks26e2NStQkII3hw==
X-Google-Smtp-Source: ABdhPJwVS2QIlSS1PXWjt7wJwFAbOL6vY5vnL/xglBpqQiKgDeFouZ3MoUiTvK6PusY2cD4HIY5CnA==
X-Received: by 2002:a05:6000:1881:b0:1e8:f75c:591d with SMTP id a1-20020a056000188100b001e8f75c591dmr13975498wri.257.1645449050313;
        Mon, 21 Feb 2022 05:10:50 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 3sm49412801wrz.86.2022.02.21.05.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:10:49 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/10] ASoC: codecs: wsa-macro: setup soundwire clks correctly
Date:   Mon, 21 Feb 2022 13:10:35 +0000
Message-Id: <20220221131037.8809-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/lpass-wsa-macro.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index a8d30f3b3fdf..d51d6acac28b 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2257,6 +2257,7 @@ static int wsa_swrm_clock(struct wsa_macro *wsa, bool enable)
 	struct regmap *regmap = wsa->regmap;
 
 	if (enable) {
+		clk_prepare_enable(wsa->clks[2].clk);
 		wsa_macro_mclk_enable(wsa, true);
 
 		/* reset swr ip */
@@ -2281,6 +2282,7 @@ static int wsa_swrm_clock(struct wsa_macro *wsa, bool enable)
 		regmap_update_bits(regmap, CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
 				   CDC_WSA_SWR_CLK_EN_MASK, 0);
 		wsa_macro_mclk_enable(wsa, false);
+		clk_disable_unprepare(wsa->clks[2].clk);
 	}
 
 	return 0;
@@ -2351,7 +2353,7 @@ static int wsa_macro_register_mclk_output(struct wsa_macro *wsa)
 	struct clk_init_data init;
 	int ret;
 
-	parent_clk_name = __clk_get_name(wsa->clks[2].clk);
+	parent_clk_name = __clk_get_name(wsa->clks[3].clk);
 
 	init.name = clk_name;
 	init.ops = &swclk_gate_ops;
-- 
2.21.0

