Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF7B56A0E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiGGLIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiGGLII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:08:08 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741DE57272;
        Thu,  7 Jul 2022 04:08:06 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 267B7v5f013468;
        Thu, 7 Jul 2022 06:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657192077;
        bh=y/Z39qua67dgp5zkofpHim547GKv+6IKE9vJapd+IGg=;
        h=From:To:CC:Subject:Date;
        b=hJydOVYEQNmdNd1rcNhGayOMOWU1tqkcYvyPBM9pu8G0/OMnqSK9gFQ/BVLQM7nF5
         lBFMeRZi5DBsxlAcBtQGcoOAwkQ31+XPuqMXwxNytoUXCIFsm3M1NxcOJmVmXQvOC7
         PtlkId1A1GQaMe6gcLLZ12ZX5mzpwQoC3NyRGMfA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 267B7vle063776
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jul 2022 06:07:57 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Jul 2022 06:07:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Jul 2022 06:07:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 267B7u35020504;
        Thu, 7 Jul 2022 06:07:57 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <j-keerthy@ti.com>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH] dt-bindings: crypto: ti,sa2ul: drop dma-coherent property
Date:   Thu, 7 Jul 2022 16:37:56 +0530
Message-ID: <20220707110756.16169-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crypto driver itself is not dma-coherent. It is the dmaengine
that moves data and the buffers are to be mapped to the
dmaengine provider. So this property should be dropped.

Fixes: 2ce9a7299bf6 ('dt-bindings: crypto: Add TI SA2UL crypto accelerator documentation')
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 .../devicetree/bindings/crypto/ti,sa2ul.yaml        | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
index 02f47c2e7998..0c15fefb6671 100644
--- a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
+++ b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
@@ -35,8 +35,6 @@ properties:
       - const: rx1
       - const: rx2
 
-  dma-coherent: true
-
   "#address-cells":
     const: 2
 
@@ -72,16 +70,6 @@ required:
   - dmas
   - dma-names
 
-if:
-  properties:
-    compatible:
-      enum:
-        - ti,j721e-sa2ul
-        - ti,am654-sa2ul
-then:
-  required:
-    - dma-coherent
-
 additionalProperties: false
 
 examples:
@@ -95,5 +83,4 @@ examples:
         dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>,
                <&main_udmap 0x4001>;
         dma-names = "tx", "rx1", "rx2";
-        dma-coherent;
     };
-- 
2.17.1

