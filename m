Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93A54D6267
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348909AbiCKNa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346052AbiCKNa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:30:56 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7120093188;
        Fri, 11 Mar 2022 05:29:53 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id cx5so8171168pjb.1;
        Fri, 11 Mar 2022 05:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=lWnNWcx+SboqtPq9WI7B/BLf7BDyEwBuicgeSMUjIxY=;
        b=CI2lfgcC0JOTIFvd4yDLT3+LWmWjTs5HWYaKKWWWBU97Q9NR/plDDe0BG3emS2zFKB
         +PJDSRQC719268FrWzd6QkLdlmk0gVmCBDJok4gCU8MnZ/0SRRUhP0gGlKoebPC+zHzO
         zOQRl9LlHG6abAWeq3UVrxPIE/ip2pXQRjjjb9O5VwHcZG1FCNZTU/DuAxpPk9S7v2J8
         PvnhwSHFwfCvh6aX1eBI5E6w+9QtXlEam++fKNpT6NmS/HpMMKfCg3QngORtBnRb/f2M
         YLQXFYXmISlNn/Few8+6us2FBav5lVbBA9/3HjYoS9YLk/IVlPUywlRlU9ayBI30Ih/s
         Yn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lWnNWcx+SboqtPq9WI7B/BLf7BDyEwBuicgeSMUjIxY=;
        b=iY6DAJFXeFd2NLcw01C0KA1SxLZIydEu17aNWLq/y237y845glNZH5zsG5AwDsB4Q2
         5o8lxiARvPrGai1iCgq6kWEJEwFl2rvefKOg7P/OvS+jSNLhJXMH2wMfUbmGFDSDNP1h
         YGY17bJZ7Bt29TV6dnzivGzOtN7MfXTRgH87TSztG4im2QIDvr6+DrmwG9XDbAfuudHg
         HIDA6BSfGxwzIif5DoJ1v4t+R9k1OKbrEzv+kPUnbwgT7J1pCEgBBAKyH5LDVjWNNeLU
         aOiOGfkogNpQtx0Ch0rB7A3m2nGIAO1pDRQ+G3ftFkWEbBQo83oIGIiLbHF4gxGqONv4
         lwbw==
X-Gm-Message-State: AOAM5327WYTU6XNR/4mTo5Pj/HuqsKyxrwLcGY4dn7IhJrvUlt2vVuLr
        MAyIO2fcOZXKpUs/8XmzdT8=
X-Google-Smtp-Source: ABdhPJwNo2sTsZyi47iCLuC+XNJ4MMfgBohTLUQ/Ge/2csyWYtjNvf7ShW0r3I+OCg63OmoQHP2JUw==
X-Received: by 2002:a17:902:b490:b0:14c:da4a:deca with SMTP id y16-20020a170902b49000b0014cda4adecamr10745394plr.134.1647005392946;
        Fri, 11 Mar 2022 05:29:52 -0800 (PST)
Received: from localhost.localdomain ([211.212.143.131])
        by smtp.gmail.com with ESMTPSA id l17-20020a056a0016d100b004c34686e322sm11319934pfc.182.2022.03.11.05.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 05:29:52 -0800 (PST)
From:   Steve Lee <steve.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryans.lee@maximintegrated.com,
        Steve Lee <steve.lee.analog@gmail.com>
Subject: [V2 1/2] ASoC: max98390: Add reset gpio control
Date:   Fri, 11 Mar 2022 22:29:05 +0900
Message-Id: <20220311132906.32292-1-steve.lee.analog@gmail.com>
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
 sound/soc/codecs/max98390.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index b392567c2b3e..5c6162701667 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -1022,6 +1022,7 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
 
 	struct max98390_priv *max98390 = NULL;
 	struct i2c_adapter *adapter = to_i2c_adapter(i2c->dev.parent);
+	struct gpio_desc *reset_gpio;
 
 	ret = i2c_check_functionality(adapter,
 		I2C_FUNC_SMBUS_BYTE
@@ -1073,6 +1074,17 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	reset_gpio = devm_gpiod_get_optional(&i2c->dev,
+						"maxim,reset-gpios", GPIOD_OUT_LOW);
+
+	/* Power on device */
+	if (reset_gpio) {
+		usleep_range(1000, 2000);
+		/* bring out of reset */
+		gpiod_set_value_cansleep(reset_gpio, 1);
+		usleep_range(1000, 2000);
+	}
+
 	/* Check Revision ID */
 	ret = regmap_read(max98390->regmap,
 		MAX98390_R24FF_REV_ID, &reg);
-- 
2.17.1

