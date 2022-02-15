Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8F24B7917
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244204AbiBOUww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:52:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244190AbiBOUwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:52:50 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC661C922;
        Tue, 15 Feb 2022 12:52:39 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o2so39296722lfd.1;
        Tue, 15 Feb 2022 12:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7bMGM2CViaQZCCdppiGP+G8NcZfPb54iKlO3oLEklg=;
        b=Lc3YSjGC/o4VJjzRx1pYaoRC87fkYzne0z+pvEHnf6Iz6xO0VbFk2gFGr9uK6Imq2D
         8+I3a2Kv1OgPZxHxdVrEY7iobDv/N2+cIsxLdhNoIp4uv0T+1m4hLvH0fH4T1OL5Bsa4
         sAaxcowk94AczQOtNzSctq+lexvb4XyyTqQweH78Y5DkgYkZbYXyVy+u9NQEBYGDlyae
         5hgj1TDLhQLRiXmlBmqMbtxH8O8uvziVynLnWs8rzrNOc+PzblJ6ZCY179RoGBphef8E
         MDzcTpdhYSRMY4p3pqwi9sMqxbYn3XbqLFye9/WXGlU/DWns4v8S0CYnEBPcUBi3aPjT
         EBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7bMGM2CViaQZCCdppiGP+G8NcZfPb54iKlO3oLEklg=;
        b=kaF/V59Cmwq84jEt8h9tuNPkjXgVOze9hwRvH71Mx+GkuBnpqg8oEL4PPzue8E4vEl
         i32O2xDbi/zOr5sO9QaOHDKSOoe6OF3iZL9tu+lemVtyBDoiMNG5D5eQ5SkDNId7iRQw
         Nwm53TgiCU01kQn8i7W+Kt+qZ9AdVN8oBDcZms3JXlGItE7LnkdSlbNAydXbLetVraS5
         rzDg9Wu3PIZK1sK7qgjEzHdMhZenDWFfahMXtm+21JZbCEADH1rniUWj8DMhaO2lHGO/
         53uCUBVfYkLWzvKmXUXzmPHiinkNXs73nmFLVvJBIVjXnE6fOBwZ9CSJ1kAYVdB4wNx3
         vwOw==
X-Gm-Message-State: AOAM532iv5kKfKEjrlCugLp74Ix/AAQeHzwUWAhK0R7sk4YrK70CdUCb
        7TM7kzvlD2PAkj5KV7dDbHHqllJSEnSkc6eB
X-Google-Smtp-Source: ABdhPJwkq8rwi0nE3350nKr+0qhX6xmJou0YAcbsdDdnPpum31vi/kCbtvuf9Zz4mGsk8CcF99+T1A==
X-Received: by 2002:a05:6512:3f94:: with SMTP id x20mr667024lfa.583.1644958357797;
        Tue, 15 Feb 2022 12:52:37 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id 18sm1129337ljw.71.2022.02.15.12.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 12:52:37 -0800 (PST)
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
Subject: [PATCH v4 1/2] dt-bindings: input/touchscreen: bindings for Imagis
Date:   Tue, 15 Feb 2022 22:51:51 +0200
Message-Id: <20220215205153.57966-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220215205153.57966-1-markuss.broks@gmail.com>
References: <20220215205153.57966-1-markuss.broks@gmail.com>
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
 .../input/touchscreen/imagis,ist3038c.yaml    | 74 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
new file mode 100644
index 000000000000..f98e5dfa2bc4
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
+    - enum:
+        - imagis,ist3038c
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

