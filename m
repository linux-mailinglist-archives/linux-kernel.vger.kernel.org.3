Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDDD5AEE2C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbiIFOxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiIFOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:52:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A7A95B4;
        Tue,  6 Sep 2022 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662473372; x=1694009372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qnRuIvqb2EIJBjRR/INNwmO5YT4t+bc7TsYz9wHYHEA=;
  b=Jo21PHGXDG1tZiUjZ0tHAPOkaphsG2G3IRDEEAKvQxg+lgKWEhjCETAz
   kW1TPPOMVVqUWHNL0pMBpwZDBMOCmIRchn8eqvVlwlh5ak2TfGkoDkJIX
   ZS41t/SrfpY5gAO2BMUowgujnH2SyBljKxrJDwHbbFouNuCyjEQx0p2Am
   x49hJwoGG9KFcLzasWHzNjovB5LTHH7pQbfxfnRpZHBJEMnJRK1z/yrcA
   OrJ0106dwRPFR2TfXF4qdILzpZcafrdoUfE9aiQKZo/KTfkxPTmmWPMZN
   X2n3UAoGEOHyTzio36lvN8ypxKWJw0ad3rzby19ojnToFSbIxgqV2fxXn
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="112380574"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 06:57:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 06:57:42 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 06:57:37 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <sergiu.moga@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <tudor.ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 13/13] dt-bindings: serial: atmel,at91-usart: Add gclk as a possible USART clock
Date:   Tue, 6 Sep 2022 16:55:12 +0300
Message-ID: <20220906135511.144725-14-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906135511.144725-1-sergiu.moga@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Devicetree nodes for FLEXCOM's USART can also have an alternative
clock source for the baudrate generator (other than the peripheral
clock), namely the Generick Clock. Thus make the binding aware of
this potential clock that someone may place in the clock related
properties of the USART node.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---



v1 -> v2:
- Nothing, this patch was not here before



 .../devicetree/bindings/serial/atmel,at91-usart.yaml   | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index 4d80006963c7..db595b498bad 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -36,10 +36,16 @@ properties:
     maxItems: 1
 
   clock-names:
-    const: usart
+    minItems: 1
+    items:
+      - const: usart
+      - const: gclk
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: USART Peripheral Clock
+      - description: USART Generic Clock
 
   dmas:
     items:
-- 
2.25.1

