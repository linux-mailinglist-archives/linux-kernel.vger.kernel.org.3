Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3727F4DDBE1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiCROra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237451AbiCROrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:47:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA44105051;
        Fri, 18 Mar 2022 07:45:50 -0700 (PDT)
X-UUID: 6d9d66b40ec9407480ccc2333a9d64d4-20220318
X-UUID: 6d9d66b40ec9407480ccc2333a9d64d4-20220318
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1521379821; Fri, 18 Mar 2022 22:45:41 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 18 Mar 2022 22:45:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Mar
 2022 22:45:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Mar 2022 22:45:39 +0800
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
Subject: [PATCH v4 00/22] Add driver nodes for MT8192 SoC 
Date:   Fri, 18 Mar 2022 22:45:12 +0800
Message-ID: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver nodes for MT8192 SoC and this series are based on tag: next-20220318, linux-next/master.

The current mmsys dt-binding,
Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml, doesn't define mboxes or mediatek,gce-client-reg.
Need to reference the below link
https://urldefense.com/v3/__https://lore.kernel.org/all/20220126071932.32615-2-jason-jh.lin@mediatek.com/__;!!CTRNKA9wMg0ARbw!zNfQkN-YYjiqPCd5m9DsLhrQDymgEZJoY4oSl24nC3R95P0gIXEmNjyJMhjQZXkWX7mZPa5QS7KIMlGXMbDjDA1_2A$ 

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

Allen-KH Cheng (22):
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
  arm64: dts: mt8192: Add the mmsys reset bit to reset the dsi0
  arm64: dts: mt8192: Add dsi node
  arm64: dts: mt8192: Add gce info for display nodes
  arm64: dts: mt8192: Add pwm node

 arch/arm64/boot/dts/mediatek/mt8192.dtsi  | 783 +++++++++++++++++++++-
 include/dt-bindings/reset/mt8192-resets.h |   3 +
 2 files changed, 775 insertions(+), 11 deletions(-)

-- 
2.18.0

