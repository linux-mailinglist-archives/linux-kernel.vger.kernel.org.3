Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4351FB10
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiEILQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiEILQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:16:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0991AB794;
        Mon,  9 May 2022 04:12:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l18so26074250ejc.7;
        Mon, 09 May 2022 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bXlbOejj9Sna5Dfj4lSOONGUdBd9cH72j0nYofArQyo=;
        b=IMk7Nf4Mkgfm01ZACxlWd2nUwAmrsiP2uDe6RHrrYFj+WGLqUkHAYNvBCj0VzulJYH
         0OX8ZAcFIINYgYvMoagWxurz1K6ZT2Wgu6hoDFGdcd5N2olNxtPuqvioZMsdAlZKa/3u
         zWjjPysZAEcIr+/yUXrddeajESnMM/b4UYsI8oVNAi7qnLchl045zja3xaFDu3YKQ9/F
         JHjXLZxdcPXs4gAiPMcYciCiPW9fLT7VxyQk6DbUnc3mkXBCCSy+oTWNgmYF+cYGSPAQ
         u0Ve6+Soq3plc+xkXULtAwB81JlDKOr9Px32EPo+d8rksbninqC1W0gGHjd5qNnHbf/b
         dKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bXlbOejj9Sna5Dfj4lSOONGUdBd9cH72j0nYofArQyo=;
        b=gZWp7SX6WVJNl6QMqxDznvbHluHIrGIe39PLMpxLSOVPr1FnHLl+4s5afTlu+ID1vY
         nIG5bxZxoaUJkLPj8eSQQ07MXdZVmGcsisTtBupVytWQjhdYHnvh4Tely7bUcE9wxyII
         7Cs3UsQRa4KeYbVpOl93Mz+ZlPuXOxAnR7+Pyz0ndyeNZzqGVD45cZmildLWpDRxWXiT
         4ujZvQvLYOAlTN/WJATfmPPz1xzTd3L9dZCxNNJVIZsU1e5HJrPTChmve8yPaDJO81/k
         vVi43rhRNsSoR/Riisear7OJNT/CUNm33Hx8akMDkWsH4EyQ5XCJ/omfV7Ie7F/3S3kX
         tD7g==
X-Gm-Message-State: AOAM531pMuSuXq2lySkNS2VCvdcDCw2D6oq02Krut4yhoA3BsTcl/5iT
        hVec7vzhxaxwRqZUwTqSxxA=
X-Google-Smtp-Source: ABdhPJxHRk3zNzRPO3XitFUCSqKBphxtUV8etOHwuIAJF8BCkcOYE0RQy41AYx3b5X9aw6U6CGIz9g==
X-Received: by 2002:a17:907:2ce5:b0:6f5:64f4:91d8 with SMTP id hz5-20020a1709072ce500b006f564f491d8mr11795154ejc.675.1652094727083;
        Mon, 09 May 2022 04:12:07 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id c24-20020aa7c758000000b0042617ba63b4sm6075672eds.62.2022.05.09.04.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:12:06 -0700 (PDT)
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
Subject: [PATCH v1 2/3] ARM: dts: imx6qdl-colibri: Mux mclk for sgtl5000 with the codec node
Date:   Mon,  9 May 2022 13:11:25 +0200
Message-Id: <20220509111126.7032-3-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220509111126.7032-1-max.oss.09@gmail.com>
References: <20220509111126.7032-1-max.oss.09@gmail.com>
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

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

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

