Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A61846787B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381157AbhLCNio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381153AbhLCNig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:38:36 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA511C061785
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:35:12 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:3191:9890:620a:6f4])
        by michel.telenet-ops.be with bizsmtp
        id RpbA2600D3eLghq06pbAZm; Fri, 03 Dec 2021 14:35:10 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt8iT-002LQX-Rt; Fri, 03 Dec 2021 14:35:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt8iT-000kke-6z; Fri, 03 Dec 2021 14:35:09 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] dt-bindings: input: gpio-keys: Fix interrupts in example
Date:   Fri,  3 Dec 2021 14:35:06 +0100
Message-Id: <47ecd2d8efcf09f8ab47de87a7bcfafc82208776.1638538079.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638538079.git.geert+renesas@glider.be>
References: <cover.1638538079.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "interrupts" property in the example looks weird:
  - The type is not in the last cell,
  - Level interrupts don't work well with gpio-keys, as they keep the
    interrupt asserted as long as the key is pressed, causing an
    interrupt storm.

Use a more realistic falling-edge interrupt instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/input/gpio-keys.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index 060a309ff8e7c757..dbe7ecc19ccb9423 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -142,7 +142,7 @@ examples:
         down {
             label = "GPIO Key DOWN";
             linux,code = <108>;
-            interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+            interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
         };
     };
 
-- 
2.25.1

