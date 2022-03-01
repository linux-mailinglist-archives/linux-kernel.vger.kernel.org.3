Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3C44C8A7A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiCALRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbiCALRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:17:31 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A33E91AD7;
        Tue,  1 Mar 2022 03:16:50 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 221BGfso031519;
        Tue, 1 Mar 2022 05:16:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646133401;
        bh=4SwLAH88JnJT5PZJ5YWyDguLyFBhuOkYKFjfGfwc2B8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CttWfzwly6dommpD31OHhZN+B9vKKXN21pE4YBt441OTdy3J7HQhwAWiBgm+PxK+x
         hnuA9QPHfNPmpU63DMysdeMwoWxbhUpbaNZ5LX2Wg2ZnfSuOJjy3UtBdVg6rShnnnT
         WGFJfaBS/Lih/G74vvondYJMBVu3ErPEQKycXXVQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 221BGfCd023079
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Mar 2022 05:16:41 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 1
 Mar 2022 05:16:40 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 1 Mar 2022 05:16:40 -0600
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 221BGMAp116021;
        Tue, 1 Mar 2022 05:16:37 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v10 4/4] phy: dt-bindings: Add Cadence D-PHY Rx bindings
Date:   Tue, 1 Mar 2022 16:46:21 +0530
Message-ID: <20220301111621.2992275-5-p.yadav@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220301111621.2992275-1-p.yadav@ti.com>
References: <20220301111621.2992275-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rx mode DPHY is different from Tx mode DPHY. Add a separate binding
for it.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

(no changes since v8)

Changes in v8:
- Add Rob and Laurent's R-by.

Changes in v6:
- Add a new binding for DPHY Rx.

 .../devicetree/bindings/phy/cdns,dphy-rx.yaml | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
new file mode 100644
index 000000000000..07be031d82e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/cdns,dphy-rx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence DPHY Rx Device Tree Bindings
+
+maintainers:
+  - Pratyush Yadav <p.yadav@ti.com>
+
+properties:
+  compatible:
+    items:
+      - const: cdns,dphy-rx
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    dphy0: phy@4580000 {
+        compatible = "cdns,dphy-rx";
+        reg = <0x4580000 0x1100>;
+        #phy-cells = <0>;
+        power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
+    };
-- 
2.34.1

