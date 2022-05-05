Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93B651CCB4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386759AbiEEXaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbiEEX3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:29:53 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985EF606C4;
        Thu,  5 May 2022 16:26:12 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5C7A3331;
        Thu,  5 May 2022 16:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651793169;
        bh=L4IB0VoUFCWwJW2jk1V0bP//XVHc5hIoPCrUlnX1oXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQOvXL0VJDatl+irFLuOtu1857mb91W96sEGVLTJ5zMg2eVP/bxSUFuFYRCL62/SZ
         w8OPcwBDnHJ0yvJfr8drtv0hZUbILNTpKKEfvF79Sek/cJZqsxhOjdQaFThODYu9cA
         Z9Pu8Fh8dfoGR637s6xOdQbtEw1qFQhc1OwlsRuM=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org
Subject: [PATCH v2 1/2] dt-bindings: connector: Add regulator-connector binding
Date:   Thu,  5 May 2022 16:25:56 -0700
Message-Id: <20220505232557.10936-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505232557.10936-1-zev@bewilderbeest.net>
References: <20220505232557.10936-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This describes a power connector supplied by a regulator, such as a
power outlet on a power distribution unit (PDU).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../connector/regulator-connector.yaml        | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/connector/regulator-connector.yaml

diff --git a/Documentation/devicetree/bindings/connector/regulator-connector.yaml b/Documentation/devicetree/bindings/connector/regulator-connector.yaml
new file mode 100644
index 000000000000..96825b6f608a
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/regulator-connector.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/connector/regulator-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator output connector
+
+maintainers:
+  - Zev Weiss <zev@bewilderbeest.net>
+
+description: |
+  This describes a power connector supplied by a regulator, such as a
+  power outlet on a power distribution unit (PDU).  The connector may
+  be standalone or merely one channel or set of pins within a ganged
+  physical connector carrying multiple independent power outputs.
+
+properties:
+  compatible:
+    const: regulator-connector
+
+  vout-supply:
+    description:
+      Phandle of the regulator supplying the connector.
+
+required:
+  - compatible
+  - vout-supply
+
+additionalProperties: false
+
+examples:
+  - |
+      output {
+          compatible = "regulator-connector";
+          vout-supply = <&output_reg>;
+      };
-- 
2.36.0

