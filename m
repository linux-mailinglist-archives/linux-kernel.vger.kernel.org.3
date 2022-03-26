Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495304E83BD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbiCZTZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiCZTZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:25:39 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DEB33E31;
        Sat, 26 Mar 2022 12:24:02 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D9FBE223F0;
        Sat, 26 Mar 2022 20:24:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648322640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngZOER/c529YUL1r4pFNa98rLmtvDnqoQWaU7g07B4E=;
        b=ejiI+BDJS+hPUaz11Qoy54uC28GOGZLRZFUwqZFfHnXYbWNeKBHJHcV3Wm4RqJCkYDaI3D
        7OYBzzcxx7b6+JPMqGmbMsgBJpCXuLEqS555T1e72fnduAUe1u5r6hfXxivBWZUH/zm8Mi
        SWYnRnbSBc+rFthVg9zByHZygt2ctvg=
From:   Michael Walle <michael@walle.cc>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH v1 3/4] dt-bindings: hwmon: add Microchip LAN966x bindings
Date:   Sat, 26 Mar 2022 20:23:46 +0100
Message-Id: <20220326192347.2940747-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220326192347.2940747-1-michael@walle.cc>
References: <20220326192347.2940747-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the temperature sensor and the fan controller on the
Microchip LAN966x family.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../bindings/hwmon/microchip,lan966x.yaml     | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml b/Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml
new file mode 100644
index 000000000000..390dd6755ff5
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/microchip,lan966x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN966x Hardware Monitor
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description: |
+  Microchip LAN966x temperature monitor and fan controller
+
+properties:
+  compatible:
+    enum:
+      - microchip,lan9668-hwmon
+
+  reg:
+    items:
+      - description: PVT registers
+      - description: FAN registers
+
+  reg-names:
+    items:
+      - const: pvt
+      - const: fan
+
+  clocks:
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    hwmon: hwmon@e2010180 {
+        compatible = "microchip,lan9668-hwmon";
+        reg = <0xe2010180 0xc>,
+              <0xe20042a8 0xc>;
+        reg-names = "pvt", "fan";
+        clocks = <&sys_clk>;
+        #thermal-sensor-cells = <0>;
+    };
-- 
2.30.2

