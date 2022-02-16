Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE594B84A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiBPJna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:43:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiBPJnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:43:25 -0500
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 01:43:09 PST
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750C429412B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1645004589;
  x=1676540589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e0DJx/LBwDBcnKXR7T/m2VbehHGOddblLmaGHQmo1QM=;
  b=dDKk5rDjYPhma2/qxpiUqbv1/GIY4vba28yGzdfkP532EqzdSmFPh5iB
   OpV7LVq3AM7aIvuueMNgU9j0eoHHSyC4e55cpCQCYXBCbofnMbe3PA0fx
   xTWiEVEzutmV4QTaSnY4GWCIVMVM59lqVdd4ueFvIfCt5BgZKiqfR+SRO
   ztXf9ia6tJKtM2dhDyWraPWaq8RLgkUJvwIC0WM/cc+9LZHW1C9S7vWqQ
   9uABs2eQmfCGvibCMgNiqc7hI46SO1m05Otp9YncB9APrAFZnya+DqSi4
   ufAFG/qYG3HPe0lowrpvSbcMXsWwyhfLeVsSs6N7w9+hvPt6Hut920Xve
   Q==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <kernel@axis.com>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH] driver core: Free DMA range map when device is released
Date:   Wed, 16 Feb 2022 10:41:28 +0100
Message-ID: <20220216094128.4025861-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unbinding/binding a driver with DMA mapped memory, the DMA map is
not freed before the driver is reloaded. This leads to a memory leak
when the DMA map is overwritten when reprobing the driver.

This can be reproduced with a platform driver having a dma-range:

dummy {
	...
	#address-cells = <0x2>;
	#size-cells = <0x2>;
	ranges;
	dma-ranges = <...>;
	...
};

and then unbinding/binding it:

~# echo soc:dummy >/sys/bus/platform/drivers/<driver>/unbind

DMA map object 0xffffff800b0ae540 still being held by &pdev->dev

~# echo soc:dummy >/sys/bus/platform/drivers/<driver>/bind
~# echo scan > /sys/kernel/debug/kmemleak
~# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffffff800b0ae540 (size 64):
  comm "sh", pid 833, jiffies 4295174550 (age 2535.352s)
  hex dump (first 32 bytes):
    00 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 80 00 00 00 00 00 00 00 80 00 00 00 00  ................
  backtrace:
    [<ffffffefd1694708>] create_object.isra.0+0x108/0x344
    [<ffffffefd1d1a850>] kmemleak_alloc+0x8c/0xd0
    [<ffffffefd167e2d0>] __kmalloc+0x440/0x6f0
    [<ffffffefd1a960a4>] of_dma_get_range+0x124/0x220
    [<ffffffefd1a8ce90>] of_dma_configure_id+0x40/0x2d0
    [<ffffffefd198b68c>] platform_dma_configure+0x5c/0xa4
    [<ffffffefd198846c>] really_probe+0x8c/0x514
    [<ffffffefd1988990>] __driver_probe_device+0x9c/0x19c
    [<ffffffefd1988cd8>] device_driver_attach+0x54/0xbc
    [<ffffffefd1986634>] bind_store+0xc4/0x120
    [<ffffffefd19856e0>] drv_attr_store+0x30/0x44
    [<ffffffefd173c9b0>] sysfs_kf_write+0x50/0x60
    [<ffffffefd173c1c4>] kernfs_fop_write_iter+0x124/0x1b4
    [<ffffffefd16a013c>] new_sync_write+0xdc/0x160
    [<ffffffefd16a256c>] vfs_write+0x23c/0x2a0
    [<ffffffefd16a2758>] ksys_write+0x64/0xec

To prevent this we should free the dma_range_map when the device is
released.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/base/dd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9eaaff2f556c..f47cab21430f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -629,6 +629,9 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			drv->remove(dev);
 
 		devres_release_all(dev);
+		arch_teardown_dma_ops(dev);
+		kfree(dev->dma_range_map);
+		dev->dma_range_map = NULL;
 		driver_sysfs_remove(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
@@ -1209,6 +1212,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 		devres_release_all(dev);
 		arch_teardown_dma_ops(dev);
+		kfree(dev->dma_range_map);
+		dev->dma_range_map = NULL;
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
 		if (dev->pm_domain && dev->pm_domain->dismiss)
-- 
2.30.2

