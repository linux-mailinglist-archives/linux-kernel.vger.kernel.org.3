Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12904C492E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242199AbiBYPiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242077AbiBYPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:38:06 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9707453703
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:37:32 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 738483FCAE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645803451;
        bh=UZI/W2JahxU89dnjOf2ONuJlruSbsJiXCZ4vcoyOmqk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Un9k9sGzhB+QWdFL16upqpbVq5/RYzGjprCIx05/0bAnv/qg+ZW2qAyorl/h/sRma
         pMBikbxS4TPOOO+uTRGaW7nod78c1pCuxqAX8FKHiA+pAjSRMDW9aJfNf7RtVrL1KD
         O1AruCN8iyhUqh+DQWdcwyR5dNrH4AhRBXCaNsKYZ1T0HcC2w66bs7BPS+vwP++0ga
         uuXipMD0msU+PU4g7gKimCfByjLj0wLyKsYlLuVi3QEUla87JDB2sjZVAqtRUtPj5Z
         eyu0ne2GJshLhEwBypraZrMmwRdzPPQXVn2hoG7T5aemvYbtp7oSf/8ZEzZ+/6ynl4
         vBb/Tv9308VLw==
Received: by mail-wm1-f69.google.com with SMTP id z15-20020a1c4c0f000000b00380d331325aso1469488wmf.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZI/W2JahxU89dnjOf2ONuJlruSbsJiXCZ4vcoyOmqk=;
        b=f4MhX/DqEgEh61wGMhckPRkX1HIXsKRpvH11BemtakWZd7hKjnr8ozHFCrPt3Pw2Pg
         e0q0w8wnLjxPVOVeG3ZfGW7YNwkFB1SjKI1VVcL7a67y2ObADueWB6bS7yWUfEaHzwc1
         ljI8FDVGqCCyELGDnHJ6XDYLvtNcuvJ+EgrKk+pAmZ5sXpabKSD2lNqyB88cRBvEjQEy
         uJphEqrO5YnduVB2m0dnavyHnDF7qK1JcQU4wE+eHny6EOWNf51uemZqLU7apS2l64Mh
         CYekljtJI7KPR8ft+unK73E5HnkhVhvstfhqBJTWw4ew5/p0xI52qYFPIBGbahBQwUgQ
         7W9g==
X-Gm-Message-State: AOAM530q4jgGJ4ufH6ccMYq0tgAsHfPQ4lj4FroIHkQy1h3lAG1aH1r5
        hEyd7Ft1B5pyaIFevlznseYwfpJ0mWG1qcBkCw/t8kBXPkKoWk9KNBK1hxTiQ0zwyTO575PloX8
        FAhDZ4AnD6ZMEPVK+N8eHptyaTSZX7mjbO9hnnde8wA==
X-Received: by 2002:a05:600c:4fd0:b0:37b:ddf7:aeb9 with SMTP id o16-20020a05600c4fd000b0037bddf7aeb9mr3296669wmq.190.1645803451240;
        Fri, 25 Feb 2022 07:37:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIFKEf+6La7szHsSP99MDMXNfHBPihThkLUvVYK9XyumQ4jUFIYy/zF/Tl0PvKABo2wryFaA==
X-Received: by 2002:a05:600c:4fd0:b0:37b:ddf7:aeb9 with SMTP id o16-20020a05600c4fd000b0037bddf7aeb9mr3296649wmq.190.1645803451088;
        Fri, 25 Feb 2022 07:37:31 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id p15-20020adfce0f000000b001edc0bcf875sm2647168wrn.102.2022.02.25.07.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 07:37:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: exynos: add a specific compatible to MCT
Date:   Fri, 25 Feb 2022 16:36:50 +0100
Message-Id: <20220225153650.289923-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225153650.289923-1-krzysztof.kozlowski@canonical.com>
References: <20220225153650.289923-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One compatible is used for the Multi-Core Timer on most of the Samsung
Exynos SoCs, which is correct but not specific enough.  These MCT blocks
have different number of interrupts, so add a second specific
compatible to Exynos5433 and Exynos850.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 3 ++-
 arch/arm64/boot/dts/exynos/exynos850.dtsi  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 661567d2dd7a..017ccc2f4650 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -806,7 +806,8 @@ tmu_isp: tmu@1007c000 {
 		};
 
 		timer@101c0000 {
-			compatible = "samsung,exynos4210-mct";
+			compatible = "samsung,exynos5433-mct",
+				     "samsung,exynos4210-mct";
 			reg = <0x101c0000 0x800>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index d1700e96fee2..12f7ddc6fd0a 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -181,7 +181,8 @@ chipid@10000000 {
 		};
 
 		timer@10040000 {
-			compatible = "samsung,exynos4210-mct";
+			compatible = "samsung,exynos850-mct",
+				     "samsung,exynos4210-mct";
 			reg = <0x10040000 0x800>;
 			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.32.0

