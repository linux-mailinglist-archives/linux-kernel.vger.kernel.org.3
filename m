Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CB5487FC3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiAGXyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiAGXxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:53:52 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3736C061401
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:53:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id r14-20020a17090b050e00b001b3548a4250so5302544pjz.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGzgdGw2ygRqpcUdePm+Su5tD7TZxP9sdobQbw7EuUI=;
        b=RUQ7R2K0ZKIUdwB5X5NmRvSqn3fS17E6ywGorO3ouAqwwj3P5S0sZwCL/ybr4XscT4
         6D5y3Njh9Bz3SdNQwXelYmKZIpQQAisRv8pd85kvQyGL+8A7U5Q86we/+xH2jY4WvEAK
         JdAeJlcWx2Hw74F5uoUczZ6RNG4YfJ9DkTiL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGzgdGw2ygRqpcUdePm+Su5tD7TZxP9sdobQbw7EuUI=;
        b=GUwu1c7wl0r0k7ZOZf4fS9QDF2n2OtXqOuj4/YpFyJ5Lrm5uBNYHECANxf87JP9GV1
         ZvhxNCP5A5+niCMF4sEaPAG+N35LmKRokEe6ILNNZ4KAGTZjVPHA0qPGeolRbIWcZszt
         +FuDB+fBw64GC5SVTWNbsKiQXf9r3XNB3cjjqQuijccyYdkaGUZKhrohuueNHe3EFwQD
         b5V6HCYcTAdZDb21vWDklY9k90ehxP116Okg3gaA5cXfaS0j7hzc3csiG4I7K6WwEX5t
         PumN2Dm95Ju3y/b4OLx44rs/C3ZDL30H90u2E+kgRnxgjM9ovX4SZcacWmXtS9P3VP23
         oNxA==
X-Gm-Message-State: AOAM532hqCXXAV/m71rAxCv1XzdwatX4wqY5A3rGsLzgQIfXtr6SEDmq
        7j5fE9HV7oOiuMzoFDg18pn2kymdPsWFsg==
X-Google-Smtp-Source: ABdhPJwL1zbXYqcwNN1NKUrnQbenm9zESq2WGHkzK0A9KpnOeaZTWfin5pN4KEKW7GQcDUdkAFVExA==
X-Received: by 2002:a17:903:191:b0:148:a2f7:9d4a with SMTP id z17-20020a170903019100b00148a2f79d4amr64690380plg.105.1641599631474;
        Fri, 07 Jan 2022 15:53:51 -0800 (PST)
Received: from localhost ([2620:15c:202:201:db:1c60:693f:c24e])
        by smtp.gmail.com with UTF8SMTPSA id u18sm49681pfi.158.2022.01.07.15.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 15:53:51 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 10/10] arm64: dts: rockchip: Enable dmc and dfi nodes on gru
Date:   Fri,  7 Jan 2022 15:53:20 -0800
Message-Id: <20220107155215.10.I3a5c7f21ecd8221b42c2dbcd618386bce7b3e9a6@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220107235320.965497-1-briannorris@chromium.org>
References: <20220107235320.965497-1-briannorris@chromium.org>
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
---
This was part of a previous series, at:
https://lore.kernel.org/r/20210308233858.24741-3-daniel.lezcano@linaro.org
I've picked up a bunch of changes and fixes, so I've restarted the patch
series numbering.

Updates since the old series:

 * reordered alphabetically by phandle name, per style
 * drop a ton of deprecated/unused properties
 * add required center-supply for scarlet
 * add new *_idle_dis_freq properties
 * drop the lowest (200 MHz) OPP; this was never stabilized for
   production
 * bump the voltage (0.9V -> 0.925V) for the highest OPP on Chromebook
   models; later (tablet) models were more stable, with a fixed DDR
   regulator
 * bump odt_dis_freq to 666 MHz; early versions used 333 MHz, but
   stabilization efforts landed on 666 MHz for production

 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  7 +++++
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 12 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 28 +++++++++++++++++++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 25 +++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 9b2c679f5eca..46292fdceecb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -234,6 +234,13 @@ &cdn_dp {
 	extcon = <&usbc_extcon0>, <&usbc_extcon1>;
 };
 
+&dmc {
+	center-supply = <&ppvar_centerlogic>;
+	rockchip,pd_idle_dis_freq = <800000000>;
+	rockchip,sr_idle_dis_freq = <800000000>;
+	rockchip,sr_mc_gate_idle_dis_freq = <800000000>;
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
index 45a5ae5d2027..58b8d332f924 100644
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
+	rockchip,pd_idle = <0x40>;
+	rockchip,sr_idle = <0x2>;
+	rockchip,sr_mc_gate_idle = <0x3>;
+	rockchip,srpd_lite_idle	= <0x4>;
+	rockchip,standby_idle = <0x2000>;
+	rockchip,ddr3_odt_dis_freq = <666000000>;
+	rockchip,lpddr3_odt_dis_freq = <666000000>;
+	rockchip,lpddr4_odt_dis_freq = <666000000>;
+
+	rockchip,pd_idle_dis_freq = <1000000000>;
+	rockchip,sr_idle_dis_freq = <1000000000>;
+	rockchip,sr_mc_gate_idle_dis_freq = <1000000000>;
+	rockchip,srpd_lite_idle_dis_freq = <0>;
+	rockchip,standby_idle_dis_freq = <928000000>;
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
2.34.1.575.g55b058a8bb-goog

