Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD33475C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbhLOP4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:56:07 -0500
Received: from marcansoft.com ([212.63.210.85]:52888 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244285AbhLOP4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:56:03 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 73E38421F5;
        Wed, 15 Dec 2021 15:55:59 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: mailbox: apple,mailbox: Add generic and t6000 compatibles
Date:   Thu, 16 Dec 2021 00:55:26 +0900
Message-Id: <20211215155527.36775-2-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211215155527.36775-1-marcan@marcan.st>
References: <20211215155527.36775-1-marcan@marcan.st>
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

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../devicetree/bindings/mailbox/apple,mailbox.yaml   | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 2c1704b34e7a..e3d87239811c 100644
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
+          - const: apple,asc-mailbox-v4
 
       - description:
           M3 mailboxes are an older variant with a slightly different MMIO
           interface still found on the M1. It is used for the Thunderbolt
           co-processors.
         items:
-          - const: apple,t8103-m3-mailbox
+          - enum:
+              - apple,t8103-m3-mailbox
+              - apple,t6000-m3-mailbox
+          - const: apple,m3-mailbox-v2
 
   reg:
     maxItems: 1
@@ -68,7 +74,7 @@ additionalProperties: false
 examples:
   - |
         mailbox@77408000 {
-                compatible = "apple,t8103-asc-mailbox";
+                compatible = "apple,t8103-asc-mailbox", "apple,asc-mailbox-v4";
                 reg = <0x77408000 0x4000>;
                 interrupts = <1 583 4>, <1 584 4>, <1 585 4>, <1 586 4>;
                 interrupt-names = "send-empty", "send-not-empty",
-- 
2.33.0

