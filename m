Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C3853B231
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiFBDmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiFBDmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:42:00 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B897E186C5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 20:41:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id x12so3648670pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 20:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96Q41uk4y6XbcZl1Zsx4+krpYFpttRN8NWnLOQ9e608=;
        b=XUstNAd+TkZxYOg2nB0/CnWOe031scydaaFy5ujX6N9OPZ4fDymvFtAI9RQ5HtU9xy
         1mPG+WzesqN4xw/HI+17JlvYsYombwEsWJy+zxHHswmhFSXNKdx6fgFhpGGP8juPpFz6
         5bYIBgfJW5l3glxrFfHyFw6eCaCdbe7URRR2yAselbs8VOuEWjwsNBowqmT0TzePPjrk
         Ld7vQMAppj2mohHZqCfIoa3gjuGIyvzm8iFMAru5vGPmAqdIAAqkceY9mie5fLcqPv0s
         PbLdcJQIxOxrsBdXRC9VtP5+lnuaZfIbA1QDX2XuCNqjoLaG7zeTvavawY9e5kh8Ku/c
         CAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96Q41uk4y6XbcZl1Zsx4+krpYFpttRN8NWnLOQ9e608=;
        b=D7pg4ypSCsxN9LVLx7XusELCbRMRfQC5tVN7P+f3QpaAlqsWnbyeg+IuoNCygge6SF
         ovX8qwMpvHcPB1yfgGirzSr2unFIlBrndyvF++D+rUbq+eYc7OW6bMjCwFTIHVt92cjo
         veJdKSoed7H6wHA3Ksa32jt0mwY0W56c2sNDMJdDlpktks8Hl2paVbGchBf9zKvzu279
         NQDrgYIy5fsXs4O+tYKkfyqF3oXV7YaNVOpt8q6I7MsBibmu+AsXuWQJLvHxVm3T1IcD
         BgpTmf20eE7x0M85m1echn1hebSNLBFKHj444mrTJ69emUwQxuSLuVt6uzdhxG+Grg+M
         HFjw==
X-Gm-Message-State: AOAM532QGSw0TygXtjaQrQODws9/r6aHTrsxGlotZ361q69O6xU84u8J
        vXSnIGP8QhOpFBK7BUsqtms=
X-Google-Smtp-Source: ABdhPJyPyKsY1RQq4rtR0YQcNAGzw5ULWmM3dgngCbyE+JjqSgZREIGNeNy4NwVWNPsBK4RJSAeXyg==
X-Received: by 2002:a63:7e4e:0:b0:3db:945a:2575 with SMTP id o14-20020a637e4e000000b003db945a2575mr2354037pgn.227.1654141315261;
        Wed, 01 Jun 2022 20:41:55 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id o24-20020a17090ac09800b001e2f578560csm2104137pjs.45.2022.06.01.20.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 20:41:54 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Koro Chen <koro.chen@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: mt8173: Fix refcount leak in mt8173_rt5650_rt5676_dev_probe
Date:   Thu,  2 Jun 2022 07:41:42 +0400
Message-Id: <20220602034144.60159-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Fix missing of_node_put() in error paths.

Fixes: 94319ba10eca ("ASoC: mediatek: Use platform_of_node for machine drivers")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index 70bf312e855f..8794720cea3a 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -256,14 +256,16 @@ static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
 	if (!mt8173_rt5650_rt5676_dais[DAI_LINK_CODEC_I2S].codecs[0].of_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_node;
 	}
 	mt8173_rt5650_rt5676_dais[DAI_LINK_CODEC_I2S].codecs[1].of_node =
 		of_parse_phandle(pdev->dev.of_node, "mediatek,audio-codec", 1);
 	if (!mt8173_rt5650_rt5676_dais[DAI_LINK_CODEC_I2S].codecs[1].of_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_node;
 	}
 	mt8173_rt5650_rt5676_codec_conf[0].dlc.of_node =
 		mt8173_rt5650_rt5676_dais[DAI_LINK_CODEC_I2S].codecs[1].of_node;
@@ -276,13 +278,15 @@ static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
 	if (!mt8173_rt5650_rt5676_dais[DAI_LINK_HDMI_I2S].codecs->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_node;
 	}
 
 	card->dev = &pdev->dev;
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 
+put_node:
 	of_node_put(platform_node);
 	return ret;
 }
-- 
2.25.1

