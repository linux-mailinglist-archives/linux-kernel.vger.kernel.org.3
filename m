Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0081651A431
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352650AbiEDPmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352431AbiEDPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:42:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77760165BB;
        Wed,  4 May 2022 08:38:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q20so1097116wmq.1;
        Wed, 04 May 2022 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGfHsjidANyyHV7qeZ5govjIF6ESMs4sMWxP9NbcJlA=;
        b=HKTlhRQHU8wuB7Yd31wODGwwRr40WNkmFOUi8rsW6a8U0AAakmd/S8xFQCyz9ygkUq
         KkbnO3jCpSaaRv9Cu18gBVEYgWedbtQIQ7v1QZzQGuem2lXTH4pVkFSZ8ahpG4gb8Yfe
         Owfjb/312vx0W+x6paggOO9TZSNp+AsCeZAPybwqxItFZ26jUv0nBmX5jgh1lR3B8Dx4
         9ZhrgldNc1u5aC2kqKViBqEhO0M1dij+sKZGyYAviJF3LCi6h1y/5MMHTnJIcJWE9QWE
         Ouvdhmn2ZGLH46qpy5POC5U0eZrN8FnHYvns7eKamBnzL/u+7NlTEPqxhMFs0LQw1Bn9
         GFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGfHsjidANyyHV7qeZ5govjIF6ESMs4sMWxP9NbcJlA=;
        b=WPgaZNgsdEG5l3PZVQS/3V/XwMy09Vz3/f7tcmY2dquTfghzV0+kivFpDyZW7bo10h
         O9Yg2MwuzM1v/Jf0twwVOW3QwkQJiHLM/6R0+QU9IKdaLxB9baXSjSe7HVGJXvbX7LXx
         LZBErjZ/Ag8sH87DHkGiq3oz5INvzZ7Ja6q2D05P5EyhPBvUd0LU3brROlNwwUB9/8F+
         u7r6OTRMDi0G2pigyX6fguuXqSCy2lRU7cPDjxcGATA/L97iWe67mfan5urTnu41HWMp
         40tD/3Nkxq3XTgOIkOfYHwOKhrZ5IDar6Srddl3JkBzs+N6Z+ZfQnAY6JBsOf9Oz+ocM
         z24w==
X-Gm-Message-State: AOAM533BjOB2IGAkuez0/R3xd/RXDI6tNvAaEKg3LS2YGL/u0Rc31WkA
        19AHX+UUC9kQ5atihfFazN4=
X-Google-Smtp-Source: ABdhPJzh6RAR1drthFT0i0kt4pF+YyMWOWIHuCbuIALa+gZThkRIq2l8IX27Il5BYGhR0GytSkfC7w==
X-Received: by 2002:a1c:2706:0:b0:391:822c:83da with SMTP id n6-20020a1c2706000000b00391822c83damr46858wmn.100.1651678713085;
        Wed, 04 May 2022 08:38:33 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id e18-20020adf9bd2000000b0020c5253d8besm11792725wrc.10.2022.05.04.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:38:32 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     pavel@ucw.cz
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6 (corrected v2) 2/2] leds: ktd2692: Make aux-gpios optional
Date:   Wed,  4 May 2022 18:38:11 +0300
Message-Id: <20220504153814.11108-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504153814.11108-1-markuss.broks@gmail.com>
References: <20220504153814.11108-1-markuss.broks@gmail.com>
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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

