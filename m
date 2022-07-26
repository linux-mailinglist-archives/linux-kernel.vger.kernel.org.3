Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3679E580BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbiGZG32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237796AbiGZG3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:29:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF28DD80;
        Mon, 25 Jul 2022 23:28:58 -0700 (PDT)
X-UUID: 171aa453ce8b4603bfbe171c595ef681-20220726
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:dac61b2c-9f23-4be5-9916-62acea505034,OB:20,L
        OB:20,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:90
X-CID-INFO: VERSION:1.1.8,REQID:dac61b2c-9f23-4be5-9916-62acea505034,OB:20,LOB
        :20,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:90
X-CID-META: VersionHash:0f94e32,CLOUDID:742609ee-db04-4499-9fdf-04ef44b9468c,C
        OID:ea2a07b87beb,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 171aa453ce8b4603bfbe171c595ef681-20220726
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1011207800; Tue, 26 Jul 2022 14:28:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 26 Jul 2022 14:28:51 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Jul 2022 14:28:48 +0800
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v14 3/3] mmc: mediatek: add support for SDIO eint wakup IRQ
Date:   Tue, 26 Jul 2022 14:28:42 +0800
Message-ID: <20220726062842.18846-4-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726062842.18846-1-axe.yang@mediatek.com>
References: <20220726062842.18846-1-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for eint IRQ when MSDC is used as an SDIO host. This
feature requires SDIO device support async IRQ function. With this
feature, SDIO host can be awakened by SDIO card in suspend state,
without additional pin.

MSDC driver will time-share the SDIO DAT1 pin. During suspend, MSDC
turn off clock and switch SDIO DAT1 pin to GPIO mode. And during
resume, switch GPIO function back to DAT1 mode then turn on clock.

Some device tree property should be added or modified in MSDC node
to support SDIO eint IRQ. Pinctrls "state_eint" is mandatory. Since
this feature depends on asynchronous interrupts, "wakeup-source",
"keep-power-in-suspend" and "cap-sdio-irq" flags are necessary, and
the interrupts list should be extended(the interrupt named with
sdio_wakeup):
        &mmcX {
		...
		interrupt-names = "msdc", "sdio_wakeup";
		interrupts-extended = <...>,
                              	      <&pio xxx IRQ_TYPE_LEVEL_LOW>;
                ...
                pinctrl-names = "default", "state_uhs", "state_eint";
                ...
                pinctrl-2 = <&mmc2_pins_eint>;
                ...
                cap-sdio-irq;
		keep-power-in-suspend;
		wakeup-source;
                ...
        };

Co-developed-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Reviewed-by: Chaotian Jing <chaotian.jing@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Axe Yang <axe.yang@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 86 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index a4954b200d87..4ff73d1883de 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2014-2015 MediaTek Inc.
+ * Copyright (c) 2014-2015, 2022 MediaTek Inc.
  * Author: Chaotian.Jing <chaotian.jing@mediatek.com>
  */
 
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -440,8 +441,10 @@ struct msdc_host {
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_default;
 	struct pinctrl_state *pins_uhs;
+	struct pinctrl_state *pins_eint;
 	struct delayed_work req_timeout;
 	int irq;		/* host interrupt */
+	int eint_irq;		/* interrupt from sdio device for waking up system */
 	struct reset_control *reset;
 
 	struct clk *src_clk;	/* msdc source clock */
@@ -1521,17 +1524,46 @@ static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb)
 
 static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
 {
-	unsigned long flags;
 	struct msdc_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&host->lock, flags);
 	__msdc_enable_sdio_irq(host, enb);
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	if (enb)
-		pm_runtime_get_noresume(host->dev);
-	else
-		pm_runtime_put_noidle(host->dev);
+	if (mmc_card_enable_async_irq(mmc->card) && host->pins_eint) {
+		if (enb) {
+			/*
+			 * In dev_pm_set_dedicated_wake_irq_reverse(), eint pin will be set to
+			 * GPIO mode. We need to restore it to SDIO DAT1 mode after that.
+			 * Since the current pinstate is pins_uhs, to ensure pinctrl select take
+			 * affect successfully, we change the pinstate to pins_eint firstly.
+			 */
+			pinctrl_select_state(host->pinctrl, host->pins_eint);
+			ret = dev_pm_set_dedicated_wake_irq_reverse(host->dev, host->eint_irq);
+
+			if (ret) {
+				dev_err(host->dev, "Failed to register SDIO wakeup irq!\n");
+				host->pins_eint = NULL;
+				pm_runtime_get_noresume(host->dev);
+			} else {
+				dev_dbg(host->dev, "SDIO eint irq: %d!\n", host->eint_irq);
+			}
+
+			pinctrl_select_state(host->pinctrl, host->pins_uhs);
+		} else {
+			dev_pm_clear_wake_irq(host->dev);
+		}
+	} else {
+		if (enb) {
+			/* Ensure host->pins_eint is NULL */
+			host->pins_eint = NULL;
+			pm_runtime_get_noresume(host->dev);
+		} else {
+			pm_runtime_put_noidle(host->dev);
+		}
+	}
 }
 
 static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32 intsts)
