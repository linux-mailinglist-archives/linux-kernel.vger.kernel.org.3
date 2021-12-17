Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3673B478884
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbhLQKND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbhLQKM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:12:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F107AC061574;
        Fri, 17 Dec 2021 02:12:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93761620E5;
        Fri, 17 Dec 2021 10:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB46C36B02;
        Fri, 17 Dec 2021 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639735975;
        bh=pH4F/hKaDAo8h6YPe6yQklEHUIa1UBskbn4kAw+qsCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tXUeT8Gm2htr6bczJiWXTKy3jOVbIOrSOFrbGb1thqmqXwArWD5IogeHg3xGGCJRs
         Hv2lsxBzZFahv82wUsQsSUe9jnKWcZ/7bo/xc0T4nZLz8pIHLzWy8K9lDW6TEljNq5
         wVgIpGIh1MSFgkce8pVmDNtiJ66ugWAQgnbZm8gF0ecRAg6i6ewnNq6hYYbMOZIIG/
         jUJW6vbTTcibIPKmP2rTN2tg0GixZTeBhFH3PQmXG8ZLnGantpjHbZoDyKqVXykdOm
         qPJy9h+2evxMjqjVrsfC0u6tRKkPbhiA4d6Z/CjnIs3pQnDNuwHfOK8pnjgecetXoV
         oipw2czCh9cgA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1myAEP-000g6W-FP; Fri, 17 Dec 2021 11:12:53 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 7/7] arm64: dts: hisilicon: Add usb mux hub for hikey960
Date:   Fri, 17 Dec 2021 11:12:51 +0100
Message-Id: <dd91fa5d635f90072ffe74c6c42dfcdfc4c30495.1639735742.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639735742.git.mchehab@kernel.org>
References: <cover.1639735742.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1639735742.git.mchehab@kernel.org/

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

