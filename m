Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD3481F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241614AbhL3SG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241615AbhL3SGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:06:19 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052B8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:06:18 -0800 (PST)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:a9e6:6f2a:78f1:2f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 226EA28A0E8;
        Thu, 30 Dec 2021 19:06:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640887577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DiLz8h07bXCPmngkalpDxgI0CnnZbPU7/fGeU0TGX7s=;
        b=LnXKpvGw4bBLeOhVoFx0sQzmVAKFE9qRD34m7KZ5fdWb0VvaPoHCqPUjbxltyQ/iDXlk0s
        6ChnqQJoaxdbohF2d/9yiT4DQwuBSQQ1wvdSXjODyqihGZkkvGS2RbwzCFNt2WWBijKH1a
        6fIITHhN4d2dzOydGCtt5nvyfWWLciN5xIGb4Z/EBUhODXZF3kDXXDL5PK3FfWJkvTPvaR
        Y0CgjvKO0KdEUWL69UeL0G+3jKjI+Fg5xeYMPNhUjDWPqRLTpvPM3WTQjvk5WBCePsHZBX
        0UXcfwUqQ0ulYrifwreSoWo3DU2yMYXS1bOHiPtMtWWoo3qzDbxKF30AVpXHAg==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH v1 2/3] dt-bindings: power: reset: gpio-restart: Add -ms suffix to delays
Date:   Thu, 30 Dec 2021 19:06:02 +0100
Message-Id: <35e4da34fb7e18ea7e3af2405db4c5a2a7ba2dfe.1640887456.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640887456.git.sander@svanheule.net>
References: <cover.1640887456.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The delay properties are expressed in milliseconds, so the property
names should have a -ms suffix. Add the suffix, and deprecate the
original properties.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 .../bindings/power/reset/gpio-restart.yaml    | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
index 6a1f4aeebf49..13827fe7b395 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
+++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
@@ -62,17 +62,26 @@ properties:
             restart handlers
 
   active-delay:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: Delay (default 100) to wait after driving gpio active [ms]
+    $ref: '#/properties/active-delay-ms'
+    deprecated: true
 
   inactive-delay:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: Delay (default 100) to wait after driving gpio inactive [ms]
+    $ref: '#/properties/inactive-delay-ms'
+    deprecated: true
 
   wait-delay:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: '#/properties/wait-delay-ms'
+    deprecated: true
+
+  active-delay-ms:
+    description: Delay (default 100 ms) to wait after driving gpio active
+
+  inactive-delay-ms:
+    description: Delay (default 100 ms) to wait after driving gpio inactive
+
+  wait-delay-ms:
     description:
-      Delay (default 3000) to wait after completing restart sequence [ms]
+      Delay (default 3000 ms) to wait after completing restart sequence
 
 required:
   - compatible
@@ -86,7 +95,7 @@ examples:
       compatible = "gpio-restart";
       gpios = <&gpio 4 0>;
       priority = <128>;
-      active-delay = <100>;
-      inactive-delay = <100>;
-      wait-delay = <3000>;
+      active-delay-ms = <100>;
+      inactive-delay-ms = <100>;
+      wait-delay-ms = <3000>;
     };
-- 
2.33.1

