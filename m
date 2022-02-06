Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E5F4AAFC9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 15:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbiBFN7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 08:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiBFN7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 08:59:37 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FBDC0401E5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 05:59:23 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D821D40040
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644155962;
        bh=SJklMGC7T/EUcj3Xgr8zoxCnRlerqEqIREG1cOIIgnU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YW11ea5uXVN444CaJ2jZT7W4kgqT1ZRyL2/QzBK50Z2ItGNbp+ceYLP6v8vYtNBK6
         U2JdUAWg1IE3U0PzRMjfB6AMOibK7+VGFN28FFIBwGG4XvqwgkrWDxZgkHIIXSf/X+
         A5QHfOxl6UR1iRdWZqi/iKhGRmqC5s9IlN+8Z34aXqq0D7gOoMb3PrOSANnNJt5+NP
         4AbAshSsf5doUktYI6SbPEdqb77D3X9xEdFCzZJJQZnbdf0BmWtrjzTIRjKWyliGsd
         5tW9Y4mVSJytwFXjWjtjWHQ+Q9ECgjeH5W3sDx1vMmk4Uvz556riByr72IBzooj84w
         gj5tCzNuTKidA==
Received: by mail-wm1-f69.google.com with SMTP id l16-20020a7bcf10000000b0034ffdd81e7aso4240534wmg.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 05:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJklMGC7T/EUcj3Xgr8zoxCnRlerqEqIREG1cOIIgnU=;
        b=n6gPhmkq9v5W1IKjr1QHWnH0k7LY9+Mvv1krN/aCj/PXiZoedgEMS4O6nDbl7qUTpO
         hdG2IAVsDJKG43qshmfMs7CC7xx+NZcniAHzqfBquMAzKDRT2aC8akWagMpAV4U0IQQ0
         OdkKQ10nwkwQ05LsGVUht8V+SPQw+2Wmw3Q3U3+HF34CpibvMJqgWlKiW+KTLnFf8MHK
         SsTGXxXPot5/ZhGlSH8pKQMQtgxt5smz8N8TyF09/wlXzO66T7zLofjhPxSVrPdro0VF
         oskcM9oCczY8wqXW8Jbtn0/faHN3cX7tqFMBiy2k4De9dpEqMdtGAzUFQ9ULRc4hkTWc
         I4ig==
X-Gm-Message-State: AOAM532Kf/jKN/ku8WTc+Z/v6Kb3SB316+P/eAAymBzombLDwb7iqPet
        5VleVGUZgyHYWY4QefCLVNwhxGeWsdvg2AlKE0MS6Jd5M6maHFQZZuR008/VY8e21f6PVITZaF0
        dYQUxwWDFyfAyIDIpaISXiL7tbUmvT7Jz9af9Q33Ojg==
X-Received: by 2002:a05:600c:502b:: with SMTP id n43mr10478963wmr.67.1644155962524;
        Sun, 06 Feb 2022 05:59:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUW+CjZnoeRLOh3DLXJaGbc+rfq4URa9GWOKXq/P5jT8JUcEp9PlU4lZBC6zLP0TImsGzKjQ==
X-Received: by 2002:a05:600c:502b:: with SMTP id n43mr10478958wmr.67.1644155962408;
        Sun, 06 Feb 2022 05:59:22 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m14sm9018167wrp.4.2022.02.06.05.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 05:59:21 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 8/8] ARM: dts: exynos: remove deprecated unit address for LPDDR3 timings on Odroid
Date:   Sun,  6 Feb 2022 14:59:18 +0100
Message-Id: <20220206135918.211990-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
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

Passing maximum frequency of LPDDR3 memory timings as unit address was
deprecated in favor of 'max-freq' property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 2f65dcf6ba73..35818c4cd852 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -333,8 +333,6 @@ samsung_K3QF2F20DB: lpddr3 {
 		compatible	= "samsung,K3QF2F20DB", "jedec,lpddr3";
 		density		= <16384>;
 		io-width	= <32>;
-		#address-cells	= <1>;
-		#size-cells	= <0>;
 
 		tRFC-min-tck		= <17>;
 		tRRD-min-tck		= <2>;
@@ -358,10 +356,9 @@ samsung_K3QF2F20DB: lpddr3 {
 		tCKESR-min-tck		= <2>;
 		tMRD-min-tck		= <5>;
 
-		timings_samsung_K3QF2F20DB_800mhz: timings@800000000 {
+		timings_samsung_K3QF2F20DB_800mhz: timings {
 			compatible	= "jedec,lpddr3-timings";
-			/* workaround: 'reg' shows max-freq */
-			reg		= <800000000>;
+			max-freq	= <800000000>;
 			min-freq	= <100000000>;
 			tRFC		= <65000>;
 			tRRD		= <6000>;
-- 
2.32.0

