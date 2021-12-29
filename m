Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91974814AC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbhL2PpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240626AbhL2Po6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:44:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479B7C061748
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:44:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8H-0006qM-8e; Wed, 29 Dec 2021 16:44:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8E-007KGm-92; Wed, 29 Dec 2021 16:44:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8C-00012M-Pd; Wed, 29 Dec 2021 16:44:48 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/23] counter: Provide a wrapper to access device private data
Date:   Wed, 29 Dec 2021 16:44:22 +0100
Message-Id: <20211229154441.38045-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; h=from:subject; bh=nI58JSBfZvVnyN7QPFK4oMMervOf4JOAenELBrn+YQs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIIbL+kTmyWBIbdKKa2s0P6eY0bwWeRn4wqcnwKh wCF4VFGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCGwAKCRDB/BR4rcrsCZ6nB/ wPbHt7Ab+jh/3Wi5VhpJW8ISfS+JNBiyGm6NzNFTIXfVyYHrwxK8ghQmZ5fw6Z/mvL4biwGtUbRvXz AZmO7y/OGhvOd7bodovcaKyOtr9nlXMbEJUTb4GrLsj/d9bruD9tgM68LGEmxUmY1tdwr232jnCW+Q wJaEssqIre5sOrQolxxFjJL7jZhkDBkk7J/DT7eRq3meMwvn6tnYl03+9GeyOv4F1e/lmpKtk+pUO0 kNP36EevieDJxbD8tl+W3qUEEuNqSk7CaC4y+iLqlxhSkBL4tvBfRF+AIsC1ep/U/ldKHQJVNsCLWL jYjgFmHxZwjxMK2r77Iw1kUoLN2hMv
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
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
2.34.1

