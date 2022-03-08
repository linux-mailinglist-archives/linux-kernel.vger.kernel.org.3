Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B9A4D1F69
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349267AbiCHRuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349265AbiCHRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:50:09 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF2C4839E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:49:11 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6100:2d37:4115:c358])
        by baptiste.telenet-ops.be with bizsmtp
        id 3tp72700V1Yj8bA01tp7Qb; Tue, 08 Mar 2022 18:49:09 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRdxL-003DQP-4j; Tue, 08 Mar 2022 18:49:07 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRdxK-006gpQ-H6; Tue, 08 Mar 2022 18:49:06 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] dt-bindings: firmware: arm,scpi: Add missing maxItems to mboxes/shmem
Date:   Tue,  8 Mar 2022 18:49:02 +0100
Message-Id: <58b7c706f259f88a61bfe82d9106fe0a93a9838d.1646761693.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"make dt_binding_check":

    Documentation/devicetree/bindings/firmware/arm,scpi.example.dt.yaml: scpi: shmem: [[2], [1]] is too long

Fix this by adding a proper maxItems value to the shmem property,
and to the related mboxes property.

Fix the grouping of the "mboxes" property in the example.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
Exposed by commit 39bd2b6a3783b899 ("dt-bindings: Improve phandle-array
schemas").

v2:
  - Change limit from 2 to 4, as requested by Sudeep,
  - Add Acked-by,
  - Add maxItems to mboxes properties,
  - Group mboxes in example.
---
 Documentation/devicetree/bindings/firmware/arm,scpi.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scpi.yaml b/Documentation/devicetree/bindings/firmware/arm,scpi.yaml
index 800417a76bda0bd9..1f9322925e7c9f2d 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scpi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scpi.yaml
@@ -43,6 +43,7 @@ properties:
       by remote SCP firmware for use by SCPI message protocol should be
       specified in any order.
     minItems: 1
+    maxItems: 4
 
   shmem:
     description:
@@ -51,6 +52,7 @@ properties:
       be any memory reserved for the purpose of this communication between the
       processors.
     minItems: 1
+    maxItems: 4
 
   power-controller:
     type: object
@@ -235,7 +237,7 @@ examples:
     firmware {
         scpi {
             compatible = "amlogic,meson-gxbb-scpi", "arm,scpi-pre-1.0";
-            mboxes = <&mailbox 1 &mailbox 2>;
+            mboxes = <&mailbox 1>, <&mailbox 2>;
             shmem = <&cpu_scp_lpri>, <&cpu_scp_hpri>;
 
             scpi_sensors1: sensors {
-- 
2.25.1

