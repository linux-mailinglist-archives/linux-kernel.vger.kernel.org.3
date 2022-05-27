Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF65535B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345259AbiE0ILo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiE0ILn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:11:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0961CFD34E
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:11:42 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L8ct70rR3zbbhg;
        Fri, 27 May 2022 16:10:07 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:11:40 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:11:40 +0800
From:   keliu <liuke94@huawei.com>
To:     <rdunlap@infradead.org>, <gregkh@linuxfoundation.org>,
        <christian.gromm@microchip.com>, <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] most: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 08:33:09 +0000
Message-ID: <20220527083309.2553087-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/most/core.c      | 10 +++++-----
 drivers/most/most_cdev.c |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/most/core.c b/drivers/most/core.c
index e4412c7d25b0..81d60d4ee8c2 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -1286,7 +1286,7 @@ int most_register_interface(struct most_interface *iface)
 	    !iface->poison_channel || (iface->num_channels > MAX_CHANNELS))
 		return -EINVAL;
 
-	id = ida_simple_get(&mdev_id, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&mdev_id, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(iface->dev, "Failed to allocate device ID\n");
 		return id;
@@ -1294,7 +1294,7 @@ int most_register_interface(struct most_interface *iface)
 
 	iface->p = kzalloc(sizeof(*iface->p), GFP_KERNEL);
 	if (!iface->p) {
-		ida_simple_remove(&mdev_id, id);
+		ida_free(&mdev_id, id);
 		return -ENOMEM;
 	}
 
@@ -1308,7 +1308,7 @@ int most_register_interface(struct most_interface *iface)
 		dev_err(iface->dev, "Failed to register interface device\n");
 		kfree(iface->p);
 		put_device(iface->dev);
-		ida_simple_remove(&mdev_id, id);
+		ida_free(&mdev_id, id);
 		return -ENOMEM;
 	}
 
@@ -1366,7 +1366,7 @@ int most_register_interface(struct most_interface *iface)
 	}
 	kfree(iface->p);
 	device_unregister(iface->dev);
-	ida_simple_remove(&mdev_id, id);
+	ida_free(&mdev_id, id);
 	return -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(most_register_interface);
@@ -1397,7 +1397,7 @@ void most_deregister_interface(struct most_interface *iface)
 		device_unregister(&c->dev);
 	}
 
-	ida_simple_remove(&mdev_id, iface->p->dev_id);
+	ida_free(&mdev_id, iface->p->dev_id);
 	kfree(iface->p);
 	device_unregister(iface->dev);
 }
diff --git a/drivers/most/most_cdev.c b/drivers/most/most_cdev.c
index 3722f9abd7b9..27913b1c8128 100644
--- a/drivers/most/most_cdev.c
+++ b/drivers/most/most_cdev.c
@@ -100,7 +100,7 @@ static void destroy_cdev(struct comp_channel *c)
 
 static void destroy_channel(struct comp_channel *c)
 {
-	ida_simple_remove(&comp.minor_id, MINOR(c->devno));
+	ida_free(&comp.minor_id, MINOR(c->devno));
 	kfifo_free(&c->fifo);
 	kfree(c);
 }
@@ -424,7 +424,7 @@ static int comp_probe(struct most_interface *iface, int channel_id,
 	if (c)
 		return -EEXIST;
 
-	current_minor = ida_simple_get(&comp.minor_id, 0, 0, GFP_KERNEL);
+	current_minor = ida_alloc(&comp.minor_id, GFP_KERNEL);
 	if (current_minor < 0)
 		return current_minor;
 
@@ -471,7 +471,7 @@ static int comp_probe(struct most_interface *iface, int channel_id,
 err_free_c:
 	kfree(c);
 err_remove_ida:
-	ida_simple_remove(&comp.minor_id, current_minor);
+	ida_free(&comp.minor_id, current_minor);
 	return retval;
 }
 
-- 
2.25.1

