Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3344A31A1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 20:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353125AbiA2ThW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 14:37:22 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37346
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353099AbiA2ThH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 14:37:07 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B3A3E4002A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 19:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643485018;
        bh=Fc1eyAl7NybW6jYdngJRL9d8j3U5amMxubQkyGhXpG4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PgOrk954aJll0U8qHwyfFHfOjAnd61R9wrh74AJF9KhEm1VKcWLNLv6LYNnQxa4Kl
         OBKHAfLpQr6mMqNOkOt7MZ12D8JIpzdJZwitmkod/IX+bWSqmwRR5y/etP2U4Y3IsO
         JJtswVzJzczbxAcuq7YmIr85d+HYIuUrRw/Gv1iEamxL4GNbjn2BS/7Oq3dysUmRIH
         XeSrFw6VZg8k+zL43IzB3zh/fJAz3VlDv1AdvAbrbN3NVejkla4An8Y9hj58As6wFV
         kz3z6Jk1ETbAouWF7bYygJKC93haR7pkSKnUAvcHH+etCaZYbYhvN9wy4pkT1oBNDe
         M//K325mNHeWg==
Received: by mail-ed1-f71.google.com with SMTP id bc24-20020a056402205800b00407cf07b2e0so4798236edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 11:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fc1eyAl7NybW6jYdngJRL9d8j3U5amMxubQkyGhXpG4=;
        b=w1fIhzj1TTKVcGp5T1OMH29z09MfvGTbbn80Ow1mVb3HRUr+5Sp1P2zk4feTGudJ8S
         nc4Vjbh4it9XD5Y8E6AgBnT9LQ+xgZ3m+iXzusKWUDoik4e1KLMi4s3EA3jdwiY5cnZ6
         TDlBs6fPB1JbOCiCnQpbLvLkKFbyC2i2eePyJpcLc/MHV7QJyoQTBONf2DsmmxyjZuVW
         KJgwyPZ6IP0FIm4RFZOvRee70SCuitYPjELimJVU3WIVEmpQj341ZKCk5sr2JzKSaBBN
         HTGtOFBfjhWzeNrwaGgfOUMIFrM3XGDfzz3k0nmiFKa09Wd6Xn/K7UmrMzirjR4tW0xW
         iCzg==
X-Gm-Message-State: AOAM532WB++uTFhLr62QcXH/KLoPr1yTqb7X0YNYlXRWsC8xxg7VJxNT
        1B16nKoP/Imc+qwJ6n5Prjxub5M7wS00twFDwHauif5W/3dCf1uTLxwAuUXI72mePWgiywdS7Zb
        d08QMOAkBWr+wq7Ui6b2eotOyNjny5bGDIhN5l2JiVA==
X-Received: by 2002:a17:907:6096:: with SMTP id ht22mr11140550ejc.611.1643485018006;
        Sat, 29 Jan 2022 11:36:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2C00tlFyQ3RoELXj4WirLkICa8agfl7xt6lK1t4z9axQaIvO2QsBaGqe8J3bXTyJSyrs97A==
X-Received: by 2002:a17:907:6096:: with SMTP id ht22mr11140538ejc.611.1643485017831;
        Sat, 29 Jan 2022 11:36:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bf21sm14968026edb.2.2022.01.29.11.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 11:36:56 -0800 (PST)
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
Subject: [PATCH 7/8] dt-bindings: phy: samsung: move SATA phy I2C to trivial devices
Date:   Sat, 29 Jan 2022 20:36:45 +0100
Message-Id: <20220129193646.372481-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
References: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C interface for Samsung Exynos SoC SATA phy is a very simple and
limited, so move it to trivial devices.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/phy/samsung-phy.txt        | 14 --------------
 .../devicetree/bindings/trivial-devices.yaml       |  2 ++
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
index 1ee78016dc72..b0abeb4ac0a2 100644
--- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -1,17 +1,3 @@
-Device-Tree bindings for sataphy i2c client driver
---------------------------------------------------
-
-Required properties:
-compatible: Should be "samsung,exynos-sataphy-i2c"
-- reg: I2C address of the sataphy i2c device.
-
-Example:
-
-	sata_phy_i2c:sata-phy@38 {
-		compatible = "samsung,exynos-sataphy-i2c";
-		reg = <0x38>;
-	};
-
 Samsung Exynos5 SoC series USB DRD PHY controller
 --------------------------------------------------
 
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 091792ba993e..d53a4b2f81aa 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -283,6 +283,8 @@ properties:
           - renesas,isl29501
             # S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
           - samsung,24ad0xd1
+            # Samsung Exynos SoC SATA PHY I2C device
+          - samsung,exynos-sataphy-i2c
             # Sensirion low power multi-pixel gas sensor with I2C interface
           - sensirion,sgpc3
             # Sensirion multi-pixel gas sensor with I2C interface
-- 
2.32.0

