Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A0646DA1D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbhLHRma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238365AbhLHRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:56 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C97C061A32;
        Wed,  8 Dec 2021 09:38:23 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bu18so7185268lfb.0;
        Wed, 08 Dec 2021 09:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z+2i2S1W26dZ7VgKg6S5rlGKr4ZHMsx/PFUfrnnRofM=;
        b=Yn9bRJ3BRnXDuMR1X8U/oKzRmdz17/4tMoHxP5Wa02BKy81sZMT31bJo8ehx3eZUgX
         yJNOu4xAyJyKlxXAVUHED/2rWSEwm0ydfv8zC6P4P0y9JNBCzqvmPmtnMf8dp91xZ4jZ
         kNmtlN47SMWvn9NA2R5I96flsQt8QnwUDSbccohfCcM8ydCCw2481MrghaE4G5iNKNrn
         Mn8CtroHm9r5GY/EE4YyJLS23t3frzHEohFpKKwzFstAcsOE44cWZTiFmWE71AKgZO1n
         hozoohYQhDO8Zoffqq5szZoKkSBA3f+qFhCwhARgY73NLJOEvhpwdak6aWb9r7q+K6Fq
         YiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+2i2S1W26dZ7VgKg6S5rlGKr4ZHMsx/PFUfrnnRofM=;
        b=4Od6PPqAae1+E+3J6tgPdz60F/98IK/XfAKE7scSA22xfvpAwbczdOYUPxykyBuUOd
         Zi+2pQbWWqWv2/AA4FdJJTkOTCoWy6YLL696wYhG4jLzIyaeGr9JrTeQ6ylZGwaLKxiW
         G980sL7Poc5CQajLhfh+q/MhS/nCk7rKg3kAw0r391xTfsGwKjcTx9eyEVBTZLU7pB9p
         90YS8U8aMqm8G6in7dEHcU2US2nUCvBPxYYiGMlAqmTZHDw53UpxPWY8/dUn2A+KzSEF
         HiJUy3ojBGDUkk4oUtmhsqUuIG8q2olyoXTgZ1yWVtH96m80gPrw9fcpUto2ZPpFJ5J2
         Q6DA==
X-Gm-Message-State: AOAM531uwsn842T5bDYSAjiI8/WHnECPDmVEMrZ3bQkXVRybATiNvSiy
        B83pDnhje7SgugtdP97lvffdpivE4MQ=
X-Google-Smtp-Source: ABdhPJwZ52+o0LKXPN/fEaighrw/2vOUPzMAGtr/maiFBDuHttsmJn0hzLQAaKNtB+pjLJHvzAIBuQ==
X-Received: by 2002:a05:6512:1094:: with SMTP id j20mr784503lfg.237.1638985102283;
        Wed, 08 Dec 2021 09:38:22 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:38:21 -0800 (PST)
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
Subject: [PATCH v5 22/24] ARM: tegra: Enable video decoder on Tegra114
Date:   Wed,  8 Dec 2021 20:36:07 +0300
Message-Id: <20211208173609.4064-23-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
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

