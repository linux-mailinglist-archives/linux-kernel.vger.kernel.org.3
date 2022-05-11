Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ED752324E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiEKMAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbiEKL77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:59:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F922421A6;
        Wed, 11 May 2022 04:59:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y21so2282236edo.2;
        Wed, 11 May 2022 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yoXugxNmlSlyrYTc39E+9Noe/h1XX+7WUCIyJignh3o=;
        b=D026iAc3+EoDUnwWKEQ9HoDKjAWHKuRpOUTVxCk4fCFdz81hkNeDa/JP3Az+cIYC3T
         G0qCh+RbRrbF+aldPqAMEtZa2QEnfnZKlgHhTrDCObLVtJfzy43FJyDDpLp/Hfl/HbWO
         5zXS7WP0sgw+gfsYf34Y7Gh22Ye0a+Wb2M+Oyr57ymkqaXLtoacMV2GeWPEuuLB7vhpT
         VQ1XEYGVAQU4s7FuEiVBNsoXEwDjmDETPDaNuKCP3Wc48PHvZj61sRYgfCuExSDIEw0i
         T0zFBG/+O2N+Z2yg9xlv6Fr2VkXMz/+JZ2lUuPbkPJ3Y6ckeWVZyHDYrZZ4ObtvP0dFd
         RJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yoXugxNmlSlyrYTc39E+9Noe/h1XX+7WUCIyJignh3o=;
        b=IErEtsZiDwh8TPLGWBUFd172ejz35PCYQL9kztO88B8Avzo1bX8NZZmInLvsA8sfoK
         OUGtAieXxpDWI9lqE7V5Id5k/6YB2M7pgV5e0khOFxM4xPyGX5RZQfXJWx5Hse/xOVhM
         TcSOyvSh1MU/8vMSqtpPG20u+Sv83ALvzezm3+5magYw6wirGspX0KXrJ0X6o/8kTk3o
         QNJX3S9LSL8ris9g8W6LzXRjBrzXXFu4arEPuNwgg6YBdexUZWiTm7qAD+hntn/IwtMD
         fxTOS4bcM9FxgZJD8rl6Zh0h7tzu7BqiY1a1C2szd5zmFCQD7fVtCh9UbRxJ2YUE3AIi
         tyxg==
X-Gm-Message-State: AOAM531ICXNvydbGne/h9y4Xu9k573iN/YobzQ+CLws+Ew0zNPWtXNY3
        pQq8EsYsU7p685DcZ6Rx7s0cbMsesYk=
X-Google-Smtp-Source: ABdhPJzgqkvrEDviEwiklNlmmdCAVDvDspKWtkdWOiB4VrnsT8/Vw/77WrUGaK+ioYO2KLRwBqtHpg==
X-Received: by 2002:a05:6402:11cb:b0:427:7e52:eba5 with SMTP id j11-20020a05640211cb00b004277e52eba5mr29164454edw.17.1652270396074;
        Wed, 11 May 2022 04:59:56 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id g6-20020a50d0c6000000b0042617ba63aasm1089279edf.52.2022.05.11.04.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:59:55 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: dts: imx6qdl-colibri: Mux mclk for sgtl5000 with the codec node
Date:   Wed, 11 May 2022 13:59:08 +0200
Message-Id: <20220511115911.54960-3-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220511115911.54960-1-max.oss.09@gmail.com>
References: <20220511115911.54960-1-max.oss.09@gmail.com>
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

Move the pin muxing for MCLK used by the codec to the codec node
instead of placing it inside the audmux pinctrl group.

While no negative effects have been observed this should make sure that
MCLK is provided when the codec driver is probed.

Follows commit fa51e1dc4b91 ("ARM: dts: imx6qdl-apalis: Fix sgtl5000
detection issue")

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
- Added Fabio's 'Reviewed-by'

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 7df270cea292..f0908b530f86 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -520,6 +520,8 @@
 		compatible = "fsl,sgtl5000";
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		lrclk-strength = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sgtl5000>;
 		reg = <0x0a>;
 		#sound-dai-cells = <0>;
 		VDDA-supply = <&reg_module_3v3_audio>;
@@ -739,8 +741,6 @@
 
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
-			/* SGTL5000 sys_mclk */
-			MX6QDL_PAD_GPIO_0__CCM_CLKO1	0x000b0
 			MX6QDL_PAD_KEY_COL0__AUD5_TXC	0x130b0
 			MX6QDL_PAD_KEY_ROW0__AUD5_TXD	0x130b0
 			MX6QDL_PAD_KEY_COL1__AUD5_TXFS	0x130b0
@@ -991,6 +991,13 @@
 		>;
 	};
 
+	pinctrl_sgtl5000: sgtl5000grp {
+		fsl,pins = <
+			/* SGTL5000 sys_mclk */
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1	0x000b0
+		>;
+	};
+
 	pinctrl_spdif: spdifgrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x1b0b0
-- 
2.20.1

