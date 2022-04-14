Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F088501A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiDNRn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343653AbiDNRnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:43:02 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5A3E438E;
        Thu, 14 Apr 2022 10:40:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649958021; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=g32l+8hgqG2jlHAkGyf2aftxPyygZoQr+oeoLg/pkbWQS1CTnab0pmTIsscpR/uHPd+i0ifVVmeWxnIkMzSjhNkgHzWkQYNsjZTj6kZH6bRWegI+BeYycIb2g9V6GeoAp730suSfvM9GHArRv7Gy6bHO2/l66pHn/d66e5Eh9ok=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649958021; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=IMNM5MdolEKAJtDmJ2L/PHlHBjhgQ3P7ALeEsPMkcPE=; 
        b=RH3tKHeYfIOaAblCTyjShRpiqA89T3oU8ZQ9fjZdiUy34EyMUJ8LE6dFyMBEFaMqTin8BALWr8pePQyu9K4hyVHR+WZKahh0+WPBYELf5i9Lu43aN1l4zkDGFdlqyXR70sXZ7PWeYyfCHZ83e0Ws0zBvkH4R+V/cC+qHAAJea1Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649958021;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=IMNM5MdolEKAJtDmJ2L/PHlHBjhgQ3P7ALeEsPMkcPE=;
        b=ZNY/n5JCYx3TQwbAbGTHA3bN5nnjYchtA/08g6NTTxK2q9wmWaQeETBY1bNC6sPZ
        2e0OoIVfM6FVXbwewDL+fz69UCFLjzXq4hkULiB5heMKwVX6hLwrtAL2poiyrhW5rNi
        W6PuhSndgYzURR4bcsmbi4/ckvsVT94cpqwr0UgE=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649958020478365.7778123721878; Thu, 14 Apr 2022 10:40:20 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v2 10/14] dt-bindings: pinctrl: rt2880: fix binding name, pin groups and functions
Date:   Thu, 14 Apr 2022 20:39:12 +0300
Message-Id: <20220414173916.5552-11-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414173916.5552-1-arinc.unal@arinc9.com>
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate the old property "ralink,rt2880-pinmux". Add the new property
"ralink,rt2880-pinctrl". The old property name was inaccurate as the
hardware block is called pinctrl across the Mediatek/Ralink architecture.

Current pin group and function bindings are for MT7621. Put bindings for
RT2880 instead.

Add me as a maintainer.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 ...pinmux.yaml => ralink,rt2880-pinctrl.yaml} | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{ralink,rt2880-pinmux.yaml => ralink,rt2880-pinctrl.yaml} (53%)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
similarity index 53%
rename from Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml
rename to Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
index 9de8b0c075e2..56e5becabcfd 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
@@ -1,21 +1,23 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/ralink,rt2880-pinmux.yaml#
+$id: http://devicetree.org/schemas/pinctrl/ralink,rt2880-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Ralink rt2880 pinmux controller
+title: Ralink RT2880 Pin Controller
 
 maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
 description:
-  The rt2880 pinmux can only set the muxing of pin groups. Muxing indiviual pins
-  is not supported. There is no pinconf support.
+  Ralink RT2880 pin controller for RT2880 SoC.
+  The pin controller can only set the muxing of pin groups. Muxing individual
+  pins is not supported. There is no pinconf support.
 
 properties:
   compatible:
-    const: ralink,rt2880-pinmux
+    const: ralink,rt2880-pinctrl
 
 patternProperties:
   '-pins$':
@@ -28,14 +30,12 @@ patternProperties:
 
         properties:
           groups:
-            description: Name of the pin group to use for the functions.
-            enum: [i2c, jtag, mdio, pcie, rgmii1, rgmii2, sdhci, spi,
-                   uart1, uart2, uart3, wdt]
+            description: The pin group to select.
+            enum: [i2c, spi, uartlite, jtag, mdio, sdram, pci]
+
           function:
-            description: The mux function to select
-            enum: [gpio, i2c, i2s, jtag, mdio, nand1, nand2, pcie refclk,
-                   pcie rst, pcm, rgmii1, rgmii2, sdhci, spdif2, spdif3,
-                   spi, uart1, uart2, uart3, wdt refclk, wdt rst]
+            description: The mux function to select.
+            enum: [gpio, i2c, spi, uartlite, jtag, mdio, sdram, pci]
 
         required:
           - groups
@@ -57,7 +57,7 @@ examples:
   # Pinmux controller node
   - |
     pinctrl {
-      compatible = "ralink,rt2880-pinmux";
+      compatible = "ralink,rt2880-pinctrl";
 
       i2c_pins: i2c0-pins {
         pinmux {
-- 
2.25.1

