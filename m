Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBDA58FCF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiHKM6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbiHKM6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:58:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6756FA14;
        Thu, 11 Aug 2022 05:58:14 -0700 (PDT)
X-UUID: 7f172b1bea76499eac95a50111932633-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=heTuLO5w5bRhg77sCY/T5elSQuTrqyZATEgIg4GEwGY=;
        b=njHEOJJgPIBccp5FOoWS2+a0uZUd28in4ozgUstAw0Xav19sSygBxqKx7yMhX4TBUCXBeBL5rDn5z1DWw3UvhSvBc4az6dppFNla/2fhIcMKdPi+82uz+I29fg1ZNtPaFKGYKQcjqGzWCkm5wJJBxt6th4wddGRyBy4B5RsV+j0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:fb6884ec-9b96-4707-9321-e6b3469d9b73,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:-5
X-CID-META: VersionHash:3d8acc9,CLOUDID:bb96649c-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7f172b1bea76499eac95a50111932633-20220811
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1201883101; Thu, 11 Aug 2022 20:58:09 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 11 Aug 2022 20:58:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 11 Aug 2022 20:58:08 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v14 0/1] Add basic node support for MediaTek MT8186 SoC
Date:   Thu, 11 Aug 2022 20:58:04 +0800
Message-ID: <20220811125805.28577-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8186 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
and 2 CA76 cores. MT8186 share many HW IP with MT65xx series. This
patchset was tested on MT8186 evaluation board to shell. This series
is based on tag: tag: next-20220811, origin/master

Since we have a another dts series of mt8195[1] which is waiting for
review from maintainers. we remove power domains controller node from
this mt8186 series and because the power domains controller is required
for dsi, we also need to remove dsi node. Those will be updated on another
patchi in the feature.

Based on Comments in [2], we use "mediatek,mt8186-wdt", "mediatek,mt6589-wdt"
instead of "mediatek,mt8186-wdt" according to bindings definition.

There is a correction in mt8186 hardware bindings. We need to apply it
[3].

[1]
https://patchwork.kernel.org/project/linux-mediatek/list/?series=663978
[2]
https://patchwork.kernel.org/project/linux-mediatek/patch/20220721014845.19044-2-allen-kh.cheng@mediatek.com/
[3]
https://patchwork.kernel.org/project/linux-mediatek/patch/20220720130604.14113-2-allen-kh.cheng@mediatek.com/

changes since v13:
 - use "mediatek,mt8186-wdt", "mediatek,mt6589-wdt" in wdt node
 - remove dsi node

changes since v12:
 - remove drive-strength fom i2c pins
 - use lowercase hex addresses in pinctrl node
 - correct clk order in xhci0
 - add clk26m for dma_ck

changes since v11:
 - add #cooling-cells in cpu nodes
 - add pmu nodes for mt8186
 - change #interrupt-cells from 3 to 4
 - correct interrupts property in each nodes for 4 interrupt cells
 - remove power domains controller node
 - move #address-cells and #size-cells into mt8186.dts
 - remove unused ahb_cg clock in mmc0
 - add efuse node
 - add dsi node and remove dpi node
 - move i2c status position in mt8186-evb.dts
 - change i2c child nodee name in pio node to *-pins
 - change property from mediatek,drive-strength-adv to drive-strength-microamp in i2c child nodes of pio
 - change drive-strength value from MTK_DRIVE_4mA to 4 in i2c child nodes of pio
 - change i2c child nodes from pins-sda-sc1 to pins-bus
 - correct pintctrl clk names

changes since v10:
 - remove merged PATCHes
 - add pmu nodes
 - add #cooling-cells
 - change #interrupt-cells number from 3 to 4
 - remove power domains controller node
 - move #address-cells/#size-cells into mt8186.dts from evb dts for i2c
 - move status = 'okay' position in i2cx
 - fix pinctrl patternproperties name in pio
 - add efuse node
 - fix dsi node
 - add #reset-cells in infracfg_ao: syscon

changes since v9:
 - remove some merged PATCHs from series
 - reorder nodes in dts (cpu-map)
 - remove okay status in auxadc
 - remove unnecessary suffix node name for i2c
 - add pwm node 
 - add dsi-phy node 
 - add dpi node 

changes since v9:
 - add one space before equal sign of drive-strength-adv
 - corect compatible name for big cores (ca76)
 - use upper case of address in pinctrl
 - add pwrap node
 - add pwm node

changes since v8:
 - change name from pins_bus to pins-sda-scl
 - correct email address
 - add capacity-dmips-mhz for each CPU
 - add ppi-partitions in gic node
 - change name to power-domain
 - remove status "okay" in scp node
 - update timer and pericfg compatible in series

changes since v7:
 - add scp&auxadc node

changes since v6:
 - remove unnecessary blank line

changes since v5:
 - replace Mediatek a to MediaTek
 - use GPL-2.0-only OR BSD-2-Clause

changes since v4:
 - correct driver clock of mt8186
 - add power domains controller and clock controllers
 - add pinctrl, usb host, spi and i2c nodes
 - add node status in mt8186-evb.dts
 - correct some dtbs_check warnings

changes since v3:
 - remove serial, mmc and phy patch from series. (already merged)
 - remove mcusysoff node
 - move oscillator nodes at the head of dts
 - change name from usb-phy to t-phy

changes since v2:
 - add soc {} in mt8186.dtsi

changes since v1:
 - add dt-bindings: arm: Add compatible for MediaTek MT8186

Allen-KH Cheng (1):
  arm64: dts: Add MediaTek MT8186 dts and evaluation board and Makefile

 arch/arm64/boot/dts/mediatek/Makefile       |   1 +
 arch/arm64/boot/dts/mediatek/mt8186-evb.dts | 228 ++++++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi    | 858 ++++++++++++++++++++
 3 files changed, 1087 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi

-- 
2.18.0

