Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD1A4FAFD2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbiDJTiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241621AbiDJTiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:38:10 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441C15675F;
        Sun, 10 Apr 2022 12:35:59 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id q11so16441876iod.6;
        Sun, 10 Apr 2022 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+80NmnoxSiKUBJ9sZPBxOdWSJwSuD1484dBqAZ+IV/k=;
        b=jPpM24NiXXpeaMcG15L6VwN9JJHGgB7Y7BVPOvW9j1H8kGwb5HJLoAyZtPiHyko/DR
         GmT2D5njYRzIGZ7mm4NwVNj9H3ZGf9qtW4ePQQPtAyzRRDvRO67MNAzsOaBJQe/RsaBT
         BBTs/sCINlnXN76RXFx6WeW2XG0IOhJ+KukjjDyiOAL3hsAvofWIngf5wI5Lbsiout/3
         N9AX8pouTfBL9j5sefV6A4zdEgt6qpcKWa3iRECAWIE++hSZUAktDdh2ZbZOjQTtuPeP
         OAOZu1z0gkEyprs6w7UUOatHJ0iy0Um5bRWr3vCaIIL5p9AN6pNUonBQV/Syj58zYFfp
         Ugbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+80NmnoxSiKUBJ9sZPBxOdWSJwSuD1484dBqAZ+IV/k=;
        b=VyGu/z7v71vHTdsCdcxMCV2WRs3P4UKjAzJqNSdIJAWxyOSMJXVKZIuzuCiSENPdqT
         30aM7i1NfS9hLyVv0c+ieX9p4Y6F+MduDhI6+IowXfN8w8y0MyWP9g0Tp0xcqvo4BBcj
         sRHVTLPxTqgbgr4FCtDAAjMPL9F4X3m15ZQ0x5NhjkdRUohbhWqGU9P5U1LPvBg7yUVP
         OowTkoZG2Ds4xJfUDQ3Jv0tXwSfTS9sKI1o+unBux8RozqPYbhvg3hnJo5Yym32BZHjz
         PsssjdoaoDd5SmkF+AtfHGDA4oLZymAQw7RidMOXmJN5JFVnPkHCh00Nmfz0AnCP/T2x
         APPA==
X-Gm-Message-State: AOAM533zZojzlO2TGSNtJIX4PJdTCQ3PTXEtKAFT8AupwMz9XXPrSz9x
        e9X9Q7Q/Y5v+CpNuk6nTo2LyYurF2Js=
X-Google-Smtp-Source: ABdhPJx5T0mO7NTeAYUHEz7JUdoiRpWnuaK1nmYmVishki1RLaX4oXJQ+opjZ6Rqtz0851OHnlflDA==
X-Received: by 2002:a05:6602:1648:b0:647:9f39:1272 with SMTP id y8-20020a056602164800b006479f391272mr11425002iow.146.1649619358264;
        Sun, 10 Apr 2022 12:35:58 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:1e67:6f3b:4d7f:4f90])
        by smtp.gmail.com with ESMTPSA id m6-20020a923f06000000b002ca74f4fab2sm7218409ila.14.2022.04.10.12.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 12:35:57 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/3] arm64: dts: imx8mn: Enable HS400-ES
Date:   Sun, 10 Apr 2022 14:35:42 -0500
Message-Id: <20220410193544.1745684-2-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220410193544.1745684-1-aford173@gmail.com>
References: <20220410193544.1745684-1-aford173@gmail.com>
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

The SDHC controller in the imx8mn has the same controller
as the imx8mm which supports HS400-ES. Change the compatible
fallback to imx8mm to enable it, but keep the imx7d-usdhc
to prevent breaking backwards compatibility.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V4: No Change
V3: No change
V2: Keep fallback to fsl,imx7d-usdhc to prevent breakage

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 99f0f5026674..13c51363cc06 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -933,7 +933,7 @@ mu: mailbox@30aa0000 {
 			};
 
 			usdhc1: mmc@30b40000 {
-				compatible = "fsl,imx8mn-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mn-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b40000 0x10000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_IPG_ROOT>,
@@ -947,7 +947,7 @@ usdhc1: mmc@30b40000 {
 			};
 
 			usdhc2: mmc@30b50000 {
-				compatible = "fsl,imx8mn-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mn-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b50000 0x10000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_IPG_ROOT>,
@@ -961,7 +961,7 @@ usdhc2: mmc@30b50000 {
 			};
 
 			usdhc3: mmc@30b60000 {
-				compatible = "fsl,imx8mn-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mn-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b60000 0x10000>;
 				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_IPG_ROOT>,
-- 
2.34.1

