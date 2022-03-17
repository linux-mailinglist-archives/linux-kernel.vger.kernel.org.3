Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628954DD0FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiCQXCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiCQXCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:02:13 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6913C14CD2C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:00:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id g24so7991982lja.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=45WiQuXkjTLwjH5KekJze4iDLtUQ2UlWaqKlaD1vlfU=;
        b=O1uLVIDYM5fl7sZQRbcj9rjoWtAVK446LBhQZ+vm2XLwi/hJGbQLrpKZCSfjgZV9xC
         f1v4X9+/CJoIASqRasudGMitV3p+vb3zOiD0kkW8W0cnfXIUcCwC6gtKJT7vue6y/KZu
         L+8PDBjEaIFO+x7JzYRpVPJ1CquGg4BbIxkzHcuhT10PpOwYyrDpNZyiw6cnlwwqOsDL
         ADdeUbp4cX24Io+vocI8kkwk/czBm8ORISg5LYRqNd32i6LZHEmkkTS1NeapFpjn7zLE
         y/6WTcBtSGWwfiauf9fCvAWF/tY+M2JMQE2EfOa9YDlcUmHQw8/4ow9xmYiUo7Muv27o
         QMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45WiQuXkjTLwjH5KekJze4iDLtUQ2UlWaqKlaD1vlfU=;
        b=lUVm3MR7ASBhmOkg8LOKxV5CdjtOcZuZTdpq56HzmRjvqS/9EfMapkc2FUHKYW9WOU
         YyDYseOCDAcWvc2ydt4U4hiWJQsoudHuRQ6yIsP9Q4uEcEIHkzTBTXLFCyEPZTjCzNfa
         7SgOx55bl6F3veZLm+rZ3TX4U+3hfJfH7oeQZ0iiqQFes7vb+cPlG6iBfFp1EVNYnWiD
         u5ncOdIl9Q7nPjMRGjQ4l5ukntMGnL2s8HXE3zPze7qB88UU1nAzItys3A2UVRDRv9jT
         HJn1K9+S5Tc4Q9tO3Xwkgr+fD0mMs+IDq+/AxR93/AqpGpzGqfTiVCc1TlqY8mvRn5Ty
         lb7w==
X-Gm-Message-State: AOAM531XHLWNiDhZBPkJa7igewp3IsUILYEoDnQgoYImYIfQxWAqqrU0
        ReEtTIz0U4lK881t+UfbtpotEz+uefCveg==
X-Google-Smtp-Source: ABdhPJwuwYyEOdjueIIJ8/a9Si9EB0k5nSdlhsDtQPYoGlIqZnU0oT4grkWutD4aG3ykIfk5ZVJ4og==
X-Received: by 2002:a05:651c:2dc:b0:247:e451:48ae with SMTP id f28-20020a05651c02dc00b00247e45148aemr4478851ljo.248.1647558053641;
        Thu, 17 Mar 2022 16:00:53 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id 11-20020a2e154b000000b0024967cd674esm191876ljv.35.2022.03.17.16.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:00:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/5 v2] dt-bindings: gnss: Rewrite sirfstar binding in YAML
Date:   Thu, 17 Mar 2022 23:58:42 +0100
Message-Id: <20220317225844.1262643-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317225844.1262643-1-linus.walleij@linaro.org>
References: <20220317225844.1262643-1-linus.walleij@linaro.org>
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

This rewrites the SiRFstar DT bindings in YAML.

Cc: devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Change additionalProperties: false to uneavaluatedProperties: false
  so new common properties get available immediately
- This should also make the checker robot happy about
  lna-supply
---
 .../devicetree/bindings/gnss/sirfstar.txt     | 46 ------------
 .../devicetree/bindings/gnss/sirfstar.yaml    | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.txt
 create mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.yaml

diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.txt b/Documentation/devicetree/bindings/gnss/sirfstar.txt
deleted file mode 100644
index f4252b6b660b..000000000000
--- a/Documentation/devicetree/bindings/gnss/sirfstar.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-SiRFstar-based GNSS Receiver DT binding
-
-SiRFstar chipsets are used in GNSS-receiver modules produced by several
-vendors and can use UART, SPI or I2C interfaces.
-
-Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
-properties.
-
-Required properties:
-
-- compatible	: Must be one of
-
-			"fastrax,uc430"
-			"linx,r4"
-			"wi2wi,w2sg0004"
-			"wi2wi,w2sg0008i"
-			"wi2wi,w2sg0084i"
-
-- vcc-supply	: Main voltage regulator (pin name: 3V3_IN, VCC, VDD)
-
-Required properties (I2C):
-- reg		: I2C slave address
-
-Required properties (SPI):
-- reg		: SPI chip select address
-
-Optional properties:
-
-- sirf,onoff-gpios	: GPIO used to power on and off device (pin name: ON_OFF)
-- sirf,wakeup-gpios	: GPIO used to determine device power state
-			  (pin name: RFPWRUP, WAKEUP)
-- timepulse-gpios	: Time pulse GPIO (pin name: 1PPS, TM)
-
-Example:
-
-serial@1234 {
-	compatible = "ns16550a";
-
-	gnss {
-		compatible = "wi2wi,w2sg0084i";
-
-		vcc-supply = <&gnss_reg>;
-		sirf,onoff-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
-		sirf,wakeup-gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.yaml b/Documentation/devicetree/bindings/gnss/sirfstar.yaml
new file mode 100644
index 000000000000..9f80add3e61b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/sirfstar.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gnss/sirfstar.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiRFstar GNSS Receiver Device Tree Bindings
+
+allOf:
+  - $ref: gnss-common.yaml#
+
+maintainers:
+  - Johan Hovold <johan@kernel.org>
+
+description:
+  The SiRFstar GNSS receivers have incarnated over the years in different
+  chips, starting from the SiRFstarIII which was a chip that was introduced in
+  2004 and used in a lot of dedicated GPS devices. In 2009 SiRF was acquired
+  by CSR (Cambridge Silicon Radio) and in 2012 the CSR GPS business was
+  acquired by Samsung, while some products remained with CSR. In 2014 CSR
+  was acquired by Qualcomm who still sell some of the SiRF products.
+
+  SiRF chips can be used over UART, I2C or SPI buses.
+
+properties:
+  compatible:
+    enum:
+      - fastrax,uc430
+      - linx,r4
+      - wi2wi,w2sg0004
+      - wi2wi,w2sg0008i
+      - wi2wi,w2sg0084i
+
+  reg:
+    description:
+      The I2C Address, SPI chip select address. Not required on UART buses.
+
+  vcc-supply:
+    description:
+      Main voltage regulator, pin names such as 3V3_IN, VCC, VDD.
+
+  timepulse-gpios:
+    description: Comes with pin names such as 1PPS or TM
+
+  sirf,onoff-gpios:
+    maxItems: 1
+    description: GPIO used to power on and off device, pin name ON_OFF.
+
+  sirf,wakeup-gpios:
+    maxItems: 1
+    description: GPIO used to determine device power state, pin names such
+      as RFPWRUP, WAKEUP.
+
+required:
+  - compatible
+  - vcc-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    serial {
+        gnss {
+            compatible = "wi2wi,w2sg0084i";
+            vcc-supply = <&gnss_vcc_reg>;
+            sirf,onoff-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+            sirf,wakeup-gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+            current-speed = <38400>;
+        };
+    };
-- 
2.35.1

