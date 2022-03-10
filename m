Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDECB4D424C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbiCJIRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbiCJIRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:17:04 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C441342F2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:16:04 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so7556215pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=UqlG/qlH51JzZZsCgyFBRJweMGZD26FahP+uwp4r9BQ=;
        b=FSykQPtDCQ1wMMLVzooyDgNeZvg0vebosc8YpUWUKsz0xMGoHdez5Xrx+9YJDKnn+i
         rD3Xmudvj5gGZ3vlviX0TbDh/pwPZSic27LxDN1LUg7XX5NneYzM4QgwtA7ncuVzSU/w
         6uJ/5RDzmnKepU4FdBxQw3ZKXBZbM19S1BVWvAHXx8e9Kv/faT43TvyHEaozwqwUb78b
         jjxirwC/D84rrn03DOKiYMjYmjsyFIDm6Fm+KBaFHWogt3sph4RL+FJHK9DMQT7adsZs
         N0/Fz1JPrd30+TkezrquUviXm3ls1n2RDbOvZNXcg+0RnQy96wxXfqE1RHYZUF/Um+s4
         vocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UqlG/qlH51JzZZsCgyFBRJweMGZD26FahP+uwp4r9BQ=;
        b=E+Sa4k80Nvv5qaN2AZOBD3sp34P+xU0g6xP02LtSSe6PuDG7MgTIqWrK5P+oPcipPA
         uQ4hJUoMaEl6dMTzqsFnfZSojo4stxZ3DvtefuAWgHXmcKiJn7Xpvd7wvH6g02wT1hif
         u8Kji6Tahkg/LIY0bdsL2tk3zdkZog7FGIeR01Zko+yf31DKZ0Dq4g2tT07QtNkOZP43
         GGqYpZAkm3dLjiez7G+pCFRKVDVpu/2Ha7CCVEZzBlhYE6YVczYYoaraWpLFZXvhVXVq
         nQ4j1yf9ma3D2b3S8+Yt8gOHNl+l2sF+4mMjCsiM7qfapBIyoZynpgmA5eoydomzavmP
         NDGQ==
X-Gm-Message-State: AOAM532Y9hElWk2oFjx9BeOh5VhgyC33kr1IbZliuz/kxmyECt5c0rvu
        ASThkGuYPTEUS51LTjH89BI=
X-Google-Smtp-Source: ABdhPJy00iGjkiSnCAWiH3WRRptw5KPM3DJ86R40tXtln3/EFo+qhm9Ikg+kT6B002zR9EzRfyoDlw==
X-Received: by 2002:a17:902:d4c9:b0:151:d074:cbe8 with SMTP id o9-20020a170902d4c900b00151d074cbe8mr3840413plg.102.1646900163675;
        Thu, 10 Mar 2022 00:16:03 -0800 (PST)
Received: from localhost.localdomain ([211.212.143.131])
        by smtp.gmail.com with ESMTPSA id q11-20020a056a00084b00b004f73e6c26b8sm5976727pfk.25.2022.03.10.00.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 00:16:03 -0800 (PST)
From:   Steve Lee <steve.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        shumingf@realtek.com, srinivas.kandagatla@linaro.org,
        krzk@kernel.org, dmurphy@ti.com, jack.yu@realtek.com,
        nuno.sa@analog.com, steves.lee@maximintegrated.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Steve Lee <steve.lee.analog@gmail.com>
Subject: [PATCH] ASoC: max98390: Add reset gpio control
Date:   Thu, 10 Mar 2022 17:15:48 +0900
Message-Id: <20220310081548.31846-1-steve.lee.analog@gmail.com>
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
 sound/soc/codecs/max98390.c | 18 ++++++++++++++++++
 sound/soc/codecs/max98390.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index b392567c2b3e..574d8d5f1119 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -1073,6 +1073,24 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	max98390->reset_gpio = of_get_named_gpio(i2c->dev.of_node,
+						"maxim,reset-gpios", 0);
+
+	/* Power on device */
+	if (gpio_is_valid(max98390->reset_gpio)) {
+		ret = devm_gpio_request(&i2c->dev, max98390->reset_gpio,
+					"MAX98390_RESET");
+		if (ret) {
+			dev_err(&i2c->dev, "%s: Failed to request gpio %d\n",
+				__func__, max98390->reset_gpio);
+			return -EINVAL;
+		}
+		gpio_direction_output(max98390->reset_gpio, 0);
+		usleep_range(1000, 2000);
+		gpio_direction_output(max98390->reset_gpio, 1);
+		usleep_range(1000, 2000);
+	}
+
 	/* Check Revision ID */
 	ret = regmap_read(max98390->regmap,
 		MAX98390_R24FF_REV_ID, &reg);
diff --git a/sound/soc/codecs/max98390.h b/sound/soc/codecs/max98390.h
index c250740f73a2..5518f2340247 100644
--- a/sound/soc/codecs/max98390.h
+++ b/sound/soc/codecs/max98390.h
@@ -655,6 +655,7 @@
 
 struct max98390_priv {
 	struct regmap *regmap;
+	int reset_gpio;
 	unsigned int sysclk;
 	unsigned int master;
 	unsigned int tdm_mode;
-- 
2.17.1

