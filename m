Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02AA51ADE3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbiEDTjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377571AbiEDTjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:39:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4371C13D;
        Wed,  4 May 2022 12:35:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e2so3343833wrh.7;
        Wed, 04 May 2022 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pd70Q4kWObWSujRxWPRUBFu3tMsCwi7TVBTLrG5xt18=;
        b=RIyrV26bXmtm94kY9IFJlcdISavl7bv95wd4i912RKfrRErbLp4Ff0AaWe8rY8wSCp
         uKP1STMiIGzG1rYqqwErdqQkCDSdqqxJt1l7yXKh1KuiDOYC5n/lBg3Xek1N6Z7S3XYB
         i278bW1tZEkjSBXac8pvFHS7LIik7Eyy3LkcvJP5c3ECS4GYVBoXGV4uEVyBlulOJRsq
         cD9DMa4A/e2Vci97K69aQm45aRrZ/oqTmxqi5lfc2AXQBwlyHBbYx+YlJ4WN/5IANGq6
         t09WZSXjfqS5qaiq96mahg91N47iHT7r7Aaa1zOXcZLDX1sbFjm5+nbKNPQHaPnpoIFr
         puyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pd70Q4kWObWSujRxWPRUBFu3tMsCwi7TVBTLrG5xt18=;
        b=fQ4ZxicaBjHb1SOX4k9iwuSb+5OxxauDVb9bFPnTviqnGG743rTiZNYwiFutN59wkN
         4v6WRMyYn7u/TXVti0cMNzWxbr/D3WPcMYaJe7B11I/+NELD+TzbeqpUpczoB/2oIoNi
         lr3TFy1xyB3tM/grZE64hBRp25Sd0WKGqyUNeopJ/Vdl729vyykcr3QdOig7nX9hoMOB
         60S8fNDmhxDFHQz+6hYjRvrYVqILxZV/oP8z4vrZrEm90Imt4zZShKqvLBP0psQ8V37N
         ugmrfyzaXX1yFmUiaJGsS8dJW1W5y4UrPfUNaRgB9QzH++rO5w5U6G78EXPAS+rFIFXX
         P8/w==
X-Gm-Message-State: AOAM533ZxkZvbX6xcyHv2LK5OjMy+gT4zjPJqcvjLTN6hmWhq9TspTAR
        elsGwfzPZ9Y9uMbw3TGxG67EYHWDQis=
X-Google-Smtp-Source: ABdhPJxsC8Z1xAfENXiVAtjB8zOJtFn885Jmd3oBmZJtFMghavGiy424SmkYi9GZjac2kWwzolMUMQ==
X-Received: by 2002:a5d:64a6:0:b0:20c:64ef:c9cc with SMTP id m6-20020a5d64a6000000b0020c64efc9ccmr12003206wrp.190.1651692926854;
        Wed, 04 May 2022 12:35:26 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 67-20020a1c1946000000b003942a244f2csm5519358wmz.5.2022.05.04.12.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 12:35:26 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     pavel@ucw.cz
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] leds: ktd2692: Make aux-gpios optional
Date:   Wed,  4 May 2022 22:34:36 +0300
Message-Id: <20220504193439.15938-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504193439.15938-1-markuss.broks@gmail.com>
References: <20220504193439.15938-1-markuss.broks@gmail.com>
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
 drivers/leds/flash/leds-ktd2692.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
index ed1f20a58bf6..1736b3f6b899 100644
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

