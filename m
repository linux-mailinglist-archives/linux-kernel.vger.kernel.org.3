Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A904F8866
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiDGUa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiDGUaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB0A42DBFF9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649362442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TE4gPpLf7WhkN5ezB0vCrjVorkv1sMpiSBwQ7irjd6Q=;
        b=iA9x1zYfJ0IKsX2BDpF0ws1BZJw/5CXcp54ozh+Bu5gnJKvAJUbBL2gpPDbcB2KVFYIVcf
        MH1OyMVQunuapHS5FDqhRvUXJvUG1r25Rchq2/rWwsthzaygcLZ9pOD6ljWhHrBVtftjsc
        fEEZQdqypTer8eDld3Rw140EHsVIwKc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-pLKSWdTbOsW-nzt0TzEk4g-1; Thu, 07 Apr 2022 16:03:04 -0400
X-MC-Unique: pLKSWdTbOsW-nzt0TzEk4g-1
Received: by mail-wr1-f70.google.com with SMTP id j67-20020adf9149000000b00203e6b7d151so1556125wrj.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TE4gPpLf7WhkN5ezB0vCrjVorkv1sMpiSBwQ7irjd6Q=;
        b=a7e06fU6NX2ySM7OwNqdIjgQk843Xn5qbFWckF5eFpAHcz/78OiGaMAOCNoZh8Hu8v
         LXTEPEij8WTJaBBP18S0eeJEE0sEGfiXYWp/u9/2nMOOM64lel1/GaBtGhtL3rGqmHq6
         3e3W1a0ElAYf+VwFBBlXFPoNfL70F4e81nWgwpV5KixbrvuCTo5vh2djZADPaOJi9eom
         aBBCtZ4NaUbWSIJf6PGppSA3zQXSL3rg1OuTQ3H2fLyjTN8TrhUBCiZL6jks28YFMv7+
         7BnW8vBGbbY094luLjXs9mGzk+ruQPMMlafmvu89GP6rDQAgOxN2xgfeRlIPd2TmAtC2
         2fXw==
X-Gm-Message-State: AOAM530YStotYEUSRejf56iCSfxFGH8xMBwhXWAAJr4d/XooCyWcbCmd
        QfAsz3nQ4k7nbQv2JVJ2/0xa3pW28gG7Ft3i+zpNZ6tlJ2r4JcSgtekgjkhIoXsieIJPRxAY/gk
        E4SOnF7fJjWqeYObqg9uVb4IgXhxajADDxI9yUzQrf8XeNc9F+spS0318hIb8Gpvc0unDTdqMvK
        0=
X-Received: by 2002:adf:9dd2:0:b0:206:14f9:6432 with SMTP id q18-20020adf9dd2000000b0020614f96432mr11931366wre.129.1649361783499;
        Thu, 07 Apr 2022 13:03:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqOZMuv7vlTxaNOa9uzsUAtJoY+v170aoJd1/4gM8Ev8wfF6xaGJEgCSZ0qspOkfmmAC/8pw==
X-Received: by 2002:adf:9dd2:0:b0:206:14f9:6432 with SMTP id q18-20020adf9dd2000000b0020614f96432mr11931343wre.129.1649361783111;
        Thu, 07 Apr 2022 13:03:03 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f15-20020a0560001a8f00b002078f74ccd2sm1048712wry.36.2022.04.07.13.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:03:02 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH 4/5] drm/solomon: Move device info from ssd130x-i2c to the core driver
Date:   Thu,  7 Apr 2022 22:02:03 +0200
Message-Id: <20220407200205.28838-5-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407200205.28838-1-javierm@redhat.com>
References: <20220407200205.28838-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are declared in the ssd130x-i2c transport driver but the information
is not I2C specific and could be used by other SSD130x transport drivers.

Move them to the ssd130x core driver and just set the OF device entries to
an ID that could be used to lookup the correct device into from an array.

While being there, also move the SSD130X_DATA and SSD130X_COMMAND control
bytes. Since even though are used by the I2C interface, it could also be
useful for other transport protocols such as SPI.

Suggested-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x-i2c.c | 51 ++++-------------------
 drivers/gpu/drm/solomon/ssd130x.c     | 60 +++++++++++++++++++++++++--
 drivers/gpu/drm/solomon/ssd130x.h     | 13 ++++++
 3 files changed, 78 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
index a469679548f8..aa6cc2cb54f9 100644
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
 		.compatible = "sinowealth,sh1106-i2c",
