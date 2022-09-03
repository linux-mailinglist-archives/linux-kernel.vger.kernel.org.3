Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02575ABBF6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiICA4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiICA4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:56:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5484E9A99F;
        Fri,  2 Sep 2022 17:56:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso7017312pjd.2;
        Fri, 02 Sep 2022 17:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZNNnL0ArxV3UchUohJJ2ySkOJIf+KXfLKML33D2Bf7k=;
        b=bVaAaKdZLy10hzqDxhpmfjwyC/kkz6xkRZTUYcLfYcuylJI2fjAm2Q7TgoVU7Olzf3
         cXDpIFSPa/qkpvjw4FLzF0hPEY1oQPkQmdGMEt2sTUMsMNV7exxB9L9n9dDSzJguxxfe
         0FvKWXJ+5duWII7/fYe9nm4JHJKzin5M65CodOYWzYKYezlkLlIobIujR7gqVH3hIDf/
         Zy5KO7QC8ITH+QbagFqp3mtsFfcVHOX2gR2W8FL2y2SnuGTl7BwS6naxR+vviF8lWgDA
         XLz4d4ul6O4QGYCP2sPtrEqlsP1ub0e+VX6PpY5GPgph99ERtD+JFijsF0aRYwoqUOdb
         dUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZNNnL0ArxV3UchUohJJ2ySkOJIf+KXfLKML33D2Bf7k=;
        b=t9xqbdsMYTGnW1WUEHnONQ24RQrSjausg4cAq5wneWh1TH7cYKTbKxtyTn94S2HQ0b
         /F/12K/FoRovImXltO3anHVVgGFLyLHxd38Stjv8J9qnTOMmYN5/iZcr3Zmo5kSt4fG8
         WgHsveIxjzerYtjWM+Fqrg1KEum99J5jB3bjz8sI3c/7Ql40i5E4AdZE2JFj4MdbK2Rk
         3rCfZ7DOmEYW25pX+Sg5RsPsOtEEfRpAr3TXjSoX6Ea3MWsEwXTpGkiW14mypQinr17W
         9uSQEFhuti1U+CgfLgw9mpQLsB+zUoD5WkLRUTVPv0RTrqbTMX0g8XowVcsPx3yX6pAH
         EmGQ==
X-Gm-Message-State: ACgBeo3WFZ9z8BqoT1fu9pZG0HMsuKBaPDJB70VCssyPQpKYb2Z7ViBv
        utJBdXIyHHk5ri+Yycr7KMxICqHI2I4=
X-Google-Smtp-Source: AA6agR7ENpqU1vibIKXWvd0I//Z20UictvL3atkTGHCZNfEHdCTWz2LWzTss7431Rg49sgEZ7AXtsg==
X-Received: by 2002:a17:90b:38c9:b0:1ff:f240:101c with SMTP id nn9-20020a17090b38c900b001fff240101cmr7283042pjb.143.1662166567693;
        Fri, 02 Sep 2022 17:56:07 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:ea21:afd4:e65e:539c])
        by smtp.gmail.com with ESMTPSA id nn5-20020a17090b38c500b001f7a76d6f28sm2152933pjb.18.2022.09.02.17.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 17:56:07 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v1 1/3] leds: gpio: switch to using devm_fwnode_gpiod_get()
Date:   Fri,  2 Sep 2022 17:55:25 -0700
Message-Id: <20220902-get_gpiod_from_child-remove-v1-1-1e47125df20f@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
References: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-fc921
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

devm_fwnode_get_gpiod_from_child() is going away as the name is too
unwieldy, let's switch to using the new devm_fwnode_gpiod_get().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 092eb59a7d32..ce4e79939731 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -151,9 +151,8 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 		 * will be updated after LED class device is registered,
 		 * Only then the final LED name is known.
 		 */
-		led.gpiod = devm_fwnode_get_gpiod_from_child(dev, NULL, child,
-							     GPIOD_ASIS,
-							     NULL);
+		led.gpiod = devm_fwnode_gpiod_get(dev, child, NULL, GPIOD_ASIS,
+						  NULL);
 		if (IS_ERR(led.gpiod)) {
 			fwnode_handle_put(child);
 			return ERR_CAST(led.gpiod);

-- 
b4 0.10.0-dev-fc921
