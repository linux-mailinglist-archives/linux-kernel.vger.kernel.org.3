Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5654A4F8222
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbiDGOvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbiDGOvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:51:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C01C7C25
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:49:42 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZ4494wkVzgYXB;
        Thu,  7 Apr 2022 22:47:53 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 22:49:38 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 22:49:38 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/2] amba: fix memory leak in amba_device_try_add()
Date:   Thu, 7 Apr 2022 23:02:40 +0800
Message-ID: <20220407150240.151166-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220407150240.151166-1-wangkefeng.wang@huawei.com>
References: <20220407150240.151166-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If amba_device_try_add() return error code (not EPROBE_DEFER),
memory leak occurred when amba device fails to read periphid.

unreferenced object 0xc1c60800 (size 1024):
  comm "swapper/0", pid 1, jiffies 4294937333 (age 75.200s)
  hex dump (first 32 bytes):
    40 40 db c1 04 08 c6 c1 04 08 c6 c1 00 00 00 00  @@..............
    00 d9 c1 c1 84 6f 38 c1 00 00 00 00 01 00 00 00  .....o8.........
  backtrace:
    [<(ptrval)>] kmem_cache_alloc_trace+0x168/0x2b4
    [<(ptrval)>] amba_device_alloc+0x38/0x7c
    [<(ptrval)>] of_platform_bus_create+0x2f4/0x4e8
    [<(ptrval)>] of_platform_bus_create+0x380/0x4e8
    [<(ptrval)>] of_platform_bus_create+0x380/0x4e8
    [<(ptrval)>] of_platform_bus_create+0x380/0x4e8
    [<(ptrval)>] of_platform_populate+0x70/0xc4
    [<(ptrval)>] of_platform_default_populate_init+0xb4/0xcc
    [<(ptrval)>] do_one_initcall+0x58/0x218
    [<(ptrval)>] kernel_init_freeable+0x250/0x29c
    [<(ptrval)>] kernel_init+0x24/0x148
    [<(ptrval)>] ret_from_fork+0x14/0x1c
    [<00000000>] 0x0
unreferenced object 0xc1db4040 (size 64):
  comm "swapper/0", pid 1, jiffies 4294937333 (age 75.200s)
  hex dump (first 32 bytes):
    31 63 30 66 30 30 30 30 2e 77 64 74 00 00 00 00  1c0f0000.wdt....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<(ptrval)>] __kmalloc_track_caller+0x19c/0x2f8
    [<(ptrval)>] kvasprintf+0x60/0xcc
    [<(ptrval)>] kvasprintf_const+0x54/0x78
    [<(ptrval)>] kobject_set_name_vargs+0x34/0xa8
    [<(ptrval)>] dev_set_name+0x40/0x5c
    [<(ptrval)>] of_device_make_bus_id+0x128/0x1f8
    [<(ptrval)>] of_platform_bus_create+0x4dc/0x4e8
    [<(ptrval)>] of_platform_bus_create+0x380/0x4e8
    [<(ptrval)>] of_platform_bus_create+0x380/0x4e8
    [<(ptrval)>] of_platform_bus_create+0x380/0x4e8
    [<(ptrval)>] of_platform_populate+0x70/0xc4
    [<(ptrval)>] of_platform_default_populate_init+0xb4/0xcc
    [<(ptrval)>] do_one_initcall+0x58/0x218
    [<(ptrval)>] kernel_init_freeable+0x250/0x29c
    [<(ptrval)>] kernel_init+0x24/0x148
    [<(ptrval)>] ret_from_fork+0x14/0x1c

Fix them by adding amba_device_put() to release device name and
amba device.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 0073d8ba0353..7e775ba6fdd9 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -478,8 +478,14 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 		goto skip_probe;
 
 	ret = amba_read_periphid(dev);
-	if (ret)
+	if (ret) {
+		if (ret != -EPROBE_DEFER) {
+			amba_device_put(dev);
+			goto err_out;
+		}
 		goto err_release;
+	}
+
 skip_probe:
 	ret = device_add(&dev->dev);
 err_release:
-- 
2.26.2

