Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CE850AA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392507AbiDUUlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392467AbiDUUkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:40:52 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF37A4DF7D;
        Thu, 21 Apr 2022 13:37:59 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23LKbkMs086287;
        Thu, 21 Apr 2022 15:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650573466;
        bh=00iQh3PHih6BL9yI7/x5tx/QTRchJ9JW0+LhCl/5cb4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NYrvuAMFe6KPer6ZEYJZm4K8VfQy2d1XQ/VsNJvC3bzqLZaJnvT4lXzm8bp4IS/XL
         CH73Um6I009N5rSMGalfZ8++EdW1HpdzmkJlnGkAxrHONxdONS+gS0fMh0tTCccRGu
         yE33ViBxX7n9IBevfIjJSZKKe3rikSoTbb3WYWv0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23LKbkjx001098
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Apr 2022 15:37:46 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Apr 2022 15:37:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Apr 2022 15:37:46 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23LKbkOD122041;
        Thu, 21 Apr 2022 15:37:46 -0500
From:   Dave Gerlach <d-gerlach@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 2/6] dt-bindings: ti,sci: Add lpm region and ti,lpm-firmware-name
Date:   Thu, 21 Apr 2022 15:36:55 -0500
Message-ID: <20220421203659.27853-3-d-gerlach@ti.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220421203659.27853-1-d-gerlach@ti.com>
References: <20220421203659.27853-1-d-gerlach@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the lpm region which tells the ti-sci driver where
to load the FS Stub low power mode firmware and also the
ti,lpm-firmware-name which tells the driver which binary to load. Both
of these are optional for normal system operation but required to
enabled suspend-to-mem usage of Deep Sleep state.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 .../bindings/arm/keystone/ti,sci.yaml         | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
index ec88aa88a2a0..31c783507cd0 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -42,12 +42,19 @@ properties:
           - const: ti,am654-sci
 
   reg-names:
-    description: |
-      Specifies the debug messages memory mapped region that is optionally
-      made available from TI-SCI controller.
-    const: debug_messages
+    items:
+      - const: debug_messages
+      - const: lpm
+    minItems: 1
 
   reg:
+    items:
+      - description: |
+          Specifies the debug messages memory mapped region that is optionally
+          made available from TI-SCI controller.
+      - description: |
+          Specifies the lpm memory mapped region where the FS Stub low power
+          firmware is to be loaded.
     minItems: 1
 
   mbox-names:
@@ -92,6 +99,12 @@ properties:
     type: object
     $ref: /schemas/reset/ti,sci-reset.yaml#
 
+  ti,lpm-firmware-name:
+    description: |
+      Name of binary of FS Stub low power firmware located on the
+      firmware search path.
+    $ref: /schemas/types.yaml#/definitions/string
+
 required:
   - compatible
   - mbox-names
-- 
2.35.0

