Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BFC5914D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbiHLRcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbiHLRbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:31:35 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9CBB248D;
        Fri, 12 Aug 2022 10:31:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id e28so1278782qts.1;
        Fri, 12 Aug 2022 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=sjab8NUtyjy7A2QDJ5EJm8tKiQk79yMcDvt2JCTAsw0=;
        b=nVfrYlWRzDUck1DebjdefJaXAbtcBFycnp3gtj02ghP5oPhHFZt3ezQehqJREv5ZBH
         hjAIiGNKIPyzrDTKrdg8pcNUYIAX+JZSq2dV9m8UnBvk46J2grPf4MDis6AKTQjm4fa7
         ZDV+izdVleyUaPxVcz26pGnsyWBeX+b41v4RD5p2RYmdD6c/naCfAMTGDcQt5JEppgha
         +YF6FnFNY4IjO7K9wuGWRVNi8nqyDItYrspckF9/9DdfsNHJOUYTKmdbcfytFzbXozcw
         qARmUeUWRQWaqrNPY4rRJMimxsLepF8cPymk4EMV9qLx6ktPnPR5X0B3cTz7/z/goAX4
         fyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sjab8NUtyjy7A2QDJ5EJm8tKiQk79yMcDvt2JCTAsw0=;
        b=svWFdSDal9u1T7yoNv8y6NB5WGETJ2HdGR+p9UOogGNEhMCHh4Jq68+05QFlSbSHS8
         ltOo3yZrTKjIqvE/kefuo/iRxSbzVfOKpGa7OLRt5qQteyl497EmhAaZX8YT/+mAxmoL
         85jxcVpt3eO6zAGMkeyVIXX/1/aUG5wo2oU46g5OE0et6IlMLdqUxr2zVrKCP3AlveXj
         zh4tnROGtpy1x7ac813oU2OIixBnCqNesBFE74e8V1TVf4gWmQl695gIHC32ApGObnJ3
         l9WWOppOnuImzlzUFxhKsTAjdEjMb/mTazZcXuJyaP1+sQZwMxmTSGUjhaa7djjL48bB
         0kqA==
X-Gm-Message-State: ACgBeo20m4THIDLBbrT7VI610KPQFs4UNuU1Efrh6jFGXENHHUnTemOC
        R8mdEds4KnteSM+yfiSnqRZ1dc1tevk=
X-Google-Smtp-Source: AA6agR6veVPiUF+nEdr/188KNF2vU9BS5nI9czYnLmdhXiGGtIpVOVA6S42K7vjG48rnySciwI63sw==
X-Received: by 2002:a05:622a:48d:b0:343:7386:8b6f with SMTP id p13-20020a05622a048d00b0034373868b6fmr3162397qtx.280.1660325493535;
        Fri, 12 Aug 2022 10:31:33 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t201-20020a37aad2000000b006b9b7879964sm2369300qke.28.2022.08.12.10.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 10:31:32 -0700 (PDT)
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
Subject: [PATCH v4 1/3] dt-bindings: memory-controller: Document Broadcom STB MEMC
Date:   Fri, 12 Aug 2022 10:31:23 -0700
Message-Id: <20220812173125.2410536-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812173125.2410536-1-f.fainelli@gmail.com>
References: <20220812173125.2410536-1-f.fainelli@gmail.com>
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

