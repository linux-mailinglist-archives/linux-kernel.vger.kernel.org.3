Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CC546561D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245104AbhLATIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352125AbhLATIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:08:24 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A4BC061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 11:05:03 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id k37so65496128lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 11:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RUQx5kq3VrQOJzLJrHIG10H6hCDxVpxGzWKF98as5kk=;
        b=In8k5sq2384AcnFdRb15c2gEmINBS3KJi7PU5aATZmmOIwm71wY+dCo1UfvvCI8ubY
         JrQ/3mNIyh5OOfqFRcY9UCd8oSyhc1xh2Hpi7AMODLgBd2wdhiTIEkHae6+aks0/0TwF
         FYsmK/fu3LQa/TvYW3yTnL6PTiDnFX5+FGMKgA+K/G/y+7iwfx/Iu7gJ+oLFTNmwhoyz
         ZFdMWczP+U08BUVaO33E/meDGAYiFL22EwDK/QFaCnjmleEA10M7HnVLI/rWH+15Ob83
         69+p04MC0BRa9jrE+tT0vrdcuq1CdRN4Q8nBf1UMHkGHjAf+VyPvTmYxwM3OK8CFund8
         IiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RUQx5kq3VrQOJzLJrHIG10H6hCDxVpxGzWKF98as5kk=;
        b=n8x4axRkxjChivkmyqW0W6+r4WoWJX1DXP+C5soL1vYGWc7X1quSFpDHc9Juwa7x2m
         YCrDqqoJctEfZP+qg4QDPTs8ux7N7+pEjStwopYNxje6jJZvj3fyk/gxebXBEfwyP07e
         A4B/f8Inj/dqlP/i0DaitODHfLX5Z/b79O9Ekx/aFEspW5aHhVkx888SMejHNS8gnu1r
         tZOzX2Les9hNlJTUdBEdG2KyGj5fuDp5S4WSPkcVsstYBEsb19hnjqRVhpnYEeHDwhvy
         JwNKEA3WRe5TRc0GfC6cAHqRMPjONQNg1ukRLF4BRW1/std8r+VPDthNZEvb04o+a6rm
         k3vg==
X-Gm-Message-State: AOAM530PZnBoIHTz8hXb/QvFTRS/InpvPEwLvO/XtStuIrEvAGpbVrzR
        dnPWu67zdwyqJMXYYFcX3tHznw==
X-Google-Smtp-Source: ABdhPJyXfA1Aj/HuZe6HAzGr6uRY6CRxqJOxRkA1rtTvcyqa/VFMR4R6HUAfwPmKzWFpso4Sn5/UEA==
X-Received: by 2002:ac2:42c6:: with SMTP id n6mr7403216lfl.553.1638385501381;
        Wed, 01 Dec 2021 11:05:01 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id e20sm71103ljo.119.2021.12.01.11.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 11:05:00 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: i2c: exynos5: Add bus clock
Date:   Wed,  1 Dec 2021 21:04:52 +0200
Message-Id: <20211201190455.31646-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201190455.31646-1-semen.protsenko@linaro.org>
References: <20211201190455.31646-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In new Exynos SoCs (like Exynos850) where HSI2C is implemented as a
part of USIv2 block, there are two clocks provided to HSI2C controller:
  - PCLK: bus clock (APB), provides access to register interface
  - IPCLK: operating IP-core clock; SCL is derived from this one

Both clocks have to be asserted for HSI2C to be functional in that case.

Modify bindings doc to allow specifying bus clock in addition to
already described operating clock. Make it optional though, as older
Exynos SoC variants only have one HSI2C clock.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-exynos5.yaml          | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
index db20e703dea0..a212c1d5e7d9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
@@ -49,11 +49,16 @@ properties:
       clock-frequency is >= 1MHz.
 
   clocks:
-    maxItems: 1
-    description: I2C operating clock
+    minItems: 1
+    items:
+      - description: I2C operating clock
+      - description: Bus clock (APB)
 
   clock-names:
-    const: hsi2c
+    minItems: 1
+    items:
+      - const: hsi2c
+      - const: hsi2c_pclk
 
 required:
   - compatible
-- 
2.30.2

