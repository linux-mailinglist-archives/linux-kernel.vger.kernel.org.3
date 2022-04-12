Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CD14FE338
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356639AbiDLN61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356547AbiDLN6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:58:04 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949AE5F95;
        Tue, 12 Apr 2022 06:55:46 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id r11so13626994ila.1;
        Tue, 12 Apr 2022 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFygX3e7jf6/dIYH8/lrT+A75jVZH0A2pgBQWAXlxbw=;
        b=fj/affBQ8bmBfZ2qeG9uXS2pjNKW82Mcyb26Wfy2NltfalDzmUh3qXowxqbZMdwsi0
         xVDQDTAZkdR9z3MNaeOQyvHnBBfPMF50RlV9Z720F10CAmKZcwh9DY+aMKsJBV1Y2HTj
         VWDaJWmK7bF9sPxxaLWhY5faR1GCEZ6GG/XDF6+G6T+oz0u8vYlXy+4t77LCOXHZG33q
         PUmW/KHJT6LXxRqINtfeRCQuBRTRmVC6DSBJVBA3tTCZGsXa4j5QtNH6Pol6Yf+puCar
         LF+jU7CAbM+mpQuEMdKONE1ajmg2mPPjRwzAb9qVIA/fv8REUHqqklfd9QA0OzOdugj2
         Fz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFygX3e7jf6/dIYH8/lrT+A75jVZH0A2pgBQWAXlxbw=;
        b=AFC3srrae4kNHbAjVkSMxEL/z/oxKLD2oFOFk4Z4OkAK02Njps9uo/ryCk/18RSifq
         l53mIYQJ6aC8FKYd94wO4FzaLWHP1WhBk+9CdUhSikA/Qbneh3qzck1NUlXF7WAjgP9n
         FCiYvruVrFqWmocmImswlMsk0PmLNTRezwa2N18U4DmB8l3mPX36B7AyDgl9cK2xyTW5
         URppNS4VBC7mqcotFa4ub4ND2AZVDYJWkioKBsbL1n/ZtpDsDAMMdZe3m1QIzr1JXoa+
         Y02RKGCRJX4PEb/naTay8f/OyErlRfAT1XdXqrVNRxutfwuD2RwDSoK+t5p8axZEqNIy
         sSBQ==
X-Gm-Message-State: AOAM530KbrbsLhuevExDT79YrqBw68TolUPQAfc9LhZ7nT4su6S5OcgB
        HEIIyd/c0o8DGXfVOmtwL0WKm0u22Frb8A==
X-Google-Smtp-Source: ABdhPJzskXSdeHIbPNslR7qV78wRjFqJ+Mllhg5OdadDMxDVhmYYvGTuHKv8MSOnuv6j4RFUJNPMag==
X-Received: by 2002:a05:6e02:1566:b0:2ca:a34a:a673 with SMTP id k6-20020a056e02156600b002caa34aa673mr5970257ilu.1.1649771745533;
        Tue, 12 Apr 2022 06:55:45 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2611:a7ae:f1c9:5ec2])
        by smtp.gmail.com with ESMTPSA id n12-20020a92dd0c000000b002cac22690b6sm2280748ilm.0.2022.04.12.06.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 06:55:44 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, tharvey@gateworks.com,
        cstevens@beaconembedded.com, aford@beaconembedded.com,
        laurent.pinchart@ideasonboard.com, Adam Ford <aford173@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] media: i2c: imx219: Split common registers from mode tables
Date:   Tue, 12 Apr 2022 08:55:30 -0500
Message-Id: <20220412135534.2796158-2-aford173@gmail.com>
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

There are four modes, and each mode has a table of registers.
Some of the registers are common to all modes, so create new
tables for these common registers to reduce duplicate code.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/media/i2c/imx219.c | 103 ++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 64 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index e10af3f74b38..b7cc36b16547 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -145,19 +145,36 @@ struct imx219_mode {
 	struct imx219_reg_list reg_list;
 };
 
