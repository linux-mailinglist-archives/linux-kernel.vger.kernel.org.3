Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88EC4DA76B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352042AbiCPBmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240895AbiCPBmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:42:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF1853E0F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:41:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s11so1718358pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=5TN7lZdXFXxg1iaTCPv4OVG95Uy6qF3btAwL8YcaPoo=;
        b=fp6lcFh5R0fHZgw6XCRFpUL7I5I1gXmE8/vyIb2woJggGoKpx50bjig+qMBd33Y7WJ
         kVuGkMUNDOsxAT0LxoZMiZktQafTk6zX8IBjtpBWOr6JKAc+pGnn41DSEGPcj+K5e5j7
         9eEPSz1tMiJuALgTV9pauBZGx9f0iZO8XsNtGu7s/plgCrynSjgc15H4XiFvzXE5sjlr
         ZhVXs0KI7GY5UGlPLEaDuBg3g0I3YVUzZiXewCh6skyTB6rGNJOvcKadRTiLEn7VaWUh
         ZsVBekxVVg3Q4R57fTjai04UeQos0/OyCC9zSRyl+l1y5I893f5j9Li8nS1yujnNx0qj
         BZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=5TN7lZdXFXxg1iaTCPv4OVG95Uy6qF3btAwL8YcaPoo=;
        b=wu9qwCUjB9kCVLCsRUX0OK0KvLb3vFeGYpJ5olsaTz9WMGkScJQ7mjGCz95Uw71nfb
         Emj2toVVUn/kDE14r76kWfs6zmR1+yi/sBflnmZdNdku3ogwKmlIKVtqrnvBnkhQxQpv
         /nUhnJMqorEFqFeoHaRPywZRfVVL8KmH5c9CCJqiGByhQvr1a9SRBWaid15WDwuwEW16
         Ni9Pzgsss6bjyZPiJEd7DPnXHGHj0+hMJTeIkzSCl1U4iOb2+eVQ2LhLij8QfvGvc+o2
         V8JcVaQ0Xckg4s4pxaSPV4hwwYL+xEYI0v55aCN9KEpzUPpXzTT/zwUB+j8tYZ8b40Y0
         D4qQ==
X-Gm-Message-State: AOAM530UD1qFuWJswSjzhhrNvaFy+w32bBdh3p7EoC78CQ5m21Htj1TZ
        XblLz7Ffk1mnrEvOW9EnMkA=
X-Google-Smtp-Source: ABdhPJxK7nJ6x3EXhO8mMTf3wXoWFtWkzGi6+LnIsadkdyjrPZjF5qTX1txO598/jtLONqY44bQ5Jw==
X-Received: by 2002:a63:8e:0:b0:380:93d7:e85f with SMTP id 136-20020a63008e000000b0038093d7e85fmr26142946pga.177.1647394866646;
        Tue, 15 Mar 2022 18:41:06 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id me5-20020a17090b17c500b001c63699ff60sm4485594pjb.57.2022.03.15.18.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 18:41:06 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Shunli Wang <shunli.wang@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: mediatek: Fix error handling in mt8183_da7219_max98357_dev_probe
Date:   Wed, 16 Mar 2022 01:40:57 +0000
Message-Id: <20220316014059.19292-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Yia5XgkGyLbIRc1f@google.com>
References: <Yia5XgkGyLbIRc1f@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

This function only calls of_node_put() in the regular path.
And it will cause refcount leak in error paths.
Fix this by calling of_node_put() in error handling too.

Fixes: 5bdbe9771177 ("ASoC: mediatek: mt8183-da7219: use hdmi-codec")
Fixes: ebbddc75bbe8 ("ASoC: Mediatek: MT8183: Add machine driver with DA7219")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
change in v2:
- update Fixes tag.
---
 .../mediatek/mt8183/mt8183-da7219-max98357.c  | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 718505c75418..f090dee0c7a4 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -695,8 +695,11 @@ static int mt8183_da7219_max98357_dev_probe(struct platform_device *pdev)
 	}
 
 	card = (struct snd_soc_card *)of_device_get_match_data(&pdev->dev);
-	if (!card)
-		return -EINVAL;
+	if (!card) {
+		ret = -EINVAL;
+		goto put_platform_node;
+	}
+
 	card->dev = &pdev->dev;
 
 	hdmi_codec = of_parse_phandle(pdev->dev.of_node,
@@ -761,12 +764,15 @@ static int mt8183_da7219_max98357_dev_probe(struct platform_device *pdev)
 	if (!mt8183_da7219_max98357_headset_dev.dlc.of_node) {
 		dev_err(&pdev->dev,
 			"Property 'mediatek,headset-codec' missing/invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_hdmi_codec;
 	}
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	if (!priv) {
+		ret = -ENOMEM;
+		goto put_hdmi_codec;
+	}
 
 	snd_soc_card_set_drvdata(card, priv);
 
@@ -775,13 +781,16 @@ static int mt8183_da7219_max98357_dev_probe(struct platform_device *pdev)
 		ret = PTR_ERR(pinctrl);
 		dev_err(&pdev->dev, "%s failed to select default state %d\n",
 			__func__, ret);
-		return ret;
+		goto put_hdmi_codec;
 	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 
-	of_node_put(platform_node);
+
+put_hdmi_codec:
 	of_node_put(hdmi_codec);
+put_platform_node:
+	of_node_put(platform_node);
 	return ret;
 }
 
-- 
2.17.1

