Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155664754A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbhLOIym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:54:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52514 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbhLOIyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:54:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C527061859;
        Wed, 15 Dec 2021 08:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA54C34606;
        Wed, 15 Dec 2021 08:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639558480;
        bh=bPwyIX0t/F7TcAWDAFt7NPQXqT9UtG8bvIM4c8B3Qh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UBtXEiHxgQwGPUePcPODVvLEWjJxuvHNXDUG24u/iIVUn/WXh5ttWN50rWPXsuHEH
         mwh55Buyl9rjz5U48W13vVDd5f7q1DnhQWAprQcD9kb9Qx263Fl4cLeSsbz/qCCsZ2
         uUPtxzLuI9+UJOLPUy1rcycjKZ5564wsCxwiFQf7snu/HswVOIShrt6sTIDZkcvb9R
         JYU0dmZI/O45Q14s3M4Pkeg22/yIAyVNfvTkaEiovvlDJ9trU1Poz2AqbbvX6yLjo8
         ReAXiam2dzZaCcjE6PcDlNWQb6eyPYgC282A+3ECkHdmfYQE9RviX2lv1goo668LxJ
         7RjEzelZ/besg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mxQ3Z-0054IE-Q6; Wed, 15 Dec 2021 09:54:37 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 6/7] arm64: dts: hisilicon: Add usb mux hub for hikey970
Date:   Wed, 15 Dec 2021 09:54:32 +0100
Message-Id: <d0bc2f01be73c89c9768e5d881e6043539ae5b1d.1639558366.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639558366.git.mchehab+huawei@kernel.org>
References: <cover.1639558366.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings for Kirin 970 USB HUB. Such board comes with an
integrated USB HUB provided via a TI TUSB8041 4-port USB 3.0 hub.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RESEND 0/7] at: https://lore.kernel.org/all/cover.1639558366.git.mchehab+huawei@kernel.org/

 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 60594db07041..95ca49f1e455 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -53,6 +53,29 @@ wlan_en: wlan-en-1-8v {
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	usb-hub {
+		compatible = "hisilicon,usbhub";
+		typec-vbus-gpios = <&gpio26 1 0>;
+		otg-switch-gpios = <&gpio4 2 0>;
+		hub-reset-en-gpios = <&gpio0 3 0>;
+		hub-vdd-supply = <&ldo17>;
+		usb-role-switch;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hikey_usb_ep0: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dwc3_role_switch>;
+			};
+			hikey_usb_ep1: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&rt1711h_ep>;
+			};
+		};
+	};
 };
 
 /*
-- 
2.33.1

