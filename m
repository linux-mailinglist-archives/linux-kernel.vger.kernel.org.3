Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62184F6A99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiDFTzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiDFTx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:53:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D21F2EC515;
        Wed,  6 Apr 2022 10:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F256B824ED;
        Wed,  6 Apr 2022 17:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8CCC385A9;
        Wed,  6 Apr 2022 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649266214;
        bh=qYRpRNZs3OEzs4LYnyrIl0pJ6/CiB0ubdZRFp4cKc2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1GIxYa4XJqhh4t5X+qk8bnEhCoqrZCT3Hy+2nyY/58JCBw2nD6ELZAT1epDOzNIO
         TKuPQTJB/UMb1eyIDK9YON0FZzb+6rKmE0u7hm33p20E7b8QjNDTlBQhJujIIZh/Ob
         Oheaq9a6AcXhtQWuPL2UDHVkmCuCBYa59SfHC2+NOpS5mkS0S1SQDI7Slt0K+ChJLV
         XyeEPlRa6ipfRqycaWIj+vrBGy/iCXorIySwHi6GaBtx71PX7Zl96dgA692lqWcu7y
         ExRez1k+0K7hjt54f20KLFC8V16e3IpifHyW1WJhM9MX3bY5sPwAWyrU8b27Y61Rgq
         6SDMFMXz2gyXA==
Received: by wens.tw (Postfix, from userid 1000)
        id 633365FD3C; Thu,  7 Apr 2022 01:30:11 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/ssd130x: Add support for SINO WEALTH SH1106
Date:   Thu,  7 Apr 2022 01:29:56 +0800
Message-Id: <20220406172956.3953-5-wens@kernel.org>
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

The SINO WEALTH SH1106 is an OLED display driver that is somewhat
compatible with the SSD1306. It supports a slightly wider display,
at 132 instead of 128 pixels. The basic commands are the same, but
the SH1106 doesn't support the horizontal or vertical address modes.

Add support for this display driver. The default values for some of
the hardware settings are taken from the datasheet.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/solomon/Kconfig       |  9 +++++----
 drivers/gpu/drm/solomon/ssd130x-i2c.c | 11 +++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kconfig
index 6230369505c9..8c0a0c788385 100644
--- a/drivers/gpu/drm/solomon/Kconfig
+++ b/drivers/gpu/drm/solomon/Kconfig
@@ -5,9 +5,9 @@ config DRM_SSD130X
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
 	help
-	  DRM driver for the SSD1305, SSD1306, SSD1307 and SSD1309 Solomon
-	  OLED controllers. This is only for the core driver, a driver for
-	  the appropriate bus transport in your chip also must be selected.
+	  DRM driver for the SSD130x Solomon and SINO WEALTH SH110x OLED
+	  controllers. This is only for the core driver, a driver for the
+	  appropriate bus transport in your chip also must be selected.
 
 	  If M is selected the module will be called ssd130x.
 
@@ -16,6 +16,7 @@ config DRM_SSD130X_I2C
 	depends on DRM_SSD130X && I2C
 	select REGMAP_I2C
 	help
-	  Say Y here if the SSD130x OLED display is connected via I2C bus.
+	  Say Y here if the SSD130x or SH110x OLED display is connected via
+	  I2C bus.
 
 	  If M is selected the module will be called ssd130x-i2c.
diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
index 3126aeda4ced..d099b241dd3f 100644
--- a/drivers/gpu/drm/solomon/ssd130x-i2c.c
+++ b/drivers/gpu/drm/solomon/ssd130x-i2c.c
@@ -53,6 +53,13 @@ static void ssd130x_i2c_shutdown(struct i2c_client *client)
 	ssd130x_shutdown(ssd130x);
 }
 
+static struct ssd130x_deviceinfo ssd130x_sh1106_deviceinfo = {
+	.default_vcomh = 0x40,
+	.default_dclk_div = 1,
+	.default_dclk_frq = 5,
+	.page_mode_only = 1,
+};
+
 static struct ssd130x_deviceinfo ssd130x_ssd1305_deviceinfo = {
 	.default_vcomh = 0x34,
 	.default_dclk_div = 1,
@@ -80,6 +87,10 @@ static struct ssd130x_deviceinfo ssd130x_ssd1309_deviceinfo = {
 };
 
 static const struct of_device_id ssd130x_of_match[] = {
+	{
+		.compatible = "sinowealth,sh1106-i2c",
+		.data = &ssd130x_sh1106_deviceinfo,
+	},
 	{
 		.compatible = "solomon,ssd1305fb-i2c",
 		.data = &ssd130x_ssd1305_deviceinfo,
-- 
2.34.1

