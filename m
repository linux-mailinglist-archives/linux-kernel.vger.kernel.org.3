Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC0A5334C1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243252AbiEYBcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbiEYBcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:32:45 -0400
Received: from mo-csw.securemx.jp (mo-csw1116.securemx.jp [210.130.202.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3475853B55;
        Tue, 24 May 2022 18:32:43 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 24P1W79U014816; Wed, 25 May 2022 10:32:07 +0900
X-Iguazu-Qid: 2wHHoRQqLZjpEs969Y
X-Iguazu-QSIG: v=2; s=0; t=1653442327; q=2wHHoRQqLZjpEs969Y; m=Xr7wfXU0P28tQrglBFUkXafUeWb8aRJHHN/nDBBqDyc=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1110) id 24P1W605016226
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 May 2022 10:32:06 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     yuji2.ishikawa@toshiba.co.jp, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 2/3] iommu: bindings: Add binding documentation for Toshiba Visconti5 IOMMU device
Date:   Wed, 25 May 2022 10:31:46 +0900
X-TSB-HOP2: ON
Message-Id: <20220525013147.2215355-3-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the binding of Toshiba Visconti5 SoC's IOMMU.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../bindings/iommu/toshiba,visconti-atu.yaml  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml b/Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml
new file mode 100644
index 000000000000..af8d6688fa70
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/toshiba,visconti-atu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba ARM SoC Visconti5 IOMMU (ATU)
+
+maintainers:
+  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+
+description: |+
+  IOMMU (ATU) driver can bse used for Visconti5's multimedia IPs, such as
+  DCNN (Deep Convolutional Neural Network), VIIF(Video Input), VOIF(Video
+  output), and others.
+
+properties:
+  compatible:
+    const: toshiba,visconti-atu
+
+  reg:
+    maxItems: 1
+
+  "#iommu-cells":
+    const: 0
+
+  toshiba,max-entry:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The size of entry for address
+    enum:
+      - 16
+      - 32
+
+  toshiba,reserved-entry:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The reserve number of entry address.
+    default: 0
+    minimum: 0
+    maximum: 32
+
+required:
+  - compatible
+  - reg
+  - "#iommu-cells"
+  - toshiba,max-entry
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        atu_affine0: iommu@1400f000 {
+            compatible = "toshiba,visconti-atu";
+            reg = <0 0x1400F000 0 0x1000>;
+            toshiba,max-entry = <16>;
+            toshiba,reserved-entry = <1>;
+            #iommu-cells = <0>;
+        };
+    };
-- 
2.36.0


