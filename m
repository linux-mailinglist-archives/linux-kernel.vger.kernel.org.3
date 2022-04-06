Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA44F6A6B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiDFTvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiDFTvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:51:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3E32EC4E9;
        Wed,  6 Apr 2022 10:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBF8D61A97;
        Wed,  6 Apr 2022 17:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208BDC385A6;
        Wed,  6 Apr 2022 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649266214;
        bh=kx10uHVY26ckRcwECa6MjiojP3WVqmzi3kWJLSQqtFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxMu4PutC4dDwqhZ7SdiV574Mh98fdV2T7xjh1ZMn2asjOlRuzgcxrKM5sa7MyZ0t
         6Ryd5qnGeLctycurtIWYVw4syI44r7/LvstlLMyLFcuqnK/RgdvPckSoWqICwv6C1i
         MurZ2xprNeX1erhNowmi/F2GlbWYDNycdSutRMK7a2rj5LtWIi2Au6P+PXwrNRu8Ns
         +sQANeuu6FHNROn/HWmXfTI8NdXtQg/sf95W8tNjnNuKcVeYhrEmoMVGDds+2bf4Ey
         CLQRgUoI0JwoQ9KuL7tM/j1CAG02pXcT8ZEb08F5tVgymxAgwjYl4SagarEde3MvYe
         x+W9vuCaxmYFA==
Received: by wens.tw (Postfix, from userid 1000)
        id 58CDF5FD30; Thu,  7 Apr 2022 01:30:11 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] drm/ssd130x: Support page addressing mode
Date:   Thu,  7 Apr 2022 01:29:55 +0800
Message-Id: <20220406172956.3953-4-wens@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220406172956.3953-1-wens@kernel.org>
References: <20220406172956.3953-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

On the SINO WEALTH SH1106, which is mostly compatible with the SSD1306,
only the basic page addressing mode is supported. This addressing mode
is not as easy to use compared to the currently supported horizontal
addressing mode, as the page address has to be set prior to writing
out each page, and each page must be written out separately as a result.
Also, there is no way to force the column address to wrap around early,
thus the column address must also be reset for each page to be accurate.

Add support for this addressing mode, with a flag to choose it. This
flag is designed to be set from the device info data structure, but
can be extended to be explicitly forced on through a device tree
property if such a need arises.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 73 ++++++++++++++++++++++++++++---
 drivers/gpu/drm/solomon/ssd130x.h |  2 +
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 38b6c2c14f53..a7e784518c69 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -42,6 +42,8 @@
 #define SSD130X_DATA				0x40
 #define SSD130X_COMMAND				0x80
 
+#define SSD130X_PAGE_COL_START_LOW		0x00
+#define SSD130X_PAGE_COL_START_HIGH		0x10
 #define SSD130X_SET_ADDRESS_MODE		0x20
 #define SSD130X_SET_COL_RANGE			0x21
 #define SSD130X_SET_PAGE_RANGE			0x22
@@ -61,6 +63,11 @@
 #define SSD130X_SET_COM_PINS_CONFIG		0xda
 #define SSD130X_SET_VCOMH			0xdb
 
+#define SSD130X_PAGE_COL_START_MASK		GENMASK(3, 0)
+#define SSD130X_PAGE_COL_START_HIGH_SET(val)	FIELD_PREP(SSD130X_PAGE_COL_START_MASK, (val) >> 4)
+#define SSD130X_PAGE_COL_START_LOW_SET(val)	FIELD_PREP(SSD130X_PAGE_COL_START_MASK, (val))
+#define SSD130X_START_PAGE_ADDRESS_MASK		GENMASK(2, 0)
+#define SSD130X_START_PAGE_ADDRESS_SET(val)	FIELD_PREP(SSD130X_START_PAGE_ADDRESS_MASK, (val))
 #define SSD130X_SET_SEG_REMAP_MASK		GENMASK(0, 0)
 #define SSD130X_SET_SEG_REMAP_SET(val)		FIELD_PREP(SSD130X_SET_SEG_REMAP_MASK, (val))
 #define SSD130X_SET_COM_SCAN_DIR_MASK		GENMASK(3, 3)
@@ -130,6 +137,7 @@ static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
 	return ret;
 }
 
