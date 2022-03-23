Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ADF4E5362
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244417AbiCWNmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbiCWNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:42:06 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCCF7D036;
        Wed, 23 Mar 2022 06:40:36 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r2so1679671iod.9;
        Wed, 23 Mar 2022 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bC9rTh2FGaAT6ZiIunAd/+2aVgoCUzEEMyUVt1pLXug=;
        b=TaWbvjP6NbIEayvUJGiwls9xaONscOusJCNIbfVt6iHPOS4YmwiIkFD9wycKsb3PYq
         ZE6prIRo5ILQ2ol3in2Ja4/+R6QMJXEtZJm8e+dyQtpF12NKVJYOKgK3eVPmULa2g0jl
         I365mnUix6SiU5oAOUNFz4CR7Iw6hhDKJ/fSKqsr/tlGNS9nPTNBBDoFtzmoyJ9Y2CX1
         +NgiwBL6C6CTPqw/5m/vAfj7+gEbliHMfrTjoFFTI7P19Y0MWruCF68DgJES0KTkPR2l
         wyvVqyg1u9ctdmzZB6xjIMa7YIdbSU81+tBRBgpmJJCJRCxcDH1x22rxfCY4MRRbN4e+
         PihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bC9rTh2FGaAT6ZiIunAd/+2aVgoCUzEEMyUVt1pLXug=;
        b=I1zeM1He9fBBZqq8k7RN5VPfjmK5/O2VLuLVuds0vUaApYXMRS3ifyeT0QvqJUn1C9
         9P07YR0mrd9jtUik0XnMgkNRNRpDxaPJrbVP25oyh+XjhyEuWsUuUO87X4Jr12RoSa7K
         Dld2I5YwbBNomn0uzvuTFgt1d7D4lwrKqzM4r3SqRknn+X/x+oFm4h6BQO9vy6jbCkSr
         7206EX2hGNWYONlPjNXjWiSYCLVBJN09De/ejOi+ck8hvEGn8Ct66LRGlyT0zqwpaALS
         KlLsDf15/yV54mdOYpniYXPlDXzm68bHX4WQM18HpDZpPAzwtS4fUKB/Hlf2rNv3B9IJ
         mPnw==
X-Gm-Message-State: AOAM532jz7RWXs8Gkt6+h5rQO1mcVZmgjZTDUcyiI91MoLqhcwybPa7K
        671x79W+VYCay335Nqv2JxI=
X-Google-Smtp-Source: ABdhPJzeNWcNe/DSLtlxCZTTRGlJKGNv+pY57/wb/eQkxlBYLP1DMdFcTOG1j9nFeJeR2v4euaEbvA==
X-Received: by 2002:a6b:7b03:0:b0:648:40c7:309d with SMTP id l3-20020a6b7b03000000b0064840c7309dmr33671iop.15.1648042835788;
        Wed, 23 Mar 2022 06:40:35 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:3c99:2d92:f93d:dc94])
        by smtp.gmail.com with ESMTPSA id y6-20020a056e02174600b002c7f247b3a7sm35253ill.54.2022.03.23.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 06:40:35 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: imx8mn: Enable HS400-ES
Date:   Wed, 23 Mar 2022 08:40:18 -0500
Message-Id: <20220323134019.3796178-2-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220323134019.3796178-1-aford173@gmail.com>
References: <20220323134019.3796178-1-aford173@gmail.com>
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
fallback to imx8mm to enable it.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 99f0f5026674..959285c3fee0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -933,7 +933,7 @@ mu: mailbox@30aa0000 {
 			};
 
 			usdhc1: mmc@30b40000 {
-				compatible = "fsl,imx8mn-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mn-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x30b40000 0x10000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_IPG_ROOT>,
@@ -947,7 +947,7 @@ usdhc1: mmc@30b40000 {
 			};
 
 			usdhc2: mmc@30b50000 {
-				compatible = "fsl,imx8mn-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mn-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x30b50000 0x10000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_IPG_ROOT>,
@@ -961,7 +961,7 @@ usdhc2: mmc@30b50000 {
 			};
 
 			usdhc3: mmc@30b60000 {
-				compatible = "fsl,imx8mn-usdhc", "fsl,imx7d-usdhc";
+				compatible = "fsl,imx8mn-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x30b60000 0x10000>;
 				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_IPG_ROOT>,
-- 
2.34.1

