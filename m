Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BC64FE5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357588AbiDLQau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357569AbiDLQaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D48ED5D5ED
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649780875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qHKa3ZaE0n6rBQ9YSS4vax+vsIDK3+3iyrOxfgB78w=;
        b=Y3BQ35HJJlcHBgj8dc9v4L0wzojdSxtCTWT46M4CA8Btjothu14aLFFhadZLcQNTnKP8vW
        PAa/XQP87L8ZkUGkPTp0ZYy8HQrJjTYoMpqOhY5qkJUqYeRBuE9tlEPN97D9gQtvVjCkXo
        lRzYQnNBbDlQN+4zWuqk75MMFG/Uiio=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-YwF-ivU5O7yoi6xujPKAug-1; Tue, 12 Apr 2022 12:27:54 -0400
X-MC-Unique: YwF-ivU5O7yoi6xujPKAug-1
Received: by mail-wm1-f69.google.com with SMTP id q25-20020a1ce919000000b0038ead791083so1478045wmc.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4qHKa3ZaE0n6rBQ9YSS4vax+vsIDK3+3iyrOxfgB78w=;
        b=WBuiPUeoDPKmLsH4ZXEnq0wXIZJMRKWFYO2saqBzDThnAG1waxMlW7geWI2VlkNusQ
         DTaOXEXmVi7OnwZ9SoQ15CsTitC+iUcbaABdD1UK2DZdigCe+7PtjAvpzQO16t7GBjJ9
         nhgIq6R/ykto2wuUq1DsNkUmpcbshsvkyB/WX7/sk4vzLxcOq2AUY9LzzHzfqsRWArPV
         7UO5L7MfyYyCX29LjPi1E/xxVIKLnEAQVOaFSPWhhG8AqpMXu62tkiYzhihVIkcL6Tbp
         HwZBUynpxMx/NSCP0+VJTU42zD7H4lEEQmKcypZAMC1HY7IsEJVhNGgELDSms/QV3GA6
         ajwQ==
X-Gm-Message-State: AOAM530tRnjPw6NkWjTOBZES1otQLT+gf4cAaVgenTbLw7KQsP2Jeghj
        ijCPHw9orKDsqT3CxfbfrX7Xn50PIrQvrPBGRw/7Y55gpjA752/P1FpE7NRvMcgvlgImvqYKO5+
        prkSq1gZ2Fp5lCGxYpA0Z71+HeeDpMlbP3OEH4LRsCh2z6gF1FPjiGSWvl/TAaqBDk6d0xPugfv
        k=
X-Received: by 2002:a05:600c:281:b0:38e:bc6e:5971 with SMTP id 1-20020a05600c028100b0038ebc6e5971mr4861385wmk.111.1649780872811;
        Tue, 12 Apr 2022 09:27:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQpDf/vKaz+nFjHprARrN0OuUEjxREzyZtfW6KM/URrKifXWZjC6q7NkGzTQjVmLslypRy6Q==
X-Received: by 2002:a05:600c:281:b0:38e:bc6e:5971 with SMTP id 1-20020a05600c028100b0038ebc6e5971mr4861351wmk.111.1649780872578;
        Tue, 12 Apr 2022 09:27:52 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d4888000000b00207a49fa6a1sm7700358wrq.81.2022.04.12.09.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 09:27:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v3 4/5] drm/solomon: Move device info from ssd130x-i2c to the core driver
Date:   Tue, 12 Apr 2022 18:27:28 +0200
Message-Id: <20220412162729.184783-5-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412162729.184783-1-javierm@redhat.com>
References: <20220412162729.184783-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v3:
- s/it/they in the commit description (Geert Uytterhoeven)
- Drop unnecessary blank line (Geert Uytterhoeven)
- Export variants array and use &info[ID] in device table (Andy Shevchenko)

Changes in v2:
- Drop ssd13x_variant_to_info() and just use the array index (Neil Armstrong).

 drivers/gpu/drm/solomon/ssd130x-i2c.c | 51 +++++----------------------
 drivers/gpu/drm/solomon/ssd130x.c     | 36 +++++++++++++++++--
 drivers/gpu/drm/solomon/ssd130x.h     | 14 ++++++++
 3 files changed, 56 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
index 45867ef2bc8b..13b0713e31ad 100644
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
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index a7e784518c69..c9b80ab8727b 100644
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
@@ -94,6 +92,38 @@
 
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
+EXPORT_SYMBOL_GPL(ssd130x_variants);
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

