Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EA05A9DD1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiIARKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiIARKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:10:49 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F4318E18;
        Thu,  1 Sep 2022 10:10:47 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 281HAg0A065676;
        Thu, 1 Sep 2022 12:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662052242;
        bh=FC+lvapJIAl+8Wydco90vIDMxGEVlLFkAmgj19g62c0=;
        h=From:To:CC:Subject:Date;
        b=ast8CZpPPkKFREMBPN1q7sYcIAuXtdIc7BD0KN+6TkgXbiNbvj84JtoB1Onet1QCu
         +CMeOV6HTgRz5VAEunJ4PZyRvuBOAhV7waxq8xyfR6woZBkxvBFfEQUxAWneI9RDmx
         m86yJ333ePBr4AmmniVo6GSUWo3rKY/DLTks/l0g=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 281HAgx6110235
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 12:10:42 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 12:10:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 12:10:41 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 281HAfLJ118311;
        Thu, 1 Sep 2022 12:10:41 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH] dt-bindings: rng: omap_rng: Drop requirement for clocks
Date:   Thu, 1 Sep 2022 12:10:41 -0500
Message-ID: <20220901171041.32056-1-afd@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For K3 devices the clock fed into the RNG module is shared with the rest
of the Crypto module, it is not dedicated to the RNG module and cannot be
controlled by the RNG driver. The driver does not require this clock to
always be defined and the DT binding should not force it either.

Remove this so we can start dropping out the clock properties as needed.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 Documentation/devicetree/bindings/rng/omap_rng.yaml | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/rng/omap_rng.yaml b/Documentation/devicetree/bindings/rng/omap_rng.yaml
index 010188cdbec86..ccf54fae83028 100644
--- a/Documentation/devicetree/bindings/rng/omap_rng.yaml
+++ b/Documentation/devicetree/bindings/rng/omap_rng.yaml
@@ -53,17 +53,6 @@ allOf:
       required:
         - interrupts
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - inside-secure,safexcel-eip76
-
-    then:
-      required:
-        - clocks
-
 
 required:
   - compatible
-- 
2.36.1

