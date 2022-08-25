Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532175A1448
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbiHYOko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241645AbiHYOjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:39:42 -0400
X-Greylist: delayed 1632 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 07:38:39 PDT
Received: from mail.aboehler.at (mail.aboehler.at [178.63.100.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444C7B6D06;
        Thu, 25 Aug 2022 07:38:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.aboehler.at (Postfix) with ESMTP id D43193CC0D34;
        Thu, 25 Aug 2022 16:38:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aboehler.at
Received: from mail.aboehler.at ([127.0.0.1])
        by localhost (aboehler.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PuSPUBzEpyfc; Thu, 25 Aug 2022 16:38:36 +0200 (CEST)
Received: from x390y.lan (194-166-175-3.adsl.highway.telekom.at [194.166.175.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andreas@aboehler.at)
        by mail.aboehler.at (Postfix) with ESMTPSA id 91BD03CC0293;
        Thu, 25 Aug 2022 16:38:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aboehler.at;
        s=default; t=1661438315;
        bh=msAkpeofl6i76s1eFNpaXkmTSxKzyGsse6EZY2d6yfU=;
        h=From:To:Cc:Subject:Date:From;
        b=SmwVfalS4wgVYwCwtzw9cFmyzh/whzDnaTa3TzmbmnagCghewyQU/U788Ina4jInx
         Bv+GtSAzlvzN//qW18XlzLaQSR56kpg6JAd1jMUd5IJlOYmkXpkFxYfH5zRTogQkyc
         turotBGFXRqYgrXR1XfOKB0t3Ja6eYdCgPKXUxzM=
From:   =?UTF-8?q?Andreas=20B=C3=B6hler?= <dev@aboehler.at>
Cc:     dev@aboehler.at, Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] Documentation: devicetree: update bindings for tps23861
Date:   Thu, 25 Aug 2022 16:37:36 +0200
Message-Id: <20220825143737.77732-1-dev@aboehler.at>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tps23861 driver does not initialize the chip and relies on it being
in auto-mode by default. On some devices, these controllers default to
OFF-Mode and hence cannot be used at all.

This brings minimal support for initializing the controller in a user-
defined mode.

Signed-off-by: Andreas Böhler <dev@aboehler.at>
---
 .../bindings/hwmon/ti,tps23861.yaml           | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
index 3bc8e73dfbf0..ed3a703478fb 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
@@ -35,6 +35,50 @@ required:
   - compatible
   - reg
 
+patternProperties:
+  "^port@([0-3])$":
+    type: object
+    description: Represents ports of the device and their specific configuration.
+
+    properties:
+      reg:
+        description: The port number
+        items:
+          minimum: 0
+          maximum: 3
+
+      mode:
+        description: The operating mode the device should be initialized with
+        items:
+          - enum:
+              - auto
+              - semiauto
+              - manual
+              - off
+
+      enable:
+        description: Whether the port should be enabled
+        items:
+          minimum: 0
+          maximum: 1
+
+      power:
+        description: Whether the port should be powered on
+        items:
+          minimum: 0
+          maximum: 1
+
+      poe_plus:
+        description: Whether the port should support PoE+
+        items:
+          minimum: 0
+          maximum: 1
+
+    required:
+      - reg
+
+    additionalProperties: false
+
 additionalProperties: false
 
 examples:
@@ -47,5 +91,37 @@ examples:
               compatible = "ti,tps23861";
               reg = <0x30>;
               shunt-resistor-micro-ohms = <255000>;
+
+              port@0 {
+                  reg = <0>;
+                  mode = "auto";
+                  enable = <1>;
+                  power = <1>;
+                  poe_plus = <1>;
+              };
+
+              port@1 {
+                  reg = <1>;
+                  mode = "semiauto";
+                  enable = <1>;
+                  power = <0>;
+                  poe_plus = <1>;
+              };
+
+              port@2 {
+                  reg = <2>;
+                  mode = "manual";
+                  enable = <0>;
+                  power = <0>;
+                  poe_plus = <0>;
+              };
+
+              port@3 {
+                  reg = <3>;
+                  mode = "off";
+                  enable = <0>;
+                  power = <0>;
+                  poe_plus = <1>;
+              };
           };
     };
-- 
2.37.2

