Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85985AF42D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiIFTGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiIFTGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:06:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D03AD53
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:06:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f24so12240772plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=7KHx1Yv+hEk7Y/hrqYv9UfQMba4m3xWqmPYWeA+BX2E=;
        b=ADvCai+SyN5W/C1ulJZkXa/VUtB8IPbdCUo9Hjg+bjvUMWufJOrVmDpI2ulbN+NF6/
         RptOGkIaxmGO94Dtc0R3vP+PLHRYa1wRCSj2fuLDOVatGtj2SCtlVTmwD/WC/HOsdSWJ
         DJp+70JAAxw3XgPcrBBu5mPFk+12vE5/oKvVr5tR1BiT28dqOyF0IigsD2k0opCIG+gN
         iGep6N+bWxVA8l0S+DBto68rXPyVicnEjRi8ugKCWTMEe7W7fqcw5DgvlkRGCrLbNsQN
         Ou1Dq2jSL2IEPsmM0nnJc+GGAbPHq6jyQqAL22B6c7GFIe9F2sKCOJde/t422hBhtVzB
         He4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7KHx1Yv+hEk7Y/hrqYv9UfQMba4m3xWqmPYWeA+BX2E=;
        b=DjIiVH501nmlRzBhRIcVHG+TOvLBa9+ur1RoBOFsAypuWfyzoSWBCVN3iYhJ+WMXC4
         GvBmM3uVYjmMZ6VylwM+ZYwQqg/sUbW3gePLcxHg9WcN5UBVCEOkyOb1cMIILpccJhx3
         yqVVNohTPdXj31NkA6U3q5sgcyDhmpwSYeuBQvMvkq5X0LLEcC4+71dwCVkvyZpjuCHi
         DuFApidZvy/0d2sv4a5Bq6T9zhW3S7cqgNjupue6opvuMX7tha4lJHoKXuDOICqWGaPI
         NVZi2hY2VOkJCUsmIzNLEU59ocJU62Ux2u1jIkvqxTq+tfgZL9FiA5J82ChXYYOk4REw
         Fr0A==
X-Gm-Message-State: ACgBeo0uTp4sja4rDEFTCwrTaTjQsegAllPr0i1qDuywt1VbfdA39LPz
        Ugi2ez6eZLdLwi7EAHkf4/k=
X-Google-Smtp-Source: AA6agR6E2NBlUJFJ4G2LFfqZzaBJliai50FugTV+4NYqpWcHIbzDHOZ4xJASIg5wpD8TwMM4+U3CdQ==
X-Received: by 2002:a17:90b:2242:b0:200:1c81:c108 with SMTP id hk2-20020a17090b224200b002001c81c108mr18779670pjb.89.1662491172521;
        Tue, 06 Sep 2022 12:06:12 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1190:fbfa:ae95:111c])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902da8400b0017297a6b39dsm10445347plx.265.2022.09.06.12.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:06:12 -0700 (PDT)
Date:   Tue, 6 Sep 2022 12:06:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: simple-card-utils: switch to using gpiod API
Message-ID: <YxeaITtlJexygQo9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches the driver away from legacy gpio/of_gpio API to
gpiod API, and removes use of of_get_named_gpio_flags() which I want to
make private to gpiolib.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 sound/soc/generic/simple-card-utils.c | 28 ++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 1b201dd09259..bef16833c487 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -9,7 +9,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_graph.h>
 #include <sound/jack.h>
 #include <sound/pcm_params.h>
@@ -729,12 +728,12 @@ int asoc_simple_init_jack(struct snd_soc_card *card,
 			  char *pin)
 {
 	struct device *dev = card->dev;
-	enum of_gpio_flags flags;
+	struct gpio_desc *desc;
 	char prop[128];
 	char *pin_name;
 	char *gpio_name;
 	int mask;
-	int det;
+	int error;
 
 	if (!prefix)
 		prefix = "";
@@ -742,36 +741,39 @@ int asoc_simple_init_jack(struct snd_soc_card *card,
 	sjack->gpio.gpio = -ENOENT;
 
 	if (is_hp) {
-		snprintf(prop, sizeof(prop), "%shp-det-gpio", prefix);
+		snprintf(prop, sizeof(prop), "%shp-det", prefix);
 		pin_name	= pin ? pin : "Headphones";
 		gpio_name	= "Headphone detection";
 		mask		= SND_JACK_HEADPHONE;
 	} else {
-		snprintf(prop, sizeof(prop), "%smic-det-gpio", prefix);
+		snprintf(prop, sizeof(prop), "%smic-det", prefix);
 		pin_name	= pin ? pin : "Mic Jack";
 		gpio_name	= "Mic detection";
 		mask		= SND_JACK_MICROPHONE;
 	}
 
-	det = of_get_named_gpio_flags(dev->of_node, prop, 0, &flags);
-	if (det == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	desc = gpiod_get_optional(dev, prop, GPIOD_IN);
+	error = PTR_ERR_OR_ZERO(desc);
+	if (error)
+		return error;
+
+	if (desc) {
+		error = gpiod_set_consumer_name(desc, gpio_name);
+		if (error)
+			return error;
 
-	if (gpio_is_valid(det)) {
 		sjack->pin.pin		= pin_name;
 		sjack->pin.mask		= mask;
 
 		sjack->gpio.name	= gpio_name;
 		sjack->gpio.report	= mask;
-		sjack->gpio.gpio	= det;
-		sjack->gpio.invert	= !!(flags & OF_GPIO_ACTIVE_LOW);
+		sjack->gpio.desc	= desc;
 		sjack->gpio.debounce_time = 150;
 
 		snd_soc_card_jack_new_pins(card, pin_name, mask, &sjack->jack,
 					   &sjack->pin, 1);
 
-		snd_soc_jack_add_gpios(&sjack->jack, 1,
-				       &sjack->gpio);
+		snd_soc_jack_add_gpios(&sjack->jack, 1, &sjack->gpio);
 	}
 
 	return 0;
-- 
2.37.2.789.g6183377224-goog


-- 
Dmitry
