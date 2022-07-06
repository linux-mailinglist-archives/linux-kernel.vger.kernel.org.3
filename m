Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BB0568526
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiGFKSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiGFKSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:18:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0A125C77;
        Wed,  6 Jul 2022 03:18:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b26so21385617wrc.2;
        Wed, 06 Jul 2022 03:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h68PRQAH5qAHTVc1B0ZAXo6MScyFSWdG4r8hcoymSm4=;
        b=mBGWjDrG05Vddixf87c7ylAWeLvCLxfYtUDjft/WVgLt5f9qlFNZsEnGv1RXrzitKu
         n8lqnEpj3WQdXZZruUioTDB1E6hgiaGwE9VqnSkail/Scxy/cgvPWnl3SQYC/YE3W8i0
         Xo4Eb83b9waJVuqKazvRu+ReJQZ2zy83/XtyH2P1J9niA9K/47rBWRiLa4ex6WwtEZLP
         2xz/gnKst6kTantzd594FmNieEun/wel6qR6u97CSMtY1BS0AGMdN1jdISR5eI9MjhKV
         1ouz/ZBlTxPFLMMhSe3EyiyH0lyFQNEnlYyq3v9diuW7xp9stJ9HN5WGEv/IuExyVD8D
         upwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h68PRQAH5qAHTVc1B0ZAXo6MScyFSWdG4r8hcoymSm4=;
        b=n7Y54Gy+WPXKhISG6jiEopehqWOa+U7oV2sGr/dj8huYlVG0IvCcTiGSs9X3gEZHxz
         4WIkjXm3kL1zd0NrmLaHNQkbGFInLFFoQtpJo7fZUbP4W8RDYiz8x/62+eTxXc7DLMxd
         DV1svwD1zXWzJS2UmVtX283Z47zU+YQHHhXsVirFzRnuSAw3ppyXde6UUkeq3wSWrSmA
         wR02n5T4J0V4ydXMYgcsS0wgNGDqV6jSwjAEC5Ck9R13lsHI0uRq8QrxCzscJNQuRg2/
         sesUGyUmQMILuz0ZnfiTiq0jazZOV9wO9YFrBtgbIkZPDVqek1tz64vghxFAhdwNRTtl
         rgbQ==
X-Gm-Message-State: AJIora80tYrgOCF5ARkq0jQw+XTteVhUUgbyDxwYuELeYA3CpLVqaMDu
        7BSeILZXwwSVcLtr+7+aF/Q=
X-Google-Smtp-Source: AGRyM1vUBBwtmb2vZRbCN2V64GX+6K86rZHz213Ze5a2b4R1jn5XAfjIkNzfLb2IIEd/7jkR576CoA==
X-Received: by 2002:adf:f20a:0:b0:21d:6661:41e9 with SMTP id p10-20020adff20a000000b0021d666141e9mr16889430wro.604.1657102715132;
        Wed, 06 Jul 2022 03:18:35 -0700 (PDT)
Received: from localhost (92.40.202.167.threembb.co.uk. [92.40.202.167])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d5601000000b0021d7799cf4csm2911883wrv.61.2022.07.06.03.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:18:34 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 03/13] dt-bindings: power: supply: axp20x: Add AXP192 compatible
Date:   Wed,  6 Jul 2022 11:18:52 +0100
Message-Id: <20220706101902.4984-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
References: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
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

The AXP192's USB power supply is similar to the AXP202 but it has
different USB current limits and a different offset for the VBUS
status register.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 0c371b55c9e1..e800b3b97f0d 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - x-powers,axp192-usb-power-supply
           - x-powers,axp202-usb-power-supply
           - x-powers,axp221-usb-power-supply
           - x-powers,axp223-usb-power-supply
-- 
2.35.1

