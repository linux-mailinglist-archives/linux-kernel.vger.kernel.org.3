Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E694E232E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345826AbiCUJVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbiCUJVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:21:06 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02270F211A;
        Mon, 21 Mar 2022 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=cW97tF9dygiHq7o/+gILOv2WKq3Hft3IjKo4B2OX804=;
        b=eP+TbhMwTDC2j/k3vk+arf1HxLZHBCa9ukqIl4zZcm2pKdDaQQT9Z7/5UP7gZXUagWq3IrAZtvYpN
         BzEro9LzLjg4qfTuMtL1O/0RIbJa58cLmvRBkQ2T8j37jYvTnwTbkAhRFVYmQGhGtsdak/c2fp3Dq6
         bltPPCBPCBNeUVuWkt+a4sIOtJlcqmpQr86V5ZOo5E62ojQ7p0w5KJy04+NTKTtFW4fkUMleu4lIoZ
         UlA9/DLMgukrJwOxfSkqEYJVhpQ9ickKwLXipoXRTwkqjlL2gK0oCndaRINI5nN//bcjYU4mzcbX+O
         sg4YwOE6kkZU4yOUxb7wzMsLJnZibtg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1410, Stamp: 3], Multi: [Enabled, t: (0.000009,0.007073)], BW: [Enabled, t: (0.000021,0.000001)], RTDA: [Enabled, t: (0.159073), Hit: No, Details: v2.28.0; Id: 15.52k2hp.1fulscguq.40nc; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 21 Mar 2022 12:19:30 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        conor.dooley@microchip.com, robh+dt@kernel.org, system@metrotek.ru,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 2/2] dt-bindings: fpga: add binding doc for microchip-spi fpga mgr
Date:   Mon, 21 Mar 2022 12:00:20 +0300
Message-Id: <20220321090020.22530-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321090020.22530-1-i.bornyakov@metrotek.ru>
References: <20220321090020.22530-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Tree Binding doc for Microchip Polarfire FPGA Manager using
slave SPI to load .dat formatted bitstream image.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 .../fpga/microchip,mpf-spi-fpga-mgr.yaml      | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml

diff --git a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
new file mode 100644
index 000000000000..6955fc527ed2
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/microchip,mpf-spi-fpga-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Polarfire FPGA manager.
+
+description: |
+  Device Tree Bindings for Microchip Polarfire FPGA Manager using slave SPI to
+  load the bitstream in .dat format.
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - microchip,mpf-spi-fpga-mgr
+
+  reg:
+    items:
+      - description: spi chip select
+
+examples:
+  - |
+    spi@2008000 {
+            ...
+            fpga_mgr: fpga_mgr@0 {
+                    compatible = "microchip,mpf-spi-fpga-mgr";
+                    spi-max-frequency = <20000000>;
+                    reg = <0>;
+            };
+    };
-- 
2.34.1


