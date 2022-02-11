Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B144B2ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353509AbiBKUvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:51:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353472AbiBKUvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:51:16 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DE2DA1;
        Fri, 11 Feb 2022 12:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=meNhctVqWiZ7bMMAhRsGEJ5/xhPxg/TVlXWUTDDfSJk=; b=hI+nWPx7He/fESsdnk3+SJSf11
        OIcaZV/z0YQJ5gKRbeOEx6Pogab0Q305k899ue8COQ/TJbL6DZornZAG8j8a2DEXgfdBRWInX5/1y
        Wp9mxSTtXLcJ9bUItFZG80XLcnAghma6oZtWvynHToFDP2JtEluLT1Km/Xpmb1IO+QJA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55280 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nIcsj-00067w-Dc; Fri, 11 Feb 2022 15:51:06 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, Rob Herring <robh+dt@kernel.org>
Cc:     hugo@hugovil.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Fri, 11 Feb 2022 15:50:29 -0500
Message-Id: <20220211205029.3940756-15-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220211205029.3940756-1-hugo@hugovil.com>
References: <20220211205029.3940756-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 14/14] dt-bindings: rtc: pcf2127: add PCF2131
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add support for new NXP RTC PCF2131.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 .../devicetree/bindings/rtc/nxp,pcf2127.yaml  | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
index cde7b1675ead..57eb0a58afa3 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
@@ -14,7 +14,9 @@ maintainers:
 
 properties:
   compatible:
-    const: nxp,pcf2127
+    enum:
+      - nxp,pcf2127
+      - nxp,pcf2131
 
   reg:
     maxItems: 1
@@ -48,4 +50,19 @@ examples:
         };
     };
 
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@53 {
+            compatible = "nxp,pcf2131";
+            reg = <0x53>;
+            pinctrl-0 = <&rtc_nint_pins>;
+            interrupts-extended = <&gpio1 16 IRQ_TYPE_LEVEL_HIGH>;
+            reset-source;
+        };
+    };
+
 ...
-- 
2.30.2

