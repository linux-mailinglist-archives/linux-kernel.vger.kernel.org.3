Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B926538832
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243163AbiE3UVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240450AbiE3UVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:21:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB63963D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:21:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso138634wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eiDOJFzaInCJhnUpiGhTUeinv2gyCwbF/a7PS9tPsw8=;
        b=GGLTks7z+Cu2sD67ItYjIkSDBnPFbXlry0Yr2hBSF7OQkd9rKRwnYFKllacNxl2clO
         jWHHOCWRt3kxSiYR5U8LKYbDItbOm17Myh6fQPHght6fxMCiy8WPnyuQfqXiN0teNpjJ
         6TpUF6rm3KWf64/X882oAL/sIwnxRDF8w3VwkUWFYx755AxKaLVLTGpTOXQ8i7LsSMYx
         7mzkX6zpqpUTcc4ilmGiuAEnAgtOWEXfl2cJre2phoWZmTy7Uy9Hz0t18CM3WF2b/mBh
         wAe+zJhJJj9rsXLXTbkOT8W1F71HrBAjoTvICAXgTHNJ5CM3mbqVBujloyWQh8SlM7x7
         W5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eiDOJFzaInCJhnUpiGhTUeinv2gyCwbF/a7PS9tPsw8=;
        b=zOQ7WiFKAPFoDh6ICuJEapkcUGueCewuStSo2VAs3+XnGI+Mfu4mhj3ehHLE9mo456
         6nZ4t32T11gZi9AG8mBD8rm7UZtH+ty5mTHh2m3QbJn1ilZaB5DY7unZtxAHrujz26t8
         h9U7+K6Z2X5T3IJ60p9zGIob9iEN+t9DdNItBHQ12u88HJSCjfYr9Cd7dNUh6O6xjywf
         ZoFXBrirtzYroDa4rhZqaJEuCsqW2APN9KWGFMoq46aA9lJcANw8fv2HlI5L6oW361KM
         kfJ7cpjrZUSIUh/n/92U6qm5ewgFU7oEtsBWia9YOKqd4gqo1Mg04W306kcPKP18dVZ5
         M20Q==
X-Gm-Message-State: AOAM532ycdmCsUfi2NkhxPdMMGkzncyi3m0qZtaOpDxbH4uxjEwXi4NG
        hpDoODwQannDuy7PP1DPXhUKMg==
X-Google-Smtp-Source: ABdhPJxAETeJdaqhq72lFl2LUU+Ioc+InFtkW1WnYu123vrwlMVWG/bC/IKO0H+s9HT4NX5FMo8g+w==
X-Received: by 2002:a05:600c:48aa:b0:397:55ba:adb3 with SMTP id j42-20020a05600c48aa00b0039755baadb3mr20239263wmp.73.1653942110348;
        Mon, 30 May 2022 13:21:50 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id q9-20020a1cf309000000b0039754d1d327sm261860wmq.13.2022.05.30.13.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 13:21:49 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: pwm: add MT8365 SoC binding
Date:   Mon, 30 May 2022 22:21:34 +0200
Message-Id: <20220530202136.906407-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 25ed214473d7..ac5c58bbb22d 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -8,6 +8,7 @@ Required properties:
    - "mediatek,mt7628-pwm": found on mt7628 SoC.
    - "mediatek,mt7629-pwm": found on mt7629 SoC.
    - "mediatek,mt8183-pwm": found on mt8183 SoC.
+   - "mediatek,mt8365-pwm": found on mt8365 SoC.
    - "mediatek,mt8516-pwm": found on mt8516 SoC.
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.yaml in this directory for a description of
@@ -17,6 +18,7 @@ Required properties:
                 has no clocks
    - "top": the top clock generator
    - "main": clock used by the PWM core
+   - "pwm1-3": the five per PWM clocks for mt8365
    - "pwm1-8": the eight per PWM clocks for mt2712
    - "pwm1-6": the six per PWM clocks for mt7622
    - "pwm1-5": the five per PWM clocks for mt7623
-- 
2.36.1

