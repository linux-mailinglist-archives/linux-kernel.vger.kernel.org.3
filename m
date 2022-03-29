Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F92C4EA60D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiC2Dbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiC2DbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:31:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FD324F1C;
        Mon, 28 Mar 2022 20:29:31 -0700 (PDT)
X-UUID: 011b3b4679d349f1bb91b3dfc5a3ca0f-20220329
X-UUID: 011b3b4679d349f1bb91b3dfc5a3ca0f-20220329
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1805520085; Tue, 29 Mar 2022 11:29:27 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 29 Mar 2022 11:29:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Mar
 2022 11:29:22 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Mar 2022 11:29:20 +0800
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
        Yong Mao <yong.mao@mediatek.com>
Subject: [PATCH v9 3/3] mmc: mediatek: add support for SDIO eint wakup IRQ
Date:   Tue, 29 Mar 2022 11:29:13 +0800
Message-ID: <20220329032913.8750-4-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329032913.8750-1-axe.yang@mediatek.com>
References: <20220329032913.8750-1-axe.yang@mediatek.com>
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
the interrupts list should be extended:
        &mmcX {
		...
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
Signed-off-by: Axe Yang <axe.yang@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 94 +++++++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 65037e1d7723..2905d7134243 100644
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
@@ -440,8 +441,11 @@ struct msdc_host {
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_default;
 	struct pinctrl_state *pins_uhs;
+	struct pinctrl_state *pins_eint;
 	struct delayed_work req_timeout;
 	int irq;		/* host interrupt */
+	int eint_irq;		/* interrupt from sdio device for waking up system */
+	int sdio_wake_irq_depth;
 	struct reset_control *reset;
 
 	struct clk *src_clk;	/* msdc source clock */
@@ -465,6 +469,7 @@ struct msdc_host {
 	bool hs400_tuning;	/* hs400 mode online tuning */
 	bool internal_cd;	/* Use internal card-detect logic */
 	bool cqhci;		/* support eMMC hw cmdq */
+	bool sdio_eint_ready;	/* Ready to support SDIO eint interrupt */
 	struct msdc_save_para save_para; /* used when gate HCLK */
 	struct msdc_tune_para def_tune_para; /* default tune setting */
 	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
@@ -1527,10 +1532,12 @@ static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
 	__msdc_enable_sdio_irq(host, enb);
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	if (enb)
-		pm_runtime_get_noresume(host->dev);
-	else
-		pm_runtime_put_noidle(host->dev);
+	if (mmc->card && !mmc_card_enable_async_irq(mmc->card)) {
+		if (enb)
+			pm_runtime_get_noresume(host->dev);
+		else
+			pm_runtime_put_noidle(host->dev);
+	}
 }
 
 static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32 intsts)
@@ -2631,6 +2638,18 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		goto host_free;
 	}
 
+	/* Support for SDIO eint irq ? */
+	if (mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ) {
+		host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
+		if (IS_ERR(host->pins_eint)) {
+			ret = dev_err_probe(&pdev->dev, PTR_ERR(host->pins_eint),
+					    "Cannot find pinctrl eint!\n");
+			goto host_free;
+		}
+
+		host->sdio_eint_ready = true;
+	}
+
 	msdc_of_property_parse(pdev, host);
 
 	host->dev = &pdev->dev;
@@ -2722,6 +2741,21 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto release;
 
+	if (host->sdio_eint_ready) {
+		host->eint_irq = irq_of_parse_and_map(host->dev->of_node, 1);
+		ret = host->eint_irq ? dev_pm_set_dedicated_wake_irq(host->dev, host->eint_irq) :
+		      -ENODEV;
+
+		if (ret) {
+			dev_err(host->dev, "Failed to register data1 eint irq!\n");
+			goto release;
+		}
+
+		dev_pm_disable_wake_irq(host->dev);
+		pinctrl_select_state(host->pinctrl, host->pins_uhs);
+	}
+
+	device_init_wakeup(host->dev, true);
 	pm_runtime_set_active(host->dev);
 	pm_runtime_set_autosuspend_delay(host->dev, MTK_MMC_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(host->dev);
@@ -2734,6 +2768,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	return 0;
 end:
 	pm_runtime_disable(host->dev);
+	dev_pm_clear_wake_irq(host->dev);
 release:
 	platform_set_drvdata(pdev, NULL);
 	msdc_deinit_hw(host);
@@ -2845,6 +2880,16 @@ static int __maybe_unused msdc_runtime_suspend(struct device *dev)
 	struct msdc_host *host = mmc_priv(mmc);
 
 	msdc_save_reg(host);
+
+	if (host->sdio_eint_ready) {
+		disable_irq(host->irq);
+		pinctrl_select_state(host->pinctrl, host->pins_eint);
+		if (host->sdio_wake_irq_depth == 0) {
+			dev_pm_enable_wake_irq(dev);
+			host->sdio_wake_irq_depth++;
+		}
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	}
 	msdc_gate_clock(host);
 	return 0;
 }
@@ -2860,12 +2905,25 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
 		return ret;
 
 	msdc_restore_reg(host);
+
+	if (host->sdio_eint_ready) {
+		if (host->sdio_wake_irq_depth > 0) {
+			dev_pm_disable_wake_irq(dev);
+			host->sdio_wake_irq_depth--;
+			sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+		} else {
+			sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+		}
+		pinctrl_select_state(host->pinctrl, host->pins_uhs);
+		enable_irq(host->irq);
+	}
 	return 0;
 }
 
-static int __maybe_unused msdc_suspend(struct device *dev)
+static int __maybe_unused msdc_suspend_noirq(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
 
 	if (mmc->caps2 & MMC_CAP2_CQE) {
@@ -2874,16 +2932,36 @@ static int __maybe_unused msdc_suspend(struct device *dev)
 			return ret;
 	}
 
+	if (host->sdio_eint_ready)
+		enable_irq_wake(host->eint_irq);
+
 	return pm_runtime_force_suspend(dev);
 }
 
-static int __maybe_unused msdc_resume(struct device *dev)
+static int __maybe_unused msdc_resume_noirq(struct device *dev)
 {
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct msdc_host *host = mmc_priv(mmc);
+
+	if (host->sdio_eint_ready) {
+		disable_irq_wake(host->eint_irq);
+
+		/*
+		 * In noirq resume stage, msdc_runtime_resume()
+		 * won't be called, so disalbe wake irq here
+		 * to block dedicated wake irq handler callback.
+		 */
+		if (likely(host->sdio_wake_irq_depth > 0)) {
+			dev_pm_disable_wake_irq(dev);
+			host->sdio_wake_irq_depth--;
+		}
+	}
+
 	return pm_runtime_force_resume(dev);
 }
 
 static const struct dev_pm_ops msdc_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(msdc_suspend, msdc_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(msdc_suspend_noirq, msdc_resume_noirq)
 	SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
 };
 
-- 
2.25.1

