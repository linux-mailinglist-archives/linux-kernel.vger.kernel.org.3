Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAD74CFFD7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbiCGNUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbiCGNU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:20:29 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9625F75223
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:19:35 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g19so2195413pfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=8UIXOdI0t1TiJ+FRLj3UKI2HFoPWogUwUu2GB97fws0=;
        b=aFXQLGZNm6HlTM+8vb5jBpBwR6GcUgZ+vJeu6kLxjsPs4qpHX63yj5GjD7LIv+R0qG
         uW0/fL50y3txM8TmbA+ZeFDXGIwErtwvN+cksdP91/UNNNL8nnfMlNWMM+xMKJot988o
         FCNj/CFn2yPPNnTAmUEmNjayZTw8UHpvKiLp9kqXlLOwmJBU1aIqd3sXdxKGPLu56/85
         XZMh0ztdYKajUKKqNMaUCjrqzpZ5Jd7hH5ZrmkrDm6eMZxAciarclpNiwIiMPuA/a4C+
         m01AWr7JiT9EH/Lu/XqMPX6IH6dVMj6+VCCWXrUhuXDnD0HZ0VdfgxDJdNAJ74Caj/Gc
         ZZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=8UIXOdI0t1TiJ+FRLj3UKI2HFoPWogUwUu2GB97fws0=;
        b=dZXA2WKKc1xy9kmlXWpZ0/5NMP3IiFtHBwzX6eRDrsYOBNppClSAXMdtdFFugAhTQg
         6T1w7OqWYwquK+GcEsfMffoAXtRt3eFYi1ukeShVgKSZmwWSFrcOyFicx/OvNrFdpqJb
         Ad2eF4j7TRQJNe0htsDtkahmO0uQIxXZQ1F9bY5l3viZkMJEGdVnm8507AXpV4y/j2Bq
         Ow+utvprCj26xNSj1q0v0WdUnO4CV9Q8/ilCTy1iEq95b9SgVw3BZVva0jVXM15C//e1
         YP/xGufgm5cqSYsaiBbX56fp+/hKHZxG0jaCs7kkYEH3ZV/RS7BKwkm7msRkihsa7Nxn
         bOow==
X-Gm-Message-State: AOAM5303kRs9WTBwtnaiN0FAH9qLw07Y9VQsBQr+FBUL5zotNMuNDbw+
        1vjKm4N0y68uQ4szNRpgnAM=
X-Google-Smtp-Source: ABdhPJw2cXIDr0JRcIC/XnOnRqQeuQAShi8lvv7wag+5HYdHbVOXvTbaf3SR8QpJ/e9XmNztZflyDw==
X-Received: by 2002:a62:8f83:0:b0:4f1:68e4:c561 with SMTP id n125-20020a628f83000000b004f168e4c561mr12760779pfd.67.1646659175160;
        Mon, 07 Mar 2022 05:19:35 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id m8-20020a17090a158800b001bf2cec0377sm11040696pja.3.2022.03.07.05.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:19:34 -0800 (PST)
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
Subject: [PATCH] ASoC: mediatek: Fix error handling in mt8183_da7219_max98357_dev_probe
Date:   Mon,  7 Mar 2022 13:19:21 +0000
Message-Id: <20220307131924.9905-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Fixes: ebbddc75bbe8 ("ASoC: Mediatek: MT8183: Add machine driver with DA7219")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
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

