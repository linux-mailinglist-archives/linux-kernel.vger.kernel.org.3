Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9D04CAE4F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244945AbiCBTKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244918AbiCBTKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:10:31 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F5DCA707
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:09:47 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 535913F1B3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646248185;
        bh=+ix6D6CD66t0elYK19u+3Q/64q1OEoVuJh2pl4hMuNY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=JcfHF4JdIg2G3t7FM0eJjqU7k4GoOJp2GRSrLQL6qCYF3OIGe8TNs1uI803Ez6t1i
         fkNI6lafislkhmAtM3RRvPgyCf5EWHuZms7VrzAPSDpwTvWgGGq243VqjjKemnLOnD
         kiWHHtiwURK7YmGZMu07ktI8ShIltOMhubhRMSgwngsncaAW1Ld6omm+0Lb8t/nwEA
         kqnSvwlx+DIRheFWw+J5J79rbbEpdEYW9XPBeu4li6HymG017+fL4uTxJ+LkruiVkw
         MfhdTubPIxZCDn3GriC0l4QmJmXCeOQerMIsnVDppUwM01ZpNrdIBchx3OozzLbGM/
         KhEaaMJuDpNfA==
Received: by mail-ed1-f70.google.com with SMTP id m12-20020a056402510c00b00413298c3c42so1504950edd.15
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ix6D6CD66t0elYK19u+3Q/64q1OEoVuJh2pl4hMuNY=;
        b=TBdfpGZDoNm9xow5W7Fr2YbIl30/ww42VTPBGCmsPBCV4xvYuLPc17ocy2807WIfEB
         mKDnQCxcHKyUQsg4o0eii7egRmf1bF+oUBYlceC0Kj94i5cyBIhEp4tWXYSGUuoPqiyN
         FzcYX631gpQgWhzv8fn4NbqIEUbEfGH+XBvYbkeMznAIhSwkKQL510Yf6gIkImYi4uI0
         7vnM37wiFayFFnJBcdsFtp3pZtTzzX1uX2JioBvB1/SVwvUqIgWID6cJPKAr+KVLfbYj
         +kY2cjp0RQXVN7AI8wU2N8neyxVGPWZNXqXQpQMjgdtUhJFr+GbnlnA/5wdyWUx0NSZ7
         Sxfw==
X-Gm-Message-State: AOAM533rlzWMgv5jhbAD15irfTwBXgDdHgZZzZ1PQZJbR024yGZ+ggHT
        xS4cNoFC1MDtLNGaCGgxzc+5mufAQl/KVhd0qTtTCQmJ6fkd0o5KDhlHoe+A59PxI2Fmhdi0PJz
        0tYpIlGBVQY2w9yhmy5TRGz3OCjWi/bsPH0+RI/aLAg==
X-Received: by 2002:a50:d097:0:b0:415:cec5:3b31 with SMTP id v23-20020a50d097000000b00415cec53b31mr1313763edd.377.1646248184911;
        Wed, 02 Mar 2022 11:09:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyzzw3WeGg9KUbPHGQtz+Yl8jQt3D3ZCq0CDIYK4ChRt1a5zuypCDtRTnUImYuRW4UJHRt0Q==
X-Received: by 2002:a50:d097:0:b0:415:cec5:3b31 with SMTP id v23-20020a50d097000000b00415cec53b31mr1313746edd.377.1646248184686;
        Wed, 02 Mar 2022 11:09:44 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id u9-20020aa7db89000000b0041372781e69sm8216383edt.52.2022.03.02.11.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:09:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: usb: samsung,exynos-usb2: convert to dtschema
Date:   Wed,  2 Mar 2022 20:09:38 +0100
Message-Id: <20220302190938.6195-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220302190938.6195-1-krzysztof.kozlowski@canonical.com>
References: <20220302190938.6195-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Samsung Exynos SoC USB 2.0 EHCI and OHCI Controller bindings
to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/exynos-usb.txt    |  66 ----------
 .../bindings/usb/samsung,exynos-usb2.yaml     | 117 ++++++++++++++++++
 2 files changed, 117 insertions(+), 66 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/exynos-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
