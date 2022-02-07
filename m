Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF34F4AB7E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351604AbiBGJgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351369AbiBGJ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:29:04 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77172C0401C9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 01:29:03 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ka4so40037305ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 01:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bo43NL5WgxumOcYzft9YAYcZtXZd3PhX1zRfnI8bjDk=;
        b=S7RBonqahTYRFKv7WG0mmEYJJUzc1lgwjVMm8b+J3T/EUN6iZ8uhtXgqlWMh/1b02H
         ziD4Jceqsrha8UsKrCqJLi6sYRh3v0gX03YdSTgjoYTGIFrTkz4d8NsCzgrZmMvLkhSS
         IJFIIqbi2s4GUNqR4ybTImL1wVgby+8h+spx97Hjjnzw+uoE+8haTHw246kq6cKBJa2m
         EO3tp78lnmVbiKHkTbGRKyfaaIx+BOPYpje3NoZIi/x3Im8yggUgGsrUI4dj0oD189Lk
         isHgXScgpluL5s1p2TdqTuZYiLN1MDPjLN2bzfRw8b/HCb0xMyn8N6Z+3sGdjoN6cX03
         BNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bo43NL5WgxumOcYzft9YAYcZtXZd3PhX1zRfnI8bjDk=;
        b=RlsWZ6Ww1AAuhwMfUWCg/zS4lUfdR1vZ/7+/oVhc82HyP7QQipNktK2M0YGy44dEbr
         rnlk4NJOpACUxSZumnjhAiqfhBvPA50GVzb/QIAMBf3PMg6OzQjw/njO1HPHYtoehsJ+
         15/vOUuK4N9PcFSoC779GUtxEHNjU1h8Tfu6UzP3KIce0maJXKjCDIcqVNt2P4lDmoy+
         UjyoR6npEqPCXOraK+iiN7frnT6uItvPHaYsor0qPoqfnRdgc24wfahcsS41vt+oU48l
         4WXvF4R0qHgP9ItNdQMfgb1AUf74tB0Ch4Q/BfiER75ZfuHPPfqmqWADOYuMwJKrkkBo
         oOlQ==
X-Gm-Message-State: AOAM533v0PRdUyXKT/xNNXpdulei4eIVb+je4NUSYFO2/Lj1GkIRKWw5
        /UoZMc6OnFurjzqnZJdwVnom3uJ8m3RiyQ==
X-Google-Smtp-Source: ABdhPJwCNcxbMgelqPsgWm8NLd9TU9xw8/NWgJ2eG5AoiN83uWaWirK6U4CMqrjTGzjaanZoefwM7g==
X-Received: by 2002:a17:906:2bd9:: with SMTP id n25mr9298896ejg.359.1644226142042;
        Mon, 07 Feb 2022 01:29:02 -0800 (PST)
Received: from fedora.. (ip-088-153-139-166.um27.pools.vodafone-ip.de. [88.153.139.166])
        by smtp.gmail.com with ESMTPSA id g9sm3487059ejm.152.2022.02.07.01.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 01:29:01 -0800 (PST)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 1/3] dt-bindings: i2c: Add Maxim MAX735x/MAX736x variants
Date:   Mon,  7 Feb 2022 10:28:24 +0100
Message-Id: <20220207092827.104978-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207092827.104978-1-patrick.rudolph@9elements.com>
References: <20220207092827.104978-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the pca954x bindings to add support for the Maxim MAX735x/MAX736x
chips. The functionality will be provided by the exisintg pca954x driver.

While on it make the interrupts support conditionally as not all of the
existing chips have interrupts.

For chips that are powered off by default add an optional regulator
called vdd-supply.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 .../bindings/i2c/i2c-mux-pca954x.yaml         | 44 ++++++++++++++-----
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
index 9f1726d0356b..8d90127b06ce 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
@@ -4,21 +4,48 @@
 $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: NXP PCA954x I2C bus switch
+title: NXP PCA954x I2C and compatible bus switches
 
 maintainers:
   - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 
 description:
-  The binding supports NXP PCA954x and PCA984x I2C mux/switch devices.
+  The binding supports NXP PCA954x and PCA984x I2C mux/switch devices,
+  and the Maxim MAX735x and MAX736x I2C mux/switch devices.
 
 allOf:
   - $ref: /schemas/i2c/i2c-mux.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max7367
+              - maxim,max7369
+              - nxp,pca9542
+              - nxp,pca9543
+              - nxp,pca9544
+              - nxp,pca9545
+    then:
+      properties:
+        interrupts:
+          maxitems: 1
+
+        "#interrupt-cells":
+          const: 2
+
+        interrupt-controller: true
 
 properties:
   compatible:
     oneOf:
       - enum:
+          - maxim,max7356
+          - maxim,max7357
+          - maxim,max7358
+          - maxim,max7367
+          - maxim,max7368
+          - maxim,max7369
           - nxp,pca9540
           - nxp,pca9542
           - nxp,pca9543
@@ -38,14 +65,6 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts:
-    maxItems: 1
-
-  "#interrupt-cells":
-    const: 2
-
-  interrupt-controller: true
-
   reset-gpios:
     maxItems: 1
 
@@ -59,6 +78,9 @@ properties:
     description: if present, overrides i2c-mux-idle-disconnect
     $ref: /schemas/mux/mux-controller.yaml#/properties/idle-state
 
+  vdd-supply:
+    description: A voltage regulator supplying power to the chip.
+
 required:
   - compatible
   - reg
@@ -79,6 +101,8 @@ examples:
             #size-cells = <0>;
             reg = <0x74>;
 
+            vdd-supply = <&p3v3>;
+
             interrupt-parent = <&ipic>;
             interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
             interrupt-controller;
-- 
2.34.1

