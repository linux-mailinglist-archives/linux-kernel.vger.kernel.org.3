Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D04535C58
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344297AbiE0JEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350539AbiE0JAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:00:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3E9F06;
        Fri, 27 May 2022 01:56:12 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L8dsT26d5zbbs5;
        Fri, 27 May 2022 16:54:37 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:56:10 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:56:10 +0800
From:   keliu <liuke94@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] iio:  Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 09:17:39 +0000
Message-ID: <20220527091739.2949426-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 drivers/iio/industrialio-core.c    | 6 +++---
 drivers/iio/industrialio-trigger.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e1ed44dec2ab..41daa10cd63d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1618,7 +1618,7 @@ static void iio_dev_release(struct device *device)
 
 	iio_device_detach_buffers(indio_dev);
 
-	ida_simple_remove(&iio_ida, iio_dev_opaque->id);
+	ida_free(&iio_ida, iio_dev_opaque->id);
 	kfree(iio_dev_opaque);
 }
 
@@ -1660,7 +1660,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	mutex_init(&iio_dev_opaque->info_exist_lock);
 	INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
 
-	iio_dev_opaque->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
+	iio_dev_opaque->id = ida_alloc(&iio_ida, GFP_KERNEL);
 	if (iio_dev_opaque->id < 0) {
 		/* cannot use a dev_err as the name isn't available */
 		pr_err("failed to get device id\n");
@@ -1669,7 +1669,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	}
 
 	if (dev_set_name(&indio_dev->dev, "iio:device%d", iio_dev_opaque->id)) {
-		ida_simple_remove(&iio_ida, iio_dev_opaque->id);
+		ida_free(&iio_ida, iio_dev_opaque->id);
 		kfree(iio_dev_opaque);
 		return NULL;
 	}
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f504ed351b3e..6eb9b721676e 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -71,7 +71,7 @@ int __iio_trigger_register(struct iio_trigger *trig_info,
 
 	trig_info->owner = this_mod;
 
-	trig_info->id = ida_simple_get(&iio_trigger_ida, 0, 0, GFP_KERNEL);
+	trig_info->id = ida_alloc(&iio_trigger_ida, GFP_KERNEL);
 	if (trig_info->id < 0)
 		return trig_info->id;
 
@@ -98,7 +98,7 @@ int __iio_trigger_register(struct iio_trigger *trig_info,
 	mutex_unlock(&iio_trigger_list_lock);
 	device_del(&trig_info->dev);
 error_unregister_id:
-	ida_simple_remove(&iio_trigger_ida, trig_info->id);
+	ida_free(&iio_trigger_ida, trig_info->id);
 	return ret;
 }
 EXPORT_SYMBOL(__iio_trigger_register);
@@ -109,7 +109,7 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
 	list_del(&trig_info->list);
 	mutex_unlock(&iio_trigger_list_lock);
 
-	ida_simple_remove(&iio_trigger_ida, trig_info->id);
+	ida_free(&iio_trigger_ida, trig_info->id);
 	/* Possible issue in here */
 	device_del(&trig_info->dev);
 }
-- 
2.25.1

