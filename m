Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D325047B1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 14:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiDQMMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 08:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiDQMMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 08:12:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B143DF07;
        Sun, 17 Apr 2022 05:10:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so6252641wms.2;
        Sun, 17 Apr 2022 05:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Du11iDI+Cu/JqtV2c54FHoNA7YFRAOPPpSo4RvNH1Hk=;
        b=n+SmJjPD5f8c/UdOa7Bo6MoJFlzPss0CF+km0+vOVgiTmL2o7/WDk9TjIWSSQN6XFL
         e5a4djYWEAIPpa2aWj1q53lOjXpSNtkDWnERICOj8QDCHoK3LsMds1uBa1Bb1jpKxwuT
         SfhISzkd+LJZnQj52yY+PIF5pkd2g/LadfhCtvVbzd79D9RoLqTFxqaxQeGWMEHtZPix
         ++YWcsoJsk7m2zb/S/KtJMnAmJ1mW08pbY7FlUiJ54u83zJjvfW5BUbOYbCrLdt/hDnT
         /8XSCBObEgxmkbeY0xQTN9O99qqTXpyYHhFmSnsm2skJNRmyRU8sh30E0wkY7IpXOSE7
         RG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Du11iDI+Cu/JqtV2c54FHoNA7YFRAOPPpSo4RvNH1Hk=;
        b=oqOGHDev3WYpUphfHZzkBaXgxGzz8WxBrCv0rjy0A5eEEGs6fF5A4fI5HGOoDY7s4B
         xKIKftVdXP1Vkp1cNF8dlOlFjAbX0X4ptD0MWyNlCdzk7Pecg8oFC29N6vfp+Fv3xJul
         mmCJa5tzrDFgiib2RY8HutNskMWPn2JzCTnNdZp9+Nqh0jRUdycBnu++PmMfsz0y2mrW
         OLgqGm0OdBBxj4IP+2WKDRBap9gqP6PFohVqU4bkLreXU1uo4Pz9uXiSVhsOo2hNiNXN
         SfHDSgWDy42AoVaQ+NlffTjpJeAaZecrDT2UpW6WEcXwP+ak1QCk91bxSoqSABtaYHzV
         35Mg==
X-Gm-Message-State: AOAM530bbz8+VY/maMLkj4i8PDZ+y3HX44O3EnHu7n3Pncw610tr+KAH
        /WHJjr+AU7LPwt65a6931fW1hKsMJgU=
X-Google-Smtp-Source: ABdhPJxSbcmRPNoxRY9Sfg0txvxHnvUiGYkFFVJqwE3NVviC/9TUdSOW7c+6EENDSsGxgofHXc/6yQ==
X-Received: by 2002:a05:600c:2744:b0:38e:b6f7:d548 with SMTP id 4-20020a05600c274400b0038eb6f7d548mr11164904wmw.49.1650197411537;
        Sun, 17 Apr 2022 05:10:11 -0700 (PDT)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b00392889d04c4sm4949393wmq.23.2022.04.17.05.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 05:10:11 -0700 (PDT)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Subject: [PATCH] media: i2c: tw2804: Use ARRAY_SIZE instead of manual checking
Date:   Sun, 17 Apr 2022 14:09:59 +0200
Message-Id: <20220417120959.16977-1-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this driver currently uses a terminator(0xFF, 0xFF) to check for the
end of a reg-val list, instead a struct array with ARRAY_SIZE macro
from linux/kernel.h can be used to obtain the length of the array.

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 drivers/media/i2c/tw2804.c | 177 +++++++++++++++++++------------------
 1 file changed, 91 insertions(+), 86 deletions(-)

diff --git a/drivers/media/i2c/tw2804.c b/drivers/media/i2c/tw2804.c
index cd05f1ff504d..87842d178361 100644
--- a/drivers/media/i2c/tw2804.c
+++ b/drivers/media/i2c/tw2804.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/kernel.h>
 #include <linux/videodev2.h>
 #include <linux/ioctl.h>
 #include <linux/slab.h>
@@ -32,75 +33,77 @@ struct tw2804 {
 	int norm;
 };
 
