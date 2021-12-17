Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3864783F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhLQEUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbhLQEUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:20:14 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC1BC061574;
        Thu, 16 Dec 2021 20:20:14 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id j11so978079pgs.2;
        Thu, 16 Dec 2021 20:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zmWmnK0WKuVDlmt6wZDvsvjiu/QeAOZ/HlwwvclxrtM=;
        b=Ybhk1b4BaJOqomxkyCHZ4XMGvXqjydFRoks6iuNTckp2o2xUXKgGPdJWS4SFNIPncq
         coTDZqjmo3oOw4TLb0vcIxQEwMk6fAj8aJOVcHEv5kvQwVN4KZCBmfr4YWpxTBKB6vPT
         YLYTb/z/cD38fc3QmAlpmbGsX3O7/degx0sSEkWgD5Nqgv1z2AVZG6ZMWaGBJjcgCkBl
         Q39FcdOIjh93plaqRvZmCg7Tqa258GK+RQSa9rnkm81IDQd6s3A5MZW/aTjlzDeR0z5N
         wYySbv05CRf3KfRP+zZAnWST/a/L6GnrucUC97F3gEbRr55fP+Y2HzriPVJ8MblpPMdt
         J76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zmWmnK0WKuVDlmt6wZDvsvjiu/QeAOZ/HlwwvclxrtM=;
        b=UNW2oXibRnGzWTw6jW4vC/+A/ZoYjOkUeA/rY7/EvAh431DXWH6eV2VHECzw2L1opd
         Wp7FEMmCwH5nSiyX0x5qXwHU2jq4yu2Eph731X4lTA+bWsXkLeCH/UjnB0X937UPSVlo
         zNyjd7vUlgYT7GpZ0SqiqxdcX4ZncV9uGUNRaEKEa97Ha9snGTcaPqX/DJbvojtnuk24
         r1TbQ8nmV/R2741w+jLvTNf7r8fQdvgJgDMhT3niwj//QflJ/H9fp/OjfM8YBPJH9bu2
         yxy9ogxR/ah746766SN4yiQRZ05ZwQfo4gjhsj6YM+/7WufXOeucnZ1umzqJUIdyIVPj
         O2kA==
X-Gm-Message-State: AOAM532gQfj40UwmS7cEOHXUJWLCYCCi5SxH4/e/zJlenMsv31ANZ4OR
        wzE4cethT+ECwDFtWczlkqHEvSucd9I=
X-Google-Smtp-Source: ABdhPJwRc0wxumUjAqE7UXbvEOVWjFwqAsMctaFrs3Y1yy1SZWrTHc5v1rt+2HJdjTJQREQaitwdmA==
X-Received: by 2002:a65:4889:: with SMTP id n9mr1279475pgs.303.1639714813569;
        Thu, 16 Dec 2021 20:20:13 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id mq10sm7553496pjb.3.2021.12.16.20.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:20:13 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [PATCH v4 2/6] dt-bindings: interrupt-controller: Merge BCM3380 with BCM7120
Date:   Thu, 16 Dec 2021 20:19:57 -0800
Message-Id: <20211217042001.479577-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217042001.479577-1-f.fainelli@gmail.com>
References: <20211217042001.479577-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two bindings are very similar and should be covered by the same
document, do that so we can get rid of an additional binding file.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../brcm,bcm3380-l2-intc.txt                  | 39 -------------------
 .../brcm,bcm7120-l2-intc.yaml                 | 31 +++++++++++++--
 2 files changed, 28 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
deleted file mode 100644
index 37aea40d5430..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Broadcom BCM3380-style Level 1 / Level 2 interrupt controller
-
-This interrupt controller shows up in various forms on many BCM338x/BCM63xx
-chipsets.  It has the following properties:
-
-- outputs a single interrupt signal to its interrupt controller parent
-
-- contains one or more enable/status word pairs, which often appear at
-  different offsets in different blocks
-
-- no atomic set/clear operations
-
-Required properties:
-
-- compatible: should be "brcm,bcm3380-l2-intc"
-- reg: specifies one or more enable/status pairs, in the following format:
-  <enable_reg 0x4 status_reg 0x4>...
-- interrupt-controller: identifies the node as an interrupt controller
-- #interrupt-cells: specifies the number of cells needed to encode an interrupt
-  source, should be 1.
-- interrupts: specifies the interrupt line in the interrupt-parent controller
-  node, valid values depend on the type of parent interrupt controller
-
-Optional properties:
-
-- brcm,irq-can-wake: if present, this means the L2 controller can be used as a
-  wakeup source for system suspend/resume.
-
-Example:
-
-irq0_intc: interrupt-controller@10000020 {
-	compatible = "brcm,bcm3380-l2-intc";
-	reg = <0x10000024 0x4 0x1000002c 0x4>,
-	      <0x10000020 0x4 0x10000028 0x4>;
-	interrupt-controller;
-	#interrupt-cells = <1>;
-	interrupt-parent = <&cpu_intc>;
-	interrupts = <2>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
index e10c9879f3f8..d24493fe246c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/interrupt-controller/brcm,bcm7120-l2-intc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Broadcom BCM7120-style Level 2 interrupt controller
+title: Broadcom BCM7120-style Level 2 and Broadcom BCM3380 Level 1 / Level 2
 
 maintainers:
   - Florian Fainelli <f.fainelli@gmail.com>
@@ -59,15 +59,29 @@ description: >
   ..
   31 ........................ X
 
+  The BCM3380 Level 1 / Level 2 interrrupt controller shows up in various forms
+  on many BCM338x/BCM63xx chipsets. It has the following properties:
+
+  - outputs a single interrupt signal to its interrupt controller parent
+
+  - contains one or more enable/status word pairs, which often appear at
+    different offsets in different blocks
+
+  - no atomic set/clear operations
+
 allOf:
   - $ref: /schemas/interrupt-controller.yaml#
 
 properties:
   compatible:
-    const: brcm,bcm7120-l2-intc
+    items:
+      - enum:
+          - brcm,bcm7120-l2-intc
+          - brcm,bcm3380-l2-intc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
     description: >
       Specifies the base physical address and size of the registers
 
@@ -122,3 +136,14 @@ examples:
       brcm,int-map-mask = <0xeb8>, <0x140>;
       brcm,int-fwd-mask = <0x7>;
     };
+
+  - |
+    irq1_intc: interrupt-controller@10000020 {
+       compatible = "brcm,bcm3380-l2-intc";
+       reg = <0x10000024 0x4>, <0x1000002c 0x4>,
+             <0x10000020 0x4>, <0x10000028 0x4>;
+       interrupt-controller;
+       #interrupt-cells = <1>;
+       interrupt-parent = <&cpu_intc>;
+       interrupts = <2>;
+    };
-- 
2.25.1

