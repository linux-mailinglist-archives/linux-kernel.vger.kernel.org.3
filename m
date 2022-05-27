Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0924C535DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiE0KI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350833AbiE0KIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:08:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3DC1271B6;
        Fri, 27 May 2022 03:08:51 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L8gTJ13c2zgYFH;
        Fri, 27 May 2022 18:07:16 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 18:08:49 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 18:08:49 +0800
From:   keliu <liuke94@huawei.com>
To:     <sean@mess.org>, <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] media: rc: Directly use ida_free()
Date:   Fri, 27 May 2022 10:30:17 +0000
Message-ID: <20220527103017.3374446-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 drivers/media/rc/lirc_dev.c | 6 +++---
 drivers/media/rc/rc-main.c  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index 765375bda0c6..6cc8c14cf855 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -715,7 +715,7 @@ int lirc_register(struct rc_dev *dev)
 	const char *rx_type, *tx_type;
 	int err, minor;
 
-	minor = ida_simple_get(&lirc_ida, 0, RC_DEV_MAX, GFP_KERNEL);
+	minor = ida_alloc_max(&lirc_ida, RC_DEV_MAX-1, GFP_KERNEL);
 	if (minor < 0)
 		return minor;
 
@@ -760,7 +760,7 @@ int lirc_register(struct rc_dev *dev)
 	return 0;
 
 out_ida:
-	ida_simple_remove(&lirc_ida, minor);
+	ida_free(&lirc_ida, minor);
 	return err;
 }
 
@@ -778,7 +778,7 @@ void lirc_unregister(struct rc_dev *dev)
 	spin_unlock_irqrestore(&dev->lirc_fh_lock, flags);
 
 	cdev_device_del(&dev->lirc_cdev, &dev->lirc_dev);
-	ida_simple_remove(&lirc_ida, MINOR(dev->lirc_dev.devt));
+	ida_free(&lirc_ida, MINOR(dev->lirc_dev.devt));
 }
 
 int __init lirc_dev_init(void)
diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index b90438a71c80..aff7c8da1e2f 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1897,7 +1897,7 @@ int rc_register_device(struct rc_dev *dev)
 	if (!dev)
 		return -EINVAL;
 
-	minor = ida_simple_get(&rc_ida, 0, RC_DEV_MAX, GFP_KERNEL);
+	minor = ida_alloc_max(&rc_ida, RC_DEV_MAX-1, GFP_KERNEL);
 	if (minor < 0)
 		return minor;
 
@@ -1980,7 +1980,7 @@ int rc_register_device(struct rc_dev *dev)
 out_raw:
 	ir_raw_event_free(dev);
 out_minor:
-	ida_simple_remove(&rc_ida, minor);
+	ida_free(&rc_ida, minor);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(rc_register_device);
@@ -2040,7 +2040,7 @@ void rc_unregister_device(struct rc_dev *dev)
 
 	device_del(&dev->dev);
 
-	ida_simple_remove(&rc_ida, dev->minor);
+	ida_free(&rc_ida, dev->minor);
 
 	if (!dev->managed_alloc)
 		rc_free_device(dev);
-- 
2.25.1

