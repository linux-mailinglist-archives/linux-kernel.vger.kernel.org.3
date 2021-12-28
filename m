Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597BE480B68
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbhL1Qjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:39:40 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39412
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236058AbhL1Qjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:39:37 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C24A340036
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640709576;
        bh=Ky4Nsy7oalY16bNXsSxGbr4iSjVK2d1F92X5y/VROW8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GO365K0Ens3Tp9dyB8AXv3os/1eP9l0LI16MdQ9IK9rJ68xYhK9emV60PTBlj+kMT
         sOxz4R45Vndfx+hNw+khUjXJxBbBVBBQay/NoNBn/IrGwNzqr9cj6QsJ3qpGpj+b54
         Tqh3F1WzBMEgM7SDxwSnqm1+b/VHyhpxsk3Q8QvNNPl/SgHvcJSJVL25cfv6O3sJqV
         2/ygY+pxJHSwqzs8Xy362bl9pYfbGHnQLESKjBMPcQclYb9irSW3z4BMrM9vj3JX/A
         3+tOWKZ1Q87oww0p3U0cRTJCImbxQoU3IuNWJou39tGpdCgTZarJBX8qdZtptBtZhx
         /FiVIeRHJkXqw==
Received: by mail-lj1-f197.google.com with SMTP id w17-20020a05651c119100b0022dcdb204b9so2854390ljo.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ky4Nsy7oalY16bNXsSxGbr4iSjVK2d1F92X5y/VROW8=;
        b=aBe+dl+DudVCSj4ORpVpGRUfxwYcIYIOxEb9SmAek83LMTfoETuHkXsRWSWfigEPCC
         blo+JX9lU69rNRfeLKCvxdoNZkl2+WekcV3ah2fb4ngivL0L0LuheZq+/gsyu7NIRQZE
         v+6mVIu1hWMRbYsY10eTx0DKyJzUltZF5rlmmBpo+hh8u4lvQo1NyPyaFPI3+u+Kw185
         thH8n4ZQHxcTKy3AyP6JOVz0w3WPKkYPk28NeBQfg/Qc4G6jpqRyWECDQGaBhBcKHVrN
         75kv+KvQmJCWroSAbJtjsmjUiDCuz1y1w3s2y0BmVFBadgIgo1FxblO13ByqeCoWwGvt
         vceg==
X-Gm-Message-State: AOAM5319dbDfUJsOJxkYSLPvD96F36YsbBUup7jLANqnd/cpo/WlG1df
        XwVpWehWIZ1VBBQ6pFpNz1H8BNn5w66r+iVtUore1ZgleF/Ztjl5xM2XPPfS7982LSkHw+9PZde
        8w5Ju/nr8BoUFtSojlz5bfTmlS5LyiwK70vJ/nRgnmA==
X-Received: by 2002:ac2:4e06:: with SMTP id e6mr19280518lfr.295.1640709575901;
        Tue, 28 Dec 2021 08:39:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwn49giUa0jb5mjyDBDwC6FHVyt0eQwfiCTQgcQWOInXEW1g5gUzmTg54LYWNpL3GkXApDSFw==
X-Received: by 2002:ac2:4e06:: with SMTP id e6mr19280485lfr.295.1640709575622;
        Tue, 28 Dec 2021 08:39:35 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d3sm1972876lfs.204.2021.12.28.08.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 08:39:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: leds: maxim,max77693: convert to dtschema
Date:   Tue, 28 Dec 2021 17:39:27 +0100
Message-Id: <20211228163930.35524-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
References: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the LEDs bindings of Maxim MAX77693 MUIC to DT schema format.
The existing bindings were defined in ../bindings/mfd/max77693.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/leds/maxim,max77693.yaml         | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/maxim,max77693.yaml

diff --git a/Documentation/devicetree/bindings/leds/maxim,max77693.yaml b/Documentation/devicetree/bindings/leds/maxim,max77693.yaml
new file mode 100644
index 000000000000..86a0005cf156
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/maxim,max77693.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/maxim,max77693.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77693 MicroUSB and Companion Power Management IC LEDs
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77693 MicroUSB Integrated
+  Circuit (MUIC).
+
+  There are two LED outputs available - FLED1 and FLED2. Each of them can
+  control a separate LED or they can be connected together to double the
+  maximum current for a single connected LED. One LED is represented by one
+  child node.
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max77693.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    const: maxim,max77693-led
+
+  maxim,boost-mode:
+    description:
+      In boost mode the device can produce up to 1.2A of total current on both
+      outputs. The maximum current on each output is reduced to 625mA then. If
+      not enabled explicitly, boost setting defaults to LEDS_BOOST_FIXED in
+      case both current sources are used.
+      See LEDS_BOOST_* in include/dt-bindings/leds/common.h.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+
+  maxim,boost-mvout:
+    description: |
+      Output voltage of the boost module in millivolts.
+      Valid values: 3300 - 5500, step by 25 (rounded down)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 3300
+    maximum: 5500
+    default: 3300
+
+  maxim,mvsys-min:
+    description: |
+      Low input voltage level in millivolts. Flash is not fired if chip
+      estimates that system voltage could drop below this level due to flash
+      power consumption.
+      Valid values: 2400 - 3400, step by 33 (rounded down)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2400
+    maximum: 3400
+    default: 2400
+
+patternProperties:
+  "^([a-z]+-)?led[01]?$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      led-sources:
+        allOf:
+          - minItems: 1
+            maxItems: 2
+            items:
+              minimum: 0
+              maximum: 1
+
+      led-max-microamp:
+        description: |
+          Valid values for a LED connected to one FLED output:
+            15625 - 250000, step by 15625 (rounded down)
+          Valid values for a LED connected to both FLED outputs:
+            15625 - 500000, step by 15625 (rounded down)
+
+      flash-max-microamp:
+        description: |
+          Valid values for a single LED connected to one FLED output
+          (boost mode must be turned off):
+            15625 - 1000000, step by 15625 (rounded down)
+          Valid values for a single LED connected to both FLED outputs:
+            15625 - 1250000, step by 15625 (rounded down)
+          Valid values for two LEDs case:
+            15625 - 625000, step by 15625 (rounded down)
+
+      flash-max-timeout-us:
+        description: |
+          Valid values: 62500 - 1000000, step by 62500 (rounded down)
+        minimum: 62500
+        maximum: 1000000
+
+    required:
+      - flash-max-microamp
+      - flash-max-timeout-us
+      - led-max-microamp
+      - led-sources
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.32.0

