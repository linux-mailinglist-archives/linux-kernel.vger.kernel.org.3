Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA84F9D25
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbiDHSnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiDHSn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:43:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1ED190B77;
        Fri,  8 Apr 2022 11:41:24 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p15so16517524lfk.8;
        Fri, 08 Apr 2022 11:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hss05uUSr3Uc3Gs0kDe2glyZ50kr35XM4twyAZx/Q7g=;
        b=BiLeBiNJ4IU0JKxxJwQ/+tsSbDO8w926u868ywMqvgqSx1ECrq4SQRpVmiNHU8xInz
         I08n30WH55Fgmj3kKdizeFitibHvWRfJ+NsJTlIyX3sdgo/gRX0ApYXQGo25hnxeJH0o
         IchXYwrlNxr6YCxsOjzty/dlQUst72RcEKFB94cZQmdku2lU5NqQ0A/pCZ174EZIuQ/G
         NDJjCwqsKNMQ+C1AgoYTSwvcopDsdbP1FuCdqKlEJCIwmJSmCRO9iZsF0b0rdGJ9aEN6
         0EQEV3Si86ME/BVSZL7hEeg+9PTpDY5FO2NxDfT6C98SSDTFdo8hVrj9SYMbeD4Q8oZU
         GSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hss05uUSr3Uc3Gs0kDe2glyZ50kr35XM4twyAZx/Q7g=;
        b=3GN4UqsGcXE1so6MDu2e+4FtEXttIJ+xKHl3EY0R0TRSFXLNh8+1RR9KKZjQzi/OrO
         iumRqZBEPUL8Tz2lSzJkvgUMzQhEsOnAE/YeMyoRiN4sL4dFv5W6nxeRsUjs3W3E5Lq2
         fk6R0OHgLZ/bEd/KmoD4XjlsJephSB5cMo1qwTCOPsSnFmCLtl5mS+hWp+6ciHN6cTuA
         PZqkUfBEQYLC9ONsuQ6qPRU/JjGUoueWSTg3jf8eFgRewA7/NC8UprFDY1ijRDoVB8AH
         n4KR9TTOqSdEWGCFU97UP1J6yX0q7Ijsa1vWxiCAHZMZy+9lChhuBrwkf1KhTeYPyC3u
         E2KQ==
X-Gm-Message-State: AOAM533zNLFCqD/ix8ua+Fi2eTiocbWirwyyhm8l6J7zUro0geiynjKk
        ob4WdwLV/xEt5/+iMBiVel14pQ+0XS8=
X-Google-Smtp-Source: ABdhPJy/Vqtt6+tWHlLIytsK6143rCKFf7AKlW6x1FLCTH0jDJY7ZEmgYaHrNxzFJSHIFIY2fBqhtQ==
X-Received: by 2002:ac2:5619:0:b0:464:f76b:cace with SMTP id v25-20020ac25619000000b00464f76bcacemr5412057lfd.437.1649443282346;
        Fri, 08 Apr 2022 11:41:22 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id v17-20020a2e9f51000000b0024b006037eesm2301201ljk.139.2022.04.08.11.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 11:41:21 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 2/2] leds: ktd2692: Make aux-gpios optional
Date:   Fri,  8 Apr 2022 21:40:55 +0300
Message-Id: <20220408184104.13665-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408184104.13665-1-markuss.broks@gmail.com>
References: <20220408184104.13665-1-markuss.broks@gmail.com>
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

Make the AUX pin optional, since it isn't a core part of functionality,
and the device is designed to be operational with only one CTRL pin.

Also pick up maintenance for the LED driver and the yaml bindings.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 MAINTAINERS                       | 6 ++++++
 drivers/leds/flash/leds-ktd2692.c | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2db49ea7ae55..8ef5667a1d98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10479,6 +10479,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd253.yaml
 F:	drivers/video/backlight/ktd253-backlight.c
 
+KTD2692 FLASH LED DRIVER
+M:	Markuss Broks <markuss.broks@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2692.yaml
+F:	drivers/leds/flash/leds-ktd2692.yaml
+
 KTEST
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	John Hawley <warthog9@eaglescrag.net>
diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
index f341da1503a4..01ceea83af67 100644
--- a/drivers/leds/flash/leds-ktd2692.c
+++ b/drivers/leds/flash/leds-ktd2692.c
@@ -284,9 +284,9 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 		return ret;
 	}
 
-	led->aux_gpio = devm_gpiod_get(dev, "aux", GPIOD_ASIS);
-	ret = PTR_ERR_OR_ZERO(led->aux_gpio);
-	if (ret) {
+	led->aux_gpio = devm_gpiod_get_optional(dev, "aux", GPIOD_ASIS);
+	if (IS_ERR(led->aux_gpio)) {
+		ret = PTR_ERR(led->aux_gpio);
 		dev_err(dev, "cannot get aux-gpios %d\n", ret);
 		return ret;
 	}
-- 
2.35.1

