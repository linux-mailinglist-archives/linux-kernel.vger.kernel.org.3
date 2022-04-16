Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9436503496
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 08:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiDPHAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 03:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPHAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 03:00:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3288F4D268;
        Fri, 15 Apr 2022 23:57:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so8835993wmb.4;
        Fri, 15 Apr 2022 23:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17zTEE8XFfFm+/ScXpzV4xIgy2dAstkdBPVwcZZY8rQ=;
        b=bwBNhFrQSrmvc1CtKbZ4sqWEuSbDshJHlQMQLnYIya2Pa6hBoPjlcvZXjhD16Te5/M
         VYvkeS8B53NtEDZGScwOS2LmZSVGv0XBChFMUdlNthg8RdtOgS8JG89eKomSaJsp7tz5
         P8LtIuYX7iIJIVgdjdF4C7y4cCT/ha1vI6j7ch4blTL1X8okXedJKXLFyToPH8TtWfSb
         13pQxwAtJZP9M4a0K4boas/+yILr8jWIhRAA3fxQSZ2dpWoZGnmiuk5v24rPok0w4D6p
         aGipaoPK1V/YFRNMZ7t+DWgkW4xpXN6PyazbugdjdYn2gNgxmOXCg4jnxhV/CVzRQus4
         Z9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17zTEE8XFfFm+/ScXpzV4xIgy2dAstkdBPVwcZZY8rQ=;
        b=ALKR4xceT4b63L0l1h6mmOEHfpiy+lnosSV9z5fbvz64ZvelOpayYc/qvwouuQ63LH
         MutW1bdC1ZMNFktWp7oEXmlpbs0RjAgaVh4dMUHw3o+rC/9fbZMBPwCRLhcBQJOHN7ee
         DZp1tqVn3P7A1SE9O3jFcH7mvssA+JPcxqdNWqMhZCg4Zg5xLubBF8oQX7ChxEtLyM+v
         EArbSp9OJntLvAyZ0dfLfJ3OgfkFNUj/jw1yCP7CN0jasZndve2nTrLS7E8WbYd+0swt
         R4EWrfW10WtKI+Uu4NiGhQXOcyy55691IAuubwgA2UEsetT4d7lkKCVtFjCSGLf6q5C/
         xLzg==
X-Gm-Message-State: AOAM533kksL7xZaER8bjJ7XDlG7jzw4WQn/tFdFZFTqHitr8M9AdYSnm
        anZCBKM4n/bolkUOFDXq0Mg=
X-Google-Smtp-Source: ABdhPJwWvH+6ikfkTS5jdiE4pjuOGynlgRgn79e7LCayb9QYNxXGZHAF5dWXj3uDfBRVkZEdzyBgww==
X-Received: by 2002:a1c:f315:0:b0:381:1f6d:6ca6 with SMTP id q21-20020a1cf315000000b003811f6d6ca6mr6235188wmq.25.1650092277720;
        Fri, 15 Apr 2022 23:57:57 -0700 (PDT)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600002cb00b0020a88c4ecb5sm579350wry.3.2022.04.15.23.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 23:57:57 -0700 (PDT)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Subject: [PATCH] media: i2c: tw9906: Use ARRAY_SIZE instead of manual checking
Date:   Sat, 16 Apr 2022 08:56:54 +0200
Message-Id: <20220416065654.56712-1-mosescb.dev@gmail.com>
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
of reg-vals, instead a struct array with ARRAY_SIZE macro from
linux/kernel.h can be used to obtain the length of the array.

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 drivers/media/i2c/tw9906.c | 110 ++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 50 deletions(-)

diff --git a/drivers/media/i2c/tw9906.c b/drivers/media/i2c/tw9906.c
index c528eb01fed0..318f87ae63f2 100644
--- a/drivers/media/i2c/tw9906.c
+++ b/drivers/media/i2c/tw9906.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/kernel.h>
 #include <linux/videodev2.h>
 #include <linux/ioctl.h>
 #include <linux/slab.h>
@@ -26,36 +27,40 @@ static inline struct tw9906 *to_state(struct v4l2_subdev *sd)
 	return container_of(sd, struct tw9906, sd);
 }
 
