Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354694C0318
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiBVUfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbiBVUfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:35:09 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A5D13D57F;
        Tue, 22 Feb 2022 12:34:43 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id h15so22790341edv.7;
        Tue, 22 Feb 2022 12:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C4U82fp6qV13uln58gfJv2W4jtMmn+wW3Vn6D224n38=;
        b=fCjBsjkjkIT/PmB7vvDuhH3FIXmTG5u4bWzQ6To9nAqts0JLDoF5uz4p6PFHUk3iAI
         rvgFvCb5WZCIy0GLhi7ochXn6Lrg6ZszROl7fyysMiQuPtI15zrcRylYHHcENFKa8aJW
         xErit5Pz6qqpb8sjhJk47D/+i1mCyNPR/NfGUJp88CLljiKGQqjbZ/TVu4wHYaSIXI/z
         crZAGB1oghxdONL/zasWJNayB2wKOkHTvWYry3NJswRVAu880ao8UIpafNH9NX9CxpTa
         96+oNW9ecwJfgiflZPTvuwbcAyN6dcQ4Yw73QymepZfnn73293kp1zqg1HsQ/CDXZ5hd
         zZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C4U82fp6qV13uln58gfJv2W4jtMmn+wW3Vn6D224n38=;
        b=EqLhtWBKZZ4JPITFio/3ptgIkufQG+R0om5CPWtshvOVp3vG7mMIwslNRVEl/6bHsi
         0EqiXaCOQMlMWxOB7T7vzFdY7xCdihGpHjeAIL90UbZzLOxP7TJiTdy1TnZEUOpm/A5x
         e3MXZ0fHLQY5FHCeQ/jHgKKUx/Lg2Zrp22Dy07kGRiljRPXUDJyW2hDOvGz/Bl0AQvax
         Ft6KinfIyCw0pEN7/sl6uqmvR+gJ4EXRMZtqge/98A29/0lUGRrD40W5zw3LxD6KTS7O
         6T0bnghfKhLTaIPO4Zn2+Ye/3cZkQp3s6CEKHATQQGq3eBnmrVuPqh9yTxLeHPkTpBkU
         2Gaw==
X-Gm-Message-State: AOAM533faunrgPhK27QdPsJT4DlN66KanQX5lhbgJIAjVOLfBDGtFy+C
        Zchz5m2HROmJyytAEM1Vp/Hz3zy/Ipw+0ti4
X-Google-Smtp-Source: ABdhPJwSVNRbpk9H0kip4fRxnPNW781RLxwTeSOdXdXfUPMw2jAXoDJOLr2yG4qpM4rS0sd1YLOlDw==
X-Received: by 2002:aa7:df12:0:b0:410:a50b:de00 with SMTP id c18-20020aa7df12000000b00410a50bde00mr28340037edy.2.1645562082273;
        Tue, 22 Feb 2022 12:34:42 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id ec37sm10358388edb.19.2022.02.22.12.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:34:42 -0800 (PST)
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
Subject: [PATCH v6 1/2] dt-bindings: input/touchscreen: bindings for Imagis
Date:   Tue, 22 Feb 2022 22:34:10 +0200
Message-Id: <20220222203414.8656-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220222203414.8656-1-markuss.broks@gmail.com>
References: <20220222203414.8656-1-markuss.broks@gmail.com>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../input/touchscreen/imagis,ist3038c.yaml    | 74 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
new file mode 100644
index 000000000000..e3a2b871e50c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -0,0 +1,74 @@
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
+    pattern: "^touchscreen@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - imagis,ist3038c
+
+  reg:
+    maxItems: 1
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

