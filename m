Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6666C54E0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376972AbiFPMb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376424AbiFPMb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:31:56 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1CB4D9FC;
        Thu, 16 Jun 2022 05:31:54 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id x75so842045qkb.12;
        Thu, 16 Jun 2022 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rr2NkPqUDPIFLCqvXbtLfZjFxFQyJ3K960K4QMA58Hs=;
        b=GyQT65sDvGr3cfDspP4xzRHXMUDKWqf/eTdZ/z+H7ZAYhOC/dkRZWKwWwA6mvtHvxE
         cdRRKXp360s1VKbVYnHlBZ60jzkKkpFkNYFGa3Q8YtkRLTB7qdjkk79ztnsG7xzajA0n
         VzGwCD3Vks5DTGT2TiwEd25g0aQ3ShSHGXcnT6fjx1L7Vc87NKSOeZDxrthkxkbmonX+
         27Rr5Xk/yzNeF2e7uW0W1eSPcycQwk6j1CG06UG6UYFLH8C3qJGPkBEqo7m7yCISJ/OD
         xVm4NP0NNPZOMiwaTIPuzEQDtUR+0eXO72n9QDxceSYvra9fwbGvHpsRRjoDtJgg8x7b
         84lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rr2NkPqUDPIFLCqvXbtLfZjFxFQyJ3K960K4QMA58Hs=;
        b=mcYa5YsWx3rDlVBQu25UOqLQCi9dysyZCinOED2Q1nrLthD2vTbOwt9zpz/yzO1dIU
         VwXk3JlOXJI/6IzvsWsAF+sDHqOUSgEoNzL5IxBXzCgHn5OdviIsaXv0pLMiuh937+VN
         ES8wj5WIRww9n28Gvf36hWjzbSjktGSNrpVQDF6Rf19JOkZAnFlkItAjGSuliqP4o0oz
         1uusjD2nENWmrpM2lcseTJgqmL6UtKKkjStOZ4hxLrJ7W/Z5lG3hTpujSsMzQr99VBpv
         jgtrA4qiO3FdiXajgqc+Su6FARUAl0rYsSqNYMsRzvnYKt3NUonrLVhp8zxzaQeuZ6b6
         HWVw==
X-Gm-Message-State: AJIora837NWhQQg6Sb0NFX4DmOmFof/lab3s6DLb91KoqHsBP4NsySjT
        +ssllIirplERnmKyQB9BXrMaPNJujJM=
X-Google-Smtp-Source: AGRyM1tr2O4MPEUwy87VKlof5GPpmK9KMiD5bolSF3JFF8Lt/RVwO0jYvO7XbVEfhAzsUcK7lIkifw==
X-Received: by 2002:a37:a153:0:b0:6a9:881c:540e with SMTP id k80-20020a37a153000000b006a9881c540emr3203350qke.585.1655382713626;
        Thu, 16 Jun 2022 05:31:53 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id k20-20020a05620a415400b006a6f1c30701sm1697979qko.115.2022.06.16.05.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 05:31:53 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     dave.stevenson@raspberrypi.com, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH V2 1/2] media: i2c: imx219: Split common registers from mode tables
