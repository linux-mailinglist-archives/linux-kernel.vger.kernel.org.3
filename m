Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B284641A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344841AbhK3Wod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344831AbhK3WmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:20 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC5C0613E0;
        Tue, 30 Nov 2021 14:38:57 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e11so43999513ljo.13;
        Tue, 30 Nov 2021 14:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDbM4I30lOOSvtqVOQfcQSvD6Q4tKt5cQZX4AWoWoK4=;
        b=kaI7cJpNQb12z3NJIm0y6/NBlud8XnsXD2xt2hQBm6fGFIIaBno3ZYodiZRi3GAGui
         nQjT/Bidmt4xOSdb14NbvxuwVYMdeX6wJ1MxNpwLBkg8x+TPtW1605A1aZAjfBxF2IUP
         EyQpOZ3+86OIzyYW7RCQVVOgz2d0RgtNi8cKLnTCuKmbRfdXkG4+dJ0FyzjPIh/KpNmI
         qNTms7tunM9T49lz2uBLqGqRAf1s+olq+hIwMMenEyOmdtBr6u1pgRxbFs6TQH7ZfUN9
         cwjB+zGYYNNxTAflU7RkaZFsCVbaW8y7v7xckC3mvlm6ZkzIXnrhyz0fm/lBG5ZONcwl
         GQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDbM4I30lOOSvtqVOQfcQSvD6Q4tKt5cQZX4AWoWoK4=;
        b=VJjJxGJYnIn9HOHSH1mbOEW2eH5vwEnf+Vrr29WLMj3Vw169wOu6GoBf0hnURkEHwy
         Bx8n8bEC2F0rcnXxvo68lS41/qVk3+722c9PLCrLjbb2RNbdy9PlCWvePd8yzDbvqUMr
         Z3fVMy3j+LbeAhpv6BZl0ASEUUA2OfJPI+rvVzKUfFR6CAZfgTudYEochOnTdH4BHpE5
         ACFI4zdHACmxFXQHZHIKrn0UsQjyMxY87KNvgOFli8FOvs6BlRXBys9MYQJj+FbUyphn
         IRNNEO8Re6pTAbgmXO4ZYskg8ir/biydbueiq/v0T/XzyRozv0TCa8lW8UBYhCEtgjsV
         ZCUw==
X-Gm-Message-State: AOAM5324q0ahzqOB1eCCFx80prWPkuwEcJxSXQcIgx98XSTWpogA9/xE
        P3Js9VadE6RHE75V2o96BQs=
X-Google-Smtp-Source: ABdhPJweKgijr3RIeNHcsE0lPaCJusw/t24PV5Xt1PvyKy/wJjplt/2ONcfD+U3gDfZXwZiN+U+okA==
X-Received: by 2002:a05:651c:a12:: with SMTP id k18mr1772113ljq.251.1638311935610;
        Tue, 30 Nov 2021 14:38:55 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:38:55 -0800 (PST)
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
Subject: [PATCH v4 15/24] ARM: tegra: Add usb-role-switch property to USB OTG ports
Date:   Wed,  1 Dec 2021 01:38:11 +0300
Message-Id: <20211130223820.23609-16-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

If an USB port is an OTG port, then we should add the usb-role-switch
property. Otherwise XUSB setup fails and therefore padctl is unable to
set up the ports. This leads to broken USB and PCIe ports. Add the
usb-role-switch properties to Tegra124 device-trees to fix the problem.

The error message shown without this patch is e.g:
usb2-0: usb-role-switch not found for otg mode

[digetx@gmail.com: improved commit message]
Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 1 +
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 1 +
 arch/arm/boot/dts/tegra124-nyan.dtsi        | 1 +
 arch/arm/boot/dts/tegra124-venice2.dts      | 2 +-
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index cde9ae8fa04b..b9198f842a34 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1885,6 +1885,7 @@ ports {
 			usb2-0 {
 				status = "okay";
 				mode = "otg";
+				usb-role-switch;
 				vbus-supply = <&reg_usbo1_vbus>;
 			};
 
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index a46d9ba9bb7a..1a996fb78ee2 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1877,6 +1877,7 @@ ports {
 			usb2-0 {
 				status = "okay";
 				mode = "otg";
+				usb-role-switch;
 				vbus-supply = <&reg_usbo1_vbus>;
 			};
 
diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 63a81270300a..93a40a84b792 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -466,6 +466,7 @@ usb2-0 {
 				vbus-supply = <&vdd_usb1_vbus>;
 				status = "okay";
 				mode = "otg";
+				usb-role-switch;
 			};
 
 			usb2-1 {
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index e6b54ac1ebd1..de8c18e6b7e6 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -972,7 +972,7 @@ ports {
 			usb2-0 {
 				status = "okay";
 				mode = "otg";
-
+				usb-role-switch;
 				vbus-supply = <&vdd_usb1_vbus>;
 			};
 
-- 
2.33.1

