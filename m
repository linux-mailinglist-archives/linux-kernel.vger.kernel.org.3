Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DDB4FE346
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356649AbiDLN6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356561AbiDLN6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:58:07 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EF2F51;
        Tue, 12 Apr 2022 06:55:49 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e22so22309930ioe.11;
        Tue, 12 Apr 2022 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dsEjLgvTaSnJWB0qaHEaU7KaeVze6U1DoRRKehYbw4I=;
        b=EpCGAJdbnJSAP3mcFMIgp0gM/CzioJACPjZshjTi4vmru4ciSmQtESmIdyJkH1RxBL
         WXyJ0dvOzc69IinOb/3/LpEnG8zbYWceeKDcGuOReh4XqXf2OKIQBPJkV+ltT/qfC+qK
         qFswdp+pBK9043p7hCsGclNSm7zsVgkaywgH72qCBkSPeYDRSPFojSJlVq375DQkgRse
         cCrcS6TEEAFqLwf9828xlRtHylk/LbIavVWh9qgQLNpuijau9hqsmkWiFM5uoivqM9H3
         rGNvklr+5Wc2Rz0zlwUXRmpP+qTGGLD0S9tYvb2btfJ58qYXH+Ot7gy7Z//vQ8jR9GIj
         uNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dsEjLgvTaSnJWB0qaHEaU7KaeVze6U1DoRRKehYbw4I=;
        b=JQGcnEQmGAwDp4+7zK6yj7OrTSXg+Qv0IjjGja21WgZ38iAwBDFuEihBitO2ha0OsB
         6TV3zvbIoUP6HtSMsbTyrBfL3Taz3K4gxMddNoI7ujtIV1u+UPwhiFDRnT84Ii0vy+0D
         Nx09pVw4H1StXGieI7qU0Mv/UkMikk0PRVwJAOWt4EzYOjQR+EWNbofeyDfbsFGBQZNC
         zV2ewRq/47eVbxDbYP5G3QGq4ZOeTO+4GCcqMg2qoDIBCx7WxYnJ8G0WPoiP7MV9JTqv
         d967ShAydb/qpXdX3jQgO0H67AIeb7zwIVqqsio7QM8nh2WGOqyk24Q2ay5Q3mEtk0EE
         E7Xw==
X-Gm-Message-State: AOAM532+nuY3gB9CBuM60yd19WZvcLjPTtfoAWgptI8OqVw8kSUvmRz/
        kmog0yyLQQq+VKMfXompT6pthkP8/zWczw==
X-Google-Smtp-Source: ABdhPJzQiDj980Uywa9g5DatCrWtmN2Guk7U5Sn5Ec5jtD1hNewqjrmQ8R1mSKrXK1dbyH3o9GQgrg==
X-Received: by 2002:a05:6638:22c5:b0:326:2b3a:b08b with SMTP id j5-20020a05663822c500b003262b3ab08bmr6534540jat.250.1649771748824;
        Tue, 12 Apr 2022 06:55:48 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2611:a7ae:f1c9:5ec2])
        by smtp.gmail.com with ESMTPSA id n12-20020a92dd0c000000b002cac22690b6sm2280748ilm.0.2022.04.12.06.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 06:55:48 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, tharvey@gateworks.com,
        cstevens@beaconembedded.com, aford@beaconembedded.com,
        laurent.pinchart@ideasonboard.com, Adam Ford <aford173@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] media: i2c: imx219: Enable variable XCLK
Date:   Tue, 12 Apr 2022 08:55:32 -0500
Message-Id: <20220412135534.2796158-4-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220412135534.2796158-1-aford173@gmail.com>
References: <20220412135534.2796158-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet shows the external clock can be anything
from 6MHz to 27MHz, but EXCK, PREPLLCK_VT_DIV and
PREPLLCK_OP_DIV need to change based on the clock, so
create helper functions to set these registers based on
the rate of xclk.

Move the validation of the clock rate into imx219_check_hwcfg
which means delaying the call to it until after xclk has been
determined.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/media/i2c/imx219.c | 79 ++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 16 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index d13ce5c1ece6..08e7d0e72430 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -39,8 +39,12 @@
 #define IMX219_REG_CHIP_ID		0x0000
 #define IMX219_CHIP_ID			0x0219
 
-/* External clock frequency is 24.0M */
-#define IMX219_XCLK_FREQ		24000000
+/* Default external clock frequency is 24.0M */
+#define IMX219_XCLK_MIN_FREQ		6000000
+#define IMX219_XCLK_MAX_FREQ		27000000
+#define IMX219_REG_EXCK			0x012a
+#define IMX219_REG_PREPLLCK_VT_DIV	0x0304
+#define IMX219_REG_PREPLLCK_OP_DIV	0x0305
 
 /* Pixel rate is fixed for all the modes */
 #define IMX219_PIXEL_RATE		182400000
