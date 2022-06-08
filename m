Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBF9542B5C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiFHJVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiFHJTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:19:15 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4272383C6;
        Wed,  8 Jun 2022 01:41:47 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e656032735so26419869fac.0;
        Wed, 08 Jun 2022 01:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SXmj6b+DkfLw5itmWk4/FOZXu0aiY0xTFwHQz3P20xg=;
        b=WdYBN8CGdrIXxQzK0GPeVgw2MzDlTQbjZImmiSCIjEzItPZCLwSrJunmeLbwAI5ikm
         7UpERZ2fzajMjBN38noWZM/RUcDEMPoazkYxmDCZ/piF6SB6ltAhCk3muTBLBmfff+up
         1ySlRhC1vAawc4shHJYJl8WtvyOFfF7pyOD2RMHst5fPRND+9bgFXKQhUs4eFuzF83pL
         TH7AybGjXUB/CPMHa+NdXiymNtTHvTNSi9Ff/1E1P5OvPjJCNNfhkrNJDXwi4zpqetk1
         kyOe8mqAmriJNKLHM0imih+M6yAeZIA/mFxwR6SZyk+XLKohGvYt0P+D4aZX/5GXgoaR
         obRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SXmj6b+DkfLw5itmWk4/FOZXu0aiY0xTFwHQz3P20xg=;
        b=XlmxD4uFJ3X5WhoTEiCn0+s+2JaYcVK42fDK6N5iKvZd1JWKt1YrU3TxMVvpMeOrLn
         RKXOiw+xJz+4CyKOZMPkkU+fWDex3qrmU3KTvul+oYv+LL2uRz0qONySfqRrTJ44+YvX
         lUTspEvTrAhb7BdVdF3Ji661bOyV6FylHqhxViOGts3cjHz9IjLWrTz+jb73uLR98sro
         yYwJ809nx35LNQjVsWy5yrEE7BKOsw4GObcTHX/KjK5DrRakHh0N1e/E35LSErsqAOT2
         ilocDKkanXIUxXG54K7hcxLd8qw84qFZSBbHrHbRmm4NYPvMrxSWCtBuG8Akng07AWpC
         KYaw==
X-Gm-Message-State: AOAM532tfNMeo1xHmQ71vS9vGTm5AKM/ljQoe6b2qWrX7GY14wlFx21J
        G98IA3RujJ1LfLERlTiWgQrE8g0XgTA0hA==
X-Google-Smtp-Source: ABdhPJxAOK47geI2yEq8uUzL6jVlujBVSQkzoXkWwANZs743d3DkA34VEE/uGgrzp5MCNfVJU/Fzyg==
X-Received: by 2002:a17:90a:4897:b0:1c7:5fce:cbcd with SMTP id b23-20020a17090a489700b001c75fcecbcdmr71830734pjh.45.1654677696141;
        Wed, 08 Jun 2022 01:41:36 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:837b:38ad:1ae9:1239:b178])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902f34400b0015e8d4eb263sm13902217ple.173.2022.06.08.01.41.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:41:35 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] backlight: rt4831: Apply ocp level from devicetree
Date:   Wed,  8 Jun 2022 16:41:14 +0800
Message-Id: <1654677674-15417-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654677674-15417-1-git-send-email-u0084500@gmail.com>
References: <1654677674-15417-1-git-send-email-u0084500@gmail.com>
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

Add 'richtek,bled-ocp-microamp' property parsing in
device_property_init function.

This value may configure prior to the kernel driver. If it's not specified in
devicetree, keep the original setting. Else, use clamp to align the
value in min/max range and also roundup to choose the best selector.

Reported-by: Lucas Tsai <lucas_tsai@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v2:
- Prase the 'richtek,bled-ocp-microamp', clamp the value in min/max range, and
  roundup to get the best selector.

---
 drivers/video/backlight/rt4831-backlight.c | 33 +++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/rt4831-backlight.c b/drivers/video/backlight/rt4831-backlight.c
index 42155c7..8c2001b 100644
--- a/drivers/video/backlight/rt4831-backlight.c
+++ b/drivers/video/backlight/rt4831-backlight.c
@@ -12,6 +12,7 @@
 #define RT4831_REG_BLCFG	0x02
 #define RT4831_REG_BLDIML	0x04
 #define RT4831_REG_ENABLE	0x08
+#define RT4831_REG_BLOPT2	0x11
 
 #define RT4831_BLMAX_BRIGHTNESS	2048
 
@@ -23,6 +24,11 @@
 #define RT4831_BLDIML_MASK	GENMASK(2, 0)
 #define RT4831_BLDIMH_MASK	GENMASK(10, 3)
 #define RT4831_BLDIMH_SHIFT	3
+#define RT4831_BLOCP_MASK	GENMASK(1, 0)
+
+#define RT4831_BLOCP_MINUA	900000
+#define RT4831_BLOCP_MAXUA	1800000
+#define RT4831_BLOCP_STEPUA	300000
 
 struct rt4831_priv {
 	struct device *dev;
@@ -85,7 +91,7 @@ static int rt4831_parse_backlight_properties(struct rt4831_priv *priv,
 {
 	struct device *dev = priv->dev;
 	u8 propval;
-	u32 brightness;
+	u32 brightness, ocp_uA;
 	unsigned int val = 0;
 	int ret;
 
@@ -120,6 +126,31 @@ static int rt4831_parse_backlight_properties(struct rt4831_priv *priv,
 	if (ret)
 		return ret;
 
+	/*
+	 * This OCP level is used to protect and limit the inductor current.
+	 * If inductor peak current reach the level, low-side MOSFET will be
+	 * turned off. Meanwhile, the output channel current may be limited.
+	 * To match the configured channel current, the inductor chosen must
+	 * be higher than the OCP level.
+	 *
+	 * Not like the OVP level, the default 21V can be used in the most
+	 * application. But if the chosen OCP level is smaller than needed,
+	 * it will also affect the backlight channel output current to be
+	 * smaller than the register setting.
+	 */
+	ret = device_property_read_u32(dev, "richtek,bled-ocp-microamp",
+				       &ocp_uA);
+	if (!ret) {
+		ocp_uA = clamp_val(ocp_uA, RT4831_BLOCP_MINUA,
+				   RT4831_BLOCP_MAXUA);
+		val = roundup(ocp_uA - RT4831_BLOCP_MINUA,
+			      RT4831_BLOCP_STEPUA);
+		ret = regmap_update_bits(priv->regmap, RT4831_REG_BLOPT2,
+					 RT4831_BLOCP_MASK, val);
+		if (ret)
+			return ret;
+	}
+
 	ret = device_property_read_u8(dev, "richtek,channel-use", &propval);
 	if (ret) {
 		dev_err(dev, "richtek,channel-use DT property missing\n");
-- 
2.7.4

