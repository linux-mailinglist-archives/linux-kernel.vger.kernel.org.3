Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5FA57E1F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbiGVNEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbiGVNEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:04:14 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E369AAF960;
        Fri, 22 Jul 2022 06:04:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m12so6460804lfj.4;
        Fri, 22 Jul 2022 06:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knFtpsDUHJLhvP+nNFn6yLtZbr5Vu25n0owL6mtc+zk=;
        b=f6lRXuyAwcbLJbExmbcb5sJghYbagvLVgGeF83P5SMaORdUIkKD3raS8+xn3Qo6p/K
         R+tbv3jZOIk1tPSdvi2k4j/OZJe9pWTECqMCXBeYJTfHxaS1LpKJyw1jb7Q3oXwlYhOI
         lpChgYzRxnINoWr6dgXMIODiXpUzUJmcIoWQmGZ9vJKlEtLHgOAn6qHcNmxxKltc4y2W
         ejya4dI4jrSKng+K2Ahcmqkm+6nu18c9WU2BNJ81jnqOc4BfrKz+haZDRvraBS3syccC
         g8OGUzeYGTHcjevRYl0g7UTmJyPwWy5yWTNq59bxucl74P+m1nwtpf3b0iSl1Cr5Xyrh
         PRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knFtpsDUHJLhvP+nNFn6yLtZbr5Vu25n0owL6mtc+zk=;
        b=FG6YoDetvFRnUOFwkI8rSgd6Espv+POwR16Br2RpQH4tdzQ/A5QVJdpvooG+YbNBPW
         6cbwS+RsTszUVDo17U7q+OZwPCqM8vZNqMJ2ZbkyjrVETyGxWgSjjEFZ55YUhGStJgRs
         wZfcRqjW2xNvHOeNyrg18KkiOjRhBO9cOvO74v2icT9C2hes1Gs7Suz+tue2u9z6Tq8N
         y3EK6Yx7SA6C3xPgoYXb5WphCxliaCWXXwGGuA4pykt8qKgJFxT5q0+EQou0PRRldvyj
         kRRGqaVfR2lKNt9fD4CPact7P/1JHDJaC/pkN5BoZWiPdDzWd6LK9rOEbdZEKVjg3Nyr
         qHvA==
X-Gm-Message-State: AJIora/RBfEeTMfHYMkVmbkLgTnOc6OjjWyZ/80YRKoR4rya7OsppZBr
        AeABi6KFXNYwm3NsL4oRXbQ=
X-Google-Smtp-Source: AGRyM1sFcAFfYMUJaH4oxbzjmlCO0Bjv6SAAGINlAquwJJU9mqZcGgvbgV7etlXVUt4w8kVFapWWmg==
X-Received: by 2002:a05:6512:12c8:b0:489:efbf:18d1 with SMTP id p8-20020a05651212c800b00489efbf18d1mr194117lfg.192.1658495051239;
        Fri, 22 Jul 2022 06:04:11 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id s18-20020a056512203200b004786d37229csm1039673lfs.155.2022.07.22.06.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:04:10 -0700 (PDT)
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
Subject: [PATCH v4 7/9] dt-bindings: iio: adc: mcp3911: add microchip,data-ready-hiz entry
Date:   Fri, 22 Jul 2022 15:07:24 +0200
Message-Id: <20220722130726.7627-8-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220722130726.7627-1-marcus.folkesson@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 95ab285f4eba..57a16380f864 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -36,6 +36,13 @@ properties:
     description: IRQ line of the ADC
     maxItems: 1
 
+  microchip,data-ready-hiz:
+    description:
+      Data Ready Pin Inactive State Control
+      true = The DR pin state is high-impedance when data are NOT ready
+      false = The DR pin state is a logic high when data are NOT ready
+    type: boolean
+
   microchip,device-addr:
     description: Device address when multiple MCP3911 chips are present on the same SPI bus.
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.36.1

