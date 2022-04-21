Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354A350AA2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392483AbiDUUk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344664AbiDUUkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:40:49 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA1F4DF76;
        Thu, 21 Apr 2022 13:37:55 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23LKbk7R026792;
        Thu, 21 Apr 2022 15:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650573467;
        bh=7mnJvrp490Lo0N7o19GCy4p70pRbdpLKgPu8bMwwMXA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gLdWwpNS5urCNE/bvBFaLNAN1OEmg3tlLkpXBBxeqFbUM7k0X2GENuIzEqjn4fhYA
         T6RAwfssZo9xrgs88L/Vqscid1We58fTIeI5bp3LkIJBvK2pOD+CkXLQjZnFr27mjY
         7eRhpl1Z/TdC9jg3El/CYTo3Fl8PLOmlOc1el9Hg=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23LKbkGe084672
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Apr 2022 15:37:46 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Apr 2022 15:37:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Apr 2022 15:37:46 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23LKbkwe026868;
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
Subject: [PATCH 1/6] dt-bindings: ti,sci: Add ti,ctx-memory-region property
Date:   Thu, 21 Apr 2022 15:36:54 -0500
Message-ID: <20220421203659.27853-2-d-gerlach@ti.com>
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

Add documentation for the ti,ctx-memory-region property which is a
phandle to a reserved-memory carveout to be used by the ti_sci driver
storage of low power mode memory context. This is optional for normal
system operation but required to enabled suspend-to-mem usage of Deep
Sleep state.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 .../devicetree/bindings/arm/keystone/ti,sci.yaml         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
index 34f5f877d444..ec88aa88a2a0 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -61,6 +61,15 @@ properties:
   mboxes:
     minItems: 2
 
+  ti,ctx-memory-region:
+    description:
+      Phandle to the reserved memory node to be associated with the
+      ti-sci device, to be used for saving low power context. The
+      reserved memory node should be a carveout node, and should
+      be defined as per the bindings in
+      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
+    $ref: /schemas/types.yaml#/definitions/string
+
   ti,system-reboot-controller:
     description: Determines If system reboot can be triggered by SoC reboot
     type: boolean
-- 
2.35.0

