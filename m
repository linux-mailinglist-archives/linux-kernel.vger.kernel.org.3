Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F98D5A2971
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbiHZO2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiHZO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:28:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DFFA1D34;
        Fri, 26 Aug 2022 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661524126; x=1693060126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ekaeoHamQzWRDEGag5x7p5HDua4LhMsX4qQRAr9Esd4=;
  b=GdWCq6TlzN+ga2amxKgEjvZ0uBxBRyZZUOdvaakOWEDCFw2Y9NeMqwbi
   aitJWRYvFfiNRtNKX5BGK6/48+9+cjVCm2uC92i1gTyn4d23cpXPXnR8o
   FNdomizDEO+HO+qGmcZgkHIAnsSaCzFBGjk9clp5jksDG9erUYvSjpecf
   1YiAmpfhM1yzBG/LkcFzomIgsn4MpoUqCe34ubqs4CRK3e5FS/nKciCEH
   GY01+iArvt43EKCDOzjZlEGK8jKOAcsf9HHSDtmBiRatWW9dZMtZrzmhe
   NyzM/bwtnGkQEJGXLSHxlTQx60DjNNeO0VfVT6VZrcbwvDOQen2o4K6/p
   A==;
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="174335886"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 07:28:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 07:28:44 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 26 Aug 2022 07:28:41 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/9] dt-bindings: riscv: microchip: document icicle reference design
Date:   Fri, 26 Aug 2022 15:27:59 +0100
Message-ID: <20220826142806.3658434-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826142806.3658434-1-conor.dooley@microchip.com>
References: <20220826142806.3658434-1-conor.dooley@microchip.com>
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

The icicle kit reference design's v2022.09 release,made some changes
to the memory map - including adding the ability to read the fabric
clock controllers via the system controller bus & making the PCI
controller work with upstream Linux.

While the PCI was not working in the v2022.03 design, so nothing is
broken there in terms of backwards compatibility, the fabric clocks
used in the v2022.03 design were chosen by the individual run of the
synthesis tool. In the v2022.09 reference design, the clocks are fixed
to use the "north west" fabric Clock Conditioning Circuitry.

Make use of a new compatible to denote that this is not backwards
compatible.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Krzysztof: you acked this patch in another series, but I moved it here
and reworked the patch contents to make the relationship between the
compatibles clearer. Since it is basically a new patch just with the
same intent, I dropped your ack.
---
 .../devicetree/bindings/riscv/microchip.yaml    | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 1aa7336a9672..7cfc96c21ab0 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -17,12 +17,17 @@ properties:
   $nodename:
     const: '/'
   compatible:
-    items:
-      - enum:
-          - microchip,mpfs-icicle-kit
-          - microchip,mpfs-icicle-reference-rtlv2203
-          - sundance,polarberry
-      - const: microchip,mpfs
+    oneOf:
+      - items:
+          - enum:
+              - microchip,mpfs-icicle-reference-rtlv2203
+              - microchip,mpfs-icicle-reference-rtlv2209
+          - const: microchip,mpfs-icicle-kit
+          - const: microchip,mpfs
+
+      - items:
+          - const: sundance,polarberry
+          - const: microchip,mpfs
 
 additionalProperties: true
 
-- 
2.36.1

