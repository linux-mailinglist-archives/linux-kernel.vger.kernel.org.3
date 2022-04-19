Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE49507C23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiDSVvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357635AbiDSVvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FB8A3FDA1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650404917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVLLH9C759FHMpXQwwKHJScD/DCbIHfB8SwIPo2nJQ0=;
        b=L8qntPQQoD/x1hXShQOnkCNfrFIv3sWUWBgbk4a5g2asVttKOH8mIfwjTibOQ/SM3Z8xDv
        ctPWP7ObzCqyatfdGbTh/LTlUsDKL0viHGmcuQUJkA/aT6By2HyutHGRMQk6JN14WIEqcx
        Sc6xZfk6LCUDoaZNajdC5H2q4gye3tk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-EmQMZfQUOaeajES1avP6eg-1; Tue, 19 Apr 2022 17:48:36 -0400
X-MC-Unique: EmQMZfQUOaeajES1avP6eg-1
Received: by mail-wm1-f69.google.com with SMTP id r204-20020a1c44d5000000b0038eaca2b8c9so1939766wma.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVLLH9C759FHMpXQwwKHJScD/DCbIHfB8SwIPo2nJQ0=;
        b=Nn0OhHhKzHVaLoZ+aBD7zr99GV9+spjMtR4z5lPr2fjxtxSInl1hRTvj+CQanQR8OX
         xhsxY6q+gdzXqLY3Idh8dMUlOoezu59s+PkcGtTlz1+3GkR2hKh/58JzQQYYwVGE0zdB
         3JUj97D1ZVDj8gJr6m8EoYbT+v8iA6IFevp5WAjDy6hTR6RKGXtDwajsZKDF+VL+nVrJ
         TdfLd7uJ4nCvA9WGS8HG4hq1l9E2vcgW0sVHabEEGnt3fIxxfDJfkkB8twq6rSM7FQen
         h5wvhF2unBPqa8B5fH8R+jEJoYYyUBdZWPRBM7gk81XK+zls4Y0CLSKxhdakF3mRlPol
         P+eg==
X-Gm-Message-State: AOAM5300c1PCQrxNuco1Bvccjz9euVkph3ROpsT9dRFL6R1r3VlGqWCH
        q90EheauAr2ATNbGBbl3WGsXa6pY+1eqfzim56EZGWkYtCEO0cGVIDA8NEcfeu28OOMJi+DzU57
        wYJFE9dHKqcCS6Nmx3BFPAAQS1eoY4gdW4qW8KJZkYPEeA1+1mEmS4kZ9q3kzrIhByF16TaGa5r
        8=
X-Received: by 2002:a5d:588b:0:b0:20a:9570:de77 with SMTP id n11-20020a5d588b000000b0020a9570de77mr9040559wrf.27.1650404915052;
        Tue, 19 Apr 2022 14:48:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzatn+dYelnkGoOsI6bvv8PKpP08+CPJhO0Hu57/jsMjYH4dmAtg8p9Rd0YiNjJRCa9cn9xbg==
X-Received: by 2002:a5d:588b:0:b0:20a:9570:de77 with SMTP id n11-20020a5d588b000000b0020a9570de77mr9040539wrf.27.1650404914803;
        Tue, 19 Apr 2022 14:48:34 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d5587000000b00207a8cde900sm13333699wrv.19.2022.04.19.14.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:48:34 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v5 4/5] drm/solomon: Move device info from ssd130x-i2c to the core driver
Date:   Tue, 19 Apr 2022 23:48:22 +0200
Message-Id: <20220419214824.335075-5-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419214824.335075-1-javierm@redhat.com>
References: <20220419214824.335075-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are declared in the ssd130x-i2c transport driver but the information
is not I2C specific, and could be used by other SSD130x transport drivers.

Move them to the ssd130x core driver and just set the OF device entries to
an ID that could be used to lookup the correct device info from an array.

While being there, also move the SSD130X_DATA and SSD130X_COMMAND control
bytes. Since even though they are used by the I2C interface, they could
also be useful for other transport protocols such as SPI.

Suggested-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v5:
- Remove unnecessary blank line added by mistake in v4 (Andy Shevchenko).

Changes in v4:
- Export ssd13x_variants array using EXPORT_SYMBOL_NS_GPL() (Andy Shevchenko)
- Use MODULE_IMPORT_NS(DRM_SSD130X) in the ssd130x-i2c driver (Andy Shevchenko)

Changes in v3:
- s/it/they in the commit description (Geert Uytterhoeven)
- Drop unnecessary blank line (Geert Uytterhoeven)
- Export variants array and use &info[ID] in device table (Andy Shevchenko)

Changes in v2:
- Drop ssd13x_variant_to_info() and just use the array index (Neil Armstrong).

 drivers/gpu/drm/solomon/ssd130x-i2c.c | 52 ++++++---------------------
 drivers/gpu/drm/solomon/ssd130x.c     | 35 ++++++++++++++++--
 drivers/gpu/drm/solomon/ssd130x.h     | 14 ++++++++
 3 files changed, 56 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
index 45867ef2bc8b..d6835ec71c39 100644
--- a/drivers/gpu/drm/solomon/ssd130x-i2c.c
+++ b/drivers/gpu/drm/solomon/ssd130x-i2c.c
@@ -53,76 +53,43 @@ static void ssd130x_i2c_shutdown(struct i2c_client *client)
 	ssd130x_shutdown(ssd130x);
 }
 
