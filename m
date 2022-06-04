Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB1953D81F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbiFDSjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 14:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiFDSjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 14:39:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBEA31524
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 11:39:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u3so14473814wrg.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 11:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zjb1mGSym65J9ellOm0DGmh/ve+ZjqPiIhIp48CKMg=;
        b=AyHfIekbEa9O0Z2h216EY2CHg2BPLKqFNyNc+ZJm/WVRM/04WA8N9/2RkGQvUK8Kc3
         JLDqCdqvbdAcL4CLa9aiP2G9cFCZQOCitOA6QIKUdoc1gwnScCmI7Dvmq7C6X9VpKyK/
         EckOUHW7xwGgyms3yo/Z6DbfEYQjXekGyDItQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zjb1mGSym65J9ellOm0DGmh/ve+ZjqPiIhIp48CKMg=;
        b=fPA2QF0Hhv+WR4DE7Unrdl6iNZD+y/TaXS6dG+lmWuAn/RZBI9yN+hfYGyFH10WZVK
         tgRUEs5M/lc0zEKjDbpRMDIyYhz89zOVgYq1wzuNH9BvGkS7R0uzrajKNXeHQ/yOxGRk
         Z8iv6MsooMr866q8vs7+6GTOJiMMU5zgWm/TwW3cUhfWTB8LiUswgiAIhjYlrooPoLx0
         K9GPNXQV4jUduvKfgUwZhFE7BLnDia2H7Z32p4oyNuu09MTTw21D4EPQuxpbSbTKi5wu
         4dp/fqevwslL2FPetEIbaD1dXvjr3/myt333uKvOnN2kOj5I2Ig9/GKakNXo6Fdl3wha
         B6hw==
X-Gm-Message-State: AOAM531k7IXRa7OjoOfga1uGYlNZzcBb9hXgpm/xFMp//DpIwXGLJKcL
        1sf1/t4O1voJAhpRzAEi3BS/pWU6fsryAw==
X-Google-Smtp-Source: ABdhPJzRj6geKqRf7J30fIivb1dEg0YG34ldikQSCda3nTTUGz7XeTsmi3BbgAmQ5/KxSGxLeHPezA==
X-Received: by 2002:a05:6000:1841:b0:20f:d80a:963f with SMTP id c1-20020a056000184100b0020fd80a963fmr13447868wri.116.1654367949162;
        Sat, 04 Jun 2022 11:39:09 -0700 (PDT)
Received: from localhost.localdomain (mob-37-180-27-19.net.vodafone.it. [37.180.27.19])
        by smtp.gmail.com with ESMTPSA id d6-20020adff846000000b0020c5253d8d2sm10814263wrq.30.2022.06.04.11.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 11:39:08 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: imx8mn-bsh-smm-s2/pro: Add pmic clock connection
Date:   Sat,  4 Jun 2022 20:38:58 +0200
Message-Id: <20220604183905.1025201-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmic clock is connected to svns_rtc using RTC_XTALI pin,
and wifi/bluetooth chipset

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 .../boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi     | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
index c11895d9d582..a21ec0d1d003 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
@@ -28,6 +28,8 @@ usdhc2_pwrseq: usdhc2-pwrseq {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_usdhc2_pwrseq>;
 		reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
+		clocks = <&bd71847>;
+		clock-names = "ext_clock";
 	};
 };
 
@@ -214,6 +216,11 @@ &i2c4 {
 	status = "okay";
 };
 
+&snvs_rtc {
+	clocks = <&bd71847>;
+	clock-names = "snvs-rtc";
+};
+
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
@@ -235,6 +242,8 @@ bluetooth {
 		shutdown-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		device-wakeup-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
 		host-wakeup-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+		clocks = <&bd71847>;
+		clock-names = "lpo";
 		max-speed = <3000000>;
 	};
 };
-- 
2.25.1

