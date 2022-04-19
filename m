Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA28A50624D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345606AbiDSCtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345229AbiDSCtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:49:03 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B622222A8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:46:19 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5D0F02C086E;
        Tue, 19 Apr 2022 02:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1650336377;
        bh=04tBdQ/JpQKgjiXKo+M/e+/FSrNGvX8TgHtHdWAYVY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejp2pLLf+9Ka1x+GYVoFnx08/xLZNiZVGkmnUO8BQ+lRB7r/1I9rc7+Jauir6VjId
         G8g/QLRDSlV7g/cqkPWOrM30Gw9YznPrc/pIei5fuXaQdG+Y0IIQRNjFH/tI0YfCA8
         5qyERD4jjZxt2pmPXuLttyfMCuW/SfOxuccUzNkyAwBiDcztwBpay6MkqVMUKjjUHY
         euSPCR9SRoEfSbPhYV9KUa+w1BADRMV/c+RLNA+7qNuAsGj4A+VMOLCn4S98TJ49tQ
         ynKrcFOYBMo70UjAeHctZWxd+SMOTlore2a4IcOetSBwbWclt4Zl8j0oV6VINEj4s1
         8zebVYiCXUfDQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B625e22780002>; Tue, 19 Apr 2022 14:46:16 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 6929713EE37;
        Tue, 19 Apr 2022 14:46:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C26492A2679; Tue, 19 Apr 2022 14:46:14 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, adrian.hunter@intel.com,
        nico@fluxnic.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 4/4] dt-bindings: mmc: convert sdhci-dove to JSON schema
Date:   Tue, 19 Apr 2022 14:46:11 +1200
Message-Id: <20220419024611.1327525-5-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz>
References: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=RL7N4Lq+ c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=z0gMJWrwH1QA:10 a=gEfo2CItAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=HCZY7b2unBJ0_1QZS9cA:9 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the sdhci-dove binding to JSON schema. The optional clocks
property was not in the original binding document but has been in the
dove.dtsi since commit 5b03df9ace68 ("ARM: dove: switch to DT clock
providers").

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Add clocks property
    - interrupts.maxItems =3D 2
    - Update maintainers based on ./scripts/get_maintainer.pl -f drivers/=
mmc/host/sdhci-dove.c

 .../bindings/mmc/marvell,dove-sdhci.yaml      | 44 +++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-dove.txt    | 14 ------
 2 files changed, 44 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,dove-sd=
hci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-dove.txt

diff --git a/Documentation/devicetree/bindings/mmc/marvell,dove-sdhci.yam=
l b/Documentation/devicetree/bindings/mmc/marvell,dove-sdhci.yaml
new file mode 100644
index 000000000000..7c9c652ad59c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/marvell,dove-sdhci.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/marvell,dove-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell sdhci-dove controller
+
+maintainers:
+  - Adrian Hunter <adrian.hunter@intel.com>
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    const: marvell,dove-sdhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sdio0: mmc@92000 {
+      compatible =3D "marvell,dove-sdhci";
+      reg =3D <0x92000 0x100>;
+      interrupts =3D <35>;
+      clocks =3D <&gate_clk 9>;
+    };
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-dove.txt b/Docum=
entation/devicetree/bindings/mmc/sdhci-dove.txt
deleted file mode 100644
index ae9aab9abcd7..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-dove.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-* Marvell sdhci-dove controller
-
-This file documents differences between the core properties in mmc.txt
-and the properties used by the sdhci-pxav2 and sdhci-pxav3 drivers.
-
-- compatible: Should be "marvell,dove-sdhci".
-
-Example:
-
-sdio0: sdio@92000 {
-	compatible =3D "marvell,dove-sdhci";
-	reg =3D <0x92000 0x100>;
-	interrupts =3D <35>;
-};
--=20
2.35.1

