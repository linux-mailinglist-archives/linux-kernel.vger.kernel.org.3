Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046695115C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiD0LDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiD0LCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:02:54 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6849B3E99D8;
        Wed, 27 Apr 2022 03:41:53 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id b17so743329qvf.12;
        Wed, 27 Apr 2022 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=suJzkUXqPQf4PYb2XhQgEpW3i2lXW5ZFjJbjw6YDCwQ=;
        b=lU8rgki1uD9UMtWb81rCPzKmXqQKTc1SYK/4Jg4IOXlm9l51RDUyETvWNsPyrQJ5oD
         NTPG9mu3bcgiMxkdnx2/hrfx47TKhDWW/Y1ynVywJ4kpPU7RjGdibVfTYiJkpR2OqQea
         Kz+l/deOPIaKMf8Ejftkc9lV/5uKuEddUQHKF9xr02rG5mggH14WtDbZvoW4CZxU76mr
         /rhC/vX4rVTMcT8Frj0S1uRWpKt28xWSAArRzE9fevX6vPqFhVd1tSB8lHKlXuO8M6te
         +miMtKU0K8jWuReH9+xpmYPKmT5N6rpri2rVVnLPnKXGkCaFx6C3RmI2ezZtcDiEv+wu
         Ha1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suJzkUXqPQf4PYb2XhQgEpW3i2lXW5ZFjJbjw6YDCwQ=;
        b=mz3ozHTVtvyDjUvZLukVC20WaneqOJVVqOJs1qpzj7CD/5uMyDlfc1wf9LonL3B6MA
         S2p+n5K7hItMUKC5nyfy8IXj8VXbJYrmkwBsY5wGB5MEEoMJZv7mjjuua73qrwu86Yx1
         vTrpafTaUqEebdHgQ4Vacn/yXUgG/V/zeWp/OcOLq6WL7DZ+SajFlfH49AB+Ov5NvtUC
         QHKoIFtHhQCzAx/G3XPE/NtpjnWZgd91BAbcN03GG3HquFzIXqqqR+ByaRU5sjdzL/Lb
         J7O6cdDKA4sxuSVaTeGGtbpzDA934jv7mCOre6+7kA3Z1roPApwOHb7lE0IQY+dJ29Zp
         dZaQ==
X-Gm-Message-State: AOAM531zNsvCX7qpNlAh+LmqPRX3SKFP8/ElkK4+Shpdo1ycPmp5hTO1
        pft+a2I5ieZkF8OyOD43OuBNg9yNXH1SSQ==
X-Google-Smtp-Source: ABdhPJwMXZ+bv/j/U49YNgrTCpbhxGZbtDZO4KJmBqL8dV/TqcqnkVRGW5dvPH1fMgHAXjGOmoGPuA==
X-Received: by 2002:a05:6a00:a8b:b0:4e1:52db:9e5c with SMTP id b11-20020a056a000a8b00b004e152db9e5cmr28922674pfl.38.1651054147588;
        Wed, 27 Apr 2022 03:09:07 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h7-20020aa786c7000000b00505bf336385sm18260649pfo.124.2022.04.27.03.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 03:09:07 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, lee.jones@linaro.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/4] dt-bindings: clk: sprd: Add bindings for ums512 clock controller
Date:   Wed, 27 Apr 2022 18:08:45 +0800
Message-Id: <20220427100848.3525710-2-gengcixi@gmail.com>
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

From: Cixi Geng <cixi.geng1@unisoc.com>

Add a new bindings to describe ums512 clock compatible string.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 .../bindings/clock/sprd,ums512-clk.yaml       | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
new file mode 100644
index 000000000000..5f747b0471cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: UMS512 Soc clock controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sprd,ums512-apahb-gate
+      - sprd,ums512-ap-clk
+      - sprd,ums512-aonapb-clk
+      - sprd,ums512-pmu-gate
+      - sprd,ums512-g0-pll
+      - sprd,ums512-g2-pll
+      - sprd,ums512-g3-pll
+      - sprd,ums512-gc-pll
+      - sprd,ums512-aon-gate
+      - sprd,ums512-audcpapb-gate
+      - sprd,ums512-audcpahb-gate
+      - sprd,ums512-gpu-clk
+      - sprd,ums512-mm-clk
+      - sprd,ums512-mm-gate-clk
+      - sprd,ums512-apapb-gate
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+    description: |
+      The input parent clock(s) phandle for the clock, only list
+      fixed clocks which are declared in devicetree.
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: ext-26m
+      - const: ext-32k
+      - const: ext-4m
+      - const: rco-100m
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#clock-cells'
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ap_clk: clock-controller@20200000 {
+      compatible = "sprd,ums512-ap-clk";
+      reg = <0x20200000 0x1000>;
+      clocks = <&ext_26m>;
+      clock-names = "ext-26m";
+      #clock-cells = <1>;
+    };
+...
-- 
2.25.1

