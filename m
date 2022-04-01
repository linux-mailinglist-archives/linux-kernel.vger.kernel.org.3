Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6B14EFB67
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352320AbiDAUW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352017AbiDAUVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:21:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C5CC0A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:18:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i132-20020a1c3b8a000000b0038ce25c870dso4253775wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Te9hYO9YZcBZwbAvVyltxpv/8oWnq+ebPbFSU+ms3XE=;
        b=kYaQkzXlrUl/GeXdh2ja+IJnTXgTt9vr39v0ACWppltl2of4ARaWH5Sdc7lA6+G8It
         +1l+tqqE4lLFy52g4PSpAXb21P3P+gSKKhXzOKvU0v3PRLXcp+ICJ41tFTtSWrE4HfWJ
         P0hD5tgea7xJKJvZvAga4d01UQsjKxFQjeki4LGXOIQiq/F31eeUXBuiC2yMUiSkYf6Y
         g6SqEzI1Ara4MAPQZjfeU5HsuC0mhRc8gsr87BQ3a7FD1PEi3PWL8olqr+0Xoq6Gc+sm
         /7CbRNuW+5FojFEHQ7UVF/XjR5eLgd0mSmIw/qq6RAs0zfESJMC9N4k5awwaj3GznQ6M
         heGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Te9hYO9YZcBZwbAvVyltxpv/8oWnq+ebPbFSU+ms3XE=;
        b=ezydPfWwp8JLnq2LniihW8kyPRyN1eD3sn8eU+vz8RkaLukxVjTe7qnHcz7i65QJHU
         dqa6ASRGy0YuYHm6xgN1BzDfrFIvpihW+wY17Rjguud5ABP27Si7yFXjXiV0nM0W6Nd0
         SWGd4y1nti3UzuOoDSCNBbF390l2WCBI+PKVSg9lIGKKWKwP2NQEKTAiINuZQuAg1QST
         tcTROWntvU8ZIuKBF2q0iCrrTi+82b8D9ZrgdNTz4co+99Mox+zK//MjsrHHLnI5Os1Q
         K47W602MYzOvRCVl3Mtr5GyazsNWpCHjIk7sFLQD9xQiqvTESHAZzeRr0ZkWbHvmKve8
         Suvg==
X-Gm-Message-State: AOAM5318a8CkbHrtPHvq5yZpq2s8DaSzwdnzyIYCFIqBCfyXU2CW86/D
        Fd/iYQjvBeMPCFKFwo0+VmUgrg==
X-Google-Smtp-Source: ABdhPJxdHOjOzDXGrlocz4uXluHwgPsZ16qcP0nDaXk1Xo6D0gpcFlPR+Qz9YjXxabmjgLAGrxk/Fg==
X-Received: by 2002:a05:600c:510e:b0:38e:346f:8a46 with SMTP id o14-20020a05600c510e00b0038e346f8a46mr9870650wms.153.1648844313554;
        Fri, 01 Apr 2022 13:18:33 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm17823838wmq.27.2022.04.01.13.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:18:33 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 31/33] arm64: dts: rockchip: add rk3328 crypto node
Date:   Fri,  1 Apr 2022 20:18:02 +0000
Message-Id: <20220401201804.2867154-32-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401201804.2867154-1-clabbe@baylibre.com>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rk3328 has a crypto IP handled by the rk3288 crypto driver so adds a
node for it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b822533dc7f1..e83e0bf7e517 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -1007,6 +1007,16 @@ gic: interrupt-controller@ff811000 {
 		      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	crypto: crypto@ff060000 {
+		compatible = "rockchip,rk3328-crypto";
+		reg = <0x0 0xff060000 0x0 0x4000>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_CRYPTO_MST>, <&cru HCLK_CRYPTO_SLV>,
+			 <&cru SCLK_CRYPTO>;
+		clock-names = "hclk_master", "hclk_slave", "sclk";
+		resets = <&cru SRST_CRYPTO>;
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3328-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.35.1

