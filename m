Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C334950CEF5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbiDXDaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbiDXD3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:29:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730ED105207;
        Sat, 23 Apr 2022 20:26:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y14so10983003pfe.10;
        Sat, 23 Apr 2022 20:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTSKZRhjg25O5C1jlBW1LRl5IUhwoxhhyCVs3jC3lXs=;
        b=NQEwgIsyvQM+8c91zHJp/VLeFL09cmvrN/vlUyahcrDgfjqF0SOWuHfyKAebhXKaGB
         8CDfEF/W//rKPtjwmgE/i1SsC8KrAP0TsaHOjEGv/YFAhMkXwQkEcxo7FAaj51MDJciG
         C+BZE/k+XF1IPrsGNVcTf0u0VgX9jmXoYj7RMJ8gg7I1HtnT+C3y5pO/5gQbaWYWxr4u
         Mv+yHTv0SJwqegA4QhJW9D6NITCZiLRCumAsqrYAn7mFQnBOOXBd5pA69m4NV7ItlNPt
         AKTeCQ0KuwivsKU7Sj06o2fF5omHx5+c/CwcDOh/bqTgnjst0d1r6HB5Mz6G/roFBqXn
         0kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTSKZRhjg25O5C1jlBW1LRl5IUhwoxhhyCVs3jC3lXs=;
        b=Cj9m7RCmdtALCILFdj5OxyW/l9U90FUJXn4KgJT6jL36RAyFNt5djZXftjqZGMH5WF
         N1MkK4JNGJaW2jdPYu2qGFPtTvQqjLOYmnhAZbO94opEY9TMFHhphvoWrlzryi1zCXTe
         efsz2yIRc81JO32HmJwcKSUM3dCu17fxPT0CSn7b/GCp/nA1p5yZECK/+ru1GNzyTs4n
         CH085KzTIzk1U8PYLF8jWSaXD7c/cQFhBpt8E82JVsCpZBc1v161Q4QhRY2v2dkk2AsD
         4aAz3kWl97i18kyg25HJuVvrcCqj0O6sfNWOqRG0RFpms8cvqDGqCk1s8gFnMW4t6L2p
         ektQ==
X-Gm-Message-State: AOAM532bSx4gj3ego3ww0zNTEFE3663iYr8QTgU3coyGZSPZ7frP0AFH
        c9E4QAHh8GWHSDPH1CIwKAwzkTfbByBxUzZC
X-Google-Smtp-Source: ABdhPJwnCkDmNFP2ub0LUJ5XFBOw3WVX1bkBhe4XHDPGH7PdIKzQy9kZ9No2Rbpa1oUDlTX3Rbfi3g==
X-Received: by 2002:a63:358c:0:b0:39c:c97a:ee80 with SMTP id c134-20020a63358c000000b0039cc97aee80mr9999124pga.7.1650770795849;
        Sat, 23 Apr 2022 20:26:35 -0700 (PDT)
Received: from guoguo-omen.lan ([222.201.153.219])
        by smtp.gmail.com with ESMTPSA id r76-20020a632b4f000000b003820643e1c2sm5790724pgr.59.2022.04.23.20.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 20:26:35 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: [PATCH v6 5/5] arm64: dts: mediatek: add mtk-snfi for mt7622
Date:   Sun, 24 Apr 2022 11:25:27 +0800
Message-Id: <20220424032527.673605-6-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424032527.673605-1-gch981213@gmail.com>
References: <20220424032527.673605-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a device-tree node for the MTK SPI-NAND Flash Interface
for MT7622 device tree.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Changes since v1:
  1. use the newly introduced nand-ecc-engine instead
  2. reword commit message
Change in v2-v6: none

 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index f232f8baf4e8..8c2563a3919a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -545,6 +545,18 @@ nandc: nfi@1100d000 {
 		status = "disabled";
 	};
 
+	snfi: spi@1100d000 {
+		compatible = "mediatek,mt7622-snand";
+		reg = <0 0x1100d000 0 0x1000>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_NFI_PD>, <&pericfg CLK_PERI_SNFI_PD>;
+		clock-names = "nfi_clk", "pad_clk";
+		nand-ecc-engine = <&bch>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	bch: ecc@1100e000 {
 		compatible = "mediatek,mt7622-ecc";
 		reg = <0 0x1100e000 0 0x1000>;
-- 
2.35.1

