Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26EF46433A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241366AbhK3Xbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345470AbhK3X14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:56 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406B0C06175C;
        Tue, 30 Nov 2021 15:24:35 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id z7so23591530lfi.11;
        Tue, 30 Nov 2021 15:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ops+ixvINP38o4nA4ikQm5GyykwXVWsU0qQPTLJ2ovo=;
        b=YMJPx1WkfQ4OtvgoHiEOjNWPEVjmn3npVavgDBfRcNtJDkNDsT+oIhWmoM6O2vWsFz
         kDfpD5FcITyBnC2WuMVLxKEi13AvMRCTzq0ziSJJ3GMHqJ1GZeh8mmMiENZw293W3hoh
         mbjG8N3cb1e8+k4AUPL9nxcldnvXDRrUQDXPA3FfG9zQRX7TFmzQA3LU3Pn+zelGrqP8
         fv2bDd75irm5uKgrOxMJjI+jzBDGrK+24gXvFS/BW4cpb9k9r83dMlJxIcZqWCHapD78
         iKuBfdBjVqeMBg+gCfa2Vok8CbbEsYlGoOkCBJ4lOIKW2mr0wPEl0jmVvU8ud2k8B4w1
         eM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ops+ixvINP38o4nA4ikQm5GyykwXVWsU0qQPTLJ2ovo=;
        b=Abqyu988mDzSCna70Gtbr9nclNj1MJbFOddNxUmfjsFL2qK/bO/hjt+y/1Y0UuDInJ
         mMWUCl1kMxxPpiz57lkwQUF0fsV+WjZ+J3cSGg9LkX5ZFcT2mge+w+kyCxtOB418J0cG
         izsPJpmxA/7z/cQLp65wpnhKmCSo0jgIjllU4DAMfddN/neFRfAG6wG3wHFuql/U9DcS
         nYWlaLYhmat2Xcv0nzn7/IN0kAaUJizLpnSmURT5h+HBvLQxqcVQXgm5UNBmDAaubXm1
         mGZUJzItGhYKPt7VvJPvxmweNSv04JF8+zE4h+yQ8JCiuLfIbTGubD3GdlQadNT9u1vH
         3QKA==
X-Gm-Message-State: AOAM531WaB0BUy6dIOxPLpIr1KyyLSMTsipzWUkRCJHSg0tkAwHsP5SD
        xTzsIWf+FOcC2+rx9Wu2s3AZEFsjZtA=
X-Google-Smtp-Source: ABdhPJwYhMt2gMhwNZLB8J5sGborl43HOmKpzseUac+5sucFsKDv4qipP1jfRU2yxx/VOb5FtiCQaA==
X-Received: by 2002:ac2:491e:: with SMTP id n30mr2284370lfi.97.1638314673603;
        Tue, 30 Nov 2021 15:24:33 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:33 -0800 (PST)
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
Subject: [PATCH v16 40/40] ARM: tegra20/30: Disable unused host1x hardware
Date:   Wed,  1 Dec 2021 02:23:47 +0300
Message-Id: <20211130232347.950-41-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPE, VI, EPP and ISP were never used and we don't have drivers for them.
Since these modules are enabled by default in a device-tree, a device is
created for them, blocking voltage scaling because there is no driver to
bind, and thus, state of PMC driver is never synced. Disable them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 4 ++++
 arch/arm/boot/dts/tegra30.dtsi | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 7b69ffc57abe..8010b40d7377 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -59,6 +59,7 @@ mpe@54040000 {
 			reset-names = "mpe";
 			power-domains = <&pd_mpe>;
 			operating-points-v2 = <&mpe_dvfs_opp_table>;
+			status = "disabled";
 		};
 
 		vi@54080000 {
@@ -70,6 +71,7 @@ vi@54080000 {
 			reset-names = "vi";
 			power-domains = <&pd_venc>;
 			operating-points-v2 = <&vi_dvfs_opp_table>;
+			status = "disabled";
 		};
 
 		epp@540c0000 {
@@ -81,6 +83,7 @@ epp@540c0000 {
 			reset-names = "epp";
 			power-domains = <&pd_core>;
 			operating-points-v2 = <&epp_dvfs_opp_table>;
+			status = "disabled";
 		};
 
 		isp@54100000 {
@@ -91,6 +94,7 @@ isp@54100000 {
 			resets = <&tegra_car 23>;
 			reset-names = "isp";
 			power-domains = <&pd_venc>;
+			status = "disabled";
 		};
 
 		gr2d@54140000 {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 96d1c5688248..c8b22ec30ef0 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -145,6 +145,8 @@ mpe@54040000 {
 			operating-points-v2 = <&mpe_dvfs_opp_table>;
 
 			iommus = <&mc TEGRA_SWGROUP_MPE>;
+
+			status = "disabled";
 		};
 
 		vi@54080000 {
@@ -158,6 +160,8 @@ vi@54080000 {
 			operating-points-v2 = <&vi_dvfs_opp_table>;
 
 			iommus = <&mc TEGRA_SWGROUP_VI>;
+
+			status = "disabled";
 		};
 
 		epp@540c0000 {
@@ -171,6 +175,8 @@ epp@540c0000 {
 			operating-points-v2 = <&epp_dvfs_opp_table>;
 
 			iommus = <&mc TEGRA_SWGROUP_EPP>;
+
+			status = "disabled";
 		};
 
 		isp@54100000 {
@@ -183,6 +189,8 @@ isp@54100000 {
 			power-domains = <&pd_venc>;
 
 			iommus = <&mc TEGRA_SWGROUP_ISP>;
+
+			status = "disabled";
 		};
 
 		gr2d@54140000 {
-- 
2.33.1

