Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36354716A8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhLKVQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhLKVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:15:13 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080F5C0617A2;
        Sat, 11 Dec 2021 13:14:50 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 207so18429658ljf.10;
        Sat, 11 Dec 2021 13:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qiHcMiEd6KcY2C0+ILivslEVgP5sXrzhXPuybOmc7dw=;
        b=MOoaFxMbb4EAc7zInKUn4CbujGyyMSYjwTplfSc7bfGtIL8euvXgX0ubzF8F6QQJTI
         LalMOEHxACPQCamqcg0CmgsHMhIPf1hfLbxGcabAlXRAV7Qp4wb4VFIZcqYgzZ9uMDTm
         LHcS619xUWwg7+bi93icpcc5RSahO0ZuDDGc2/ff0LZu8FoZLjqPP37FOyf4wwyf2QDc
         R0P2jt633GMj9XIn3Qt4fw2j4ldxQTZckKOfDXhmsvLaOOAgiG7G25DvCrb6bTxuusrZ
         cOc9ktKsJm0Sg7ZbujL6l0DykVQzqedzm5o/MzCeg+F0KtV9X48IfRNqqjPnq7poGMIU
         lrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qiHcMiEd6KcY2C0+ILivslEVgP5sXrzhXPuybOmc7dw=;
        b=NcLw9wxZfcecA0IeVD25qWQxTzYgFy8UnS/FCIEvtzf2HnrmWx/SgtKjk0anCaMYQc
         uTEVnP3ut2Iof+IgGE/4YDvgPMwc4kCJLKv5xIM0DGvN3qbDq18DINzyMcDwImkmQS+w
         MQSG5G6yUYKPk3iPHo4pF7YvppHzUgxbc9Ro/v4HSvlIlYVXvgOmh1B+gMY6ASAXEtMW
         qc4rJmXXLqXr76b7/dL2U10Hz3WsCviaX+q5pffBRWvsCXuuEgQuPhhxtKFTYeFXx6Lc
         vZLPFX+u1KZmz+SNndRZsjLspjzJ3EoRecUvBlbmONiC43vh5J4hg2jsNVJjYia525YE
         DHNQ==
X-Gm-Message-State: AOAM533MpoC+fGb767ZqNzy48IOugwDSSOSt0lFVvHmyzeWT3FxwM+/H
        tTMWIs96cmtpyw49jvnB5K8=
X-Google-Smtp-Source: ABdhPJwBfECAzRzARREWDabHv1SnGwl5wYB0H94hUJgwS9fCpiSfbZia17WUFujnG6/4sNcAlef5Yw==
X-Received: by 2002:a05:651c:1024:: with SMTP id w4mr19697403ljm.154.1639257288345;
        Sat, 11 Dec 2021 13:14:48 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:48 -0800 (PST)
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
Subject: [PATCH v6 26/28] ARM: tegra: Re-add gpio-ranges properties
Date:   Sun, 12 Dec 2021 00:14:10 +0300
Message-Id: <20211211211412.10791-27-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

The properties have been commented out to prevent a regression a
while ago. The first regression should be resolved by
commit 44af7927316e ("spi: Map SPI OF client IRQ at probe time").

The second regression is probably addressed by
commit 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend resume order")
and/or maybe others. Re-add the gpio-ranges properties to see whether
regressions still get reported.

This reverts commit 4f1d841475e1f6e9e32496dda11215db56f4ea73
("ARM: tegra: Comment out gpio-ranges properties").

[digetx@gmail.com: removed gpio-ranges from tegra30-ouya.dtsi]
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra114.dtsi    | 2 --
 arch/arm/boot/dts/tegra124.dtsi    | 2 --
 arch/arm/boot/dts/tegra20.dtsi     | 2 --
 arch/arm/boot/dts/tegra30-ouya.dts | 4 ----
 arch/arm/boot/dts/tegra30.dtsi     | 2 --
 5 files changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 3d08764401ce..ea5ba6e19a32 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -261,9 +261,7 @@ gpio: gpio@6000d000 {
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		/*
 		gpio-ranges = <&pinmux 0 0 246>;
-		*/
 	};
 
 	vde@6001a000 {
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 63a64171b422..fbc9bc6e5bd7 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -313,9 +313,7 @@ gpio: gpio@6000d000 {
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		/*
 		gpio-ranges = <&pinmux 0 0 251>;
-		*/
 	};
 
 	apbdma: dma@60020000 {
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 9508248fd166..f9ad0780587f 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -293,9 +293,7 @@ gpio: gpio@6000d000 {
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		/*
 		gpio-ranges = <&pinmux 0 0 224>;
-		*/
 	};
 
 	vde@6001a000 {
diff --git a/arch/arm/boot/dts/tegra30-ouya.dts b/arch/arm/boot/dts/tegra30-ouya.dts
index fd64aadc472a..e40043546a0b 100644
--- a/arch/arm/boot/dts/tegra30-ouya.dts
+++ b/arch/arm/boot/dts/tegra30-ouya.dts
@@ -68,10 +68,6 @@ hdmi@54280000 {
 		};
 	};
 
-	gpio: gpio@6000d000 {
-		gpio-ranges = <&pinmux 0 0 248>;
-	};
-
 	pinmux@70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index a6772171c910..b7a48758d930 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -441,9 +441,7 @@ gpio: gpio@6000d000 {
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		/*
 		gpio-ranges = <&pinmux 0 0 248>;
-		*/
 	};
 
 	vde@6001a000 {
-- 
2.33.1

