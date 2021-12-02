Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FDF4664E8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358403AbhLBOLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358402AbhLBOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:11:28 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DE1C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 06:08:05 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638454083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gPirYehpBwpu5LgsC7IQsyd1iqeSQ6rbgeQ4CjpKlRA=;
        b=t2yTj1Nxu0I+EOzRfxw+iLzuDZyNsTw2IL1GpCSM9IWPC2SJCVb1NvzA2BZzQ/eNCFKFv7
        SGvjygnmghFH7P1+WEwzhq1m48/f2QrMIwWqM5AwQJ1LpA4PiSWuOTJnRe+7kqfZyYDqbo
        9YYBxn+/VnbBgZFGexItXY3P6llxO+8=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: mips_ejtag_fdc: Make use of the helper function kthread_run_on_cpu()
Date:   Thu,  2 Dec 2021 22:07:37 +0800
Message-Id: <20211202140737.94832-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kthread_create/kthread_bind/wake_up_process() with
kthread_run_on_cpu() to simplify the code.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/tty/mips_ejtag_fdc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 02c10a968de1..31dceb5039b5 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -955,19 +955,18 @@ static int mips_ejtag_fdc_tty_probe(struct mips_cdmm_device *dev)
 		mips_ejtag_fdc_con.tty_drv = driver;
 
 	init_waitqueue_head(&priv->waitqueue);
-	priv->thread = kthread_create(mips_ejtag_fdc_put, priv, priv->fdc_name);
-	if (IS_ERR(priv->thread)) {
-		ret = PTR_ERR(priv->thread);
-		dev_err(priv->dev, "Couldn't create kthread (%d)\n", ret);
-		goto err_destroy_ports;
-	}
 	/*
 	 * Bind the writer thread to the right CPU so it can't migrate.
 	 * The channels are per-CPU and we want all channel I/O to be on a
 	 * single predictable CPU.
 	 */
-	kthread_bind(priv->thread, dev->cpu);
-	wake_up_process(priv->thread);
+	priv->thread = kthread_run_on_cpu(mips_ejtag_fdc_put, priv,
+					  dev->cpu, "ttyFDC/%u");
+	if (IS_ERR(priv->thread)) {
+		ret = PTR_ERR(priv->thread);
+		dev_err(priv->dev, "Couldn't create kthread (%d)\n", ret);
+		goto err_destroy_ports;
+	}
 
 	/* Look for an FDC IRQ */
 	priv->irq = get_c0_fdc_int();
@@ -1095,15 +1094,14 @@ static int mips_ejtag_fdc_tty_cpu_up(struct mips_cdmm_device *dev)
 	}
 
 	/* Restart the kthread */
-	priv->thread = kthread_create(mips_ejtag_fdc_put, priv, priv->fdc_name);
+	/* Bind it back to the right CPU and set it off */
+	priv->thread = kthread_run_on_cpu(mips_ejtag_fdc_put, priv,
+					  dev->cpu, "ttyFDC/%u");
 	if (IS_ERR(priv->thread)) {
 		ret = PTR_ERR(priv->thread);
 		dev_err(priv->dev, "Couldn't re-create kthread (%d)\n", ret);
 		goto out;
 	}
-	/* Bind it back to the right CPU and set it off */
-	kthread_bind(priv->thread, dev->cpu);
-	wake_up_process(priv->thread);
 out:
 	return ret;
 }
-- 
2.25.1

