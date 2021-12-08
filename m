Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7989246DA0D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbhLHRmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbhLHRlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:47 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD7BC061A72;
        Wed,  8 Dec 2021 09:38:15 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bi37so7050447lfb.5;
        Wed, 08 Dec 2021 09:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GaDrIMpgT6ehw+oYiizpPLZzCqnLOIYK1wjey+O3h34=;
        b=Pqo4Jd4O/HLoDGruXyCJAP/za85iFZ7p1Cj2aEhHYVfr3yklT/BO6xdMYXQh/BUsuf
         VB1nfPHvFkY1flL2gEZo9n6GFFSh9jkjSGm72iPHeurwf1rg/Id3Kl6UzG5DuqEFJXqF
         LN+QQE+ke8PEsjJkvK0TG19RICoaYtjNiHYav2GWEp3GOaSoRi0y5LRHXmqt9GmFG/bJ
         v5qooCS/Ax6u7gYzc3+IE91e9pWpYNlVJjE4Q/wO5wazfZhtYxuYAUXfwdxyDL16FaS8
         Gi9K/fpVu0diwrlOHNm2J5o1u1WvQiS1mLSu69Q35cQV20aigf0eIjpY2AjiLeAp6o1P
         Mq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GaDrIMpgT6ehw+oYiizpPLZzCqnLOIYK1wjey+O3h34=;
        b=XLsEtxKzw0pnqtHhA6MO5/RbShp3dTZGeNAVa8L5Pd4MPJjoTbnG2lsO/HXaAeVQwP
         XI2lVlb2YwwiYVzHNlROiFOp6y2c8Lsx4yov7LI2B32jEyArorJ+Rtl0iJYQVxmrarL8
         o/I08qlmwXTFyuRgvaGwis3qVmppkTftbiKRgkPE74oyKx6A/j95Ydq5kcTdIxVz5gK/
         hdJ3d95A/FqGlBjuI5cUSS52wg6kx/ZcPX4E+nKA9ZNqN5CJ5lZX8EJXZ4sGW90TWqI/
         WWoHx7HGCcckOUOL1QnIn0DKjo+2LdifZmBWqws22bXPPty+oGIRJBy/UMh/a7ELzq3a
         qDKg==
X-Gm-Message-State: AOAM532oSjU2xftcHP3Jz8Zm8GqADlS6eCdb8wl01ibygtLKBl97CIav
        X3/9iSoDgg0T4i3cejoekp0=
X-Google-Smtp-Source: ABdhPJwGqakbrEhveiiGGmkeiW+6iFJ97HNrKf2Gb+PgPAZpBvxKdD4z4ivIj0Ev7FJkisaC+KkSgw==
X-Received: by 2002:ac2:464f:: with SMTP id s15mr839062lfo.590.1638985093728;
        Wed, 08 Dec 2021 09:38:13 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:38:13 -0800 (PST)
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
Subject: [PATCH v5 14/24] ARM: tegra: Add device-tree for 1080p version of Nyan Big
Date:   Wed,  8 Dec 2021 20:35:59 +0300
Message-Id: <20211208173609.4064-15-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
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

