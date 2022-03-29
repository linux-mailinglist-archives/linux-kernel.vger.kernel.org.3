Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B534EA615
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiC2DbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiC2DbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:31:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ACA2228C;
        Mon, 28 Mar 2022 20:29:22 -0700 (PDT)
X-UUID: 5c7adc8aa45b49df88968c7b50ed9c61-20220329
X-UUID: 5c7adc8aa45b49df88968c7b50ed9c61-20220329
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1806153097; Tue, 29 Mar 2022 11:29:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Mar 2022 11:29:16 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Mar 2022 11:29:15 +0800
From:   Axe Yang <axe.yang@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Axe Yang <axe.yang@mediatek.com>, Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v9 0/3] mmc: mediatek: add support for SDIO async IRQ
Date:   Tue, 29 Mar 2022 11:29:10 +0800
Message-ID: <20220329032913.8750-1-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v9:
- remove pinctrl "state_dat1"

Changes in v8:
- remove maxItems property under pinctrl-names property

Changes in v7:
- add device_init_wakeup() to register SDIO host as wakeup source

Changes in v6:
- abandon cap-sdio-async-irq flag, use wakeup-source flag instead
- extend interrupts and pinctrls in mediatek mmc host controller DT documents
- add mmc_card_enable_async_irq() to access enable_async_irq flag
- simplify wakeup irq implementation with dedicate wake up irq related interface

Changes in v5:
- resort variables to reversed xmas tree order
- restore old copyright year range and add current year back

Changes in v4:
- add MMC_CAP2_SDIO_ASYNC_IRQ judge before lookup eint pinctrl
- replace spin_lock_irqsave() variant with spin_lock() in eint irq handler

Changes in v3:
- correct abbreviations with capital letters in commit message
- replace copyright year with 2022 in mtk-sd.c
- remove unnessary pointer casting
- adjust variable order to reversed xmas tree
- remove a redundant blank line
- refine if statement, following standard pattern

Changes in v2:
- change flag name from 'cap-sdio-async-int' to 'cap-sdio-async-irq'
- change corresponding macro names from xxx_INT to xxx_IRQ
- resort new member in msdc_host structure
- refine function msdc_request_dat1_eint_irq()
- rename msdc_{suspend,resume} function names, add suffix '_noirq'
- add MMC_CAP2_NO_SDIO judgement before parse eint related pin setting

Axe Yang (3):
  dt-bindings: mmc: mtk-sd: extend interrupts and pinctrls properties
  mmc: core: Add support for SDIO wakeup interrupt
  mmc: mediatek: add support for SDIO eint wakup IRQ

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 17 +++-
 drivers/mmc/core/sdio.c                       | 17 ++++
 drivers/mmc/host/mtk-sd.c                     | 94 +++++++++++++++++--
 include/linux/mmc/card.h                      |  8 +-
 include/linux/mmc/sdio.h                      |  5 +
 5 files changed, 131 insertions(+), 10 deletions(-)

-- 
2.25.1


