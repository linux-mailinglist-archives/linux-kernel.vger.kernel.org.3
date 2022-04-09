Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7C54FA781
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241768AbiDIMLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbiDIMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:11:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDC4A5E91;
        Sat,  9 Apr 2022 05:09:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 2so10954044pjw.2;
        Sat, 09 Apr 2022 05:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X2EWpn+6zXv1xmcH8X/db35fCjSMxjasklgZRmyt+K4=;
        b=SP7h7/bTN5UCHbTLEfWi+32Mvf2ij+k26fzw4v+NICFPk5dhePVz65ZByMmcwfOtaV
         hTdePxgIZoTIei0P78oB1S7Kk0ym4QiI+4GGQnzGM8zg6K1dYMWWdho7kHOcHg+KXvC7
         OEnhhOrFXIY9+W4mmKAKlDBsG2dGUkxcS7p4NLUniXZ1l8dbGxMhG0xgBdVvOAPnoD3U
         mHTUNhhJDziX2CegEVU4YDXQQvd8UuzDA/z/PbBmYTBbgFaGbn0y8gVeQSD9sxdRMKKu
         JKXDJPr/n1oRbRtyzfiHkWUlxF1guXGMLLQht0pJ38LGQOwoQM5KxI8BRpDhpPJtPWjo
         KmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X2EWpn+6zXv1xmcH8X/db35fCjSMxjasklgZRmyt+K4=;
        b=u/ir6QNzklXXyjIMvcKqjLDWudT4jhkYYxI86HsNmt8lw5AsXUBz9Z54r9RvUAhoWu
         622JrQ8Yr6VHl+By9g8jhKqYtwFmZQNQvcrohhwbQ4WaOn4w9bGLupPlnAZ0jsU1+FFm
         ZUgLp3xJMWao1r/iz1OjvIhD+pqkT2L1uX4uBbTOOY/GNTF6+hdmEL1XtkkoMJBpgzPw
         5qKD4lVjfR+ntPtUYy/B3EDtAv4Mk772r+0alky6AJj9p+SfpafwJMTwRsYsEXwCKSVw
         diXnJSTAlcf+MDpYKqopWl4c8HfaO5a1CO2y8R1GlIsfUEBfIkM73HJbn2WisrdQ+cMb
         55fQ==
X-Gm-Message-State: AOAM531j7k6sD76dhUREOimZBAPH5xgq6eIYi2V2NM6h04te/K7Yxyb5
        P8a9SM/uGuQPN8FSscUHmdKavOoS38vJywT2KrE13w==
X-Google-Smtp-Source: ABdhPJwc8r/p0057XWNzs8kB43AH/8e05JMFItJFo9731KrL+XTpCkDSMZwiy3IsRG4c5x5fgubT9w==
X-Received: by 2002:a17:90b:94a:b0:1cb:1338:c370 with SMTP id dw10-20020a17090b094a00b001cb1338c370mr14043954pjb.45.1649506169164;
        Sat, 09 Apr 2022 05:09:29 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id a85-20020a621a58000000b0050569a135besm8307357pfa.201.2022.04.09.05.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 05:09:28 -0700 (PDT)
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
Subject: [PATCH v5 5/5] arm64: dts: mediatek: add mtk-snfi for mt7622
Date:   Sat,  9 Apr 2022 20:08:19 +0800
Message-Id: <20220409120819.3124209-6-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409120819.3124209-1-gch981213@gmail.com>
References: <20220409120819.3124209-1-gch981213@gmail.com>
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

This patch adds a device-tree node for the MTK SPI-NAND Flash Interface
for MT7622 device tree.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Changes since v1:
  1. use the newly introduced nand-ecc-engine instead
  2. reword commit message
Change in v2-v5: none

 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 47d223e28f8d..097c625ed858 100644
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

