Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702F44A3192
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 20:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353079AbiA2ThL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 14:37:11 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37290
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234299AbiA2ThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 14:37:00 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 20D323F2FF
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 19:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643485012;
        bh=hAGep8pVNTsPRC1nSKuBp/hWEFmbR4UGlLqtXTKGMQk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=i4zpSszG15EZyTwRPbRKsmjbskf/clS+i5U33cpx5gXE5jiQk/5VXbe2wxivPbwtL
         M1WAaM/umTRMcJXwkLBqfdAoYHA2eVRjpBuv3NqQBCBe2SIEH3o/+25YAt2BFlZY+e
         2x9bpS0zo1prJcSyu5gyjBlnUes5BNnrcNOCl/lPezUfwsHDNnd2xixqNLeNTrvH//
         HNgd+Vxc52bS6VqEAh1RcewvPX32EGNGyaidUKcoFq9pLrb4RrrYIH6LOiPibhHxO4
         Q7teMXB1teYQ8Cgkc7oKZxyS2nX+OGWpdGAZg17sdASFK3OLoReDYHLXXge9crg+f4
         22I221hkOoAbQ==
Received: by mail-ed1-f69.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso4736500edk.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 11:36:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hAGep8pVNTsPRC1nSKuBp/hWEFmbR4UGlLqtXTKGMQk=;
        b=CGi8d0UUBLh36iM3xQMP9taIEtHykvC+4DzWrAwy3wIMBNYkbLjPbJwzZAg7vDrvtg
         ltCG4kCkUFRXCGs37lWwsHJl6s+9TWgy3OublMMKpcwf+eLBEQMuiFaYBu7/XIXyE3J+
         1Iw8NQ1Nyau04A8QulO789xJG/xH4JmHGnY3XVfo2tTB/YVhxJ3WgRqtWi9W6Ac+FGeN
         tCrNzP+In8V5CiKDNQTIOMpLULyt3yh1a3zL8Ggs2tKqhwRA73grwgGujSzEHFXHRAOG
         HyPSDCpyQiHzsrqsbkkVOUXtnlFx7YU41SPdmXXfrH3U8kS1sFCUilBE57ZvUtS969Vb
         UG/g==
X-Gm-Message-State: AOAM532VP0bZ/OWNKat1ho0wvmJXd0qr3O9aN2W49MNDZxZYsNn30O0V
        Apgxzg8CRa+qtnK1K0r08oEiOGSTqYvEcY0NsvEOUGPm596ASC4bs4Z20jJA/dE907zL7xITYVY
        bSPW7Im1acP6H6A64+gitNfld2Ij5Hd4GoafrJAxyPQ==
X-Received: by 2002:a17:906:e0cb:: with SMTP id gl11mr11488641ejb.135.1643485011236;
        Sat, 29 Jan 2022 11:36:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6nnWsixSDr5XE5v72szvmmUfsStrbIoMAbLaY3/xYGrtNlZ1bDnYpJvY48+Oy+FGS75nXxw==
X-Received: by 2002:a17:906:e0cb:: with SMTP id gl11mr11488637ejb.135.1643485011078;
        Sat, 29 Jan 2022 11:36:51 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bf21sm14968026edb.2.2022.01.29.11.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 11:36:50 -0800 (PST)
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
Subject: [PATCH 2/8] dt-bindings: phy: samsung: drop old Eynos5440 PCIe phy
Date:   Sat, 29 Jan 2022 20:36:40 +0100
Message-Id: <20220129193646.372481-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
References: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Exynos5440 PCIe phy support was removed in commit 496db029142f
("phy: samsung: phy-exynos-pcie: rework driver to support Exynos5433
PCIe PHY") (with its own bindings), so drop the old bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/phy/samsung-phy.txt     | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
index 8f51aee91101..390065f49b62 100644
--- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -191,20 +191,3 @@ Example:
 		usbdrdphy0 = &usb3_phy0;
 		usbdrdphy1 = &usb3_phy1;
 	};
-
-Samsung Exynos SoC series PCIe PHY controller
---------------------------------------------------
-Required properties:
-- compatible : Should be set to "samsung,exynos5440-pcie-phy"
-- #phy-cells : Must be zero
-- reg : a register used by phy driver.
-	- First is for phy register, second is for block register.
-- reg-names : Must be set to "phy" and "block".
-
-Example:
-	pcie_phy0: pcie-phy@270000 {
-		#phy-cells = <0>;
-		compatible = "samsung,exynos5440-pcie-phy";
-		reg = <0x270000 0x1000>, <0x271000 0x40>;
-		reg-names = "phy", "block";
-	};
-- 
2.32.0

