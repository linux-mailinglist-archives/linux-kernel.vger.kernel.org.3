Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464D94FE889
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 21:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352098AbiDLTYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiDLTYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:24:20 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149522182C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:21:59 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23CJLmCX122083;
        Tue, 12 Apr 2022 14:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649791308;
        bh=4S1RUOXcbZxG3WKNqNwLEJhycOS8MjSrjSKSjrGitrU=;
        h=From:To:CC:Subject:Date;
        b=jCQi/gZHfi/M98rtPW3/gstTqg4kGHqS9IlSjgOOwfH0mbCff5SOMqZd4KaZKphwh
         3dWkv+gcLDlPShr0B7XfbBV733w8Qxz57wraD7NBqOpTX81GvWlsqeaADtjlAhZ+XX
         5iNR7sIPct+7KI7su+c1+YP42rpYrt+cyX58SVRI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23CJLm3c091533
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Apr 2022 14:21:48 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Apr 2022 14:21:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Apr 2022 14:21:48 -0500
Received: from uda0274052 (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23CJLmqY100489;
        Tue, 12 Apr 2022 14:21:48 -0500
Received: from a0274052local by uda0274052 with local (Exim 4.90_1)
        (envelope-from <d-gerlach@ti.com>)
        id 1neM5E-00087N-4V; Tue, 12 Apr 2022 14:21:48 -0500
From:   Dave Gerlach <d-gerlach@ti.com>
To:     <kristo@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <d-gerlach@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v2] firmware: ti_sci: Switch transport to polled mode during system suspend
Date:   Tue, 12 Apr 2022 14:21:38 -0500
Message-ID: <20220412192138.31189-1-d-gerlach@ti.com>
X-Mailer: git-send-email 2.35.0
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

During system suspend it is completely valid for devices to invoke TISCI
commands during the noirq phase of the suspend path. Specifically this
will always be seen for devices that define a power-domains DT property
and make use of the ti_sci_pm_domains genpd implementation.
The genpd_finish_suspend call will power off devices during the noirq
phase, which will invoke TISCI.

In order to support this, the ti_sci driver must switch to not use
wait_for_completion_timeout during suspend, but instead rely on a manual
check for if the completion is not yet done, and proceed only if this is
the case.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
Resend to correct git send-email From address issue, sorry for the noise.

v1 -> v2:
 * Rebase on v5.18-rc1 now that mailbox dependency has been merged.

v1: https://lore.kernel.org/lkml/20220210175858.11247-1-d-gerlach@ti.com/

 drivers/firmware/ti_sci.c | 61 +++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 4697edc125b1..ebc32bbd9b83 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments System Control Interface Protocol Driver
  *
- * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2015-2022 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  */
 
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
@@ -96,6 +97,7 @@ struct ti_sci_desc {
  * @node:	list head
  * @host_id:	Host ID
  * @users:	Number of users of this instance
+ * @is_suspending: Flag set to indicate in suspend path.
  */
 struct ti_sci_info {
 	struct device *dev;
@@ -114,7 +116,7 @@ struct ti_sci_info {
 	u8 host_id;
 	/* protected by ti_sci_list_mutex */
 	int users;
-
+	bool is_suspending;
 };
 
 #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
@@ -349,6 +351,8 @@ static struct ti_sci_xfer *ti_sci_get_one_xfer(struct ti_sci_info *info,
 
 	hdr = (struct ti_sci_msg_hdr *)xfer->tx_message.buf;
 	xfer->tx_message.len = tx_message_size;
+	xfer->tx_message.chan_rx = info->chan_rx;
+	xfer->tx_message.timeout_rx_ms = info->desc->max_rx_timeout_ms;
 	xfer->rx_len = (u8)rx_message_size;
 
 	reinit_completion(&xfer->done);
@@ -406,6 +410,7 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 	int ret;
 	int timeout;
 	struct device *dev = info->dev;
+	bool done_state = true;
 
 	ret = mbox_send_message(info->chan_tx, &xfer->tx_message);
 	if (ret < 0)
@@ -413,13 +418,27 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 
 	ret = 0;
 
-	/* And we wait for the response. */
-	timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
-	if (!wait_for_completion_timeout(&xfer->done, timeout)) {
+	if (!info->is_suspending) {
+		/* And we wait for the response. */
+		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
+		if (!wait_for_completion_timeout(&xfer->done, timeout))
+			ret = -ETIMEDOUT;
+	} else {
+		/*
+		 * If we are suspending, we cannot use wait_for_completion_timeout
+		 * during noirq phase, so we must manually poll the completion.
+		 */
+		ret = read_poll_timeout_atomic(try_wait_for_completion, done_state,
+					       true, 1,
+					       info->desc->max_rx_timeout_ms * 1000,
+					       false, &xfer->done);
+	}
+
+	if (ret == -ETIMEDOUT || !done_state) {
 		dev_err(dev, "Mbox timedout in resp(caller: %pS)\n",
 			(void *)_RET_IP_);
-		ret = -ETIMEDOUT;
 	}
+
 	/*
 	 * NOTE: we might prefer not to need the mailbox ticker to manage the
 	 * transfer queueing since the protocol layer queues things by itself.
@@ -3264,6 +3283,35 @@ static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 	return NOTIFY_BAD;
 }
 
+static void ti_sci_set_is_suspending(struct ti_sci_info *info, bool is_suspending)
+{
+	info->is_suspending = is_suspending;
+}
+
+static int ti_sci_suspend(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+	/*
+	 * We must switch operation to polled mode now as drivers and the genpd
+	 * layer may make late TI SCI calls to change clock and device states
+	 * from the noirq phase of suspend.
+	 */
+	ti_sci_set_is_suspending(info, true);
+
+	return 0;
+}
+
+static int ti_sci_resume(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+
+	ti_sci_set_is_suspending(info, false);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ti_sci_pm_ops, ti_sci_suspend, ti_sci_resume);
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3472,6 +3520,7 @@ static struct platform_driver ti_sci_driver = {
 	.driver = {
 		   .name = "ti-sci",
 		   .of_match_table = of_match_ptr(ti_sci_of_match),
+		   .pm = &ti_sci_pm_ops,
 	},
 };
 module_platform_driver(ti_sci_driver);
-- 
2.35.0

