Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52A4F05E4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 21:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbiDBTmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 15:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346869AbiDBTlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 15:41:49 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C075BD03;
        Sat,  2 Apr 2022 12:39:57 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id r11so4201001ila.1;
        Sat, 02 Apr 2022 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WinkjzPa9wNFBdfy3cxVUCM43zQXmo5BiQJvI8WCurc=;
        b=ASj9IEj8cG/7QQLiAkmWuFhJL9OADrLLXAirU/FwNlgk4qxOvQSyAXFP9bbGzv4u66
         8NgyjVZkcDheQ1H98yr54cxU+ipQ/S2TmKXypASk1SsFJ2DoUoX2pLwWHkbVPPPuAFFe
         wmmTqUWmx2K3eTkhH1d6+Y7QBR878pVUvx6iyE4tnHMbAr1jtEum2U3cZ72+KQjAApzC
         T/27MuFH20Ztrk6eXO5a0TmadOKckTj7zae3bRMkmLGjgdvS7hwSmxhvLz1LdiqFcwqt
         uaTNhKoiRHF/Fk85+6TQ5H373UeSCuFshnQeqZeGo0+pxSP/Gt+WRBvyCoVojS7/A+qY
         qE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WinkjzPa9wNFBdfy3cxVUCM43zQXmo5BiQJvI8WCurc=;
        b=wX2GEi0m8eTgRCnCpkOe7S/r+uVQH6pWgS+YcUyBqscY7zImLB0GaSFWn26RK5X4Ds
         8ZrjntCm9PN7V/W8egYcudh+9EjbyZFSOZCzyPZiRBRRNYSM3QD07eHn+go/gO/EKX+M
         NHbsUdTWbhAWUsUkvkq3Jt6GqwlQATmkJNo7MTSacfvuYXNfxJ1XowR2wBtgcDmPiIlQ
         ssC3x9ewIDGN1x4+fFYllPAbtMbDhToiHFFBroVZ6i53AQodbtz7PHfZG6qTXLkVmdZJ
         Ip3Jl3J5BVvd5LSjyeHwaQ/5M3+hSfWLLcNN7a8b9yc7vEiMRb6X/oNIA9zZnSQS3Mqd
         ysbA==
X-Gm-Message-State: AOAM531rbVRKekzIF8jiIctitx0m4t3jdx4tWb47b/XoBe8qyDqZ/ssq
        nDTbnUexJa8H5v2a2MCzamm4CFVTli1ZmA==
X-Google-Smtp-Source: ABdhPJwQphokNGlMTGeK1MygO57M1D4ndFS+PkiMH7OKaVbdkJR1seQDISbuD/XZnllVbdeqZ5IuAg==
X-Received: by 2002:a05:6e02:1a2c:b0:2ca:2f11:c60b with SMTP id g12-20020a056e021a2c00b002ca2f11c60bmr762906ile.75.1648928396410;
        Sat, 02 Apr 2022 12:39:56 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6ab1:a455:ad1b:e8da])
        by smtp.gmail.com with ESMTPSA id a14-20020a056e020e0e00b002c9e2f0fd76sm3261756ilk.13.2022.04.02.12.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 12:39:55 -0700 (PDT)
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
Subject: [PATCH V3 3/3] arm64: dts: imx8mp: Enable HS400-ES
Date:   Sat,  2 Apr 2022 14:39:41 -0500
Message-Id: <20220402193942.744737-4-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220402193942.744737-1-aford173@gmail.com>
References: <20220402193942.744737-1-aford173@gmail.com>
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
fallback to imx8mm to enable it, but keep the imx7d-usdhc
to prevent breaking backwards compatibility.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Keep the fsl,imx7d-usdhc to keep backwards compatiblity and prevent breaking something.

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 794d75173cf5..8578ff1062e6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -769,7 +769,7 @@ i2c6: i2c@30ae0000 {
 			};
 
 			usdhc1: mmc@30b40000 {
-				compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b40000 0x10000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MP_CLK_DUMMY>,
@@ -783,7 +783,7 @@ usdhc1: mmc@30b40000 {
 			};
 
 			usdhc2: mmc@30b50000 {
-				compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b50000 0x10000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MP_CLK_DUMMY>,
@@ -797,7 +797,7 @@ usdhc2: mmc@30b50000 {
 			};
 
 			usdhc3: mmc@30b60000 {
-				compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b60000 0x10000>;
 				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MP_CLK_DUMMY>,
-- 
2.34.1

