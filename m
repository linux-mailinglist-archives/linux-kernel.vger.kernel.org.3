Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C16B4CD4B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiCDNJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiCDNJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:09:10 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CB54DF7D;
        Fri,  4 Mar 2022 05:08:19 -0800 (PST)
X-UUID: 25015b17d6594d529719ea8606100674-20220304
X-UUID: 25015b17d6594d529719ea8606100674-20220304
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1496070713; Fri, 04 Mar 2022 21:08:13 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 4 Mar 2022 21:08:11 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 4 Mar
 2022 21:08:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Mar 2022 21:08:11 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v3 00/21] Add driver nodes for MT8192 SoC 
Date:   Fri, 4 Mar 2022 21:07:48 +0800
Message-ID: <20220304130809.12924-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver nodes for MT8192 SoC and this series are based on tag: next-20220304, linux-next/master.

The current mmsys dt-binding,
Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml, doesn't define mboxes or mediatek,gce-client-reg.
Need to reference the below link
https://urldefense.com/v3/__https://lore.kernel.org/all/20220126071932.32615-2-jason-jh.lin@mediatek.com/__;!!CTRNKA9wMg0ARbw!zNfQkN-YYjiqPCd5m9DsLhrQDymgEZJoY4oSl24nC3R95P0gIXEmNjyJMhjQZXkWX7mZPa5QS7KIMlGXMbDjDA1_2A$ 

changes since v2:
- rebase on next-20220304
- remove power domains controller patch from series (already in linux-next)
- scp: fix indentation
- t-phy: change node name from usb-phy to t-phy and set ranges address
- usb: change node name from xhci to usb and add disabled status
- audsys: syscon: add increasing the address range's length info in commit message
- infracfg_rst: add simple-mfd info in commit message
- nor_flash: add Fixes tag d0a197a0d064a in  commit message
- efuse: use lower case characters
- mmc: use single line for reg
- mipi_tx: change node name from mipi-dphy to dsi-phy, drop clock-names and add disabled status
- m4u and smi: fixing the formatting of the mediatek,larbs properties and remove smi-id property
- H264 venc: fix indentation, remove '0x' prefix for node address
- vcodec lat and core: use '-' instead of '_' in the node name, fix indentation and
  set mtk-vcodec-lat and mtk-vcodec-core as subnodes of vcodec-dec
- dpi: add disabled status
- display: appended "mediatek,mt8183-disp-aal" for ccorr
- dsi: fix indentation and add disabled status
- gce info: add drivers' CMDQ support inn commit message
- pwm: add disabled status
- i2c aliases: move the aliases at the board level.

changes since v1:
- add usb-phy node for xhci node
- move infracfg_rst patch in front of PCIe patch
- add display nodes, i2c aliases and pwm node.

Allen-KH Cheng (21):
  arm64: dts: mt8192: Add pwrap node
  arm64: dts: mt8192: Add spmi node
  arm64: dts: mt8192: Add gce node
  arm64: dts: mt8192: Add SCP node
  arm64: dts: mt8192: Add usb-phy node
  arm64: dts: mt8192: Add xhci node
  arm64: dts: mt8192: Add audio-related nodes
  arm64: dts: mt8192: Add infracfg_rst node
  arm64: dts: mt8192: Add PCIe node
  arm64: dts: mt8192: Fix nor_flash status disable typo
  arm64: dts: mt8192: Add efuse node
  arm64: dts: mt8192: Add mmc device nodes
  arm64: dts: mt8192: Add mipi_tx node
  arm64: dts: mt8192: Add m4u and smi nodes
  arm64: dts: mt8192: Add H264 venc device node
  arm64: dts: mt8192: Add vcodec lat and core nodes
  arm64: dts: mt8192: Add dpi node
  arm64: dts: mt8192: Add display nodes
  arm64: dts: mt8192: Add dsi node
  arm64: dts: mt8192: Add gce info for display nodes
  arm64: dts: mt8192: Add pwm node

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 778 ++++++++++++++++++++++-
 1 file changed, 767 insertions(+), 11 deletions(-)

-- 
2.18.0

