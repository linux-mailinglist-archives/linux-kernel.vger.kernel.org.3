Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8BD4F05E8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 21:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347743AbiDBTl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 15:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345250AbiDBTlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 15:41:47 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05FF5C84D;
        Sat,  2 Apr 2022 12:39:55 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z6so6921251iot.0;
        Sat, 02 Apr 2022 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kONCy+L4837y2p0w8BZs1PjYyStHLqcIFx2rz6iTVeE=;
        b=iSarmlkKTkcdzX8tAzc2M2OYHancQQ4Nvmzfe1TGzY007BXQEP6Cac6g8OTJSufI2E
         aNQR92hUytvA3Ioo5J7iRciiSBFq7kOTnK6wgC4SutsNfSSrlGyL3P8FGUY+ZkOVsWNo
         /85wkhv/ccz8rVOSx8aVdClgeIr6qn1ivtYO03qJQUi02acQypOeIm6JZVJ/8jEdXEkZ
         R28jH2+wwRhjreZRl0iB/MAQvxitBQByV0HNXZBaWmxNTd+Hwq41YNmf0lfAGOKw3iEz
         soMZt8TFwCG+zsZJR34BIwX42WPR79cjgte+v9PpcATwKTSr19+P5R8zwaf9uT2pvCY9
         Un8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kONCy+L4837y2p0w8BZs1PjYyStHLqcIFx2rz6iTVeE=;
        b=A74Acgpz8MU8VG0WdwBemGosn6ain95krqaryJrah4UXl+Lui0rl8GrLz28n9Cs7hm
         BU/JYgr4XQ29zzzs/9m6tYoKd2r8Fxht6cJJisuBW6pKHSzSKlKHGNJXfsY93ecSsMoI
         WWOoAj3QAue9O84AOQYfm1gQdHJM0lmwQRaTgrcrscoLfCDNqTYJ35Lr0IwJ2y44vA6Z
         P2JQAYYc+xBROucz4PJN/7oiolGnJ4OgJ2aqPequ12k2ZFfuWOkYVCp1dFQyLiLiKQ2/
         euue7HSWU477PtleTfF8PIgyEugipnWQT1Fuz8Acgfhdjx/t9R0mIHKjBmrLJAuqP4wQ
         HTFw==
X-Gm-Message-State: AOAM531bvK0jSu8Z1L+IjQCQNE6QMfImwb1tBw7LZ3TtlhcGb+5Wb1EQ
        GleO2MdKNEiIk8CXJW5SG4uDDgKZ23frGg==
X-Google-Smtp-Source: ABdhPJwiUwdMQPJbZlUd9T0RrBa18B5TGL9rYfD8yMUPu9Jj/6m718gBAECI1gyB+xPNGXCHOkdA9A==
X-Received: by 2002:a05:6602:1593:b0:648:aa01:8d89 with SMTP id e19-20020a056602159300b00648aa018d89mr2295191iow.149.1648928394836;
        Sat, 02 Apr 2022 12:39:54 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6ab1:a455:ad1b:e8da])
        by smtp.gmail.com with ESMTPSA id a14-20020a056e020e0e00b002c9e2f0fd76sm3261756ilk.13.2022.04.02.12.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 12:39:54 -0700 (PDT)
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
Subject: [PATCH V3 2/3] arm64: dts: imx8mn: Enable HS400-ES
Date:   Sat,  2 Apr 2022 14:39:40 -0500
Message-Id: <20220402193942.744737-3-aford173@gmail.com>
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

The SDHC controller in the imx8mn has the same controller
as the imx8mm which supports HS400-ES. Change the compatible
fallback to imx8mm to enable it, but keep the imx7d-usdhc
to prevent breaking backwards compatibility.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Keep the fsl,imx7d-usdhc to keep backwards compatiblity and prevent breaking something.

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

