Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32671470697
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbhLJRFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:05:10 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49426 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235987AbhLJRFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:05:09 -0500
X-UUID: 72d2782b45164d26b7af5cbbeb102d9b-20211211
X-UUID: 72d2782b45164d26b7af5cbbeb102d9b-20211211
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 659292089; Sat, 11 Dec 2021 01:01:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Dec 2021 01:01:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:01:30 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, JB Tsai <jb.tsai@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [PATCH v4 0/8] Add Support for MediaTek MT8192 APU Power Domain
Date:   Sat, 11 Dec 2021 01:01:05 +0800
Message-ID: <20211210170113.30063-1-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek AI Processing Unit (APU) is a proprietary hardware
in the SoC to support AI operations.
The series is to create apusys in the SoC folder for developing
the related drivers. Add the apu clocks, basic apu nodes and the
power domain to provide the power controller of APU subsystem.

This series is based on MT8192 power domain[1], PWRAP[2]
and PMIC MT6359[3] patches.
[1] https://patchwork.kernel.org/patch/12456165
[2] https://patchwork.kernel.org/patch/12134935
[3] https://patchwork.kernel.org/patch/12140237

Change notes:
v3->v4:
  1) Rebase to 5.16-rc1
  2) Update mtk-apu-pm driver to be a module or a buildin driver.
  3) Fix coding defects and typo in mtk-apu-pm.c and update
     copyright in dt-bindins.
  4) Split the mt8192 EVB device tree "mt8192-evb.dts" to a new patch
     file in the series.

v2->v3:
  1) Rebase to 5.15-rc1
  2) remove the apu-mbox registers from syscon.
  3) update mtk-apu-pm to fix clock flow and move power status bit into
     platform data to support different hardware settings.

v1->v2:
  1) update expression "s/_/-/" in dt-bindings documents.
  2) drop apu power domain header file for mt8192.

v1: https://patchwork.kernel.org/project/linux-mediatek/list/?series=461999

Flora Fu (8):
  dt-bindings: clock: Add MT8192 APU clock bindings
  clk: mediatek: mt8192: Add APU clocks support
  dt-bindings: arm: mediatek: Add new document bindings for APU
  dt-bindings: soc: mediatek: apusys: Add new document for APU power
    domain
  soc: mediatek: apu: Add apusys and add apu power domain driver
  arm64: dts: mt8192: Add APU node
  arm64: dts: mt8192: Add APU power domain node
  arm64: dts: mt8192: Set up apu power domain regulators

 .../arm/mediatek/mediatek,apusys.yaml         |  50 ++
 .../soc/mediatek/mediatek,apu-pm.yaml         | 144 ++++
 arch/arm64/boot/dts/mediatek/mt8192-evb.dts   |   7 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  39 +
 drivers/clk/mediatek/clk-mt8192.c             |  91 +++
 drivers/soc/mediatek/Kconfig                  |  12 +
 drivers/soc/mediatek/Makefile                 |   1 +
 drivers/soc/mediatek/apusys/Kconfig           |  14 +
 drivers/soc/mediatek/apusys/Makefile          |   2 +
 drivers/soc/mediatek/apusys/mtk-apu-pm.c      | 727 ++++++++++++++++++
 include/dt-bindings/clock/mt8192-clk.h        |  14 +-
 11 files changed, 1099 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
 create mode 100644 drivers/soc/mediatek/apusys/Kconfig
 create mode 100644 drivers/soc/mediatek/apusys/Makefile
 create mode 100644 drivers/soc/mediatek/apusys/mtk-apu-pm.c

-- 
2.18.0

