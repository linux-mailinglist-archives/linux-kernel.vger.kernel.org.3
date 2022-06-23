Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A91557640
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiFWJFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiFWJFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:05:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033DF22530;
        Thu, 23 Jun 2022 02:05:07 -0700 (PDT)
X-UUID: 99a9c4c7b75245d292a059857a6c50f6-20220623
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:eb5c520e-6b4d-44ff-9d62-08aeaf099ebb,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:491451ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 99a9c4c7b75245d292a059857a6c50f6-20220623
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1587169448; Thu, 23 Jun 2022 17:05:03 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 23 Jun 2022 17:05:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jun 2022 17:05:02 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jun 2022 17:04:58 +0800
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
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v13 0/3] mmc: mediatek: add support for SDIO async IRQ
Date:   Thu, 23 Jun 2022 17:04:42 +0800
Message-ID: <20220623090445.1401-1-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v13:
- remove state_dat1 related description in mtk-sd.yaml
- move device_init_wakeup() to probe stage
- remove redundancy SDC_CFG_SDIOIDE bit control in msdc_runtime_suspend()
- replace SDC_CFG_SDIOIDE control with __msdc_enable_sdio_irq() function to
  disable sdio irq when sdio_irq_claimed() return true in msdc_runtime_resume()
- restore to use pm_runtime_force_resume|suspend(), to avoid go out directly
  in force resume, bump up runtime PM usage counter before force suspend. 

Changes in v12:
- assign NULL to pins_eint directly instead of using kfree()

Changes in v11:
- remove '_irq' suffix in interrupts-names property
- fix yaml example build error
- refactor msdc_enable_sdio_irq(), free pins_eint if async irq is not supported

Changes in v10:
- add sample node for SDIO host which support wakeup interrupt in yaml
- skip MMC_PM_WAKE_SDIO_IRQ check before enable SDIO async interrupt
- add MMC_PM_KEEP_POWER check before SDIO eint pinstate parsing
- use dev_pm_set_dedicated_wake_irq_reverse() to correct irq control sequence
- set dedicated irq in msdc_enable_sdio_irq() rather than msdc_drv_probe()
- remove unnecessary wake irq control, rpm/dpm system shall manage that
- move wake irq/msdc irq control back to system suspend phase, use rpm_suspend
  and rpm_resume to ensure irq control sequence:
     disable msdc irq -> enable wake irq -> disable wake irq -> enable msdc irq
- simplify variables, check pins_eint to know whether wakeup settings are managed

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

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 50 ++++++++++-
 drivers/mmc/core/sdio.c                       | 14 ++++
 drivers/mmc/host/mtk-sd.c                     | 84 +++++++++++++++++--
 include/linux/mmc/card.h                      |  8 +-
 include/linux/mmc/sdio.h                      |  5 ++
 5 files changed, 153 insertions(+), 8 deletions(-)

-- 
2.25.1


