Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3485873BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiHAWJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbiHAWJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:09:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6819CDF7D;
        Mon,  1 Aug 2022 15:09:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w10so11760508plq.0;
        Mon, 01 Aug 2022 15:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=sjab8NUtyjy7A2QDJ5EJm8tKiQk79yMcDvt2JCTAsw0=;
        b=doXfW1Zz0vXbj2SptEufE+H0lyvFuZX/+1ML39t4MtIzg2K775qZVef6fZUdoPobu/
         vt8kZlpDZMCD15SKax/ZVo0LKoCLD4UdoKt3GBQ8e9GT9tdyUgbgI/cCq23LWKFNVUAO
         VE5E+rP5Q7tBQXSDJsCQ5bxCWKErC2WUyTINMFGX2X13TDI/1NF2CCq2fR43v1M06MdX
         eOh2+ZQnlXKiA1T/j+SuvL/XZY/zYp23Mg18z4irtagh5kK1mR4eHs/pNq7guMjJfmQT
         gu2RkZ94oKnGw3+hDRrNJc6qfD9x3zdGtPqGAdl5CHFiig1fMXLctmiCyEUrCMm3vUla
         KkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sjab8NUtyjy7A2QDJ5EJm8tKiQk79yMcDvt2JCTAsw0=;
        b=ljmCoSU55dEEGnqx2O1CPZlD/7KJ5FQvs/4kPkVYHTVh6sg17KVWnw5odMg/KcK6vF
         YGFQ8nuxzfLOvU/kIRC17di4Le+fb6oDYZs+h3/oby5OxombgUrEhuwUL+NijmzxQRET
         Q9Gd7i46MRUBxQwUvQq/YY/J17THg7ngsmxW2d/H+RQv7J8fPm9rtJmrPy1hrm8YuWJK
         XtsbX9ExV4eqyiMi/vkDHaZvDV2HYU9saL/SxeUsx1UruP2hFoG1JjJ1JOEpKZGDISF0
         ubTyZRbZIvHK3p+l7oTx+w++qZ8bdzXKkTJaLJSiMU4lrEgNaKsVp7W996itnQdzf21l
         8kuQ==
X-Gm-Message-State: ACgBeo1/v8vfZTWpeoVkoZuXzDTpe/TppZhJGsgsVa6AMcGFHRnXkcYx
        vQ/eJrpqujToURe4LYJpgJ1XaYrtxVg=
X-Google-Smtp-Source: AA6agR5ubTKoly0OfbXLwy3n8TdouvblHS8E8zj9EhjHj5NhxTjqsHOBQPBQaviIotcIKnLCur+qSQ==
X-Received: by 2002:a17:902:7612:b0:16d:c805:7d4d with SMTP id k18-20020a170902761200b0016dc8057d4dmr17776805pll.171.1659391775531;
        Mon, 01 Aug 2022 15:09:35 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001637529493esm10136969plq.66.2022.08.01.15.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 15:09:35 -0700 (PDT)
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
Subject: [PATCH v3 1/3] dt-bindings: memory-controller: Document Broadcom STB MEMC
Date:   Mon,  1 Aug 2022 15:09:29 -0700
Message-Id: <20220801220931.181531-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801220931.181531-1-f.fainelli@gmail.com>
References: <20220801220931.181531-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

