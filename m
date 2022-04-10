Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F284FAFCF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbiDJTiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241651AbiDJTiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:38:12 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE94056C3C;
        Sun, 10 Apr 2022 12:36:00 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e1so10051336ile.2;
        Sun, 10 Apr 2022 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kq2mDXpJVUKHZ8kDUCVzEF7Ewrkfj8MwGMVmAZjj5HM=;
        b=G0GGQ471rxAxJoI+vflM67vRTsrP8uihcV5wkB9k4TaGvypdTKT++LF0rprADglri2
         brzUGCQfJDrVkfTd//0Vuy4tRp7SXeRaYzURHhGtwSnqFsa61aFVWZCnH3/NcJbyj27Z
         oNSstFwLreTMuQtJSJhbT8AAN5lPD0uyA8jUceBJVjZc+kkpV9PvGpyNZ8KCZy6aRlo/
         pXWRDNpNLaZfjg+LXmih3fp7zzOfuccZ/38lkPnn4W8fxAlqT33vu8nE81HWhqnI4wmR
         vMqM6ASyb+Y3K+9tdyzumxpNnxrNe4WL42waSJsqOhuz8hEEvxKPC/JYmovk1hbl4jBM
         +Izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kq2mDXpJVUKHZ8kDUCVzEF7Ewrkfj8MwGMVmAZjj5HM=;
        b=Xwhhb8fCTFcbZg4DKrjuTzM+VzuVmdMapRuCvGSjlxlouGdeYmZzjBvb6SJusbWWMv
         4EI9RBI8Vh+rJshke1mcbruFe4njrieZZE+CJc5X7Mbm+bDnxOSQ4RzmUdFd5w0Lhd8b
         ukrZM0la19sD41vFtyBgI4W7Dw7QhkbE5eKvTs/TlxeSsvMoaEYQhCRWOdlruENJS4Sb
         uSM6hbTtYv4Y5gabNSkKQoZK8Exub8YTIh1W51WBKkKnw9ysfVgzlDX22w3G6ow7OcNg
         93dpVVg3MHjB+boot+HHVHLur+Fa3g2/n56jOw/yBUQgn/uYMfxoTGTeTUkHEdoFYWqo
         f08w==
X-Gm-Message-State: AOAM532d6cF/gxLSS4GXsJI2b3r3tx0XsWLRMJbtwbuw8TY/pbhLMTo0
        /tqQmW1Lisr31JLj0VydN8Kptdbqvzc=
X-Google-Smtp-Source: ABdhPJzaEb7zRVi/v1e9VtJQAKwimsKumnvluM8yYX+DQjfXWYPJkI4iu0AYZKgzS9EOghpQgBRi4A==
X-Received: by 2002:a05:6e02:18cb:b0:2ca:a7d5:d392 with SMTP id s11-20020a056e0218cb00b002caa7d5d392mr1717924ilu.8.1649619359818;
        Sun, 10 Apr 2022 12:35:59 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:1e67:6f3b:4d7f:4f90])
        by smtp.gmail.com with ESMTPSA id m6-20020a923f06000000b002ca74f4fab2sm7218409ila.14.2022.04.10.12.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 12:35:59 -0700 (PDT)
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
Subject: [PATCH V4 3/3] arm64: dts: imx8mp: Enable HS400-ES
Date:   Sun, 10 Apr 2022 14:35:43 -0500
Message-Id: <20220410193544.1745684-3-aford173@gmail.com>
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

The SDHC controller in the imx8mp has the same controller
as the imx8mm which supports HS400-ES. Change the compatible
fallback to imx8mm to enable it, but keep the imx7d-usdhc
to prevent breaking backwards compatibility.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V4: No Change
V3: No change
V2: Keep fallback to fsl,imx7d-usdhc to prevent breakage

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

