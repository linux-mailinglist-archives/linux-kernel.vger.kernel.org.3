Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5954641A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbhK3Woh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344695AbhK3WmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:20 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E45C0613D7;
        Tue, 30 Nov 2021 14:38:56 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id t26so57638324lfk.9;
        Tue, 30 Nov 2021 14:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GaDrIMpgT6ehw+oYiizpPLZzCqnLOIYK1wjey+O3h34=;
        b=JNuBegogz4rG9mT5/zVUHwHZhsuXa/21y9CRXOavsDLTVxHIduJQtebT0x84hStezN
         fz77DAcHyY6/UWaEAvcnv0V6KhpJcYiBslAfDH4oW0HysQ6sc96nAUsHlRnyCAxlWQMR
         8y2lvIkvKbybgwOxkdI4ISEZ54Cs071sjyjPlW2PWu2ediikDfh1dasIALj+oTCDd8ou
         PG7sEHZP+EVcamAIF54Dyh8BiOY94P0Cw/8jaJEbl2EBdZllItf0u58N11UQZ521lHXZ
         +M2/u6rGjpoTXNqengbl6B1PS+b9So2dSybYSLwFS2Wnj0D3vr8iIHxq0Tzg3z2A1xpR
         qnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GaDrIMpgT6ehw+oYiizpPLZzCqnLOIYK1wjey+O3h34=;
        b=G9e4XRBdkmiNO+Ss+TbWSkffgElzwcq9jDITIbKYWMF3IH0hAjWR4GzOAPzfokpuhp
         n0JxFbFdb8mxFQ9Yhcmx1YtLjFs3m1j9XL3OQx1Mz+n+JOSWJZC046xeocH/drLg1bd/
         ltsd2AkJ7oRUj5n9q2Xm28Fq78H/vt4+hUhAmjlNPE2T/+S5zfQKVAq3+OO7hFFAtbHX
         jE0PFWp9rB/Xln2yMjDAmRDRKCEuKzFP/K3hqesfUt5df2C0mGDt+URBp/yezHM4Sg4Z
         t1F/aMZiYHkrpaP4/4uSJ6UZkPaMTEg4qxz/7t3ACFEc+YeWppjon1Inmz/QAMvI3PZJ
         uHig==
X-Gm-Message-State: AOAM531lcE3/wv7PDMcO6Gi9+Yy9w2GQ53Qnfn9qJoxRkpaw+aJCNzJU
        Qs2of23RvBAn/uCbMtJ0oY8=
X-Google-Smtp-Source: ABdhPJxD/YjGVrBujYBOFTuuYvwM1Q6sJZuAzAGIQqBXE3Q0YNp0688DPxO/wczO+Jxs0rhOgz32Ww==
X-Received: by 2002:ac2:418f:: with SMTP id z15mr1819557lfh.213.1638311934611;
        Tue, 30 Nov 2021 14:38:54 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:38:54 -0800 (PST)
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
Subject: [PATCH v4 14/24] ARM: tegra: Add device-tree for 1080p version of Nyan Big
Date:   Wed,  1 Dec 2021 01:38:10 +0300
Message-Id: <20211130223820.23609-15-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
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

