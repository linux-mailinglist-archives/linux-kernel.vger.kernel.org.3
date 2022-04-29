Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00662514434
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355689AbiD2Ibf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355684AbiD2Ibe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:31:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE89C12F6;
        Fri, 29 Apr 2022 01:28:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n8so6560924plh.1;
        Fri, 29 Apr 2022 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BR4WAmgelf0ZWIhIYoCRXMhlMvqe3Pi566VUnFRf31w=;
        b=WBVUgRcqPVb4pEzYJwwXkB0wBQld4htKWIU9n6/5tdnmEUlme+hbT3pDnB8tPGyZZ6
         hBUAoI6CVZrDJgcQ4AFCj2sOqDzKxlObGwIlhIkgR6xjCJjtanbQ5PA3xnJOplO72lQ7
         EozDLiJ+Jr5fESWuNVL9RKkTWLVta5bb5vq6o//RcH7chYEa/RzauUiZsfgj8jhPOqD0
         uLJUVUKk6v1rCa1T6+fhm+2/tv9VLxH31+PNDbexTSzMP8JmchJ8ht5p6t0dDzjsCsqP
         kbb5/9F0FJNPsXMCBEcsCHIUmeqBoKSDPDMTuNcNDltDYGLmEDsvmB1pJwwpMKefe8c+
         SXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BR4WAmgelf0ZWIhIYoCRXMhlMvqe3Pi566VUnFRf31w=;
        b=ExoNAvPQUwwSACKlt0yOSXOKCL2pHN8+K62T/wDKslgfftNdIcRIuY8vc59bTDyg+A
         VNoEUzoESkwsJ00j1r9E2q+FXFi5/ZiwcNCYYg3Fyo7ow2loatoNLWJ+s0YlVoJTxrey
         EL3x3IhEUCJsEPP4VyfMxGwxu05Eeofq9/Dt6mLWwMhdHko2SJHTJ0IwmszMDCaRyCIw
         5odCyjkJyvYyhY2bJCxX2rPB5dvZ5h5j20Qc7ARZSTq8yfiyHNJvi29hXkJhkfoN1pn9
         tKmMvBASm3e2hYPYkOd0gb89ZM73E96QPZBxk++QNlbOqztSckDFKaHzM7DgSFeHvFVA
         osiA==
X-Gm-Message-State: AOAM530kYwfqYWOZHu3MRbfS6OH2mjMfl2E+McUtyOoqSEPfTlDL7Evc
        bYGOf3A24DNYesrrOI7L9SQaVOpXLD1ycg==
X-Google-Smtp-Source: ABdhPJyB6Mf1bKQ7+HJgsVZ8OeBnoyrZ1pixZIQDBeos+Kemq5ZHOOFCr7DDfOcABhIk2c4DX0/fIg==
X-Received: by 2002:a17:90a:5b09:b0:1cd:b3d3:a3f3 with SMTP id o9-20020a17090a5b0900b001cdb3d3a3f3mr2659601pji.9.1651220895385;
        Fri, 29 Apr 2022 01:28:15 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id z7-20020a056a00240700b004e1cde37bc1sm2346874pfh.84.2022.04.29.01.28.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Apr 2022 01:28:14 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, davem@davemloft.net,
        vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v4 2/2] dt-bindings: usb: Add bindings doc for Sunplus EHCI driver
Date:   Fri, 29 Apr 2022 16:27:56 +0800
Message-Id: <1651220876-26705-3-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651220876-26705-1-git-send-email-vincent.sunplus@gmail.com>
References: <1651220876-26705-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus EHCI driver

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v2:
  - Address the comments from Mr. Krzysztof Kozlowski and Mr. Rob Herring

 .../bindings/usb/sunplus,sp7021-usb-ehci.yaml      | 79 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml

diff --git a/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
new file mode 100644
index 0000000..307b018
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/sunplus,sp7021-usb-ehci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 EHCI Controller Device Tree Bindings
+
+allOf:
+  - $ref: usb-hcd.yaml#
+
+maintainers:
+  - Vincent Shih <vincent.sunplus@gmail.com>
+
+description:
+  Sunplus SP7021 USB HOST IP is a USB2.0 Host Controller. It supports both
+  Enhanced Host Controller Interface (EHCI) and Open Host Controller Interface
+  (OHCI).
+
+  It supports 32-bits address bus and 64bit data bus interface, compliant
+  to AMBA AXI interface for data transfer.
+
+  It supports 32-bits address and data bus interface, compliant to AMBA
+  AHB interface for register configurations.
+
+  It supports 32-bits address and data bus interface, compliant to AMBA
+  AXI interface for register alternative configurations.
+
+  The UTM Interface block generates PHY control signals, compliant to
+  USB2.0 Transceiver Macrocell Interface Specification Revision 1.0.
+
+properties:
+  compatible:
+    const: sunplus,sp7021-usb-ehci
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: uphy
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - interrupts
+  - phys
+  - phy-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    sp_ehci0: usb@9c102100 {
+      compatible = "sunplus,sp7021-usb-ehci";
+      reg = <0x9c102100 0x68>;
+      clocks = <&clkc 0x3a>;
+      resets = <&rstc 0x2a>;
+      interrupt-parent = <&intc>;
+      interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
+      phys = <&sp_uphy0>;
+      phy-names = "uphy";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e103afa..a057288 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18918,6 +18918,7 @@ SUNPLUS USB EHCI DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
 F:	drivers/usb/host/ehci-sunplus.c
 
 SUPERH
-- 
2.7.4