Date:   Thu, 16 Jun 2022 07:31:49 -0500
Message-Id: <20220616123150.5890-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
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
V2:  Merge the PLL table into the common table instead of having
     two separate, common tables.

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index e10af3f74b38..a43eed143999 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -145,23 +145,60 @@ struct imx219_mode {
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
+static const struct imx219_reg imx219_common_regs[] = {
+	{0x0100, 0x00},	/* Mode Select */
+
+	/* Access Command Sequence */
 	{0x30eb, 0x0c},
 	{0x30eb, 0x05},
 	{0x300a, 0xff},
 	{0x300b, 0xff},
 	{0x30eb, 0x05},
 	{0x30eb, 0x09},
-	{0x0114, 0x01},
-	{0x0128, 0x00},
-	{0x012a, 0x18},
+
+	/* PLL Clock Table */
+	{0x0301, 0x05},	/* VTPXCK_DIV */
+	{0x0303, 0x01},	/* VTSYSCK_DIV */
+	{0x0304, 0x03},	/* PREPLLCK_VT_DIV 0x03 = AUTO set */
+	{0x0305, 0x03}, /* PREPLLCK_OP_DIV 0x03 = AUTO set */
+	{0x0306, 0x00},	/* PLL_VT_MPY */
+	{0x0307, 0x39},
+	{0x030b, 0x01},	/* OP_SYS_CLK_DIV */
+	{0x030c, 0x00},	/* PLL_OP_MPY */
+	{0x030d, 0x72},
+
+	/* Undocumented registers */
+	{0x455e, 0x00},
+	{0x471e, 0x4b},
+	{0x4767, 0x0f},
+	{0x4750, 0x14},
+	{0x4540, 0x00},
+	{0x47b4, 0x14},
+	{0x4713, 0x30},
+	{0x478b, 0x10},
+	{0x478f, 0x10},
+	{0x4793, 0x10},
+	{0x4797, 0x0e},
+	{0x479b, 0x0e},
+
+	/* Frame Bank Register Group "A" */
+	{0x0162, 0x0d},	/* Line_Length_A */
+	{0x0163, 0x78},
+
+	/* Output setup registers */
+	{0x0114, 0x01},	/* CSI 2-Lane Mode */
+	{0x0128, 0x00},	/* DPHY Auto Mode */
+	{0x012a, 0x18},	/* EXCK_Freq */
 	{0x012b, 0x00},
+};
+
+/*
+ * Register sets lifted off the i2C interface from the Raspberry Pi firmware
+ * driver.
+ * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
+ */
+static const struct imx219_reg mode_3280x2464_regs[] = {
 	{0x0164, 0x00},
 	{0x0165, 0x00},
 	{0x0166, 0x0c},
@@ -176,51 +213,15 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
 	{0x016f, 0xa0},
 	{0x0170, 0x01},
 	{0x0171, 0x01},
-	{0x0174, 0x00},
+	{0x0174, 0x00},	/* No-Binning */
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
 	{0x0627, 0xa0},
-	{0x455e, 0x00},
-	{0x471e, 0x4b},
-	{0x4767, 0x0f},
-	{0x4750, 0x14},
-	{0x4540, 0x00},
-	{0x47b4, 0x14},
-	{0x4713, 0x30},
-	{0x478b, 0x10},
-	{0x478f, 0x10},
-	{0x4793, 0x10},
-	{0x4797, 0x0e},
-	{0x479b, 0x0e},
-	{0x0162, 0x0d},
-	{0x0163, 0x78},
 };
 
 static const struct imx219_reg mode_1920_1080_regs[] = {
-	{0x0100, 0x00},
-	{0x30eb, 0x05},
-	{0x30eb, 0x0c},
-	{0x300a, 0xff},
-	{0x300b, 0xff},
-	{0x30eb, 0x05},
-	{0x30eb, 0x09},
-	{0x0114, 0x01},
-	{0x0128, 0x00},
-	{0x012a, 0x18},
-	{0x012b, 0x00},
-	{0x0162, 0x0d},
-	{0x0163, 0x78},
 	{0x0164, 0x02},
 	{0x0165, 0xa8},
 	{0x0166, 0x0a},
@@ -235,47 +236,15 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
 	{0x016f, 0x38},
 	{0x0170, 0x01},
 	{0x0171, 0x01},
-	{0x0174, 0x00},
+	{0x0174, 0x00},	/* No-Binning */
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
 	{0x0627, 0x38},
-	{0x455e, 0x00},
-	{0x471e, 0x4b},
-	{0x4767, 0x0f},
-	{0x4750, 0x14},
-	{0x4540, 0x00},
-	{0x47b4, 0x14},
-	{0x4713, 0x30},
-	{0x478b, 0x10},
-	{0x478f, 0x10},
-	{0x4793, 0x10},
-	{0x4797, 0x0e},
-	{0x479b, 0x0e},
 };
 
 static const struct imx219_reg mode_1640_1232_regs[] = {
-	{0x0100, 0x00},
-	{0x30eb, 0x0c},
-	{0x30eb, 0x05},
-	{0x300a, 0xff},
-	{0x300b, 0xff},
-	{0x30eb, 0x05},
-	{0x30eb, 0x09},
-	{0x0114, 0x01},
-	{0x0128, 0x00},
-	{0x012a, 0x18},
-	{0x012b, 0x00},
 	{0x0164, 0x00},
 	{0x0165, 0x00},
 	{0x0166, 0x0c},
@@ -290,51 +259,15 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
 	{0x016f, 0xd0},
 	{0x0170, 0x01},
 	{0x0171, 0x01},
-	{0x0174, 0x01},
+	{0x0174, 0x01},	/* x2-Binning */
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
 	{0x0627, 0xd0},
-	{0x455e, 0x00},
-	{0x471e, 0x4b},
-	{0x4767, 0x0f},
-	{0x4750, 0x14},
-	{0x4540, 0x00},
-	{0x47b4, 0x14},
-	{0x4713, 0x30},
-	{0x478b, 0x10},
-	{0x478f, 0x10},
-	{0x4793, 0x10},
-	{0x4797, 0x0e},
-	{0x479b, 0x0e},
-	{0x0162, 0x0d},
-	{0x0163, 0x78},
 };
 
 static const struct imx219_reg mode_640_480_regs[] = {
-	{0x0100, 0x00},
-	{0x30eb, 0x05},
-	{0x30eb, 0x0c},
-	{0x300a, 0xff},
-	{0x300b, 0xff},
-	{0x30eb, 0x05},
-	{0x30eb, 0x09},
-	{0x0114, 0x01},
-	{0x0128, 0x00},
-	{0x012a, 0x18},
-	{0x012b, 0x00},
-	{0x0162, 0x0d},
-	{0x0163, 0x78},
 	{0x0164, 0x03},
 	{0x0165, 0xe8},
 	{0x0166, 0x08},
@@ -349,33 +282,12 @@ static const struct imx219_reg mode_640_480_regs[] = {
 	{0x016f, 0xe0},
 	{0x0170, 0x01},
 	{0x0171, 0x01},
-	{0x0174, 0x03},
+	{0x0174, 0x03},	/* x2-analog binning */
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
 	{0x0627, 0xd0},
-	{0x455e, 0x00},
-	{0x471e, 0x4b},
-	{0x4767, 0x0f},
-	{0x4750, 0x14},
-	{0x4540, 0x00},
-	{0x47b4, 0x14},
-	{0x4713, 0x30},
-	{0x478b, 0x10},
-	{0x478f, 0x10},
-	{0x4793, 0x10},
-	{0x4797, 0x0e},
-	{0x479b, 0x0e},
 };
 
 static const struct imx219_reg raw8_framefmt_regs[] = {
@@ -1041,6 +953,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
 	if (ret < 0)
 		return ret;
 
+	/* Send the Manufacturing Header common to all modes */
+	ret = imx219_write_regs(imx219, imx219_common_regs, ARRAY_SIZE(imx219_common_regs));
+	if (ret) {
+		dev_err(&client->dev, "%s failed to send mfg header\n", __func__);
+		goto err_rpm_put;
+	}
+
 	/* Apply default values of current mode */
 	reg_list = &imx219->mode->reg_list;
 	ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
-- 
2.34.1

