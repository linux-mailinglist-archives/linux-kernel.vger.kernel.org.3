Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD0859F3FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiHXHIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiHXHIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:08:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3EE93220;
        Wed, 24 Aug 2022 00:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661324922; x=1692860922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=81PIQ4oU2nHHaT+a+f2peD1/PAaHzqplOIRgk1gmyjA=;
  b=RidzpIP+pl5YeM0lKk4M04yH4JZZbjMtHAehpRvRuCEeWTeJtTD8P5Bk
   PSxG5FQp5Z6rrk1vlB7jQgKCqTljznnT0ajLMyhKByvql6dF2QxcFE3Rn
   AkIx69GgXJbByAFqBS3RNckTqlZwnhiXYt4aQtNISPSGj4bYXYOdkz4F/
   7wsSOfVzKulNM5Ci5sk/zvQ4FtOHZCwde70MQDNbRUdbeFBSS2LkuEtUg
   OYG5gq9NiAni44KYLNxLDv6w+a4QQzknfrIZhA23h+YUasxCqwy2ZpRHn
   Y/BH+RXnDMKaHfcCbyru8haJtr86MibV2R4n9wEOq1yoveCrMa0kPEG0T
   A==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="173867262"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 00:08:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 00:08:41 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 24 Aug 2022 00:08:39 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: mailbox: fix the mpfs' reg property
Date:   Wed, 24 Aug 2022 08:08:10 +0100
Message-ID: <20220824070810.52219-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220824070810.52219-1-conor.dooley@microchip.com>
References: <20220824070810.52219-1-conor.dooley@microchip.com>
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

The "data" region of the PolarFire SoC's system controller mailbox is
not one continuous register space - the system controller's QSPI sits
between the control and data registers. Split the "data" reg into two
parts: "data" & "control".

Fixes: 213556235526 ("dt-bindings: soc/microchip: update syscontroller compatibles")
Fixes: ed9543d6f2c4 ("dt-bindings: add bindings for polarfire soc mailbox")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/mailbox/microchip,mpfs-mailbox.yaml  | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
index 082d397d3e89..935937c67133 100644
--- a/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
@@ -14,9 +14,15 @@ properties:
     const: microchip,mpfs-mailbox
 
   reg:
-    items:
-      - description: mailbox data registers
-      - description: mailbox interrupt registers
+    oneOf:
+      - items:
+          - description: mailbox control & data registers
+          - description: mailbox interrupt registers
+        deprecated: true
+      - items:
+          - description: mailbox control registers
+          - description: mailbox interrupt registers
+          - description: mailbox data registers
 
   interrupts:
     maxItems: 1
@@ -39,7 +45,8 @@ examples:
       #size-cells = <2>;
       mbox: mailbox@37020000 {
         compatible = "microchip,mpfs-mailbox";
-        reg = <0x0 0x37020000 0x0 0x1000>, <0x0 0x2000318c 0x0 0x40>;
+        reg = <0x0 0x37020000 0x0 0x58>, <0x0 0x2000318C 0x0 0x40>,
+              <0x0 0x37020800 0x0 0x100>;
         interrupt-parent = <&L1>;
         interrupts = <96>;
         #mbox-cells = <1>;
-- 
2.36.1