-static const u8 initial_registers[] = {
-	0x02, 0x40, /* input 0, composite */
-	0x03, 0xa2, /* correct digital format */
-	0x05, 0x81, /* or 0x01 for PAL */
-	0x07, 0x02, /* window */
-	0x08, 0x14, /* window */
-	0x09, 0xf0, /* window */
-	0x0a, 0x10, /* window */
-	0x0b, 0xd0, /* window */
-	0x0d, 0x00, /* scaling */
-	0x0e, 0x11, /* scaling */
-	0x0f, 0x00, /* scaling */
-	0x10, 0x00, /* brightness */
-	0x11, 0x60, /* contrast */
-	0x12, 0x11, /* sharpness */
-	0x13, 0x7e, /* U gain */
-	0x14, 0x7e, /* V gain */
-	0x15, 0x00, /* hue */
-	0x19, 0x57, /* vbi */
-	0x1a, 0x0f,
-	0x1b, 0x40,
-	0x29, 0x03,
-	0x55, 0x00,
-	0x6b, 0x26,
-	0x6c, 0x36,
-	0x6d, 0xf0,
-	0x6e, 0x41,
-	0x6f, 0x13,
-	0xad, 0x70,
-	0x00, 0x00, /* Terminator (reg 0x00 is read-only) */
+struct reg_val {
+	u8 reg;
+	u8 val;
+};
+
+static const struct reg_val init_regs[] = {
+	{0x02, 0x40}, /* input 0, composite */
+	{0x03, 0xa2}, /* correct digital format */
+	{0x05, 0x81}, /* or 0x01 for PAL */
+	{0x07, 0x02}, /* window */
+	{0x08, 0x14}, /* window */
+	{0x09, 0xf0}, /* window */
+	{0x0a, 0x10}, /* window */
+	{0x0b, 0xd0}, /* window */
+	{0x0d, 0x00}, /* scaling */
+	{0x0e, 0x11}, /* scaling */
+	{0x0f, 0x00}, /* scaling */
+	{0x10, 0x00}, /* brightness */
+	{0x11, 0x60}, /* contrast */
+	{0x12, 0x11}, /* sharpness */
+	{0x13, 0x7e}, /* U gain */
+	{0x14, 0x7e}, /* V gain */
+	{0x15, 0x00}, /* hue */
+	{0x19, 0x57}, /* vbi */
+	{0x1a, 0x0f},
+	{0x1b, 0x40},
+	{0x29, 0x03},
+	{0x55, 0x00},
+	{0x6b, 0x26},
+	{0x6c, 0x36},
+	{0x6d, 0xf0},
+	{0x6e, 0x41},
+	{0x6f, 0x13},
+	{0xad, 0x70},
 };
 
 static int write_reg(struct v4l2_subdev *sd, u8 reg, u8 value)
@@ -65,13 +70,14 @@ static int write_reg(struct v4l2_subdev *sd, u8 reg, u8 value)
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
 
@@ -86,24 +92,28 @@ static int tw9906_s_std(struct v4l2_subdev *sd, v4l2_std_id norm)
 {
 	struct tw9906 *dec = to_state(sd);
 	bool is_60hz = norm & V4L2_STD_525_60;
-	static const u8 config_60hz[] = {
-		0x05, 0x81,
-		0x07, 0x02,
-		0x08, 0x14,
-		0x09, 0xf0,
-		0,    0,
+	int ret;
+
+	static const struct reg_val config_60hz[] = {
+		{0x05, 0x81},
+		{0x07, 0x02},
+		{0x08, 0x14},
+		{0x09, 0xf0},
 	};
-	static const u8 config_50hz[] = {
-		0x05, 0x01,
-		0x07, 0x12,
-		0x08, 0x18,
-		0x09, 0x20,
-		0,    0,
+	static const struct reg_val config_50hz[] = {
+		{0x05, 0x01},
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
 
 static int tw9906_s_ctrl(struct v4l2_ctrl *ctrl)
@@ -195,7 +205,7 @@ static int tw9906_probe(struct i2c_client *client,
 	/* Initialize tw9906 */
 	dec->norm = V4L2_STD_NTSC;
 
-	if (write_regs(sd, initial_registers) < 0) {
+	if (write_regs(sd, init_regs, ARRAY_SIZE(init_regs)) < 0) {
 		v4l2_err(client, "error initializing TW9906\n");
 		return -EINVAL;
 	}
-- 
2.30.2

