Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB957E817
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbiGVULt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbiGVULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:11:46 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0079FE0D;
        Fri, 22 Jul 2022 13:11:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c139so5348141pfc.2;
        Fri, 22 Jul 2022 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lbo5uECb0o/jiIgG5lB+d7+oEGREOOe63VzH02hiN10=;
        b=pIRZCYJmMVT98nQge1EzLzSpw3xkaPz+b/mLErevak3WGzOn/C+WvvGhCxaZIVgbAp
         3KWUHtgfm6CxB3fUuZrZHl8iF+qXL7KafXRcgD8i4msz7BoHXs+cjTWV1ZydHenMp9Is
         +WuLlMStLh6ccvgenVirflO2DLiGTrVXPGdnigRPHukAdwoZbAf8lLxUeiqN/sebqmg3
         1QREJgFtu2a8kR9bljmv83OcAauD72vCIN+LWCzRt4c+BdlIJeB0tqg+1MfVW8duUijK
         keebtE76pq3CMZ6iHlNGGBaVQTiW4M1u2WjSC1LVNqIQxmf33VyWlZMzHzFV9vR/qjgF
         KjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lbo5uECb0o/jiIgG5lB+d7+oEGREOOe63VzH02hiN10=;
        b=6p8ZWR6xNgYJsvaMZgOZTMJfzII1RL0viXRfuENWYGjI15L6V0iu98yihFCL+SMNyB
         oCigd556Pb9MHTzmNRnRODWReyJZpXBpdfuPsqwNa5VSiJ29AFuIRkwRBi6lFhjvUzV1
         wRdsoTJpzkvqdkI6uBx3iSxLUbW/X5whLAn5Sh+IaqK86ZSudOiOYYfIQ/hlANhSCjIN
         7V83wYWurfrX8W0H1ycgS6WNIwG5O14vTxDR93AsfoE0lyqPFSyM8HefCE14C0VdNn+M
         UxyT/998L0DVjiZPyVdb4mAQfcs79YyAPhRPKOqeUw5ISrw7mJQVVYn9jpb5hKYAGy1N
         X8aA==
X-Gm-Message-State: AJIora87UHricfuoxPsVAz5DNW/NsUblZqNlxIvhzG0LZIIZnSu0b8Jn
        uejQV1IyR/iao6STNLymta0dMFUd6xI=
X-Google-Smtp-Source: AGRyM1sFhcDB3t1xGU2Of1ghtHRwoRHDTRV8XFilpEt0pDeJEHb2VLjQa/4LEfFlTqN4jQH8KCPboA==
X-Received: by 2002:a65:6bc4:0:b0:3c2:2f7c:cc74 with SMTP id e4-20020a656bc4000000b003c22f7ccc74mr1208985pgw.307.1658520704327;
        Fri, 22 Jul 2022 13:11:44 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902780200b0016c0eb202a5sm4098604pll.225.2022.07.22.13.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:11:43 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2 1/3] dt-bindings: memory-controller: Document Broadcom STB MEMC
Date:   Fri, 22 Jul 2022 13:10:41 -0700
Message-Id: <20220722201043.2731570-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722201043.2731570-1-f.fainelli@gmail.com>
References: <20220722201043.2731570-1-f.fainelli@gmail.com>
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

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,brcmstb.txt         | 11 +---
 .../brcm,brcmstb-memc-ddr.yaml                | 53 +++++++++++++++++++
 2 files changed, 55 insertions(+), 9 deletions(-)
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
index 000000000000..a1479b75c536
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml
@@ -0,0 +1,53 @@
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
+  - clock-frequency
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

