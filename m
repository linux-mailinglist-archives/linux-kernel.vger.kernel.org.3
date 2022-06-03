Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D853CA1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbiFCMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241456AbiFCMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:42:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7753A5E8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:42:55 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 7so6336540pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCaeN99qbe80XdllZmNt/NTUfNqd3MU7NsYrWBRHqB8=;
        b=buW7IdY3iqfdV6Y6qR7TYjHvNuMvA/L04H0R8YSMDhiClFymdVYWGX8PmytWGvqRxh
         FOhWxuHje/Jlz6IoOzONeQaXPpN2OLDgyHokkR6JrZC94wWxXvaVQTIHnbw0oOX3bOBJ
         o82+3Iy/EtwXNT2MraVUNLfAyO3D/+DFTDiO1kq0lD1Lkylufvdn/Ze2kfaoynZmHJwI
         8Th8yW3GWOeE3s/f0D+uH7C5WB6Kdhq76q/f8XTbJc3w4jj3aTtKy4oc+5TLENSp4Ocv
         GtuMF1vcGj13EZEPNCpl5iJ7uysZn6ExNB9pXJqf1qwmyYAvAsZjxu5eQqlSu0KAnvRl
         7Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCaeN99qbe80XdllZmNt/NTUfNqd3MU7NsYrWBRHqB8=;
        b=FtMUJEOxY1SXsF9xgl56igz8psoCKGuUirB1/jxqXqAyZHUkmr9n6jy+OR329rfgCu
         79PtZeNtfgCwI9lbR71a7d2cw8DbzLSnqEz7dsmvlzRYLUpb5nCDdRJC0Qu5Dodpiuhw
         iY8mVKJgWVCXa3rnkF3nc45Lj6hI20xxPfzPCzAQdepV5B32YJPEJfGL8Tg86ZKbviGq
         znRW84IRkPirl4XPfvokFGNHdEynbM5ufC33rqxVuO9Fd0pvTaW+RytzsudBiF63aeUL
         psfHhHVHfx3oSNC35jKiwWQ2FE30eKZ0hbBbcetRiUL1Rum6I71Y7bNIJBRsCH4bEFCe
         SBiA==
X-Gm-Message-State: AOAM530rcpBYdGVTHnvPP6m5rbneDXGoV9UICHYWnnO5/KxN8Oijh64a
        u6UQeGkGIN47UDpDh+W097c=
X-Google-Smtp-Source: ABdhPJxtjqcZQQnfkaDUcq0d4BxEe41StW6Nl7kFFyr+bh4ai1NO4S9DbH8MfP9DcPew/6oFyFwHRw==
X-Received: by 2002:aa7:8008:0:b0:51a:cae3:7563 with SMTP id j8-20020aa78008000000b0051acae37563mr33507197pfi.16.1654260175367;
        Fri, 03 Jun 2022 05:42:55 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id v22-20020a17090ad59600b001e281acb2f1sm5079719pju.57.2022.06.03.05.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:42:54 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        PC Liao <pc.liao@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Koro Chen <koro.chen@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: mediatek: mt8173-rt5650: Fix refcount leak in mt8173_rt5650_dev_probe
Date:   Fri,  3 Jun 2022 16:42:41 +0400
Message-Id: <20220603124243.31358-1-linmq006@gmail.com>
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
Fix refcount leak in some error paths.

Fixes: 0f83f9296d5c ("ASoC: mediatek: Add machine driver for ALC5650 codec")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
- update fixes tag.
v1 Link: https://lore.kernel.org/r/20220603081308.1332-1-linmq006@gmail.com
---
 sound/soc/mediatek/mt8173/mt8173-rt5650.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index d1c94acb4516..e05f2b0231fe 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -280,7 +280,8 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 	if (!mt8173_rt5650_dais[DAI_LINK_CODEC_I2S].codecs[0].of_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_platform_node;
 	}
 	mt8173_rt5650_dais[DAI_LINK_CODEC_I2S].codecs[1].of_node =
 		mt8173_rt5650_dais[DAI_LINK_CODEC_I2S].codecs[0].of_node;
@@ -293,7 +294,7 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"%s codec_capture_dai name fail %d\n",
 				__func__, ret);
-			return ret;
+			goto put_platform_node;
 		}
 		mt8173_rt5650_dais[DAI_LINK_CODEC_I2S].codecs[1].dai_name =
 			codec_capture_dai;
@@ -315,12 +316,14 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 	if (!mt8173_rt5650_dais[DAI_LINK_HDMI_I2S].codecs->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_platform_node;
 	}
 	card->dev = &pdev->dev;
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 
+put_platform_node:
 	of_node_put(platform_node);
 	return ret;
 }
-- 
2.25.1

