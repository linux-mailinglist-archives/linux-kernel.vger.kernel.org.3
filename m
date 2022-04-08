Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6534F9AB8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiDHQgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiDHQgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:36:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F0D10A971;
        Fri,  8 Apr 2022 09:34:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j9so7908763lfe.9;
        Fri, 08 Apr 2022 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cChhgUxqUquSxt9/MV0hz1DMxqkQELGYSGZGOjKnMXY=;
        b=XPHg1ZZyWroe2zHgMWYnq2OaPDwRV0W/+Mg6I/WEteIPObhlP7AWhC1Y6tH+wqzwCJ
         AkbU77JCJfgH5J/b614F3Yk+rYiJ0kkorHjEaW+3ASqerwfjxEJiAGtKznLDdxiCij+/
         BaUVr8tOs98EREPi7eVoW22wLPimRHKZhWrAiLmgNfnCzirNxbxNj409lA8POvYv5LoU
         SaLJ5KE3006n8MIq4j5Mvdp/5mO+V83kQMymm/57NU/8j2xC3rf+cGDQpK2GV3e2Kbak
         jJA/kHEA4Y8hOWKk0vZSchrP8GfNjraBdgPGxZ7iFeKT/HoI7yt7rZNmGzcyUumJajUS
         o1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cChhgUxqUquSxt9/MV0hz1DMxqkQELGYSGZGOjKnMXY=;
        b=ID04/VsYg7iRmldIu8VtFhL5xGFhDBlgmIEh50MBMEsoB/KOUnUkPI1otkjY85knkT
         p2mmJ/Mm9B5ByN8xymV1DUNVxjGUTUd9HfS247vERHQrZOvyu1Pgxhcw5+INV9chfOxQ
         zHPok3sCE4QRLKvkn9EKFPncOgG45fg3q4cjsABqbET5QwdlaJCK9ScmLOKcvXJ0B4qe
         E8GEFo16mM9BHLinfx/N+aooJT8QJ4d4AFzVpinCQom7qg0Ij1dhiYPl1QtsEdOfarIO
         phEaY6fSceyS6LkSLRnZdoQmTP1TQ4FntkEgEly2mKy5ReIvsKzL535kRvV+veXqQf+r
         T3gw==
X-Gm-Message-State: AOAM533xyKXh/fusTnRRgymuIwUlr2SI8LcpnTvI1fmdqSezPJMF5KrE
        2WqDKOnUrOoV3jqVV5PYp1Zh6c4S6N4=
X-Google-Smtp-Source: ABdhPJzJm9fP7FHt9SJzUQD5SShZf1ryBdWk3MHN43jMhhAgxzXqSMavPhRjqZB0DrekOSSraMeDCA==
X-Received: by 2002:a05:6512:308a:b0:44a:96cf:7ceb with SMTP id z10-20020a056512308a00b0044a96cf7cebmr13008771lfd.1.1649435649340;
        Fri, 08 Apr 2022 09:34:09 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id q4-20020a0565123a8400b0044a27a8c63asm2495403lfu.80.2022.04.08.09.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 09:34:08 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 2/2] leds: ktd2692: Make aux-gpios optional
Date:   Fri,  8 Apr 2022 19:33:28 +0300
Message-Id: <20220408163330.200898-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408163330.200898-1-markuss.broks@gmail.com>
References: <20220408163330.200898-1-markuss.broks@gmail.com>
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
 drivers/leds/flash/leds-ktd2692.c | 7 +++----
 2 files changed, 9 insertions(+), 4 deletions(-)

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
index f341da1503a4..26edf41dfa7d 100644
--- a/drivers/leds/flash/leds-ktd2692.c
+++ b/drivers/leds/flash/leds-ktd2692.c
@@ -284,10 +284,9 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 		return ret;
 	}
 
-	led->aux_gpio = devm_gpiod_get(dev, "aux", GPIOD_ASIS);
-	ret = PTR_ERR_OR_ZERO(led->aux_gpio);
-	if (ret) {
-		dev_err(dev, "cannot get aux-gpios %d\n", ret);
+	led->aux_gpio = devm_gpiod_get_optional(dev, "aux", GPIOD_ASIS);
+	if (IS_ERR(led->aux_gpio)) {
+		dev_err(dev, "cannot get aux-gpios: %d\n", ret);
 		return ret;
 	}
 
-- 
2.35.1

