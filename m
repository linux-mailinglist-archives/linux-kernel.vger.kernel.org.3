Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4765A46DA2C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbhLHRnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbhLHRlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:50 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BCCC0698C8;
        Wed,  8 Dec 2021 09:38:18 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 13so4970920ljj.11;
        Wed, 08 Dec 2021 09:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFv5ewELhNJglV+yW+iqcYT9tK2sEvBiahvNmcOYRpE=;
        b=o4SY5h3kbkDGZwezVEtAnfxuoIzpcv6sjJd5laF3y+OfYu3DkBcvANKFjZfMOI8Gy+
         +d2FkU2gRjm7dyV3SWlWRjdOxH/5JZn+BqzzEZa8jI6BuvN7lvqNUmJcLt9oYI+ne4cU
         ewT94D/uqPZqC8KdMC2mphFdqvVRflaq6mY/Me+tMEpy9SQ0GmWUwb8ZDZtExUU7cuJD
         vGDYKF12aJ1kNE/G5cOt4h6QGGLfLNCCkqp39OE0XODcaqbEu7wNefSZ18dJ9SQH5n00
         wg56vhH22QnX7S+V4MjAsMIN8/onfD+Am/6DAJWxK7cKMnWQ0CGQ+9m0YL+CDVqnXdaZ
         kBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFv5ewELhNJglV+yW+iqcYT9tK2sEvBiahvNmcOYRpE=;
        b=DZRemPGXy3Wi24oHrYswyWQI8UqMDQO3fjJi5zV8SNhPgh2un6bWIYqb+pu16f6g6/
         A2D5LIZQ7zd37Nk3BPgbH3v1RI0U7XM/CHeqHM1hVVFmDssf+3m+9cSS0MXBMYZe7cbk
         qG/OlcGv5uCvgnPv0EnTt41u47d9nW7zSa91KMEyyBSWOppGgkriG5KNAnJRIeN0BC2P
         uHharNO/FWAF3C3EF9/cFwHtYiSQmeFVhNF9PguuDHWmG3P2lm+0VolOJ7eVgl9235Od
         jgeosmlj3ielmhHYAZwoa87wZqbzdnhdy9BfoFUnihLQQ90TNRgOLGhla8snOiISBLRu
         NIYA==
X-Gm-Message-State: AOAM531Q6LMzwW/lcd+QkBsLmSmyVBhStNx2UJBdALEhcB4S2kVAAS8i
        dLCbzMRjSz0Kbx4ffVt1xk8=
X-Google-Smtp-Source: ABdhPJwulxpuEuyzDVvU9YxPcOvDGdKentzOKRJyn/HIXVk21qAbOuQmVCj/r2csAH3z9SAYS8rgcw==
X-Received: by 2002:a2e:530e:: with SMTP id h14mr834214ljb.256.1638985096586;
        Wed, 08 Dec 2021 09:38:16 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:38:16 -0800 (PST)
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
Subject: [PATCH v5 17/24] ARM: tegra: Enable CPU DFLL on Nyan
Date:   Wed,  8 Dec 2021 20:36:02 +0300
Message-Id: <20211208173609.4064-18-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU DFLL node on Nyan Chromebooks. DFLL was previously disabled due
to Linux kernel CPUFreq driver which didn't support suspend-resume. That
problem was fixed years ago, but DFLL was never re-enabled.

Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index a5dff226831b..ec01a23d4d47 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -532,7 +532,7 @@ mmc@700b0600 { /* eMMC on this bus */
 
 	/* CPU DFLL clock */
 	clock@70110000 {
-		status = "disabled";
+		status = "okay";
 		vdd-cpu-supply = <&vdd_cpu>;
 		nvidia,i2c-fs-rate = <400000>;
 	};
-- 
2.33.1