-static struct ssd130x_deviceinfo ssd130x_sh1106_deviceinfo = {
-	.default_vcomh = 0x40,
-	.default_dclk_div = 1,
-	.default_dclk_frq = 5,
-	.page_mode_only = 1,
-};
-
-static struct ssd130x_deviceinfo ssd130x_ssd1305_deviceinfo = {
-	.default_vcomh = 0x34,
-	.default_dclk_div = 1,
-	.default_dclk_frq = 7,
-};
-
-static struct ssd130x_deviceinfo ssd130x_ssd1306_deviceinfo = {
-	.default_vcomh = 0x20,
-	.default_dclk_div = 1,
-	.default_dclk_frq = 8,
-	.need_chargepump = 1,
-};
-
-static struct ssd130x_deviceinfo ssd130x_ssd1307_deviceinfo = {
-	.default_vcomh = 0x20,
-	.default_dclk_div = 2,
-	.default_dclk_frq = 12,
-	.need_pwm = 1,
-};
-
-static struct ssd130x_deviceinfo ssd130x_ssd1309_deviceinfo = {
-	.default_vcomh = 0x34,
-	.default_dclk_div = 1,
-	.default_dclk_frq = 10,
-};
-
 static const struct of_device_id ssd130x_of_match[] = {
 	{
 		.compatible = "sinowealth,sh1106",
-		.data = &ssd130x_sh1106_deviceinfo,
+		.data = &ssd130x_variants[SH1106_ID],
 	},
 	{
 		.compatible = "solomon,ssd1305",
-		.data = &ssd130x_ssd1305_deviceinfo,
+		.data = &ssd130x_variants[SSD1305_ID],
 	},
 	{
 		.compatible = "solomon,ssd1306",
-		.data = &ssd130x_ssd1306_deviceinfo,
+		.data = &ssd130x_variants[SSD1306_ID],
 	},
 	{
 		.compatible = "solomon,ssd1307",
-		.data = &ssd130x_ssd1307_deviceinfo,
+		.data = &ssd130x_variants[SSD1307_ID],
 	},
 	{
 		.compatible = "solomon,ssd1309",
-		.data = &ssd130x_ssd1309_deviceinfo,
+		.data = &ssd130x_variants[SSD1309_ID],
 	},
 	/* Deprecated but kept for backward compatibility */
 	{
 		.compatible = "solomon,ssd1305fb-i2c",
-		.data = &ssd130x_ssd1305_deviceinfo,
+		.data = &ssd130x_variants[SSD1305_ID],
 	},
 	{
 		.compatible = "solomon,ssd1306fb-i2c",
-		.data = &ssd130x_ssd1306_deviceinfo,
+		.data = &ssd130x_variants[SSD1306_ID],
 	},
 	{
 		.compatible = "solomon,ssd1307fb-i2c",
-		.data = &ssd130x_ssd1307_deviceinfo,
+		.data = &ssd130x_variants[SSD1307_ID],
 	},
 	{
 		.compatible = "solomon,ssd1309fb-i2c",
-		.data = &ssd130x_ssd1309_deviceinfo,
+		.data = &ssd130x_variants[SSD1309_ID],
 	},
 	{ /* sentinel */ }
 };
@@ -142,3 +109,4 @@ module_i2c_driver(ssd130x_i2c_driver);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_AUTHOR("Javier Martinez Canillas <javierm@redhat.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(DRM_SSD130X);
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index a7e784518c69..ba2de93d00f0 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -39,9 +39,6 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
-#define SSD130X_DATA				0x40
-#define SSD130X_COMMAND				0x80
-
 #define SSD130X_PAGE_COL_START_LOW		0x00
 #define SSD130X_PAGE_COL_START_HIGH		0x10
 #define SSD130X_SET_ADDRESS_MODE		0x20
@@ -94,6 +91,38 @@
 
 #define MAX_CONTRAST 255
 
+const struct ssd130x_deviceinfo ssd130x_variants[] = {
+	[SH1106_ID] = {
+		.default_vcomh = 0x40,
+		.default_dclk_div = 1,
+		.default_dclk_frq = 5,
+		.page_mode_only = 1,
+	},
+	[SSD1305_ID] = {
+		.default_vcomh = 0x34,
+		.default_dclk_div = 1,
+		.default_dclk_frq = 7,
+	},
+	[SSD1306_ID] = {
+		.default_vcomh = 0x20,
+		.default_dclk_div = 1,
+		.default_dclk_frq = 8,
+		.need_chargepump = 1,
+	},
+	[SSD1307_ID] = {
+		.default_vcomh = 0x20,
+		.default_dclk_div = 2,
+		.default_dclk_frq = 12,
+		.need_pwm = 1,
+	},
+	[SSD1309_ID] = {
+		.default_vcomh = 0x34,
+		.default_dclk_div = 1,
+		.default_dclk_frq = 10,
+	}
+};
+EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD130X);
+
 static inline struct ssd130x_device *drm_to_ssd130x(struct drm_device *drm)
 {
 	return container_of(drm, struct ssd130x_device, drm);
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index f5b062576fdf..d14f78c2eb07 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -18,6 +18,18 @@
 
 #include <linux/regmap.h>
 
+#define SSD130X_DATA				0x40
+#define SSD130X_COMMAND				0x80
+
+enum ssd130x_variants {
+	SH1106_ID,
+	SSD1305_ID,
+	SSD1306_ID,
+	SSD1307_ID,
+	SSD1309_ID,
+	NR_SSD130X_VARIANTS
+};
+
 struct ssd130x_deviceinfo {
 	u32 default_vcomh;
 	u32 default_dclk_div;
@@ -71,6 +83,8 @@ struct ssd130x_device {
 	u8 page_end;
 };
 
+extern const struct ssd130x_deviceinfo ssd130x_variants[];
+
 struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap);
 int ssd130x_remove(struct ssd130x_device *ssd130x);
 void ssd130x_shutdown(struct ssd130x_device *ssd130x);
-- 
2.35.1

