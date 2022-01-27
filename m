Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D9449EE9D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344641AbiA0XJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344513AbiA0XIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:08:48 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A49C06175C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:48 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n32so4343960pfv.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H3WPdl8RHDSD1wX3WYrqIIpaKS0otWy1CXBFRdtFIp0=;
        b=MI68bzzOlftwsLGrBYAOzyCTdVT7/DjY0G28T/dktb1p+eyNQg3lJ38XqA+02nrBSc
         MlpQ+bwattyukKMVxifDcCRAefoXuFGzT6ODOCQjr3VmwTb1WTYp7pMoDJmFVXvaU0gx
         GIYMCkunM9HKsSMPediCjBTpAmV/CiExCjGxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3WPdl8RHDSD1wX3WYrqIIpaKS0otWy1CXBFRdtFIp0=;
        b=enXPd6OSTXQtvMBxiQgLE0w1zgi4LLI9SLQU+X8rJKMrdi0r9ys0sA1OhEcJ6X41+B
         MzweUj+vODc4+DUaTwELuiB+kf0qBo+2eOLrdUJ6DZsmnKynR3CDW55dRxDyz8kPz4xO
         sVOIkw9R2RwnxYy2C4UW024viikv9zSQblrnPZ/KRwBlIaSWIDB9r7GUETV2LnEHFdcq
         WBSbp15SZ2TgH2Q1SFatGOqwAGB02Eop2A2H1wVZL+6+kVFD9gIZ4b2++1AfwtZ9dzhL
         a9/oQ1U/2N9EX6m7u2KHSpsuZwnPTPrnrcyFyMkSoCbRW/vCBsdxIP8abiGNfWht/bNA
         /8qA==
X-Gm-Message-State: AOAM532kGUE+zTDCaJktViw1U9ZNRgQlLawl1Subg0waiV6Eow2kEPT2
        KUk5bTMJ/S2fGwjOjOK9dr2ksQ==
X-Google-Smtp-Source: ABdhPJxHGKBFiprBfzF/G3/1M/XaUir6+M8cdNjBdHlepR+kl6Wvt2iHAswSxIZ9FoocWQX1BCjKkw==
X-Received: by 2002:a63:245:: with SMTP id 66mr2604212pgc.349.1643324927837;
        Thu, 27 Jan 2022 15:08:47 -0800 (PST)
Received: from localhost ([2620:15c:202:201:723d:38a9:9e7f:3435])
        by smtp.gmail.com with UTF8SMTPSA id z124sm6396253pfb.166.2022.01.27.15.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:08:47 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 12/15] arm64: dts: rockchip: Enable dmc and dfi nodes on gru
Date:   Thu, 27 Jan 2022 15:07:23 -0800
Message-Id: <20220127150615.v2.12.I3a5c7f21ecd8221b42c2dbcd618386bce7b3e9a6@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127230727.3369358-1-briannorris@chromium.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

Enable the DMC (Dynamic Memory Controller) and the DFI (DDR PHY
Interface) nodes on gru boards so we can support DDR DVFS.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Updates since the old series:

 - reordered alphabetically by phandle name, per style
 - drop a ton of deprecated/unused properties
 - add required center-supply for scarlet
 - add new *_idle_dis_freq properties
 - drop the lowest (200 MHz) OPP; this was never stabilized for
   production
 - bump the voltage (0.9V -> 0.925V) for the highest OPP on Chromebook
   models; later (tablet) models were more stable, with a fixed DDR
   regulator
 - bump odt_dis_freq to 666 MHz; early versions used 333 MHz, but
   stabilization efforts landed on 666 MHz for production

---

Changes in v2:
 - Adapt to new properties

Changes in v1:
This was part of a previous series, at:
https://lore.kernel.org/r/20210308233858.24741-3-daniel.lezcano@linaro.org
I've picked up a bunch of changes and fixes, so I've restarted the patch
series numbering.

 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  7 +++++
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 12 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 28 +++++++++++++++++++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 25 +++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 9b2c679f5eca..cc8950046d94 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -234,6 +234,13 @@ &cdn_dp {
 	extcon = <&usbc_extcon0>, <&usbc_extcon1>;
 };
 
+&dmc {
+	center-supply = <&ppvar_centerlogic>;
+	rockchip,pd-idle-dis-freq-hz = <800000000>;
+	rockchip,sr-idle-dis-freq-hz = <800000000>;
+	rockchip,sr-mc-gate-idle-dis-freq-hz = <800000000>;
+};
+
 &edp {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index a9817b3d7edc..913d845eb51a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -391,6 +391,18 @@ &cru {
 		<400000000>;
 };
 
+/* The center supply is fixed to .9V on scarlet */
+&dmc {
+	center-supply = <&pp900_s0>;
+};
+
+/* We don't need .925 V for 928 MHz on scarlet */
+&dmc_opp_table {
+	opp03 {
+		opp-microvolt = <900000>;
+	};
+};
+
 &gpio0 {
 	gpio-line-names = /* GPIO0 A 0-7 */
 			  "CLK_32K_AP",
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 162f08bca0d4..23bfba86daab 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -373,6 +373,34 @@ &cru {
 		<200000000>;
 };
 
+&dfi {
+	status = "okay";
+};
+
+&dmc {
+	status = "okay";
+
+	rockchip,pd-idle-ns = <160>;
+	rockchip,sr-idle-ns = <10240>;
+	rockchip,sr-mc-gate-idle-ns = <40960>;
+	rockchip,srpd-lite-idle-ns = <61440>;
+	rockchip,standby-idle-ns = <81920>;
+
+	rockchip,ddr3_odt_dis_freq = <666000000>;
+	rockchip,lpddr3_odt_dis_freq = <666000000>;
+	rockchip,lpddr4_odt_dis_freq = <666000000>;
+
+	rockchip,sr-mc-gate-idle-dis-freq-hz = <1000000000>;
+	rockchip,srpd-lite-idle-dis-freq-hz = <0>;
+	rockchip,standby-idle-dis-freq-hz = <928000000>;
+};
+
+&dmc_opp_table {
+	opp03 {
+		opp-suspend;
+	};
+};
+
 &emmc_phy {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
index 2180e0f75003..6e29e74f6fc6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
@@ -110,6 +110,27 @@ opp05 {
 			opp-microvolt = <1075000>;
 		};
 	};
+
+	dmc_opp_table: dmc_opp_table {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <666000000>;
+			opp-microvolt = <900000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <900000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <928000000>;
+			opp-microvolt = <925000>;
+		};
+	};
 };
 
 &cpu_l0 {
@@ -136,6 +157,10 @@ &cpu_b1 {
 	operating-points-v2 = <&cluster1_opp>;
 };
 
+&dmc {
+	operating-points-v2 = <&dmc_opp_table>;
+};
+
 &gpu {
 	operating-points-v2 = <&gpu_opp_table>;
 };
-- 
2.35.0.rc0.227.g00780c9af4-goog

