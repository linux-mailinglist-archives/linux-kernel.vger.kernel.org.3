Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B923948200E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbhL3Txi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:53:38 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33610
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240534AbhL3Txh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:53:37 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0E2A33FFD5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 19:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640894016;
        bh=IkNBdPvO0WBW1RMTehOrcXz9DKxSm9w/tT6yjAM5hts=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=rvaDyOSc7lds38C85NqaSixNsCIT7U3JnO4Sa6Zlk5WMGZczqBpvM9oHlt0drvDj3
         UXGrgMaxw0NxWmnaImrUsycLc01PFHCMxuv0YRtpP/pxnHOdYKM+AD3E6pPSpXsWO4
         9mPcLlOjHPrxQGsRNpreODkmsQk10TarZhE3XOraUeZCUVlyZfC/QjxrYZq5WzZmH8
         TeKHnbs8vuRID+aDsmI5fT3NanDdBMYqHbpQC9h0ouSUB07oiXSTZ1MOWThfHJ7t7a
         KHB7OBVO5vxPOBvhgUhZoiV5AllwaLlKj+cGcS0z3dAHl1+s9PR/5zUEXLZBrNxKOn
         SiMPzucWiZycg==
Received: by mail-lj1-f199.google.com with SMTP id y4-20020a2e95c4000000b0022dbab5f69eso5729293ljh.14
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IkNBdPvO0WBW1RMTehOrcXz9DKxSm9w/tT6yjAM5hts=;
        b=DY2LrKyvLvEG0tIHX299qnmwFiHKaqvo11Lst1hPF5Lty96rEJ72TWVbC0DuxqWzL0
         ILMPYCAcS05zEAmAWKk2Rxn9WUgP+XyzfPHOrXD8384u/9N6YLBaUJT1DA0SskH4xfk8
         Bb78sMEr7WIdVW+Se4IAVp1IAZG5wqZuMfyRdJxHLqofvYtDXpuZnU8DgMe7P2Yy5UXD
         uWKLtTc1XuWAWcSl4FQB+VVM9wBoWLXlw5/93hXdi5bickFGsPZIgCRCAEGxo+ZR3xuz
         KtSBIuJSGOwVipIuJWorKi3HhLD6awg3ALnerPPZhz1md6/TF0pXk0lEefIkOAba/2dz
         ezmw==
X-Gm-Message-State: AOAM532vO4FDf08Rj8sztux8pzS0E5WsMNFK3gG6Q4IClQ7Kuw+5l8OM
        HbOtWU+ejSoYPrYCO/zzoCHB/lLeVGbvcO0qt3lTxTdmeIcbGNpbHdYFmS1PDG/6Z0JqF6UExoo
        UHM4+IMy3yjXNOiWTPUGNDFYKTC5edve0dzd6vOdkrg==
X-Received: by 2002:a2e:b818:: with SMTP id u24mr20156774ljo.426.1640894015356;
        Thu, 30 Dec 2021 11:53:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCxn9v+74EYdO2VRQPTiHMdXaG/xqPgeB6RVZO0ch93m20tllLyIOYqIKVcNZ6kp/IBgkQ1w==
X-Received: by 2002:a2e:b818:: with SMTP id u24mr20156769ljo.426.1640894015212;
        Thu, 30 Dec 2021 11:53:35 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v9sm2454505lja.109.2021.12.30.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 11:53:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>, stable@vger.kernel.org
Subject: [RFT][PATCH 1/3] ARM: dts: exynos: fix UART3 pins configuration in Exynos5250
Date:   Thu, 30 Dec 2021 20:53:23 +0100
Message-Id: <20211230195325.328220-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpa1-4 pin was put twice in UART3 pin configuration of Exynos5250,
instead of proper pin gpa1-5.

Fixes: f8bfe2b050f3 ("ARM: dts: add pin state information in client nodes for Exynos5 platforms")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
index d31a68672bfa..d7d756614edd 100644
--- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
@@ -260,7 +260,7 @@ i2c3_hs_bus: i2c3-hs-bus {
 	};
 
 	uart3_data: uart3-data {
-		samsung,pins = "gpa1-4", "gpa1-4";
+		samsung,pins = "gpa1-4", "gpa1-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
-- 
2.32.0