-static const u8 global_registers[] = {
-	0x39, 0x00,
-	0x3a, 0xff,
-	0x3b, 0x84,
-	0x3c, 0x80,
-	0x3d, 0x80,
-	0x3e, 0x82,
-	0x3f, 0x82,
-	0x78, 0x00,
-	0xff, 0xff, /* Terminator (reg 0xff does not exist) */
+struct reg_val  {
+	u8 reg;
+	u8 val;
+};
+static const struct reg_val global_registers[] = {
+	{0x39, 0x00},
+	{0x3a, 0xff},
+	{0x3b, 0x84},
+	{0x3c, 0x80},
+	{0x3d, 0x80},
+	{0x3e, 0x82},
+	{0x3f, 0x82},
+	{0x78, 0x00},
 };
 
-static const u8 channel_registers[] = {
-	0x01, 0xc4,
-	0x02, 0xa5,
-	0x03, 0x20,
-	0x04, 0xd0,
-	0x05, 0x20,
-	0x06, 0xd0,
-	0x07, 0x88,
-	0x08, 0x20,
-	0x09, 0x07,
-	0x0a, 0xf0,
-	0x0b, 0x07,
-	0x0c, 0xf0,
-	0x0d, 0x40,
-	0x0e, 0xd2,
-	0x0f, 0x80,
-	0x10, 0x80,
-	0x11, 0x80,
-	0x12, 0x80,
-	0x13, 0x1f,
-	0x14, 0x00,
-	0x15, 0x00,
-	0x16, 0x00,
-	0x17, 0x00,
-	0x18, 0xff,
-	0x19, 0xff,
-	0x1a, 0xff,
-	0x1b, 0xff,
-	0x1c, 0xff,
-	0x1d, 0xff,
-	0x1e, 0xff,
-	0x1f, 0xff,
-	0x20, 0x07,
-	0x21, 0x07,
-	0x22, 0x00,
-	0x23, 0x91,
-	0x24, 0x51,
-	0x25, 0x03,
-	0x26, 0x00,
-	0x27, 0x00,
-	0x28, 0x00,
-	0x29, 0x00,
-	0x2a, 0x00,
-	0x2b, 0x00,
-	0x2c, 0x00,
-	0x2d, 0x00,
-	0x2e, 0x00,
-	0x2f, 0x00,
-	0x30, 0x00,
-	0x31, 0x00,
-	0x32, 0x00,
-	0x33, 0x00,
-	0x34, 0x00,
-	0x35, 0x00,
-	0x36, 0x00,
-	0x37, 0x00,
-	0xff, 0xff, /* Terminator (reg 0xff does not exist) */
+static const struct reg_val channel_registers[] = {
+	{0x01, 0xc4},
+	{0x02, 0xa5},
+	{0x03, 0x20},
+	{0x04, 0xd0},
+	{0x05, 0x20},
+	{0x06, 0xd0},
+	{0x07, 0x88},
+	{0x08, 0x20},
+	{0x09, 0x07},
+	{0x0a, 0xf0},
+	{0x0b, 0x07},
+	{0x0c, 0xf0},
+	{0x0d, 0x40},
+	{0x0e, 0xd2},
+	{0x0f, 0x80},
+	{0x10, 0x80},
+	{0x11, 0x80},
+	{0x12, 0x80},
+	{0x13, 0x1f},
+	{0x14, 0x00},
+	{0x15, 0x00},
+	{0x16, 0x00},
+	{0x17, 0x00},
+	{0x18, 0xff},
+	{0x19, 0xff},
+	{0x1a, 0xff},
+	{0x1b, 0xff},
+	{0x1c, 0xff},
+	{0x1d, 0xff},
+	{0x1e, 0xff},
+	{0x1f, 0xff},
+	{0x20, 0x07},
+	{0x21, 0x07},
+	{0x22, 0x00},
+	{0x23, 0x91},
+	{0x24, 0x51},
+	{0x25, 0x03},
+	{0x26, 0x00},
+	{0x27, 0x00},
+	{0x28, 0x00},
+	{0x29, 0x00},
+	{0x2a, 0x00},
+	{0x2b, 0x00},
+	{0x2c, 0x00},
+	{0x2d, 0x00},
+	{0x2e, 0x00},
+	{0x2f, 0x00},
+	{0x30, 0x00},
+	{0x31, 0x00},
+	{0x32, 0x00},
+	{0x33, 0x00},
+	{0x34, 0x00},
+	{0x35, 0x00},
+	{0x36, 0x00},
+	{0x37, 0x00},
 };
 
 static int write_reg(struct i2c_client *client, u8 reg, u8 value, u8 channel)
@@ -108,16 +111,17 @@ static int write_reg(struct i2c_client *client, u8 reg, u8 value, u8 channel)
 	return i2c_smbus_write_byte_data(client, reg | (channel << 6), value);
 }
 
-static int write_regs(struct i2c_client *client, const u8 *regs, u8 channel)
+static int write_regs(struct i2c_client *client, const struct reg_val *rv,
+		      int len, u8 channel)
 {
 	int ret;
-	int i;
 
-	for (i = 0; regs[i] != 0xff; i += 2) {
+	while (--len >= 0) {
 		ret = i2c_smbus_write_byte_data(client,
-				regs[i] | (channel << 6), regs[i + 1]);
+				rv->reg | (channel << 6), rv->val);
 		if (ret < 0)
 			return ret;
+		rv++;
 	}
 	return 0;
 }
@@ -252,21 +256,20 @@ static int tw2804_s_std(struct v4l2_subdev *sd, v4l2_std_id norm)
 	struct tw2804 *dec = to_state(sd);
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
 	bool is_60hz = norm & V4L2_STD_525_60;
-	u8 regs[] = {
-		0x01, is_60hz ? 0xc4 : 0x84,
-		0x09, is_60hz ? 0x07 : 0x04,
-		0x0a, is_60hz ? 0xf0 : 0x20,
-		0x0b, is_60hz ? 0x07 : 0x04,
-		0x0c, is_60hz ? 0xf0 : 0x20,
-		0x0d, is_60hz ? 0x40 : 0x4a,
-		0x16, is_60hz ? 0x00 : 0x40,
-		0x17, is_60hz ? 0x00 : 0x40,
-		0x20, is_60hz ? 0x07 : 0x0f,
-		0x21, is_60hz ? 0x07 : 0x0f,
-		0xff, 0xff,
+	struct reg_val regs[] = {
+		{0x01, is_60hz ? 0xc4 : 0x84},
+		{0x09, is_60hz ? 0x07 : 0x04},
+		{0x0a, is_60hz ? 0xf0 : 0x20},
+		{0x0b, is_60hz ? 0x07 : 0x04},
+		{0x0c, is_60hz ? 0xf0 : 0x20},
+		{0x0d, is_60hz ? 0x40 : 0x4a},
+		{0x16, is_60hz ? 0x00 : 0x40},
+		{0x17, is_60hz ? 0x00 : 0x40},
+		{0x20, is_60hz ? 0x07 : 0x0f},
+		{0x21, is_60hz ? 0x07 : 0x0f},
 	};
 
-	write_regs(client, regs, dec->channel);
+	write_regs(client, regs, ARRAY_SIZE(regs), dec->channel);
 	dec->norm = norm;
 	return 0;
 }
@@ -288,12 +291,14 @@ static int tw2804_s_video_routing(struct v4l2_subdev *sd, u32 input, u32 output,
 		dev_dbg(&client->dev, "initializing TW2804 channel %d\n",
 			dec->channel);
 		if (dec->channel == 0 &&
-				write_regs(client, global_registers, 0) < 0) {
+				write_regs(client, global_registers,
+					   ARRAY_SIZE(global_registers), 0) < 0) {
 			dev_err(&client->dev,
 				"error initializing TW2804 global registers\n");
 			return -EIO;
 		}
-		if (write_regs(client, channel_registers, dec->channel) < 0) {
+		if (write_regs(client, channel_registers,
+			       ARRAY_SIZE(channel_registers), dec->channel) < 0) {
 			dev_err(&client->dev,
 				"error initializing TW2804 channel %d\n",
 				dec->channel);
-- 
2.30.2

