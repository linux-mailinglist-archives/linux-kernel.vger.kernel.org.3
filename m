Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78C44F1200
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353978AbiDDJbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353794AbiDDJbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:31:06 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A048220CF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:29:10 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id b130so7826799pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=25rklRbKCPsv/fRQUYfQLO06IirkCoUcr/CH2yXPlg0=;
        b=nBv0RJtYmfjSnEU9JW7F8vPjVAc38XVKIiB+Nv1Pyj/2Kl3CbuQTBfdZsewPPKnt6m
         eRu9uOkrg/e9NhZhQ15shTFSGJfOzGjQatHbtfehqNJ5f4GhoTGlVd3F/RrWhucFZneO
         WU6vJl0X1XI03mve7bJACyyr2/piw3Ai+Xh/ApNfdN6YuT2F0+o/kbmFKiRRrXd5ibzz
         S0mgTCO0YWRYrIhQbc+xuAnvYmZHWVRzAdljZuvh3i2qDf4JPYR7qGxiVal1ii7mWz76
         t/V8vil3Q32bQhtdLFQNEN8AHLnhaZ1LIXIdbvZDLNmkwEpWugRXsYsJYgrUa9u9h+mi
         /+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=25rklRbKCPsv/fRQUYfQLO06IirkCoUcr/CH2yXPlg0=;
        b=inoNKOwmOYxnJnAYrN+V/Ia2MaFMm+vhwkedEP4LfPZzsv+CDMPxdwvcdcB5SlFHVq
         N+1NFTOORu5ZWVTNdlwXAC89tI/4mNnypTRdeYONCmzDtjRQ/NtEkUV57BIaY+oBLwbm
         qvuwEYGqFNCSqQdVqJHjaBe03t6ZfFScBRoRH3VM1QWOY7KYVbwi4ll/fwAAuBYe2BaZ
         tlbGoNPDLRe3QjCLOsqwF0X8f/giOxbYqh33LuOT4+W6dndtYXXiE/m837pR/ahePT3E
         yL6ACANQNwBMUGfAA6XpW5jaw30bYkZJW3ndpD0J2ShAvrK/39EExkqWlGPwRNEbe8Im
         6LiA==
X-Gm-Message-State: AOAM530Mrdqteo8SmtZ8BSEbo9quK/WEDRFM92Pl/wyBMxylaiCC5ByY
        e9zXNmH0wB0Mg3MYri1kDe4=
X-Google-Smtp-Source: ABdhPJzDhNqYIqvfdG6d/FBo1eOl6xSsWZwI4Iti4exghBFyDjhz9X/Fg/iKNHzjDK0eLF6hNJVhjA==
X-Received: by 2002:a63:3344:0:b0:398:2527:a122 with SMTP id z65-20020a633344000000b003982527a122mr25559649pgz.140.1649064549916;
        Mon, 04 Apr 2022 02:29:09 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id h189-20020a636cc6000000b0039841f669bcsm10063032pgc.78.2022.04.04.02.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 02:29:09 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Koro Chen <koro.chen@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: Fix error handling in mt8173_max98090_dev_probe
Date:   Mon,  4 Apr 2022 09:29:01 +0000
Message-Id: <20220404092903.26725-1-linmq006@gmail.com>
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

Call of_node_put(platform_node) to avoid refcount leak in
the error path.

Fixes: 94319ba10eca ("ASoC: mediatek: Use platform_of_node for machine drivers")
Fixes: 493433785df0 ("ASoC: mediatek: mt8173: fix device_node leak")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/mediatek/mt8173/mt8173-max98090.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
index 4cb90da89262..58778cd2e61b 100644
--- a/sound/soc/mediatek/mt8173/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -167,7 +167,8 @@ static int mt8173_max98090_dev_probe(struct platform_device *pdev)
 	if (!codec_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_platform_node;
 	}
 	for_each_card_prelinks(card, i, dai_link) {
 		if (dai_link->codecs->name)
@@ -179,6 +180,8 @@ static int mt8173_max98090_dev_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 
 	of_node_put(codec_node);
+
+put_platform_node:
 	of_node_put(platform_node);
 	return ret;
 }
-- 
2.17.1

