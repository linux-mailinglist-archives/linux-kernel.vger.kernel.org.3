Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E0552FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347204AbiFUKhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiFUKgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:36:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBCA28E0D;
        Tue, 21 Jun 2022 03:36:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso1130221pjz.0;
        Tue, 21 Jun 2022 03:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2wqkYCAZVWUkcpI1DWSn0LbIIhYG3OmH1tlPS2Wtmd4=;
        b=XRS5+iWhrsBICJnOwC8C91JQz4hmxydSsLa/vKMWgcdj8M6vkccWS0GLA7ZnHNbXL5
         dAa00abp8VlEUYfuLW9jmP867hFNx1ocf1VOYWuiE0e4bFnq3hHhmu4gaQVEoDQemqsi
         ehKXjlfcKLeAFw5imwO/mVFnOcLPwbPuxFzdp1bB8OkiW9tvNdqAdY9K0/dTbmtfPUsf
         1VRK4iDNk9V4JkUfJvacetxmkeCtt/E3Bc+ndCYrG4XnBFCOgYTJTX4eTWly0zuBiiFK
         c8lFnIuKlOAv2E4ZAuRL9pOHU1KF9wWVXzuATNyygFYIwrJTz8gwEK/r+aPergnvPYwp
         yCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2wqkYCAZVWUkcpI1DWSn0LbIIhYG3OmH1tlPS2Wtmd4=;
        b=J/v+Vznzxcu7+FO5U291620vxN3K93AAhPAKaJr1FQnsHwVwrFe8qSvhs8LFNf+2dV
         A6Kjji6cQD3Yl8Ap7P0mprDiqDTsbex6iHIGR8LXunEKYLGIa7kNwu2C+GlxJsbSY4vf
         JHAKmWbUGhNoXUH3oBRkh/Bbd409wPuBlttSEjg8S8yqZqywNaaD7MrETIWo3Nc/bo7D
         w666AcGUdjKPb4muwizMj00x2vCV+n3+yqep3hyn4oI6Jeaqa0AhT2S7X+AbEOu7o+Tr
         EBEI9VPGCFhF1iQrj5TlgCT3fFBedE82LNY8S5BQCx8dJQoV1j34XRayMMpOrJAKgvqi
         ihEQ==
X-Gm-Message-State: AJIora8GizWYyLyBqQs48IssyEyQBCOpxvSgCbnra5UkIf/Ep80UeihK
        Hws0JVQ3IOgDVIjGwGcB9W4=
X-Google-Smtp-Source: AGRyM1uGRIsIcP5NzsVPx4Jp99hohscoO3CeMiyTnZypEMga2gM0r3Aluuhfwhl4rfbbuNMZ+KrTGQ==
X-Received: by 2002:a17:902:a502:b0:151:8289:b19 with SMTP id s2-20020a170902a50200b0015182890b19mr27961661plq.149.1655807805722;
        Tue, 21 Jun 2022 03:36:45 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:c428:5499:b787:9:3bde])
        by smtp.gmail.com with ESMTPSA id o188-20020a625ac5000000b0050dc762819bsm36295pfb.117.2022.06.21.03.36.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2022 03:36:45 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] backlight: rt4831: Apply ocp level from devicetree
Date:   Tue, 21 Jun 2022 18:36:28 +0800
Message-Id: <1655807788-24511-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655807788-24511-1-git-send-email-u0084500@gmail.com>
References: <1655807788-24511-1-git-send-email-u0084500@gmail.com>
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
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Hi, Daniel:

I may use the wrong macro, must be 'DIV_ROUND_UP', not 'roundup'.
the v4 is to fix it.

Since v4
- Fix wrong macro usage, must be 'DIV_ROUND_UP', not 'roundup'

Since v2:
- Prase the 'richtek,bled-ocp-microamp', clamp the value in min/max range, and
  roundup to get the best selector.

---
 drivers/video/backlight/rt4831-backlight.c | 33 +++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/rt4831-backlight.c b/drivers/video/backlight/rt4831-backlight.c
index 42155c7..eb8c59e 100644
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
+		val = DIV_ROUND_UP(ocp_uA - RT4831_BLOCP_MINUA,
+				   RT4831_BLOCP_STEPUA);
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

