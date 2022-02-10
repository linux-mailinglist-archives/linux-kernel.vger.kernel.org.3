Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7B34B14C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245452AbiBJR7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:59:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245442AbiBJR7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:59:08 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B751A8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:59:08 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21AHwxYR033936;
        Thu, 10 Feb 2022 11:58:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644515939;
        bh=B2bHIKbB6eJK04fx2EZ+8k0DR+9c9Sj3ZRCNCaJmzEI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NEmmy2gSKxq7R+VpCsDJIr9xebEQoRhRQoKdG+meCePsj0YQOvgj5Sj/OmnUpPSjo
         jH0b5dEOaJPkNNPLQVl4ctwXqXW4mL8DMVd629q6St9Ss+Rxz9eBMxS1ZGaWT8rgOs
         SeDloTlfNFvUtyYWGOla2qA15xkzaMGsfsZjujzo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21AHwxa4095188
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Feb 2022 11:58:59 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 10
 Feb 2022 11:58:58 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 10 Feb 2022 11:58:58 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21AHww4O120840;
        Thu, 10 Feb 2022 11:58:58 -0600
From:   Dave Gerlach <d-gerlach@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Dave Gerlach <d-gerlach@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/1] firmware: ti_sci: Switch transport to polled mode during system suspend
Date:   Thu, 10 Feb 2022 11:58:58 -0600
Message-ID: <20220210175858.11247-2-d-gerlach@ti.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220210175858.11247-1-d-gerlach@ti.com>
References: <20220210175858.11247-1-d-gerlach@ti.com>
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
 drivers/firmware/ti_sci.c | 61 +++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 5ae2040b8b02..7f1844e16c47 100644
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

