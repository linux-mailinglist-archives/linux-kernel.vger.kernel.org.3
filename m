Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A4558A6E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbiHEHSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240309AbiHEHRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:17:54 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B97543E75;
        Fri,  5 Aug 2022 00:17:53 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f65so1942054pgc.12;
        Fri, 05 Aug 2022 00:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4LUOCGnqvpB3ikVZAyY+IzlAAUdQ46t+B/c2CTutSek=;
        b=eDcSfnuaMdUmbGs80FYVW6w/bzZ7vapm/yugMr3FI751C5geXmskPmk7FsK/EcmPe1
         cIMjoKyo16Pdbbp2vTv3ZiY7mj6uTcjK6Ure32hp02tbXVegRrTz7kRA6bilNeQW5FLS
         9a5ZFkWzzAjaHaJO6slXENv0yvDchA9aBzBh1uIS7lXAH3gyZqqbBTUGCw1e6cOeHsHE
         lmjTiPsK8WfcZ2aH2ljmEk1NbmQtMlenWd4BiMuFC29crcGj6cdwQBpG1le/jPOrwWaK
         /zW6Ei5Dd8v6fJpr55kOTf2OrzJmoOungI1O6A/GxcGrisTqumvloHwEd9ZeXN8Xg0LF
         36/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4LUOCGnqvpB3ikVZAyY+IzlAAUdQ46t+B/c2CTutSek=;
        b=ljKxLCL4PQuboOMJKHRuHpjoJKOA47Ubr8q+752BidnrgQEn47qj7DdywKmW4CJ2q1
         COHp/XSBvp5jYOMhG50J676ycPUk3Ej5URNGFZ3jwcmTnmKEocxgxUXePaQGkx7Ohpo5
         jBHST75J9n67zcwQNcA7r2MF4+CmuUFh1GpdJGgT6fIDW2BS3UpA/GhiGheSQp2cdpQx
         Mg8E5dXBhYNP5b4pXNwcIhKBJgFXHIGbtPGSSsmlFZVF6Dzis+gLGNXK9Sfvi6Y5A3Nc
         aNMBZoAws9K96FFCbMyO+715z8a9JwBt8dB4k6DJ8yok3VRGaAPhOuFn4G6pRgOKpUQ+
         jy0g==
X-Gm-Message-State: ACgBeo074tQUfcL8SLL4MPJn9tMk7ejni6vHCJiobsZNjkLi6LRhlFoC
        1kdCUEC/VIbiXAAm7f+5zog=
X-Google-Smtp-Source: AA6agR6lkRElDutx6frjc4OTHiFmD3P6JjNae00CeLIzwKMqGsbMhPeO1XMvqtChruP5vlHWpFTA5A==
X-Received: by 2002:a63:6846:0:b0:415:bb65:d6f0 with SMTP id d67-20020a636846000000b00415bb65d6f0mr4779792pgc.238.1659683872265;
        Fri, 05 Aug 2022 00:17:52 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:254a:2074:501f:264b])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b00528c066678csm2226147pfj.72.2022.08.05.00.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:17:52 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/7] dt-bindings usb: typec: rt1711h: Add binding for Richtek RT1711H
Date:   Fri,  5 Aug 2022 15:17:07 +0800
Message-Id: <20220805071714.150882-2-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
References: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
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

From: Gene Chen <gene_chen@richtek.com>

Add binding for Richtek RT1711H

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/richtek,rt1711h.yaml   | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml

diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
new file mode 100644
index 0000000..1999f61
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/richtek,rt1711h.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Richtek RT1711H Type-C Port Switch and Power Delivery controller
+
+maintainers:
+  - Gene Chen <gene_chen@richtek.com>
+
+description: |
+  The RT1711H is a USB Type-C controller that complies with the latest
+  USB Type-C and PD standards. It does the USB Type-C detection including attach
+  and orientation. It integrates the physical layer of the USB BMC power
+  delivery protocol to allow up to 100W of power. The BMC PD block enables full
+  support for alternative interfaces of the Type-C specification.
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt1711h
+      - richtek,rt1715
+    description:
+      RT1711H support PD20, RT1715 support PD30 except Fast Role Swap.
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  wakeup-source:
+    type: boolean
+
+  connector:
+    type: object
+    $ref: /schemas/connector/usb-connector.yaml#
+    description:
+      Properties for usb c connector.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - connector
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/usb/pd.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt1711h@4e {
+        compatible = "richtek,rt1711h";
+        reg = <0x4e>;
+        interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
+        wakeup-source;
+
+        connector {
+          compatible = "usb-c-connector";
+          label = "USB-C";
+          data-role = "dual";
+          power-role = "dual";
+          try-power-role = "sink";
+          source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+          sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+          op-sink-microwatt = <10000000>;
+
+          ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+              reg = <0>;
+              endpoint {
+                remote-endpoint = <&usb_hs>;
+              };
+            };
+            port@1 {
+              reg = <1>;
+              endpoint {
+                remote-endpoint = <&usb_ss>;
+              };
+            };
+            port@2 {
+              reg = <2>;
+              endpoint {
+                remote-endpoint = <&dp_aux>;
+              };
+            };
+          };
+        };
+      };
+    };
+...
-- 
2.7.4

