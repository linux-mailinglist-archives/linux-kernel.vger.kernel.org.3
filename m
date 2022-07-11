Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354C255DC02
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbiF0OVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbiF0OUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:20:44 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A97011158;
        Mon, 27 Jun 2022 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EgbMht9C/EIGKqEapQ/eQ36TCVYKsgYuy2BxNsAgYmM=; b=LXpWxoSk6i+bognoc/dWWlF4wK
        YQQk9QI7otfjEgPfFCBWK9ihiHNtk+HvcxVF2+nKHxwkFzjRbKiznz/hRwPErZEJ8Qj4G3to8pV87
        TaOi4pI+lqjsC2llhiQbdqEw95khnX7I0t8V0wsxz1szsVACX17vzTJYgh2TrwZ21oeBu/8EgQI3D
        5OGHsp1KWukNFZ2zwa44bSgHyNh0xhx+QyWbdfwH4Nys2GYujuylp6Vfff4J8dzJ/TIcvS6xMDArJ
        VKo+fsZ6ULal6GLeQ+/BycSnigRP09kFULU2jkauAHhHLBFerHeAs3DpN2PiiINNMnkd4X1DSmu5A
        FCi6lnQQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o5pbM-003N2J-JE; Mon, 27 Jun 2022 17:20:31 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7/v3 09/22] dt-bindings: Add bindings for Tegra234 Host1x and VIC
Date:   Mon, 27 Jun 2022 17:19:55 +0300
Message-Id: <20220627142008.2072474-10-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627142008.2072474-1-cyndis@kapsi.fi>
References: <20220627142008.2072474-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Update VIC and Host1x bindings for changes in Tegra234.

Namely,
- New compatible strings
- Sharded syncpoint interrupts
- Optional reset.

Also, fix the order of descriptions for VM/hypervisor
register apertures -- while the reg-names specification
was correct, the descriptions for these were switched.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2:
* Add back 'required' for resets/reset-names on older SoCs
* Simplified reg descriptions
* Updated commit message
v3:
* Split out bracketing change in example
---
 .../display/tegra/nvidia,tegra124-vic.yaml    |   1 +
 .../display/tegra/nvidia,tegra20-host1x.yaml  | 106 +++++++++++++++---
 2 files changed, 93 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
index 37bb5ddc1963..7200095ef19e 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
@@ -21,6 +21,7 @@ properties:
           - nvidia,tegra210-vic
           - nvidia,tegra186-vic
           - nvidia,tegra194-vic
+          - nvidia,tegra234-vic
 
       - items:
           - const: nvidia,tegra132-vic
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
index 0adeb03b9e3a..e6056e9445a7 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
@@ -24,6 +24,7 @@ properties:
           - nvidia,tegra210-host1x
           - nvidia,tegra186-host1x
           - nvidia,tegra194-host1x
+          - nvidia,tegra234-host1x
 
       - items:
           - const: nvidia,tegra132-host1x
@@ -31,23 +32,19 @@ properties:
 
   reg:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   reg-names:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   interrupts:
-    items:
-      - description: host1x syncpoint interrupt
-      - description: host1x general interrupt
     minItems: 1
+    maxItems: 9
 
   interrupt-names:
-    items:
-      - const: syncpt
-      - const: host1x
     minItems: 1
+    maxItems: 9
 
   '#address-cells':
     description: The number of cells used to represent physical base addresses
@@ -110,13 +107,35 @@ required:
   - reg
   - clocks
   - clock-names
-  - resets
-  - reset-names
 
 additionalProperties:
   type: object
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra20-host1x
+              - nvidia,tegra30-host1x
+              - nvidia,tegra114-host1x
+              - nvidia,tegra124-host1x
+              - nvidia,tegra210-host1x
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: host1x syncpoint interrupt
+            - description: host1x general interrupt
+
+        interrupt-names:
+          items:
+            - const: syncpt
+            - const: host1x
+      required:
+        - resets
+        - reset-names
   - if:
       properties:
         compatible:
@@ -133,10 +152,8 @@ allOf:
 
         reg:
           items:
-            - description: physical base address and length of the register
-                region assigned to the VM
-            - description: physical base address and length of the register
-                region used by the hypervisor
+            - description: region used by the hypervisor
+            - description: region assigned to the virtual machine
 
         resets:
           maxItems: 1
@@ -144,6 +161,67 @@ allOf:
         reset-names:
           maxItems: 1
 
+        interrupts:
+          items:
+            - description: host1x syncpoint interrupt
+            - description: host1x general interrupt
+
+        interrupt-names:
+          items:
+            - const: syncpt
+            - const: host1x
+
+        iommu-map:
+          description: Specification of stream IDs available for memory context device
+            use. Should be a mapping of IDs 0..n to IOMMU entries corresponding to
+            usable stream IDs.
+
+      required:
+        - reg-names
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra234-host1x
+    then:
+      properties:
+        reg-names:
+          items:
+            - const: common
+            - const: hypervisor
+            - const: vm
+
+        reg:
+          items:
+            - description: region used by host1x server
+            - description: region used by the hypervisor
+            - description: region assigned to the virtual machine
+
+        interrupts:
+          items:
+            - description: host1x syncpoint interrupt 0
+            - description: host1x syncpoint interrupt 1
+            - description: host1x syncpoint interrupt 2
+            - description: host1x syncpoint interrupt 3
+            - description: host1x syncpoint interrupt 4
+            - description: host1x syncpoint interrupt 5
+            - description: host1x syncpoint interrupt 6
+            - description: host1x syncpoint interrupt 7
+            - description: host1x general interrupt
+
+        interrupt-names:
+          items:
+            - const: syncpt0
+            - const: syncpt1
+            - const: syncpt2
+            - const: syncpt3
+            - const: syncpt4
+            - const: syncpt5
+            - const: syncpt6
+            - const: syncpt7
+            - const: host1x
+
         iommu-map:
           description: Specification of stream IDs available for memory context device
             use. Should be a mapping of IDs 0..n to IOMMU entries corresponding to
-- 
2.36.1

