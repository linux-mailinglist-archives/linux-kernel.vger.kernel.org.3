Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517A34C1834
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242656AbiBWQJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242647AbiBWQJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:09:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D8CC24BA;
        Wed, 23 Feb 2022 08:09:05 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i11so43238301eda.9;
        Wed, 23 Feb 2022 08:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=elGugzkpUtqI0ijv/bJdCic69uTtVCv00H1vvYkMLIw=;
        b=eFyszSoLg0MoxESWbmFVSufqK4IwAv3iqRImUfw5pwl3scyokax0FumdtfpN3gOj+4
         rRMCgHIiV2eP+TFcEEKiokPffp2uNYAhtkiIIapGtTELg2hIOMNMG9nSibm1ZhuzIbDd
         p9jVqmGLDZnAqXt/T4CtkBksdkL32cOl1Q1S8VjBuZStAK1t+nNncCa9x78wdQR7t4Hv
         vw4/YNVZKkWO8xBmHk4ag1hdr1acsAp5I5U68K+IkukIcBJjsdmwIuiJJXtA6pZNYFUZ
         +LtplNX5c4Gqi+1WlSkJJQ5xM876mBFF/HIf1SFW77UqFUidP3hN9SF3/8f+isiu4r01
         ed4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=elGugzkpUtqI0ijv/bJdCic69uTtVCv00H1vvYkMLIw=;
        b=HZsGP+ux+VlsmHc9aTS8/AACnDzkiXvGSF8pzPkzS0UGlcyUFVq0+8UPBwq8VsgRs2
         J4KFoh4NjlaLtCg53c8EOCrsTyUsTv451TNr5ShXYBs3SOHAKfWb638mOBt4LMy9pHcG
         9FTmGFuZ7HwB4V1HN4TDD0V7S8fDYaEU+wWPiGD3BKAq0iaM73niRZsU8CkeTodC+utY
         iH4rGJVK55QPEaDjDC4R0M8u/BM9lH9PoajWcQ00zRXz4avSFjJTJtbyQj8HJiExat/f
         M3cpLHAzjZfxxuVKcclJRAqURWc3LNc7l9HlCzm8cHSpaIe93RH90vgHvR9FV99LrCSJ
         ln/g==
X-Gm-Message-State: AOAM533T3u4aUd7UTWu/jvSNWUaWMfjdSiF2TG+qaNJ1ISBJaOcGz1T6
        OU0tm48HRoWjzdKnAV71DQElQiG5Utb7lKXZ
X-Google-Smtp-Source: ABdhPJyKLX0no+TyJKwru5SPX2jNhAmSRRlc4P211Yu1ydFljtMSaZUo+kwhrByR7f2gS/90wewliQ==
X-Received: by 2002:a50:c444:0:b0:413:30d5:c6ad with SMTP id w4-20020a50c444000000b0041330d5c6admr95301edf.251.1645632543109;
        Wed, 23 Feb 2022 08:09:03 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id x7sm52005edr.12.2022.02.23.08.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:09:02 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/2] dt-bindings: input/touchscreen: bindings for Imagis
Date:   Wed, 23 Feb 2022 18:07:40 +0200
Message-Id: <20220223160749.37001-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220223160749.37001-1-markuss.broks@gmail.com>
References: <20220223160749.37001-1-markuss.broks@gmail.com>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
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

