Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051815150CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379140AbiD2Qb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379109AbiD2QbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC04D95DA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:27:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k2so11464775wrd.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vt3h5RZNHNGkriC3xpJKhWCtJkTXJ09/LUfiLrYZt/Y=;
        b=TW1PwxNUZ9uE2RnG80wcbc3cyt/q3sJ9qAT54IqYaWB1BHi246nV6xZwrccCYONMpB
         hA5mojaG7XHb8EjPg4gpWI1SALgqtOoOWFD5cvdGaNPZ1xyGoJfEiE4mHSAYMrv/7/Bc
         779PDmGF/cMDznCRe3ID2Wyiybj6axifuu6IeYXFxHAjxmAbaY3JBS+lo5Lwwj6pR7CW
         4NGEWDT5jTnX04sbA1Ge8b1whF8QaaDH+ByyDX68n+qpC/gNxYYdyWTSqzFtTVHbbYvJ
         T9q8v8GAIN2KoIeUfTnmh+Zn4R1qSs6J1nQIC0r15nE+IptJ3sYmBP3Mhj6+bXQaZraG
         1jJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vt3h5RZNHNGkriC3xpJKhWCtJkTXJ09/LUfiLrYZt/Y=;
        b=Lyzf2EjI5wl9t/6OVCZuAYsmBjw7fQP4e/gJyT0KCeV13xvUkyvx6wb/7gvypJME8f
         SkTlQU188tmz/lNyY4rTK2Jd4eCg7pCex+Oanoz0DEJIHP6JZedhafm77rhasJtYPznv
         EENDVYww7lk5mhu3wZQ68mtfOb/pY4uL+P4H0Hth0NIxYXQ3QuJZjzQnlOaijpKYes7H
         8eYh+yXV4T/EFrBwle8tfpWe5XqWQlTX8XOl++wjrQaVNt3oKmsHXhmJRcdRydPZtgV4
         A/f1aJKngOkehrIIHRVcoTt07laIFQXP4lYjfv2YIX3oSS4cYb4Iguv/pSIBO2Zs1Mjy
         OwMA==
X-Gm-Message-State: AOAM531h7N1aHFJCS+9D5+JSfyA8uen21+ZaQKyYP7StsHR/sZsw7VDX
        AHfP1UIEq3NWZGGyGlv9+QG7PA==
X-Google-Smtp-Source: ABdhPJxl1l9eTZLE5WvZqpBsTMsK9pBMN6iX58TjKdN+QuE/gYx57Msg7YEE9pL1GMH4Zup8X3VUAg==
X-Received: by 2002:a05:6000:18cb:b0:207:8c65:3fd4 with SMTP id w11-20020a05600018cb00b002078c653fd4mr31460668wrq.131.1651249677278;
        Fri, 29 Apr 2022 09:27:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:27:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/16] dt-bindings: nvmem: Add apple,efuses
Date:   Fri, 29 Apr 2022 17:26:49 +0100
Message-Id: <20220429162701.2222-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Peter <sven@svenpeter.dev>

Apple SoCs come with eFuses used to store factory-programmed data
such as calibration settings for the PCIe and Type-C PHY.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/apple,efuses.yaml          | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/apple,efuses.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
new file mode 100644
index 000000000000..5ec8f2bdb3a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/apple,efuses.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SoC eFuse-based NVMEM
+
+description: |
+  Apple SoCs such as the M1 contain factory-programmed eFuses used to e.g. store
+  calibration data for the PCIe and the Type-C PHY or unique chip identifiers
+  such as the ECID.
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-efuses
+          - apple,t6000-efuses
+      - const: apple,efuses
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse@3d2bc000 {
+        compatible = "apple,t8103-efuses", "apple,efuses";
+        reg = <0x3d2bc000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        ecid: efuse@500 {
+            reg = <0x500 0x8>;
+        };
+    };
+
+...
-- 
2.21.0

