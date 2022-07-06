Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D5156852B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiGFKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiGFKSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:18:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63014B2D;
        Wed,  6 Jul 2022 03:18:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v16so9917601wrd.13;
        Wed, 06 Jul 2022 03:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZG+WV9b/8zIynOLD+NGGVzMJIIPqNVNIfED/0tYW0ms=;
        b=dlJSeVzqMEjxJE/n0k4p+cBHeQaceux+NaZ+VMAx9Eyae1UzgUCBn7dmzMHTE++9fm
         1xCIbpz8O29gIJ0CqmblPVfHJ//QEImAv1ktl8eVfEJ3Nk69mumUN6tpDxhymgJBr5Ba
         M5xHtXbD+knTV+l3uiG9ujbkG7koCSv9oh0VTlG3rz9J+hNoAKRfzjonEsNl3cDIZVfw
         YPekGpPmq823EZknuAEJZnd5cMMDUHra08tFFVL2PPBG7smv4cw6z7bvrna2UhIVeQXT
         jBvNVNkO7BdtvLuVj5BN6pw7Q1zhruMQY4Oib8M7MmmFVYgluB5/vyPiuft152AI/cMw
         iMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZG+WV9b/8zIynOLD+NGGVzMJIIPqNVNIfED/0tYW0ms=;
        b=YMX5+JUTIODp5tSrmoi0NkNib3zc5cQ21OtK8sq2y7b6/SrWp8lYCXTqWX+1OP8Vyg
         bYllDQshfT4YWKZv1YnzunkUi5Bj1RmpGzYdwFpsGCuv9bC2mrWxvrN+jA8OxDXa1Tbw
         NuMQvrDbodb1UQvbWvqTVjROt/OlOzFN3F+OjMuv24UBGDq+Y9s8qPb12sTr4yitvABX
         akk74rr+UFdcmkrBOwC7JIucPrq4G6LDELAWqCrUqfZ0+a6o5+JWnwiKHBBYb8TKNGp1
         w3AWrCkOWyxbZaaPQz2VRrIlT/5eMSNniKLEiwRw3jxdqW4EX/e+Cbi2KJiCvjg08liT
         wd0g==
X-Gm-Message-State: AJIora/EAvKjJuLrSvBhX7wvXeUFfJ8RKnJhO8V4LzZoaFYYaBZZ/tsm
        K2yISlKQpfCKwEnXm2hWQTs=
X-Google-Smtp-Source: AGRyM1s2J0+OTU34jjXNJ4p8vts6OH7fJUVuOTypzgdpMdKgk15rBD3LCsJX3z33ydaSYnIoBmMDdQ==
X-Received: by 2002:a05:6000:1e04:b0:21d:7ec3:fe5a with SMTP id bj4-20020a0560001e0400b0021d7ec3fe5amr1807734wrb.116.1657102716820;
        Wed, 06 Jul 2022 03:18:36 -0700 (PDT)
Received: from localhost (92.40.202.167.threembb.co.uk. [92.40.202.167])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d5544000000b0021a39f5ba3bsm35103267wrw.7.2022.07.06.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:18:36 -0700 (PDT)
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
Subject: [PATCH v5 04/13] dt-bindings: power: axp20x-battery: Add AXP192 compatible
Date:   Wed,  6 Jul 2022 11:18:53 +0100
Message-Id: <20220706101902.4984-5-aidanmacdonald.0x0@gmail.com>
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

The AXP192's battery charger is similar to the others supported by
the axp20x_battery driver.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../power/supply/x-powers,axp20x-battery-power-supply.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index d055428ae39f..b7347683a07e 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -20,6 +20,7 @@ allOf:
 properties:
   compatible:
     oneOf:
+      - const: x-powers,axp192-battery-power-supply
       - const: x-powers,axp202-battery-power-supply
       - const: x-powers,axp209-battery-power-supply
       - const: x-powers,axp221-battery-power-supply
-- 
2.35.1

