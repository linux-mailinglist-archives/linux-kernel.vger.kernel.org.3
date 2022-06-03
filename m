Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4BB53C6CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 10:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbiFCINY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 04:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242754AbiFCINV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 04:13:21 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C3627CDE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 01:13:20 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c14so6653606pgu.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJndwsNGJ35YpfT/6ZKzsPH00jUacPeRpJYnOHA8axY=;
        b=bCedhaJN+3BeY6a2bO0Sz6Cv+ieP/MqSu7rAmZaMfRV0u23z583tS5kcCsjcjlAbyg
         jW/S0/2riIakoh/gVc3nfWbOy9RS2cS56xFtDgTF4S4IFLoC7XIxBK1qQtDCYr1tFE1r
         Zq9SR8HzQfqaEYKZ1J+maSu0J0YxsMpOeNWqf1j4UxNGvi/NV7CFcxpstn4XHvB1odjN
         Tr3b5SNo1uQ3GhnHixh80GE2mNPrvXzs9MwTKVOLWLKtJ8NPvmQrJQPbHj8nNgVokgaL
         pJbrDWYC5kFIGL1jyWU59WagyhGwEHlOVgEVYQIChRG5/PwDfovy4efBiSR/iLBCmE9o
         X85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJndwsNGJ35YpfT/6ZKzsPH00jUacPeRpJYnOHA8axY=;
        b=ulNDu0h1wl6ewsNCorp/uOo/GbRdUwbVgUCWycNdA5bQ2KsS3bCr5Z4q7Gmkl44Eh9
         KebkdAuYc33ixWJ2FiIB+gBbyyTsPDQ2glWQQlnyhxwhbiLB7Gdizr038GLjsf5NiFqj
         TRnFoXZEf2Pw4xAQuIFu21r9l/RlYKqNu/zTR9FRWE0+7vxlfjk9klQakDBpJr2ysaa4
         9GCSM1LfjiK+xEdwpLyIt+c2aeN9IRP773wGmIe7MvfKDNjPxj34yXxye4MMW/kUct4y
         vVlNOU6dviU0CrGkvcyAaR/Wjukn+4S/0cWOSClCMLsHiuP0538QkGACwXyeqZ47IPCq
         Lq0A==
X-Gm-Message-State: AOAM5327JThtBnffKeua/2RNi+B3XNTKrKerQrW8XZpsp08jSdADvldR
        qb4whvXQjp2UunsCs5F2kfc=
X-Google-Smtp-Source: ABdhPJzLhSSgE1fP7Y2/aGP4aExAqPKXsnEkw1E0WB57GnC/qOzY/ZO6hIqB9pDe+P7Zrd5CDEqevw==
X-Received: by 2002:a62:1744:0:b0:51b:ab76:e8c4 with SMTP id 65-20020a621744000000b0051bab76e8c4mr9339294pfx.42.1654243999461;
        Fri, 03 Jun 2022 01:13:19 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id g6-20020a170902c38600b00163de9e9342sm4829424plg.17.2022.06.03.01.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 01:13:18 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: mt8173-rt5650: Fix refcount leak in mt8173_rt5650_dev_probe
Date:   Fri,  3 Jun 2022 12:13:06 +0400
Message-Id: <20220603081308.1332-1-linmq006@gmail.com>
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

Fixes: format:0f83f9296d5c ("ASoC: mediatek: Add machine driver for ALC5650 codec")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
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

