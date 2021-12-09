Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9132346E22E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhLIFyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhLIFyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:54:43 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BF9C0617A1;
        Wed,  8 Dec 2021 21:51:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E09C1419C2;
        Thu,  9 Dec 2021 05:51:04 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mailbox: apple,mailbox: Add generic and t6000 compatibles
Date:   Thu,  9 Dec 2021 14:50:48 +0900
Message-Id: <20211209055049.99205-2-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209055049.99205-1-marcan@marcan.st>
References: <20211209055049.99205-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Much as we've done with other blocks, let's introduce generic
compatibles so drivers can bind to those and still work with future
SoCs, as long as the hardware remains the same. Also go ahead and add
compatibles for the new t600x SoCs (we group those as t6000).

Note that no DTs instantiate devices with this binding yet.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../devicetree/bindings/mailbox/apple,mailbox.yaml   | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 2c1704b34e7a..58007c789671 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -27,14 +27,20 @@ properties:
           for example for the display controller, the system management
           controller and the NVMe coprocessor.
         items:
-          - const: apple,t8103-asc-mailbox
+          - enum:
+              - apple,t8103-asc-mailbox
+              - apple,t6000-asc-mailbox
+          - const: apple,asc-mailbox
 
       - description:
           M3 mailboxes are an older variant with a slightly different MMIO
           interface still found on the M1. It is used for the Thunderbolt
           co-processors.
         items:
-          - const: apple,t8103-m3-mailbox
+          - enum:
+              - apple,t8103-m3-mailbox
+              - apple,t6000-m3-mailbox
+          - const: apple,m3-mailbox
 
   reg:
     maxItems: 1
@@ -68,7 +74,7 @@ additionalProperties: false
 examples:
   - |
         mailbox@77408000 {
-                compatible = "apple,t8103-asc-mailbox";
+                compatible = "apple,t8103-asc-mailbox", "apple,asc-mailbox";
                 reg = <0x77408000 0x4000>;
                 interrupts = <1 583 4>, <1 584 4>, <1 585 4>, <1 586 4>;
                 interrupt-names = "send-empty", "send-not-empty",
-- 
2.33.0

