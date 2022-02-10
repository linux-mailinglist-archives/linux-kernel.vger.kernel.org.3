Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533EB4B1251
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbiBJQHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:07:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243993AbiBJQHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:07:22 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A433C30
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:07:22 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v12so10504466wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h5JUklO4T5xqvKx/rl4qzE6gzcHMOtdcKBWZ8yMI/z8=;
        b=RcTpDDhNVSmBzPz6eAYUqsDDRLpg66q5cKNnTUKTHzpuyGOa1PibBs+P7BCsbSuVvK
         6GwxExItKWGu+rQZ4dwR4Z44n/te4J12RtPTcDcSXDlXIF0yMupOvpUnzGOdV1kuF6SQ
         hkHdPBg4b/XsJP5vIHCfyNnSx6STajNdxi0mRCpD0OHoK7l5PeFdIr9IVFJ0fgCB7CUJ
         vC/m0e7yKDI+6VbLk+exlf1POWc+1y/gtEgEiL48/RgKn94NyUerK3jE8IPJnhI5EPGT
         oZsLVXqwiuwVF9jH/5tsye+avhXuPVBWjRymwFA+qmkSFHi/WytpNW3thn4M5VO8xBid
         7OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h5JUklO4T5xqvKx/rl4qzE6gzcHMOtdcKBWZ8yMI/z8=;
        b=Zi6xqGR8osqCd8sM+8MQkYIaI6O8h6WpPzgIbxZg3T9+XDN1B+EvIwgKYguUFA8tdg
         mk9ARjjHvhb8WN60imRBPmsCOBhMLBl8OGTk744pqskBQ74kEoSKEvp71dHF1+xktPJw
         2ZnJ0PsFJIwiJXqATka1m2JqihKtCgixc+2aMH1x4YnHKNyabqQaKcmwsu/s01XWCDtg
         QG7CWFgRAgIbATS2DW8ylFz9NJ1tsC4ebg237aUhLs4mstbYbv10KGAZG4L8kmwU4OXE
         5Cbv/LeE+o702JugoleQ+PjT9gXnfcBGYZsSWTcZpxdP2Of+eK8o2UJ33P8uz2N7apxb
         +lLw==
X-Gm-Message-State: AOAM532cYcRe+hde12z1q1cA4oD8dlz90tBhL4sETYLpilTo5YMxuK/7
        PQF9DeKf7w+sn49NCgYyJQczkw==
X-Google-Smtp-Source: ABdhPJzAKqeEa4lL90kdB/O7YF2mg2rycWSNGksxFdiRPSsNXxdB6ZJtcWP3Nqs2WV77+jlbleSSPA==
X-Received: by 2002:adf:e5ca:: with SMTP id a10mr6719519wrn.151.1644509240825;
        Thu, 10 Feb 2022 08:07:20 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f20sm2555028wmg.2.2022.02.10.08.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 08:07:20 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     damien.lemoal@opensource.wdc.com,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4] dt-bindings: convert ata/cortina,gemini-sata-bridge to yaml
Date:   Thu, 10 Feb 2022 16:07:12 +0000
Message-Id: <20220210160712.2962810-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts ata/cortina,gemini-sata-bridge binding to yaml

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Change since v1:
- fixed cosmetic nits reported by Damien Le Moal
Changes since v2:
- Added blank lines between properties
- Removed useless quotes and label
- Re-indented description
Change since v3:
- fixed all min/maxitems reported by Krzysztof Kozlowski

 .../ata/cortina,gemini-sata-bridge.txt        |  55 ---------
 .../ata/cortina,gemini-sata-bridge.yaml       | 109 ++++++++++++++++++
 2 files changed, 109 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml

diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
deleted file mode 100644
index 1c3d3cc70051..000000000000
--- a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-* Cortina Systems Gemini SATA Bridge
-
-The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
-takes two Faraday Technology FTIDE010 PATA controllers and bridges
-them in different configurations to two SATA ports.
-
-Required properties:
-- compatible: should be
-  "cortina,gemini-sata-bridge"
-- reg: registers and size for the block
-- resets: phandles to the reset lines for both SATA bridges
-- reset-names: must be "sata0", "sata1"
-- clocks: phandles to the compulsory peripheral clocks
-- clock-names: must be "SATA0_PCLK", "SATA1_PCLK"
-- syscon: a phandle to the global Gemini system controller
-- cortina,gemini-ata-muxmode: tell the desired multiplexing mode for
-  the ATA controller and SATA bridges. Values 0..3:
-  Mode 0: ata0 master <-> sata0
-          ata1 master <-> sata1
-          ata0 slave interface brought out on IDE pads
-  Mode 1: ata0 master <-> sata0
-          ata1 master <-> sata1
-          ata1 slave interface brought out on IDE pads
-  Mode 2: ata1 master <-> sata1
-          ata1 slave  <-> sata0
-          ata0 master and slave interfaces brought out
-               on IDE pads
-  Mode 3: ata0 master <-> sata0
-          ata0 slave  <-> sata1
-          ata1 master and slave interfaces brought out
-               on IDE pads
-
-Optional boolean properties:
-- cortina,gemini-enable-ide-pins: enables the PATA to IDE connection.
-  The muxmode setting decides whether ATA0 or ATA1 is brought out,
-  and whether master, slave or both interfaces get brought out.
-- cortina,gemini-enable-sata-bridge: enables the PATA to SATA bridge
-  inside the Gemnini SoC. The Muxmode decides what PATA blocks will
-  be muxed out and how.
-
-Example:
-
-sata: sata@46000000 {
-	compatible = "cortina,gemini-sata-bridge";
-	reg = <0x46000000 0x100>;
-	resets = <&rcon 26>, <&rcon 27>;
-	reset-names = "sata0", "sata1";
-	clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
-		 <&gcc GEMINI_CLK_GATE_SATA1>;
-	clock-names = "SATA0_PCLK", "SATA1_PCLK";
-	syscon = <&syscon>;
-	cortina,gemini-ata-muxmode = <3>;
-	cortina,gemini-enable-ide-pins;
-	cortina,gemini-enable-sata-bridge;
-};
diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
new file mode 100644
index 000000000000..77af2559b097
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/cortina,gemini-sata-bridge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina Systems Gemini SATA Bridge
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+    The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
+    takes two Faraday Technology FTIDE010 PATA controllers and bridges
+    them in different configurations to two SATA ports.
+
+properties:
+  compatible:
+    const: cortina,gemini-sata-bridge
+
+  reg:
+    maxItems: 1
+
+  resets:
+    minItems: 2
+    maxItems: 2
+    description: phandles to the reset lines for both SATA bridges
+
+  reset-names:
+    items:
+      - const: sata0
+      - const: sata1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+    description: phandles to the compulsory peripheral clocks
+
+  clock-names:
+    items:
+      - const: SATA0_PCLK
+      - const: SATA1_PCLK
+
+  syscon:
+    maxItems: 1
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: a phandle to the global Gemini system controller
+
+  cortina,gemini-ata-muxmode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0
+      - 1
+      - 2
+      - 3
+    description: |
+      Tell the desired multiplexing mode for the ATA controller and SATA bridges. Values 0..3:
+      Mode 0: ata0 master <-> sata0
+              ata1 master <-> sata1
+              ata0 slave interface brought out on IDE pads
+      Mode 1: ata0 master <-> sata0
+              ata1 master <-> sata1
+              ata1 slave interface brought out on IDE pads
+      Mode 2: ata1 master <-> sata1
+              ata1 slave  <-> sata0
+              ata0 master and slave interfaces brought out on IDE pads
+      Mode 3: ata0 master <-> sata0
+              ata0 slave  <-> sata1
+              ata1 master and slave interfaces brought out on IDE pads
+
+  cortina,gemini-enable-ide-pins:
+    type: boolean
+    description: Enables the PATA to IDE connection.
+      The muxmode setting decides whether ATA0 or ATA1 is brought out,
+      and whether master, slave or both interfaces get brought out.
+
+  cortina,gemini-enable-sata-bridge:
+    type: boolean
+    description: Enables the PATA to SATA bridge inside the Gemnini SoC.
+      The Muxmode decides what PATA blocks will be muxed out and how.
+
+required:
+  - clocks
+  - clock-names
+  - cortina,gemini-ata-muxmode
+  - resets
+  - reset-names
+  - compatible
+  - reg
+  - syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cortina,gemini-clock.h>
+    sata@46000000 {
+      compatible = "cortina,gemini-sata-bridge";
+      reg = <0x46000000 0x100>;
+      resets = <&rcon 26>, <&rcon 27>;
+      reset-names = "sata0", "sata1";
+      clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
+               <&gcc GEMINI_CLK_GATE_SATA1>;
+      clock-names = "SATA0_PCLK", "SATA1_PCLK";
+      syscon = <&syscon>;
+      cortina,gemini-ata-muxmode = <3>;
+      cortina,gemini-enable-ide-pins;
+      cortina,gemini-enable-sata-bridge;
+    };
-- 
2.34.1

