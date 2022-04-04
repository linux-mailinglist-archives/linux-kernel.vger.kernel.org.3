Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D6A4F15C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351560AbiDDNVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351320AbiDDNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:21:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB721E34;
        Mon,  4 Apr 2022 06:19:17 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id w21so8317575pgm.7;
        Mon, 04 Apr 2022 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tS+NAQ+2D7agIki50tkRPL+/ag2LxAizn5hQjD0npls=;
        b=PET9hD0TOOlxzcMYMOfT1jjstVzlrGrI95uhZTqi8ziGnO+Kvzo8GzeLdfN9KuJXb5
         dEsJUm8Ddlf7AwD3XMS/Xr8vEud0/HcAkCM0vpQqVUIo8JjWdELmuNe66OFwFOZYoQjD
         7GozIrPEnrDgYaGmcuESoUq0X2y19O4CebzlfArPMfAixrP6qVfjH1ahPxV5u78/OZUQ
         LXgDU3mxfbtjB0Rbo89eQDw/bsgR9ZE2pOXv96OiS5d2B8UFWtP156ujm7OwzrM5GT+b
         w/fHjp/86V7nVlbqjbBrRuQvdbxRVNf3ERNvNnvZf1XyiKXXL0bQ29RgW/qP0Lbej6Uh
         Oayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tS+NAQ+2D7agIki50tkRPL+/ag2LxAizn5hQjD0npls=;
        b=SVGp2PfG2N6+w7mirHr3rR8jbK4D+vhQi9IFRdYrspOOKZxZapvc4o+3CtfT/pj85+
         9tOIRdgJwYERs2LVv3xiPCN6nOYxOQ554PUHq4YrDreWvVY/yyU8eh7EHOH3IstnO8up
         bCPmWtpfvhbFTmaGyPEKljJNM4zIugCVVA+IFK/IyiwXoWNqSJycLHYAFuAUsFJAv9CM
         MglK3hLsRKPcP6zSFPA8zDcV2oLGQyQTjojldKFrSbqcnhqExSQKofLLEvgpqWl1usaK
         5eJP0zh7d0exyrPRL8gAU5jm9IDBXPq4gJUhqsBhbD2mXiZQMU79LDxDNDFBDN81XWLy
         IQrg==
X-Gm-Message-State: AOAM532kWMA7afOQOL+ijJc6pEVm9ODvPolCSzxlRcaUh2d1W67z2Wbz
        taJlZbM7hgsfB06/FP8CrG87QIAk9Yu83YX27Dg=
X-Google-Smtp-Source: ABdhPJzLAMviS73DnsYXW0jI9f5cwwNFWa83DUwdZUIbuOqsebhBjg6JkDgNrUtBEulaxOE4IIAkYw==
X-Received: by 2002:a05:6a00:182a:b0:4fd:dee2:6371 with SMTP id y42-20020a056a00182a00b004fddee26371mr12945796pfa.8.1649078357014;
        Mon, 04 Apr 2022 06:19:17 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id q13-20020a056a00088d00b004e1bea9c582sm12475705pfj.43.2022.04.04.06.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 06:19:16 -0700 (PDT)
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
Subject: [PATCH v3 5/5] arm64: dts: mediatek: add mtk-snfi for mt7622
Date:   Mon,  4 Apr 2022 21:18:18 +0800
Message-Id: <20220404131818.1817794-6-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404131818.1817794-1-gch981213@gmail.com>
References: <20220404131818.1817794-1-gch981213@gmail.com>
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
Change since v2: None
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 6f8cb3ad1e84..4b8f7dc1ec23 100644
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

