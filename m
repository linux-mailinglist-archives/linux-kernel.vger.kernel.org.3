Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F6047FB1A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 09:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhL0Ig6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 03:36:58 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:57482 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235719AbhL0Igz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 03:36:55 -0500
X-UUID: ba38dc2991a642d996e768c8e1d9884d-20211227
X-UUID: ba38dc2991a642d996e768c8e1d9884d-20211227
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1467306506; Mon, 27 Dec 2021 16:36:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 27 Dec 2021 16:36:49 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Dec 2021 16:36:47 +0800
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
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 3/3] mmc: mediatek: add support for SDIO eint irq
Date:   Mon, 27 Dec 2021 16:36:41 +0800
Message-ID: <20211227083641.12538-4-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211227083641.12538-1-axe.yang@mediatek.com>
References: <20211227083641.12538-1-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for eint irq when MSDC is used as an SDIO host. This
feature requires SDIO device support async irq function. With this
feature,SDIO host can be awakened by SDIO card in suspend state,
without additional pin.

MSDC driver will time-share the SDIO DAT1 pin. During suspend, MSDC
turn off clock and switch SDIO DAT1 pin to GPIO mode. And during
resume, switch GPIO function back to DAT1 mode then turn on clock.

Some device tree property should be added or modified in msdc node
to support SDIO eint irq. Pinctrls named state_dat1 and state_eint
are mandatory. And cap-sdio-async-int flag is necessary since this
feature depends on asynchronous interrupt:
	&mmcX {
		...
		pinctrl-names = "default", "state_uhs", "state_eint",
						"state_dat1";
		...
		pinctrl-2 = <&mmc2_pins_eint>;
		pinctrl-3 = <&mmc2_pins_dat1>;
		...
		cap-sdio-async-int;
		...
	};

Signed-off-by: Axe Yang <axe.yang@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 113 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4dfc246c5f95..8f23349f2963 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2014-2015 MediaTek Inc.
+ * Copyright (c) 2014-2021 MediaTek Inc.
  * Author: Chaotian.Jing <chaotian.jing@mediatek.com>
  */
 
@@ -432,9 +432,13 @@ struct msdc_host {
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_default;
 	struct pinctrl_state *pins_uhs;
+	struct pinctrl_state *pins_eint;
+	struct pinctrl_state *pins_dat1;
 	struct delayed_work req_timeout;
 	int irq;		/* host interrupt */
 	struct reset_control *reset;
+	int eint_irq;		/* device interrupt */
+	int sdio_irq_cnt;	/* irq enable cnt */
 
 	struct clk *src_clk;	/* msdc source clock */
 	struct clk *h_clk;      /* msdc h_clk */
@@ -1519,10 +1523,12 @@ static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
 	__msdc_enable_sdio_irq(host, enb);
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	if (enb)
-		pm_runtime_get_noresume(host->dev);
-	else
-		pm_runtime_put_noidle(host->dev);
+	if (mmc->card && !mmc->card->cccr.enable_async_int) {
+		if (enb)
+			pm_runtime_get_noresume(host->dev);
+		else
+			pm_runtime_put_noidle(host->dev);
+	}
 }
 
 static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32 intsts)
@@ -2380,6 +2386,49 @@ static const struct mmc_host_ops mt_msdc_ops = {
 	.hw_reset = msdc_hw_reset,
 };
 
