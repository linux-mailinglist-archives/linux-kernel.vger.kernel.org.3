Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB08747FBA2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhL0Jqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbhL0Jps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9412BC0617A1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZU-0006YH-G5; Mon, 27 Dec 2021 10:45:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZS-006u8p-E8; Mon, 27 Dec 2021 10:45:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZR-0005Ts-CH; Mon, 27 Dec 2021 10:45:33 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/23] counter: Provide a wrapper to access device private data
Date:   Mon, 27 Dec 2021 10:45:07 +0100
Message-Id: <20211227094526.698714-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=nzQ4DnbOEgzHi7qbM8FcV4rIskOl3PDISWEFqgrONvE=; m=5uhD8Y8IZ4ytbBJcTc1wfOxi3FuwAZvDpWmUecQv954=; p=rSRrtmEFfPgDVQa4FhzU+CjOfeIKDMTamuJlb7/VKiY=; g=906fdcea6105edfcfeb026b61556fa3378e94ade
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJim0ACgkQwfwUeK3K7Ama7gf+PDT 4cSWVm8lkjM08GPVPwjxDtwAsiNKKe21JIiipRi9HzPsvXZnR1tXLynOA/O9RO13OrRytRGVHV3ae ratI0Gk9X3aSR+sR7/2dRm9OydNbw6kM+516BSL0NQfyofHVpCDs3d8DMwVIzDlY2jvnZ6epFtAqm XBhfa07G/hRFCQMbNdARv8PCHn2TsmwQMQhWvo7owp51dOGhlq8woaAw+jaELpST0xtMl43P8rinW QwlWsAXI2aS+kpOPPXfUdLFTovWR1npKOWgJ+H+jUy3XaMUf/QFWIl/p7O34HZjQIIMsEM45D1d6W U0yF5j5B2Fg3PSY+ev1yGKVEAGF1R9g==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now this just wraps accessing struct counter_device::priv. However
this is about to change and converting drivers to this helper
individually makes fixing device lifetime issues result in easier to
review patches.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/counter-core.c | 12 ++++++++++++
 include/linux/counter.h        |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index f053a43c6c04..00c41f28c101 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -45,6 +45,18 @@ static struct bus_type counter_bus_type = {
 
 static dev_t counter_devt;
 
+/**
+ * counter_priv - access counter device private data
+ * @counter: counter device
+ *
+ * Get the counter device private data
+ */
+void *counter_priv(const struct counter_device *const counter)
+{
+	return counter->priv;
+}
+EXPORT_SYMBOL_GPL(counter_priv);
+
 /**
  * counter_register - register Counter to the system
  * @counter:	pointer to Counter to register
diff --git a/include/linux/counter.h b/include/linux/counter.h
index b7d0a00a61cf..8daaa38c71d8 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -329,6 +329,8 @@ struct counter_device {
 	struct mutex ops_exist_lock;
 };
 
+void *counter_priv(const struct counter_device *const counter);
+
 int counter_register(struct counter_device *const counter);
 void counter_unregister(struct counter_device *const counter);
 int devm_counter_register(struct device *dev,
-- 
2.33.0

