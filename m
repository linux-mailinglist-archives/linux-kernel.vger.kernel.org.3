Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00A24A85BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbiBCOGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:06:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43479 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbiBCOGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:06:12 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nFcc5-00033s-10; Thu, 03 Feb 2022 14:57:29 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nFcc4-009xpX-Hv; Thu, 03 Feb 2022 14:57:28 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 2/2] counter: interrupt-cnt: add counter_push_event()
Date:   Thu,  3 Feb 2022 14:57:27 +0100
Message-Id: <20220203135727.2374052-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203135727.2374052-1-o.rempel@pengutronix.de>
References: <20220203135727.2374052-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add counter_push_event() to notify user space about new pulses

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/counter/interrupt-cnt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 9e99702470c2..3b13f56bbb11 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -26,10 +26,13 @@ struct interrupt_cnt_priv {
 
 static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
 {
-	struct interrupt_cnt_priv *priv = dev_id;
+	struct counter_device *counter = dev_id;
+	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
 	atomic_inc(&priv->count);
 
+	counter_push_event(counter, COUNTER_EVENT_CHANGE_OF_STATE, 0);
+
 	return IRQ_HANDLED;
 }
 
@@ -209,7 +212,7 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
 			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
-			       dev_name(dev), priv);
+			       dev_name(dev), counter);
 	if (ret)
 		return ret;
 
-- 
2.30.2

