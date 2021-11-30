Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30DF464333
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345743AbhK3XaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345442AbhK3X1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:50 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DFCC061574;
        Tue, 30 Nov 2021 15:24:30 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e11so44186801ljo.13;
        Tue, 30 Nov 2021 15:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nDfKTCKLqf9G6JM8mpqxRAZhh67bMGPfUrf1PMFZnmE=;
        b=fhpWDE/W8BPbpYc6LrT3Sd3tL3GRIqLrzCk59WClqm4rHNchu4CExjdl/yfsM6OXDi
         GW7PMw8GvZh5/M28Qh7yeE/PnCVnvTBw3xoaNaJ/bUDC8GUNstcex8ucbctDFUPhlg96
         XbROgohEdgTo8uryBLF23Ou2EqYu7n22+wkAFeSCbBfCaZX0LHMcTfXnfnm5vkG5Asnk
         itNiMnbDj7fRLFLdUlH8U5icIUkUeCio2KfDYw4BNJBeIgeatjNLCUU5bcONLTxWLIQb
         k5IzhApWb39vbgOAeeYilHZa1gM9hjZTLN1R0uYknT/wM2DSquHyZiZBVwYBcS1QhFJx
         0Uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nDfKTCKLqf9G6JM8mpqxRAZhh67bMGPfUrf1PMFZnmE=;
        b=rnpn9hR9HRAlTSTd8jz09WzAZTwm8Nn0XZcJYBNtHZrMB1iT0SOlgT2MRGN68MLQmF
         SEFNkxO2Lvlm8SdzIvD+czB66wQWgJDg44VYEMB4d91k3Hnp9xqn5hoYdM3DcnV02aT2
         S77ZIzC0gO10IBdl/McNnMm8Pm/MvSiXZGyHXvvEW9GolSHOjKLTSgFLgxlzh5eY+LzU
         G0RVpZUp4efCIaZoaOv5xPZCRRxmDLKiKfVXWKGv2STZrnofkOfYdkvQWM6Z43QPeUDB
         SlnClBEItP8Jg1/vaD/bKx7koKkmDKLPc2NqJavhDXs7er+b5Sl1dNtUgbym5BmJI7fE
         kjhA==
X-Gm-Message-State: AOAM533ggrhUI9a5yO5P2b1G89d8zmK5CNSV7LPIthTh5cCZXDatebyQ
        WhUkOYni9tTmu7/NZPIw+bE=
X-Google-Smtp-Source: ABdhPJxFExIlRTXbP3roDYpHOtAksUcXMnHB8sB6CKOzUF0kjCrj0HK7HUUphnePINzZFTW2y05wyw==
X-Received: by 2002:a2e:9b17:: with SMTP id u23mr1975761lji.258.1638314668747;
        Tue, 30 Nov 2021 15:24:28 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:28 -0800 (PST)
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
Subject: [PATCH v16 35/40] ARM: tegra: Add 500MHz entry to Tegra30 memory OPP table
Date:   Wed,  1 Dec 2021 02:23:42 +0300
Message-Id: <20211130232347.950-36-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend memory OPPs with 500MHz entry. This clock rate is used by ASUS
Transformer tablets.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-peripherals-opp.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi b/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
index ff25350869b3..af9640401402 100644
--- a/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
+++ b/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
@@ -216,6 +216,18 @@ opp-450000000-1250 {
 			opp-supported-hw = <0x0008>;
 		};
 
+		opp-500000000-1200 {
+			opp-microvolt = <1200000 1200000 1350000>;
+			opp-hz = /bits/ 64 <500000000>;
+			opp-supported-hw = <0x0007>;
+		};
+
+		opp-500000000-1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <500000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
 		opp-533000000-1200 {
 			opp-microvolt = <1200000 1200000 1350000>;
 			opp-hz = /bits/ 64 <533000000>;
@@ -347,6 +359,12 @@ opp-450000000 {
 			opp-peak-kBps = <3600000>;
 		};
 
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <4000000>;
+		};
+
 		opp-533000000 {
 			opp-hz = /bits/ 64 <533000000>;
 			opp-supported-hw = <0x000F>;
-- 
2.33.1

