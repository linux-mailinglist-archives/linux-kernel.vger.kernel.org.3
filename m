Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43C2481D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbhL3PEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbhL3PDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2661C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:18 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxQ-0000di-5O; Thu, 30 Dec 2021 16:03:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxP-007VLF-PT; Thu, 30 Dec 2021 16:03:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxN-0007j5-U8; Thu, 30 Dec 2021 16:03:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 16/23] counter: interrupt-cnt: Convert to new counter registration
Date:   Thu, 30 Dec 2021 16:02:53 +0100
Message-Id: <20211230150300.72196-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2847; h=from:subject; bh=kSjVLBg3kmMU/LwOxftyB5QQVKub9wY1wnwJYxRqekI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzcmg77tb9cuupSVHRrCAbwBzawT6ofIjcM5nYjmp M9Ow8TKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JoAAKCRDB/BR4rcrsCW9zCA CIhLPG+QydIO6BSaQ98qCBz2pHxpEGqZs4K0H5Gwe/vH6PGlExrUfg6mRKsQCpxjvYAGlP3NTytOAs NvCH1s+DYY2gpxiJ+Y0sPIUTrI2ZJnslajr11N07bJbtb76akn1YEPKh2VsHyLaGrKq3aFy81tAlzw 2xM4TVRscSjC3/4g/59eRrLnGxxkVzADkYyM/RWrfZWlae5mGEYHSrduyXc6BaGXhtVQXyYYDo64Sz p4px6ym1iAOkBpi8xCB+QrzwwlQcAsbLplu6AoUieEgi3Li1R8DLWgYW6YXCcwOA5q3sLXmwXm4u/a wPo8ZQxf0Wu1eDSj7xOuHM0xD8S32W
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes device lifetime issues where it was possible to free a live
struct device.

Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/interrupt-cnt.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 4bf706ef46e2..9e99702470c2 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -16,7 +16,6 @@
 
 struct interrupt_cnt_priv {
 	atomic_t count;
-	struct counter_device counter;
 	struct gpio_desc *gpio;
 	int irq;
 	bool enabled;
@@ -148,12 +147,14 @@ static const struct counter_ops interrupt_cnt_ops = {
 static int interrupt_cnt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct counter_device *counter;
 	struct interrupt_cnt_priv *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	counter = devm_counter_alloc(dev, sizeof(*priv));
+	if (!counter)
 		return -ENOMEM;
+	priv = counter_priv(counter);
 
 	priv->irq = platform_get_irq_optional(pdev,  0);
 	if (priv->irq == -ENXIO)
@@ -184,8 +185,8 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	if (!priv->signals.name)
 		return -ENOMEM;
 
-	priv->counter.signals = &priv->signals;
-	priv->counter.num_signals = 1;
+	counter->signals = &priv->signals;
+	counter->num_signals = 1;
 
 	priv->synapses.actions_list = interrupt_cnt_synapse_actions;
 	priv->synapses.num_actions = ARRAY_SIZE(interrupt_cnt_synapse_actions);
@@ -199,12 +200,11 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	priv->cnts.ext = interrupt_cnt_ext;
 	priv->cnts.num_ext = ARRAY_SIZE(interrupt_cnt_ext);
 
-	priv->counter.priv = priv;
-	priv->counter.name = dev_name(dev);
-	priv->counter.parent = dev;
-	priv->counter.ops = &interrupt_cnt_ops;
-	priv->counter.counts = &priv->cnts;
-	priv->counter.num_counts = 1;
+	counter->name = dev_name(dev);
+	counter->parent = dev;
+	counter->ops = &interrupt_cnt_ops;
+	counter->counts = &priv->cnts;
+	counter->num_counts = 1;
 
 	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
@@ -213,7 +213,11 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return devm_counter_register(dev, &priv->counter);
+	ret = devm_counter_add(dev, counter);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add counter\n");
+
+	return 0;
 }
 
 static const struct of_device_id interrupt_cnt_of_match[] = {
-- 
2.34.1

