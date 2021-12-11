Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2964716A4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhLKVQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhLKVOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:49 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6E6C0698D6;
        Sat, 11 Dec 2021 13:14:44 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id c32so24183101lfv.4;
        Sat, 11 Dec 2021 13:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QN5NXzY3UJqYsoiyi8rxS/3fNhzWfPS1PE0Io3vGCHQ=;
        b=kyYzvolMf3rLJnDG4KVocZS2co2Gmj5kbWPzBzNGBktU8m7sd0Zwti9mcUH7wwamP+
         JAyVoqSQDAnXw2csmDQTuVWNRmO6qULA1/ElH6Dbz2GobDytGvTeZ4rJ7FAcA0Oq0bKS
         TEGoR2XoPmnSKF0GcNcdKSewwtizYqwcTFvTfDEhHr/G9I3rIMsy4HQ81hEBssUTb3ci
         cMXqJoCeJTqzLUxeJN3+L8xBt5/Jnqtf+ATanU7/Tj2dQGZYvu5t5wh51yR8MYwJadhk
         Z1iT+Bi7C36lAHWEYLPx2mb+z2kg/2bXJw/V2za3MtFt2qzEXRpZwYCOLuSrlgiTw8gx
         2leQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QN5NXzY3UJqYsoiyi8rxS/3fNhzWfPS1PE0Io3vGCHQ=;
        b=C/vcGaRFD1zSj9plhHTJPzjrmHmBXE8u1yjGSBUBUhc2wAze1Ep+9VqTC97+Ds4ezc
         u95PkFzLkZN4kNiAGdBAy5bFGTKzY8QZxbv4yzggjLCVvDW1DkbRLzQlzetn653HKvP1
         95oYddTE89EKRIEfQnpkaTRBud6qjWk452buwnTdPPjWnEidnz78grqMlrWY3VBMNBXe
         w+fwUcNh6DmeaSpfg/Na9/8kdjeq0bkt9+mCLDXWGh9wxkSje0zi++S8FEeJ8EQScEni
         Ga8l4n0Q1GfrOV+BxuGj1yDuCLlKruZFhvoF8hXhPgAKssCjIX8NszeHf2UvXsSdj4n5
         SoJA==
X-Gm-Message-State: AOAM532H4MOCQD1KF4/s6g2icuuArTsclOrMiMG42Cv+Ag5smTL5Imsd
        8H8mTKTEaFZJc621+daWCgxQ3w3Setk=
X-Google-Smtp-Source: ABdhPJyVxk75chKkmywaxK6tSJO4Ya4jHrzs25LZVGhx5JDgSSPzj4W25c34CGToE8rHCnznzdLOxQ==
X-Received: by 2002:ac2:53ae:: with SMTP id j14mr18995795lfh.323.1639257283264;
        Sat, 11 Dec 2021 13:14:43 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:42 -0800 (PST)
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
Subject: [PATCH v6 21/28] ARM: tegra: nexus7: Drop clock-frequency from NFC node
Date:   Sun, 12 Dec 2021 00:14:05 +0300
Message-Id: <20211211211412.10791-22-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

The clock-frequency property was never used and is deprecated now.
Remove it from Nexus 7 device-tree.

Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
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

