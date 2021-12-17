Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800DD47825A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhLQBqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbhLQBqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:46:24 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D733C061746
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:46:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id t3so1416800lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWZ3VqkixP63yliHPRMo0MEnH6Ek4K9Uct53tM9/STk=;
        b=lMawe/RE1stZKCZShVm5Wq0mSwUp6FaAr7qucwfjfd+l38p2E8+TvLTfAh943WJOwm
         CjfN0Txt8nL2iYgjIk3W2jGm2Tfp8TS5XQZfSiS6+P2z6leHbLdc1JgVX9SReIlAUWBE
         G5v22EUi1EeC31WXFZrj/mEmV7Gzfg20rtOb05pPpJm4jxAoksc3yQ0aHOmwS6HyOS5v
         +wdluBZUOmkOJhg1hQDD/bFROQKCx8T8gpJIofYKmaYlkzCvq/TtIEAq6bYnqa/zKinK
         fA7mGT5B336t82jlKhUk0HwJ1dozxg89lOh8LcSfeQGXnNZsLR+dWqJIK34YVaavs9O3
         80tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWZ3VqkixP63yliHPRMo0MEnH6Ek4K9Uct53tM9/STk=;
        b=2BQYxLHm6IeM+JXfAbM9E+UnMaqCYbUeDPP/Y3KwiRPVNaEP0ft92E6LCUmEXfJUCy
         xvsrDJs/fQTyCOGk8HMLjg0nZ18ATTaTTzg/4H0J0IVwSus9Pz1c6KbVwv9e9tJvXISF
         8HYnwW/r4nzg9zl9seBL9um7Q0y0ej4YtBfVcGO8e3FznMhNmxT52+wKRRErc6HplaGe
         bnb6D8k3aeUXCJ6m/Tq4VfKJzEUr6xUR3QEJKza63zFiihafs3SPnzzfs4e6u2Q2oHQP
         8u50A88+/dTKP7cpt+VWKPKgDax+l1pzQluPByJtvqC8XXZmZjQQerpULnomH+9rq9iZ
         slKA==
X-Gm-Message-State: AOAM532TkBKiBBsd0O6GKzQEE8N7JLIMp3bSAPMVQZVfUJ1q1t1141Ro
        g0Mb9Mk8KQ3FtjnKdOaHYY0uWA==
X-Google-Smtp-Source: ABdhPJy5rDebfQs5ETfUVCgzouJfn9mYo78YMAaM/Gst/TZOyIs7CIxL06vNWf3rPxCu/0faVXTLcQ==
X-Received: by 2002:a05:6512:2098:: with SMTP id t24mr779816lfr.289.1639705582641;
        Thu, 16 Dec 2021 17:46:22 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id bq36sm829621lfb.42.2021.12.16.17.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:46:22 -0800 (PST)
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
Subject: [PATCH v3 5/7] dt-bindings: pinctrl: samsung: Add pin drive definitions for Exynos850
Date:   Fri, 17 Dec 2021 03:46:11 +0200
Message-Id: <20211217014613.15203-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211217014613.15203-1-semen.protsenko@linaro.org>
References: <20211217014613.15203-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All Exynos850 GPIO blocks can use EXYNOS5420_PIN_DRV* definitions,
except GPIO_HSI block. Add pin drive strength definitions for GPIO_HSI
block correspondingly.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - Added Ack tag by Rob Herring

 include/dt-bindings/pinctrl/samsung.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/pinctrl/samsung.h b/include/dt-bindings/pinctrl/samsung.h
index b1832506b923..950970634dfe 100644
--- a/include/dt-bindings/pinctrl/samsung.h
+++ b/include/dt-bindings/pinctrl/samsung.h
@@ -36,7 +36,10 @@
 #define EXYNOS5260_PIN_DRV_LV4		2
 #define EXYNOS5260_PIN_DRV_LV6		3
 
-/* Drive strengths for Exynos5410, Exynos542x and Exynos5800 */
+/*
+ * Drive strengths for Exynos5410, Exynos542x, Exynos5800 and Exynos850 (except
+ * GPIO_HSI block)
+ */
 #define EXYNOS5420_PIN_DRV_LV1		0
 #define EXYNOS5420_PIN_DRV_LV2		1
 #define EXYNOS5420_PIN_DRV_LV3		2
@@ -56,6 +59,14 @@
 #define EXYNOS5433_PIN_DRV_SLOW_SR5	0xc
 #define EXYNOS5433_PIN_DRV_SLOW_SR6	0xf
 
+/* Drive strengths for Exynos850 GPIO_HSI block */
+#define EXYNOS850_HSI_PIN_DRV_LV1	0	/* 1x   */
+#define EXYNOS850_HSI_PIN_DRV_LV1_5	1	/* 1.5x */
+#define EXYNOS850_HSI_PIN_DRV_LV2	2	/* 2x   */
+#define EXYNOS850_HSI_PIN_DRV_LV2_5	3	/* 2.5x */
+#define EXYNOS850_HSI_PIN_DRV_LV3	4	/* 3x   */
+#define EXYNOS850_HSI_PIN_DRV_LV4	5	/* 4x   */
+
 #define EXYNOS_PIN_FUNC_INPUT		0
 #define EXYNOS_PIN_FUNC_OUTPUT		1
 #define EXYNOS_PIN_FUNC_2		2
-- 
2.30.2

