Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2BC51A32B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351889AbiEDPKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351865AbiEDPKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:10:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F8121822;
        Wed,  4 May 2022 08:06:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so3391039wms.3;
        Wed, 04 May 2022 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yb/evyWqaNixsLW2kxwJWCdv52JEaXEGCeVAcoqx36g=;
        b=UoJRUOku+Y5L4dmp7tDz9wPK5709yjvuajXhr+DZmwvqcJieFzkkO1qUpNnwlAJN8W
         CXVuT1gyUNPyGr1foBcskQwExbC3ZhWTSMRZkL2nzQRKdtKDoscDeofCxtnz3ZiSYzaV
         T31f6NnQ7iBiaUcZg6+St17jbrSuxrkjdQ/EPdI8ejQQF2gaPExkw1FwGuoMdY2CEHuq
         HkVtcdc3RbnQQZDz1GZMvwrAqSzm1KZ1KWlRk8nox1MgsePF0e2Tp034hdMGu+mMXgcL
         ift+Jaokypbs9waLHaYQDKOEDmV3J/Fhwm1yldyuA80+l3ripsWJbqQ/Ae24aKTGHTpW
         j53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yb/evyWqaNixsLW2kxwJWCdv52JEaXEGCeVAcoqx36g=;
        b=wQ1Xl/QvApMijcK1xb3gm+2Xh+hmSV7Y4sPmJnS9IcO8NdKY9RkBeUPBqxI5plqfEx
         W5boXDuipy9X8w1QCn51z25wosHR9eZ4jIsABOGUzmfQqsMvkkWZN4vKF+4le+YTuzaj
         bJXf/ILL/eWLGC7hlGa461PP9BG0/xkzElSEMQ/azuG2ajHwtbGzK7vF9zp3ohHTfpD5
         BAMYciuu9h9uNqmz+HMS6SHnb+GY/1b1g6EPmo2+Jsuy+zUSY2XEVpXFXJAdn1AbWsA2
         TmPsVWm0puxxHUP77HBzz/tJLtf6kx59AtcbFivOo3vOQx50DRxmeRWNgx+ngNNLuQ3T
         30OQ==
X-Gm-Message-State: AOAM532Z41NrvmlYILK3t+9RRbBC9GnXK2pQ66yzx/0CHid1WgH9LIb4
        8QMgm7A9trE9fnWUmWLRZIc=
X-Google-Smtp-Source: ABdhPJyXHyoVksCuq8+mhIBxrsoR9GlQ7k+6D18WjCHanh4pORoyL0mATlWtjWk6Q5v30M+bi4swAA==
X-Received: by 2002:a1c:2c6:0:b0:38f:f280:caa2 with SMTP id 189-20020a1c02c6000000b0038ff280caa2mr8031383wmc.87.1651676815484;
        Wed, 04 May 2022 08:06:55 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id q14-20020adfaa4e000000b0020c5253d91fsm12143596wrd.107.2022.05.04.08.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:06:55 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     pavel@ucw.cz
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6 2/2] leds: ktd2692: Make aux-gpios optional
Date:   Wed,  4 May 2022 18:04:11 +0300
Message-Id: <20220504150457.5626-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504150457.5626-1-markuss.broks@gmail.com>
References: <20220504150457.5626-1-markuss.broks@gmail.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>

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