-		.data = &ssd130x_sh1106_deviceinfo,
+		.data = SH1106_ID,
 	},
 	{
 		.compatible = "solomon,ssd1305-i2c",
-		.data = &ssd130x_ssd1305_deviceinfo,
+		.data = (void *)SSD1305_ID,
 	},
 	{
 		.compatible = "solomon,ssd1306-i2c",
-		.data = &ssd130x_ssd1306_deviceinfo,
+		.data = (void *)SSD1306_ID,
 	},
 	{
 		.compatible = "solomon,ssd1307-i2c",
-		.data = &ssd130x_ssd1307_deviceinfo,
+		.data = (void *)SSD1307_ID,
 	},
 	{
 		.compatible = "solomon,ssd1309-i2c",
-		.data = &ssd130x_ssd1309_deviceinfo,
+		.data = (void *)SSD1309_ID,
 	},
 	/* Deprecated but remain for backward compatibility */
 	{
 		.compatible = "solomon,ssd1305fb-i2c",
-		.data = &ssd130x_ssd1305_deviceinfo,
+		.data = (void *)SSD1305_ID,
 	},
 	{
 		.compatible = "solomon,ssd1306fb-i2c",
-		.data = &ssd130x_ssd1306_deviceinfo,
+		.data = (void *)SSD1306_ID,
 	},
 	{
 		.compatible = "solomon,ssd1307fb-i2c",
-		.data = &ssd130x_ssd1307_deviceinfo,
+		.data = (void *)SSD1307_ID,
 	},
 	{
 		.compatible = "solomon,ssd1309fb-i2c",
-		.data = &ssd130x_ssd1309_deviceinfo,
+		.data = (void *)SSD1309_ID,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index a7e784518c69..1f00fd3c0023 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -39,11 +39,9 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
-#define SSD130X_DATA				0x40
-#define SSD130X_COMMAND				0x80
-
 #define SSD130X_PAGE_COL_START_LOW		0x00
 #define SSD130X_PAGE_COL_START_HIGH		0x10
+
 #define SSD130X_SET_ADDRESS_MODE		0x20
 #define SSD130X_SET_COL_RANGE			0x21
 #define SSD130X_SET_PAGE_RANGE			0x22
@@ -94,6 +92,55 @@
 
 #define MAX_CONTRAST 255
 
+static struct ssd130x_deviceinfo ssd130x_variants[] =  {
+	{
+		.default_vcomh = 0x40,
+		.default_dclk_div = 1,
+		.default_dclk_frq = 5,
+		.page_mode_only = 1,
+	},
+	{
+		.variant = SSD1305_ID,
+		.default_vcomh = 0x34,
+		.default_dclk_div = 1,
+		.default_dclk_frq = 7,
+	},
+	{
+		.variant = SSD1306_ID,
+		.default_vcomh = 0x20,
+		.default_dclk_div = 1,
+		.default_dclk_frq = 8,
+		.need_chargepump = 1,
+	},
+	{
+		.variant = SSD1307_ID,
+		.default_vcomh = 0x20,
+		.default_dclk_div = 2,
+		.default_dclk_frq = 12,
+		.need_pwm = 1,
+	},
+	{
+		.variant = SSD1309_ID,
+		.default_vcomh = 0x34,
+		.default_dclk_div = 1,
+		.default_dclk_frq = 10,
+	}
+};
+
+static const struct ssd130x_deviceinfo *ssd13x_variant_to_info(enum ssd130x_variants variant)
+{
+	int i;
+	const struct ssd130x_deviceinfo *info;
+
+	for (i = 0; i < ARRAY_SIZE(ssd130x_variants); i++) {
+		info = &ssd130x_variants[i];
+		if (info->variant == variant)
+			return info;
+	}
+
+	return NULL;
+}
+
 static inline struct ssd130x_device *drm_to_ssd130x(struct drm_device *drm)
 {
 	return container_of(drm, struct ssd130x_device, drm);
@@ -846,6 +893,7 @@ static int ssd130x_get_resources(struct ssd130x_device *ssd130x)
 struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 {
 	struct ssd130x_device *ssd130x;
+	enum ssd130x_variants variant;
 	struct backlight_device *bl;
 	struct drm_device *drm;
 	int ret;
@@ -860,7 +908,11 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 
 	ssd130x->dev = dev;
 	ssd130x->regmap = regmap;
-	ssd130x->device_info = device_get_match_data(dev);
+
+	variant = (enum ssd130x_variants)device_get_match_data(dev);
+	ssd130x->device_info = ssd13x_variant_to_info(variant);
+	if (!ssd130x->device_info)
+		return ERR_PTR(-EINVAL);
 
 	if (ssd130x->device_info->page_mode_only)
 		ssd130x->page_address_mode = 1;
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index f5b062576fdf..4e0b62a41aa3 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -18,7 +18,20 @@
 
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
+	enum ssd130x_variants variant;
 	u32 default_vcomh;
 	u32 default_dclk_div;
 	u32 default_dclk_frq;
-- 
2.35.1

