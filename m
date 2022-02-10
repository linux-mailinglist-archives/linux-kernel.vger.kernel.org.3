Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597814B0462
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 05:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiBJER3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 23:17:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiBJERC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:17:02 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED74764B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 20:16:34 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21A4GWfm082124;
        Wed, 9 Feb 2022 22:16:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644466592;
        bh=Fyxn+IHseNlnIEQ1kOMTztmmE/DKTPHFDAmcWrsYCLY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NQ0kXUd/P9Zbcs86YVPXpKuc+bxbrIE2xptKpcPh0luHmRxEZqw/OTVLAoZOEm+re
         XPYK6lY0czqbPHoR6Y9DI93Rceybae7bum6k7HBgTkHZc0ZlssBfB9iCQfIgYyDUdO
         eVki0c/GhShOLEGbgHBBI3o5DWyUr82CzYXO4NQM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21A4GWru032341
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Feb 2022 22:16:32 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 9
 Feb 2022 22:16:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 9 Feb 2022 22:16:32 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21A4GVO0114335;
        Wed, 9 Feb 2022 22:16:31 -0600
From:   Dave Gerlach <d-gerlach@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Dave Gerlach <d-gerlach@ti.com>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 2/2] mailbox: ti-msgmgr: Operate mailbox in polled mode during system suspend
Date:   Wed, 9 Feb 2022 22:16:31 -0600
Message-ID: <20220210041631.26767-3-d-gerlach@ti.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220210041631.26767-1-d-gerlach@ti.com>
References: <20220210041631.26767-1-d-gerlach@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the system suspend path we must set all queues to operate in
polled mode as it is possible for any protocol built using this mailbox,
such as TISCI, to require communication during the no irq phase of suspend,
and we cannot rely on interrupts there.

Polled mode is implemented by allowing the mailbox user to define an
RX channel as part of the message that is sent which is what gets polled
for a response. If polled mode is enabled, this will immediately be
polled for a response at the end of the mailbox send_data op before
returning success for the data send or timing out if no response is
received.

