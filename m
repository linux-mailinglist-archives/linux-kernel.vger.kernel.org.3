Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628304E958C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbiC1Lop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242129AbiC1LeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:34:06 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7295A0B2;
        Mon, 28 Mar 2022 04:25:21 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9446E2224D;
        Mon, 28 Mar 2022 13:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648466712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Avq10jTl7CHo5P+h5iiTtCoGGyerxX9+c/XJg83PbNE=;
        b=pQduOusMWzGVuvgP8rW1i1qep0c7oLBbX8VyXfnCs3nW7oOmt79R/G2jwCn3GCXw6TlhRx
        2ZJ887UtDOwAc9FvoX8UBCUZJEPcLiqb+Xh+qA8MmOcmDW/LJpM1BWjglTSdETQiTjoZhN
        IZU//WMkC6MZizOY54T1yixpvMrEzfA=
From:   Michael Walle <michael@walle.cc>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 3/4] dt-bindings: hwmon: add Microchip LAN966x bindings
Date:   Mon, 28 Mar 2022 13:25:04 +0200
Message-Id: <20220328112505.3025374-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220328112505.3025374-1-michael@walle.cc>
References: <20220328112505.3025374-1-michael@walle.cc>
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
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
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

