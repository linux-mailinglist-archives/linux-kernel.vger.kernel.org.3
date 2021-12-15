Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE165475CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244373AbhLOQJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbhLOQJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:09:11 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB396C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:09:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i22so9269027wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KL+cXQOYHhgidLM99dBCGy7kasZp0rKjTyY/gJtJdQ4=;
        b=y8OFNhUhalw6dCnqhttyPc1loZ+a6yM7hPgHfwf/zzTxlb/e2CY2RuKlWGjhgYaE6v
         vcJGFyRkwfApsMyCM1O5sfdXl9HZxQqPIFRWK0skOyrfohFCtB1vyats1J3XJvOKJE17
         g+ApLOmgkApwL93FpUDuSqgnNJ9VxLos2mi+TZZSZZ11S9X/taLesFeV0BXTxR9GK3Mx
         91h3rBJZeHaPSmr/vFwVE/Q/G6AX0hpRXYX7wrVUZzcDPhMK0MIswciWhSpMSH5xE6KV
         vIDpqQiW0PHRTObe6ep/QA8XbKyqn5BC1iQo6PRRK3bjlCyD7XgUqA3pGYKKo4cb3lR6
         gRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KL+cXQOYHhgidLM99dBCGy7kasZp0rKjTyY/gJtJdQ4=;
        b=fssmTmBiYmwoxaOXQnAi4uZbnzpw5MZuG5B07zQIlYkeDkTAdam/5rikFJRQzxO6q/
         +c4/CLOTPqoqtfMYwnv2RahGeKca2Yatg4YgMs4HYsGd/SQn+Ox8ZlPIaRX0+dRO7zJN
         7R/ggnk/gG4WLncWw1onO3ON3vdDZKt8I50WIjEH07Vt5iJsc9QtzSdRPrVPGRyeDPOE
         PVh5I34adi5gmud3kf1ZVTh0ZCeq82cTtmSS7C9TJ69B2pEtzLgXlveaUfWIwKM7J330
         NI+as0ezK7ZZKBWfm5mMDuZKcwxMHb8N1w7toG/k9WEtNf4wA9bjeodzopZkCLxyRBea
         Pqzw==
X-Gm-Message-State: AOAM531ZufBeO8fIuxC2cbrAHuRdS03aVWpfoRLaYkyal9EbNMZcqM/M
        XywFsDmpbL81a2rQClELeJ/ABA==
X-Google-Smtp-Source: ABdhPJzI/8F7NVrR3KoZliYvQkXXBgNWU0AHAc90dSYraoyq1lzYYAdKv96ceNEMLBBFwLAMrR/aRA==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr4829932wrt.419.1639584549238;
        Wed, 15 Dec 2021 08:09:09 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id f13sm2720882wmq.29.2021.12.15.08.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:09:08 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: clock: exynos850: Add bindings for Exynos850 sysreg clocks
Date:   Wed, 15 Dec 2021 18:09:00 +0200
Message-Id: <20211215160906.17451-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215160906.17451-1-semen.protsenko@linaro.org>
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System Register is used to configure system behavior, like USI protocol,
etc. SYSREG clocks should be provided to corresponding syscon nodes, to
make it possible to modify SYSREG registers.

While at it, add also missing PMU and GPIO clocks, which looks necessary
and might be needed for corresponding Exynos850 features soon.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 include/dt-bindings/clock/exynos850.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
index 8aa5e82af0d3..0b6a3c6a7c90 100644
--- a/include/dt-bindings/clock/exynos850.h
+++ b/include/dt-bindings/clock/exynos850.h
@@ -82,7 +82,10 @@
 #define CLK_GOUT_I3C_PCLK		19
 #define CLK_GOUT_I3C_SCLK		20
 #define CLK_GOUT_SPEEDY_PCLK		21
-#define APM_NR_CLK			22
+#define CLK_GOUT_GPIO_ALIVE_PCLK	22
+#define CLK_GOUT_PMU_ALIVE_PCLK		23
+#define CLK_GOUT_SYSREG_APM_PCLK	24
+#define APM_NR_CLK			25
 
 /* CMU_CMGP */
 #define CLK_RCO_CMGP			1
@@ -99,7 +102,8 @@
 #define CLK_GOUT_CMGP_USI0_PCLK		12
 #define CLK_GOUT_CMGP_USI1_IPCLK	13
 #define CLK_GOUT_CMGP_USI1_PCLK		14
-#define CMGP_NR_CLK			15
+#define CLK_GOUT_SYSREG_CMGP_PCLK	15
+#define CMGP_NR_CLK			16
 
 /* CMU_HSI */
 #define CLK_MOUT_HSI_BUS_USER		1
@@ -167,7 +171,9 @@
 #define CLK_GOUT_MMC_EMBD_SDCLKIN	10
 #define CLK_GOUT_SSS_ACLK		11
 #define CLK_GOUT_SSS_PCLK		12
-#define CORE_NR_CLK			13
+#define CLK_GOUT_GPIO_CORE_PCLK		13
+#define CLK_GOUT_SYSREG_CORE_PCLK	14
+#define CORE_NR_CLK			15
 
 /* CMU_DPU */
 #define CLK_MOUT_DPU_USER		1
-- 
2.30.2