+static irqreturn_t msdc_sdio_eint_irq(int irq, void *dev_id)
+{
+	unsigned long flags;
+	struct msdc_host *host = (struct msdc_host *)dev_id;
+	struct mmc_host *mmc = mmc_from_priv(host);
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (likely(host->sdio_irq_cnt > 0)) {
+		disable_irq_nosync(host->eint_irq);
+		disable_irq_wake(host->eint_irq);
+		host->sdio_irq_cnt--;
+	}
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	sdio_signal_irq(mmc);
+
+	return IRQ_HANDLED;
+}
+
+static int msdc_request_dat1_eint_irq(struct msdc_host *host)
+{
+	struct gpio_desc *desc;
+	int ret = 0;
+	int irq;
+
+	desc = devm_gpiod_get_index(host->dev, "eint", 0, GPIOD_IN);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	irq = gpiod_to_irq(desc);
+	if (irq >= 0) {
+		irq_set_status_flags(irq, IRQ_NOAUTOEN);
+		ret = devm_request_threaded_irq(host->dev, irq, NULL, msdc_sdio_eint_irq,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						"sdio-eint", host);
+	} else {
+		ret = irq;
+	}
+
+	host->eint_irq = irq;
+	return ret;
+}
+
 static const struct cqhci_host_ops msdc_cmdq_ops = {
 	.enable         = msdc_cqe_enable,
 	.disable        = msdc_cqe_disable,
@@ -2534,6 +2583,19 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		goto host_free;
 	}
 
+	/* Support for SDIO eint irq */
+	host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
+	if (IS_ERR(host->pins_eint)) {
+		dev_dbg(&pdev->dev, "Cannot find pinctrl eint!\n");
+	} else {
+		host->pins_dat1 = pinctrl_lookup_state(host->pinctrl, "state_dat1");
+		if (IS_ERR(host->pins_dat1)) {
+			ret = PTR_ERR(host->pins_dat1);
+			dev_err(&pdev->dev, "Cannot find pinctrl dat1!\n");
+			goto host_free;
+		}
+	}
+
 	msdc_of_property_parse(pdev, host);
 
 	host->dev = &pdev->dev;
@@ -2621,6 +2683,16 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto release;
 
+	if (!IS_ERR(host->pins_eint) && !IS_ERR(host->pins_dat1)) {
+		ret = msdc_request_dat1_eint_irq(host);
+		if (ret) {
+			dev_err(host->dev, "Failed to register data1 eint irq!\n");
+			goto release;
+		}
+
+		pinctrl_select_state(host->pinctrl, host->pins_dat1);
+	}
+
 	pm_runtime_set_active(host->dev);
 	pm_runtime_set_autosuspend_delay(host->dev, MTK_MMC_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(host->dev);
@@ -2740,21 +2812,50 @@ static void msdc_restore_reg(struct msdc_host *host)
 
 static int __maybe_unused msdc_runtime_suspend(struct device *dev)
 {
+	unsigned long flags;
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct msdc_host *host = mmc_priv(mmc);
 
 	msdc_save_reg(host);
+
+	if (!IS_ERR(host->pins_eint)) {
+		disable_irq(host->irq);
+		pinctrl_select_state(host->pinctrl, host->pins_eint);
+		spin_lock_irqsave(&host->lock, flags);
+		if (host->sdio_irq_cnt == 0) {
+			enable_irq(host->eint_irq);
+			enable_irq_wake(host->eint_irq);
+			host->sdio_irq_cnt++;
+		}
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
 	msdc_gate_clock(host);
 	return 0;
 }
 
 static int __maybe_unused msdc_runtime_resume(struct device *dev)
 {
+	unsigned long flags;
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct msdc_host *host = mmc_priv(mmc);
 
 	msdc_ungate_clock(host);
 	msdc_restore_reg(host);
+	if (!IS_ERR(host->pins_eint)) {
+		spin_lock_irqsave(&host->lock, flags);
+		if (host->sdio_irq_cnt > 0) {
+			disable_irq_nosync(host->eint_irq);
+			disable_irq_wake(host->eint_irq);
+			host->sdio_irq_cnt--;
+			sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+		} else {
+			sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+		}
+		spin_unlock_irqrestore(&host->lock, flags);
+		pinctrl_select_state(host->pinctrl, host->pins_uhs);
+		enable_irq(host->irq);
+	}
 	return 0;
 }
 
@@ -2778,7 +2879,7 @@ static int __maybe_unused msdc_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops msdc_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(msdc_suspend, msdc_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(msdc_suspend, msdc_resume)
 	SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
 };
 
-- 
2.25.1

