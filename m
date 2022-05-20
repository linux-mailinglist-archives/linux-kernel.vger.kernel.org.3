Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F052F548
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353763AbiETVo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353714AbiETVoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:44:22 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE70F17B856;
        Fri, 20 May 2022 14:44:21 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-f16a3e0529so11772070fac.2;
        Fri, 20 May 2022 14:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xuAFxBe+Oh7r20VJCSRON1DgAE3jyT4SHtR5VWLH/zo=;
        b=kzXmS6nC20v++UZ6fcRGldCByqP2sHf/AW9Msb8lKkIzCt/u2gSx79pnLnwkjYrLzY
         E53jWKVqAB2EUmtUZPWJTHVNf/r+hZ7Hk5b+KwrlEYySsOnUphB0/6iaDL7BVLHyaypN
         EcYlEKskmD5nWd2X7s0jzlztpkgg2j7Qxul3a45mBa0mE7lOodvUxMfX2wJY8l+71zG8
         s/5gACxjYTp0TPhRcsUGP0qitJnWzhUsuR3aPUYk1bVO+oamfZrmRMm2kDf0FIyPCBsU
         3l68wOXmE8SnnLtEgg4dJ/uIxLgD2rzcpLBqAXo3bq7KX+T0bcfi+6F8ZTXxqmYoPNq6
         FW7A==
X-Gm-Message-State: AOAM533vKwX8S3+7iPAW+SGxgefwhNN/3RisXzqq/GWHclvPICXoC4lb
        bZLg8Dfu3D9L6cz2hF9kWxzy5+EBYg==
X-Google-Smtp-Source: ABdhPJzORFGD0rbS+Q0lOcvCQedu3y3g3eorPA5fBEYyT++cB929na6HaNNNhnoQ5HQ//MeIXp9vjw==
X-Received: by 2002:a05:6870:3292:b0:f1:2333:83c6 with SMTP id q18-20020a056870329200b000f1233383c6mr6723924oac.129.1653083060803;
        Fri, 20 May 2022 14:44:20 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056820060c00b0035eb4e5a6d8sm1615018oow.46.2022.05.20.14.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 14:44:20 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] dt-bindings: arm: Convert CoreSight CPU debug to DT schema
Date:   Fri, 20 May 2022 16:44:16 -0500
Message-Id: <20220520214416.302127-3-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220520214416.302127-1-robh@kernel.org>
References: <20220520214416.302127-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the CoreSight CPU debug binding to DT schema format.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/arm,coresight-cpu-debug.yaml | 81 +++++++++++++++++++
 .../bindings/arm/coresight-cpu-debug.txt      | 49 -----------
 2 files changed, 81 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
new file mode 100644
index 000000000000..0a6bc03ebe00
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-cpu-debug.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CoreSight CPU Debug Component
+
+maintainers:
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+  - Mike Leach <mike.leach@linaro.org>
+  - Leo Yan <leo.yan@linaro.org>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+
+description: |
+  CoreSight CPU debug component are compliant with the ARMv8 architecture
+  reference manual (ARM DDI 0487A.k) Chapter 'Part H: External debug'. The
+  external debug module is mainly used for two modes: self-hosted debug and
+  external debug, and it can be accessed from mmio region from Coresight and
+  eventually the debug module connects with CPU for debugging. And the debug
+  module provides sample-based profiling extension, which can be used to sample
+  CPU program counter, secure state and exception level, etc; usually every CPU
+  has one dedicated debug module to be connected.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,coresight-cpu-debug
+  required:
+    - compatible
+
+allOf:
+  - $ref: /schemas/arm/primecell.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: arm,coresight-cpu-debug
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+
+  cpu:
+    description:
+      A phandle to the cpu this debug component is bound to.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  power-domains:
+    maxItems: 1
+    description:
+      A phandle to the debug power domain if the debug logic has its own
+      dedicated power domain. CPU idle states may also need to be separately
+      constrained to keep CPU cores powered.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - cpu
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    debug@f6590000 {
+        compatible = "arm,coresight-cpu-debug", "arm,primecell";
+        reg = <0xf6590000 0x1000>;
+        clocks = <&sys_ctrl 1>;
+        clock-names = "apb_pclk";
+        cpu = <&cpu0>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt b/Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
deleted file mode 100644
index f1de3247c1b7..000000000000
--- a/Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-* CoreSight CPU Debug Component:
-
-CoreSight CPU debug component are compliant with the ARMv8 architecture
-reference manual (ARM DDI 0487A.k) Chapter 'Part H: External debug'. The
-external debug module is mainly used for two modes: self-hosted debug and
-external debug, and it can be accessed from mmio region from Coresight
-and eventually the debug module connects with CPU for debugging. And the
-debug module provides sample-based profiling extension, which can be used
-to sample CPU program counter, secure state and exception level, etc;
-usually every CPU has one dedicated debug module to be connected.
-
-Required properties:
-
-- compatible : should be "arm,coresight-cpu-debug"; supplemented with
-               "arm,primecell" since this driver is using the AMBA bus
-	       interface.
-
-- reg : physical base address and length of the register set.
-
-- clocks : the clock associated to this component.
-
-- clock-names : the name of the clock referenced by the code. Since we are
-                using the AMBA framework, the name of the clock providing
-		the interconnect should be "apb_pclk" and the clock is
-		mandatory. The interface between the debug logic and the
-		processor core is clocked by the internal CPU clock, so it
-		is enabled with CPU clock by default.
-
-- cpu : the CPU phandle the debug module is affined to. Do not assume it
-        to default to CPU0 if omitted.
-
-Optional properties:
-
-- power-domains: a phandle to the debug power domain. We use "power-domains"
-                 binding to turn on the debug logic if it has own dedicated
-		 power domain and if necessary to use "cpuidle.off=1" or
-		 "nohlt" in the kernel command line or sysfs node to
-		 constrain idle states to ensure registers in the CPU power
-		 domain are accessible.
-
-Example:
-
-	debug@f6590000 {
-		compatible = "arm,coresight-cpu-debug","arm,primecell";
-		reg = <0 0xf6590000 0 0x1000>;
-		clocks = <&sys_ctrl HI6220_DAPB_CLK>;
-		clock-names = "apb_pclk";
-		cpu = <&cpu0>;
-	};
-- 
2.34.1

