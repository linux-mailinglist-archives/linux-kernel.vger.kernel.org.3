Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4974A31A5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 20:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353256AbiA2Thm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 14:37:42 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60306
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353122AbiA2ThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 14:37:13 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 16823402AA
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 19:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643485023;
        bh=okF8bn5kqmciTynWklIDfopxJdHcfxeyGhxpgYWxZes=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=IidEq6TEBore2wxMYC5TfS/YN45NCoYhBweqvosG8vVFxT0ne+/GWMgQLtI8u3PC4
         M7MYoDd3hLNzq68ErLRLw7lt+YWlucCWXJBDaX60ZLG8R7jscSVuKSGlK7refabJH+
         yxGRp7pCLJtUzxL2XJDQjj9I1FE5u3fpFqh8Vh7CkAy5YOePX3klmQcLH9S/H1qa3e
         UKVIr6zf2JUEI+F1Z/94fBVfn4TFhsZ9ZVwWlRh7LNVUY411nfRjcf13I3Kza7HYw4
         nsIpJAILu8h1bnZdtidWduBZw9kDNin/fKuV+csl/MTWakD2j2im/OV9M6hbNYgD4X
         s62Qf30wvVMyA==
Received: by mail-ed1-f71.google.com with SMTP id ed6-20020a056402294600b004090fd8a936so4774984edb.23
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 11:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okF8bn5kqmciTynWklIDfopxJdHcfxeyGhxpgYWxZes=;
        b=qpRAnmezmGcAb2842j+xtVglEq+/6G8AAjKoT/3Zvy33nKMe9fpUpCXoK01QcawRjZ
         +uj1cwkoLuWvYDOedT4ehZwi11Nuid+2Vf6rFObtY3dn4VxoSyAqspimD+/sJ6xXqjQe
         j2v/Qi6jz/bFOfwsiYZDeTfeKCCjmRE2djIQYPAtezM5JAxXjzYNwXu5qQlf9NkMGxkH
         4m3Wd3gCL7Hc1/drw9fqvtMSwIxEdw6W3omD3XvuV93buB3nCAVCjoEL9EQW6IjbIxq1
         RiPR9e536M0lR68b4ZdjubAv5P/koB56Y2BA7g88ddGwp0Wj8NWqONvcY73zHNmeqfKu
         TUrw==
X-Gm-Message-State: AOAM533Ro0EvK/W7kAL0uu6mqAlTPN359W4KtY4dHOIInxR/+KVvCE4h
        fkz81cQPEmr9DCJ1bHkjxHGzSF7TSDTKg/mYSLqUBUvxOgAAUoPdY6MiZINSmCVug0zpvcS7DGg
        2OxmqWSLE7veo87662vIdm207/95wlChaHCkxlUcq7A==
X-Received: by 2002:a17:906:99c6:: with SMTP id s6mr12264118ejn.522.1643485013704;
        Sat, 29 Jan 2022 11:36:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1xIjBHvse+WpQf8zil2xcWN1KmBQHJXw/Zj/fjql+p0Fm4NLryVA+s2m708rnsfFL8b/imw==
X-Received: by 2002:a17:906:99c6:: with SMTP id s6mr12264102ejn.522.1643485013529;
        Sat, 29 Jan 2022 11:36:53 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bf21sm14968026edb.2.2022.01.29.11.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 11:36:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 4/8] dt-bindings: phy: samsung,dp-video-phy: convert to dtschema
Date:   Sat, 29 Jan 2022 20:36:42 +0100
Message-Id: <20220129193646.372481-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
References: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Samsung SoC DisplayPort PHY bindings to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/phy/samsung,dp-video-phy.yaml    | 41 +++++++++++++++++++
 .../devicetree/bindings/phy/samsung-phy.txt   | 11 -----
 2 files changed, 41 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,dp-video-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/samsung,dp-video-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,dp-video-phy.yaml
new file mode 100644
index 000000000000..838c6d480ce6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/samsung,dp-video-phy.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/samsung,dp-video-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC DisplayPort PHY
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Marek Szyprowski <m.szyprowski@samsung.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos5250-dp-video-phy
+      - samsung,exynos5420-dp-video-phy
+
+  "#phy-cells":
+    const: 0
+
+  samsung,pmu-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to PMU system controller interface.
+
+required:
+  - compatible
+  - "#phy-cells"
+  - samsung,pmu-syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    phy {
+        compatible = "samsung,exynos5420-dp-video-phy";
+        samsung,pmu-syscon = <&pmu_system_controller>;
+        #phy-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
index 6ab16734eb65..839ffe2a2d05 100644
--- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -1,14 +1,3 @@
-Samsung Exynos SoC series Display Port PHY
--------------------------------------------------
-
-Required properties:
-- compatible : should be one of the following supported values:
-	 - "samsung,exynos5250-dp-video-phy"
-	 - "samsung,exynos5420-dp-video-phy"
-- samsung,pmu-syscon: phandle for PMU system controller interface, used to
-		      control pmu registers for power isolation.
-- #phy-cells : from the generic PHY bindings, must be 0;
-
 Samsung S5P/Exynos SoC series USB PHY
 -------------------------------------------------
 
-- 
2.32.0

