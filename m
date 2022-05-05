Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB2651C3E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381321AbiEEP3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381319AbiEEP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:29:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92E41E3D8;
        Thu,  5 May 2022 08:25:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b19so6567451wrh.11;
        Thu, 05 May 2022 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ybTkx6rA0JAuYcJUqRmvgRvg+0luA63XlWmRsPCeM8=;
        b=dJ8cydMX9FOIbOpK9JdIwEQdc9E34teovf6xkKcexTYYvZ/UEltM7h1R3IYfKxZE/V
         nuVWteafrtfSMQScAdqAis9KGXsueSB3PfChG9hYNDveQ9Wy3+eXjGAgSemZgU4Wm7mW
         D+dYd1E1jVLYH50sjhw4yg9kbGXS5RgTV7wY+9Nl14Gt6UuuWNFFHbxaoHkR7UVXq8UJ
         qfgUiZ/qI1E38VT5pnjOfG9is+dGwjij7Jacs+BDI5oAsbX9f8RKubMsfW1R5LCWYgAH
         MaWNIJz7WF06iMPhnhQeprmwe68LzNQ68tGyXprxK9+uGCe7myTg7PiBWQK68VL4eAtb
         n/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ybTkx6rA0JAuYcJUqRmvgRvg+0luA63XlWmRsPCeM8=;
        b=RavYU8F7myoilyoMi283zohDsDQ4ryIk48mpuovSYwco5O3uJRgRzNKns8XpzV5B0t
         PwirFmZ4eB9kJ0hF2KUq/gYv9fltIxR5IQjLsQljkI7nnE6KIZS7BWfFcg19K4ixW+xL
         cBsVVvGZ+/kUHVj9nmOQVJSodv0+4e52co1LVKmsooYngFt/FMhhWTDlp5t4+i/CFWPV
         fHgHElUJXK/6Iox1EYFgt6VjLLlXCS57gJRvT8/+DHNtqgEiuVYDKOSnXxUlPdB2io0G
         RLrI7hSXC+D2Ol4aFUYqs58hFT0lkWmd4p3VsjRDP3TGScaId1iCLniMDHO7INn3vLFV
         GOTA==
X-Gm-Message-State: AOAM531zwEKE4LW9kMj3BnvOIFxvdWx0mMVeFEFKV2sob5WKxlGQ0TWR
        mqJZISC6iVd3Cr+9wBc2N00=
X-Google-Smtp-Source: ABdhPJw0l6J7pD3el/9XgOffymMj9tx4ej6pWGw53HaiHwRn+AC4bVz9CUr3R4YeQ2N7FKERq6fRLg==
X-Received: by 2002:a5d:53c5:0:b0:20a:cf17:717c with SMTP id a5-20020a5d53c5000000b0020acf17717cmr21071578wrw.252.1651764341406;
        Thu, 05 May 2022 08:25:41 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600016cc00b0020c5253d8e4sm1578679wrf.48.2022.05.05.08.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 08:25:40 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     pavel@ucw.cz
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/3] leds: ktd2692: Make aux-gpios optional
Date:   Thu,  5 May 2022 18:25:18 +0300
Message-Id: <20220505152521.71019-4-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505152521.71019-1-markuss.broks@gmail.com>
References: <20220505152521.71019-1-markuss.broks@gmail.com>
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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/leds/flash/leds-ktd2692.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
index 8b99742cb68a..670f3bf2e906 100644
--- a/drivers/leds/flash/leds-ktd2692.c
+++ b/drivers/leds/flash/leds-ktd2692.c
@@ -282,9 +282,8 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 	if (ret)
 		return dev_err_probe(dev, ret, "cannot get ctrl-gpios\n");
 
-	led->aux_gpio = devm_gpiod_get(dev, "aux", GPIOD_ASIS);
-	ret = PTR_ERR_OR_ZERO(led->aux_gpio);
-	if (ret)
+	led->aux_gpio = devm_gpiod_get_optional(dev, "aux", GPIOD_ASIS);
+	if (IS_ERR(led->aux_gpio))
 		return dev_err_probe(dev, PTR_ERR(led->aux_gpio), "cannot get aux-gpios\n");
 
 	led->regulator = devm_regulator_get(dev, "vin");
-- 
2.35.1

