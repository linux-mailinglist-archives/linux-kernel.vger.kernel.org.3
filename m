Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1714E5364
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbiCWNmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiCWNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:42:08 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C9A7D037;
        Wed, 23 Mar 2022 06:40:38 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h63so1669371iof.12;
        Wed, 23 Mar 2022 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQySUKGIltsbUwKlkT+gfNkYaO0VnnadkZePMUtAOnM=;
        b=Xab3EQk0AiiE+ZzfpqOlkCBxpLAANEfxFck8rV/+z7Nn89nxokbnh27DOb8Heicc1n
         KdteK4KTex1wzhST2nP6xZJ5BQSYGJYxkZKnWY4zorTD6MBO7HVnkqe06D+oND5LjtMA
         0JilncoaQO3DP9Y0IuYaqz9uGNj+LPIe8gLY870rOxY0p0gl5MMhpEu93vU+yZs+4ZJo
         FiVmTA+Nde8iS1NZBMxMJcMhn8KMCW2ZKzRXRc7TP65Aki+HMDbrH4d07tOW1LGrzW8v
         hs/ZwpNtJm7qcb+R7ROuHIuU8sTG0yhUwuvIgLv6xIquanYMi5GxaP2+KgiYt0eZf9Es
         Pa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQySUKGIltsbUwKlkT+gfNkYaO0VnnadkZePMUtAOnM=;
        b=Be9OAbxUJJlVsVpuNaXEONQQxO5kLXIWV0cHAFjh6rPBzSWvcURXGd1r8ehDsFdqeX
         JK9CjcddSCUlBfCoUTnFWp9XPZdZdfk50KzupTd1n2EjBaqRvgYUA/jibPpYFyIToAuL
         kuSM/aKCjb3YuVrAr/UWLH/088Ash6i6Q75D9yeBkNZHkwe90YuvR1SHUeGHFDydFWMz
         StVyJd9isVqZVzcjBcd2yUhd5nS9l0euJZPKKvQHe9rrYiloEDtoWCWWwVwouv+X4FG7
         O6o1oy8B32ZqP9MuV/tYLBLuXDe0eG65cqljGHdXe7Hdrw+wETUZO28vFzFZOw2fPoad
         sOCw==
X-Gm-Message-State: AOAM531y8obGyxTRK2JmXpH7mjyYUndbDqENMGMXLFxs808j7JrI1EJw
        cTlERN1qBnITicNQFZ2kCmQ=
X-Google-Smtp-Source: ABdhPJxP+bKnJz0eHLW1UowR6ozFmv5/SYa3VZ4zAH003deMZidQ/UF5f9v7UWjo96rvT5kia5VGIw==
X-Received: by 2002:a6b:8bd7:0:b0:646:2804:5c73 with SMTP id n206-20020a6b8bd7000000b0064628045c73mr42297iod.112.1648042837385;
        Wed, 23 Mar 2022 06:40:37 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:3c99:2d92:f93d:dc94])
        by smtp.gmail.com with ESMTPSA id y6-20020a056e02174600b002c7f247b3a7sm35253ill.54.2022.03.23.06.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 06:40:36 -0700 (PDT)
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
Subject: [PATCH 3/3] arm64: dts: imx8mp: Enable HS400-ES
Date:   Wed, 23 Mar 2022 08:40:19 -0500
Message-Id: <20220323134019.3796178-3-aford173@gmail.com>
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

The SDHC controller in the imx8mp has the same controller
as the imx8mm which supports HS400-ES. Change the compatible
fallback to imx8mm to enable it.

Signed-off-by: Adam Ford <aford173@gmail.com>

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

