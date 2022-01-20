Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858964953B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiATR6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:58:02 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40638
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233214AbiATR55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:57:57 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 096C540029
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642701476;
        bh=OI1v3v2do2JpaG4iEWGXiW3KIkLzyCyv5Mi1khRNczo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Oyx4UgYRQzTNMP5SHrkg0wukBO0bASWi5OCM++9gY6WSlHThleHd3ngg9EbmQV9VK
         k1Lr/Ccxnavh1yGQcxwYL+OUaPVwWoU7Ld/mxpmk5G8s7ip962Heil9I2fXyRqE2oZ
         38tgcAriDwzf/kZSxAtbgvI8QBbDNrg7JImIefB1XvvbN/tlu4P4eH+hEYLixNILlI
         7qpaEHmV6HnDwKrtuk95W+timkyW7YtKLtJzME2EJKEFIFul+cdT0k6QsWHeAofzrm
         0goDkVJhkQNTyk2jSKzq6Ol1IPRqA7147byt8Bi/+I8/J1Ogi3oLK2VidQS98LTSnN
         4ksTvqJ6ScGXA==
Received: by mail-wm1-f71.google.com with SMTP id n25-20020a05600c3b9900b00348b83fbd0dso4602669wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OI1v3v2do2JpaG4iEWGXiW3KIkLzyCyv5Mi1khRNczo=;
        b=6JSUY1urEY5PsrYz+8QztY7hFZqaT1YPe8Oo2ywCV+opLh1nftTiYVIR1yFOCuniLm
         RvptMyqW9XfBE/osus/nXOqXT9DxMl/qt+vqAXw7NKgpI/i2nANIuPwO3NDpnr+vpXBP
         CDaLj770qdxSnsjPPPh8RxGsBtY7HWAuULA8xDK3OUNXPuVoSC5i178jM/JJ2kyE1/9q
         9dmo4QAVpi4MWVi6/sMkoDDVP69et50RiJmODv2Man+LTfcOJYo4PKEcOridcmrYfSZR
         TtRWZnLuYo5Z2DLId9d4zKxVB2gN0Do2bdGln77DZShBXkeNx88WHFnA0YgHkgv34fzj
         cNvA==
X-Gm-Message-State: AOAM533bs5rlLT6pIiVtnUv/LgfY4mpeEaqHnUsenRvP0nxCAQI5khrs
        V3PT1tUVm0seUCNN89Uh0Ch+HdFIsm+2Ko2PeAW1BuNJ99KgygKjvJ5KUGUTLKu/Nr2mnxpG03K
        7NfpjFoUf0v6HSlw5RpxV33Eroupy+eSBAMtZa0cIQw==
X-Received: by 2002:a1c:4d0e:: with SMTP id o14mr6744wmh.1.1642701473512;
        Thu, 20 Jan 2022 09:57:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmTsqY8bb8HLxL6NNBjcVpHEecqLr4GeD0bg1kTvShl9on4V8QSt4DHHPqVOEBS9tMoc/Fcw==
X-Received: by 2002:a1c:4d0e:: with SMTP id o14mr6723wmh.1.1642701473346;
        Thu, 20 Jan 2022 09:57:53 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a15sm3345248wrp.41.2022.01.20.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:57:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v5 1/4] ARM: dts: exynos: split dmas into array of phandles in Exynos5250
Date:   Thu, 20 Jan 2022 18:57:44 +0100
Message-Id: <20220120175747.43403-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220120175747.43403-1-krzysztof.kozlowski@canonical.com>
References: <20220120175747.43403-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"dmas" property should be rather an array of phandles, as dtschema
points.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Andi Shyti <andi@etezian.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 139778928b93..102bb57bf704 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -496,8 +496,7 @@ spi_0: spi@12d20000 {
 			status = "disabled";
 			reg = <0x12d20000 0x100>;
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&pdma0 5
-				&pdma0 4>;
+			dmas = <&pdma0 5>, <&pdma0 4>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -512,8 +511,7 @@ spi_1: spi@12d30000 {
 			status = "disabled";
 			reg = <0x12d30000 0x100>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&pdma1 5
-				&pdma1 4>;
+			dmas = <&pdma1 5>, <&pdma1 4>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -528,8 +526,7 @@ spi_2: spi@12d40000 {
 			status = "disabled";
 			reg = <0x12d40000 0x100>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&pdma0 7
-				&pdma0 6>;
+			dmas = <&pdma0 7>, <&pdma0 6>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.32.0

