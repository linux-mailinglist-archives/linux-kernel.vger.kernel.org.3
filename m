Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B45957C434
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiGUGMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUGLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:11:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C696270E65;
        Wed, 20 Jul 2022 23:11:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q43-20020a17090a17ae00b001f1f67e053cso533853pja.4;
        Wed, 20 Jul 2022 23:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmTXLgSYfe8i7w6gO6nOarXTiH3i5mk/SE0uP1HtN2c=;
        b=DsLS6IZYhi/zohzXQDQOxiMx/WmBzMUtQFNI2iCoM1lrbRT9t2zXVw6hF/x7pS0CA4
         A0X7H/hqnps45GXVFJrzNA3OMKKkjyc99B8wUL45vZRhJRi3A0eY1MHVdJ1w5pbudSuK
         rnAf+pmDPVCv5K1vB/10d2s9E2sjp1PbfjwLavUakeGOOaImofCSe+OEpPT1g0Y22Gps
         28Zd4j9n4hh5bRYKDW/B32d+1YPfVodmFj+oPAj1vTUO51y5IBDqxXOsxJ34rv+Nq6Ef
         FeG2DfF3bp7h/cp5RjxNG04y5rmN8sztOLv0no5xUeCokrhubaBD9JjCu3LY+O1yYzBo
         sDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmTXLgSYfe8i7w6gO6nOarXTiH3i5mk/SE0uP1HtN2c=;
        b=U41N9Z7Yhdor6m07JU4UY2kU8yExTfaAT11L7nXhz0gIxfnznMWkf6fJuG7Iyz/vDb
         v3y94HJgXy8xE7TNjfllcrYLKei67N0Pg2A4mbCX+Qu4z+sYmZp0KI+Uq2j7f8MPV+/6
         n3/4v+rQALr1bkRMiu/rWfxAyIFC/W5G5A7sPFwCsjE6PZSV4DbFFNob0eR6ic99jEg9
         wufe9DawAhJOdOAAe8v1eIVNRfchWkCMDwhCLBB9RUZN9QdY/yCbFUgJr6QtxYyoXFXp
         zGQdhuluT5hYVMul1aZO7VlxDevl1S0F4/zcJCD0BDBQqoJLL0GJlCAUXRYoXzD4mdrx
         ZdLw==
X-Gm-Message-State: AJIora//ii3yw3Hu4sMdqS5+XwPPm469I45JGnNsmqO1mv2FQsC+EZYV
        aPah3w3zuO3aa/CCo4Uol6E=
X-Google-Smtp-Source: AGRyM1sN4636z4jnPwe/yE4JQWpojZ5lFQ02VWdbDJUpn3Z77XJknm8Hxm8UFDgBFDUcVv9mmKD4KA==
X-Received: by 2002:a17:90b:3b8d:b0:1f0:22f1:27d8 with SMTP id pc13-20020a17090b3b8d00b001f022f127d8mr9701266pjb.56.1658383914036;
        Wed, 20 Jul 2022 23:11:54 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:46a:8b75:f825:a44d:6d0d:6d6e])
        by smtp.gmail.com with ESMTPSA id 13-20020a62170d000000b0052ba782f4cbsm744998pfx.7.2022.07.20.23.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:11:53 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v2 1/6] dt-bindings usb: typec: rt1711h: Add binding for Richtek RT1711H
Date:   Thu, 21 Jul 2022 14:11:39 +0800
Message-Id: <20220721061144.35139-2-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
References: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
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