-/*
- * Register sets lifted off the i2C interface from the Raspberry Pi firmware
- * driver.
- * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
- */
-static const struct imx219_reg mode_3280x2464_regs[] = {
-	{0x0100, 0x00},
+/* To Access Addresses 3000-5fff, send the following commands */
+static const struct imx219_reg mfg_specific_reg[] = {
+	{0x0100, 0x00},	/* Mode Select */
 	{0x30eb, 0x0c},
 	{0x30eb, 0x05},
 	{0x300a, 0xff},
 	{0x300b, 0xff},
 	{0x30eb, 0x05},
 	{0x30eb, 0x09},
+};
+
+static const struct imx219_reg pll_clk_table[] = {
+
+	{0x0301, 0x05},	/* VTPXCK_DIV */
+	{0x0303, 0x01},	/* VTSYSCK_DIV */
+	{0x0304, 0x03},	/* PREPLLCK_VT_DIV 0x03 = AUTO set */
+	{0x0305, 0x03}, /* PREPLLCK_OP_DIV 0x03 = AUTO set */
+	{0x0306, 0x00},	/* PLL_VT_MPY */
+	{0x0307, 0x39},
+	{0x030b, 0x01},	/* OP_SYS_CLK_DIV */
+	{0x030c, 0x00},	/* PLL_OP_MPY */
+	{0x030d, 0x72},
+};
+
+/*
+ * Register sets lifted off the i2C interface from the Raspberry Pi firmware
+ * driver.
+ * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
+ */
+static const struct imx219_reg mode_3280x2464_regs[] = {
 	{0x0114, 0x01},
 	{0x0128, 0x00},
 	{0x012a, 0x18},
@@ -178,15 +195,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
 	{0x0171, 0x01},
 	{0x0174, 0x00},
 	{0x0175, 0x00},
-	{0x0301, 0x05},
-	{0x0303, 0x01},
-	{0x0304, 0x03},
-	{0x0305, 0x03},
-	{0x0306, 0x00},
-	{0x0307, 0x39},
-	{0x030b, 0x01},
-	{0x030c, 0x00},
-	{0x030d, 0x72},
 	{0x0624, 0x0c},
 	{0x0625, 0xd0},
 	{0x0626, 0x09},
@@ -208,13 +216,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
 };
 
 static const struct imx219_reg mode_1920_1080_regs[] = {
-	{0x0100, 0x00},
-	{0x30eb, 0x05},
-	{0x30eb, 0x0c},
-	{0x300a, 0xff},
-	{0x300b, 0xff},
-	{0x30eb, 0x05},
-	{0x30eb, 0x09},
 	{0x0114, 0x01},
 	{0x0128, 0x00},
 	{0x012a, 0x18},
@@ -237,15 +238,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
 	{0x0171, 0x01},
 	{0x0174, 0x00},
 	{0x0175, 0x00},
-	{0x0301, 0x05},
-	{0x0303, 0x01},
-	{0x0304, 0x03},
-	{0x0305, 0x03},
-	{0x0306, 0x00},
-	{0x0307, 0x39},
-	{0x030b, 0x01},
-	{0x030c, 0x00},
-	{0x030d, 0x72},
 	{0x0624, 0x07},
 	{0x0625, 0x80},
 	{0x0626, 0x04},
@@ -265,13 +257,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
 };
 
 static const struct imx219_reg mode_1640_1232_regs[] = {
-	{0x0100, 0x00},
-	{0x30eb, 0x0c},
-	{0x30eb, 0x05},
-	{0x300a, 0xff},
-	{0x300b, 0xff},
-	{0x30eb, 0x05},
-	{0x30eb, 0x09},
 	{0x0114, 0x01},
 	{0x0128, 0x00},
 	{0x012a, 0x18},
@@ -292,15 +277,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
 	{0x0171, 0x01},
 	{0x0174, 0x01},
 	{0x0175, 0x01},
-	{0x0301, 0x05},
-	{0x0303, 0x01},
-	{0x0304, 0x03},
-	{0x0305, 0x03},
-	{0x0306, 0x00},
-	{0x0307, 0x39},
-	{0x030b, 0x01},
-	{0x030c, 0x00},
-	{0x030d, 0x72},
 	{0x0624, 0x06},
 	{0x0625, 0x68},
 	{0x0626, 0x04},
@@ -322,13 +298,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
 };
 
 static const struct imx219_reg mode_640_480_regs[] = {
-	{0x0100, 0x00},
-	{0x30eb, 0x05},
-	{0x30eb, 0x0c},
-	{0x300a, 0xff},
-	{0x300b, 0xff},
-	{0x30eb, 0x05},
-	{0x30eb, 0x09},
 	{0x0114, 0x01},
 	{0x0128, 0x00},
 	{0x012a, 0x18},
@@ -351,15 +320,6 @@ static const struct imx219_reg mode_640_480_regs[] = {
 	{0x0171, 0x01},
 	{0x0174, 0x03},
 	{0x0175, 0x03},
-	{0x0301, 0x05},
-	{0x0303, 0x01},
-	{0x0304, 0x03},
-	{0x0305, 0x03},
-	{0x0306, 0x00},
-	{0x0307, 0x39},
-	{0x030b, 0x01},
-	{0x030c, 0x00},
-	{0x030d, 0x72},
 	{0x0624, 0x06},
 	{0x0625, 0x68},
 	{0x0626, 0x04},
@@ -1041,6 +1001,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
 	if (ret < 0)
 		return ret;
 
+	/* Send the Manufacturing Header common to all modes */
+	ret = imx219_write_regs(imx219, mfg_specific_reg, ARRAY_SIZE(mfg_specific_reg));
+	if (ret) {
+		dev_err(&client->dev, "%s failed to send mfg header\n", __func__);
+		goto err_rpm_put;
+	}
+
 	/* Apply default values of current mode */
 	reg_list = &imx219->mode->reg_list;
 	ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
@@ -1056,6 +1023,14 @@ static int imx219_start_streaming(struct imx219 *imx219)
 		goto err_rpm_put;
 	}
 
+	/* Configure the PLL clocks */
+	ret = imx219_write_regs(imx219, pll_clk_table, ARRAY_SIZE(pll_clk_table));
+	if (ret) {
+		dev_err(&client->dev, "%s failed to sent PLL clocks\n", __func__);
+		goto err_rpm_put;
+	}
+
+
 	/* Apply customized values from user */
 	ret =  __v4l2_ctrl_handler_setup(imx219->sd.ctrl_handler);
 	if (ret)
-- 
2.34.1

