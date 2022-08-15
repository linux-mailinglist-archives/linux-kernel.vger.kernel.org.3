Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C034592968
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbiHOGMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240631AbiHOGMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:12:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1CF18E0D;
        Sun, 14 Aug 2022 23:11:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z6so9383724lfu.9;
        Sun, 14 Aug 2022 23:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OrecjO5UyPq+rEVbOsT6C3SV/fMBa8jiavf5wPC9ui4=;
        b=CN4NG/ff0yiwTJ85OtHtFFTyUnvAlIDlQry/CRIfAEgzlHLdL8jX08NQZcLcgAf8+p
         s0VqvJ5NxK+CfkaeCa0zMnpRRiY31T5AmgkXYOXkEVtw6oHOzCfio2JO5u85ND9NuA3V
         kLcMJqv7w3jAhtO5Kn0vd0H3xw4ESiWA4DLJhTP6leBKz4C1ACUVr/tt+xB2God4Tnli
         PbRqnhSlT1y0ecWf/fcMOZeQg5A39a8+RrP+W1nOzm1bgMUELNXSkKDZUwWF9CoDylEj
         Qcinwooy3ByY2NGxtOnWlN5tbCJFPmu15dm4AUWczjLrGaGfMROFwFkVd/sOqQtuTGoN
         bxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OrecjO5UyPq+rEVbOsT6C3SV/fMBa8jiavf5wPC9ui4=;
        b=1C3NFks5UFKxymzuYucc2hs2rH82awvwnY3arqDUqM2vz/q9mOMRniv+wMUO/KR4L5
         al6wtvyfq8wzqcm62sKHtLU4f2ZSc2HOSUEYeTBF10fbgonP3oQff3fXLXaxGt9MsMFI
         /Bew7l7nmPXIbpz9cwFiQQ10FMc4wOQC1xHlYolLOr4PdqTyV/9XBpHvAm7ACjwcFiEj
         aUc91T3Yet9kAMLA4N6aeZwJQ9qp4el6S4Qe/gQHw/3pR5ciT+ftIKDOkRgPH5ZuzSkT
         0V/cexhdln8fY8Gv8vQiLmoVxv24EsNG3bgSeMmgPoPU7ehxW8r6mKw8i1Nf3smWmXKy
         FsGQ==
X-Gm-Message-State: ACgBeo3aUeIAZRUGYuHzZ8gC9oHitsvs969yY8xxHEfFCy9jRyng3TD+
        lhBSXK69AvvcR+/UcOGFJ00=
X-Google-Smtp-Source: AA6agR7cPahCSnRXvY4Fgk+s1QGUrqAi981KdUyrh5ZjjmhHYTYqvLxGUSHdE2WMg2YL5panMvPVCQ==
X-Received: by 2002:a19:7102:0:b0:48b:a287:2d6f with SMTP id m2-20020a197102000000b0048ba2872d6fmr5467138lfc.515.1660543916627;
        Sun, 14 Aug 2022 23:11:56 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g17-20020a2eb5d1000000b0025d70efeaaasm1296464ljn.75.2022.08.14.23.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:11:55 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 7/9] dt-bindings: iio: adc: mcp3911: add microchip,data-ready-hiz entry
Date:   Mon, 15 Aug 2022 08:16:23 +0200
Message-Id: <20220815061625.35568-8-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815061625.35568-1-marcus.folkesson@gmail.com>
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
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

The Data Ready Output Pin is either hard wired to work as high
impedance or push-pull. Make it configurable.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
index 95ab285f4eba..6bee332ed58f 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -36,6 +36,13 @@ properties:
     description: IRQ line of the ADC
     maxItems: 1
 
+  microchip,data-ready-hiz:
+    description:
+      Data Ready Pin Inactive State Control
+      true = The DR pin state is high-impedance
+      false = The DR pin state is logic high
+    type: boolean
+
   microchip,device-addr:
     description: Device address when multiple MCP3911 chips are present on the same SPI bus.
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.37.1

