Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD456C9AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 15:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiGINvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 09:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGINvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 09:51:04 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D4B3C17F;
        Sat,  9 Jul 2022 06:51:03 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id n9so698316ilq.12;
        Sat, 09 Jul 2022 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cMrQxh/P5Iy9K8Q4TNZI4P0CEcaPHRQrvet4cwyCSTA=;
        b=js+7E5FEvu2Gg7CCR9gM1CdmcGst6Mh9QYoSJZcqtf8l+xWLSfXDeXpCKDztq9hxBE
         syUfxCsmPMrJ/hiHkxqTmHcUJMLq9+g/P0bfUWmvSqB5xEoQkH5eoXpj6/0aBtVhR7TS
         VAwqZUXkX9g/7AA9iawNL7oWEwsr4BfLBTiZeIkskVCQpuW/RKIiVeVflq5HnHOy892a
         TSILiKbHCnhSLseXeHYqfFsxCZSoA3vhFI9vYdmOAOO4zGLSv6FH4bOA3T7Gfvvc3f6q
         p/FPrv9GIOLyWSHnVf8LlpHW57JOhz6RveDQ6VcNWgjsHrO8hZva2Zmgv+4qSbxfdbKF
         5sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cMrQxh/P5Iy9K8Q4TNZI4P0CEcaPHRQrvet4cwyCSTA=;
        b=U/TnBra3kTVPAJ64sDDnU9kNdF2CT2kf8Pw0dlh25M0VjJSE3j+B5raoEgXJ8tXv6i
         0KzGAOBrwhqnExYd39Brpgu1ouFlWnM7bjQmO73zIvFdlcVscsrtOBgW1+D5ZaDJTkub
         s88Wshu+pW8FloQVToa1VpocruyCNdnZ64eAck9EeRVUP1dLtxfqFrIiI+Wz1UdNGubC
         P3Aw6518REw6MHCcCmdWegAgJNIv8AFZiKs4kkMna11O2bgDKDf2K0443AF1sV1qinS1
         fNeDCn73vSDVOqde6eN91D/4iXJV0yC9i7oWD2YeAuUd++lqybTJ7aAGY0T6FmOaOU2y
         EaWA==
X-Gm-Message-State: AJIora8mJ3JHV8vl9IgGI80rZvtrHdkVEyEp4qwunULxho5z3Gniz61N
        BslIMhUgkRpeXJwgrlUglzMbFH/oOLUuTQ==
X-Google-Smtp-Source: AGRyM1uC8/YoqNiUS7Ob5+R2NEN1K6qGviVEMbvn9JwuBR+8Wm7RrMrpu0Q9XQma/COn/fEtN/vyLg==
X-Received: by 2002:a05:6e02:b21:b0:2dc:6d2d:5a61 with SMTP id e1-20020a056e020b2100b002dc6d2d5a61mr1272502ilu.273.1657374662529;
        Sat, 09 Jul 2022 06:51:02 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:4a65:3ca1:59ec:e66b])
        by smtp.gmail.com with ESMTPSA id p133-20020a02298b000000b0033f3e34f3b4sm635441jap.150.2022.07.09.06.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 06:51:01 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     dave.stevenson@raspberrypi.com, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, Adam Ford <aford173@gmail.com>
Subject: [PATCH 1/2] media: i2c: imx219: Split common registers from mode tables
Date:   Sat,  9 Jul 2022 08:50:51 -0500
Message-Id: <20220709135052.3850913-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
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
V3:  Change some of the comments to better reflect their description
     Add a few more entries to the imx219_common_regs table.

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index e10af3f74b38..faa5dab3c2ec 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -145,23 +145,61 @@ struct imx219_mode {
 	struct imx219_reg_list reg_list;
 };
 
-/*
- * Register sets lifted off the i2C interface from the Raspberry Pi firmware
- * driver.
- * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
- */
-static const struct imx219_reg mode_3280x2464_regs[] = {
-	{0x0100, 0x00},
+static const struct imx219_reg imx219_common_regs[] = {
+	{0x0100, 0x00},	/* Mode Select */
+
+	/* To Access Addresses 3000-5fff, send the following commands */
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
+	{0x0170, 0x01}, /* X_ODD_INC_A */
+	{0x0171, 0x01}, /* Y_ODD_INC_A */
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
@@ -174,53 +212,15 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
 	{0x016d, 0xd0},
 	{0x016e, 0x09},
 	{0x016f, 0xa0},
-	{0x0170, 0x01},
-	{0x0171, 0x01},
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
@@ -233,49 +233,15 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
 	{0x016d, 0x80},
 	{0x016e, 0x04},
 	{0x016f, 0x38},
-	{0x0170, 0x01},
-	{0x0171, 0x01},
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
@@ -288,53 +254,15 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
 	{0x016d, 0x68},
 	{0x016e, 0x04},
 	{0x016f, 0xd0},
-	{0x0170, 0x01},
-	{0x0171, 0x01},
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
@@ -347,35 +275,12 @@ static const struct imx219_reg mode_640_480_regs[] = {
 	{0x016d, 0x80},
 	{0x016e, 0x01},
 	{0x016f, 0xe0},
-	{0x0170, 0x01},
-	{0x0171, 0x01},
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
@@ -1041,6 +946,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
 	if (ret < 0)
 		return ret;
 
+	/* Send all registers that are common to all modes */
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

