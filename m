Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B27503492
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 08:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiDPG5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPG5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 02:57:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FCECFE;
        Fri, 15 Apr 2022 23:54:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p189so5987668wmp.3;
        Fri, 15 Apr 2022 23:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3npAyY8rPKuk01RaNVhM66JpVvQwy4LZnWG1HHtuULM=;
        b=l+qq+pUkbiKZujFSSt+Ncg5HZStZ4JJmMmqMrH171roijPFpIPtetbfeBuiKuTZd4W
         ARA24OygzRc/gt0jA23RHZS2kchudqXAsuO3j0yD+BW2BVT+kzFatKk6b+XUQlRsMQRd
         +3X0Cnu7KD6DhxmT4ayAHbxk+5GOsvpv67LH2Qm6r84PtwgGItRkXNscyZO6VReqKajG
         SZZfr7ELqwCYS4ff47QKi+48FW90pkAGtNRaYgDo5TvYzN+oOOgQtTznTVE/p8UYjDEP
         ZIcXGFtJ0VN4rZUWicLdpKjdpKR37q/AioPyqRkvZdZHisEs6Pw42QzGiOEjzsNjmix9
         wt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3npAyY8rPKuk01RaNVhM66JpVvQwy4LZnWG1HHtuULM=;
        b=A9ir8YqHvTLs+I0ReX1gepliDkF4o2C6Zac++oFzOWqc65mz2o6dVbTKAmCzeKND4X
         r5BYSEDfi0l91o0iAutStncFdA3H7V3kvBb3EeEYCtVoeZjvDKhYOWazptGGdvHPVEc+
         ybEjyBcW9swlpwWBxl0OUqTc4mx3GoL3XSq1i3a02f/1wvHbFBA1HcxuMkrj3x2xaIJs
         wb4JawcBjkXLNGrWUatJqyAnFOtqdCycKR9Qgftm3Jopxj3jjSfL7gFQUyiyHIdqNZbY
         mxzc5fQeY1t9y21ai3AZxdd8wOb8h/euwmcJ4m9LQFTyzuYbrJhOmLZudehUUP4+nasN
         4Cig==
X-Gm-Message-State: AOAM531qcPHJmvuXu23epvLZNC4JDCejPCKLFaT7L4ZWT+ta+G7YGrM3
        hD6Pbe4rQ7OYxq9NAYzE8PhdADoi9Xc=
X-Google-Smtp-Source: ABdhPJyfvl/EftwSDRU3mfUDJs6u5VlxlNIWRQDkNLOBnlWw7xuLg1zlplaXkWy2SaiiNPwp21NyNg==
X-Received: by 2002:a05:600c:3b25:b0:38e:c5f9:8f01 with SMTP id m37-20020a05600c3b2500b0038ec5f98f01mr6231429wms.175.1650092080368;
        Fri, 15 Apr 2022 23:54:40 -0700 (PDT)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id f189-20020a1c38c6000000b0038ff83b9792sm6091294wma.43.2022.04.15.23.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 23:54:39 -0700 (PDT)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Subject: [PATCH] media: i2c: tw9903: Use ARRAY_SIZE instead of manual checking
Date:   Sat, 16 Apr 2022 08:53:58 +0200
Message-Id: <20220416065358.56537-1-mosescb.dev@gmail.com>
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

this driver currently uses a terminator(0x00, 0x00) to end the list
of reg-vals instead, a struct array with ARRAY_SIZE macro can be used
to obtain the length of the array.

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 drivers/media/i2c/tw9903.c | 150 ++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 70 deletions(-)

diff --git a/drivers/media/i2c/tw9903.c b/drivers/media/i2c/tw9903.c
index f8e3ab4909d8..b8f8240d20c1 100644
--- a/drivers/media/i2c/tw9903.c
+++ b/drivers/media/i2c/tw9903.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/kernel.h>
 #include <linux/videodev2.h>
 #include <linux/ioctl.h>
 #include <media/v4l2-device.h>
@@ -35,56 +36,60 @@ static inline struct tw9903 *to_state(struct v4l2_subdev *sd)
 	return container_of(sd, struct tw9903, sd);
 }
 
