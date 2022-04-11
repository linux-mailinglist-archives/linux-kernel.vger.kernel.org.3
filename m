Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3CF4FC686
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350115AbiDKVPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348615AbiDKVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90F6828989
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649711576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jEFGMcteZ+nA9cu4YEj6hFyYlLNIHH/8HV43Q6c+F0=;
        b=MwZlybIjMaixpGte644tSMW0qc2VXYsjeqH2lhsZIH14mO/gnhN+AA9A7MKUqYG71W5mwD
        RYAUfqIPFvv+g5WbpbLn/dSM0vxfdd8aoeRsDGk/yy4tGlwDJwGNJfRxeIt7oN9k05ycv4
        Yxh2/axAlywzKqVARiQAZJ8KTVUZhTw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-M1YzHCEIOiCI_cy-Cgl2fw-1; Mon, 11 Apr 2022 17:12:55 -0400
X-MC-Unique: M1YzHCEIOiCI_cy-Cgl2fw-1
Received: by mail-wm1-f70.google.com with SMTP id l41-20020a05600c1d2900b0038ec007ac7fso207257wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jEFGMcteZ+nA9cu4YEj6hFyYlLNIHH/8HV43Q6c+F0=;
        b=A01/m43fjRws6DCyOwmOYSo6CiKInCPYok/nivOphma8T9bFaOWGFjzoQLAPHroUAK
         h+A09HkvYoY8RVHSHkLrShdG1IDfXfRCYFTkD5E984vAhADEsOj8TCog1k007CiUvX9U
         QsHNyHtvUaHo/WgwPzaB00rNNHiSk1eI3rAqnBToN8+p0qnaMvKtvW2l9gxbUC1DfkqV
         xkaYiSt54BpHa/HEgcfmtcuMvUdGyXbdku9Lwo3EcKZyEwdoypa9Eu9zZGk5GlaIdTff
         oHscXboRAZpoljVN9mfwXZqDiPrcAoZ2WdHQ0fmWt6LaTwBj2nSDKDR9QmZfm3LnaD1v
         OsPQ==
X-Gm-Message-State: AOAM531mx74vmhB+4SNFUgwgMr55bxmCWpmRXsepeghbuyawspEKz4Td
        0AuDv2ItXbRIv9jf4QiV6wvFOYnWATRlqphFDKZVH38rGOT7QGzHRt8vUr9c1pzwYRdIf9IjoYJ
        uV/UmafosiYWrpywMJW80he2Ln0JjBIVZxnGjCfSnBRRIGEpAGnzonyxvs8F2kbp89kUjtwfvdx
        M=
X-Received: by 2002:a5d:6d0e:0:b0:207:8ecd:2dbf with SMTP id e14-20020a5d6d0e000000b002078ecd2dbfmr16797892wrq.660.1649711574164;
        Mon, 11 Apr 2022 14:12:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTmfCgkAAd79bXAApXOp928kNiObmsrvzqdhHe087nR1AzkXYxJTev+H7I9+izveEH7z5uMA==
X-Received: by 2002:a5d:6d0e:0:b0:207:8ecd:2dbf with SMTP id e14-20020a5d6d0e000000b002078ecd2dbfmr16797873wrq.660.1649711573895;
        Mon, 11 Apr 2022 14:12:53 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d6d89000000b00203d62072c4sm28723722wrs.43.2022.04.11.14.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:12:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v2 4/5] drm/solomon: Move device info from ssd130x-i2c to the core driver
Date:   Mon, 11 Apr 2022 23:12:42 +0200
Message-Id: <20220411211243.11121-5-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411211243.11121-1-javierm@redhat.com>
References: <20220411211243.11121-1-javierm@redhat.com>
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
is not I2C specific, and could be used by other SSD130x transport drivers.

Move them to the ssd130x core driver and just set the OF device entries to
an ID that could be used to lookup the correct device info from an array.

While being there, also move the SSD130X_DATA and SSD130X_COMMAND control
bytes. Since even though are used by the I2C interface, it could also be
useful for other transport protocols such as SPI.

Suggested-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
---

Changes in v2:
- Drop ssd13x_variant_to_info() and just use the array index (Neil Armstrong).

 drivers/gpu/drm/solomon/ssd130x-i2c.c | 53 +++++----------------------
 drivers/gpu/drm/solomon/ssd130x.c     | 45 +++++++++++++++++++++--
 drivers/gpu/drm/solomon/ssd130x.h     | 12 ++++++
 3 files changed, 63 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
index 87abe1fe31fc..8259b10db966 100644
--- a/drivers/gpu/drm/solomon/ssd130x-i2c.c
+++ b/drivers/gpu/drm/solomon/ssd130x-i2c.c
@@ -53,80 +53,47 @@ static void ssd130x_i2c_shutdown(struct i2c_client *client)
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
+		.data = (void *)SH1106_ID,
 	},
 	{
 		.compatible = "solomon,ssd1305",
-		.data = &ssd130x_ssd1305_deviceinfo,
+		.data = (void *)SSD1305_ID,
 	},
 	{
 		.compatible = "solomon,ssd1306",
-		.data = &ssd130x_ssd1306_deviceinfo,
+		.data = (void *)SSD1306_ID,
 	},
 	{
 		.compatible = "solomon,ssd1307",
-		.data = &ssd130x_ssd1307_deviceinfo,
+		.data = (void *)SSD1307_ID,
 	},
 	{
 		.compatible = "solomon,ssd1309",
-		.data = &ssd130x_ssd1309_deviceinfo,
+		.data = (void *)SSD1309_ID,
 	},
 	/* Deprecated but kept for backward compatibility */
 	{
 		.compatible = "sinowealth,sh1106-i2c",
-		.data = &ssd130x_sh1106_deviceinfo,
+		.data = (void *)SH1106_ID,
 	},
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
index a7e784518c69..7d5b43023213 100644
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
@@ -94,6 +92,37 @@
 
 #define MAX_CONTRAST 255
 
+static const struct ssd130x_deviceinfo ssd130x_variants[] = {
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
+
 static inline struct ssd130x_device *drm_to_ssd130x(struct drm_device *drm)
 {
 	return container_of(drm, struct ssd130x_device, drm);
@@ -846,6 +875,7 @@ static int ssd130x_get_resources(struct ssd130x_device *ssd130x)
 struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 {
 	struct ssd130x_device *ssd130x;
+	enum ssd130x_variants variant;
 	struct backlight_device *bl;
 	struct drm_device *drm;
 	int ret;
@@ -860,7 +890,14 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 
 	ssd130x->dev = dev;
 	ssd130x->regmap = regmap;
-	ssd130x->device_info = device_get_match_data(dev);
+
+	variant = (enum ssd130x_variants)device_get_match_data(dev);
+
+	if (variant >= NR_SSD130X_VARIANTS)
+		return ERR_PTR(dev_err_probe(dev, -EINVAL,
+					     "Invalid SSD130x variant\n"));
+
+	ssd130x->device_info = &ssd130x_variants[variant];
 
 	if (ssd130x->device_info->page_mode_only)
 		ssd130x->page_address_mode = 1;
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index f5b062576fdf..ec349239e945 100644
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
-- 
2.35.1

