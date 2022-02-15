Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5138B4B7334
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbiBOPPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:15:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbiBOPPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:15:52 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A6F3F309;
        Tue, 15 Feb 2022 07:15:41 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p22so3928481lfu.5;
        Tue, 15 Feb 2022 07:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKTphkXZT3foDlA2vu8RQg7J6hKGxIFWk9c2lfj2mpE=;
        b=n+GFD6nrs6dzOCchDu+dN7CUK/PZehhYcalJouc2j46gQoHuZzs9MJq+v7NbqMutpR
         5Th+1cOFpDc8/RDfMkAJM1Fz6cPbHE52Ff4e8qIj673duNTzWxRyMkmdi+N9odMGeeGe
         MWq0nz4gVf9h4YxV72GlCsZ2PKetcx7f69fJQZ2rfzQMYatRHheGQAdHA7M3B5X9y9xe
         0k5iGndcI5qxSufCpqWbX6u8bUQeWnCQifXqS1C0xW2Jk8wUFOnPBHBykQy69UhnX1jo
         7FHh1xj4xCB0mz9sSEonI9sJkf3FbQFejTrzVCZfix4MjvHb/wafvPMkNBIMfOZMqSqp
         qcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKTphkXZT3foDlA2vu8RQg7J6hKGxIFWk9c2lfj2mpE=;
        b=NRnTKa27JxXO40aApdcfzdd68irzEi+pdL+QJ409EUqkzcpF1U47vYwzOYL+1iDSlC
         cDwbtrMaz2F3F46okfKZkO3jFaYmva24+cutqZyeUHPj+Ts2OG4KaDjMpjcztg7yixi3
         sUQfgDAD+A8yuizXiPJJ23MmJNRs8PBgvbQr3xD7sG2vY3RVlWxRSPi5m2cCPXAmTyb7
         ZxfEahnfAwvxfve6eXWn75CmFhxqVpS2m7Sd5wwa3cagndFmpLH1Y9IAk5a+ilM0olE2
         42sK962GWbDJ8XoonjWOZsdC4Xj8SYn73LqfjIuWSjFQqgeslBofVTWmMVEhELiYeC5Y
         kbrA==
X-Gm-Message-State: AOAM532jHG++wB/YurExEPmjCdNLYoEehEfvq/+lXqqv9Qqi4bOMEIzG
        hk0ltiGJeLWLRP4NBpdVVIswsr5mzf8V3+eNvho=
X-Google-Smtp-Source: ABdhPJxfTQ+Cl50tDzNDqx6vkOnMSUGqfsyDbU+l6JmQOOnJtoIyqhsbn/0Usq11VQcqK6Er9ROv2g==
X-Received: by 2002:a05:6512:3ba8:: with SMTP id g40mr1672788lfv.75.1644938139714;
        Tue, 15 Feb 2022 07:15:39 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id t12sm4479598ljc.97.2022.02.15.07.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:15:39 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: input/touchscreen: bindings for Imagis
Date:   Tue, 15 Feb 2022 17:15:25 +0200
Message-Id: <20220215151527.84634-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220215151527.84634-1-markuss.broks@gmail.com>
References: <1644531943.391463.3262540.nullmailer@robh.at.kernel.org>
 <20220215151527.84634-1-markuss.broks@gmail.com>
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

This patch adds device-tree bindings for the Imagis
IST3038C touch screen IC.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../input/touchscreen/imagis,ist3038c.yaml    | 75 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
new file mode 100644
index 000000000000..7b127817e1f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/imagis,ist3038c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagis IST30XXC family touchscreen controller bindings
+
+maintainers:
+  - Markuss Broks <markuss.broks@gmail.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  $nodename:
+    pattern: "^touchscreen(@.*)?$"
+
+  compatible:
+    items:
+      - enum:
+          - imagis,ist3038c
+
+  reg:
+    description: I2C address
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Power supply regulator for the chip
+
+  vddio-supply:
+    description: Power supply regulator for the I2C bus
+
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-fuzz-x: true
+  touchscreen-fuzz-y: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@50 {
+        compatible = "imagis,ist3038c";
+        reg = <0x50>;
+        interrupt-parent = <&gpio>;
+        interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+        vdd-supply = <&ldo1_reg>;
+        vddio-supply = <&ldo2_reg>;
+        touchscreen-size-x = <720>;
+        touchscreen-size-y = <1280>;
+        touchscreen-fuzz-x = <10>;
+        touchscreen-fuzz-y = <10>;
+        touchscreen-inverted-x;
+        touchscreen-inverted-y;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index cdc851e275f1..9357cdc5aef5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -551,6 +551,8 @@ patternProperties:
     description: Ingenieurburo Fur Ic-Technologie (I/F/I)
   "^ilitek,.*":
     description: ILI Technology Corporation (ILITEK)
+  "^imagis,.*":
+    description: Imagis Technologies Co., Ltd.
   "^img,.*":
     description: Imagination Technologies Ltd.
   "^imi,.*":
-- 
2.35.0

