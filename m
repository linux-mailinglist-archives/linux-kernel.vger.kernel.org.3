Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3858AB1D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbiHEMz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiHEMzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:55:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970E7BF4A;
        Fri,  5 Aug 2022 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659704154; x=1691240154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1bVplGfcpRSCACZ3qKsPFsudC5vt7I+hPtcbEhpUdZ4=;
  b=cq+nH9Lq50pyKZqRExg+xXL3LaoejvTEsejhoNHPlCLHCM79ZXbBRmV0
   FJDjBX4CWKAPI16CQKhFwTKF/LOXvF4F80dbe/oBgoIILnEJ4z6WfqC6U
   DH5Kbrp/9rDk37Go9Rd+JuI9K25H8NNiyVso0PAmjHw3UzlJmERyiTQvW
   dDvqPtNa8XjrSfasixeS8pxXOKcos5Mbut9GWc2vDAOCNSSKyKEvrzPjS
   /lY4qkuA4Q48VxgRosV6IV+79jq9yWlb9jOteW+KwjU8zLNjPBSZtj9L5
   uN7JzIoE/eHVuV5MvaUHNtRWiKGxM1jCJrgmJ15mj33OewoAmT7/hyDGj
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="175226473"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2022 05:55:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 5 Aug 2022 05:55:53 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 5 Aug 2022 05:55:52 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH 1/3] dt-bindings: mailbox: fix the mpfs' reg property
Date:   Fri, 5 Aug 2022 13:56:17 +0100
Message-ID: <20220805125618.733628-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220805125618.733628-1-conor.dooley@microchip.com>
References: <20220805125618.733628-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

