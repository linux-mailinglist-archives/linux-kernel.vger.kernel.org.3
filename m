Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC274F09C4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358793AbiDCNPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354943AbiDCNPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:15:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD0227FD6;
        Sun,  3 Apr 2022 06:13:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s11so6525980pfu.13;
        Sun, 03 Apr 2022 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfNnbuCnnrrI2HGCtTaPf9X8eo27J8q+BtzO2NSDh9k=;
        b=msjpSnH9mfT0MJbyKbKAYAlGPiFywj7VssRS8LKVrTvPfv+yQaL/arBrXDkwvBTeHS
         Pl5PmEW4ph8HkbRCw72d3PWEmtyP8UdG7U8XiS7J1ubj7LH2VFH7FArVlJO0wldZ+zvC
         FK0LyqcNErZqb5Gkf73ELnLEgBkPx5fb8f3XA1Kx2DrR4flHRAu4IVqmrTXlAn59J4xX
         bipMmU6wRFSFHAAFubY4RPRHneI8ZDr2vEfoRh9XDHBoOFiBttDnOGjfb/TEoBPHiu/p
         juZuSSz6hetC6q9XawP7aTrzwwA5ku2pqH9YZKNZ5dCYG0xTUaVnSwNyDrty9gx1/Aoe
         nmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfNnbuCnnrrI2HGCtTaPf9X8eo27J8q+BtzO2NSDh9k=;
        b=dUp+48mDlnqddYtr1EP8MLAeBjggJ6LgUVB7+dFzazqGNvs25AjzyWtx35rNhajKKS
         4e+RuDeh9Ad7Wk6ij4wm/IKGdG0Xl6kGAG49e5X7ly5ShWaAnI6Cdr2f8d+ZRRLlTSfC
         P4a23gCypgcTPN/68q5pXKOGwfxBnAmuPvPIK6areOxGw4V7oKarVJnjzNjnRCzjfseY
         njtgDB9d839PNnjxRldKA5sZqo7GMBcigN4qXZ7Rw90gAgk4X21JTFBQJY+i20cHzfhN
         CcgqYR24h6suNwVpqux5dqreFGvq3eXmMRqzvjASjg03fmqhqZ2qzrMfb4BMlhdr/+XP
         /CWw==
X-Gm-Message-State: AOAM533pTFE2J77+BP4J4juza832poH7B58YZkU/bdZHhQ9kLUW7pppU
        RuhsOlQEGuog/W2UdZJjKLU=
X-Google-Smtp-Source: ABdhPJyD4ZZ2tlGGZ3t5FpYPJIvAflp1wJMYBe0MzHuZy5qsKEI1F+UUXO5xd+Uz5hCUa1uyU0Kjmg==
X-Received: by 2002:a63:7f1c:0:b0:382:1fb5:58b8 with SMTP id a28-20020a637f1c000000b003821fb558b8mr21882197pgd.507.1648991587689;
        Sun, 03 Apr 2022 06:13:07 -0700 (PDT)
Received: from guoguo-omen.lan ([222.201.153.219])
        by smtp.gmail.com with ESMTPSA id x123-20020a623181000000b004fdf99d25f6sm1554857pfx.80.2022.04.03.06.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 06:13:07 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@lists.infradead.org
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
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: [PATCH 4/4] arm64: dts: mediatek: add dt node for MTK SNFI
Date:   Sun,  3 Apr 2022 21:11:54 +0800
Message-Id: <20220403131154.1267887-5-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220403131154.1267887-1-gch981213@gmail.com>
References: <20220403131154.1267887-1-gch981213@gmail.com>
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

This patch adds a device-tree node for the MTK SPI-NAND Flash Interface.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 6f8cb3ad1e84..40112fdca67e 100644
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
+		ecc-engine = <&bch>;
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

