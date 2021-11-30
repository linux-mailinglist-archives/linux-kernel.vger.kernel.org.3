Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A3B4641A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344823AbhK3Woy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344851AbhK3WmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:21 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6437C0613F9;
        Tue, 30 Nov 2021 14:38:59 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id v15so44206450ljc.0;
        Tue, 30 Nov 2021 14:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFv5ewELhNJglV+yW+iqcYT9tK2sEvBiahvNmcOYRpE=;
        b=jLa2w95cxuxtQfciR0z9H/jLZd8AO04ZqpAfPCEpUHRKA9LhUjomz+vhIBaOyJN1lW
         +/IcMyB1ymRiwlBTC6FHBDdNfHTzbpIucQ6fodKUgYBQ1FuL/iEzZt80yMGZNymu5Y3g
         7IBhGcO1bh5s8c2Hjxxaj/1fAdTs/VSmXv+0DPMBddrsxP5ljr1R332m5B78F6WwuMa6
         hJPEcLK80aurhvvJ1seMehQ2HK8pN9tWmnsby8l40VccI///AVZ3reS43jF3+K3KzV+B
         /Oz5hsDdg2oI6NhJrq4rjqSzGKDkixFjbX99areh2V9TnG4ayiJhRjB4GYJ6xNmqeXL2
         9niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFv5ewELhNJglV+yW+iqcYT9tK2sEvBiahvNmcOYRpE=;
        b=pun7KsJH584nXSSavrrRIRxAvHEyoV6egbKIq2Ng8JKfkJUxTyXbLXO9JxclCgpmBO
         AiXc90kVCwNfhL8ma4cbxQQ8LWpd68Aw61rDhYWJB3sfSsfpA9JiYpuU1d590ePy2xE9
         JM296kTU8Lh40xpJNtqax9pJk0isisTA1yJ+7c2Iz0Thh6fXgPPIBg9lGaQoaNWNSwGq
         39MB6DeP37OHBAak1fQPvCSeTSJZJzkM+Rd3LIeBkAB8S2V2bZBZ2GlNQjzIhbvV3Kde
         OC5QK3lmNwckqMPTewyYsErZ1BUEqXhmFaDeeXmLJAeepchN2c+fqZ9daygWw2tGxjMY
         nVpA==
X-Gm-Message-State: AOAM532+PGtIiEE/xzr9e2qvd1VCEMJ6F9qBnsLsiFnbeWF8bmYOww04
        CPPGMHnCAoY8Ovk8V7Z0TQ8=
X-Google-Smtp-Source: ABdhPJx5zwNv905spOFabNXjFl+WGXUZe8MHugx/k+XpT2vPGl/9JhhWALVSciFQvI3oHFjQYtaI7g==
X-Received: by 2002:a05:651c:1546:: with SMTP id y6mr1697040ljp.76.1638311938091;
        Tue, 30 Nov 2021 14:38:58 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:38:57 -0800 (PST)
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
Subject: [PATCH v4 17/24] ARM: tegra: Enable CPU DFLL on Nyan
Date:   Wed,  1 Dec 2021 01:38:13 +0300
Message-Id: <20211130223820.23609-18-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
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

