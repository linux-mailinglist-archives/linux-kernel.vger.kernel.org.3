Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE034641B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345279AbhK3WpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344840AbhK3WmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:20 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0B5C0613F6;
        Tue, 30 Nov 2021 14:38:58 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z8so44105164ljz.9;
        Tue, 30 Nov 2021 14:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ivl/N40c1tlMrmwTfIX/+o/rKme8fK1843gBC9Fg4bk=;
        b=BgcFD6Tp93LbmVzz4N7C1W1XqwkIQMVP7sq8BmZHTGipmD9G4fd3/Q3sqpDx5gf6kH
         7nRmVSRqUCfHIvV3l6FV50h3UrStMFZPSKcvNcJ7qhh3iip8k8ODIzzi9W9YtYCEtFnw
         7LckAkmpq/TyWRht7DE+ek1SW57Co+hrdDvjf4Ip5R54yNTOjt3BIt015TuP//Z+13AJ
         mI2tq4PxfHZjf+uDXIQ+UNLoJxy9VFwDFRRZqojLhMUz2tMbRruPcKmuVyXDrqwfbJlB
         10IEazQwSvbaWtFtL00xCdTLMYUqsaead5oITuz/yl38HxbejIYlfxQHxWgpbypIBv9Q
         AG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ivl/N40c1tlMrmwTfIX/+o/rKme8fK1843gBC9Fg4bk=;
        b=2fInBz0Jp+EvN8e8J83kNdkZSQ40gclGY1uTSIvKgqyWghdpA+BtI84z2sJ/nWqyJp
         Qme+fDKOlI7v69CPrTVoCSQp/rRvfpRM79X9la/ssqS3bRHKOeqY9XRieHzTptEEGJwa
         GRsZDIr7zcBYSXJ5SUj23PHHY+tVbl7WQbW4F45wpJnT6KtfXfu8ExF5BahLAZkOrON0
         yeMYu267SbSKUsPEbFRbFA8KDiHRdIy4WB0mjoQDec9tX6bPl6tu9mKsy9K1awkLw2Fk
         lhFo68rgDDk90ztu73OaD06BrA/X0OGNHLvluUzH9KTL5pmGkO3vBMhZh3ZUxFe1aKxL
         jqaA==
X-Gm-Message-State: AOAM532LK5WziLlGEbt2ROa6m1i0hrnzI6Cd05Bmr9jrPlV5uV04LSKL
        bFz3476d5lk8kNeynWkH1Ms=
X-Google-Smtp-Source: ABdhPJxXdkagp8HTihfc4DlGm02oRKBJDOXK/lP+R1NxksLimrywVVzq0t3I/nPhowBXP9OHyhVcdg==
X-Received: by 2002:a2e:760e:: with SMTP id r14mr1745980ljc.234.1638311936848;
        Tue, 30 Nov 2021 14:38:56 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:38:56 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/24] ARM: tegra: Enable HDMI CEC on Nyan
Date:   Wed,  1 Dec 2021 01:38:12 +0300
Message-Id: <20211130223820.23609-17-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable HDMI CEC on Nyan Chromebooks. It allows to control TV over HDMI.

Suggested-by: Thomas Graichen <thomas.graichen@gmail.com>
Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 93a40a84b792..a5dff226831b 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -390,6 +390,10 @@ pmc@7000e400 {
 		nvidia,sys-clock-req-active-high;
 	};
 
+	cec@70015000 {
+		status = "okay";
+	};
+
 	hda@70030000 {
 		status = "okay";
 	};
-- 
2.33.1