deleted file mode 100644
index 61c03c0ef19f..000000000000
--- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-Samsung Exynos SoC USB controller
-
-The USB devices interface with USB controllers on Exynos SOCs.
-The device node has following properties.
-
-EHCI
-Required properties:
- - compatible: should be "samsung,exynos4210-ehci" for USB 2.0
-   EHCI controller in host mode.
- - reg: physical base address of the controller and length of memory mapped
-   region.
- - interrupts: interrupt number to the cpu.
- - clocks: from common clock binding: handle to usb clock.
- - clock-names: from common clock binding: Shall be "usbhost".
- - phys: from the *Generic PHY* bindings; array specifying phy(s) used
-   by the root port.
- - phy-names: from the *Generic PHY* bindings; array of the names for
-   each phy for the root ports, must be a subset of the following:
-   "host", "hsic0", "hsic1".
-
-Optional properties:
- - samsung,vbus-gpio:  if present, specifies the GPIO that
-   needs to be pulled up for the bus to be powered.
-
-Example:
-
-	usb@12110000 {
-		compatible = "samsung,exynos4210-ehci";
-		reg = <0x12110000 0x100>;
-		interrupts = <0 71 0>;
-		samsung,vbus-gpio = <&gpx2 6 1 3 3>;
-
-		clocks = <&clock 285>;
-		clock-names = "usbhost";
-
-		phys = <&usb2phy 1>;
-		phy-names = "host";
-	};
-
-OHCI
-Required properties:
- - compatible: should be "samsung,exynos4210-ohci" for USB 2.0
-   OHCI companion controller in host mode.
- - reg: physical base address of the controller and length of memory mapped
-   region.
- - interrupts: interrupt number to the cpu.
- - clocks: from common clock binding: handle to usb clock.
- - clock-names: from common clock binding: Shall be "usbhost".
- - phys: from the *Generic PHY* bindings; array specifying phy(s) used
-   by the root port.
- - phy-names: from the *Generic PHY* bindings; array of the names for
-   each phy for the root ports, must be a subset of the following:
-   "host", "hsic0", "hsic1".
-
-Example:
-	usb@12120000 {
-		compatible = "samsung,exynos4210-ohci";
-		reg = <0x12120000 0x100>;
-		interrupts = <0 71 0>;
-
-		clocks = <&clock 285>;
-		clock-names = "usbhost";
-
-		phys = <&usb2phy 1>;
-		phy-names = "host";
-	};
diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
new file mode 100644
index 000000000000..fbf07d6e707a
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/samsung,exynos-usb2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC USB 2.0 EHCI/OHCI Controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos4210-ehci
+      - samsung,exynos4210-ohci
+
+  '#address-cells':
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: usbhost
+
+  interrupts:
+    maxItems: 1
+
+  phys:
+    minItems: 1
+    maxItems: 3
+
+  phy-names:
+    items:
+      enum: [host, hsic0, hsic1]
+    minItems: 1
+    maxItems: 3
+
+  reg:
+    maxItems: 1
+
+  samsung,vbus-gpio:
+    description:
+      Only for controller in EHCI mode, if present, specifies the GPIO that
+      needs to be pulled up for the bus to be powered.
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^.*@[0-9a-f]{1,2}$":
+    description: The hard wired USB devices
+    type: object
+    $ref: /usb/usb-device.yaml
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - interrupts
+  - phys
+  - phy-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos4210-ohci
+    then:
+      properties:
+        samsung,vbus-gpio: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5420.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb@12110000 {
+        compatible = "samsung,exynos4210-ehci";
+        reg = <0x12110000 0x100>;
+        interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clock CLK_USBH20>;
+        clock-names = "usbhost";
+        phys = <&usb2_phy 0>;
+        phy-names = "host";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hub@1 {
+            compatible = "usb0424,9514";
+            reg = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            usbether@1 {
+                compatible = "usb0424,ec00";
+                reg = <1>;
+                local-mac-address = [00 00 00 00 00 00];
+            };
+        };
+    };
+
+    usb@12120000 {
+        compatible = "samsung,exynos4210-ohci";
+        reg = <0x12120000 0x100>;
+        interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clock CLK_USBH20>;
+        clock-names = "usbhost";
+        phys = <&usb2_phy 0>;
+        phy-names = "host";
+    };
-- 
2.32.0

