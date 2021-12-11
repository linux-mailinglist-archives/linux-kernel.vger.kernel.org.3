Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61F447168A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhLKVPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhLKVOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:39 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432EC061370;
        Sat, 11 Dec 2021 13:14:38 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id t26so24123155lfk.9;
        Sat, 11 Dec 2021 13:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDbM4I30lOOSvtqVOQfcQSvD6Q4tKt5cQZX4AWoWoK4=;
        b=EUrrHklyejk3kF460AWimFyf+FnRu1uYRB/EYWZ90nu1dRsWOnHaUH/8k/SHlv84RH
         VsDWN+T7b/7nlGme9aiWgTvbE4U2aQid+kBDk5SUDMlP3hFn7kKFQri7bCaxpZMG/RhC
         U6v7sL93nCeOTjO//HMwyw5fhoW6kIaPzrpw/89ulq8Fx4dAhK159reoAM2wSvp34id3
         xxH1TsweVNOH0yk2I/Yo3nsR3Oze0toEjzo7/PsFmakSCVoVZuy4xB0UFOmMMijP1T6s
         ekyvE42OXqbC1+xAp7xcg3U4evtUGfPVYl8/iG1ZkrcAi+M874KtmbUECeh0ZqY63Cdu
         Bz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDbM4I30lOOSvtqVOQfcQSvD6Q4tKt5cQZX4AWoWoK4=;
        b=tD8lJJxowhBQA84g1b0+Mxv6RPTmVkwvhX8ieuHWJiK+DcosRM/tiivX2uZpUtujSr
         9rBB5fOmTK0mT6iZZN7oTc9saHFgQR6qgpGoSfwxb/wChraPP8Pim7OeQRAQHT0q12F7
         23KBoOCYe3pFoxEUHVlJLRo8mTScqywzPw9aT4ppBle1NBMzHHFZ92pUpCgG1er4ah+S
         dH4zXWEC9s1lfurXhMqdxsoAi6m+ehRQlRoOhc9zinmKgT8JzT4JrEB8trqf4zqn6qVM
         9glzxIbiPUwKNzKluqfYYh2PsR+Q6ho494KNJN1eWxJWWAt+Z5upCZkDrdOlWbgkXvin
         0z0A==
X-Gm-Message-State: AOAM531rB5D7P9nz7PfOYG1tEzRvh/YtTv86w8SWLWPbbqp409tnS2hs
        WA7BvnUmcceOdWVg6dA3n7g=
X-Google-Smtp-Source: ABdhPJyPfdO6QyJ0t448rPB5HemddGerXN7ceeCqA5mGoP7M0ab+iWPFsY8f/aV8hVahkzd+h8edQg==
X-Received: by 2002:ac2:442e:: with SMTP id w14mr19707971lfl.577.1639257276910;
        Sat, 11 Dec 2021 13:14:36 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:36 -0800 (PST)
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
Subject: [PATCH v6 15/28] ARM: tegra: Add usb-role-switch property to USB OTG ports
Date:   Sun, 12 Dec 2021 00:13:59 +0300
Message-Id: <20211211211412.10791-16-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
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

