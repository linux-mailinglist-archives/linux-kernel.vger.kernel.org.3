Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3868F4F09D8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358211AbiDCNSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358848AbiDCNRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:17:54 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF002655;
        Sun,  3 Apr 2022 06:16:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id z128so6189365pgz.2;
        Sun, 03 Apr 2022 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfNnbuCnnrrI2HGCtTaPf9X8eo27J8q+BtzO2NSDh9k=;
        b=W3nkE02niUtCrxE60qZnIXFqTLuGGvXDYFbmnRBXtm/ZI/VAaXcw5Xqus7HTQbkvdf
         KcTVM2bCrQvDizRqNs1kkHCoCJPAFWRVua/OlPfzEv3KPcxO7/5QbM/9q7tzL4fgz1fU
         QMhjc7VCxFA0/uoNb81LtTr1T7dEuey8rdOs2vRA8HrrwjpRyIDLFN7eSi1zhku9usof
         YTqs4werHRBOJCiInOUh9+WTLSSKsDMLf6wqqwaSz4jFavLDz1CAX8FhNygGWLzjNVPL
         4mUBwf4QV0foNL6m3R+QPVRfvtelSWp8AkxV+NiybpiRY7EULKXGctBBK4DhcaH+VY31
         Aa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfNnbuCnnrrI2HGCtTaPf9X8eo27J8q+BtzO2NSDh9k=;
        b=umBBUy+NviWWRpYUH/bCJLxiufXVhIlRoXHOEURuo7r9NDXQpGtTt3BwGviQUF9C8J
         RyrmvAVN63qEIzjCdPn7hO+N8ymtt2YsgvKsGoNSBg4tGX5s1jBvphDJ6VPVAAde6bOu
         e3fT9vQteHJTKyMN3PvIsgbRnixQf1JAsdFCaUYHAy3PG2cDg38hN+Jf7W5JcH/FpUz8
         NOMikGuuk0AX0BFq8DyiNV0Uf+A/M3SPN9wpHPV0BEFbWWGlcx3eENNOoNn7zkdiHxsk
         HYKTRrBwJc8HTOrJ4OFjt6FTH9n55NlT9FnH9Gqwx8dIb56zTU8hNsoEVZJzadT+439y
         8rNw==
X-Gm-Message-State: AOAM532ycXNjEfCxIU4vLpXBYpoocJI4OlYIH+buvxJGS/Yj8Aqm7J/r
        mbbWnPrUXkNmTXpvrV3fYNYXzC6jR+ek0WPhdaU=
X-Google-Smtp-Source: ABdhPJx/jqW9K6zA3FxhpAum6lnTJzCHjiUWOeOnYjnncDZjy24UF+xT1PnUpPoXV4vMBSuGDYAStw==
X-Received: by 2002:a05:6a00:124f:b0:4fb:2608:78de with SMTP id u15-20020a056a00124f00b004fb260878demr19139111pfi.27.1648991760243;
        Sun, 03 Apr 2022 06:16:00 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:7978:d40d:86ff:591d])
        by smtp.gmail.com with ESMTPSA id w19-20020a056a0014d300b004fae5e3970csm9272416pfu.35.2022.04.03.06.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 06:16:00 -0700 (PDT)
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
Subject: [PATCH resend 4/4] arm64: dts: mediatek: add dt node for MTK SNFI
Date:   Sun,  3 Apr 2022 21:14:53 +0800
Message-Id: <20220403131453.1269229-5-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220403131453.1269229-1-gch981213@gmail.com>
References: <20220403131453.1269229-1-gch981213@gmail.com>
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

