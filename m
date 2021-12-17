Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF39478B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhLQMLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:11:55 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:47120 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229471AbhLQMLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:11:53 -0500
X-UUID: e0973650eabb4c47a15a897a111c0e8a-20211217
X-UUID: e0973650eabb4c47a15a897a111c0e8a-20211217
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 363772839; Fri, 17 Dec 2021 20:11:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Dec 2021 20:11:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Dec 2021 20:11:48 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     John Crispin <john@phrozen.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        YH Chen <yh.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v7 0/3] Mediatek MT7986 basic clock support
Date:   Fri, 17 Dec 2021 20:11:45 +0800
Message-ID: <20211217121148.6753-1-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add basic clock support for mediatek mt7986 SoC.
It is based on patch series "Add basic SoC support for mediatek mt7986"
https://lore.kernel.org/all/20211018114009.13350-1-sam.shih@mediatek.com/
and "clk: mediatek: Add API for clock resource recycle"
https://lore.kernel.org/linux-arm-kernel/20210914021633.26377-5-chun-jie.chen@mediatek.com/
---
v7: exclude DTS changes in the patch series
v5: used builtin_platform_driver instead of CLK_OF_DECLARE
    follow recent clk-mt8195 clock patch series:
    https://lore.kernel.org/linux-arm-kernel/20210914021633.26377-1-chun-jie.chen@mediatek.com/

v4:
According to the maintainer¡¦s suggestion, this patch splits the previous
thread into independent patch series.
This patch include clock driver and device tree update

Original thread:
https://lore.kernel.org/all/20210914085137.31761-1-sam.shih@mediatek.com/
https://lore.kernel.org/linux-arm-kernel/20210914085137.31761-2-sam.shih@mediatek.com/
---

Sam Shih (3):
  dt-bindings: clock: mediatek: document clk bindings for mediatek
    mt7986 SoC
  clk: mediatek: add mt7986 clock IDs
  clk: mediatek: add mt7986 clock support

 .../arm/mediatek/mediatek,apmixedsys.txt      |   1 +
 .../bindings/arm/mediatek/mediatek,ethsys.txt |   1 +
 .../arm/mediatek/mediatek,infracfg.txt        |   1 +
 .../arm/mediatek/mediatek,sgmiisys.txt        |   2 +
 .../arm/mediatek/mediatek,topckgen.txt        |   1 +
 drivers/clk/mediatek/Kconfig                  |  17 +
 drivers/clk/mediatek/Makefile                 |   4 +
 drivers/clk/mediatek/clk-mt7986-apmixed.c     | 100 +++++
 drivers/clk/mediatek/clk-mt7986-eth.c         | 132 +++++++
 drivers/clk/mediatek/clk-mt7986-infracfg.c    | 224 ++++++++++++
 drivers/clk/mediatek/clk-mt7986-topckgen.c    | 342 ++++++++++++++++++
 include/dt-bindings/clock/mt7986-clk.h        | 169 +++++++++
 12 files changed, 994 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt7986-apmixed.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-eth.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-topckgen.c
 create mode 100644 include/dt-bindings/clock/mt7986-clk.h

-- 
2.29.2

