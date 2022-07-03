Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF34564948
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiGCSfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiGCSfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:35:25 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A5AB75
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 11:35:23 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v9so8546698ljk.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AP2/efFfUDebdlE0yNTe8GyV2AogZFZgk7dz0GR3fBc=;
        b=zQUHevyZzzdk/XKbU9YZcSPXgVbNKQSP/3VAfGvhTDoY4imJX+B7kJRx8tjWAQDV28
         VSqBbjaqGF/AQmbdqOl7hQGtt1x/KDpxUmJ41WbB070fwvbYZC9Dg+VmvT/9j6GQUJfC
         wDCpuySBT0Q4JL4h/krdHq6ZrwSw/VG90hPzl/xk6y46rKv1WjmFEXhrD4jgbrPyj1f+
         xlEBo8xCFAW3AT8NaCQ4CpSCHSoIA9cHDsS9NrOcXFAVU9jsnWrHKT0JuXrB7iIUXES6
         gHad3sBsv6uUeyBodAMO97pUHyWClr7Zs5xcs6SCbPWYxxXvN7gC+vWO+TBvCvhgJz57
         8mLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AP2/efFfUDebdlE0yNTe8GyV2AogZFZgk7dz0GR3fBc=;
        b=eLr7DueTtsMGxKYTwa/qL+s4++poc/CffBcMi7OajI7V/GMCupp3CIRL/oLF9Zs0ij
         gtMoHvLqPx125Oa41TDmLfHiCVESnqdT7ytqvtsontJxj0NS6KTIDU8tN0pNtUIif+TY
         8IhR6yjZYmW3NPqqAZIyC+OuWJm/2ozq0gis736T+espW+8jq7fkAWi62ygDekf+dopq
         GsDUtRcQMCtnq8j8z5ghYk1HiU6jvbvcO7OXkPGlKkwtmP9TAW90fUrHXt5OhpWGV5Ql
         7Kkp4+j84zCSUcwQBobbGEImHSk0xtIoZvpDWh4qm/t1GGjf5wQVp4Ka8aSmjWW1Pr2A
         yyUg==
X-Gm-Message-State: AJIora/idrkOqlORuaTIl2A/bbCvRYEf1IH5muOK287qQj40pjA3q8Li
        C0Tvmz2wLj0ixNKjWLcsWmMCAA==
X-Google-Smtp-Source: AGRyM1tzj6MYo9YvTk8sXWmAU4N52ZC5v/l8ZBIasempFqYnY03ZDamXfM5aDNHtpjpaLrPs0M77bQ==
X-Received: by 2002:a2e:8558:0:b0:25a:742f:d7 with SMTP id u24-20020a2e8558000000b0025a742f00d7mr14118804ljj.178.1656873321335;
        Sun, 03 Jul 2022 11:35:21 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id n3-20020a056512310300b0047960b68eb5sm2020412lfb.40.2022.07.03.11.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:35:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] dt-bindings: hwinfo: samsung,s5pv210-chipid: add S5PV210 ChipID
Date:   Sun,  3 Jul 2022 20:34:49 +0200
Message-Id: <20220703183449.12917-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220703183449.12917-1-krzysztof.kozlowski@linaro.org>
References: <20220703183449.12917-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document already used S5PV210 ChipID block.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Move to hwinfo and rename.
2. Mention that device is already used.
---
 .../hwinfo/samsung,s5pv210-chipid.yaml        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwinfo/samsung,s5pv210-chipid.yaml

diff --git a/Documentation/devicetree/bindings/hwinfo/samsung,s5pv210-chipid.yaml b/Documentation/devicetree/bindings/hwinfo/samsung,s5pv210-chipid.yaml
new file mode 100644
index 000000000000..563ded4fca83
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwinfo/samsung,s5pv210-chipid.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwinfo/samsung,s5pv210-chipid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5PV210 SoC ChipID
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    const: samsung,s5pv210-chipid
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
+    chipid@e0000000 {
+        compatible = "samsung,s5pv210-chipid";
+        reg = <0xe0000000 0x1000>;
+    };
-- 
2.34.1