Finally, to ensure polled mode is always enabled during system suspend,
iterate through all queues to set RX queues to polled mode during system
suspend and disable polled mode for all in the resume handler.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/mailbox/ti-msgmgr.c      | 93 +++++++++++++++++++++++++++++++-
 include/linux/soc/ti/ti-msgmgr.h |  8 ++-
 2 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index f860cd0c907a..ddac423ac1a9 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' Message Manager Driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2015-2022 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  */
 
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
@@ -100,6 +101,7 @@ struct ti_msgmgr_desc {
  * @queue_ctrl: Queue Control register
  * @chan:	Mailbox channel
  * @rx_buff:	Receive buffer pointer allocated at probe, max_message_size
+ * @polled_rx_mode: Use polling for rx instead of interrupts
  */
 struct ti_queue_inst {
 	char name[30];
@@ -113,6 +115,7 @@ struct ti_queue_inst {
 	void __iomem *queue_ctrl;
 	struct mbox_chan *chan;
 	u32 *rx_buff;
+	bool polled_rx_mode;
 };
 
 /**
@@ -237,6 +240,26 @@ static int ti_msgmgr_queue_rx_data(struct mbox_chan *chan, struct ti_queue_inst
 	return 0;
 }
 
+static int ti_msgmgr_queue_rx_poll_timeout(struct mbox_chan *chan, int timeout_us)
+{
+	struct device *dev = chan->mbox->dev;
+	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
+	struct ti_queue_inst *qinst = chan->con_priv;
+	const struct ti_msgmgr_desc *desc = inst->desc;
+	int msg_count;
+	int ret;
+
+	ret = readl_poll_timeout_atomic(qinst->queue_state, msg_count,
+					(msg_count & desc->status_cnt_mask),
+					10, timeout_us);
+	if (ret != 0)
+		return ret;
+
+	ti_msgmgr_queue_rx_data(chan, qinst, desc);
+
+	return 0;
+}
+
 /**
  * ti_msgmgr_queue_rx_interrupt() - Interrupt handler for receive Queue
  * @irq:	Interrupt number
@@ -346,6 +369,17 @@ static bool ti_msgmgr_last_tx_done(struct mbox_chan *chan)
 	return msg_count ? false : true;
 }
 
+static bool ti_msgmgr_chan_has_polled_queue_rx(struct mbox_chan *chan)
+{
+	struct ti_queue_inst *qinst;
+
+	if (!chan)
+		return false;
+
+	qinst = chan->con_priv;
+	return qinst->polled_rx_mode;
+}
+
 /**
  * ti_msgmgr_send_data() - Send data
  * @chan:	Channel Pointer
@@ -363,6 +397,7 @@ static int ti_msgmgr_send_data(struct mbox_chan *chan, void *data)
 	struct ti_msgmgr_message *message = data;
 	void __iomem *data_reg;
 	u32 *word_data;
+	int ret = 0;
 
 	if (WARN_ON(!inst)) {
 		dev_err(dev, "no platform drv data??\n");
@@ -404,7 +439,12 @@ static int ti_msgmgr_send_data(struct mbox_chan *chan, void *data)
 	if (data_reg <= qinst->queue_buff_end)
 		writel(0, qinst->queue_buff_end);
 
-	return 0;
+	/* If we are in polled mode, wait for a response before proceeding */
+	if (ti_msgmgr_chan_has_polled_queue_rx(message->chan_rx))
+		ret = ti_msgmgr_queue_rx_poll_timeout(message->chan_rx,
+						      message->timeout_rx_ms * 1000);
+
+	return ret;
 }
 
 /**
@@ -652,6 +692,54 @@ static int ti_msgmgr_queue_setup(int idx, struct device *dev,
 	return 0;
 }
 
+static int ti_msgmgr_queue_rx_set_polled_mode(struct ti_queue_inst *qinst, bool enable)
+{
+	if (enable) {
+		disable_irq(qinst->irq);
+		qinst->polled_rx_mode = true;
+	} else {
+		enable_irq(qinst->irq);
+		qinst->polled_rx_mode = false;
+	}
+
+	return 0;
+}
+
+static int ti_msgmgr_suspend(struct device *dev)
+{
+	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
+	struct ti_queue_inst *qinst;
+	int i;
+
+	/*
+	 * We must switch operation to polled mode now as drivers and the genpd
+	 * layer may make late TI SCI calls to change clock and device states
+	 * from the noirq phase of suspend.
+	 */
+	for (qinst = inst->qinsts, i = 0; i < inst->num_valid_queues; qinst++, i++) {
+		if (!qinst->is_tx)
+			ti_msgmgr_queue_rx_set_polled_mode(qinst, true);
+	}
+
+	return 0;
+}
+
+static int ti_msgmgr_resume(struct device *dev)
+{
+	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
+	struct ti_queue_inst *qinst;
+	int i;
+
+	for (qinst = inst->qinsts, i = 0; i < inst->num_valid_queues; qinst++, i++) {
+		if (!qinst->is_tx)
+			ti_msgmgr_queue_rx_set_polled_mode(qinst, false);
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ti_msgmgr_pm_ops, ti_msgmgr_suspend, ti_msgmgr_resume);
+
 /* Queue operations */
 static const struct mbox_chan_ops ti_msgmgr_chan_ops = {
 	.startup = ti_msgmgr_queue_startup,
@@ -839,6 +927,7 @@ static struct platform_driver ti_msgmgr_driver = {
 	.driver = {
 		   .name = "ti-msgmgr",
 		   .of_match_table = of_match_ptr(ti_msgmgr_of_match),
+		   .pm = &ti_msgmgr_pm_ops,
 	},
 };
 module_platform_driver(ti_msgmgr_driver);
diff --git a/include/linux/soc/ti/ti-msgmgr.h b/include/linux/soc/ti/ti-msgmgr.h
index 1f6e76d423cf..69a8d7682c4b 100644
--- a/include/linux/soc/ti/ti-msgmgr.h
+++ b/include/linux/soc/ti/ti-msgmgr.h
@@ -1,7 +1,7 @@
 /*
  * Texas Instruments' Message Manager
  *
- * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2015-2022 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  *
  * This program is free software; you can redistribute it and/or modify
@@ -17,10 +17,14 @@
 #ifndef TI_MSGMGR_H
 #define TI_MSGMGR_H
 
+struct mbox_chan;
+
 /**
  * struct ti_msgmgr_message - Message Manager structure
  * @len: Length of data in the Buffer
  * @buf: Buffer pointer
+ * @chan_rx: Expected channel for response, must be provided to use polled rx
+ * @timeout_rx_ms: Timeout value to use if polling for response
  *
  * This is the structure for data used in mbox_send_message
  * the length of data buffer used depends on the SoC integration
@@ -30,6 +34,8 @@
 struct ti_msgmgr_message {
 	size_t len;
 	u8 *buf;
+	struct mbox_chan *chan_rx;
+	int timeout_rx_ms;
 };
 
 #endif /* TI_MSGMGR_H */
-- 
2.35.0

