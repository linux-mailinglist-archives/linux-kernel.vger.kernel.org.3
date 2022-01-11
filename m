Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD148AB25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348786AbiAKKNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:13:47 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41820
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237533AbiAKKNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:13:44 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B859F3F1A2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 10:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641896023;
        bh=QVrXucYojgYJ3MvsfMwPKw5wo2fuH+ML9mi4xwVkLOQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Gq3lptDrM/UFNL9K/3/ZPoRFEhBHvgw1ITCAoyZg4SnJETIO2T1/FyDwqprOXD/Fx
         6zzIyZsk/Cgn2u4PV/YlwPm29ifz3M2F9PJEO4148SQU9Taz5x1Rfi312DkzHOVrrm
         5wExd6u9BCtdwMVRJ3X/iPAdbfQ9JvCaH2xVR4+L2Xbt/Y87OG1oKc7Q77l221q2yZ
         Ums6GX+gyFc05V2sYbqIYNcbvzqJUMfR+D3Y69Tvf2LiOWstlsifpfS5LSJM3IOJkS
         78PSXHOr5UllMBjS9w/xpcl84wPnZp1z/yq77L4vovd04hbfEG39y9x3fyi+xX+Cey
         UUJc/IVigvU/Q==
Received: by mail-ed1-f69.google.com with SMTP id i9-20020a05640242c900b003fe97faab62so3029022edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QVrXucYojgYJ3MvsfMwPKw5wo2fuH+ML9mi4xwVkLOQ=;
        b=6Kz6VH6+JWH04SInhgb12ArFWJKZnG0pav9+beVzGDPGe1zGxdQYMlNBMgpwXNSB54
         ebSyZh7niwhh1s4nHvlcO5+wkcMC0mQWZnGoN5jkkvoS6xu/JIBH+6e9qZ/mi5AHBIzu
         lh9wq0mkrM4/DkyZjmHAJ/5DA6OmKDcA9IGD4VN5nGyMDiOt3LgcvbhrKLi4OzqU9GAG
         ARw6mlt0VhKZVeNE23bclAUZ7fs0JL3iglzHk08H0B6u2M6LWYxvsfkeCygj7ywIc/Mb
         rdl37l3DTFKcBBIz5sZqOr+6Q/f8Ab9GlhSZNPxAw+Y4Y/Q9fzlTayz+JNv5KfZFvCGQ
         Etdw==
X-Gm-Message-State: AOAM533t+Vqd+1uR2aLKX2E7cpO1LKuxjw+f6bTBAoDmW+fc0rJgxGPp
        41q5cAquxepVkXT8k4QOAUyAcN6tVOhddxaVBSyTHuNfQ6Yi1ewJTDhbOz02iQicgQ8DtvIQxe7
        N1r3KdmOYwzUf/Qq5BaNTCfAZ40EeYwyaXMQEuPjYZA==
X-Received: by 2002:aa7:df8f:: with SMTP id b15mr3664567edy.315.1641896022753;
        Tue, 11 Jan 2022 02:13:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpyMwCXUtd7Y6AQyuZuNoCVyccezBv3KC5C5r5rIpS2xwUTuoqjT0UFg4qT8tvTh/Gn938UA==
X-Received: by 2002:aa7:df8f:: with SMTP id b15mr3664549edy.315.1641896022625;
        Tue, 11 Jan 2022 02:13:42 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id 26sm3431268ejk.138.2022.01.11.02.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 02:13:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v2 1/4] ARM: dts: exynos: split dmas into array of phandles in Exynos5250
Date:   Tue, 11 Jan 2022 11:13:35 +0100
Message-Id: <20220111101338.58630-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com>
References: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com>
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

