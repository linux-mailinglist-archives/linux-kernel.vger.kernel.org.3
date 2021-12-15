Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D4E474F83
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbhLOAs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbhLOAqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:46:55 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A418BC061574;
        Tue, 14 Dec 2021 16:46:54 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id b187so27294595iof.11;
        Tue, 14 Dec 2021 16:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIkR8EzrHf4k1kTwxT3X1hoakBOswCTAqfRPWLPPzDY=;
        b=CxMHNT394VJYAGRFV2rtbeUuKoRMXqABuZFJmOpSs78HAQjiZyQgddE/l57/ujqwt4
         pyREYq1+aWR+lJCXrAH/xV8WQhi4DIhQ8STd7G4usG0/FgAlM23JUBydO9rLtrBAljFM
         j+v6Dxie+lynyhsRF9lpoU5Aa/Rnr4YCknx0JJtuRl7jYSLWUnW2KM9k+v5Zf6ezGXgM
         i4XdqhGIcFJ5LcWJ+FeuNn5S0VxMN9n8Td989QLRYJRbMDwB1a0iXJvNT061z+raHp1+
         RxsK17MFQXo3gtISHycIRjBjmbogA2Q4fNPWpgd+GUX2l4Zc15TK13KV3kHleHmGmL4q
         QwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIkR8EzrHf4k1kTwxT3X1hoakBOswCTAqfRPWLPPzDY=;
        b=ozTKvoYGtRzNVKGtsp4IckwAd5CDKIfx/tBel7edzhjp08LS2eppxKP0XPPLY1nvjs
         eUNt/Wvwag/PxV8RUqI9CvIcn394Do86o3+dg08LpAePYTq7xgOZK7a7zBPXtUpN2Hdk
         axAK19+3vqU0+UkJ4lT+32Jbm2lRoMGr5U9orzwq9Byu1gqmtGHTf5sf5dtFHZkRrOEM
         UC+vvf5e+PlaoQ3h9oJei9gbT7piRyDOIiqNpDtA/qXwhS3bC9oDjJxI8cpA8UKI+x9l
         boxU04eN1RNF7K/WlMJ49bkBN+ZhQhoJNttn67zJV+rHALz/euCfdYdr+5xZeNeQIa1E
         hLtw==
X-Gm-Message-State: AOAM532yNBtvgo3Q0786VhtlkM3LgmAetYImg7usrKrqXM0WoQg8M/fl
        hyxcZNddPB9gb6BD7OhQNcE=
X-Google-Smtp-Source: ABdhPJze0CYHkM6dgaNTPh7XAHYQ39BuG4KMsDO8BsDV/AqfZeVUQ+wG90cjJ70JaExEw1as0RzBIg==
X-Received: by 2002:a05:6638:d01:: with SMTP id q1mr4742027jaj.388.1639529213856;
        Tue, 14 Dec 2021 16:46:53 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8256:b93c:84fb:458b])
        by smtp.gmail.com with ESMTPSA id y8sm218857iox.32.2021.12.14.16.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:46:53 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     tharvey@gateworks.com, aford@beaconembedded.com,
        michael@amarulasolutions.com, jagan@amarulasolutions.com,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 8/9] arm64: dts: imx8mn: add DISP blk-ctrl
Date:   Tue, 14 Dec 2021 18:46:25 -0600
Message-Id: <20211215004626.2241839-9-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215004626.2241839-1-aford173@gmail.com>
References: <20211215004626.2241839-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT node for the DISP blk-ctrl. With this in place the
display/mipi power domains should be functional.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 5d851420254b..dc3f66d284e5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1038,6 +1038,34 @@ aips4: bus@32c00000 {
 			#size-cells = <1>;
 			ranges;
 
+			disp_blk_ctrl: blk-ctrl@32e28000 {
+				compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
+				reg = <0x32e28000 0x100>;
+				power-domains = <&pgc_dispmix>, <&pgc_dispmix>,
+						<&pgc_dispmix>, <&pgc_mipi>,
+						<&pgc_mipi>;
+				power-domain-names = "bus", "isi",
+						     "lcdif", "mipi-dsi",
+						     "mipi-csi";
+				clocks = <&clk IMX8MN_CLK_DISP_AXI>,
+					 <&clk IMX8MN_CLK_DISP_APB>,
+					 <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
+					 <&clk IMX8MN_CLK_DSI_CORE>,
+					 <&clk IMX8MN_CLK_DSI_PHY_REF>,
+					 <&clk IMX8MN_CLK_CSI1_PHY_REF>,
+					 <&clk IMX8MN_CLK_CAMERA_PIXEL_ROOT>;
+				clock-names = "disp_axi", "disp_apb",
+					      "disp_axi_root", "disp_apb_root",
+					      "lcdif-axi", "lcdif-apb", "lcdif-pix",
+					      "dsi-pclk", "dsi-ref",
+					      "csi-aclk", "csi-pclk";
+				#power-domain-cells = <1>;
+			};
+
 			usbotg1: usb@32e40000 {
 				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb";
 				reg = <0x32e40000 0x200>;
-- 
2.32.0

