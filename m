Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27407477129
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhLPL4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:56:06 -0500
Received: from cpanel.siel.si ([46.19.9.99]:36700 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234035AbhLPL4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=i7eUB0ds7jiwgCN/gUMjriygElaCnqVWchmx8PAy+tA=; b=JLlEqAKjXxtyOEvXYe0hwTgpgh
        w3k2pT2tPtlCNmAfIT2hgNKBsOrBQDMq6QeaPzDN+u3GDRBZk1UNin/FQFET6OwO84gnA7IZgCeEU
        oWVX+xWxZxhFfP2CHsXOyUB76yvkQ9QwlZuIqn9xbXu27LPwTwPgUGWWLmXTfMvbPZdtYkBVqvcno
        Tbt/LuJY9X4LofIUaxRUkbkOksb/j38/9lmz9uKmtjqfJv4TD2VJ0uzQb0Y8lhlBUzTMATGsUrR46
        zd4uWBJI5gsnIelzK6hD/Dhlhz7otiA+cMqcijHWS3mzfbazs26BWJpckFr+7abDWimB3tBImlG8u
        PKfWf/nw==;
Received: from [89.212.21.243] (port=49574 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mxpMc-00HBtw-6s; Thu, 16 Dec 2021 12:55:58 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org
Cc:     festevam@gmail.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, y.bas@phytec.com
Subject: [PATCH RESEND 2/2] ARM: dts: imx6qdl: Handle unneeded MFD-subdevices correctly
Date:   Thu, 16 Dec 2021 12:55:29 +0100
Message-Id: <20211216115529.2331475-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216115529.2331475-1-andrej.picej@norik.com>
References: <20211216115529.2331475-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunus Bas <y.bas@phytec.de>

The proper way to handle partly used MFD devices are to describe all MFD
subdevices in the devicetree and disable the not used ones. This
suppresses any warnings that may arise as a result.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi      |  5 +++++
 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 2ec154756bbc..3590f439adf5 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -213,6 +213,11 @@ pmic_rtc: rtc {
 		da9063_wdog: wdt {
 			compatible = "dlg,da9063-watchdog";
 		};
+
+		onkey {
+			compatible = "dlg,da9063-onkey";
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
index 94b254bfd054..28a805384668 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
@@ -116,6 +116,16 @@ watchdog {
 			dlg,use-sw-pm;
 		};
 
+		thermal {
+			compatible = "dlg,da9062-thermal";
+			status = "disabled";
+		};
+
+		gpio {
+			compatible = "dlg,da9062-gpio";
+			status = "disabled";
+		};
+
 		regulators {
 			vdd_arm: buck1 {
 				regulator-name = "vdd_arm";
-- 
2.25.1

