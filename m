Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4F9525FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379540AbiEMK15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378752AbiEMK1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:27:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E1A50450;
        Fri, 13 May 2022 03:27:06 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p18so9410326edr.7;
        Fri, 13 May 2022 03:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9YzZvCjzSx23GCo5tj+e9SggYb8gkEkdJyT+dWl4gnY=;
        b=cJcPiPXqp99o/FwSgHSz3dDHbrNByGdaMRoNV0f8aJpS3zg+2rISd3a6PXxKo+wmwD
         FK3Xn9oICrrm9NlMU1HQ3GlgN/bSqErJ49SydqShN+6HMZj/BccumgW3jNDdB6CTpB7F
         Lot8D6L90KW1lHnSguAOtEJkp9JWkgE+Hf/SkuGfQ/VMv923goKITVc8VkGRZf+J5jYM
         r1Vzt8uXbsG/bQOwbSfAet236bz+eLoHrFTnR35Gd+I7otNICzstr9/A9u5FrqoxC2zb
         MwNeR2FpF2nEQz7Q162KBSh7/+hyMZe0mYPuyIDQFWrHqlqabh4fHdQQEKFsOqYxihHi
         BpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YzZvCjzSx23GCo5tj+e9SggYb8gkEkdJyT+dWl4gnY=;
        b=jfrH8vIJ7CNsWhg0rhXuKi8UD6hLEMDlV5uwDMoAbkrlMF226xzSh/K9NKQ5p5dIxU
         t16FCfvaRls1ZSpNZ8uxvR5U6Rl88TVIyWYZzcOkdAjernk13SQXUbcHN2dDUJRQ2tZG
         e4bWAuaaHBvYt1LHY+28mgUzlFNM0COSmqWzQwS4BtyclCklrfStOXFH1l5UMCl5go0r
         ftaB3r2vLj8r6sbMAGJaQ7L3xs4s1MduO4qrKuiLd1Q7xe/nMIICPDlnNbPQ72P1pLe/
         AEjKAXdQj2jMFn6B7uqqF2Ap06fFZJG9Z3gYDNvL0mirfPVmedVy717Wz2hujAYG2tZ6
         AL8g==
X-Gm-Message-State: AOAM533OMmEBPTT0H+DW+acfC/9coKCUmZJAxAXuMS/bWzH8GTQWSjEH
        5OMyYWvf55WcXCMA64H24yY=
X-Google-Smtp-Source: ABdhPJw7MD312KW+pbEyX7ADtYmRXzNeWrJMI2J8c7tAQdrK9Sg6kXBQ/efbGcHhj8qAJoQjQPZ6gw==
X-Received: by 2002:aa7:d9c8:0:b0:428:364c:df2f with SMTP id v8-20020aa7d9c8000000b00428364cdf2fmr39587358eds.327.1652437625440;
        Fri, 13 May 2022 03:27:05 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906100300b006f3ef214e40sm609677ejm.166.2022.05.13.03.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 03:27:04 -0700 (PDT)
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
Subject: [PATCH v3 2/4] ARM: dts: imx6qdl-colibri: Mux mclk for sgtl5000 with the codec node
Date:   Fri, 13 May 2022 12:26:13 +0200
Message-Id: <20220513102616.48040-3-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220513102616.48040-1-max.oss.09@gmail.com>
References: <20220513102616.48040-1-max.oss.09@gmail.com>
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

(no changes since v2)

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

