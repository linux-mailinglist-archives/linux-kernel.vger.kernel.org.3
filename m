Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7618A534946
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbiEZDRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiEZDQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:16:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C0D101E4;
        Wed, 25 May 2022 20:16:52 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a17so392624plb.4;
        Wed, 25 May 2022 20:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UThOTLkpL6r0PfLYsEVVStjdxypFZ/KqJ5dVvlv45cQ=;
        b=TwvS3CSU4878l6qtnM6vjb91z+ZtHsGsRArRPglugXj1iIcrUot9+RP/7cVVUlboRH
         J/dJb7DHUGzCH5PXT5F7+FACbuPaPhozVRUKNFEKkfY/UzDoQgTwTUq2DwuUhOZV5FJD
         VGUHUVM+ZUt0okEKD6G8gHCqtLzE1EFzYi34hzKSu1Epue0KIxYLCXwxLyN3cd3SSkJM
         h0N5VIzySFDCKa1TXC0dfBWlTmsnDqEwQmX8mK61ruF44VsN0pYma9ckDd67YWRtRxqs
         NrSU/zhbjbZnUPQ4uZYlvheq0H5Y++27HZhiQ93dealVKz+LLtHvNf6PvYTHNZKv0ydH
         9hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UThOTLkpL6r0PfLYsEVVStjdxypFZ/KqJ5dVvlv45cQ=;
        b=wuWtke46iBVhC6RDba7a5V23esfepzFDTxMUg2N3g4cpaEelpuTUe8yO5hxFyhR+Tz
         +OpBf5cQeFCzsaNIxYGwdzTaQsevNggGyLFwf4iGptEwClu3W0G00u6NbdTaQaaWpMSt
         oKfq5uE50dr5APy8xCharH4J0n/2WLMwGYBt1b/Ap97dYQtN8gnbTJJBvbULhinbXiuD
         S2ztvSAGxrHUxyfy+Kl6WAkHfEbVpHviYFzd3z63zGmXoilIbMn+XetuLmbvGttUXdJi
         wGQoQk17uiqcXiNFBR/mj4FjaWmcjForBSqR/hqT/JS22Y+0qhgQeKo77sa1twL3HSJK
         pOhg==
X-Gm-Message-State: AOAM533f0AiYPR9SqwUgun1aQBWHnQges94vhk0pXJrLCQ/h2TfwA/7s
        NaRT4mJ40vY2FLV0M7orEzk=
X-Google-Smtp-Source: ABdhPJw4OWJucWjDO/OgkBgn3Kd7o4a82L1xaZs86EKdpB+JzlecBZUX/jxImhdjaEDiYy8UQCJd3g==
X-Received: by 2002:a17:90a:e7c6:b0:1e0:9cf7:d042 with SMTP id kb6-20020a17090ae7c600b001e09cf7d042mr354429pjb.234.1653535011416;
        Wed, 25 May 2022 20:16:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:6b12:f420:101e:bfc0:b57c])
        by smtp.gmail.com with ESMTPSA id t25-20020aa79479000000b0050dc7628181sm152964pfq.91.2022.05.25.20.16.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 May 2022 20:16:51 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] backlight: rt4831: Add the property parsing for ocp level selection
Date:   Thu, 26 May 2022 11:16:35 +0800
Message-Id: <1653534995-30794-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
References: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add the property parsing for ocp level selection.

Reported-by: Lucas Tsai <lucas_tsai@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/video/backlight/rt4831-backlight.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/video/backlight/rt4831-backlight.c b/drivers/video/backlight/rt4831-backlight.c
index 42155c7..c81f7d9 100644
--- a/drivers/video/backlight/rt4831-backlight.c
+++ b/drivers/video/backlight/rt4831-backlight.c
@@ -12,6 +12,7 @@
 #define RT4831_REG_BLCFG	0x02
 #define RT4831_REG_BLDIML	0x04
 #define RT4831_REG_ENABLE	0x08
+#define RT4831_REG_BLOPT2	0x11
 
 #define RT4831_BLMAX_BRIGHTNESS	2048
 
@@ -23,6 +24,8 @@
 #define RT4831_BLDIML_MASK	GENMASK(2, 0)
 #define RT4831_BLDIMH_MASK	GENMASK(10, 3)
 #define RT4831_BLDIMH_SHIFT	3
+#define RT4831_BLOCP_MASK	GENMASK(1, 0)
+#define RT4831_BLOCP_SHIFT	0
 
 struct rt4831_priv {
 	struct device *dev;
@@ -120,6 +123,16 @@ static int rt4831_parse_backlight_properties(struct rt4831_priv *priv,
 	if (ret)
 		return ret;
 
+	ret = device_property_read_u8(dev, "richtek,bled-ocp-sel", &propval);
+	if (ret)
+		propval = RT4831_BLOCPLVL_1P2A;
+
+	propval = min_t(u8, propval, RT4831_BLOCPLVL_1P8A);
+	ret = regmap_update_bits(priv->regmap, RT4831_REG_BLOPT2, RT4831_BLOCP_MASK,
+				 propval << RT4831_BLOCP_SHIFT);
+	if (ret)
+		return ret;
+
 	ret = device_property_read_u8(dev, "richtek,channel-use", &propval);
 	if (ret) {
 		dev_err(dev, "richtek,channel-use DT property missing\n");
-- 
2.7.4

