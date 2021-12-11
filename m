Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080D9471687
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhLKVPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhLKVOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:38 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8520CC061A72;
        Sat, 11 Dec 2021 13:14:37 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id k2so18468869lji.4;
        Sat, 11 Dec 2021 13:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GaDrIMpgT6ehw+oYiizpPLZzCqnLOIYK1wjey+O3h34=;
        b=ldPE9sEZ5OHLyblOF8Vcuw8CxtSHIv8bKumQMS978+JtsRpJNiKHyi9QA/wAlzYONk
         oo93eCrgtw33bUg34eSyOTdU/cBKyXYjrE4qJteRTK719YkifDlTripQQ7FG/uFYzdc8
         KqIjrmkrgE/2Ddq7iGbuQzMsC4PlmMjAuTaW9WMUszXQp/ryNLywBfIihY+wMGh7de92
         7iaw/Wcjpa6PskiCA1AVg1KxkAgZ3VeTYF4haJ7wFWosdbyuSE4wvNjD6nt1GMMXQ0jP
         QPdX1acHibriX65Ro/mB+55fF+w4lFIFurDAjcGP4D+LrCZEDJTGyBB3Eb3UWOgmCxrl
         Hjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GaDrIMpgT6ehw+oYiizpPLZzCqnLOIYK1wjey+O3h34=;
        b=dbio4Zsm2SBTmdqx1c2+MeGqwlDWUBkeGZvame09XWDKHeb7/QWaNfg3eO/H/bBpwS
         Ebi9QsN96JBxVqHrno7txOXAEb/C2QrCisCk3SLy2HkPJjpv23XZWJ5pJva3GFEJvUDo
         eVwTHnf5VZfk5PYhbU8UqgxG7Pyu2ZHVkjcrtUw72KDtPqseTzYObccnG1XcoA/CGTtc
         v/nvOh9D1LZS8yS5J8DiNdINTQ26YFglkFBJ5sa2m2HsPwqwz7rlBzzXEKXXwYF41RwI
         /KiVcKG0T6EqxAN3uqbs6Cw5hsmLQTpSlEhOjT8JgWfWxaMDhkipCzAoyEsWVDImYLst
         B8Qw==
X-Gm-Message-State: AOAM5314Xe1nbYB/sb4jadT5QS+RrdXWISID0Iuq/9/7T2ueNQSrxQt/
        CjjHfK8+fVSbA7T9SLgGiJc=
X-Google-Smtp-Source: ABdhPJzNeF/xCpgaw7jcDZZ7aU/OK0rkHrzzk5uHTln6kLGhOpTQ2CRWhiJ7Nv2Bw0peZOLEb4/TkA==
X-Received: by 2002:a2e:bb98:: with SMTP id y24mr19486001lje.315.1639257275847;
        Sat, 11 Dec 2021 13:14:35 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:35 -0800 (PST)
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
Subject: [PATCH v6 14/28] ARM: tegra: Add device-tree for 1080p version of Nyan Big
Date:   Sun, 12 Dec 2021 00:13:58 +0300
Message-Id: <20211211211412.10791-15-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dedicated device-tree for 1080p version of Nyan Big in order to
describe display panel properly. FHD panel doesn't support modes other
than 1080p, hence it's wrong to use incompatible lower resolution panel
in device-tree.

Tested-by: Thomas Graichen <thomas.graichen@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/tegra124-nyan-big-fhd.dts | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra124-nyan-big-fhd.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 26798673739c..561e0eae05a9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1341,6 +1341,7 @@ dtb-$(CONFIG_ARCH_TEGRA_124_SOC) += \
 	tegra124-apalis-v1.2-eval.dtb \
 	tegra124-jetson-tk1.dtb \
 	tegra124-nyan-big.dtb \
+	tegra124-nyan-big-fhd.dtb \
 	tegra124-nyan-blaze.dtb \
 	tegra124-venice2.dtb
 dtb-$(CONFIG_ARCH_U8500) += \
diff --git a/arch/arm/boot/dts/tegra124-nyan-big-fhd.dts b/arch/arm/boot/dts/tegra124-nyan-big-fhd.dts
new file mode 100644
index 000000000000..d35fb79d2f51
--- /dev/null
+++ b/arch/arm/boot/dts/tegra124-nyan-big-fhd.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra124-nyan-big.dts"
+
+/ {
+	/* Version of Nyan Big with 1080p panel */
+	panel {
+		compatible = "auo,b133htn01";
+	};
+};
-- 
2.33.1

