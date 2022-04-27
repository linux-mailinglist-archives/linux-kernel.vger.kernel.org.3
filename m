Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4214511522
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiD0KuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiD0KuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:50:07 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B40C43AE0C;
        Wed, 27 Apr 2022 03:20:55 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id jt15so707554qvb.13;
        Wed, 27 Apr 2022 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDR8xO+wwKORB+se6hIjkutRminbXNIR1XrVamWg1PQ=;
        b=X8H0v4zMcK1PoriBdTRnQM6YUuVfbdF2tw5pJ9qDOS+Vpye2SNjVRl9vnLn+YDjY85
         8OTn3pCcQ5lBnEhgYR4ZByYeHCJYNrZbe7OCKix61Nej9WgK3S/rrV0b9yQQ8fbQn6Rp
         J7qmHOLIX/rVmu65rG8pFXm4qXaDTWkbz2saAYZJUlnPp+nFA/u58ZIpa2GQSeYJyDbE
         ffyXfYNGILkv7eWlEITkyToCnAV5RDIMrzPesSu+c6aMO9TgfRW2Lx8TBi/95M3aHPJ3
         vBRxkdHejs01RZoBS1FPtFbiHQsjfRbkcSMbHfxLxdfn5CUJa+1Hf2J/+HhOSHLN+vw2
         CHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDR8xO+wwKORB+se6hIjkutRminbXNIR1XrVamWg1PQ=;
        b=OJmLgJ4oIRFejR2TR0ldb6khjQ8RZWrxRgkGlOyA/+ak8gfh+MXfYDxG4TM+C3jIyV
         STM/qogyDJbsibv8c9Dmo1X30jZGLAecJWlg+Zef8Al39+C9B+w8NfVyv4RvGdoXKRVd
         +U8IqBCtDL7aTxtgoXixZ+zQ2CKGB3Urgu6kIGVM6WbZk2rD5ekXrMyy3fDKvU+GdsNX
         EM5Ny1b2jkC+hRgIk1droHXrewXcakmHCLxCR0TwdSheLeuG4TkXPgdm0eEYbV3ywr39
         Cs9vQe4uBy5jcIL1JBtTzL2OAKSm1UBNXPATqk4BmNNvovgRcZkj8D6lZf0yIp3PuFyZ
         sKIg==
X-Gm-Message-State: AOAM531RiT/9LKpa/VIakTBG387OrV2fjOWzAxDpHILjnjEArdTf03dJ
        s8EskfSmRArpuQieIPitk3kqqEY1l+gmmw==
X-Google-Smtp-Source: ABdhPJxmcoTR6+hgM6pmebkEg3XnH8nl6eCvzxQC7kCt917TO0nJom8Io9I7ZGL03pX356ehYSoyfA==
X-Received: by 2002:a05:6a00:8c8:b0:4fe:ecb:9b8f with SMTP id s8-20020a056a0008c800b004fe0ecb9b8fmr29049183pfu.55.1651054154248;
        Wed, 27 Apr 2022 03:09:14 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h7-20020aa786c7000000b00505bf336385sm18260649pfo.124.2022.04.27.03.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 03:09:13 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, lee.jones@linaro.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
Date:   Wed, 27 Apr 2022 18:08:46 +0800
Message-Id: <20220427100848.3525710-3-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427100848.3525710-1-gengcixi@gmail.com>
References: <20220427100848.3525710-1-gengcixi@gmail.com>
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

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add bindings for Unisoc system global register which provide register map
for clocks.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
new file mode 100644
index 000000000000..3522f3d2d8de
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sprd,ums512-glbreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc System Global Register Device Tree Bindings
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description:
+  Unisoc system global registers provide register map
+  for clocks and some multimedia modules of the SoC.
+
+properties:
+  "#address-cells": true
+  "#size-cells": true
+
+  compatible:
+    items:
+      - const: sprd,ums512-glbregs
+      - const: syscon
+      - const: simple-mfd
+
+  ranges:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    # Child node
+    type: object
+    $ref: "../clock/sprd,ums512-clk.yaml"
+    description:
+      Clock controller for the SoC clocks.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ap_apb_regs: syscon@71000000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x71000000 0x3000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0 0x71000000 0x3000>;
+
+      clock-controller@0 {
+        compatible = "sprd,ums512-apahb-gate";
+        reg = <0x0 0x2000>;
+        #clock-cells = <1>;
+      };
+    };
+
+  - |
+    ap_intc5_regs: syscon@32360000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x32360000 0x1000>;
+    };
-- 
2.25.1

