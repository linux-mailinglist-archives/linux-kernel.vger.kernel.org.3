Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32734C4928
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242211AbiBYPiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbiBYPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:38:06 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A446AA4E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:37:33 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BCD353FCA8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645803451;
        bh=EaZIuP8aCiZ2Pg8BQs9OaJlXxn1NfGegDq7D5c3gugE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Z8PrTmq8Z0mLz47LCZZszH/DcszCnZuhqM/ljtHlMkwL1woMsDIKj4eaZoRdXaRXx
         dqK4Zqp2PibPKCAewdThydmkgNmaYaDJXa6Zus2Hv9HEY4Z8iEcOX5hrpYy1SoFOiy
         oXfooKW0DBt8Mj6UzZjt67f403QwndxIFUZUD7NhETFjEcB6zu+95NGyu2aJzaGysA
         eYBPLibyw2mA2SSVnam/V6q+bpSI7ffy5AMU7fP1eFzlhGv0+7PLhch0Eajcvv7uiV
         G2yoYtioNkijVTFrzN2sUDlGSGA4GYrN8oGHTjGIu/iMcH26eiu6PXgyfWaVQd4IwN
         I+YVNpdAOUWZg==
Received: by mail-wm1-f70.google.com with SMTP id az39-20020a05600c602700b00380e48f5994so1499455wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EaZIuP8aCiZ2Pg8BQs9OaJlXxn1NfGegDq7D5c3gugE=;
        b=nv5BDBa7f1EpukjNv5ugwbIwo/u8zxiY+Gu7ki+Bdn07fUQ3/t0/qVajxs+ph4bSNV
         g8DAWk+ZaumCZQc2RtVoAn+YrdEPVI2Xi4re8LZnsahaAEVDWgadQq+sGsCAanzRVRk0
         OiyuntacKY+x4H/5GMWaXRQ42KSzOIGdIgoJlzCYyD3qA3Z7DVnBkE7KvxM83lk29qqZ
         Qs0agrI97Amw5GIVOYLlH4QeUpKPZ/KCxVPbwtrPpxiY+5yU5pipTSjn5JI+SWO8C4Ty
         J2XHS9kyxa4AjJrF8zpysQohcjxdISi1KYWfkStoFqiRbDewV7Uw4keY+l2SR2DIuYNS
         nNGA==
X-Gm-Message-State: AOAM530mye2oWbgUgYtXvSMYXSUmKVmnoKUuMuPfj7meKYL/r21a77fe
        Jsk5vYxQ43vYwzaXbbkjY3YRYPC1OfBp5DTNZyXbsxLBLb7VSpZWLUzePbl44cpuUqDr5S41jcn
        f2fGsoCeucqeefTQYT6B/HKNZ4p0sveh/L0ETiZBrkQ==
X-Received: by 2002:a05:600c:54a:b0:381:3b1:cea8 with SMTP id k10-20020a05600c054a00b0038103b1cea8mr3296611wmc.76.1645803449827;
        Fri, 25 Feb 2022 07:37:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzv1D4gTqAbPxLOPgjzglkuWUH3oiR1QobSGW/+QPMmmFGhvoFo79IwgTO/MqnzcQrUp1Nzww==
X-Received: by 2002:a05:600c:54a:b0:381:3b1:cea8 with SMTP id k10-20020a05600c054a00b0038103b1cea8mr3296593wmc.76.1645803449594;
        Fri, 25 Feb 2022 07:37:29 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id p15-20020adfce0f000000b001edc0bcf875sm2647168wrn.102.2022.02.25.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 07:37:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: exynos: add a specific compatible to MCT
Date:   Fri, 25 Feb 2022 16:36:49 +0100
Message-Id: <20220225153650.289923-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225153650.289923-1-krzysztof.kozlowski@canonical.com>
References: <20220225153650.289923-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One compatible is used for the Multi-Core Timer on most of the Samsung
Exynos SoCs, which is correct but not specific enough.  These MCT blocks
have different number of interrupts, so add a second specific
compatible to Exynos3250 and all Exynos5 SoCs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 3 ++-
 arch/arm/boot/dts/exynos5250.dtsi | 3 ++-
 arch/arm/boot/dts/exynos5260.dtsi | 3 ++-
 arch/arm/boot/dts/exynos54xx.dtsi | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index ae644315855d..41bb421e67c2 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -269,7 +269,8 @@ gic: interrupt-controller@10481000 {
 		};
 
 		timer@10050000 {
-			compatible = "samsung,exynos4210-mct";
+			compatible = "samsung,exynos3250-mct",
+				     "samsung,exynos4210-mct";
 			reg = <0x10050000 0x800>;
 			interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 5baaa7eb71a4..63d1dcf2c55c 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -245,7 +245,8 @@ clock_audss: audss-clock-controller@3810000 {
 		};
 
 		timer@101c0000 {
-			compatible = "samsung,exynos4210-mct";
+			compatible = "samsung,exynos5250-mct",
+				     "samsung,exynos4210-mct";
 			reg = <0x101C0000 0x800>;
 			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
 			clock-names = "fin_pll", "mct";
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 56271e7c4587..ff1ee409eff3 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -333,7 +333,8 @@ chipid: chipid@10000000 {
 		};
 
 		mct: timer@100b0000 {
-			compatible = "samsung,exynos4210-mct";
+			compatible = "samsung,exynos5260-mct",
+				     "samsung,exynos4210-mct";
 			reg = <0x100B0000 0x1000>;
 			clocks = <&fin_pll>, <&clock_peri PERI_CLK_MCT>;
 			clock-names = "fin_pll", "mct";
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 2ddb7a5f12b3..3ec43761d8b9 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -74,7 +74,8 @@ smp-sram@53000 {
 		};
 
 		mct: timer@101c0000 {
-			compatible = "samsung,exynos4210-mct";
+			compatible = "samsung,exynos5420-mct",
+				     "samsung,exynos4210-mct";
 			reg = <0x101c0000 0xb00>;
 			interrupts-extended = <&combiner 23 3>,
 					      <&combiner 23 4>,
-- 
2.32.0

