Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575D959B084
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiHTUqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 16:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiHTUqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:46:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2215F96
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 13:46:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r16so8826737wrm.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=7V3TE9A3eDfzAhMP7VTHkeTu4QJwwcdn1JqXWxvCTzw=;
        b=VfaOebSwwfQ7KRRcTJsL6kl5KLWUW5wv3Jv0zhScBKzEkMyR3sT0bu4hZgoVSI+l4T
         j+umuQByZQKVc5jHO+g4yY4YB92e6dWRAUobANP8QcdRJxbBWMrjLL/t6g3koW//JaC5
         McbxUW9TGUufX0ZbFwGlWMCpxvLXZ2iyfRHp6Xfp/SQUlbVHgmmZft2w5kZXh8FjzIJj
         aBbNQJNwIowOovg70FX+dJgyVUgtbNyHbGYM/AsIDfPFMPcp3wklG5RfY4nzqPr9zbXN
         GpTs5rgJhOwv3lqbZSrrVxO9mMF0Gii9IxipCbGtr2QeHUVgnNb9WtXDAZY/JMwTTq9w
         gJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7V3TE9A3eDfzAhMP7VTHkeTu4QJwwcdn1JqXWxvCTzw=;
        b=jR55INyyaf5pLU7rU1ys3fE9CLkmwtOyjYMXpkZTaIWVtLIsc4XQr8X7Xd+mW+K9Ut
         F7jtygaPH5oOps84rJL6vFjcRroz41ocK+Y+0Lv43wRNc/MAw0oEkyFtqqa//ziSB95N
         OxTJywTJ+byvhua2r7EsPYC12D9COQF+PDacZ6XvFgxLajfsa70ac34yJF6nWgFgYRik
         pWnrWg5enlX2zteJFLvlZuWOw4MVkO0CzwEkdy+QhAyRz12SpLfrR1dK8CkztkvyvKww
         CTdHGD7sdcT6dQn2cMcmQHgBkWLqb0QM/mAFxv0cKl1dZ9PrKbwvNuy5MNX6VK13RtIZ
         zxUw==
X-Gm-Message-State: ACgBeo1CKiyzdCtWXNJg7bNpJlZyXpmi4Vggo+mK02sQ1ixjilf/Ouuq
        sGCC2O8w+WEL9+Iss6JcDFbLNA==
X-Google-Smtp-Source: AA6agR4CzMyvNM98C0fTK1AQN8JhuOAP6Ylg/z1MAnuXL/CIJmtUcVVshPT1TfZQAQQ5xc5z1nXnRQ==
X-Received: by 2002:adf:f881:0:b0:225:4f49:55dc with SMTP id u1-20020adff881000000b002254f4955dcmr807024wrp.414.1661028363613;
        Sat, 20 Aug 2022 13:46:03 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003a2f2bb72d5sm14971194wma.45.2022.08.20.13.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 13:46:02 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpio: mpfs-gpio: allow parsing of hog child nodes.
Date:   Sat, 20 Aug 2022 21:41:32 +0100
Message-Id: <20220820204130.1380270-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The SD card and eMMC on PolarFire SoC based dev boards are sometimes
statically muxed using a GPIO. To facilitate this, enable gpio-hog
child node properties.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/gpio/microchip,mpfs-gpio.yaml     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
index 110651eafa70..6704a7a52cd0 100644
--- a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
@@ -44,6 +44,24 @@ properties:
 
   gpio-controller: true
 
+patternProperties:
+  "^.+-hog(?:-[0-9]+)?$":
+    type: object
+
+    properties:
+      gpio-hog: true
+      gpios: true
+      input: true
+      output-high: true
+      output-low: true
+      line-name: true
+
+    required:
+      - gpio-hog
+      - gpios
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
-- 
2.37.1

