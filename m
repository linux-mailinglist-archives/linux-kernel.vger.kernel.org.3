Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634854E8BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbiC1CNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiC1CNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:13:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905904ECD6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 19:12:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jx9so12653076pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 19:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=rUHIWinBLG6g3Xi9+MUcsHpYsUZn1UkahgGOhqUSwAo=;
        b=ByyC85NIdi1Ve9pqan/WfzM2XYMfuKn3CCtZANGGya2Ss2oL4SZYsyVnf0OEXVxqM+
         NlWfBOfMsvpFMBHl8ERRxXmXQtuzccHXUlYyM9m/uRKOMCz6QzS5xAaSboA5lDQTSx2s
         yt2c+lBVhmyV/cfJpPpmzbZ+WnXCRFdcJbXGrmGyKdiEyIlle0UKaNumtHMKD09ZyvRo
         ER4DmEYTfjFQdFg2653XMB3h3c9hvLkq1PQhnPmvKj9+lAr9lO/Ptwejnqm9oYLDjgvI
         H34KW+QREWOLw0hNIHLsV5CUhGPPFHIdlB8xooOeY1/e4UyH39Zh23M1Hn6d9sJWL8np
         7Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rUHIWinBLG6g3Xi9+MUcsHpYsUZn1UkahgGOhqUSwAo=;
        b=a+IxkWe2PP7a9qbV9LIX+S31+oDk30pxTbp5zPYZMR81lxgf7Kq17wMU8+dYhczp/c
         mQSQKqkYEN8/PPzEyYxEx72uwkn6O22dFSaAvuKHNZgW6UoMZXM6HVjUxcnrQ200KnUD
         tmriM9tMVuIbpygJTIdRN9QXCjsYIEYq3gZwf/TTo8eYkrhVApPEydPPPanO4UgLZI/k
         BP2cyvJs4SbPDwPgBn1a3Jzghw95A+PgnxFAwtl74s1TfDChNi7i0E5o3k4JG9vJ3PE9
         wKSSt46rnSXGYjr5ZB3CrN9gMf5iIDAv44TtxFCBIUgqMR2XlMBd9HNpPrnF3LEA/BWe
         aKRQ==
X-Gm-Message-State: AOAM532PDp5SDEAKrA/dhtb/c1ezcXppe64r47yPTLCeKZxIso9wmDiy
        KqwOD8OW+QxQx+A3IyedsXI=
X-Google-Smtp-Source: ABdhPJw/rhtmPMAo55tnqm5NaD1eJHN71Eb8+RgZ283zFRwrUZKw9etqglyxTYSO75pWg2fPCGMGdg==
X-Received: by 2002:a17:902:9a8d:b0:155:ff17:c9fc with SMTP id w13-20020a1709029a8d00b00155ff17c9fcmr7396091plp.28.1648433525098;
        Sun, 27 Mar 2022 19:12:05 -0700 (PDT)
Received: from localhost.localdomain ([211.212.143.131])
        by smtp.gmail.com with ESMTPSA id c63-20020a624e42000000b004fa9ee41b7bsm13322058pfb.217.2022.03.27.19.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 19:12:04 -0700 (PDT)
From:   Steve Lee <steve.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ryans.lee@maximintegrated.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     krzk@kernel.org, nuno.sa@analog.com,
        Steve Lee <steve.lee.analog@gmail.com>
Subject: [V3 1/2] ASoC: max98390: Add reset gpio control
Date:   Mon, 28 Mar 2022 11:11:38 +0900
Message-Id: <20220328021139.8700-1-steve.lee.analog@gmail.com>
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
index 40fd6f363f35..05df9b85d9b0 100644
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
+					     "reset", GPIOD_OUT_LOW);
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

