Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD1846682A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347946AbhLBQan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359764AbhLBQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:30:09 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68228C06179E;
        Thu,  2 Dec 2021 08:25:33 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r26so72789420lfn.8;
        Thu, 02 Dec 2021 08:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zkcS7+n1gGRETsbxAVke0DfOgp5thJ9O9vqlNwbymZo=;
        b=aKbm0jqGqQBKRzqfDuhiE2xlT+R/vzJkmwWjfb0+xzKDh2xzPr1ZfXV7WFc1B976eD
         HSDFQVKr6YO/RZ72cNMOeNe9A6b/djeWPHQMIs4TruQEfzydiQrAfIWUgeXdSAXshrjR
         OcPeBvZTdCHWFXCAdtckkkezCVu/zJ7qR8feARLU5smSOj6qhmFeij2/T9cJSsVjTkZj
         AyKzfJSPOQh+9+sv2BovQgXLHYwUua5+RKzNc8CAs/zummyK5XnFCGhkYSrTFkNaZcH5
         yRRritoCYLKakaJSROkodMyCkG4oRzayGmZDZg9EX5QDr5fqJtJLMlzGcLRqd1TDAi28
         tSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkcS7+n1gGRETsbxAVke0DfOgp5thJ9O9vqlNwbymZo=;
        b=idz7arv/6riRKJu8p098EC0eJBbMZbehJk2Nxl9N+x4kdmpwSQQgxhx59ObBGlfy/x
         Ol+C3i3YiEOOeln+lZuMkQqcB94bPDQE3toQCkLNLhoHPBZNYGKihI7zmF08qQVi+G4m
         0I9HbuuW5d55vJg3X0KznP7aIOEHZRRRKIf5wTGdpTpujH9Cah5zSYWt5vCqjM3rdG72
         84LWr79G0ys40WliAXhMmWSORMupYi17hQsYEKEB2LR1mEwVb7WaW8EXjJu3QM0Q0QqY
         QPK2mkx070FlIH9M8Hkf+EF7oIXcgep7rNmhBDwtFHOQ6+riyBLJgipb9MZ/3dbZTJoM
         wDNA==
X-Gm-Message-State: AOAM5312oOBFPtAiK84IE0K5h+Qq/ByzbX8sy0HqacvPy2j15Yqw6PkZ
        Tpkiu6ZkgtNzyFapitLyFu0=
X-Google-Smtp-Source: ABdhPJxXWxkCEMsMgkvRWBk1cYAY6zm9sVWn+2iUZaxbe2VVIoDxFrkZckmO5aqHg1U1HX9z4kkfEw==
X-Received: by 2002:a05:6512:519:: with SMTP id o25mr12609268lfb.422.1638462331745;
        Thu, 02 Dec 2021 08:25:31 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:25:31 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 17/20] ARM: tegra: Add S/PDIF node to Tegra20 device-tree
Date:   Thu,  2 Dec 2021 19:23:38 +0300
Message-Id: <20211202162341.1791-18-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add S/PDIF node to Tegra20 device-tree. It's needed for enabling HDMI
audio support.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 63c2c2f8c0ce..72cbe32d0c1d 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -197,6 +197,7 @@ hdmi@54280000 {
 			reset-names = "hdmi";
 			power-domains = <&pd_core>;
 			operating-points-v2 = <&hdmi_dvfs_opp_table>;
+			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
 
@@ -396,6 +397,23 @@ tegra_ac97: ac97@70002000 {
 		status = "disabled";
 	};
 
+	tegra_spdif: spdif@70002400 {
+		compatible = "nvidia,tegra20-spdif";
+		reg = <0x70002400 0x200>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA20_CLK_SPDIF_OUT>,
+			 <&tegra_car TEGRA20_CLK_SPDIF_IN>;
+		clock-names = "out", "in";
+		resets = <&tegra_car 10>;
+		dmas = <&apbdma 3>, <&apbdma 3>;
+		dma-names = "rx", "tx";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+
+		assigned-clocks = <&tegra_car TEGRA20_CLK_SPDIF_OUT>;
+		assigned-clock-parents = <&tegra_car TEGRA20_CLK_PLL_A_OUT0>;
+	};
+
 	tegra_i2s1: i2s@70002800 {
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002800 0x200>;
-- 
2.33.1

