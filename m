Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181DF598A81
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbiHRR3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344394AbiHRR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:29:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA346C130
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:29:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33352499223so36972187b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=XF7rMgkGkogE1LDudIb7xz7osN0RWeSRX+mI0Z+KjmI=;
        b=RVpLZYDS3msVWhWN86uj5XmiWsuInRaiz08hd32GGW2Jjj+IcPb2r6tOC85wlkvnUR
         maN2snFEEFZR1cdwdxaSXWGcGWw1WWo22fI913gqORbWqkONMl36pl4M90LVTpYvN8l8
         qR/p88+6tFGJP9KD1Mupsgsn9LAoIXzLgx7ugcVwW+W86tKGr8N+M28jMHFMyKosdrGQ
         ZhHQBN7y7F+xfd5aFRheZLuVlvloVbBOLft/hd9VZDCXjIKfhzrb88XhvTy9w4yhMwa9
         TeDmIpbclLj3GYw9lSYNEo0uiqWmqTW106mQqe3j3d2KW1sqtqQ/QUOatcazbvDSlmn1
         cM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=XF7rMgkGkogE1LDudIb7xz7osN0RWeSRX+mI0Z+KjmI=;
        b=Ne/JDtqgza79J4UlHFhAceAMvPPZsUDfbFwotY0xGJzN6IguwhCZcQ14xw0Kk+lmjQ
         kQdgi2uA8EB5aZHavlTcvkKedbNImBIt2csfwakhPgpaThbaTtMINDOSh20S7VANmOsI
         2PUVWzPMTlLbxB06D0cus87O7UkODdk39H8WwzPQXP16/qOzYH3LN7b2NYsRHpnbCaJX
         MiWvdpKfLrz/6WqIAT6srF8+fBw7H/Zw5h6uvTTFIYGoyk/MmwnyZqM3ysSTp/hG/KrO
         q3QD9juYgQ5DH34SA4DWZwSV1QFwR4PKz0Vu5RCMWGCgsQwuUm00BFMbrIfmCRhjftJe
         ifEQ==
X-Gm-Message-State: ACgBeo0c/T9EPpbHeZw3c7QQpXoCEsADTfUBlPvfVXzJoIM9Q9e+5eBh
        sXm5G5Fg3f+no+8ghzTz3LDu8zZJg2xhIIwn1cF5zg==
X-Google-Smtp-Source: AA6agR6sB4LlpbMJED7ZTSMa5nF65b47m2WBlliFZBVD/kQiv2gHKFh3hiJGL3Q9oEiznGv6nA/xvVqMs4MSOIgovRv8Hg==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:aa25:fe91:7e28:16bc])
 (user=isaacmanjarres job=sendgmr) by 2002:a25:2543:0:b0:67f:d33d:53f1 with
 SMTP id l64-20020a252543000000b0067fd33d53f1mr3867449ybl.412.1660843739883;
 Thu, 18 Aug 2022 10:28:59 -0700 (PDT)
Date:   Thu, 18 Aug 2022 10:28:51 -0700
Message-Id: <20220818172852.3548-1-isaacmanjarres@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2] amba: Fix use-after-free in amba_read_periphid()
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        patches@armlinux.org.uk, Guenter Roeck <linux@roeck-us.net>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device
addition"), it became possible for amba_read_periphid() to be invoked
concurrently from two threads for a particular AMBA device.

Consider the case where a thread (T0) is registering an AMBA driver, and
searching for all of the devices it can match with on the AMBA bus.
Suppose that another thread (T1) is executing the deferred probe work,
and is searching through all of the AMBA drivers on the bus for a driver
that matches a particular AMBA device. Assume that both threads begin
operating on the same AMBA device and the device's peripheral ID is
still unknown.

In this scenario, the amba_match() function will be invoked for the
same AMBA device by both threads, which means amba_read_periphid()
can also be invoked by both threads, and both threads will be able
to manipulate the AMBA device's pclk pointer without any synchronization.
It's possible that one thread will initialize the pclk pointer, then the
other thread will re-initialize it, overwriting the previous value, and
both will race to free the same pclk, resulting in a use-after-free for
whichever thread frees the pclk last.

Add a lock per AMBA device to synchronize the handling with detecting the
peripheral ID to avoid the use-after-free scenario.

