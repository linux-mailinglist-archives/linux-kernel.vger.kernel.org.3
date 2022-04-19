Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D53250624E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345339AbiDSCtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345173AbiDSCtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:49:02 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14232222A0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:46:18 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5D6FC2C07F0;
        Tue, 19 Apr 2022 02:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1650336376;
        bh=UKU4nM9BEp/vlDjWja4SZAVNkl9soocW2yWwxcSJsWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDDo1d+MwT1w84tlkBCeyAH6zc3R6n10uj7qVtx6dq8zJ19ShDrM0YCjH+qgItbFp
         MD2myBYZzR8dBTgdO/oa8JOatHJi8Jvr9Rrd/kZk4s+Cwc10hYLAb33+sCy3snIY0h
         o5CH5ZWegcAjktFARkZc7vi68zLeNXaDmxjCGgQAyxW93viEGBih2GwfxH+kyzNV2x
         5XqtmDcRxa2XKcd7x1ajfJl/kjly3GxQbZvfvFII/FCwWRMn3sdPZqgyI7CaGmFPMh
         lDxJcai1KlpSnTHPpJy292gW/HSE9yJes+0/adRl1EFVsnMXlCxbPdzuhv1lUy7JFM
         Z1mamUj7Rismw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B625e22780001>; Tue, 19 Apr 2022 14:46:16 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 3A89A13EE37;
        Tue, 19 Apr 2022 14:46:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 93FCC2A2679; Tue, 19 Apr 2022 14:46:14 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, adrian.hunter@intel.com,
        nico@fluxnic.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 3/4] dt-bindings: mmc: convert orion-sdio to JSON schema
Date:   Tue, 19 Apr 2022 14:46:10 +1200
Message-Id: <20220419024611.1327525-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz>
References: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=RL7N4Lq+ c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=z0gMJWrwH1QA:10 a=KKAkSRfTAAAA:8 a=gEfo2CItAAAA:8 a=dg4UtMH5AAAA:8 a=-4Ke6npRohLabbDaJfkA:9 a=cvBusfyB2V15izCimMoJ:22 a=sptkURWiP4Gy88Gu7hUp:22 a=byNfn09xH3PuSfgbYLsR:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the orion-sdio binding to JSON schema.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Notes:
    Changes in v2:
    - Add review from Krzysztof

 .../bindings/mmc/marvell,orion-sdio.yaml      | 44 +++++++++++++++++++
 .../devicetree/bindings/mmc/orion-sdio.txt    | 16 -------
 2 files changed, 44 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,orion-s=
dio.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt

diff --git a/Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yam=
l b/Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
new file mode 100644
index 000000000000..8a97ded15aed
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/marvell,orion-sdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell orion-sdio controller
+
+maintainers:
+  - Nicolas Pitre <nico@fluxnic.net>
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    const: marvell,orion-sdio
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@d00d4000 {
+      compatible =3D "marvell,orion-sdio";
+      reg =3D <0xd00d4000 0x200>;
+      interrupts =3D <54>;
+      clocks =3D <&gateclk 17>;
+    };
diff --git a/Documentation/devicetree/bindings/mmc/orion-sdio.txt b/Docum=
entation/devicetree/bindings/mmc/orion-sdio.txt
deleted file mode 100644
index 10f0818a34c5..000000000000
--- a/Documentation/devicetree/bindings/mmc/orion-sdio.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-* Marvell orion-sdio controller
-
-This file documents differences between the core properties in mmc.txt
-and the properties used by the orion-sdio driver.
-
-- compatible: Should be "marvell,orion-sdio"
-- clocks: reference to the clock of the SDIO interface
-
-Example:
-
-	mvsdio@d00d4000 {
-		compatible =3D "marvell,orion-sdio";
-		reg =3D <0xd00d4000 0x200>;
-		interrupts =3D <54>;
-		clocks =3D <&gateclk 17>;
-	};
--=20
2.35.1

