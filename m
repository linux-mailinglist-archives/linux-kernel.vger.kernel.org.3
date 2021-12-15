Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB5A4754A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbhLOIyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:54:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52516 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240940AbhLOIyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:54:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE9B561828;
        Wed, 15 Dec 2021 08:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2584AC34608;
        Wed, 15 Dec 2021 08:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639558480;
        bh=IFbvMKX9vDDaZfjF7MZhS2oxD39IrLI4w6N9RufcTnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=faGl3hN/GHf7hFfIPWloc7b1EvnDd67wGABYhBhk2kVXr/I0wF006dYHbgEfYLevL
         9p/txzAvPakTyz24VZl63fVvbnyXlVPig25v8l3O4P/eaIpiNxwY4FVbdpFi26JpN6
         iWBFyUQ4wiy2lOZZYqHt2nxgBKSCLGamxVUquLYNAn9kQNFHflmloWrdDnlCcHpkLO
         4A6JgmCYYj9dQl1i4nDpE0hBM6C8O/oIfjaRw9+Btvt5BXBpw2ZEmKAH4rSXArYJ6u
         1ZOlRDGLj+5q49w5LEP28LCNXd7hpeFt6SUj4sribtMuTuMkwWipHUInpoW30R88F6
         EEtIndU5nnb9Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mxQ3Z-0054II-R5; Wed, 15 Dec 2021 09:54:37 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH RESEND 7/7] arm64: dts: hisilicon: Add usb mux hub for hikey960
Date:   Wed, 15 Dec 2021 09:54:33 +0100
Message-Id: <87d615caf69301f86b6305924fb702c497715a0c.1639558366.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639558366.git.mchehab+huawei@kernel.org>
References: <cover.1639558366.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <john.stultz@linaro.org>

Add dt bindings for Kirin 960 USB HUB. Such board comes with an
integrated USB HUB provided via a Microchip USB5734 4-port high-speed
hub controller.

[mchehab: modified it to adapt to the merged DT schema]
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RESEND 0/7] at: https://lore.kernel.org/all/cover.1639558366.git.mchehab+huawei@kernel.org/

 .../boot/dts/hisilicon/hi3660-hikey960.dts    | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index f68580dc87d8..135501e57f86 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -197,6 +197,37 @@ optee {
 			method = "smc";
 		};
 	};
+
+	usb_hub_vdd: usb_hub_vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "hub-vdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 6 0>;
+		enable-active-high;
+	};
+
+	usb-hub {
+		compatible = "hisilicon,usbhub";
+		typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
+		otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
+		hub-vdd-supply = <&usb_hub_vdd>;
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
@@ -564,7 +595,7 @@ port {
 
 			rt1711h_ep: endpoint@0 {
 				reg = <0>;
-				remote-endpoint = <&dwc3_role_switch>;
+				remote-endpoint = <&hikey_usb_ep1>;
 			};
 		};
 	};
@@ -686,7 +717,7 @@ port {
 		#size-cells = <0>;
 		dwc3_role_switch: endpoint@0 {
 			reg = <0>;
-			remote-endpoint = <&rt1711h_ep>;
+			remote-endpoint = <&hikey_usb_ep0>;
 		};
 
 		dwc3_ss: endpoint@1 {
-- 
2.33.1