The following KFENCE bug report helped detect this problem:
==================================================================
BUG: KFENCE: use-after-free read in clk_disable+0x14/0x34

Use-after-free read at 0x(ptrval) (in kfence-#19):
 clk_disable+0x14/0x34
 amba_read_periphid+0xdc/0x134
 amba_match+0x3c/0x84
 __driver_attach+0x20/0x158
 bus_for_each_dev+0x74/0xc0
 bus_add_driver+0x154/0x1e8
 driver_register+0x88/0x11c
 do_one_initcall+0x8c/0x2fc
 kernel_init_freeable+0x190/0x220
 kernel_init+0x10/0x108
 ret_from_fork+0x14/0x3c
 0x0

kfence-#19: 0x(ptrval)-0x(ptrval), size=36, cache=kmalloc-64

allocated by task 8 on cpu 0 at 11.629931s:
 clk_hw_create_clk+0x38/0x134
 amba_get_enable_pclk+0x10/0x68
 amba_read_periphid+0x28/0x134
 amba_match+0x3c/0x84
 __device_attach_driver+0x2c/0xc4
 bus_for_each_drv+0x80/0xd0
 __device_attach+0xb0/0x1f0
 bus_probe_device+0x88/0x90
 deferred_probe_work_func+0x8c/0xc0
 process_one_work+0x23c/0x690
 worker_thread+0x34/0x488
 kthread+0xd4/0xfc
 ret_from_fork+0x14/0x3c
 0x0

freed by task 8 on cpu 0 at 11.630095s:
 amba_read_periphid+0xec/0x134
 amba_match+0x3c/0x84
 __device_attach_driver+0x2c/0xc4
 bus_for_each_drv+0x80/0xd0
 __device_attach+0xb0/0x1f0
 bus_probe_device+0x88/0x90
 deferred_probe_work_func+0x8c/0xc0
 process_one_work+0x23c/0x690
 worker_thread+0x34/0x488
 kthread+0xd4/0xfc
 ret_from_fork+0x14/0x3c
 0x0

Cc: Saravana Kannan <saravanak@google.com>
Cc: patches@armlinux.org.uk
Fixes: f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device addition")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
KernelVersion: rmk/for-next

 drivers/amba/bus.c       | 8 +++++++-
 include/linux/amba/bus.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

v1 -> v2:
- Applied on rmk/for-next

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 32b0e0b930c1..110a535648d2 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -209,6 +209,7 @@ static int amba_match(struct device *dev, struct device_driver *drv)
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *pcdrv = to_amba_driver(drv);
 
+	mutex_lock(&pcdev->periphid_lock);
 	if (!pcdev->periphid) {
 		int ret = amba_read_periphid(pcdev);
 
@@ -218,11 +219,14 @@ static int amba_match(struct device *dev, struct device_driver *drv)
 		 * permanent failure in reading pid and cid, simply map it to
 		 * -EPROBE_DEFER.
 		 */
-		if (ret)
+		if (ret) {
+			mutex_unlock(&pcdev->periphid_lock);
 			return -EPROBE_DEFER;
+		}
 		dev_set_uevent_suppress(dev, false);
 		kobject_uevent(&dev->kobj, KOBJ_ADD);
 	}
+	mutex_unlock(&pcdev->periphid_lock);
 
 	/* When driver_override is set, only bind to the matching driver */
 	if (pcdev->driver_override)
@@ -532,6 +536,7 @@ static void amba_device_release(struct device *dev)
 
 	if (d->res.parent)
 		release_resource(&d->res);
+	mutex_destroy(&d->periphid_lock);
 	kfree(d);
 }
 
@@ -584,6 +589,7 @@ static void amba_device_initialize(struct amba_device *dev, const char *name)
 	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
 	dev->dev.dma_parms = &dev->dma_parms;
 	dev->res.name = dev_name(&dev->dev);
+	mutex_init(&dev->periphid_lock);
 }
 
 /**
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index e94cdf235f1d..5001e14c5c06 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -67,6 +67,7 @@ struct amba_device {
 	struct clk		*pclk;
 	struct device_dma_parameters dma_parms;
 	unsigned int		periphid;
+	struct mutex		periphid_lock;
 	unsigned int		cid;
 	struct amba_cs_uci_id	uci;
 	unsigned int		irq[AMBA_NR_IRQS];
-- 
2.37.1.595.g718a3a8f04-goog

