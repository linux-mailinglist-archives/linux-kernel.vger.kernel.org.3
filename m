Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D03657E6BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiGVSlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbiGVSlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:41:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D0E80F64;
        Fri, 22 Jul 2022 11:41:44 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f3-20020a17090ac28300b001f22d62bfbcso3990435pjt.0;
        Fri, 22 Jul 2022 11:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jofpAqecbdGgkYzZMNCG3YcniBpkLsYrCEk/bJeq2jo=;
        b=GBKqB6O9kXYaONhBo6rVzjwqjKkOq+RwSRcG8s+Z13pqae0x2+nNdfx+WSZWhzSUK/
         gOwdostQNIlQrjHgtnEK7EZfk5bE1RyW+ZcwJ1E5XyHALjjy3HmOVUdObkApoErHP2a+
         i1Plw+EGu7H5gG5ULKHEhGqjdChBBk9cTnpcYkdxHSaLFfSwNsR6Ik5/uJcZ5E/X0YN+
         MZ4CBM8h/WOD3ZqTmGY5Q5sGuyacf2iBIaYptW67Tb6LEWbkSuJv/MNq9whE0Kxek0U/
         zf9p0rnkGB0TFozR/0Yj3NktngM/8mNU2nflV78gR4bV37PCoSIE1Rq5aE5MZgf4lhlN
         83Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jofpAqecbdGgkYzZMNCG3YcniBpkLsYrCEk/bJeq2jo=;
        b=xGT4K6PehouId49pLDBP3XVKLdyKQUrFobRSu03Ly3ipbkvAGK1IySCrgOlYsFg2FR
         qhAmfKAe0yS1pFRm1OVJzlKiNdciHDrut8lzwRLR5CJZ1f5+9ofNyEAmktTzcIsWA562
         rvaqvtVaxKVeXELIYQyIE2ptJyifIp19xb4fc/3nR/UNDI2EVnZEib617BDEFRLd8meK
         h2iUrY1svWqilWE5BoA3AdMYp+8lInWkyHWuSGKdggy1wz7Bjv7D6sq9sb/8jzHrBUwD
         ZOURps2N8hn9Bly2NFkwbIk2mF7lzEqVE+lIXmFyPgwZob1ZBL0TkjBqPnnCDjqhMLcA
         0h7g==
X-Gm-Message-State: AJIora/xVTPNXO6YzAerSg2NEUVD3xbzYUK0caJqUCdYeh+cJb2Q7o0m
        ZEg/K06+amizrDgAfklj6nLdwcJTsjE=
X-Google-Smtp-Source: AGRyM1vaJyPY9HB20qdpQMq2mZVxyUFMAIfPg1DJF+L3ybnhQs9TCzD0nAv24ZFvyrIwX+ysckI82A==
X-Received: by 2002:a17:902:d711:b0:16d:1665:1162 with SMTP id w17-20020a170902d71100b0016d16651162mr857242ply.5.1658515303257;
        Fri, 22 Jul 2022 11:41:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016c9e5f291bsm675976plg.111.2022.07.22.11.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:41:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 1/3] dt-bindings: memory-controller: Document Broadcom STB MEMC
Date:   Fri, 22 Jul 2022 11:41:36 -0700
Message-Id: <20220722184138.2666241-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722184138.2666241-1-f.fainelli@gmail.com>
References: <20220722184138.2666241-1-f.fainelli@gmail.com>
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

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../memory-controllers/brcm,memc.yaml         | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml b/Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml
new file mode 100644
index 000000000000..a629734f0cd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/brcm,memc.yaml#
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
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-controller@9902000 {
+        compatible = "brcm,brcmstb-memc-ddr-rev-c.1.1",
+                        "brcm,brcmstb-memc-ddr";
+        reg = <0x9902000 0x600>;
+    };
-- 
2.25.1

