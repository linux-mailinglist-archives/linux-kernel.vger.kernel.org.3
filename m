Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025634C8A76
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiCALRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiCALR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:17:27 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B0991379;
        Tue,  1 Mar 2022 03:16:46 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 221BGbcg022838;
        Tue, 1 Mar 2022 05:16:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646133397;
        bh=hr1Zidk+dGcm12YMCGQGKYrVMcGM8HeOaDO0gU1IMTY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Rx+d01uGCALbii6TvNReY3Wvzxj4ew6e4WrbWS15YM59M82w4QKx4qHCvHfqsh4q5
         VQptRLwceJd+zZcY7vwF0zm1aAbKmfiuO1sZAbTiL2DPfvk/h2xVh5eo620xCy5xAE
         oKqkMrZjEO2g5dXJjG5J9gsXK8vSyJDFOubmgo/w=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 221BGbNJ023061
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Mar 2022 05:16:37 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 1
 Mar 2022 05:16:37 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 1 Mar 2022 05:16:37 -0600
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 221BGMAo116021;
        Tue, 1 Mar 2022 05:16:34 -0600
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
Subject: [PATCH v10 3/4] phy: dt-bindings: cdns,dphy: add power-domains property
Date:   Tue, 1 Mar 2022 16:46:20 +0530
Message-ID: <20220301111621.2992275-4-p.yadav@ti.com>
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

This property is needed on TI platforms to enable the PD of the DPHY
before it can be used.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rob Herring <robh@kernel.org>

---

(no changes since v3)

Changes in v3:
- Add Rob's Ack.

Changes in v2:
- Add power-domain to the example.
- Add Laurent's R-by.
- Re-order subject prefixes.

 Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
index b90a58773bf2..c50629bd1b51 100644
--- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
@@ -30,6 +30,9 @@ properties:
   "#phy-cells":
     const: 0
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -41,11 +44,13 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
     dphy0: phy@fd0e0000{
         compatible = "cdns,dphy";
         reg = <0xfd0e0000 0x1000>;
         clocks = <&psm_clk>, <&pll_ref_clk>;
         clock-names = "psm", "pll_ref";
+        power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
         #phy-cells = <0>;
     };
-- 
2.34.1

