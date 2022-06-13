Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8097549BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbiFMShQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbiFMSg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:36:56 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837FAD19DB;
        Mon, 13 Jun 2022 07:56:48 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id z11so4428822ilq.6;
        Mon, 13 Jun 2022 07:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4w68Oz0WdFsRRgldOeQ5Pjd1X1lKelGqv7XShi7EebQ=;
        b=tQRQw+ZKC4nLkjqSmYpRe6lrz0kIkHSuUhx6dO0LL6TVAWJ9sp8i3RTs3JDi+3cXKq
         KdUjvP86041Nw4jQuzDPLlKYWL6prjsOYoXRBvQhPrJXDZkgrCxnVjkTeWimxH6bi2d8
         MBSrgBApTkEDcph3n6OTukEBXh31t/ZXld9Ip+u2L5rUl1DaA9R+Fb/wQcQD8WCCjx1M
         1Xp0sESDOnvgfRnWUM0B4d9kJ2c8YqFsBRLbXh/btWbBpV1o7npQQtAGmftJu3/PONU0
         GPnN1BHy1MNwNI/Zi21db6HFLXShUF7+RFLWeQSPCQx0MaUR3KSZM8Kua9B/sCQh3YdM
         I5cg==
X-Gm-Message-State: AJIora+safhQIuaZPIrD36ZaG0VKUL1LFEiSfeBHzAQukbSEOQ19OKkS
        uiSbxppNGP61cRhSDBl/cQ==
X-Google-Smtp-Source: AGRyM1tWaOAHYCw0bAjRAC2vQHsWf0/Hg8K6igY8vBjeklRkX102W/LDsyxB1xqMjijSwT+p/hfpyA==
X-Received: by 2002:a05:6e02:158a:b0:2d3:f1c0:6b68 with SMTP id m10-20020a056e02158a00b002d3f1c06b68mr128574ilu.38.1655132207733;
        Mon, 13 Jun 2022 07:56:47 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id r13-20020a056638044d00b003318c717b59sm3610860jap.39.2022.06.13.07.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 07:56:47 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: perf: Convert Arm CCN to DT schema
Date:   Mon, 13 Jun 2022 08:55:54 -0600
Message-Id: <20220613145554.3727354-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Arm CCN performance monitors binding to DT schema format.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/perf/arm,ccn.yaml     | 40 +++++++++++++++++++
 .../devicetree/bindings/perf/arm-ccn.txt      | 23 -----------
 2 files changed, 40 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/arm,ccn.yaml
 delete mode 100644 Documentation/devicetree/bindings/perf/arm-ccn.txt

diff --git a/Documentation/devicetree/bindings/perf/arm,ccn.yaml b/Documentation/devicetree/bindings/perf/arm,ccn.yaml
new file mode 100644
index 000000000000..0b0bb2091016
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/arm,ccn.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/arm,ccn.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM CCN (Cache Coherent Network) Performance Monitors
+
+maintainers:
+  - Robin Murphy <robin.murphy@arm.com>
+
+properties:
+  compatible:
+    enum:
+      - arm,ccn-502
+      - arm,ccn-504
+      - arm,ccn-508
+      - arm,ccn-512
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    ccn@20000000 {
+        compatible = "arm,ccn-504";
+        reg = <0x20000000 0x1000000>;
+        interrupts = <0 181 4>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/perf/arm-ccn.txt b/Documentation/devicetree/bindings/perf/arm-ccn.txt
deleted file mode 100644
index 1c53b5aa3317..000000000000
--- a/Documentation/devicetree/bindings/perf/arm-ccn.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* ARM CCN (Cache Coherent Network)
-
-Required properties:
-
-- compatible: (standard compatible string) should be one of:
-	"arm,ccn-502"
-	"arm,ccn-504"
-	"arm,ccn-508"
-	"arm,ccn-512"
-
-- reg: (standard registers property) physical address and size
-	(16MB) of the configuration registers block
-
-- interrupts: (standard interrupt property) single interrupt
-	generated by the control block
-
-Example:
-
-	ccn@2000000000 {
-		compatible = "arm,ccn-504";
-		reg = <0x20 0x00000000 0 0x1000000>;
-		interrupts = <0 181 4>;
-	};
-- 
2.34.1

