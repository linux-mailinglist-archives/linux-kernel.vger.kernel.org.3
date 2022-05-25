Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721AD53350B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243427AbiEYBwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243414AbiEYBv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:51:56 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7203C4A3;
        Tue, 24 May 2022 18:51:54 -0700 (PDT)
X-UUID: 628eefc219134a5ca25ceabe482db1cb-20220525
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:2733d9c8-98aa-409a-a79b-4827db5ae2e7,OB:30,L
        OB:30,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:90
X-CID-INFO: VERSION:1.1.5,REQID:2733d9c8-98aa-409a-a79b-4827db5ae2e7,OB:30,LOB
        :30,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:90
X-CID-META: VersionHash:2a19b09,CLOUDID:73745747-4fb1-496b-8f1d-39e733fed1ea,C
        OID:1335533dafc4,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 628eefc219134a5ca25ceabe482db1cb-20220525
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1900112737; Wed, 25 May 2022 09:51:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 25 May 2022 09:51:49 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 25 May 2022 09:51:47 +0800
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
        Yong Mao <yong.mao@mediatek.com>
Subject: [RESEND v12 3/3] mmc: mediatek: add support for SDIO eint wakup IRQ
Date:   Wed, 25 May 2022 09:51:40 +0800
Message-ID: <20220525015140.384-4-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525015140.384-1-axe.yang@mediatek.com>
References: <20220525015140.384-1-axe.yang@mediatek.com>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Co-developed-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Axe Yang <axe.yang@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 80 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 195dc897188b..2d5b23616df6 100644
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
@@ -1520,17 +1523,41 @@ static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb)
 
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
+			pinctrl_select_state(host->pinctrl, host->pins_eint);
+			ret = dev_pm_set_dedicated_wake_irq_reverse(host->dev, host->eint_irq);
+
+			if (ret) {
+				dev_err(host->dev, "Failed to register SDIO wakeup irq!\n");
+				host->pins_eint = NULL;
+				pm_runtime_get_noresume(host->dev);
+			} else {
+				dev_info(host->dev, "SDIO eint irq: %d!\n", host->eint_irq);
+				device_init_wakeup(host->dev, true);
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
@@ -2631,6 +2658,19 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		goto host_free;
 	}
 
+	/* Support for SDIO eint irq ? */
+	if ((mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ) && (mmc->pm_caps & MMC_PM_KEEP_POWER)) {
+		host->eint_irq = platform_get_irq_byname(pdev, "sdio_wakeup");
+		if (host->eint_irq > 0) {
+			host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
+			if (IS_ERR(host->pins_eint)) {
+				dev_err_probe(&pdev->dev, PTR_ERR(host->pins_eint),
+					      "Cannot find pinctrl eint!\n");
+				host->pins_eint = NULL;
+			}
+		}
+	}
+
 	msdc_of_property_parse(pdev, host);
 
 	host->dev = &pdev->dev;
@@ -2845,6 +2885,12 @@ static int __maybe_unused msdc_runtime_suspend(struct device *dev)
 	struct msdc_host *host = mmc_priv(mmc);
 
 	msdc_save_reg(host);
+
+	if (sdio_irq_claimed(mmc) && host->pins_eint) {
+		disable_irq(host->irq);
+		pinctrl_select_state(host->pinctrl, host->pins_eint);
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	}
 	msdc_gate_clock(host);
 	return 0;
 }
@@ -2860,12 +2906,19 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
 		return ret;
 
 	msdc_restore_reg(host);
+
+	if (sdio_irq_claimed(mmc) && host->pins_eint) {
+		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
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
@@ -2874,11 +2927,26 @@ static int __maybe_unused msdc_suspend(struct device *dev)
 			return ret;
 	}
 
+	if (sdio_irq_claimed(mmc) && host->pins_eint) {
+		pm_runtime_put_sync_suspend(dev);
+
+		return 0;
+	}
+
 	return pm_runtime_force_suspend(dev);
 }
 
 static int __maybe_unused msdc_resume(struct device *dev)
 {
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct msdc_host *host = mmc_priv(mmc);
+
+	if (sdio_irq_claimed(mmc) && host->pins_eint) {
+		pm_runtime_get_sync(dev);
+
+		return 0;
+	}
+
 	return pm_runtime_force_resume(dev);
 }
 
-- 
2.25.1