@@ -2635,6 +2667,20 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		goto host_free;
 	}
 
+	/* Support for SDIO eint irq ? */
+	if ((mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ) && (mmc->pm_caps & MMC_PM_KEEP_POWER)) {
+		host->eint_irq = platform_get_irq_byname(pdev, "sdio_wakeup");
+		if (host->eint_irq > 0) {
+			host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
+			if (IS_ERR(host->pins_eint)) {
+				dev_err(&pdev->dev, "Cannot find pinctrl eint!\n");
+				host->pins_eint = NULL;
+			} else {
+				device_init_wakeup(&pdev->dev, true);
+			}
+		}
+	}
+
 	msdc_of_property_parse(pdev, host);
 
 	host->dev = &pdev->dev;
@@ -2849,6 +2895,15 @@ static int __maybe_unused msdc_runtime_suspend(struct device *dev)
 	struct msdc_host *host = mmc_priv(mmc);
 
 	msdc_save_reg(host);
+
+	if (sdio_irq_claimed(mmc)) {
+		if (host->pins_eint) {
+			disable_irq(host->irq);
+			pinctrl_select_state(host->pinctrl, host->pins_eint);
+		}
+
+		__msdc_enable_sdio_irq(host, 0);
+	}
 	msdc_gate_clock(host);
 	return 0;
 }
@@ -2864,12 +2919,18 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
 		return ret;
 
 	msdc_restore_reg(host);
+
+	if (sdio_irq_claimed(mmc) && host->pins_eint) {
+		pinctrl_select_state(host->pinctrl, host->pins_uhs);
+		enable_irq(host->irq);
+	}
 	return 0;
 }
 
 static int __maybe_unused msdc_suspend(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
 
 	if (mmc->caps2 & MMC_CAP2_CQE) {
@@ -2878,11 +2939,24 @@ static int __maybe_unused msdc_suspend(struct device *dev)
 			return ret;
 	}
 
+	/*
+	 * Bump up runtime PM usage counter otherwise dev->power.needs_force_resume will
+	 * not be marked as 1, pm_runtime_force_resume() will go out directly.
+	 */
+	if (sdio_irq_claimed(mmc) && host->pins_eint)
+		pm_runtime_get_noresume(dev);
+
 	return pm_runtime_force_suspend(dev);
 }
 
 static int __maybe_unused msdc_resume(struct device *dev)
 {
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct msdc_host *host = mmc_priv(mmc);
+
+	if (sdio_irq_claimed(mmc) && host->pins_eint)
+		pm_runtime_put_noidle(dev);
+
 	return pm_runtime_force_resume(dev);
 }
 
-- 
2.25.1

