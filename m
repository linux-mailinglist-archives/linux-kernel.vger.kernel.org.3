Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13679464337
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbhK3Xbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345460AbhK3X1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:54 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA28C061759;
        Tue, 30 Nov 2021 15:24:33 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id t26so57886115lfk.9;
        Tue, 30 Nov 2021 15:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EhlDIlIDsNVFTr5Q8VNTSCXABzQ4ZRHMvuz4cuElJaI=;
        b=HLwwtuno+q8YKVRyLlVnn0SkXeK/ld2EqLBtsYo4WOBg/C9VmHifYp5q2qBZ8rcmGr
         h5byPqdi5UlOX05T0WftQ43Q3ZUKYPKvpHtbHlEsSqC0Bssbi5nkxQ4mIsffrVIO/DPw
         FEgPrjgelY5JzUQHjjxgqi/U3DXhT39/N09rNaBxyYN1P3ZJuoWyEphcsgWVg5H8JyN7
         Tp8wX4bPDDXpLzpEWDbYwrdbjhnvFw4JuXMPzL6JH0yLFsxtmNHQoHfUry9J4KyE3fXE
         KpWLpRFseMp1zSrsSnq0dIa6l3YMyk+7PvnZUU0N8KLlNp7iNiv50EBuUWTCMLcfOLk+
         rSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhlDIlIDsNVFTr5Q8VNTSCXABzQ4ZRHMvuz4cuElJaI=;
        b=0OKQ/+BY6dMh+i5SBCvrJtFNN1uSXGN9bhMVlFP/v2r6tFX0sMIwUsfxc/tF1TtbLX
         ikORoFzlna8RoQdrel74tu22lK6tOzGfxSuvClvUWpaF7uk9VcB1mDFQOvjYc1vEZYvO
         Bo8TSfEqs92vhPcsuFEmLUXwdYDLoJrWJo0A9Pk48pIOw/eNZ/fwqT02KCZ6uqy+4pjf
         ipkyoTw2XxCz2O9euNsPhjaJo2EhA0LvZnRUDmi/h++nOIstL2LrFXC7fDh1XpnNdb3j
         U6YI6tbz+XyeGosVFwXsoVRm21AAzL3RHKvyzJm+cJlfXTYw+dAgDh1SViogep3YX0eY
         UWjA==
X-Gm-Message-State: AOAM5316eMd26hhLpN7cB1zCELGQZ5fcHEKPAjBjfR3TC7C6CT8ihI4O
        fvQpd1j2D7g7SW3F9mb3wRTQlebwtik=
X-Google-Smtp-Source: ABdhPJwgBmpTPWGoE5wlmkHA8FC4JwHuGKMd4RYMtWxSY8P0RGVDESESrvpM8Hf6GRLRF59dpUnlJg==
X-Received: by 2002:a05:6512:118e:: with SMTP id g14mr2237268lfr.561.1638314671809;
        Tue, 30 Nov 2021 15:24:31 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:31 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v16 38/40] ARM: tegra: Add Memory Client resets to Tegra20 GR2D, GR3D and Host1x
Date:   Wed,  1 Dec 2021 02:23:45 +0300
Message-Id: <20211130232347.950-39-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory access must be blocked before hardware reset is asserted and before
power is gated, otherwise a serious hardware fault is inevitable. Add
reset for memory clients to the GR2D, GR3D and Host1x nodes.

Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 1898351a099f..7b69ffc57abe 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -40,8 +40,8 @@ host1x@50000000 {
 		interrupt-names = "syncpt", "host1x";
 		clocks = <&tegra_car TEGRA20_CLK_HOST1X>;
 		clock-names = "host1x";
-		resets = <&tegra_car 28>;
-		reset-names = "host1x";
+		resets = <&tegra_car 28>, <&mc TEGRA20_MC_RESET_HC>;
+		reset-names = "host1x", "mc";
 		power-domains = <&pd_core>;
 		operating-points-v2 = <&host1x_dvfs_opp_table>;
 
@@ -98,8 +98,8 @@ gr2d@54140000 {
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA20_CLK_GR2D>;
-			resets = <&tegra_car 21>;
-			reset-names = "2d";
+			resets = <&tegra_car 21>, <&mc TEGRA20_MC_RESET_2D>;
+			reset-names = "2d", "mc";
 			power-domains = <&pd_core>;
 			operating-points-v2 = <&gr2d_dvfs_opp_table>;
 		};
@@ -108,8 +108,8 @@ gr3d@54180000 {
 			compatible = "nvidia,tegra20-gr3d";
 			reg = <0x54180000 0x00040000>;
 			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
-			resets = <&tegra_car 24>;
-			reset-names = "3d";
+			resets = <&tegra_car 24>, <&mc TEGRA20_MC_RESET_3D>;
+			reset-names = "3d", "mc";
 			power-domains = <&pd_3d>;
 			operating-points-v2 = <&gr3d_dvfs_opp_table>;
 		};
-- 
2.33.1

