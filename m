Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DE34716A1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhLKVPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhLKVOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:50 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017E9C0698E2;
        Sat, 11 Dec 2021 13:14:48 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id bn20so18476619ljb.8;
        Sat, 11 Dec 2021 13:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8UCI8bCAcWvgd0XmjK0VX0ydFqVgFSWgTDGV3YE2DHU=;
        b=eoLPFr13zdIVg7Lve2uNUycUavo6V3af8EAMNGZq56HSc6gnM/3UiBp9GJ54CF54Up
         7LpWUO1JVsegypn5nPLqmEGDTH11wjTemmmCsUfxrNQS73O+iTUIXM3AH8yYeLLeyRfm
         fryIGdoXwDGc2ocmck96X3mVAmZltZ2eYj3jvLW7SSIq1yEdtf+JDkBUH8teABgsnC42
         FsctymUlzWGoVsB7FHpFrl8L0Rfltj4Pct+yow6vAhUOM/Hvcc5l76q30UPhesIpm2Ye
         A8B+5jCswcsrONd9La5COang4VcluJ5T4ZZzC3Ss09MTLJBuicr40pvlVFw279rAIiby
         JCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8UCI8bCAcWvgd0XmjK0VX0ydFqVgFSWgTDGV3YE2DHU=;
        b=C2PQVigt/DCpYHP7KAYG8Ll3mYGMiZc64hjVzZrDAsLsm3Hzd/JQXF4nhJapVIhMwA
         1Q8IiBtnzjRmPPQ5fBvsMil17exy6gsvKMYmZ3n2Q4lOM5SFVB14XZXlLv+GP+uLhCxt
         Q85ck/dDoxf3bnArP9gSOEh6zBIeEaUCtaVhnsyHT/NlRuLmcLYz/+o0YP6jvOjYFL4+
         7OXLd1v8iChAFep0P3LqWT+5woPLKIqeGvfAGhlzpDMUbkQxOE3tZqDFNjPXSSlR7deh
         C8UhVLReDUx0p+zK5tqXI9bCcp4j0E5wUsE6lu35ieiGWophOcMmABoTlX8DqVbcSKQO
         CvBQ==
X-Gm-Message-State: AOAM531SGvX22huqMa9f4DBgR/vFWplPHc5CwKY7IhRzqIDGMhyotQoe
        gkTL7zWMsoiJkqXY+giqO6s=
X-Google-Smtp-Source: ABdhPJxZjiCVI6kMfPRr+ybct/YopeznkQYMrlhpr5hx2u4yhmmt/I7RDNzPXE44L0hDvW0vRIQQrg==
X-Received: by 2002:a2e:9605:: with SMTP id v5mr20927508ljh.177.1639257286325;
        Sat, 11 Dec 2021 13:14:46 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:46 -0800 (PST)
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
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 24/28] ARM: tegra: Enable video decoder on Tegra114
Date:   Sun, 12 Dec 2021 00:14:08 +0300
Message-Id: <20211211211412.10791-25-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Bambura <jenneron@protonmail.com>

Add Video Decoder Engine node to Tegra114 device-tree.

Signed-off-by: Anton Bambura <jenneron@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index d487bc180f09..3d08764401ce 100644
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
-- 
2.33.1