@@ -166,8 +170,6 @@ static const struct imx219_reg pll_clk_table[] = {
 
 	{0x0301, 0x05},	/* VTPXCK_DIV */
 	{0x0303, 0x01},	/* VTSYSCK_DIV */
-	{0x0304, 0x03},	/* PREPLLCK_VT_DIV 0x03 = AUTO set */
-	{0x0305, 0x03}, /* PREPLLCK_OP_DIV 0x03 = AUTO set */
 	{0x0306, 0x00},	/* PLL_VT_MPY */
 	{0x0307, 0x39},
 	{0x030b, 0x01},	/* OP_SYS_CLK_DIV */
@@ -182,7 +184,6 @@ static const struct imx219_reg pll_clk_table[] = {
  */
 static const struct imx219_reg mode_3280x2464_regs[] = {
 	{0x0128, 0x00},
-	{0x012a, 0x18},
 	{0x012b, 0x00},
 	{0x0164, 0x00},
 	{0x0165, 0x00},
@@ -222,7 +223,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
 
 static const struct imx219_reg mode_1920_1080_regs[] = {
 	{0x0128, 0x00},
-	{0x012a, 0x18},
 	{0x012b, 0x00},
 	{0x0162, 0x0d},
 	{0x0163, 0x78},
@@ -262,7 +262,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
 
 static const struct imx219_reg mode_1640_1232_regs[] = {
 	{0x0128, 0x00},
-	{0x012a, 0x18},
 	{0x012b, 0x00},
 	{0x0164, 0x00},
 	{0x0165, 0x00},
@@ -302,7 +301,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
 
 static const struct imx219_reg mode_640_480_regs[] = {
 	{0x0128, 0x00},
-	{0x012a, 0x18},
 	{0x012b, 0x00},
 	{0x0162, 0x0d},
 	{0x0163, 0x78},
@@ -1015,6 +1013,50 @@ static int imx219_configure_lanes(struct imx219 *imx219)
 	return ret;
 };
 
+static int imx219_set_exck_freq(struct imx219 *imx219)
+{
+	int ret;
+	/* The imx219 registers need MHz not Hz */
+	u8 clk = (u8) (imx219->xclk_freq/1000000U);
+
+	/* Set the clock frequency in MHz */
+	ret = imx219_write_reg(imx219, IMX219_REG_EXCK,
+			       IMX219_REG_VALUE_08BIT, clk);
+
+	/* Configure the PREPLLCK_VT_DIV and PREPLLCK_OP_DIV for automatic */
+	switch (clk) {
+	case 6 ... 11:
+		ret = imx219_write_reg(imx219, IMX219_REG_PREPLLCK_VT_DIV,
+			       IMX219_REG_VALUE_08BIT, 0x01);
+		if (ret)
+			return ret;
+		ret = imx219_write_reg(imx219, IMX219_REG_PREPLLCK_OP_DIV,
+			       IMX219_REG_VALUE_08BIT, 0x01);
+		return ret;
+	case 12 ... 23:
+		ret = imx219_write_reg(imx219, IMX219_REG_PREPLLCK_VT_DIV,
+			       IMX219_REG_VALUE_08BIT, 0x02);
+		if (ret)
+			return ret;
+
+		ret = imx219_write_reg(imx219, IMX219_REG_PREPLLCK_OP_DIV,
+			       IMX219_REG_VALUE_08BIT, 0x02);
+
+		return ret;
+	case 24 ... 27:
+		ret = imx219_write_reg(imx219, IMX219_REG_PREPLLCK_VT_DIV,
+			       IMX219_REG_VALUE_08BIT, 0x03);
+		if (ret)
+			return ret;
+		ret = imx219_write_reg(imx219, IMX219_REG_PREPLLCK_OP_DIV,
+			       IMX219_REG_VALUE_08BIT, 0x03);
+		return ret;
+	default:
+		/* Should never get here */
+		return -EINVAL;
+	}
+}
+
 static int imx219_start_streaming(struct imx219 *imx219)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
@@ -1039,6 +1081,9 @@ static int imx219_start_streaming(struct imx219 *imx219)
 		goto err_rpm_put;
 	}
 
+	/* Configure clock based on reference clock frequency */
+	imx219_set_exck_freq(imx219);
+
 	/* Apply default values of current mode */
 	reg_list = &imx219->mode->reg_list;
 	ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
@@ -1428,6 +1473,13 @@ static int imx219_check_hwcfg(struct imx219 *imx219)
 		return -EINVAL;
 	}
 
+	if ((imx219->xclk_freq < IMX219_XCLK_MIN_FREQ) ||
+	     imx219->xclk_freq > IMX219_XCLK_MAX_FREQ) {
+		dev_err(&client->dev, "xclk frequency not supported: %d Hz\n",
+			imx219->xclk_freq);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1478,10 +1530,6 @@ static int imx219_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	/* Check the hardware configuration in device tree */
-	if (imx219_check_hwcfg(imx219))
-		return -EINVAL;
-
 	/* Get system clock (xclk) */
 	imx219->xclk = devm_clk_get(dev, NULL);
 	if (IS_ERR(imx219->xclk)) {
@@ -1490,11 +1538,10 @@ static int imx219_probe(struct i2c_client *client)
 	}
 
 	imx219->xclk_freq = clk_get_rate(imx219->xclk);
-	if (imx219->xclk_freq != IMX219_XCLK_FREQ) {
-		dev_err(dev, "xclk frequency not supported: %d Hz\n",
-			imx219->xclk_freq);
+
+	/* Check the hardware configuration in device tree */
+	if (imx219_check_hwcfg(imx219))
 		return -EINVAL;
-	}
 
 	ret = imx219_get_regulators(imx219);
 	if (ret) {
-- 
2.34.1

