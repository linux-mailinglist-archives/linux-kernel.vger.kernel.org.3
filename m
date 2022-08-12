Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EA8591751
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbiHLW0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbiHLWZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:25:43 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292B71277A;
        Fri, 12 Aug 2022 15:25:41 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id y11so1607477qvn.3;
        Fri, 12 Aug 2022 15:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=sjab8NUtyjy7A2QDJ5EJm8tKiQk79yMcDvt2JCTAsw0=;
        b=Md4C8I0nToiurd6jFbss960niyOTyVYjKWaUsf3SNJdZfhUKrPb4iXMshy4Jwz6yFv
         eUjBrLhdraTRyxmVxWvDOZjc5S9dEL9VEhl1irEakQt+5ZeRHfrExetKYrHlIajRj4kH
         yeylhiTsKem6bhK+mJAoX7bZTFxojvsoss5Cs9mh1agBoPHmYZwwaMtYkvb14PRLLTgC
         LX9+bq6uoTY2Cmq9lXtjn1UdaMrZKu36OwKL1zSCo6Cs27mixJmIfLMXyEHdf2yj/zvO
         vmYSdp6ZgcZuXv7Vpwu224Cc1pCNs0W7WbWeEkXZoKtvs4QnN8ubqASM8K4XEis+3Sao
         sRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sjab8NUtyjy7A2QDJ5EJm8tKiQk79yMcDvt2JCTAsw0=;
        b=pLjWYfxVZWrqaEAaBgk9UGtVG7OvgFeDrYjCq//enNIXrUcVWqVdkIMSBnTRfwb6hl
         DWSVoZR8FkPXSWQoLa57t6IE9HOtPQs9XXcAP40ez9k0R/yh7RS98CCbXdBEQF2UDkFD
         ZO68C7WczxZZmKu16VBFRUvfQNa7CM+GuFRr4HvDrjgCxqEaCv2I0vCia1dwRzKjc776
         FXJMZ8ZPcGcgXYwKTH6diy0t7GfTWIpfbhFtN2iYkjd6wMS+sCVJaCWBmPO3kEvzO3zs
         6gh17+YuiymjxkQbgIw1MIqiDF7EatD0yBPGLpFXEP1dI3AvWPXNqtbA8CsSLhc8Kkg8
         GnnQ==
X-Gm-Message-State: ACgBeo3ipokd6PK+Pa0EOt8EXdiCOEBDPcKTjAOtI8z8Cwxi0sLFlUY9
        7lkAI+MmeUT9LP3Vis5THq1ehz6zwSU=
X-Google-Smtp-Source: AA6agR7XSdST2ZdExTvos4vOXScfuTgnmGAC1pwJii3cki6a03KXHCU4AYxc29sFgJ5DdbibLEINhQ==
X-Received: by 2002:ad4:5c4b:0:b0:474:7aa4:b0ba with SMTP id a11-20020ad45c4b000000b004747aa4b0bamr5572631qva.49.1660343139022;
        Fri, 12 Aug 2022 15:25:39 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f17-20020a05620a409100b006b942ae928bsm2788878qko.71.2022.08.12.15.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 15:25:37 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v5 1/3] dt-bindings: memory-controller: Document Broadcom STB MEMC
Date:   Fri, 12 Aug 2022 15:25:31 -0700
Message-Id: <20220812222533.2428033-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812222533.2428033-1-f.fainelli@gmail.com>
References: <20220812222533.2428033-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Broadcom STB memory controller which is a trivial binding
for now with a set of compatible strings and single register.

Since we introduce this binding, the section in
Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt is removed
and this binding is referenced instead.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,brcmstb.txt         | 11 +---
 .../brcm,brcmstb-memc-ddr.yaml                | 52 +++++++++++++++++++
 2 files changed, 54 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
index 104cc9b41df4..e797d2f69f3b 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
@@ -187,15 +187,8 @@ Required properties:
 Sequencer DRAM parameters and control registers. Used for Self-Refresh
 Power-Down (SRPD), among other things.
 
-Required properties:
-- compatible     : should contain one of these
-	"brcm,brcmstb-memc-ddr-rev-b.2.1"
-	"brcm,brcmstb-memc-ddr-rev-b.2.2"
-	"brcm,brcmstb-memc-ddr-rev-b.2.3"
-	"brcm,brcmstb-memc-ddr-rev-b.3.0"
-	"brcm,brcmstb-memc-ddr-rev-b.3.1"
-	"brcm,brcmstb-memc-ddr"
-- reg            : the MEMC DDR register range
+See Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml for a
+full list of supported compatible strings and properties.
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml b/Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml
new file mode 100644
index 000000000000..4b072c879b02
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/brcm,brcmstb-memc-ddr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Memory controller (MEMC) for Broadcom STB
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - brcm,brcmstb-memc-ddr-rev-b.1.x
+          - brcm,brcmstb-memc-ddr-rev-b.2.0
+          - brcm,brcmstb-memc-ddr-rev-b.2.1
+          - brcm,brcmstb-memc-ddr-rev-b.2.2
+          - brcm,brcmstb-memc-ddr-rev-b.2.3
+          - brcm,brcmstb-memc-ddr-rev-b.2.5
+          - brcm,brcmstb-memc-ddr-rev-b.2.6
+          - brcm,brcmstb-memc-ddr-rev-b.2.7
+          - brcm,brcmstb-memc-ddr-rev-b.2.8
+          - brcm,brcmstb-memc-ddr-rev-b.3.0
+          - brcm,brcmstb-memc-ddr-rev-b.3.1
+          - brcm,brcmstb-memc-ddr-rev-c.1.0
+          - brcm,brcmstb-memc-ddr-rev-c.1.1
+          - brcm,brcmstb-memc-ddr-rev-c.1.2
+          - brcm,brcmstb-memc-ddr-rev-c.1.3
+          - brcm,brcmstb-memc-ddr-rev-c.1.4
+      - const: brcm,brcmstb-memc-ddr
+
+  reg:
+    maxItems: 1
+
+  clock-frequency:
+    description: DDR PHY frequency in Hz
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-controller@9902000 {
+        compatible = "brcm,brcmstb-memc-ddr-rev-c.1.1", "brcm,brcmstb-memc-ddr";
+        reg = <0x9902000 0x600>;
+        clock-frequency = <2133000000>;
+    };
-- 
2.25.1

