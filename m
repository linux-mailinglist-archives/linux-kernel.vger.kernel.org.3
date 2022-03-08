Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3404D0CA6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbiCHAME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344110AbiCHALh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:11:37 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B5138BCD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:10:32 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id t187so10636623pgb.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rU/WmKtGF4aym/wTFIaRDtTDG4TLl/BdBtfttgE23Ag=;
        b=TVD1mjin5wJZ4UJaJm/QXnb+WcioinaTpjR3eeFHQ0JAgKwd2v94ywPR8LQHl9sqbO
         cWts2ekIxbvv67r6zBlexYyQRktCjxpkfKceI7xY9VNqyG4J1y8Lto33UzUIj0AIZIXe
         KdeUmtiZVC/pqhm9kujUmQaq1lqJ3BokIXwkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rU/WmKtGF4aym/wTFIaRDtTDG4TLl/BdBtfttgE23Ag=;
        b=7MoiT6DGmsJPqiRu+i48/B//IzKrjuyxjQQJOMStGfOC0UxKHeAExDOC4N6RKDzkZz
         m/iAK3e/J4/p4PGYkDx9C1UwiOLLdE9sLHino0OvCc7GCzbrFfhfurROiKMSJNPRVgz3
         XJoqaB4ZqrFZLRaF2iarE+QjQhJTMifJ5eKocuQJPKfOVXKKp5/SfHJrH5fAVJbS6GK0
         zbcp8tEQss/KVM0p8XBkTB0mq59kkmlh6vmnA1/1vZI1XUhcWZ/tShK3zeI73IbOjpFV
         D5YP9tDcXdV2sHRyGXNbcm2HcekgohS3QmWNUQ6flEcViSLXEYX+JNS9Z40QbDfmpvH3
         a5EQ==
X-Gm-Message-State: AOAM533incbb4zVsfhsvww8nC1mr0qYtxWK1KlUI1ecY6oV3cn0i3ao4
        YQbVvy5uvvkM2TqYfajiczHt4w==
X-Google-Smtp-Source: ABdhPJzL2r58vNjLtCrdtdNxaqnZ9zxgzJJyP7Sa+3mJN/ZwiynkhujkVw8S3vhsMpnAWZ6L+W1gkQ==
X-Received: by 2002:aa7:8211:0:b0:4f7:8b7:239b with SMTP id k17-20020aa78211000000b004f708b7239bmr6366065pfi.64.1646698231704;
        Mon, 07 Mar 2022 16:10:31 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e551:44dc:2842:57f1])
        by smtp.gmail.com with UTF8SMTPSA id kk12-20020a17090b4a0c00b001bed1ff3717sm476738pjb.6.2022.03.07.16.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:10:31 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lin Huang <hl@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 12/15] arm64: dts: rockchip: Enable dmc and dfi nodes on gru
Date:   Mon,  7 Mar 2022 16:09:42 -0800
Message-Id: <20220307160918.v3.12.I3a5c7f21ecd8221b42c2dbcd618386bce7b3e9a6@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308000945.706701-1-briannorris@chromium.org>
References: <20220308000945.706701-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

(no changes since v2)

Changes in v2:
 - Adapt to new properties

Changes in v1:
This was part of a previous series, at:
https://lore.kernel.org/r/20210308233858.24741-3-daniel.lezcano@linaro.org
I've picked up a bunch of changes and fixes, so I've restarted the patch
series numbering. Updates since the old series:
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

 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  7 +++++
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 12 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 28 +++++++++++++++++++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 25 +++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 3355fb90fa54..50d459ee4831 100644
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
2.35.1.616.g0bdcbb4464-goog

