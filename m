Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4F64E87BB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 14:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiC0MlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbiC0MlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 08:41:03 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA101F634;
        Sun, 27 Mar 2022 05:39:21 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p22so14018946iod.2;
        Sun, 27 Mar 2022 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K59qz1G2zKVvVRHr2vVCcwY/6us/MZyOmmgWHFWOKtE=;
        b=QbhmwVwkxWaKmxIFmg8ktSCUDcEJAfI6obT/CfofXbF8/YfPHUmD0hrILEdjTMl5pa
         /ixczP59Q45H0x1O5olB0Pop/q8oml5l/u4wGvz/k3kR+4V1Tc0jQsibBty/+rZVS3Zu
         GvKZ2wXJyQ/+tTcP5n3rnnSQJHFPC0EnA2L43AlJR4lBud+nCseacVC3fFKHtmpT6IDM
         EYC9rif9ZjDK+0sK72Zk5vL02Bq14sWeARWdQxZyxBtr7o1HCVFqNHmoYr2iRel5UE2K
         W9UFeZQgRGbkvwJQLSJ6lrbekNlOKwjXWi13aH0Qx7tGowpMd+3S9c0tGx5hpkJjSpdk
         BL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K59qz1G2zKVvVRHr2vVCcwY/6us/MZyOmmgWHFWOKtE=;
        b=awnuviyuVAH8Fe6ukyPBwuhF8o2e+pfzWlUiwcJ3WglSJt5pdADE16wPCw7LhSjT3E
         0z6K2NvECxEcgPCTtr9SdDdQhogAOALLzdqcX6FGocnB5cvlTyjkLx9r02ra9fUYDMYB
         n82oSFRLLaWOvyUBOPzy9PjRolLwl29oY67tlg6tm4rp1tiN51Ii44uv0YHoCtaaQYYs
         u9N7LLDmzXps2WOnmaLewWdKmf/U1cShoVeMhDiYGg7Dq8X1ArRXNb+a8Q9qRQA5hPMx
         Um0ob+cUxB1AEExQg+shWLqXC/j4bfHkQ18bM+PMXuD0/q2UFA5BQ9bh4myhflXumBCB
         kHzw==
X-Gm-Message-State: AOAM531MlYnfDA4WOxaEEhsgNAQxwZ+83gyiSW4gXh2yKSuk+gM4gPJz
        mZa0Yb3AsOklZVh4b/Tbb8zMXjlAD4w=
X-Google-Smtp-Source: ABdhPJw9+L+Qv1shPiCtCjTb8zGBkRjbKxf06+lFS0kJCnQMnE/mil0W9J+A5cCPpBQST3JuKvoJ6Q==
X-Received: by 2002:a5d:9955:0:b0:63d:a8e7:538d with SMTP id v21-20020a5d9955000000b0063da8e7538dmr3928050ios.207.1648384760591;
        Sun, 27 Mar 2022 05:39:20 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:7073:b368:2f66:5e36])
        by smtp.gmail.com with ESMTPSA id t7-20020a5e9907000000b00649d6bd1ec5sm6134534ioj.31.2022.03.27.05.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 05:39:20 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     haibo.chen@nxp.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64: dts: imx8mp: Enable HS400-ES
Date:   Sun, 27 Mar 2022 07:38:32 -0500
Message-Id: <20220327123835.28329-3-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327123835.28329-1-aford173@gmail.com>
References: <20220327123835.28329-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDHC controller in the imx8mp has the same controller
as the imx8mm which supports HS400-ES. Change the compatible
fallback to imx8mm to enable it.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 794d75173cf5..d5ee1520f1fe 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -769,7 +769,7 @@ i2c6: i2c@30ae0000 {
 			};
 
 			usdhc1: mmc@30b40000 {
-				compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x30b40000 0x10000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MP_CLK_DUMMY>,
@@ -783,7 +783,7 @@ usdhc1: mmc@30b40000 {
 			};
 
 			usdhc2: mmc@30b50000 {
-				compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x30b50000 0x10000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MP_CLK_DUMMY>,
@@ -797,7 +797,7 @@ usdhc2: mmc@30b50000 {
 			};
 
 			usdhc3: mmc@30b60000 {
-				compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x30b60000 0x10000>;
 				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MP_CLK_DUMMY>,
-- 
2.34.1

