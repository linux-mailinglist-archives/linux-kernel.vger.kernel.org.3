Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8FD4EC5C1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346130AbiC3NkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiC3NkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:40:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B57A2BF0;
        Wed, 30 Mar 2022 06:38:23 -0700 (PDT)
X-UUID: bdb7026bd0344eeab51be161c178fe34-20220330
X-UUID: bdb7026bd0344eeab51be161c178fe34-20220330
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1822432979; Wed, 30 Mar 2022 21:38:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Mar 2022 21:38:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Mar 2022 21:38:17 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v5 0/4] Add driver nodes for MT8192 SoC 
Date:   Wed, 30 Mar 2022 21:38:12 +0800
Message-ID: <20220330133816.30806-1-allen-kh.cheng@mediatek.com>
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

Add driver nodes for MT8192 SoC and this series are based on matthias.bgg/linux.git, v5.18-next/dts64
(PCIe, mmc, H264 venc, vcodec lat and core nodes)

In order to track the dependencies of some patches, I remove them from this series and will
send a new series for each node. (spmi, gce, infracfg_rst, mipi_tx, dpi, display, dsi, gce info and pwm)

changes since v4:
- remove some patches from this series.
- PCIe: remove reset node, correct the clk names
- mmc: reserve msdc node
- vcodec: correct the clk names (remove vdec- prefix)

changes since v3:
- add patch: add the mmsys reset bit to reset the dsi0
- dsi0: use mmsys for reset controller support
- mmc: reorder clocks as specified in the dt-bindings
- vcodec: use ranges for regs of subnodes

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

Allen-KH Cheng (4):
  arm64: dts: mt8192: Add PCIe node
  arm64: dts: mt8192: Add mmc device nodes
  arm64: dts: mt8192: Add H264 venc device node
  arm64: dts: mt8192: Add vcodec lat and core nodes

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 150 +++++++++++++++++++++++
 1 file changed, 150 insertions(+)

-- 
2.18.0

