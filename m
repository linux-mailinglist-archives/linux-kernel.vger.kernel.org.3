Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FAD471697
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhLKVPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhLKVOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:47 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC84EC0698CA;
        Sat, 11 Dec 2021 13:14:40 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id l7so18500217lja.2;
        Sat, 11 Dec 2021 13:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFv5ewELhNJglV+yW+iqcYT9tK2sEvBiahvNmcOYRpE=;
        b=cJ4IMGi9wDk2bKuQGFRd4u+BwhLdFNyz/2jaznmXgeZ42j2X0zlVmA1Ynf2aEeqbKX
         AgstJEBZ2oJpiOMfX1iSIB+sUXo1t5B1rbvwalVzC9/jywVJCc6TXEjyKsty3/n8Lix/
         xMj3MghIj3bbibXRLqdrv2IiTPzG6CE0N0tSO0sIXuVmSEM4kGW2mHOanDj9n2yhlHXF
         C/EZa56Lyk+sN8EgXUFihpqrdwBhun0MzO/2HfhTlStXDo9Z1Ihw3PeuQv9HvXmZxz57
         AhbohJNTSiayTV9Ni4szr4akLlKxkZCqr+zzgm/FAWo54T5o2OnM5Kb/nMc+2hzU0izo
         TBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFv5ewELhNJglV+yW+iqcYT9tK2sEvBiahvNmcOYRpE=;
        b=QACHrZRNHUUAwBnxttDT6uZ9Zcc4vvtArvy1GFLSPloVBJMUVEsblEWnpkZU6S1OvU
         nfHZsqcER+ZwPNVT+KQHdtguiQQ5TTSqpf9JnibCWVJxm+6qgM2FQ/mlJMCfM2RV7txI
         /irBN+Xd0ZUpZ1+B0XRyDE8wKVetQDshB62s4bxCCM4R9GUSgH1Kqklqcz9uuGqEd0dY
         jg/ndFWm5zsicKRIrA/cQqsmdy1KqAe9A48ode91i/MZktsGsjrkw7BDdlU8jUasG2QH
         /EwkCldf9Sa4+ag8rTId3SCXHsNJlS61TSsyDmLqEZxSr1Yc5SmfYu2F6oyR6mNXHvU7
         NlOQ==
X-Gm-Message-State: AOAM532qMvvBesk8b0QJeDZR1xOf9+vlDtxza3xfiYv8TdiFzJNkVpPL
        FtllpMsCY+dFufsbzY5OzUM=
X-Google-Smtp-Source: ABdhPJxZsaHAf0Qb8FT+bruVPtYb4eIei4hOEcjJQePH4qpqYqYm9Y3pLVyEWDJOttMlM5V2tDjlSw==
X-Received: by 2002:a2e:9698:: with SMTP id q24mr20673795lji.246.1639257279017;
        Sat, 11 Dec 2021 13:14:39 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:38 -0800 (PST)
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
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 17/28] ARM: tegra: Enable CPU DFLL on Nyan
Date:   Sun, 12 Dec 2021 00:14:01 +0300
Message-Id: <20211211211412.10791-18-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
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

