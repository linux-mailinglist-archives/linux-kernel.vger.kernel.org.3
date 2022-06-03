Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EE653CB1B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244958AbiFCN5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244880AbiFCN4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:56:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6731939821;
        Fri,  3 Jun 2022 06:56:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z17so4142417wmf.1;
        Fri, 03 Jun 2022 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3/ArNj3Gx6ysweu6QmWCkRaXZNp/b8pZqhl3nfQBWw=;
        b=ZVsQkdWZwki7857RR0N7O8162fv72qfm+dNqCFCFfzBjAeracnkR3fl6ejkCmmikaG
         JLW0xmoFyX0dds5TZt0BkWXSsoH3gXUqJuSwVcJQ75aO1xVP17MErHY0hNrKmpaRCYMc
         dROl2/1Yw1XLLCEvZ3wSTS2WxgtxNspljGSOmPIAE84ahPukfNsym/pRIOfd6ynt+2ME
         xWMsNG3dhZ3sI0iVN0xpeDUivu1BVsuffwDSo8MkP3QPGBcOEqGLnqu++SPM0XDQypVr
         HPmEJrZNhtrZakZyj65/NnkI3Xtgj6HKfuFbSFcgce2BV18muIsqyRv1MxUVnM3aA/NH
         ZKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3/ArNj3Gx6ysweu6QmWCkRaXZNp/b8pZqhl3nfQBWw=;
        b=SlhuY4DtW+I2cYEUD3XD20nPNQBZTrCO5K6Z+80BTdeGzZCByHN9y97P8p3dI7Lr8i
         0McXwb07kXL21VpML3XMpHybjyZM9T82Zt2qxsoAO5snTGyE/1Yv91TqW3Q5Sj7eXE+C
         dDBg5925Co2jodpUuK/EZg8t3GCVBlU8hmiZjxqXaGBXpl00i/lFzj/9w093y3PtSrKL
         Z3IjqFZA3s+uqAM3txywHq+Trn/kZW5kR5H6N4n3OTPwrqSVGgtrx4ymfm/gtONeYcZ6
         nyM6FEOTc5bHZZHU17DnKViA3AaYTWgCh7YaV3YsDJcE3NqV7d9sqhFnE2g0nzBmQaKR
         w9yA==
X-Gm-Message-State: AOAM5314bMKawy8GZrhTrBpg0flgBbIGYgl8WnpjzRWY6ApTM2pN8Cq5
        4c1SmIDjAndFa7kG0CjuMaE=
X-Google-Smtp-Source: ABdhPJymrL5pMssSod52/digpr5OcG2Is93Lvg1T53T3bk0ng83WgaxLscbYytTDi8SHmV0gTydOSA==
X-Received: by 2002:a1c:f604:0:b0:399:c7a6:44c1 with SMTP id w4-20020a1cf604000000b00399c7a644c1mr9018967wmc.54.1654264602021;
        Fri, 03 Jun 2022 06:56:42 -0700 (PDT)
Received: from localhost (92.40.203.126.threembb.co.uk. [92.40.203.126])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d560d000000b0020fe35aec4bsm7606516wrv.70.2022.06.03.06.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:56:41 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] dt-bindings: iio: adc: axp209: Add AXP192 compatible
Date:   Fri,  3 Jun 2022 14:57:07 +0100
Message-Id: <20220603135714.12007-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192 is identical to the AXP20x, except for two additional
GPIO ADC channels.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../bindings/iio/adc/x-powers,axp209-adc.yaml  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
index d6d3d8590171..1a68e650ac7d 100644
--- a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
@@ -14,6 +14,23 @@ description: |
   Device is a child of an axp209 multifunction device
   ADC channels and their indexes per variant:
 
+  AXP192
+  ------
+   0 | acin_v
+   1 | acin_i
+   2 | vbus_v
+   3 | vbus_i
+   4 | pmic_temp
+   5 | gpio0_v
+   6 | gpio1_v
+   7 | gpio2_v
+   8 | gpio3_v
+   9 | ipsout_v
+  10 | batt_v
+  11 | batt_chrg_i
+  12 | batt_dischrg_i
+  13 | ts_v
+
   AXP209
   ------
    0 | acin_v
@@ -50,6 +67,7 @@ description: |
 properties:
   compatible:
     oneOf:
+      - const: x-powers,axp192-adc
       - const: x-powers,axp209-adc
       - const: x-powers,axp221-adc
       - const: x-powers,axp813-adc
-- 
2.35.1

