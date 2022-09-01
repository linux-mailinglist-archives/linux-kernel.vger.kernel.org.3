Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86C45A9BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiIAPle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiIAPlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:41:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466926C116;
        Thu,  1 Sep 2022 08:41:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r4so23098226edi.8;
        Thu, 01 Sep 2022 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JxxplVChk1fR4jdUMTZHm2J51GYz2+D62Sgb2oOFN0I=;
        b=EJpmZxcV/H0wdtJOHcmfSa0JYUz8JFHgBxllCr4dkL9P+Z2xJCFsfuhgZwVKf3zGyU
         xdtDMW3KiC9F5TnnHgd8bzmfq18rJrvP+DBCUnOPgUUrRgvM7o5hL9NKVtbjVZtH04gS
         4kLMe29soL72dRGtpf+YWQUdWMgV4PEu6NXj5QKsvRKrluV+Z+uzpQR3Vy4UAnNjpM9n
         6aTrkGVJSh4nQDWkO6twoswkD1SrcHdwp+ZiR5jR43kWQJgpYwxELNRjVhJ80NcATCQZ
         8XGVDbMBYDEmWzNS251D6PL1rip5YGjs7DVBaI6ZrmUeKhns8Z8CrY3M7koY58Az6EH0
         DkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JxxplVChk1fR4jdUMTZHm2J51GYz2+D62Sgb2oOFN0I=;
        b=gje4n8Gdjzn/iGXmLxqsb5Rss9DtJmdPZbsyRElbuQiIXBA49hR31Qu+REyHpw2Ddu
         CaKjSyDstJWifxxUiudvw9nT7uYyr9DTMnFLTIRe86bc3Z6s34b7kLBFLn3EMFnvF5YR
         /gSB7lINZ1n9qJjmBhEFlhDW/o7s/oXM8U/asDsOmhNIKlNcgPJHtI/V7b7GBcwINpuW
         POrYfY6y1bqLb3ssAW1uKHBFBPjr7w35Oxh+CrEzgGVCU0Sg4vFycDzU3y1mIeab0Enm
         xl50OSJHghix0vnerkUF0zfR/+dRZjgIUChNmlkrz7PIIF8E74yvh2SKIKCMeRowViGu
         UE7g==
X-Gm-Message-State: ACgBeo3ezcaP8TX88JCfwj0XkQmV23PlMe9dWesTFg/UvMkmcblbIgFU
        MM7TZszWG4UOsPUSkvGPwYQ=
X-Google-Smtp-Source: AA6agR5Y7RlBE4VSvJQJlhfWWkThmcA/jGMUGDj69duBgecT3jkrk873qDBX7ZNFh/J0rbUal4Zm6A==
X-Received: by 2002:aa7:cdcc:0:b0:447:bac0:4c20 with SMTP id h12-20020aa7cdcc000000b00447bac04c20mr28510923edw.183.1662046880512;
        Thu, 01 Sep 2022 08:41:20 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id c25-20020a056402159900b00447b1772a26sm1543103edv.12.2022.09.01.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:41:20 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: imx8mp-verdin: add dsi to lvds functionality
Date:   Thu,  1 Sep 2022 17:40:51 +0200
Message-Id: <20220901154051.1885509-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220901154051.1885509-1-max.oss.09@gmail.com>
References: <20220901154051.1885509-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

Add a panel-lvds node and use the correct dsi to lvds chip name.
Both to be later extended in a dt overlay according to the exact
board HW configuration.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index bd84a0d135dc..a3e20c7add3e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -67,6 +67,13 @@ hdmi_connector: hdmi-connector {
 		status = "disabled";
 	};
 
+	panel_lvds: panel-lvds {
+		compatible = "panel-lvds";
+		backlight = <&backlight>;
+		data-mapping = "vesa-24";
+		status = "disabled";
+	};
+
 	/* Carrier Board Supplies */
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
@@ -690,8 +697,8 @@ gpio_expander_21: gpio-expander@21 {
 		status = "disabled";
 	};
 
-	lvds_ti_sn65dsi83: bridge@2c {
-		compatible = "ti,sn65dsi83";
+	lvds_ti_sn65dsi84: bridge@2c {
+		compatible = "ti,sn65dsi84";
 		/* Verdin GPIO_9_DSI (SN65DSI84 IRQ, SODIMM 17, unused) */
 		/* Verdin GPIO_10_DSI (SODIMM 21) */
 		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
-- 
2.35.3

