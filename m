Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1454641B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbhK3WqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344962AbhK3Wm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D3EC06175E;
        Tue, 30 Nov 2021 14:39:05 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bu18so57771278lfb.0;
        Tue, 30 Nov 2021 14:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z+2i2S1W26dZ7VgKg6S5rlGKr4ZHMsx/PFUfrnnRofM=;
        b=pkle3XH6mC7obpCfaTNgVrNrptv638F0CtUZd9TvTJk6Agsek3Ucx77eZME4wV8qHo
         5KJaJl6sg2R0WUr3CBLsnsC/IuM5C7xxWYWtGNGCyU/GZo3i53D4DW6k+MhjLC0bzItE
         63AwZlnKQTcfoXylvZTqqd4EShcQLDJYpvzD5xtzz8W9EfxB16y4hqCPChmM6T+7F5eY
         xHb+W8bwmqCDj5z6kB32tReXYUjdbkUpwHtQiZDjfNer97O29ZbqyEdNMLDf/1WdjffY
         87igfsEun+KKjegBnpDEn9cHM7uA3Yc5Uq/IaAlhsbVQKWd4s+4n/9e+fUK/QFGMajHD
         EFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+2i2S1W26dZ7VgKg6S5rlGKr4ZHMsx/PFUfrnnRofM=;
        b=YWmJa5RzTNJSy5v+cvmc11YrJbmX3IKY0Jw16UukFO/oEFmC7dJrIwbFM+dWWAqxia
         nfWfCXt9uuho5XNbo1vRuooXozZ2D9o0UgmDo0rJ3eh25l6IRSl++2gyw4YMpt5LQMsH
         /lylzJ4d4Q8go360TjD+0EIqShcTDFPsXMKe3zm5FN16bmLM7+EXVK9IGldvZoG+tMOM
         jd5PpHO71Nq/vTftFv+YwNQLYhJ+oB32vrtiZP3R8I1riNO9D/YBHOL0fg6B+kOpvCwG
         SIV/WvcE6e0RtQ73caBBXHzIOVvgopSQ/3O+uVzCF0OJERRdDfvojZO+fV4Jz6bPuISc
         Thyw==
X-Gm-Message-State: AOAM53062uSr0OC3oeR4znnozI0rePijCik4v3eizhiQV+paL2s816b3
        awO6ptLCvLAPuaDALNi70TE=
X-Google-Smtp-Source: ABdhPJxMWaqI790dLLJcz1WFAxw35mzbQssGGUzzfP3q5BdgmcPp+GhPJHiv7dMaYJ6U/rV8uRWVVw==
X-Received: by 2002:a05:6512:3502:: with SMTP id h2mr1951342lfs.551.1638311944221;
        Tue, 30 Nov 2021 14:39:04 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:39:03 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 22/24] ARM: tegra: Enable video decoder on Tegra114
Date:   Wed,  1 Dec 2021 01:38:18 +0300
Message-Id: <20211130223820.23609-23-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Bambura <jenneron@protonmail.com>

Add Video Decoder Engine node to Tegra114 device-tree.

Signed-off-by: Anton Bambura <jenneron@protonmail.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 563ee262f41d..3d08764401ce 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -17,6 +17,19 @@ memory@80000000 {
 		reg = <0x80000000 0x0>;
 	};
 
+	sram@40000000 {
+		compatible = "mmio-sram";
+		reg = <0x40000000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x40000000 0x40000>;
+
+		vde_pool: sram@400 {
+			reg = <0x400 0x3fc00>;
+			pool;
+		};
+	};
+
 	host1x@50000000 {
 		compatible = "nvidia,tegra114-host1x";
 		reg = <0x50000000 0x00028000>;
@@ -253,6 +266,30 @@ gpio: gpio@6000d000 {
 		*/
 	};
 
+	vde@6001a000 {
+		compatible = "nvidia,tegra114-vde";
+		reg = <0x6001a000 0x1000>, /* Syntax Engine */
+		      <0x6001b000 0x1000>, /* Video Bitstream Engine */
+		      <0x6001c000  0x100>, /* Macroblock Engine */
+		      <0x6001c200  0x100>, /* Post-processing Engine */
+		      <0x6001c400  0x100>, /* Motion Compensation Engine */
+		      <0x6001c600  0x100>, /* Transform Engine */
+		      <0x6001c800  0x100>, /* Pixel prediction block */
+		      <0x6001ca00  0x100>, /* Video DMA */
+		      <0x6001d800  0x400>; /* Video frame controls */
+		reg-names = "sxe", "bsev", "mbe", "ppe", "mce",
+			    "tfe", "ppb", "vdma", "frameid";
+		iram = <&vde_pool>; /* IRAM region */
+		interrupts = <GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>, /* Sync token interrupt */
+			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>, /* BSE-V interrupt */
+			     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>; /* SXE interrupt */
+		interrupt-names = "sync-token", "bsev", "sxe";
+		clocks = <&tegra_car TEGRA114_CLK_VDE>;
+		reset-names = "vde", "mc";
+		resets = <&tegra_car 61>, <&mc TEGRA114_MC_RESET_VDE>;
+		iommus = <&mc TEGRA_SWGROUP_VDE>;
+	};
+
 	apbmisc@70000800 {
 		compatible = "nvidia,tegra114-apbmisc", "nvidia,tegra20-apbmisc";
 		reg = <0x70000800 0x64>, /* Chip revision */
@@ -543,6 +580,7 @@ mc: memory-controller@70019000 {
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 
 		#iommu-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	ahub@70080000 {
-- 
2.33.1

