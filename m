Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679F5464336
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbhK3XbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345406AbhK3X1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:55 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4FCC06175A;
        Tue, 30 Nov 2021 15:24:34 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id m12so6134443ljj.6;
        Tue, 30 Nov 2021 15:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1V/UFpas9dR6RAsIe/6wp+AuQdWLTUAavRrmb8F89vE=;
        b=MwLkQ6y/frw8oUgS8oo/4Md25aV5Ayz94lDl9OvFvysZrqXXX1tNtK69gkkj/hgvot
         x/vadNhpiWIr5r1uN0JnAN1KOUNtkSA5LJluU7Pv/LD3rYUf+CkFobE2oFwn6X6YBk2V
         PINflefJEkY4aAt1MFYK9zRRH6puIXSxzcJQuxpoJXtuu2B5OqaSlaBFNZFz4fkO9bFF
         VY+9n4uFh2Vef8di06UQJWDThIDieAKv/5JdzHba71EtT4Q2B98fvTkC/pV+wllsoakh
         erMXQzYLbgmXcJvxDmneBj9byZTdtGlkL3fjhUnUNy/zIDNCOtqmmAuIqVA6Bwt8BZ5s
         n2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1V/UFpas9dR6RAsIe/6wp+AuQdWLTUAavRrmb8F89vE=;
        b=RmuWlhcqTOhoPcAU8a+un2oSJk+6Ih6Dpij0nVlt8OgP31+IxKAjHSn688l+Fjlz2q
         PtrG/kETEqNIPFpVUz37VzYtXqCmAQs7GrPFK35QqJrCnk70PMttwoyOuTlEJcyqTIH2
         Ys19pxAhMgGqRXVnl03UvgXob4qPQPGWy6nm2hApzF+MKcCkj4la/iIOczOdbQrK+jSJ
         hh1hn7X44YgBNmrprCkOvxH6PdzuTfUrGZkii6VB8ag2o+6ucvX6Lnm6T9VO5SZWTb4Q
         CHc9SrUkCL5TkHzNL1HXrMJpyN6PRMd8EhltaKr3eiksliaZj+A/iDjlAJWxNhllYTDh
         IYYQ==
X-Gm-Message-State: AOAM530r6/AlicxYSqqD6QH13MIV/orLTynWYeAnl5dCi2je5Y/ESaKr
        eCls0ZKLChfKbPknbGGIiOQ=
X-Google-Smtp-Source: ABdhPJz0sWleOmyioOFnT7nxYKFSRhyGAHaWvEEJs/ucrK8wCAckUXGadtrKT8aAS/x2ZR+Jd6y4kA==
X-Received: by 2002:a2e:9b41:: with SMTP id o1mr1927573ljj.499.1638314672683;
        Tue, 30 Nov 2021 15:24:32 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:32 -0800 (PST)
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
Subject: [PATCH v16 39/40] ARM: tegra: Add Memory Client resets to Tegra30 GR2D, GR3D and Host1x
Date:   Wed,  1 Dec 2021 02:23:46 +0300
Message-Id: <20211130232347.950-40-digetx@gmail.com>
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

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 0ac6cb315e8d..96d1c5688248 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -123,8 +123,8 @@ host1x@50000000 {
 		interrupt-names = "syncpt", "host1x";
 		clocks = <&tegra_car TEGRA30_CLK_HOST1X>;
 		clock-names = "host1x";
-		resets = <&tegra_car 28>;
-		reset-names = "host1x";
+		resets = <&tegra_car 28>, <&mc TEGRA30_MC_RESET_HC>;
+		reset-names = "host1x", "mc";
 		iommus = <&mc TEGRA_SWGROUP_HC>;
 		power-domains = <&pd_heg>;
 		operating-points-v2 = <&host1x_dvfs_opp_table>;
@@ -190,8 +190,8 @@ gr2d@54140000 {
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
-			resets = <&tegra_car 21>;
-			reset-names = "2d";
+			resets = <&tegra_car 21>, <&mc TEGRA30_MC_RESET_2D>;
+			reset-names = "2d", "mc";
 			power-domains = <&pd_heg>;
 			operating-points-v2 = <&gr2d_dvfs_opp_table>;
 
@@ -205,8 +205,10 @@ gr3d@54180000 {
 				 <&tegra_car TEGRA30_CLK_GR3D2>;
 			clock-names = "3d", "3d2";
 			resets = <&tegra_car 24>,
-				 <&tegra_car 98>;
-			reset-names = "3d", "3d2";
+				 <&tegra_car 98>,
+				 <&mc TEGRA30_MC_RESET_3D>,
+				 <&mc TEGRA30_MC_RESET_3D2>;
+			reset-names = "3d", "3d2", "mc", "mc2";
 			power-domains = <&pd_3d0>, <&pd_3d1>;
 			power-domain-names = "3d0", "3d1";
 			operating-points-v2 = <&gr3d_dvfs_opp_table>;
-- 
2.33.1

