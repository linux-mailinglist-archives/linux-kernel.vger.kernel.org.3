Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB94F8280
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbiDGPKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiDGPKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:10:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1911F081E;
        Thu,  7 Apr 2022 08:08:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id kw18so5842486pjb.5;
        Thu, 07 Apr 2022 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrtvb4212It3IhUoSO26JM4Kh2WKJPNfVyn34wMno3s=;
        b=CdKoyvFYtcgYgIoynZn9xJOG4ouYERktRTxynaEiC2GYuw4iKl+zzb8DOXVBUCqchY
         kD3Cca7aLaBOPFeQqIRdyNoAOvb730Fy04LKCPyKRm6ExlPltGoj8CxZQib03AVtDF4n
         W/XwpGD49YOQQKXySra6y7MBmlkN7X7riVsofaERvlAqwHe7DDrr0WxbJ/a+VJttVqcZ
         npjBJsxu5zTBm4xvfTZzfttZu6WYp/u6nmaHIGehEmTPEilAn/LeGwXz6zPGOe9iUSzY
         bXDgJV8SfpyJka/V0NuQQ0tFquxzhm+7dLoQtIw3NUYJMjOnltyCtZWiVprPWmb99Rss
         NWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrtvb4212It3IhUoSO26JM4Kh2WKJPNfVyn34wMno3s=;
        b=mGAqOQVS3Ut23az79zQiG1YTqp3ltBbiyYrAmqy0wQ2YZWkBSO5WAniGhMEAm3Jz7t
         Qk0wETjiB1A1EY2kByw6dy/TPVzLgQ/BGxJcHczvRcWnIVjVUy4cZQRFowcgukFGNWL5
         d9e549NbfsPppkBO0OQNUWTzTuR24lgucQGyzQVbDHQ4DIKctBmfNciH/jvLOzy62Ds8
         UvfwK9kNLPEy+EsFeaK0I6czPXRpqQ4i1X61vQ9MBisBLA3Qg/e64cszgVOHCyID7hVn
         4d+0sPuTwU8ZGgq/ltIvVE2kv459t3b+bs2Ft/9Z082u14EtHCla6AAo5xWj/2UHV8bF
         0STg==
X-Gm-Message-State: AOAM5321WEhbaGP2euaazlYSPJOmIyqUHCknuPSW3CpP+SjqFSsKJm+Q
        kKDQUiPs5xkwTAAp6SNvfm1yTldkKRitB24wagk=
X-Google-Smtp-Source: ABdhPJwo9sQWb5/mta+s4Cyd7+A2btFwfuVblu9GNLlR6RUcNF57pVGnmshWcIMgUsebh44jAvBnpg==
X-Received: by 2002:a17:902:cec2:b0:154:6df6:1e6a with SMTP id d2-20020a170902cec200b001546df61e6amr14428036plg.58.1649344069155;
        Thu, 07 Apr 2022 08:07:49 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id x2-20020a63aa42000000b0038265eb2495sm19329908pgo.88.2022.04.07.08.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 08:07:48 -0700 (PDT)
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
Subject: [PATCH v4 5/5] arm64: dts: mediatek: add mtk-snfi for mt7622
Date:   Thu,  7 Apr 2022 23:06:52 +0800
Message-Id: <20220407150652.21885-6-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407150652.21885-1-gch981213@gmail.com>
References: <20220407150652.21885-1-gch981213@gmail.com>
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
Change since v2: none
Change since v3: none

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

