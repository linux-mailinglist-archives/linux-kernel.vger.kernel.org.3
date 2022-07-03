Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D1E564945
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiGCSf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiGCSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:35:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A82BE76
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 11:35:21 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id n15so8550029ljg.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8IkkEF4egC3rkEgWtJPxJ8ArxvMQw5ju4scGShbuOI=;
        b=dcZO+XEXqVI6lBTu1pbWv4FzDBL+GzNuPVE4zcv1kWfoO8AuGesGwm38bSzC39E6B2
         gChT2X6Vjp/HsDyqgQDd842auAnF+dgaZz4sFrZCebNk2DZilyb4hxuLrch4+Ehw5EdW
         VkZnRc8btqBREk3FcUGWvoAtRoe7+Xdt2da8WuL/o4isrJZaz1wfuQGbDfi0S1wwK+Yw
         oKAud5LdkYuQQXuTTFIOOZ5HrFaz02NA4m+wWX1eM31yd6U5QVeUUDSH2jqBQa/YIM5s
         pNbUsf5BEhOhLhqF6huE5yTuG+5mz4XodimkWcxMCSrrdB5ghjWjpYPipkZUZS2ftFOy
         y5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8IkkEF4egC3rkEgWtJPxJ8ArxvMQw5ju4scGShbuOI=;
        b=CMt5QDvLDd7fj2htvcfdcHsTeY8+vwH/fWS98HDKWNcEw41qEAJNdBQqCA/wbc17fa
         mO9vk0Hswq0SdKbDQBv66oe4XmT7Un6gwQdzcxT4/JBd3DbIShHquoRPnSkSx7VXM11Z
         Z9a2i+loAYqnlJv768BlBjGaRp/0xj/KiEEQoYCkdKnvnz4Kd9rbavr9SFdCq928eQtu
         cuhghFPBPVu0MUYCX7sQyXny6km3Uqg74GkppvE8ySsVPnUVJXP305ubMdiYzSued3Mj
         LW5kwz5tFDp1VgYDAVPMf0YCIdd5vUqGuy7WwdzxZ4GEIMRaXwOnsThOG50FzJOcD99R
         P15Q==
X-Gm-Message-State: AJIora+ALJhUK2KZ9g7jfIbxoO82WWCQD5CI/Z125BRYWU4hrtFh0mfS
        hdvipozF2Btg7vDYIwDiZS96hA==
X-Google-Smtp-Source: AGRyM1uFo1i/MRFrFZEDssmgTQ+njlO8c/6dj0jLYFkx9vj29tUzIRFbNBhZgB16vqbK0g6NJ8l0dA==
X-Received: by 2002:a2e:9d8e:0:b0:25b:e468:6629 with SMTP id c14-20020a2e9d8e000000b0025be4686629mr13799339ljj.335.1656873319751;
        Sun, 03 Jul 2022 11:35:19 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id n3-20020a056512310300b0047960b68eb5sm2020412lfb.40.2022.07.03.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:35:19 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: hwinfo: group Chip ID-like devices
Date:   Sun,  3 Jul 2022 20:34:48 +0200
Message-Id: <20220703183449.12917-2-krzysztof.kozlowski@linaro.org>
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

Group devices like Chip ID or SoC information under "hwinfo" directory.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch
---
 .../bindings/{soc/renesas => hwinfo}/renesas,prr.yaml          | 2 +-
 .../exynos-chipid.yaml => hwinfo/samsung,exynos-chipid.yaml}   | 2 +-
 .../{soc/ti/k3-socinfo.yaml => hwinfo/ti,k3-socinfo.yaml}      | 2 +-
 MAINTAINERS                                                    | 3 +++
 4 files changed, 6 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/{soc/renesas => hwinfo}/renesas,prr.yaml (92%)
 rename Documentation/devicetree/bindings/{soc/samsung/exynos-chipid.yaml => hwinfo/samsung,exynos-chipid.yaml} (92%)
 rename Documentation/devicetree/bindings/{soc/ti/k3-socinfo.yaml => hwinfo/ti,k3-socinfo.yaml} (92%)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,prr.yaml b/Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/soc/renesas/renesas,prr.yaml
rename to Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
index 654c96638e75..792f371cec03 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas,prr.yaml
+++ b/Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/soc/renesas/renesas,prr.yaml#
+$id: http://devicetree.org/schemas/hwinfo/renesas,prr.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas Product Register
diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-chipid.yaml b/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/soc/samsung/exynos-chipid.yaml
rename to Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
index 4bb8efb83ac1..95cbdcb56efe 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-chipid.yaml
+++ b/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/soc/samsung/exynos-chipid.yaml#
+$id: http://devicetree.org/schemas/hwinfo/samsung,exynos-chipid.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Samsung Exynos SoC series Chipid driver
diff --git a/Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
rename to Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
index a1a8423b2e2e..dada28b47ea0 100644
--- a/Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
+++ b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/soc/ti/k3-socinfo.yaml#
+$id: http://devicetree.org/schemas/hwinfo/ti,k3-socinfo.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Texas Instruments K3 Multicore SoC platforms chipid module
diff --git a/MAINTAINERS b/MAINTAINERS
index 7c9187635801..cd7a6598436d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2629,6 +2629,7 @@ Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 C:	irc://irc.libera.chat/renesas-soc
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
 F:	Documentation/devicetree/bindings/arm/renesas.yaml
+F:	Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
 F:	arch/arm64/boot/dts/renesas/
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
@@ -2679,6 +2680,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
 F:	Documentation/arm/samsung/
 F:	Documentation/devicetree/bindings/arm/samsung/
+F:	Documentation/devicetree/bindings/hwinfo/samsung,*
 F:	Documentation/devicetree/bindings/power/pd-samsung.yaml
 F:	Documentation/devicetree/bindings/soc/samsung/
 F:	arch/arm/boot/dts/exynos*
@@ -2912,6 +2914,7 @@ M:	Tero Kristo <kristo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/arm/ti/k3.yaml
+F:	Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
 F:	arch/arm64/boot/dts/ti/Makefile
 F:	arch/arm64/boot/dts/ti/k3-*
 F:	include/dt-bindings/pinctrl/k3.h
-- 
2.34.1

