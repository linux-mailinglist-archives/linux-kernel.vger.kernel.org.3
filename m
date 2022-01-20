Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB0E495556
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377624AbiATUUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377610AbiATUUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:20:03 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5F9C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:20:03 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d3so25908511lfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qHMBzi7x2OFj/PiKKy+8Sw+4QHkYBdO7GhGQ2rRzgfc=;
        b=gI7M7f4w9Ec64LvvhZiOGgyL7gfY6VYmyaDSqBfPbnnTqPNfKLfbtGYYcgPSGDu09O
         ngQL2ieRaz1PkOdds05NGuOilMz5knFBMJqinNGYh0MtKAocIS87ajzaXXHPl5Q5KgO3
         DCx3HRWdBYt4mxFiilHkTUFPomMpJADFOcWYnNu4rzg5ojF/ogLbU1TfKgNhtC2/reLp
         jWHR13SgrKtbuILwUCkCWAhfIZQVbhntEGczbf+POVCUb6J7Cx/157gD0grp9gvRLvwI
         1KLJnsljzfBKBnjCdmmwDP5fTU6CN/A0s/tp3lGG/vAyRVDPmAW/91krzC2KrLgXNm3m
         1VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qHMBzi7x2OFj/PiKKy+8Sw+4QHkYBdO7GhGQ2rRzgfc=;
        b=xqV3MNavCLvAabA85991i7gd0sAXy2xTKdEMC9tYpAIu6oHD5N9Yy1GJjNwjv3500O
         c6ojWzl9DvcvLFu5mi9VT6DqOEzhDO0+c5bStlFRQkLeS/2fkawbLrIKd+dBGsrVpVBs
         OWS47K0jx28AT+yHvkWpHPgiBRclwvQW/BgvHx5KMEuD7ab0pVNIMWRgUKx2meU8GKJT
         fBLQwnrVodsO22Q7GfiRjejvGj1cc23A8bEEa1Zku/ZfoD4ubh2eSJrmLD/afVg1+dGI
         U7JldtJD/pYc9b8KwzflkV/4RutLrpTxGYLdvKMNY366v1QRhCqenc3arC8nld4vRpHZ
         b3Bw==
X-Gm-Message-State: AOAM533AA0W+Pqz/kXubmdbA/0L3Ty8tShPbQPYjLD2DxZSCssxRSo5b
        dahFVdbSEZjnHDdd23zhz++HDg==
X-Google-Smtp-Source: ABdhPJz9MCqm4mf16pWvfozG0/iMnkcOzRIZ4U4OufHVSDiFa/AIkBn2S3ErqIBTk0WXuzurOufRsw==
X-Received: by 2002:ac2:58cc:: with SMTP id u12mr732654lfo.263.1642710001392;
        Thu, 20 Jan 2022 12:20:01 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id a12sm22620lfo.168.2022.01.20.12.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 12:20:00 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Hyesoo Yu <hyesoo.yu@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Jinkyu Yang <jinkyu1.yang@samsung.com>,
        Alex <acnwigwe@google.com>, Carlos Llamas <cmllamas@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        Erick Reyes <erickreyes@google.com>,
        "J . Avila" <elavila@google.com>, Jonglin Lee <jonglin@google.com>,
        Mark Salyzyn <salyzyn@google.com>,
        Thierry Strudel <tstrudel@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC 1/3] dt-bindings: iommu: Add bindings for samsung,sysmmu-v8
Date:   Thu, 20 Jan 2022 22:19:56 +0200
Message-Id: <20220120201958.2649-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120201958.2649-1-semen.protsenko@linaro.org>
References: <20220120201958.2649-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only example of usage and header for now.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../bindings/iommu/samsung,sysmmu-v8.txt      | 31 +++++++++++++
 include/dt-bindings/soc/samsung,sysmmu-v8.h   | 43 +++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt
 create mode 100644 include/dt-bindings/soc/samsung,sysmmu-v8.h

diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt b/Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt
new file mode 100644
index 000000000000..d6004ea4a746
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt
@@ -0,0 +1,31 @@
+Example (Exynos850, IOMMU for DPU usage):
+
+	#include <dt-bindings/soc/samsung,sysmmu-v8.h>
+
+	/* IOMMU group info */
+	iommu_group_dpu: iommu_group_dpu {
+		compatible = "samsung,sysmmu-group";
+	};
+
+	sysmmu_dpu: sysmmu@130c0000 {
+		compatible = "samsung,sysmmu-v8";
+		reg = <0x130c0000 0x9000>;
+		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+		qos = <15>;
+
+		clocks = <&cmu_dpu CLK_GOUT_DPU_SMMU_CLK>;
+		clock-names = "gate";
+
+		sysmmu,secure-irq;
+		sysmmu,secure_base = <0x130d0000>;
+		sysmmu,default_tlb = <TLB_CFG(BL1, PREFETCH_PREDICTION)>;
+		sysmmu,tlb_property =
+			<1 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x2, 0xF)>,
+			<2 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x4, 0xF)>,
+			<3 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x6, 0xF)>,
+			<4 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x8, 0xF)>;
+		port-name = "DPU";
+		#iommu-cells = <0>;
+		//power-domains = <&pd_dpu>;
+	};
diff --git a/include/dt-bindings/soc/samsung,sysmmu-v8.h b/include/dt-bindings/soc/samsung,sysmmu-v8.h
new file mode 100644
index 000000000000..2d422e05dae1
--- /dev/null
+++ b/include/dt-bindings/soc/samsung,sysmmu-v8.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Device Tree binding constants for Exynos System MMU.
+ */
+
+#ifndef _DT_BINDINGS_SAMSUNG_SYSMMU_V8_H
+#define _DT_BINDINGS_SAMSUNG_SYSMMU_V8_H
+
+/* define for fetchsize in TLB_CFG */
+#define BL1			(0x0 << 5)
+#define BL2			(0x1 << 5)
+#define BL4			(0x2 << 5)
+#define BL8			(0x3 << 5)
+#define BL16			(0x4 << 5)
+#define BL32			(0x5 << 5)
+#define BL64			(0x6 << 5)
+
+/* define for prefetch in TLB_CFG */
+#define PREFETCH_NONE		(0x0 << 1)
+#define PREFETCH_DESCENDING	(0x1 << 1)
+#define PREFETCH_ASCENDING	(0x3 << 1)
+#define PREFETCH_PREDICTION	(0x5 << 1)
+
+/* combine fetchsize and prefetch */
+#define TLB_CFG(fetchsize, prefetch)	(fetchsize | prefetch)
+#define TLB_CFG_DEFAULT		0x0
+
+/* define for direction in TLB_MATCH_CFG */
+#define DIR_NONE		(0x0 << 8)
+#define DIR_READ		(0x1 << 8)
+#define DIR_WRITE		(0x2 << 8)
+#define DIR_RW			(0x3 << 8)
+
+/* define for TLB_MATCH_SID */
+#define SYSMMU_ID_MASK(id,mask)		((mask) << 16 | (id))
+#define SYSMMU_NOID			0
+
+#endif /* _DT_BINDINGS_SAMSUNG_SYSMMU_V8_H */
-- 
2.30.2

