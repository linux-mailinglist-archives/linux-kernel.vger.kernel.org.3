Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C4C481D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbhL3PDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbhL3PDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF68C06175C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxP-0000cP-0V; Thu, 30 Dec 2021 16:03:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxM-007VKl-WB; Thu, 30 Dec 2021 16:03:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxL-0007hB-Kx; Thu, 30 Dec 2021 16:03:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 06/23] counter: interrupt-cnt: Convert to counter_priv() wrapper
Date:   Thu, 30 Dec 2021 16:02:43 +0100
Message-Id: <20211230150300.72196-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2386; h=from:subject; bh=ScSX9M6WEmr2zHotq+DCYxiwYwGU/fI0ZlDKzhLgR4A=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzclovs4jX8wmoAm13sWLSZ0VrIbwBWnmCxW/ctwa JodCCm6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JaAAKCRDB/BR4rcrsCdK/B/ 4hkq89JKu8ztRy5w19XhtUkMvB/1j5xGpYmiAd8Vr8FtIerz10jSuFMlvG51UmFYYh27w5BGpQmGCD zOBHWaWEAN0v2DTcGDg9Rn5837hY7UtlvfcyC34oka4qCVcBiIRgndfwHjLm+/FSN+cY6MEJMxynfr rcfS7HMGacQu7Y4SfzIsCxAe21CzxADbD9t0xFSa7xYvTYVKovbvBSF4SzGf3piQoPoG3IqXvQqgSR I7p9JjSNnoNQS/0oU6LcHf4SKQSsxDyoxwGIdPVXWlRg55CbpQd93ZPEGfBe6WwLCqtiS5WE079nUa dncOzpOcsvCy2mMjWt4GL30/HZ4shr
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a straight forward conversion to the new counter_priv() wrapper.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/interrupt-cnt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 8514a87fcbee..4bf706ef46e2 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -37,7 +37,7 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
 static int interrupt_cnt_enable_read(struct counter_device *counter,
 				     struct counter_count *count, u8 *enable)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
 	*enable = priv->enabled;
 
@@ -47,7 +47,7 @@ static int interrupt_cnt_enable_read(struct counter_device *counter,
 static int interrupt_cnt_enable_write(struct counter_device *counter,
 				      struct counter_count *count, u8 enable)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
 	if (priv->enabled == enable)
 		return 0;
@@ -85,7 +85,7 @@ static int interrupt_cnt_action_read(struct counter_device *counter,
 static int interrupt_cnt_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
 	*val = atomic_read(&priv->count);
 
@@ -95,7 +95,7 @@ static int interrupt_cnt_read(struct counter_device *counter,
 static int interrupt_cnt_write(struct counter_device *counter,
 			       struct counter_count *count, const u64 val)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
 	if (val != (typeof(priv->count.counter))val)
 		return -ERANGE;
@@ -122,7 +122,7 @@ static int interrupt_cnt_signal_read(struct counter_device *counter,
 				     struct counter_signal *signal,
 				     enum counter_signal_level *level)
 {
-	struct interrupt_cnt_priv *priv = counter->priv;
+	struct interrupt_cnt_priv *priv = counter_priv(counter);
 	int ret;
 
 	if (!priv->gpio)
-- 
2.34.1

