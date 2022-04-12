Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695B84FE339
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356705AbiDLN6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356573AbiDLN6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:58:09 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838A05F95;
        Tue, 12 Apr 2022 06:55:51 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id q11so22336796iod.6;
        Tue, 12 Apr 2022 06:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=res6PbBmwf6ry1dEgNl1r8RYqBrRnpwX5BOzecykxas=;
        b=Ps6za+nMoQaBSvb6viYugVvoRA/60HSnxsK3qMBlFLUnEl6M6gph66pVygyMMzBpCc
         DMT0EQhS5GoXcCV3H2/h1sgY477lqD+DomBPfRGXoS+1eBAUF3Q1Bvv2sqnPn64Nyzou
         X1S9zjzXHjT3ycEUX0E5H7abZtvm2HMgED0xpJ6n0r942FemdlsdZpprGYCZRG3+0NGW
         PqXRHG3T5+VvjrCAa46BeA7TbiFiDYtfl9zeEtqjH0dpg6UcBIiHXBhlLolVc8VdYiE9
         jpD8PF7yHbgu55nsvEh18/GbCUOQ54pzXDSw11p1Mn6I/NH98n1k9Pdugu1ivmq5LiGW
         VGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=res6PbBmwf6ry1dEgNl1r8RYqBrRnpwX5BOzecykxas=;
        b=RbISeua+zTbJL1nOIlJbwcF8QWOvGsGJHSXWPp7Lq694lvMau5ATLaDZT0WRG816WJ
         cgigUb58Y1zaNY+QA+b/amOLQsA9k++BAdqwsQmpm6tkgK1ykqLcKfnmaF2JIjI/6y5Q
         uW3SzaAfg6oLlaij2Jkdkxo4kVxFIKF2vy8C3epq+Bguv8K6ADZsT57vlFmZZi0qmOKI
         ukWaqicBQQqeyWiuKR8BvlkqXqR3M4F+m3mLtmw7CxRX0Wyz25qxIxwKUF8I0r7X+YKJ
         2+KWmx63TwOZ40LXsDjmQXoe/3Kf0H+nEy6TsAzIQUpn5KGqBL+TLS2DDCgLtVpRUpoI
         TnHw==
X-Gm-Message-State: AOAM530IB5UJ6gmUdNv2+tir/60k+d5zvrQjqnmu1pYwaa3u4qdEfQzx
        fp0m60KqRvuCi5es4tqe1I8uR8AHz1eb8Q==
X-Google-Smtp-Source: ABdhPJyvqo3RbUH2Dh/5IQVqyLFzlDj0YKtLF8usD1wyAdbMOH8tGamWYqkS3u4m3htyBtgIyj8r/A==
X-Received: by 2002:a05:6638:3e92:b0:326:2d62:5197 with SMTP id ch18-20020a0566383e9200b003262d625197mr5381665jab.132.1649771750531;
        Tue, 12 Apr 2022 06:55:50 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2611:a7ae:f1c9:5ec2])
        by smtp.gmail.com with ESMTPSA id n12-20020a92dd0c000000b002cac22690b6sm2280748ilm.0.2022.04.12.06.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 06:55:49 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, tharvey@gateworks.com,
        cstevens@beaconembedded.com, aford@beaconembedded.com,
        laurent.pinchart@ideasonboard.com, Adam Ford <aford173@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] media: i2c: imx219: Create DPHY helper function
Date:   Tue, 12 Apr 2022 08:55:33 -0500
Message-Id: <20220412135534.2796158-5-aford173@gmail.com>
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

In the table of modes, each mode sets the DPHY to auto.
Create a helper function which does the same thing while
removing the entry for auto DPHY from ever mode entry.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/media/i2c/imx219.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 08e7d0e72430..bb0bc1b8d91c 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -35,6 +35,10 @@
 #define IMX219_MODE_STANDBY		0x00
 #define IMX219_MODE_STREAMING		0x01
 
+
+#define IMX219_REG_DPHY_CTRL		0x0128
+#define IMX219_DPHY_AUTO		0
+
 /* Chip ID */
 #define IMX219_REG_CHIP_ID		0x0000
 #define IMX219_CHIP_ID			0x0219
@@ -183,7 +187,6 @@ static const struct imx219_reg pll_clk_table[] = {
  * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
  */
 static const struct imx219_reg mode_3280x2464_regs[] = {
-	{0x0128, 0x00},
 	{0x012b, 0x00},
 	{0x0164, 0x00},
 	{0x0165, 0x00},
@@ -222,7 +225,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
 };
 
 static const struct imx219_reg mode_1920_1080_regs[] = {
-	{0x0128, 0x00},
 	{0x012b, 0x00},
 	{0x0162, 0x0d},
 	{0x0163, 0x78},
@@ -261,7 +263,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
 };
 
 static const struct imx219_reg mode_1640_1232_regs[] = {
-	{0x0128, 0x00},
 	{0x012b, 0x00},
 	{0x0164, 0x00},
 	{0x0165, 0x00},
@@ -300,7 +301,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
 };
 
 static const struct imx219_reg mode_640_480_regs[] = {
-	{0x0128, 0x00},
 	{0x012b, 0x00},
 	{0x0162, 0x0d},
 	{0x0163, 0x78},
@@ -999,6 +999,15 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
 	return -EINVAL;
 }
 
+static int imx219_enable_dphy(struct imx219 *imx219, u8 mode)
+{
+	int ret;
+
+	ret = imx219_write_reg(imx219, IMX219_REG_DPHY_CTRL,
+			       IMX219_REG_VALUE_08BIT, mode);
+	return ret;
+};
+
 static int imx219_configure_lanes(struct imx219 *imx219)
 {
 	int ret;
@@ -1081,6 +1090,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
 		goto err_rpm_put;
 	}
 
+	/* Setup DPHY */
+	ret = imx219_enable_dphy(imx219, IMX219_DPHY_AUTO);
+	if (ret) {
+		dev_err(&client->dev, "%s failed to configure dphy\n", __func__);
+		goto err_rpm_put;
+	}
+
 	/* Configure clock based on reference clock frequency */
 	imx219_set_exck_freq(imx219);
 
-- 
2.34.1

