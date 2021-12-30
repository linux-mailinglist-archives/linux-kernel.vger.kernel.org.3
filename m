Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31AE482013
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbhL3Txm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:53:42 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36124
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242028AbhL3Txj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:53:39 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6D86640710
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 19:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640894018;
        bh=8uEPws7WapP8rUIPMK6UFetuvdb1C3w9FuCMI36coi0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=MmvXfGOxbyaGvtXJH+Sm/7l6oHMOp9Nm421qB0UqutaS4GlO7Ci3kqa/NGfzEJMom
         tmsjDD/WeN2wdMmcs7jXeBUsay14cA9Ce7QyGoEH1RHMGxKW1gbtcnXUdHZreZ2iZn
         AdloX+fMtQqTDVW6lIqQACRSHun8Sxb490csBkNUBbbIdJ3a3pvJoJYww3AccrLBka
         UCemlxD675XkbQ1U7O9fklIA+cxWRO8y51KrbOJdB1cgLCjgVGHHUb7v0dl5DdkRvG
         zw5x3mhdAE9avfITYKjrS8kjtnhJKEM44r0As1YeCsHyvD6sfa3NFIRUUEhh0V29Sd
         7tihllKzX1OvQ==
Received: by mail-lj1-f198.google.com with SMTP id j15-20020a2e6e0f000000b0022db2724332so6165176ljc.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uEPws7WapP8rUIPMK6UFetuvdb1C3w9FuCMI36coi0=;
        b=MTqAjGUBbxXYqxswkyYxuh+81BwRH3+gHTYKD9hcdgZDbY72rtmU5Q9oItYLf6NGlq
         HV96SbbboDBR1dTTl307vqcPvnJl/ADnMDKuC+zmJc0x8YdjVMpshNwR6mws0V8tfHnB
         vGJvD4PQASxFro1Tg+BlkbFRgkQoNE5f3D81AuBPe+738+6EyFgwziX4yjIOWrsyABm1
         9M9xEVRTBUTcSfITI2z0lA6EReCLBJ2RLFilfLdLylxrgETk1AF5IbIOeeN78MsMapsU
         WxfWinifhj133SMZpR1SGUU8X+SaAw/ONo+c1b+Xm4oz7lOxbmBHKxrC1gZCrM/vG+cV
         JIHg==
X-Gm-Message-State: AOAM5319cU+LBLM5TpUOBqdXgGiFf7Zf3l0tQ7S90mSfKUCFMN8/xGaJ
        +50j/xhlmWNiYb0xrLFTS6s+K9G3RtHVWlrO2PkCaTkZ4bjbnOojldaAPN/wrJxHQbyaKl8YSmR
        l1cjp8c1gGqkS2XOO2AqBqbSoHChOeJQX04H2NLeSKQ==
X-Received: by 2002:a2e:a288:: with SMTP id k8mr14085916lja.204.1640894017918;
        Thu, 30 Dec 2021 11:53:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNHCKwtJ5UoHGrJtzXyOc5ie5RkA53X5zCoUxVYllNPxSfugxzeS6pBP++ALCmFSmUMlifTA==
X-Received: by 2002:a2e:a288:: with SMTP id k8mr14085902lja.204.1640894017764;
        Thu, 30 Dec 2021 11:53:37 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v9sm2454505lja.109.2021.12.30.11.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 11:53:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [RFT][PATCH 3/3] arm64: dts: exynos: drop incorrectly placed wakeup interrupts in Exynos850
Date:   Thu, 30 Dec 2021 20:53:25 +0100
Message-Id: <20211230195325.328220-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211230195325.328220-1-krzysztof.kozlowski@canonical.com>
References: <20211230195325.328220-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin controller device node is expected to have one (optional)
interrupt.  Its pin banks capable of external interrupts, should define
interrupts for each pin, unless a muxed interrupt is used.

Exynos850 defined the second part - interrupt for each pin in wake-up
pin controller - but also added these interrupts in main device node,
which is not correct.

Fixes: e3493220fd3e ("arm64: dts: exynos: Add initial Exynos850 SoC support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/exynos/exynos850.dtsi | 40 -----------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index 2abbb972b610..4f0a40de5e67 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -344,38 +344,6 @@ cmu_hsi: clock-controller@13400000 {
 		pinctrl_alive: pinctrl@11850000 {
 			compatible = "samsung,exynos850-pinctrl";
 			reg = <0x11850000 0x1000>;
-			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos7-wakeup-eint";
@@ -385,14 +353,6 @@ wakeup-interrupt-controller {
 		pinctrl_cmgp: pinctrl@11c30000 {
 			compatible = "samsung,exynos850-pinctrl";
 			reg = <0x11c30000 0x1000>;
-			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos7-wakeup-eint";
-- 
2.32.0

