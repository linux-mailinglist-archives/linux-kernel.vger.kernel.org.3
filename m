Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E732482BC6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiABP6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 10:58:14 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34716
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233330AbiABP6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 10:58:12 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 04E383F225
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641139091;
        bh=JsLUW9PBBaBZ0y++pKFR+MSeA/AChbSj0X9fhhwXYLw=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Hg8ws7AmHNtKIpfslVzO3lQqhDmzaAEJAK42NZ9Z0lwSgAR5eyDEK4+aVH8dbhJMc
         upbkRJMyVPN8xJLVkXtn9GSInu75vJeZc0R873e6BrTp9eyJKEvRogl0SPBX1Exitt
         IQtbwyRqp4rxWnk92dPkWf/ghNra27D+X6qaGjMXF1X+lTXtL7JZ/lr79XQVzo4zOH
         /IoKjhMwTMWhmlzojWcArbulQGyRMEE+OpQXIkuvm3mQ6SZ2xwOANCnQkoWgSyAzxR
         4Iux816Bcz9hxCFOvXh8AQFSEgiCCnuazkSfj1btUnfTRXxGg5a/W6/1Q+huCqZuKu
         uwTNH48rsQORw==
Received: by mail-lf1-f70.google.com with SMTP id n7-20020a056512388700b0042a063bb38cso2113749lft.14
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 07:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JsLUW9PBBaBZ0y++pKFR+MSeA/AChbSj0X9fhhwXYLw=;
        b=nJt7P0q91TKxPx5LhlZtMi5AlguTiTBTEHsgIAtIszhtRWc4J6dZZ9Tf0OSbgfKlGS
         7eVD2N22SyUQV0PbN3OaX1Kc47fDoxYK4JVB0hCSppLDmcnxWqa6xn+NCnquxONHDgSb
         2kje+NVsJXfjE00icteWKEdME49JKQVhSMe59vKBpeLZPwhVEssZiH6f6QcFQ4I2QZ8I
         tThErRD1Q5+g3dBD9esF70nRTfsxbAZkDbPraCkDhMGHqdnjltPSqjqzIK8UnWcBSnwm
         h/Oq85BI7eAwqHbjgIofCUADEaIpsUW3R7sR1czmdEhAY6CsOzqYSP6gyuZjIe3mxa0M
         j2dg==
X-Gm-Message-State: AOAM5338pdtEG6utW0tIwrBCpea3onDZQMk7ebH7DLOGVX/nZagHHpFT
        py0NHo9NevjZqCi/KRq9xkyxOIWkM62J//nzYXz4gIH/zjjdTer0kRUom3T01MYOPRsilTqK6K0
        Yaf5mYIZJ5L3G3Rnuh3Dq5iMB7wy4J2u88IjmPKenuQ==
X-Received: by 2002:a2e:1f09:: with SMTP id f9mr29416354ljf.3.1641139090394;
        Sun, 02 Jan 2022 07:58:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxX3lM0GN8CO7Wt7w+dKtHIACUI0lhA4N61UxnAExYdI7f5b5cZpa55feEAFdFshfYVEdZIEw==
X-Received: by 2002:a2e:1f09:: with SMTP id f9mr29416343ljf.3.1641139090145;
        Sun, 02 Jan 2022 07:58:10 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id k19sm3377612lfv.87.2022.01.02.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 07:58:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] ARM: dts: exynos: split dmas into array of phandles in Exynos5250
Date:   Sun,  2 Jan 2022 16:58:06 +0100
Message-Id: <20220102155807.42758-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"dmas" property should be rather an array of phandles, as dtschema
points.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

