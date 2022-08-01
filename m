Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D28C586763
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiHAK1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiHAK1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:27:18 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A3193FF;
        Mon,  1 Aug 2022 03:27:18 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h132so9288100pgc.10;
        Mon, 01 Aug 2022 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+DCZgVJ0CsaRwE83F/0raSGoaEkswc7t3B15LpI0LQ=;
        b=c/UcHHep3nR8roeLhAGe11ERMCmDBIvnPCIvKoe22wfOjXeupbCvwDXH8yuyOHcpGM
         8TsvCRIc1hlI1mGX2IiGZWHVqx97SuASvBOSRnyrlTCjYxwlK7SwTEXqs+k1fSVCDy7Z
         JATdW96dSHuBczPjXSGWNhjZSy9oqpwawRYRHOIi2i3jhN0/WDW3sUN/SBXYbvRiA+Cn
         IEVXpCF13nqn2/gOsI1Dj/hOfDIBXiV8xr6X83NtlOKE7wcAQVkyvtUM1tYbtZEtEVsy
         OIq01oskUp+s78P/ZSJmTgMnBAJkydzwv5dYcJBMvej+4ZFU1C+gsT9kQv0rJuq4kj56
         vK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+DCZgVJ0CsaRwE83F/0raSGoaEkswc7t3B15LpI0LQ=;
        b=Kf5BnL0c4Ah10ioKNXLdtqbURw9OAgxJK/JS30XtfxG74lF09drOritU1lQTB+SlaX
         vdA4eYTBlTAM6LWz/zqpv42IO0M9h84IIwOjvZw117ojaBp+wxMQPSngV72/dyq8AiJF
         c1BZL75YERHfTZ/6/+0ObpPYlRQiT5JPdfeBzy6KZw/GfI7973dylJtULP50e3Mmpvm5
         HwedNDulq+Z49qm91SqXBYi0qdUexJDyxG9chzDb4HnHdYPiDncrIS6mtjc+CtKB0x2E
         oYrv0KYMh3rI6ZVj+9C0SQd+QO+dzNSY0KE+gL7OEoqDi1ULt9IH7op0foT/eG0ADIoU
         om4g==
X-Gm-Message-State: ACgBeo1pdyWRN/tZq6fpNM0aUvWHWv3HsGkuqhSkl97vpXfvd07AIBII
        iCwqFHqwRDNBfARnQ0sdFs6nAIw6Kx0=
X-Google-Smtp-Source: AA6agR7LDhIUnkFvMdkr+sGmWldlqEVConHLcJAy+OaIqQ8Le7ZQ+KFcC1ClV+DtPyNlLO8uRxfcnw==
X-Received: by 2002:a05:6a00:cc1:b0:52d:a29d:fb1 with SMTP id b1-20020a056a000cc100b0052da29d0fb1mr1500585pfv.56.1659349637550;
        Mon, 01 Aug 2022 03:27:17 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:8d46:b2ef:57e3:7c30])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016c6a6d8967sm9199302plb.83.2022.08.01.03.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 03:27:17 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/7] dt-bindings usb: typec: rt1711h: Add binding for Richtek RT1711H
Date:   Mon,  1 Aug 2022 18:14:41 +0800
Message-Id: <20220801101447.86207-2-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
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
 .../bindings/usb/richtek,rt1711h.yaml         | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml

diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
new file mode 100644
index 000000000000..1999f614c89b
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
2.25.1

