Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D4C55CE76
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbiF1Ija (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbiF1IjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:39:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9072DA83
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:39:09 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXHwp5YtLzTgF8;
        Tue, 28 Jun 2022 16:35:38 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 16:39:08 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 16:39:07 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>
CC:     <laurent@vivier.eu>, <geert@linux-m68k.org>
Subject: [PATCH -next v2] m68k: virt: platform: fix missing platform_device_unregister() on error in virt_platform_init()
Date:   Tue, 28 Jun 2022 16:49:03 +0800
Message-ID: <20220628084903.3147123-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing platform_device_unregister() before return
from virt_platform_init() in the error handling case.

Fixes: 05d51e42df06 ("m68k: Introduce a virtual m68k machine")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v2:
  change for loop to while at lable err_unregister_rtc_virtio.
---
 arch/m68k/virt/platform.c | 58 ++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/arch/m68k/virt/platform.c b/arch/m68k/virt/platform.c
index cb820f19a221..1560c4140ab9 100644
--- a/arch/m68k/virt/platform.c
+++ b/arch/m68k/virt/platform.c
@@ -8,20 +8,15 @@
 
 #define VIRTIO_BUS_NB	128
 
-static int __init virt_virtio_init(unsigned int id)
+static struct platform_device * __init virt_virtio_init(unsigned int id)
 {
 	const struct resource res[] = {
 		DEFINE_RES_MEM(virt_bi_data.virtio.mmio + id * 0x200, 0x200),
 		DEFINE_RES_IRQ(virt_bi_data.virtio.irq + id),
 	};
-	struct platform_device *pdev;
 
-	pdev = platform_device_register_simple("virtio-mmio", id,
+	return platform_device_register_simple("virtio-mmio", id,
 					       res, ARRAY_SIZE(res));
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	return 0;
 }
 
 static int __init virt_platform_init(void)
@@ -35,8 +30,10 @@ static int __init virt_platform_init(void)
 		DEFINE_RES_MEM(virt_bi_data.rtc.mmio + 0x1000, 0x1000),
 		DEFINE_RES_IRQ(virt_bi_data.rtc.irq + 1),
 	};
-	struct platform_device *pdev;
+	struct platform_device *pdev1, *pdev2;
+	struct platform_device *pdevs[VIRTIO_BUS_NB];
 	unsigned int i;
+	int ret = 0;
 
 	if (!MACH_IS_VIRT)
 		return -ENODEV;
@@ -44,29 +41,40 @@ static int __init virt_platform_init(void)
 	/* We need this to have DMA'able memory provided to goldfish-tty */
 	min_low_pfn = 0;
 
-	pdev = platform_device_register_simple("goldfish_tty",
-					       PLATFORM_DEVID_NONE,
-					       goldfish_tty_res,
-					       ARRAY_SIZE(goldfish_tty_res));
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	pdev1 = platform_device_register_simple("goldfish_tty",
+						PLATFORM_DEVID_NONE,
+						goldfish_tty_res,
+						ARRAY_SIZE(goldfish_tty_res));
+	if (IS_ERR(pdev1))
+		return PTR_ERR(pdev1);
 
-	pdev = platform_device_register_simple("goldfish_rtc",
-					       PLATFORM_DEVID_NONE,
-					       goldfish_rtc_res,
-					       ARRAY_SIZE(goldfish_rtc_res));
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	pdev2 = platform_device_register_simple("goldfish_rtc",
+						PLATFORM_DEVID_NONE,
+						goldfish_rtc_res,
+						ARRAY_SIZE(goldfish_rtc_res));
+	if (IS_ERR(pdev2)) {
+		ret = PTR_ERR(pdev2);
+		goto err_unregister_tty;
+	}
 
 	for (i = 0; i < VIRTIO_BUS_NB; i++) {
-		int err;
-
-		err = virt_virtio_init(i);
-		if (err)
-			return err;
+		pdevs[i] = virt_virtio_init(i);
+		if (IS_ERR(pdevs[i])) {
+			ret = PTR_ERR(pdevs[i]);
+			goto err_unregister_rtc_virtio;
+		}
 	}
 
 	return 0;
+
+err_unregister_rtc_virtio:
+	while (i > 0)
+		platform_device_unregister(pdevs[--i]);
+	platform_device_unregister(pdev2);
+err_unregister_tty:
+	platform_device_unregister(pdev1);
+
+	return ret;
 }
 
 arch_initcall(virt_platform_init);
-- 
2.25.1

