Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A314641B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345089AbhK3WpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344898AbhK3WmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:23 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899EC06175A;
        Tue, 30 Nov 2021 14:39:03 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z8so44105599ljz.9;
        Tue, 30 Nov 2021 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVMeO5TsjpG7X103IJ0vtCcKisfNOPmQ/M/aYmMnN4k=;
        b=lF17/Kr0r/+h+0A50HTSTvVpfiJQ4ESmynP4F9vwQ1DvJBAFg5Cxpw8DLPT743eQWW
         JFtwgBrIQ83gztDvFl+FwhmggSF1cfuhC5PYM47Fkwcji7VFPourfiok3YM86YiLZFCr
         t+92Gt5c9q8QxcWUSHvuGY/VRULh3L0YzwLtYvjniu9mJLvuA0Mh2vO7jAzIADf2DP/B
         XmgSiD9xqlBEoPC+FZb6pLAtOy6KfR1ipVc8FTuR9VOhtoVWYy8imdDfxzseGlET42Rk
         9VdQPo1fp6XVF6PKXAm6hktR1LdnMehNg3PioWb2DnhMwm1r8QVwgAWLu/XDuNM8MPZv
         lyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVMeO5TsjpG7X103IJ0vtCcKisfNOPmQ/M/aYmMnN4k=;
        b=QdTQcBy0MIK+hABDD726kx3AtBKY6UjRDhsRSs99EzH0Gn+JQcS231o1h9HPR61zQ0
         Mh6DZYoV2J24SFiXLeD62eScHpn6naLsXNZaXRGcy77M0mfUfxy6BIVlXzgukfQWXBot
         mFGqiiJxMKoUNXeFIbSe9dpEvBLVGH/vuy8ZKnwd08jBVeZHw/LJSPToq7iw6CKfuSza
         UoeU1N1E2Jvy/TVJImpzPiRXmEHR6cNtm0DM4196RtUPtJLQ5DCy9YmYiXTe0Swejhus
         fHk1L5IIh5FuJxGDpaiGIFpMcgI/fkc4Y9ksDi7bUR/ePppSD26HptXLxqVfvWa+KWng
         f6Yg==
X-Gm-Message-State: AOAM533QDQTK9PQ6GSjhknRl+kuGhb5khgSRtZJhfHK/Sj5hLXQMFz0c
        cB5xQ7Fqoev/pDgM4Ydx2SR4h5R2EoE=
X-Google-Smtp-Source: ABdhPJxNj31jwsvH1y9drCfxprWWdkoJRp6JdQcEGk9RvPwEvzk58DReJcZUT/AFxPl7tOHnmFROKg==
X-Received: by 2002:a2e:2e0b:: with SMTP id u11mr1723557lju.190.1638311941852;
        Tue, 30 Nov 2021 14:39:01 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:39:01 -0800 (PST)
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
Subject: [PATCH v4 20/24] ARM: tegra: nexus7: Drop clock-frequency from NFC node
Date:   Wed,  1 Dec 2021 01:38:16 +0300
Message-Id: <20211130223820.23609-21-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
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

