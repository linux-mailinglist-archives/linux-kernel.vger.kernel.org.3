Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3A4B81E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiBPHrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:47:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiBPHrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:47:04 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F17275D9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:46:51 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i11so791099eda.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Qp48YxiaMxUaSkAZB2KP0MgOrfMIZ3D9Sry12KdxAE=;
        b=YWeMvVBxh4gpo2h3Y85nGrHoK5QX4vV4JpIs/vWdzb1VI05buY8jA7nzVqpNNVv+cg
         PUN4WDmgbrLcgfk2HIUIzi2+QxOcO3AncSMGp6LOI8jYYeJu/ZEi68D6HfTzMdbhw//R
         zi95/6NFA0JRfqopl7H2JLnrwwRG4ATyDnuUFabRTo+r4aTmLXCvq1VRaehUIs+XGYIn
         /oX30R0pF9OG+xTwmFAe3hNzt0lHfN1WCtc4Vvh9F9XPf1mrkOH1DI59MMoAohkJgFAz
         yfcKbYQg+qpFuMQxh9bKRbhet573YD/rnVTMCmYsL9XolIBPhMTB+OjH1LfZvsOxonF+
         2G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Qp48YxiaMxUaSkAZB2KP0MgOrfMIZ3D9Sry12KdxAE=;
        b=U0AoocQUiGzm0BnrvME3JpXoMZMTfxm2I2kIoltTjjIIzd3Ww3WtIfFblcDFlWk5jO
         W/PCR/UJW7WHRGwv0tiyOny28l8uMJg1dROTeE/CTZ5cdQMDVzc6A39L6yWZDLuTcgZu
         JZX0HvjYxUqJ2KQYQlB4QXy6/01CjDd5+dke1vk7Yos135gjh0cdviZGTbz9nSGQ8T5f
         nsGthZZviHEy16/NmNPPnNA8p1cfT/hUObstEePEgU22vQ/hZYE4oI0xZS13h5nwixV9
         9QedD2pk6aiKUM6Xg4TZHnrwJjhyvYCZzOHqYFGw0fStNUytVt7DJWEP9rmsw3JMcn2v
         tVuA==
X-Gm-Message-State: AOAM532OWM1XC2R+mgUrmLSvzauzTYTEp4ZwIDu0CzRngKsJwB2y9C6U
        5yrLFMF+WClPRtgqKoWH+TBo7lJ5zAmt4g==
X-Google-Smtp-Source: ABdhPJwGUzYTRZwkbLxxIy7pE1LspK3WX+GsYx6/0IUxDYwnnzMbBQGVZNR/QjGwsy42qnyfH03QrA==
X-Received: by 2002:a05:6402:5186:b0:412:818a:aee0 with SMTP id q6-20020a056402518600b00412818aaee0mr26149edd.308.1644997609648;
        Tue, 15 Feb 2022 23:46:49 -0800 (PST)
Received: from fedora.sec.9e.network (ip-088-153-139-166.um27.pools.vodafone-ip.de. [88.153.139.166])
        by smtp.gmail.com with ESMTPSA id gq1sm11615202ejb.58.2022.02.15.23.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 23:46:49 -0800 (PST)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v6 1/3] dt-bindings: i2c: Add Maxim MAX735x/MAX736x variants
Date:   Wed, 16 Feb 2022 08:46:10 +0100
Message-Id: <20220216074613.235725-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216074613.235725-1-patrick.rudolph@9elements.com>
References: <20220216074613.235725-1-patrick.rudolph@9elements.com>
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
index 9f1726d0356b..132c3e54e7ab 100644
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
+          maxItems: 1
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

