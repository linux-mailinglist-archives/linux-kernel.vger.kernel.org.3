Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85903508048
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 06:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359348AbiDTEwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 00:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbiDTEwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 00:52:01 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23912275D4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 21:49:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t4so546478pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 21:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=F+SNI6ZhHsirUO9usNliSeUPedFWMdKyf9VNSlCdVbY=;
        b=c4KMrt+fwRje0c7WzOZQubm2Gpc13Z+BKkK+K6SoqWf7LTdw68mI7t6Z6Cfkf0TiNY
         E7i0SuiB9EPgX5yUoFfspleKuNib8po0ItT5myeK3+qa8+42qE+H8nU2kJGn/83rn0RO
         U6470hFqvwycQn3JUTjwSRiZRi23veobH195i9RNCtKheEiP9swwicPa98xfYFQr9Odm
         M6Gpa8ooYnX16610o0STT8AZonBO+AIN9hv/vT9CAA+tqI0alSbfsECfuAaarafNQdla
         /ZNBd+z7RkgpVxQpEBzFvQ7GB5cU5d7yq41zo9KwurtZVN6u15jPDaPk4Epms02+jbFr
         XyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F+SNI6ZhHsirUO9usNliSeUPedFWMdKyf9VNSlCdVbY=;
        b=z5h+1sJn1XOdhoo7WRQrAEX84ikX4twEpo6aSf/TJgBwak/pIWOKohLBpt+TuhfRcC
         0wQEqvHhWnM3EpL44t+XMvAWBwCapaNGDtNtReJV59VdSjogBPORuzufhfHWH4NU/gCf
         M45DnBfG5VLimhlYM57vWAVAgikvdmsxLIb0uM5fqxasHOd0uJHGG41InG3oNtsCP2PI
         sDtR0d6oC+IQIzsgwNp7kYy6cmz7Z5m8X8MZozG3fxtpf2Ir73B1VfuSvO4KqtDiw3dG
         M7OWbLaINlUi5yWiTdpekCUv44dYsPQSq5gnmcp+3EkV9UVJCvRSMNftyLfhqkBtzJnG
         o7yQ==
X-Gm-Message-State: AOAM53258EpQ019x6W8mLouPGzeTxFNgakNOr4QO8P7dEnNBLRyeBxqX
        C4Jv7jF4eFmmok+1X4m6uho=
X-Google-Smtp-Source: ABdhPJyRBK4IecUu8kA+XNAbcJU+Yc1QJ5QFkvvT2Vi+gKVJH9tNsi1WUtHoYam7N5VPv83WMhxMag==
X-Received: by 2002:a05:6a00:2442:b0:4fd:8b00:d2f with SMTP id d2-20020a056a00244200b004fd8b000d2fmr21364305pfj.39.1650430155675;
        Tue, 19 Apr 2022 21:49:15 -0700 (PDT)
Received: from localhost.localdomain ([211.212.143.131])
        by smtp.gmail.com with ESMTPSA id o3-20020a056a001bc300b0050a7b7257b2sm7957225pfw.25.2022.04.19.21.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 21:49:15 -0700 (PDT)
From:   Steve Lee <steve.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     krzk@kernel.org, nuno.sa@analog.com, ryans.lee@analog.com,
        Steve Lee <steve.lee.analog@gmail.com>
Subject: [V4 1/2] ASoC: max98390: Add reset gpio control
Date:   Wed, 20 Apr 2022 13:48:59 +0900
Message-Id: <20220420044900.2989-1-steve.lee.analog@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Add reset gpio control to support RESET PIN connected to gpio.

Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
---
V3 -> V4: change reset gpio control as GPIO_ACTIVE_LOW in DT

 sound/soc/codecs/max98390.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index 40fd6f363f35..bdfd6cccc3d2 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -1022,6 +1022,7 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
 
 	struct max98390_priv *max98390 = NULL;
 	struct i2c_adapter *adapter = i2c->adapter;
+	struct gpio_desc *reset_gpio;
 
 	ret = i2c_check_functionality(adapter,
 		I2C_FUNC_SMBUS_BYTE
@@ -1073,6 +1074,17 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	reset_gpio = devm_gpiod_get_optional(&i2c->dev,
+					     "reset", GPIOD_OUT_HIGH);
+
+	/* Power on device */
+	if (reset_gpio) {
+		usleep_range(1000, 2000);
+		/* bring out of reset */
+		gpiod_set_value_cansleep(reset_gpio, 0);
+		usleep_range(1000, 2000);
+	}
+
 	/* Check Revision ID */
 	ret = regmap_read(max98390->regmap,
 		MAX98390_R24FF_REV_ID, &reg);
-- 
2.17.1

