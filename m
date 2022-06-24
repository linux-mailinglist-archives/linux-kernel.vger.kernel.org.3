Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD613559A36
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiFXNNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiFXNNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:13:14 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306C211454;
        Fri, 24 Jun 2022 06:13:09 -0700 (PDT)
Received: from droid11-sz.amlogic.com (10.28.8.21) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Fri, 24 Jun 2022
 21:13:00 +0800
From:   Liang Yang <liang.yang@amlogic.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v7 0/5] fix the meson NFC clock
Date:   Fri, 24 Jun 2022 21:12:50 +0800
Message-ID: <20220624131257.29906-1-liang.yang@amlogic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.21]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EMMC and NAND have the same clock control register named 'SD_EMMC_CLOCK'
which is defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is
the divider and bit6~7 is the mux for fix pll and xtal. At the beginning,
a common MMC and NAND sub-clock was discussed and planed to be implemented
as NFC clock provider, but now this series of patches of a common MMC and
NAND sub-clock are never being accepted and the current binding was never
valid. the reasons are:
1. EMMC and NAND, which are mutually exclusive anyway
2. coupling the EMMC and NAND.
3. it seems that a common MMC and NAND sub-clock is over engineered.
and let us see the link for more information:
https://lore.kernel.org/all/20220121074508.42168-5-liang.yang@amlogic.com
so The meson nfc can't work now, let us rework the clock.

Changes since v6 [7]
 - use COMMON_CLK instead of !HAVE_LEGACY_CLK

Changes since v5 [6]
 - add change log for patch 3/5
 - add patch 5/5 to fix the reporting error of test robot

Changes since v4 [5]
 - split the dt binding patch into two patches, one for fixing, 
   clock, the other for coverting to yaml
 - split the nfc driver patch into two patches, one for fixing 
   clock, the other for refining the get nfc resource.

Changes since v3 [4]
 - use devm_platform_ioremap_resource_byname
 - dt_binding_check for mtd/amlogic,meson-nand.yaml

Changes since v2 [3]
 - use fw_name from dts, instead the wrong way using __clk_get_name
 - reg resource size change to 0x800
 - use reg-names

Changes since v1 [2]
 - use clk_parent_data instead of parent_names
 - define a reg resource instead of sd_emmc_c_clkc 

[1] https://lore.kernel.org/r/20220106033130.37623-1-liang.yang@amlogic.com
    https://lore.kernel.org/r/20220106032504.23310-1-liang.yang@amlogic.com
[2] https://lore.kernel.org/all/20220217063346.21691-1-liang.yang@amlogic.com
[3] https://lore.kernel.org/all/20220318124121.26117-1-liang.yang@amlogic.com
[4] https://lore.kernel.org/all/20220402074921.13316-1-liang.yang@amlogic.com/
[5] https://lore.kernel.org/all/20220513123404.48513-1-liang.yang@amlogic.com/
[6] https://lore.kernel.org/all/20220607064731.13367-1-liang.yang@amlogic.com/

Liang Yang (5):
  dt-bindings: nand: meson: fix meson nfc clock
  mtd: rawnand: meson: fix the clock
  mtd: rawnand: meson: refine resource getting in probe
  dt-bindings: nand: meson: convert txt to yaml
  mtd: rawnand: meson: not support legacy clock

 .../bindings/mtd/amlogic,meson-nand.txt       | 60 -------------
 .../bindings/mtd/amlogic,meson-nand.yaml      | 88 +++++++++++++++++++
 drivers/mtd/nand/raw/Kconfig                  |  2 +-
 drivers/mtd/nand/raw/meson_nand.c             | 86 +++++++++---------
 4 files changed, 131 insertions(+), 105 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml

-- 
2.34.1

