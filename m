Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8BA47BE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhLUKqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhLUKqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:46:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BE3C061748
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:46:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcei-0005BI-Rb; Tue, 21 Dec 2021 11:46:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcei-005nfz-FY; Tue, 21 Dec 2021 11:46:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzceh-0004By-7D; Tue, 21 Dec 2021 11:46:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Oleksij Rempel <linux@rempel-privat.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] counter: interrupt-cnt: Use container_of instead of struct counter_device::priv
Date:   Tue, 21 Dec 2021 11:45:42 +0100
Message-Id: <20211221104546.214066-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=k5h2hlgCdmOIAEJ7Fs8WZpknSGjaIvXaLZnK8BkIGW8=; m=zhLK+hnhOwzuTQYiqBPMLfjqowx6F6J8r6X6vgVOca8=; p=dgCJ1NZDgXSaEGIddQpEUHjgk268Zy+G9OFdHZSQSG4=; g=4e97fb2e9cadb1143a60b137d87eabb130b8e4f4
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHBsD8ACgkQwfwUeK3K7Anx7Qf9GyT QCjMD2VJKD3SdfZOlrlbJf/rli/UpGwRJkMP4tTH1cyuWTC8A/I+wvsw8YBzj42OwRV+RmRfXw38J 6ak+MZ8isF7Djt7rvwVeasI142MpP9teM45mSHNhdaXNR0GmXSk6W8qVxDGKkUYLJciXz5un1YYUd 0WhlSgP0NZeJJC3uIxNuesd1d7GWUZV6DUXWGzpuMkpHVKt0MDLWhtxNecapeN52+4CTb4fDblRRS 2Gb0m7Rmp30Kt2qPiDXGtVTiEUg7P+BwzmoiHetE2BUReKCV006pGtTAwR8LvPLJyc5qIpSaUYGaK IVpKuKSUaS091DeJTFuuUcmbnB9f+qQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using counter->priv is a memory read and so more expensive than
container_of which is only an addition.

So container_of is expected to be a tad faster, it's type-safe, and
produces smaller code (ARCH=arm allmodconfig):

	add/remove: 0/0 grow/shrink: 0/6 up/down: 0/-60 (-60)
	Function                                     old     new   delta
	interrupt_cnt_write                          136     128      -8
	interrupt_cnt_read                            92      84      -8
	interrupt_cnt_enable_write                   180     172      -8
	interrupt_cnt_enable_read                     76      68      -8
	interrupt_cnt_probe                         1048    1036     -12
	interrupt_cnt_signal_read                    164     148     -16
	Total: Before=2841, After=2781, chg -2.11%

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/interrupt-cnt.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 8514a87fcbee..c61628aa5c32 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -25,6 +25,11 @@ struct interrupt_cnt_priv {
 	struct counter_count cnts;
 };
 
+static inline struct interrupt_cnt_priv *interrupt_cnt_from_counter(struct counter_device *counter)
+{
+	return container_of(counter, struct interrupt_cnt_priv, counter);
+}
+
 static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
 {
 	struct interrupt_cnt_priv *priv = dev_id;
@@ -37,7 +42,7 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
 static int interrupt_cnt_enable_read(struct counter_device *counter,
 				     struct counter_count *count, u8 *enable)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = interrupt_cnt_from_counter(counter);
 
 	*enable = priv->enabled;
 
@@ -47,7 +52,7 @@ static int interrupt_cnt_enable_read(struct counter_device *counter,
 static int interrupt_cnt_enable_write(struct counter_device *counter,
 				      struct counter_count *count, u8 enable)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = interrupt_cnt_from_counter(counter);
 
 	if (priv->enabled == enable)
 		return 0;
@@ -85,7 +90,7 @@ static int interrupt_cnt_action_read(struct counter_device *counter,
 static int interrupt_cnt_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = interrupt_cnt_from_counter(counter);
 
 	*val = atomic_read(&priv->count);
 
@@ -95,7 +100,7 @@ static int interrupt_cnt_read(struct counter_device *counter,
 static int interrupt_cnt_write(struct counter_device *counter,
 			       struct counter_count *count, const u64 val)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = interrupt_cnt_from_counter(counter);
 
 	if (val != (typeof(priv->count.counter))val)
 		return -ERANGE;
@@ -122,7 +127,7 @@ static int interrupt_cnt_signal_read(struct counter_device *counter,
 				     struct counter_signal *signal,
 				     enum counter_signal_level *level)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = interrupt_cnt_from_counter(counter);
 	int ret;
 
 	if (!priv->gpio)
@@ -199,7 +204,6 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	priv->cnts.ext = interrupt_cnt_ext;
 	priv->cnts.num_ext = ARRAY_SIZE(interrupt_cnt_ext);
 
-	priv->counter.priv = priv;
 	priv->counter.name = dev_name(dev);
 	priv->counter.parent = dev;
 	priv->counter.ops = &interrupt_cnt_ops;
-- 
2.33.0

