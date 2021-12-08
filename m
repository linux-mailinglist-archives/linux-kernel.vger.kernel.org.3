Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89046DA19
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbhLHRmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbhLHRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:56 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5795BC0698D7;
        Wed,  8 Dec 2021 09:38:21 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b40so6988178lfv.10;
        Wed, 08 Dec 2021 09:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVMeO5TsjpG7X103IJ0vtCcKisfNOPmQ/M/aYmMnN4k=;
        b=h4YHUaUH+61gQIqQv+0xllt+xb40H0potONRxgOSvGhH/L6e66yBCmcJeHmyjOpY4z
         kiPKhzQwfWHE1cOqAZy6LYdM6Kmqe4WFV4jy0WJe0fwjnTmErLv613DSQAXeUpeciHhF
         mKvVSFsRZGUcwPhpmbiQsm2gPTHuvi9uMA4DlhN7BQbyxOtDMbzNs+N9ZoLFJTdXsxPg
         NI/z5aLWbq2xUat0GVZ2VXW1BfLGIE3JLYPGJIN3aMvCLJbQhlqAkWthB/u5xUNn0S1T
         gGY/D2B2BRK0vZb2DleqiEa+FEvkdGegLPlHc/HrooY+onVW8CI9uFMLfPruFXpgNTAw
         jvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVMeO5TsjpG7X103IJ0vtCcKisfNOPmQ/M/aYmMnN4k=;
        b=oRLREwzzA8e9AKVOzPw3RXFd40Hpbym+cX5ypGEimZUplz7yilGs3W5V/nYLyqjcsr
         QC5M3LZbLx/Ph/ApRI/1Pekt25+1CRPf7XBkN7DbK43gB40iwwFp6hz1ntbb1oASXyA2
         YFA0PaQhEEafjIBrld0co0kuQSZ/fB1ihytginJh1+xkxS8hWpuWAdFjqplxJ4RME5nx
         JfL0m+jh8GKfa9PZKNNQgpc+SFYbDLS4uKqcIK3FW/m//XeVn2VewuLyxRMBaA7/Tqka
         X+z2arzpV5MpVI8EeBOw/QIJs1c8lO6TTd9dyraFasfD1KrBhM/JoxLza/rpA2SxO5L/
         b2ZA==
X-Gm-Message-State: AOAM532kXhtVlE9Ix+9JLJP3QweoCLfLEEmdAiyiGouBkr2BUTn4JhHd
        IA7lSfOyPHYiJ4h2sC2p8ek=
X-Google-Smtp-Source: ABdhPJzCdM7qRpQ5Z2Usl9cPWNrsepSRlq7XaNSglr4pbqRckUPRnc0dxYoG9vVfzkhk/vT1eKP63w==
X-Received: by 2002:a05:6512:130d:: with SMTP id x13mr815806lfu.466.1638985099699;
        Wed, 08 Dec 2021 09:38:19 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:38:19 -0800 (PST)
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
Subject: [PATCH v5 20/24] ARM: tegra: nexus7: Drop clock-frequency from NFC node
Date:   Wed,  8 Dec 2021 20:36:05 +0300
Message-Id: <20211208173609.4064-21-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

The clock-frequency property was never used and is deprecated now.
Remove it from Nexus 7 device-tree.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dtsi | 1 -
 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dtsi
index a044dbd200a9..564cfcde21a9 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dtsi
@@ -137,7 +137,6 @@ i2c@7000c500 {
 		nfc@28 {
 			compatible = "nxp,pn544-i2c";
 			reg = <0x28>;
-			clock-frequency = <100000>;
 
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(X, 0) IRQ_TYPE_EDGE_RISING>;
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi
index a681ad51fddd..cd63e0ef7445 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi
@@ -223,8 +223,6 @@ nfc@2a {
 			compatible = "nxp,pn544-i2c";
 			reg = <0x2a>;
 
-			clock-frequency = <100000>;
-
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(S, 7) IRQ_TYPE_EDGE_RISING>;
 
-- 
2.33.1

