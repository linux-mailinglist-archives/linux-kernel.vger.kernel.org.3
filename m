Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB06946DA18
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbhLHRmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbhLHRls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:48 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F35FC061D60;
        Wed,  8 Dec 2021 09:38:16 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id m12so5020480ljj.6;
        Wed, 08 Dec 2021 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDbM4I30lOOSvtqVOQfcQSvD6Q4tKt5cQZX4AWoWoK4=;
        b=O68U2kXk/w/fAjDqquMhlRRJT5Xf+hw8DWjiw1FuaCxeAQRUl2ofkRKZQwukFZlP4J
         7swSJVe6W6bzEJxVm8PxfwLuJ3YbCc0TQfKZoyS89BLN7s09HSU1+D2NSYk6s2zi0Njl
         2tlo19Y/OzU0CQ+tDNFgx313bFcfvoKYKF55CwnkjDo4hQgHCxd9OczIFAJZU9FICVAQ
         caPWv/+j9cPbM+iWuGeMIBisfPmba3O6T53DjEZ2kQWFNFIgm7RyeZd232H3N3TDloNX
         uxyaSLxzi9eMalX9tzolQHSKOBdveXo5VO5O1kGzcoKiDrp1Wi6wDLoAyLO8pqTypdbp
         NgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDbM4I30lOOSvtqVOQfcQSvD6Q4tKt5cQZX4AWoWoK4=;
        b=ur9dxMUFqDlhTdxBqcXzGsEdvnC7ruun3kDfrKsyg/nY0E6p7Yd2yWZlCB2l/yuizG
         dJqTjLSKFFNe4TUKRrDf0jQwZcAICHVS0Yb8fB/CcpVLG/Tul6DBdUxcNMwcQtaMoPts
         Y6BcInV1GTCD3gIe8sooF8OnTJu/kN5xVgpEDdIGaV2tuo6bTWns8bJabmFCuwT27SIY
         DYwdTu/qKaB3xES7L5OzkBJFSNIsE+dxKKt53AUyPDLobJ7twgLGa55CwxPb5OFUSiTs
         4lfa9rYxksy8261g4FEVMZnyunsjxt+tXhbjlUlMgeolTgvMkrc8O6lv/USpD59v3TzB
         I6RA==
X-Gm-Message-State: AOAM533YiV1142V9zkAoUYnvT8b73DF2gvqetOjGhmEXYO25tTIzoz25
        Jz2G979W9C28kjRAZfB+FfY=
X-Google-Smtp-Source: ABdhPJwbNmf+ZOoNv2tIPqMGo5gFw5WybZOnLdA7epavQvbBjoWLlFGsX+XzEeWMngbqTHRs2BUOaA==
X-Received: by 2002:a05:651c:1543:: with SMTP id y3mr867638ljp.436.1638985094711;
        Wed, 08 Dec 2021 09:38:14 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:38:14 -0800 (PST)
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
Subject: [PATCH v5 15/24] ARM: tegra: Add usb-role-switch property to USB OTG ports
Date:   Wed,  8 Dec 2021 20:36:00 +0300
Message-Id: <20211208173609.4064-16-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
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

