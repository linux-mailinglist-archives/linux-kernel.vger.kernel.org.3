Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72794575EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiGOKEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiGOKEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:04:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6940420BEC;
        Fri, 15 Jul 2022 03:04:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x21so2825298plb.3;
        Fri, 15 Jul 2022 03:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+IFkwURZ9TzI4d4nsyuIECKELcBe+Ufdc+HAFumbKk=;
        b=eWBrxVJdIdl4Mm1ckW/tC6XW1WSGRVUJyH0w6bWcKioK0c27Jst1K7eIhYYzm0JyeF
         CkZct692RTUtWFV7fYyCHzUJVJKVZ8+DWx8HO2xLts+/Ce8WjIks0bTYbPg2uyJ0iZR/
         1vYpGeNz6trP1Waf7nKr3LC8gGTSzghwktpeScv2xBbLnTvxucoXPS+6WzR14MMhdYXs
         3SYirghPZmZtBaGf6bat6Z88AQynnyaXyT3UDYH8QYkJCD7q0PA2kweFXY24YHs3AMTY
         iBJIaiI9J4pz9X/xNpbLeQMhB/2OvmfkVD5dTXSUqSQaeIE2j6aVpn9GPOSwEVL0Ilra
         DQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+IFkwURZ9TzI4d4nsyuIECKELcBe+Ufdc+HAFumbKk=;
        b=Xz3JvjONuT0xBzDhkYbx7TiaNQnF7mwn6HIvk7DzcMjoMaLh2pf9ihTbazArdvJ4V3
         wDeiAWaw94/V8aw3hiwKk8fL9+Gs2LJYcB67qp8xcDAASLzmwRHbcpdobcV2z6OJpfbY
         ZIm6V6N0/jgxpZIXKbMk0X8i+sWTls+VVL2SZUs2g6bfi2Tz834mhUaNVIqarQfysqIj
         E/KLBhxTdWQZkj5FIscsb0PeJbi+p6uZyOI2ioI6Tv1K0VV/sL6qLt9KpbndXxvPmbUQ
         IEIYpcM3SHwxFuDp0QqXMf6NDWh+G8c1zaaK5Mmbh7D+a3i7uxSC+SuHvsxG1ub91+AR
         YvTw==
X-Gm-Message-State: AJIora8BVFSB3YN2wXmHIUs3gU18jKa+azsX0IWdGUDtqo3YvnsYzrue
        8chcY7bykx+zrbE6J3aZX7sQzDzIjeM=
X-Google-Smtp-Source: AGRyM1tnIGku2iwT1sqcON7jJXF1MGuTORPoOmAE7LlfdSRjXs4AODN4DJlbjJbq90U1Gkipmrftcw==
X-Received: by 2002:a17:903:22d0:b0:16b:f798:1cff with SMTP id y16-20020a17090322d000b0016bf7981cffmr12718103plg.23.1657879471883;
        Fri, 15 Jul 2022 03:04:31 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:569:4518:3851:6d9:846d:fbd1])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709028d8c00b0016c1948ef7esm3033791plo.296.2022.07.15.03.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 03:04:31 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH 1/3] dt-bindings usb: typec: rt1711h: Add binding for Richtek RT1711H
Date:   Fri, 15 Jul 2022 18:04:16 +0800
Message-Id: <20220715100418.155011-2-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715100418.155011-1-gene.chen.richtek@gmail.com>
References: <20220715100418.155011-1-gene.chen.richtek@gmail.com>
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
 .../bindings/usb/richtek,rt1711h.yaml         | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml

diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
new file mode 100644
index 000000000000..b6daca71429b
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/richtek,rt1711h.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Richtek RT1711H Type-C Port Switch and Power Delivery controller DT bindings
+
+maintainers:
+  - Gene Chen <gene_chen@richtek.com>
+
+description: |
+  - Richtek RT1711H TypeC PD Controller.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - richtek,rt1711h
+          - richtek,rt1715
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  wakeup-source:
+    description: enable IRQ remote wakeup, see power/wakeup-source.txt
+    type: boolean
+
+  connector:
+    type: object
+    $ref: ../connector/usb-connector.yaml#
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

