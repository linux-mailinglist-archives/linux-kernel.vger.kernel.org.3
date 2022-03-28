Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E04D4E974A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242793AbiC1NHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbiC1NHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:07:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFEF5FD9;
        Mon, 28 Mar 2022 06:05:36 -0700 (PDT)
X-UUID: 9958799102904dd99c0d53d6590b66b2-20220328
X-UUID: 9958799102904dd99c0d53d6590b66b2-20220328
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1081657017; Mon, 28 Mar 2022 21:05:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 28 Mar 2022 21:05:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Mar 2022 21:05:30 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 00/15] MediaTek MT8186 clock support
Date:   Mon, 28 Mar 2022 21:05:06 +0800
Message-ID: <20220328130521.24385-1-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch series is based on 5.17-rc1 and depends on
[1]"clk: mediatek: Cleanups and Improvements - Part 1"

changes since v3:
- re-order linux and internal driver header
- remove redundant lock in mcusys muxes
- add more description for mcusys clock driver

changes since v2:
- add '|' to preserve the formatting in binding document
- change 'Mediatek'to 'MediaTek'

changes since v1:
- combine dt-binding documents as a single patch
- remove redundant example in binding document
- change to dual license in binding document
- add more clock error handle based on interface provided in [1]

[1]https://patchwork.kernel.org/project/linux-mediatek/list/?series=612171

Chun-Jie Chen (15):
  dt-bindings: ARM: MediaTek: Add new document bindings of MT8186 clock
  clk: mediatek: Add MT8186 mcusys clock support
  clk: mediatek: Add MT8186 topckgen clock support
  clk: mediatek: Add MT8186 infrastructure clock support
  clk: mediatek: Add MT8186 apmixedsys clock support
  clk: mediatek: Add MT8186 imp i2c wrapper clock support
  clk: mediatek: Add MT8186 mfgsys clock support
  clk: mediatek: Add MT8186 mmsys clock support
  clk: mediatek: Add MT8186 wpesys clock support
  clk: mediatek: Add MT8186 imgsys clock support
  clk: mediatek: Add MT8186 vdecsys clock support
  clk: mediatek: Add MT8186 vencsys clock support
  clk: mediatek: Add MT8186 camsys clock support
  clk: mediatek: Add MT8186 mdpsys clock support
  clk: mediatek: Add MT8186 ipesys clock support

 .../arm/mediatek/mediatek,mt8186-clock.yaml   |  56 ++
 .../mediatek/mediatek,mt8186-sys-clock.yaml   |  54 ++
 drivers/clk/mediatek/Kconfig                  |   8 +
 drivers/clk/mediatek/Makefile                 |   5 +
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c  | 133 +++
 drivers/clk/mediatek/clk-mt8186-cam.c         |  90 ++
 drivers/clk/mediatek/clk-mt8186-img.c         |  68 ++
 .../clk/mediatek/clk-mt8186-imp_iic_wrap.c    |  67 ++
 drivers/clk/mediatek/clk-mt8186-infra_ao.c    | 216 +++++
 drivers/clk/mediatek/clk-mt8186-ipe.c         |  55 ++
 drivers/clk/mediatek/clk-mt8186-mcu.c         | 108 +++
 drivers/clk/mediatek/clk-mt8186-mdp.c         |  80 ++
 drivers/clk/mediatek/clk-mt8186-mfg.c         |  48 ++
 drivers/clk/mediatek/clk-mt8186-mm.c          | 111 +++
 drivers/clk/mediatek/clk-mt8186-topckgen.c    | 780 ++++++++++++++++++
 drivers/clk/mediatek/clk-mt8186-vdec.c        |  88 ++
 drivers/clk/mediatek/clk-mt8186-venc.c        |  51 ++
 drivers/clk/mediatek/clk-mt8186-wpe.c         |  51 ++
 include/dt-bindings/clock/mt8186-clk.h        | 445 ++++++++++
 19 files changed, 2514 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8186-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-infra_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-ipe.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-mcu.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-mdp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8186-wpe.c
 create mode 100644 include/dt-bindings/clock/mt8186-clk.h

-- 
2.18.0

