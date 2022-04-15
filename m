Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A5D502E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356062AbiDORC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356056AbiDORC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:02:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339B546BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:00:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i20so11251275wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+DtrWZQmLbh6BgPYAsMpSHPxDFToRkqobGkqBOET+Pc=;
        b=xWkLOaddSO4SKchm0277aiMkAwx1ZOGp2XXeXJPSksUvO3GmJz5BK80b5J3dEBY6EN
         wnhgzaisOm6LgOJeZz4wWQqDiZtCEiYb4OTacJJhH/O8QMp4a+YKmFVmyfCCNm+IhkUD
         Ufwd1uH5BIH8fK/LnX4C7Qlz5BgYuDifZGO3cC2VJsCnM2tqVC0x4M8cGPsRRzsW6Bbk
         XAKP5wmNFTST8DJsrASlC6AmOYIOo77PiEYCi+g/ctpZ77Tm7Ybq2uamx7aCKJSwP/dw
         c+UJ31dqtfTz1LQa1GpLWxscDkanxRdBLlLaambeawWsJdFNuFqzWJecW7iSoGUVR3DI
         r9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DtrWZQmLbh6BgPYAsMpSHPxDFToRkqobGkqBOET+Pc=;
        b=St63GPOt8WWOq2F58wL73vkQStT09LX8euaP7ofF54s9NwbEUUx0+f8OPUIVFi7r18
         Dbnb/HcnHieDPM6pgCAE9oONVduUn0WzxEaKcGDY0OlaCg5x08A/Ld7l2Ha2/ETxUllZ
         O+Bo1RUjQhH8WFP5bpfAs+h9lE82gXXL8Npq+WOGaibPeOVh81uiQ9CnnKJMkKrgs0pA
         +LYZt9T8ohB7WEXWiKRhCx3mPl2D+7JRLF0kNWWvt4cDtt/fZcaX9d6z92XG441DicOp
         cjDydT8H5fpkiGeUHgZpQtf1j2f5Cjtlzab/e9qpzly5pYBejmg3j9eK2+nqiW3emmE1
         CBAQ==
X-Gm-Message-State: AOAM533pm/SnKQ3wo4MJ5Icx7gfh+yah7MYdBs0vP+7Oqu5lIeCpS3yL
        NvT7HuUeIJ3n7SdZyamCbSDwSA==
X-Google-Smtp-Source: ABdhPJyvWQj30Y6+u8XT8aJ4AK2kwz8H/ZsRhCjD+JCTOfHK6pVtnfj5JXf8eLkK9T8Dh119HuzfcA==
X-Received: by 2002:a5d:48ca:0:b0:207:b62b:7483 with SMTP id p10-20020a5d48ca000000b00207b62b7483mr81653wrs.349.1650042027083;
        Fri, 15 Apr 2022 10:00:27 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id i127-20020a1c3b85000000b00391a363f5adsm2119704wma.36.2022.04.15.10.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 10:00:26 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8195: add UFS HCI node
Date:   Fri, 15 Apr 2022 18:59:39 +0200
Message-Id: <20220415165939.1861470-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415165939.1861470-1-fparent@baylibre.com>
References: <20220415165939.1861470-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the node for the UFS HCI controller for the MediaTek MT8195 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index b57e620c2c72..2255e19cc3b2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -619,6 +619,30 @@ mmc2: mmc@11250000 {
 			status = "disabled";
 		};
 
+		ufshci: ufshci@11270000 {
+			compatible = "mediatek,mt8195-ufshci",
+				     "mediatek,mt8183-ufshci";
+			reg = <0 0x11270000 0 0x2300>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&ufsphy>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_AES_UFSFDE>,
+				 <&infracfg_ao CLK_INFRA_AO_AES>,
+				 <&infracfg_ao CLK_INFRA_AO_UFS_TICK>,
+				 <&infracfg_ao CLK_INFRA_AO_UNIPRO_SYS>,
+				 <&infracfg_ao CLK_INFRA_AO_UNIPRO_TICK>,
+				 <&infracfg_ao CLK_INFRA_AO_UFS_MP_SAP_B>,
+				 <&infracfg_ao CLK_INFRA_AO_UFS_TX_SYMBOL>,
+				 <&infracfg_ao CLK_INFRA_AO_PERI_UFS_MEM_SUB>;
+			clock-names = "ufs", "ufs_aes", "ufs_tick",
+				      "unipro_sysclk", "unipro_tick",
+				      "unipro_mp_bclk", "ufs_tx_symbol",
+				      "ufs_mem_sub";
+			freq-table-hz = <0 0>, <0 0>, <0 0>,
+					<0 0>, <0 0>, <0 0>,
+					<0 0>, <0 0>;
+			status = "disabled";
+		};
+
 		xhci1: usb@11290000 {
 			compatible = "mediatek,mt8195-xhci",
 				     "mediatek,mtk-xhci";
-- 
2.35.2

