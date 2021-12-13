Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C32472B31
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbhLMLVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:21:12 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46392
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231296AbhLMLVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:21:09 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B864F3F175
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639394468;
        bh=xdfPDnUa/UcvSSeLF3saSWMWAAoRJzBhdsMDRnO/JDQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=LeGfp0SfXiD6nLvL0vtDFW9dl1CftXAt/zplYOIj5pTRd39WVV0zEgRJYRM/p4t37
         HTWKWOwuwWdrNu0fz+/UWkhbEy+efMJOGQMlmPVd1RULRgdz8DYtc8TPnP0UEVqajY
         1h5wFA1Pz1Q7Y3Uzk7BrK9BOP5ZlnqrHgRHR4MjUrLgiKPiZLFIIo+dUAu4WmQrpe9
         Ilfa5VjPYuRVot0ztp6yBxSdgs3YpreG1Btf+wYg++FoE0ApaNpHY6bzKrkDAp01NV
         UuOPWq52VXyTA+z8uhTKiDnpSB4D7T8Fslp9sOVJu+ZBMQ2o17iTzC6vVKRJ9kUiTe
         UgJaauw5Hz3jg==
Received: by mail-lf1-f70.google.com with SMTP id w21-20020a197b15000000b00422b0797fa3so139662lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 03:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xdfPDnUa/UcvSSeLF3saSWMWAAoRJzBhdsMDRnO/JDQ=;
        b=xQx/V45HFGTVNUqvt7OMsVXuHMPzR5cD6dX87GOJ3s3KUDG39p906eR6o99aFizv7P
         AxLJ+HXaTBlNNt88wSFcOD3kHy303BTbWmP3Dg2wx+nWHA1oNRBvcKqkbbvjmZEoanW9
         zQbp4M3N6KwC/DXa2Quwt0R4g5UW6nnMEClHJ+NLsR1ThoxEiDVRpLIsmcYGUL3hO/pl
         GQpImHTAhaKqccPd2K/UibpA+JCLm1eERqYwQp7EXa6/v3QgbP0nhhh3bcyGKdyx+Xgl
         2Et3Va1KCD2/qL3gbIP6HXs48oc0OTAx0/kckz6LoteeR6Wxn9nYQ0t/tjAnVuva70fx
         gxsQ==
X-Gm-Message-State: AOAM533BESABteXomhWaPEMapgE68SOVIjz95x4qOysUMWfP0xTb9Bzz
        rsOY272Gp00F37RC8ABbAygaX9S0yjXl4AfR/4euME3/w6IqSntdmGNFd/s4Xx18rSrVnOb8wLx
        +q/5YCdsrjsra8kN9+ncYf52dwLvFDN8AEsUsDORq6Q==
X-Received: by 2002:ac2:5317:: with SMTP id c23mr28053342lfh.525.1639394468225;
        Mon, 13 Dec 2021 03:21:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWZO1hjyHi3R4CUnRLP/FUuM1hUtLtmHevibc8NPWHgNjYpl3AgKLpdoWTlWW3NXfnSe/3ng==
X-Received: by 2002:ac2:5317:: with SMTP id c23mr28053326lfh.525.1639394468040;
        Mon, 13 Dec 2021 03:21:08 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bq18sm43660lfb.88.2021.12.13.03.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:21:07 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: samsung: keep SoC driver bindings together
Date:   Mon, 13 Dec 2021 12:20:57 +0100
Message-Id: <20211213112057.16709-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently added Samsung Exynos USI driver devicetree bindings were added
under ../bindings/soc/samsung/exynos-usi.yaml, so move there also two
other bindings for Exynos SoC drivers: the PMU and ChipID.

Update Samsung Exynos MAINTAINERS entry to include this new path.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/{arm => soc}/samsung/exynos-chipid.yaml | 2 +-
 .../{arm/samsung/pmu.yaml => soc/samsung/exynos-pmu.yaml}       | 2 +-
 MAINTAINERS                                                     | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/{arm => soc}/samsung/exynos-chipid.yaml (93%)
 rename Documentation/devicetree/bindings/{arm/samsung/pmu.yaml => soc/samsung/exynos-pmu.yaml} (97%)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-chipid.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
rename to Documentation/devicetree/bindings/soc/samsung/exynos-chipid.yaml
index bfc352a2fdd6..4bb8efb83ac1 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-chipid.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/samsung/exynos-chipid.yaml#
+$id: http://devicetree.org/schemas/soc/samsung/exynos-chipid.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Samsung Exynos SoC series Chipid driver
diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/arm/samsung/pmu.yaml
rename to Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index 0bbd89265b28..c30a6437030d 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/samsung/pmu.yaml#
+$id: http://devicetree.org/schemas/soc/samsung/exynos-pmu.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Samsung Exynos SoC series Power Management Unit (PMU)
diff --git a/MAINTAINERS b/MAINTAINERS
index 79ef55bf2ca7..8926b925514d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2554,6 +2554,7 @@ Q:	https://patchwork.kernel.org/project/linux-samsung-soc/list/
 F:	Documentation/arm/samsung/
 F:	Documentation/devicetree/bindings/arm/samsung/
 F:	Documentation/devicetree/bindings/power/pd-samsung.yaml
+F:	Documentation/devicetree/bindings/soc/samsung/
 F:	arch/arm/boot/dts/exynos*
 F:	arch/arm/boot/dts/s3c*
 F:	arch/arm/boot/dts/s5p*
-- 
2.32.0

