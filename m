Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6A5A13BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241864AbiHYOgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241895AbiHYOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:36:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E56A61E1;
        Thu, 25 Aug 2022 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661438173; x=1692974173;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=phSuuXXl4YEtWyDnHAU+d+JU7bFN1Ijd9OinFLNU96s=;
  b=UOEjSyjBhw9iSu9/awJsMlG+58Vjrzl4vohq68ySwFV1s5VoA+Bs0DXG
   7uJEVI54vmjVaQoKzy7TpJ2/zklstknyvAtN+D32xuHNpNTlsuKVqwUUh
   8UQmKa3InOR/4VzzJ51c2eGcTYXTX5nOFwbAiJrkpcAuWXNiq0XYY+yMb
   iJlNnLMClh/IZ68qW1kJY+gn/bDZXYF977TBuSZSj4VlGiDWHLmosgf9t
   js9Qf6YayiyJwzQd+V7OSaHTntM+YYVDJNC0SlXEiVw9GI1Sc8+lNOVtl
   Pcj1C01Hn13/bG7hA65iK9PtiZMHyPEx1PG4qckVPkYx0ddlgKFuIsHEk
   w==;
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="110734230"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2022 07:36:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 25 Aug 2022 07:36:10 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 25 Aug 2022 07:36:09 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <brgl@bgdev.pl>, <krzysztof.kozlowski+dt@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2] dt-bindings: gpio: mpfs-gpio: allow parsing of hog child nodes.
Date:   Thu, 25 Aug 2022 15:35:23 +0100
Message-ID: <20220825143522.3102546-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SD card and eMMC on PolarFire SoC are sometimes muxed using a GPIO
by the bootloader. Add a hog child property to facilitate this.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v1:
- move addtionalProperties up under type:
- drop the explicit match group syntax
---
 .../bindings/gpio/microchip,mpfs-gpio.yaml     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
index 110651eafa70..fdc16822fd4b 100644
--- a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
@@ -44,6 +44,24 @@ properties:
 
   gpio-controller: true
 
+patternProperties:
+  "^.+-hog(-[0-9]+)?$":
+    type: object
+
+    additionalProperties: false
+
+    properties:
+      gpio-hog: true
+      gpios: true
+      input: true
+      output-high: true
+      output-low: true
+      line-name: true
+
+    required:
+      - gpio-hog
+      - gpios
+
 required:
   - compatible
   - reg
-- 
2.36.1

