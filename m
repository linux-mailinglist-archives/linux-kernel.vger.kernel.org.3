Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81824A311D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352794AbiA2Rxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:53:39 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36092
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352729AbiA2Rxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:53:37 -0500
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2ADB43F1D0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 17:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643478816;
        bh=UuAmHmse5/7Zq3pHBrLReTIT8+GCT8GhUGa1FdMNyD0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=C6D06qp0NZpK/cpAobfix1u4cWS0k2bIaNXKtyFaPAXOr1lIew2dUhWLXoa2Xvh/A
         9rMYzjD2yGakCeumHg7B7JE5LvV+rJIZXb0piVxpIM7dIG3G4vQKU4tYf7c8CD0iEM
         sNDZFRQcoHBIGL14tQExREN5LaezA2V53n2xvDrej0hDM0A6luZ/+QnQ7DoELZcjB3
         72OxLlGIcM8AOdJGNohF66k8NEXSJqjzAaUX+bQZRP1zUJDflw4tjOhGQNkOV1d+z8
         cwZYm34KYewgcyDr8EIxrOLU7Om8G2fqWMBAsfu3RuIr21C6TOxBruoDVrOPNe8w7u
         iksG19IAm6haA==
Received: by mail-ej1-f72.google.com with SMTP id l18-20020a1709063d3200b006a93f7d4941so3801884ejf.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 09:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UuAmHmse5/7Zq3pHBrLReTIT8+GCT8GhUGa1FdMNyD0=;
        b=rUBtqWqMMKjbI6tK+LXD45sMj1tq7poWkIcYK0kel6LYD3l0t5u7wQ7cCN7lLELXXG
         tKSQ4yu46vYYTIytR40iW/Tp7+8PW8c2V1MF8nj+HvQKdul9StzG30zzlfQm04W+VQzN
         2Xyt74epRQ5MfeFrI7vhG5dTX6LztLVPXeN/IipRTsBxmDOgdpT74TbGuoJ3itJ5Cs1e
         +c7oWMT/EUPVzLcNaCQh72K5rRf8kjpTz12eIcd8Kdt6dA5Jfx4CMalyh0YyuOZFiAiq
         DHm2gkzqb7adyFssBwztfYNo2f60Uc2645rrP2Zfmi99V9Azgr6U+vCSMF+3SqFahO1c
         xENQ==
X-Gm-Message-State: AOAM530BKEzAteG2eI+0UwaZKhaIY57rkoHX44XK8wYX9WsjRZaqM4JS
        v7s4VMzhzoq9dziz64fx3wUXQ3YlnI7YWfbrGnyw4vuu3wTbCLqFyPRlKdII/AsuCBAB0GZVxrQ
        cfdPU5Uzl7gL0xSJkFJvoo/mSN5EC2opruKavf40wGw==
X-Received: by 2002:a17:907:3e83:: with SMTP id hs3mr11405849ejc.16.1643478815351;
        Sat, 29 Jan 2022 09:53:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoYeYNFVHm8L57tWF3N04jNWX9vUgWvjjwCv32ktyz+5reypKzReeLBf3LNdZx/oGR3dBS5w==
X-Received: by 2002:a17:907:3e83:: with SMTP id hs3mr11405836ejc.16.1643478815150;
        Sat, 29 Jan 2022 09:53:35 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s12sm11236266ejx.184.2022.01.29.09.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:53:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 1/5] arm64: dts: exynos: align pl330 node name with dtschema
Date:   Sat, 29 Jan 2022 18:53:28 +0100
Message-Id: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes dtbs_check warnings like:

  pdma@15610000: $nodename:0: 'pdma@15610000' does not match '^dma-controller(@.*)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 6 +++---
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index bfe4ed8a23d6..b4cde77e02d3 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1858,7 +1858,7 @@ mshc_2: mshc@15560000 {
 			status = "disabled";
 		};
 
-		pdma0: pdma@15610000 {
+		pdma0: dma-controller@15610000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x15610000 0x1000>;
 			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
@@ -1869,7 +1869,7 @@ pdma0: pdma@15610000 {
 			#dma-requests = <32>;
 		};
 
-		pdma1: pdma@15600000 {
+		pdma1: dma-controller@15600000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x15600000 0x1000>;
 			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
@@ -1891,7 +1891,7 @@ audio-subsystem@11400000 {
 			#size-cells = <1>;
 			ranges;
 
-			adma: adma@11420000 {
+			adma: dma-controller@11420000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x11420000 0x1000>;
 				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 960823b8247a..3364b09c3158 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -142,7 +142,7 @@ gic: interrupt-controller@11001000 {
 				<0x11006000 0x2000>;
 		};
 
-		pdma0: pdma@10e10000 {
+		pdma0: dma-controller@10e10000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x10E10000 0x1000>;
 			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
@@ -153,7 +153,7 @@ pdma0: pdma@10e10000 {
 			#dma-requests = <32>;
 		};
 
-		pdma1: pdma@10eb0000 {
+		pdma1: dma-controller@10eb0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x10EB0000 0x1000>;
 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.32.0

