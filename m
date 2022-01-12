Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB9B48C1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352344AbiALKBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:01:21 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58378
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239613AbiALKA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:00:56 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 083DE40317
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641981655;
        bh=QVrXucYojgYJ3MvsfMwPKw5wo2fuH+ML9mi4xwVkLOQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kjsHl/gaf1PG3XsuQBlc1y/giifAKd4nVO/sr5vU3HB66JOprokzzZlenJ5RXPDnM
         9K6FCxS40XhMAYVH1JbBhcQtNWBn0YamybDEIoL36sBzpj+TkBszremaHslzdtuZAf
         RjMvkLPgPUfPkJlchrsFUxM1ZYjw53/o7F1UvBsqhSnW9QhUTsbeHUiOsztF43WN3U
         NyK95S7keU3aSXeLNCcYzmixwddY9sD7nRc1+YRUl7k7QGJQUFu8SsT6zj5kGkir58
         E6gS2JRORiCZ7wcS0UumfZOyo81IJ5Smuutqx293dZkN+K29ieFjxCvGqh0T92PkE+
         ZMC4n+fu7a6rg==
Received: by mail-ed1-f70.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso1769989edt.20
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QVrXucYojgYJ3MvsfMwPKw5wo2fuH+ML9mi4xwVkLOQ=;
        b=xsrtiTGrt6J30iCSD3DA/G+gD0iAdwGxbI19OIlC8mQLUResPjJDqwbxd6XPH/MYRW
         Og53QN/c5vOsFVMTu0Q55p9A8+q0m+JYX/9yDGBANugPpQ+wcmt3BMCQebLZ5ZX+e/08
         Vyaru4GuM+tuABRRiy7Uk24ksx06PrqEaBHkPLd/XULqsRsCay+lTtRfonkhXX3Vwtyr
         Gxxo9LAQl08/sm6f+pNTKxw3TOG5TyhQReUwx6bHk1HBxDXyReyZ51/vk23QHmNmRO0k
         zKj0uHC5gUwV1ZldT7DInlvTUftRtmF9q4pbiGZ3hK/R3tQqW71OY7PEt8JQIrgMueCR
         u5qg==
X-Gm-Message-State: AOAM533hi2yUo0RR3KCwrRgIg42ThwFDTeV6IqIpNqaA/KB35BWJF+bE
        VRhYiDGvi2dEArwv9Y3LUnIFF0fDPMPn7TCgzMkgf+10qZi+bHZf1Z1SukRzWuzEG+PDPAkZhJq
        FCGTjBT22niHqDJ8yp6qmLjVXCuMK0kcx0aKFOsw83w==
X-Received: by 2002:aa7:c1d7:: with SMTP id d23mr8007134edp.25.1641981653222;
        Wed, 12 Jan 2022 02:00:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKiVju5BY5SKliX0Vazs/LyzcIPx+Xnn1NeOt/kXgzB98trXRihJhGZ2eu1WJFRzbKvyKDGw==
X-Received: by 2002:aa7:c1d7:: with SMTP id d23mr8007050edp.25.1641981651551;
        Wed, 12 Jan 2022 02:00:51 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id hb11sm4311083ejc.33.2022.01.12.02.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 02:00:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v3 1/4] ARM: dts: exynos: split dmas into array of phandles in Exynos5250
Date:   Wed, 12 Jan 2022 11:00:43 +0100
Message-Id: <20220112100046.68068-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
References: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"dmas" property should be rather an array of phandles, as dtschema
points.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Andi Shyti <andi@etezian.org>
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