+/* Set address range for horizontal/vertical addressing modes */
 static int ssd130x_set_col_range(struct ssd130x_device *ssd130x,
 				 u8 col_start, u8 cols)
 {
@@ -166,6 +174,26 @@ static int ssd130x_set_page_range(struct ssd130x_device *ssd130x,
 	return 0;
 }
 
+/* Set page and column start address for page addressing mode */
+static int ssd130x_set_page_pos(struct ssd130x_device *ssd130x,
+				u8 page_start, u8 col_start)
+{
+	int ret;
+	u32 page, col_low, col_high;
+
+	page = SSD130X_START_PAGE_ADDRESS |
+	       SSD130X_START_PAGE_ADDRESS_SET(page_start);
+	col_low = SSD130X_PAGE_COL_START_LOW |
+		  SSD130X_PAGE_COL_START_LOW_SET(col_start);
+	col_high = SSD130X_PAGE_COL_START_HIGH |
+		   SSD130X_PAGE_COL_START_HIGH_SET(col_start);
+	ret = ssd130x_write_cmd(ssd130x, 3, page, col_low, col_high);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int ssd130x_pwm_enable(struct ssd130x_device *ssd130x)
 {
 	struct device *dev = ssd130x->dev;
@@ -342,6 +370,11 @@ static int ssd130x_init(struct ssd130x_device *ssd130x)
 		}
 	}
 
+	/* Switch to page addressing mode */
+	if (ssd130x->page_address_mode)
+		return ssd130x_write_cmd(ssd130x, 2, SSD130X_SET_ADDRESS_MODE,
+					 SSD130X_SET_ADDRESS_MODE_PAGE);
+
 	/* Switch to horizontal addressing mode */
 	return ssd130x_write_cmd(ssd130x, 2, SSD130X_SET_ADDRESS_MODE,
 				 SSD130X_SET_ADDRESS_MODE_HORIZONTAL);
@@ -396,13 +429,16 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x, u8 *buf,
 	 *  (5) A4 B4 C4 D4 E4 F4 G4 H4
 	 */
 
-	ret = ssd130x_set_col_range(ssd130x, ssd130x->col_offset + x, width);
-	if (ret < 0)
-		goto out_free;
+	if (!ssd130x->page_address_mode) {
+		/* Set address range for horizontal addressing mode */
+		ret = ssd130x_set_col_range(ssd130x, ssd130x->col_offset + x, width);
+		if (ret < 0)
+			goto out_free;
 
-	ret = ssd130x_set_page_range(ssd130x, ssd130x->page_offset + y / 8, pages);
-	if (ret < 0)
-		goto out_free;
+		ret = ssd130x_set_page_range(ssd130x, ssd130x->page_offset + y / 8, pages);
+		if (ret < 0)
+			goto out_free;
+	}
 
 	for (i = 0; i < pages; i++) {
 		int m = 8;
@@ -421,9 +457,29 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x, u8 *buf,
 			}
 			data_array[array_idx++] = data;
 		}
+
+		/*
+		 * In page addressing mode, the start address needs to be reset,
+		 * and each page then needs to be written out separately.
+		 */
+		if (ssd130x->page_address_mode) {
+			ret = ssd130x_set_page_pos(ssd130x,
+						   ssd130x->page_offset + i,
+						   ssd130x->col_offset + x);
+			if (ret < 0)
+				goto out_free;
+
+			ret = ssd130x_write_data(ssd130x, data_array, width);
+			if (ret < 0)
+				goto out_free;
+
+			array_idx = 0;
+		}
 	}
 
-	ret = ssd130x_write_data(ssd130x, data_array, width * pages);
+	/* Write out update in one go if we aren't using page addressing mode */
+	if (!ssd130x->page_address_mode)
+		ret = ssd130x_write_data(ssd130x, data_array, width * pages);
 
 out_free:
 	kfree(data_array);
@@ -806,6 +862,9 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 	ssd130x->regmap = regmap;
 	ssd130x->device_info = device_get_match_data(dev);
 
+	if (ssd130x->device_info->page_mode_only)
+		ssd130x->page_address_mode = 1;
+
 	ssd130x_parse_properties(ssd130x);
 
 	ret = ssd130x_get_resources(ssd130x);
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index cd21cdccb566..f5b062576fdf 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -24,6 +24,7 @@ struct ssd130x_deviceinfo {
 	u32 default_dclk_frq;
 	int need_pwm;
 	int need_chargepump;
+	bool page_mode_only;
 };
 
 struct ssd130x_device {
@@ -38,6 +39,7 @@ struct ssd130x_device {
 
 	const struct ssd130x_deviceinfo *device_info;
 
+	unsigned page_address_mode : 1;
 	unsigned area_color_enable : 1;
 	unsigned com_invdir : 1;
 	unsigned com_lrremap : 1;
-- 
2.34.1

