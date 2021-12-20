Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F4347B312
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbhLTSoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:44:06 -0500
Received: from ixit.cz ([94.230.151.217]:43896 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231635AbhLTSoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:44:05 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id DD44E24CC2;
        Mon, 20 Dec 2021 19:44:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640025843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0pAXOGja/2dmDtyWJXbtgamO/U+PNoS4/USu48pMSoo=;
        b=YM9ipUAznpkqf8He96pds0edqlWHFPI6DbliXavDM6Ct6kHYY3+Gzq/S0j7SnpO+0WkKbG
        PeqzaXvQC59We/1xa790TVMAsS4pJ4GUqbIIHImRbft7LZ2Uwfpuphs+tVukum4VagBWxX
        +yKzWKCJtwgUpntVxl4FXzmWoDvGLZU=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: crypto: convert Qualcomm PRNG to yaml
Date:   Mon, 20 Dec 2021 19:43:55 +0100
Message-Id: <20211220184355.86582-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm PRNG documentation to yaml format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/crypto/qcom,prng.txt  | 19 --------
 .../devicetree/bindings/crypto/qcom,prng.yaml | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/crypto/qcom,prng.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/qcom,prng.yaml

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.txt b/Documentation/devicetree/bindings/crypto/qcom,prng.txt
deleted file mode 100644
index 7ee0e9eac973..000000000000
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Qualcomm MSM pseudo random number generator.
-
-Required properties:
-
-- compatible  : should be "qcom,prng" for 8916 etc
-              : should be "qcom,prng-ee" for 8996 and later using EE
-		(Execution Environment) slice of prng
-- reg         : specifies base physical address and size of the registers map
-- clocks      : phandle to clock-controller plus clock-specifier pair
-- clock-names : "core" clocks all registers, FIFO and circuits in PRNG IP block
-
-Example:
-
-	rng@f9bff000 {
-		compatible = "qcom,prng";
-		reg = <0xf9bff000 0x200>;
-		clocks = <&clock GCC_PRNG_AHB_CLK>;
-		clock-names = "core";
-	};
diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
new file mode 100644
index 000000000000..bb42f4588b40
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/qcom,prng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Pseudo Random Number Generator
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,prng  # 8916 etc.
+      - qcom,prng-ee  # 8996 and later using EE
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: core
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    rng@f9bff000 {
+        compatible = "qcom,prng";
+        reg = <0xf9bff000 0x200>;
+        clocks = <&clk 125>;
+        clock-names = "core";
+    };
-- 
2.34.1

