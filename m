Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE484E87B8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 14:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiC0MlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 08:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiC0Mk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 08:40:58 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13CF1F626;
        Sun, 27 Mar 2022 05:39:19 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id 8so8168777ilq.4;
        Sun, 27 Mar 2022 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4YCgujv27+woyfX0FEzZgY70JuHa3urHBxFeIijA2o=;
        b=Vl9OvyTBcamMB+DBnmsjvio3b1Q1L0IOI47z9vKDe7Cx2sPI8kdMJeVgCYcLWVvZol
         uUk7niO3ula5zUxe3u0pyvTwVMmgQoA+LyFoqgBno5ZonHAv6JkrtEkgionyqklvjbKz
         VsI9EDekcfUmJ/UtaCCshDtBlBxn1o77KTf0pgoegd5tdWxgZ7aHcB8jCGy+g6QOD6MA
         nb13Q7Tr0vSUWTyw5zydjvLHXKJ0+QAIYHeJwsn5eJJQOA1Rtm/FcY+s+xpqX/s3MK+x
         ro+68Bc1qdfIpPvsKe4N7lnFxDjiUcb6vLMhafy0cnK2VSX5qpCt0XDWlOQ74+OId5+y
         JBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4YCgujv27+woyfX0FEzZgY70JuHa3urHBxFeIijA2o=;
        b=06wYeZuXvaIdvZgFYrlbDcmS2KgfwUeoQ00K4hPTthpwCSgQoZTPgMKRzQ5ecLqJqH
         0bhj/X+yenGEpqXAXuLcvXfl0S9aqcjiAoXUC2j6z7o6kokifwkwFq8eK9KSu5aVhmpK
         wrpMMhaKD+Ks1qIZg1PW6HHcIdfJSTkELC0N7dNWxt/JOM93BlAagVUXe81mroCJJFAu
         aIlu5rAVNRdkzwbXbxsT0iMxCGRR86CeolWGSXtLErWBBbCZdH46gcQh5rz2yvY58hsJ
         nXvOs0eWS2TNWaN/z6zekd9AZbCjBG9BhVeiOp+Lo2tVg2MyjvBJxvOm2t+XU+Wc+p8S
         w8oQ==
X-Gm-Message-State: AOAM530GA9eMGhnPGuyw7p0sj/vO9Ynn27xTW+SPuflyq2QjG9OcXmiU
        yJaROAXdY9zqjPH45b92HwKPimqdfBI=
X-Google-Smtp-Source: ABdhPJyWZn2Fl0JCU6vjMYac2Vo5YOOmyLLN/6PEU/jRVxmEe89gaAT6y7GwciQB+PUlcdlPa5aNeQ==
X-Received: by 2002:a05:6e02:19cc:b0:2c2:82ad:7c92 with SMTP id r12-20020a056e0219cc00b002c282ad7c92mr3263154ill.258.1648384758777;
        Sun, 27 Mar 2022 05:39:18 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:7073:b368:2f66:5e36])
        by smtp.gmail.com with ESMTPSA id t7-20020a5e9907000000b00649d6bd1ec5sm6134534ioj.31.2022.03.27.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 05:39:18 -0700 (PDT)
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
Subject: [PATCH 2/5] arm64: dts: imx8mn: Enable HS400-ES
Date:   Sun, 27 Mar 2022 07:38:31 -0500
Message-Id: <20220327123835.28329-2-aford173@gmail.com>
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

The SDHC controller in the imx8mn has the same controller
as the imx8mm which supports HS400-ES. Change the compatible
fallback to imx8mm to enable it.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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

