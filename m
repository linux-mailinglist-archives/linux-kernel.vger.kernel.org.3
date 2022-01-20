Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AB3494DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiATMOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiATMOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:14:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24C0C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 04:14:18 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n8so11643985wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 04:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H36YrbiGOn2dmwMZgkzdW8WEj8aMCcESSiL6M40TDbA=;
        b=W64G4Gd4ZxgARXL0HhvYAA+1EY/yVo8+EVDkLfan63Et+NfeLDxf0NkirD3X2MJgOg
         xvqIvJ/AOCdf1bdo5PLhqWqcA4aQEjvRGr/zX7H03FoIIzzhekjYegOTZIHEgGigPau3
         dQ3ROyd6iZkmtFPDae5BWAZOliV/ovBZVC5XKmH3h0gmoGUpuFm0kqdNYD02BCEfMPf3
         oAJ492i1+Wl0A01ZEgwfaEYiRAr6rGOes1BHTpt3i/EJmTI9QJ7s9cjp+WUHYLGuu4Lx
         KYmMgQC+SM0hkJ4TIaHDyCXdJ3a56BUBvNg22lQDG5Fy5fe2CHNYKEwsJqXhxliPBg0m
         qELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H36YrbiGOn2dmwMZgkzdW8WEj8aMCcESSiL6M40TDbA=;
        b=ByQtdrkbd45iN1xmnS7MF2tLeG2pJCx2oUWsOBu9JO6HsR+gmAWpoY8hpeLOn3okug
         JITeCgoCXmy7R5yrkBU0kx9g7vBIrZJbM+UAkLP7niE2iI0Cpy14zRC7zFqfaHj6hcdN
         c5WUe+Na1YjNrZVD8CaqeAf7gnzboCS/GvQ6G2hqQAxYAVaUxe6uiucRFE3Q+pBYKG5w
         7PI58A4BYKB9KjAgn9LdnJ8VtDLWGlAaRHO6wkq81NWi/9KsTS0WXA5zPKXN/w4dD1NP
         pIHrLyck922IwiirQmWDlm3NxhNic+sL72Vf4u3YfQbZLrciWXmiYm3vy86EiCVmmAaK
         6Oyw==
X-Gm-Message-State: AOAM531nOnXtykt6J6iSmgj48JTNbxJFBof9RRkzS0sA6uuHO+IME3Ul
        pgxHiuEYt17mID7vKTK1W0rrrw==
X-Google-Smtp-Source: ABdhPJySb22nCJLK0QuZkUxK3WffgAPGW9iFzkJWzncczeENXFWwZcNXDP+0AYEYh+kAGlaPUtl1fQ==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr29491724wry.683.1642680857269;
        Thu, 20 Jan 2022 04:14:17 -0800 (PST)
Received: from fedora.sec.9e.network (ip-088-153-139-166.um27.pools.vodafone-ip.de. [88.153.139.166])
        by smtp.gmail.com with ESMTPSA id x4sm2853863wrp.13.2022.01.20.04.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:14:16 -0800 (PST)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 1/3] dt-bindings: i2c: Add Maxim MAX735x/MAX736x variants
Date:   Thu, 20 Jan 2022 13:13:11 +0100
Message-Id: <20220120121314.463944-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120121314.463944-1-patrick.rudolph@9elements.com>
References: <20220120121314.463944-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 .../bindings/i2c/i2c-mux-pca954x.yaml         | 43 ++++++++++++++-----
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
index 9f1726d0356b..e7650e2a777e 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
@@ -4,21 +4,47 @@
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
+        interrupts: true
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
@@ -38,14 +64,6 @@ properties:
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
 
@@ -59,6 +77,9 @@ properties:
     description: if present, overrides i2c-mux-idle-disconnect
     $ref: /schemas/mux/mux-controller.yaml#/properties/idle-state
 
+  vdd-supply:
+    description: A voltage regulator supplying power to the chip.
+
 required:
   - compatible
   - reg
@@ -79,6 +100,8 @@ examples:
             #size-cells = <0>;
             reg = <0x74>;
 
+            vdd-supply = <&p3v3>;
+
             interrupt-parent = <&ipic>;
             interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
             interrupt-controller;
-- 
2.34.1

