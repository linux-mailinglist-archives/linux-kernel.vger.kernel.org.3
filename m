Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420284A3138
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352973AbiA2R4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:56:07 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36340
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229895AbiA2R4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:56:02 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC9F93F1D8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 17:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643478961;
        bh=PmlUH1NKT1IBe/kDwTpAruCqxv8iCTSRTkhnLBQvKAs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=cG8r3M3wQT8yFNiibegrAP808bFWFsp3m201pGJ90ZZyP676L/KpDQ5BnDWh6lzbP
         EHIpTetVxUU4HDXhRhxlXdooH1P6utDA/WLAf08Oj1b46YOOmfLxQlzr2jluEa/xqk
         8PKt2hFWLNFYR0mKXc1KSsetKS5X9kJE8nXdUUqcyQSoFzFLRfwPoqcixWcpetKbVK
         r35wmxsZv+NW0RXQQvzlPq5pEDb8DNTJuuV6p6Low9tHnX4ITop7Par/QQEfCDoFdR
         E5jiuU/pTQEGP4zS5G+06bIOsWcCx5JyX5rTcj7mEYPxw1hM+CJXXMgAAngY6+Jo8S
         4iBSXw8Uz+KGg==
Received: by mail-ed1-f70.google.com with SMTP id p17-20020aa7c891000000b004052d1936a5so4698423eds.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 09:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PmlUH1NKT1IBe/kDwTpAruCqxv8iCTSRTkhnLBQvKAs=;
        b=7QudXk+9NZ08257dn2L+fFZaPqh8ODoNYl4kKRNXnTT63RcfYYddjXZQvabID5HqWM
         YZ1+RykLF33E887pLKMOkM6nLZAQd8CfEHuO07Fd91HwN6Ue49Z7Ni11dC/k1LBYIu5d
         2kPfkAdwEwH2/oQwGA4lfj+8qqTEwmeW26K9FpDRmVN0kG3t5RtoKqf4jknDXHzzrodd
         1Z+U5WQhKEp32Wom6nRUbq6TqaupEYCS7/TRJNV62H7zdomt+njG0efpeqg4yMidWu+A
         wqIokr5Y3qSE5gPheBKuzTkA4yY/lgV6rz7Qvz4GPlFYHtv2A9lTfxx1tHoB7Uz+vo1x
         sRBg==
X-Gm-Message-State: AOAM533wHJlUFnGP+HkDBVJ+5M5QXfvtjWQdxbvgC1eGZ2QbMIdqvkjN
        rCBQCYHdfVL9pD+lU0qsfOu4tPBobO5vrxq72UiG0bzHY7kVbEQlfSt2GOf7XrzJ6zN10yZHkP7
        rVAKOxyI6uTyRRWeV/tYHGZAOwG7C34wH4GFn/m2OrA==
X-Received: by 2002:a17:906:c28d:: with SMTP id r13mr11287217ejz.389.1643478960070;
        Sat, 29 Jan 2022 09:56:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXVQA+kGTTTX00K/ZlYb2OdeOwGhxIQR91k0MV8Wgbq/YDvbHke+YcIJWW0AvdFX7HYlL78g==
X-Received: by 2002:a17:906:c28d:: with SMTP id r13mr11287205ejz.389.1643478959935;
        Sat, 29 Jan 2022 09:55:59 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s26sm15085895eds.39.2022.01.29.09.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:55:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] arm64: dts: broadcom: align pl330 node name with dtschema
Date:   Sat, 29 Jan 2022 18:55:57 +0100
Message-Id: <20220129175557.299166-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes dtbs_check warnings like:

  dma@310000: $nodename:0: 'dma@310000' does not match '^dma-controller(@.*)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 2 +-
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 2cfeaf3b0a87..6da38ac317f2 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -276,7 +276,7 @@ crypto3: crypto@61330000 {
 			mboxes = <&pdc3 0>;
 		};
 
-		dma0: dma@61360000 {
+		dma0: dma-controller@61360000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x61360000 0x1000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 7b04dfe67bef..4135246b6e72 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -543,7 +543,7 @@ hwrng: hwrng@220000 {
 			reg = <0x00220000 0x28>;
 		};
 
-		dma0: dma@310000 {
+		dma0: dma-controller@310000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x00310000 0x1000>;
 			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.32.0