-static const u8 initial_registers[] = {
-	0x02, 0x44, /* input 1, composite */
-	0x03, 0x92, /* correct digital format */
-	0x04, 0x00,
-	0x05, 0x80, /* or 0x00 for PAL */
-	0x06, 0x40, /* second internal current reference */
-	0x07, 0x02, /* window */
-	0x08, 0x14, /* window */
-	0x09, 0xf0, /* window */
-	0x0a, 0x81, /* window */
-	0x0b, 0xd0, /* window */
-	0x0c, 0x8c,
-	0x0d, 0x00, /* scaling */
-	0x0e, 0x11, /* scaling */
-	0x0f, 0x00, /* scaling */
-	0x10, 0x00, /* brightness */
-	0x11, 0x60, /* contrast */
-	0x12, 0x01, /* sharpness */
-	0x13, 0x7f, /* U gain */
-	0x14, 0x5a, /* V gain */
-	0x15, 0x00, /* hue */
-	0x16, 0xc3, /* sharpness */
-	0x18, 0x00,
-	0x19, 0x58, /* vbi */
-	0x1a, 0x80,
-	0x1c, 0x0f, /* video norm */
-	0x1d, 0x7f, /* video norm */
-	0x20, 0xa0, /* clamping gain (working 0x50) */
-	0x21, 0x22,
-	0x22, 0xf0,
-	0x23, 0xfe,
-	0x24, 0x3c,
-	0x25, 0x38,
-	0x26, 0x44,
-	0x27, 0x20,
-	0x28, 0x00,
-	0x29, 0x15,
-	0x2a, 0xa0,
-	0x2b, 0x44,
-	0x2c, 0x37,
-	0x2d, 0x00,
-	0x2e, 0xa5, /* burst PLL control (working: a9) */
-	0x2f, 0xe0, /* 0xea is blue test frame -- 0xe0 for normal */
-	0x31, 0x00,
-	0x33, 0x22,
-	0x34, 0x11,
-	0x35, 0x35,
-	0x3b, 0x05,
-	0x06, 0xc0, /* reset device */
-	0x00, 0x00, /* Terminator (reg 0x00 is read-only) */
+struct reg_val {
+	u8 reg;
+	u8 val;
+};
+
+static const struct reg_val init_regs[] = {
+	{0x02, 0x44}, /* input 1, composite */
+	{0x03, 0x92}, /* correct digital format */
+	{0x04, 0x00},
+	{0x05, 0x80}, /* or 0x00 for PAL */
+	{0x06, 0x40}, /* second internal current reference */
+	{0x07, 0x02}, /* window */
+	{0x08, 0x14}, /* window */
+	{0x09, 0xf0}, /* window */
+	{0x0a, 0x81}, /* window */
+	{0x0b, 0xd0}, /* window */
+	{0x0c, 0x8c},
+	{0x0d, 0x00}, /* scaling */
+	{0x0e, 0x11}, /* scaling */
+	{0x0f, 0x00}, /* scaling */
+	{0x10, 0x00}, /* brightness */
+	{0x11, 0x60}, /* contrast */
+	{0x12, 0x01}, /* sharpness */
+	{0x13, 0x7f}, /* U gain */
+	{0x14, 0x5a}, /* V gain */
+	{0x15, 0x00}, /* hue */
+	{0x16, 0xc3}, /* sharpness */
+	{0x18, 0x00},
+	{0x19, 0x58}, /* vbi */
+	{0x1a, 0x80},
+	{0x1c, 0x0f}, /* video norm */
+	{0x1d, 0x7f}, /* video norm */
+	{0x20, 0xa0}, /* clamping gain (working 0x50) */
+	{0x21, 0x22},
+	{0x22, 0xf0},
+	{0x23, 0xfe},
+	{0x24, 0x3c},
+	{0x25, 0x38},
+	{0x26, 0x44},
+	{0x27, 0x20},
+	{0x28, 0x00},
+	{0x29, 0x15},
+	{0x2a, 0xa0},
+	{0x2b, 0x44},
+	{0x2c, 0x37},
+	{0x2d, 0x00},
+	{0x2e, 0xa5}, /* burst PLL control (working: a9) */
+	{0x2f, 0xe0}, /* 0xea is blue test frame -- 0xe0 for normal */
+	{0x31, 0x00},
+	{0x33, 0x22},
+	{0x34, 0x11},
+	{0x35, 0x35},
+	{0x3b, 0x05},
+	{0x06, 0xc0}, /* reset device */
 };
 
 static int write_reg(struct v4l2_subdev *sd, u8 reg, u8 value)
@@ -94,13 +99,14 @@ static int write_reg(struct v4l2_subdev *sd, u8 reg, u8 value)
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-static int write_regs(struct v4l2_subdev *sd, const u8 *regs)
+static int write_regs(struct v4l2_subdev *sd,
+		      const struct reg_val *rv, int len)
 {
-	int i;
-
-	for (i = 0; regs[i] != 0x00; i += 2)
-		if (write_reg(sd, regs[i], regs[i + 1]) < 0)
+	while (--len >= 0) {
+		if (write_reg(sd, rv->reg, rv->val) < 0)
 			return -1;
+		rv++;
+	}
 	return 0;
 }
 
@@ -115,24 +121,28 @@ static int tw9903_s_std(struct v4l2_subdev *sd, v4l2_std_id norm)
 {
 	struct tw9903 *dec = to_state(sd);
 	bool is_60hz = norm & V4L2_STD_525_60;
-	static const u8 config_60hz[] = {
-		0x05, 0x80,
-		0x07, 0x02,
-		0x08, 0x14,
-		0x09, 0xf0,
-		0,    0,
+	int ret;
+
+	static const struct reg_val config_60hz[] = {
+		{0x05, 0x80},
+		{0x07, 0x02},
+		{0x08, 0x14},
+		{0x09, 0xf0},
 	};
-	static const u8 config_50hz[] = {
-		0x05, 0x00,
-		0x07, 0x12,
-		0x08, 0x18,
-		0x09, 0x20,
-		0,    0,
+	static const struct reg_val config_50hz[] = {
+		{0x05, 0x00},
+		{0x07, 0x12},
+		{0x08, 0x18},
+		{0x09, 0x20},
 	};
 
-	write_regs(sd, is_60hz ? config_60hz : config_50hz);
+	if (is_60hz)
+		ret = write_regs(sd, config_60hz, ARRAY_SIZE(config_60hz));
+	else
+		ret = write_regs(sd, config_50hz, ARRAY_SIZE(config_50hz));
+
 	dec->norm = norm;
-	return 0;
+	return ret;
 }
 
 
@@ -227,7 +237,7 @@ static int tw9903_probe(struct i2c_client *client,
 	/* Initialize tw9903 */
 	dec->norm = V4L2_STD_NTSC;
 
-	if (write_regs(sd, initial_registers) < 0) {
+	if (write_regs(sd, init_regs, ARRAY_SIZE(init_regs)) < 0) {
 		v4l2_err(client, "error initializing TW9903\n");
 		return -EINVAL;
 	}
-- 
2.30.2

