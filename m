Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAF45119FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiD0Nq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiD0Nqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:46:48 -0400
Received: from bin-mail-out-06.binero.net (bin-mail-out-06.binero.net [195.74.38.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05A93B56F0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:43:35 -0700 (PDT)
X-Halon-ID: 07644750-c630-11ec-9627-0050569116f7
Authorized-sender: andreas@gaisler.com
Received: from andreas.got.gaisler.com (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id 07644750-c630-11ec-9627-0050569116f7;
        Wed, 27 Apr 2022 15:43:33 +0200 (CEST)
From:   Andreas Larsson <andreas@gaisler.com>
To:     linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-kernel@vger.kernel.org, software@gaisler.com
Subject: [PATCH 3/3] can: grcan: Only use the napi poll budget for rx
Date:   Wed, 27 Apr 2022 15:43:07 +0200
Message-Id: <20220427134307.22981-4-andreas@gaisler.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427134307.22981-1-andreas@gaisler.com>
References: <20220427134307.22981-1-andreas@gaisler.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous split budget between tx and rx made it return not using the
entire budget but at the same time not having calling called
napi_complete. This sometimes led to the poll to not be called, and at
the same time with tx and rx interrupts disabled.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/net/can/grcan.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 2f56d4bbb65c..cb98eadc3b93 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1124,7 +1124,7 @@ static int grcan_close(struct net_device *dev)
 	return 0;
 }
 
-static int grcan_transmit_catch_up(struct net_device *dev, int budget)
+static void grcan_transmit_catch_up(struct net_device *dev)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
 	unsigned long flags;
@@ -1132,7 +1132,7 @@ static int grcan_transmit_catch_up(struct net_device *dev, int budget)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	work_done = catch_up_echo_skb(dev, budget, true);
+	work_done = catch_up_echo_skb(dev, -1, true);
 	if (work_done) {
 		if (!priv->resetting && !priv->closing &&
 		    !(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
@@ -1146,8 +1146,6 @@ static int grcan_transmit_catch_up(struct net_device *dev, int budget)
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
-
-	return work_done;
 }
 
 static int grcan_receive(struct net_device *dev, int budget)
@@ -1229,19 +1227,13 @@ static int grcan_poll(struct napi_struct *napi, int budget)
 	struct net_device *dev = priv->dev;
 	struct grcan_registers __iomem *regs = priv->regs;
 	unsigned long flags;
-	int tx_work_done, rx_work_done;
-	int rx_budget = budget / 2;
-	int tx_budget = budget - rx_budget;
+	int work_done;
 
-	/* Half of the budget for receiving messages */
-	rx_work_done = grcan_receive(dev, rx_budget);
+	work_done = grcan_receive(dev, budget);
 
-	/* Half of the budget for transmitting messages as that can trigger echo
-	 * frames being received
-	 */
-	tx_work_done = grcan_transmit_catch_up(dev, tx_budget);
+	grcan_transmit_catch_up(dev);
 
-	if (rx_work_done < rx_budget && tx_work_done < tx_budget) {
+	if (work_done < budget) {
 		napi_complete(napi);
 
 		/* Guarantee no interference with a running reset that otherwise
@@ -1258,7 +1250,7 @@ static int grcan_poll(struct napi_struct *napi, int budget)
 		spin_unlock_irqrestore(&priv->lock, flags);
 	}
 
-	return rx_work_done + tx_work_done;
+	return work_done;
 }
 
 /* Work tx bug by waiting while for the risky situation to clear. If that fails,
-- 
2.17.1

