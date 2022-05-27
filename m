Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61049535A00
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiE0HN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiE0HNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:13:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090B0B7ED;
        Fri, 27 May 2022 00:13:21 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L8bZm75p1zbc2f;
        Fri, 27 May 2022 15:11:44 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 15:13:18 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 15:13:17 +0800
From:   keliu <liuke94@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] thermal: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 07:34:45 +0000
Message-ID: <20220527073445.2474380-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
 drivers/thermal/thermal_core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 82654dc8382b..b36c348a110b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -667,7 +667,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	dev->target = THERMAL_NO_TARGET;
 	dev->weight = weight;
 
-	result = ida_simple_get(&tz->ida, 0, 0, GFP_KERNEL);
+	result = ida_alloc(&tz->ida, GFP_KERNEL);
 	if (result < 0)
 		goto free_mem;
 
@@ -721,7 +721,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 remove_symbol_link:
 	sysfs_remove_link(&tz->device.kobj, dev->name);
 release_ida:
-	ida_simple_remove(&tz->ida, dev->id);
+	ida_free(&tz->ida, dev->id);
 free_mem:
 	kfree(dev);
 	return result;
@@ -768,7 +768,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 	device_remove_file(&tz->device, &pos->weight_attr);
 	device_remove_file(&tz->device, &pos->attr);
 	sysfs_remove_link(&tz->device.kobj, pos->name);
-	ida_simple_remove(&tz->ida, pos->id);
+	ida_free(&tz->ida, pos->id);
 	kfree(pos);
 	return 0;
 }
@@ -901,7 +901,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
-	ret = ida_simple_get(&thermal_cdev_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&thermal_cdev_ida, GFP_KERNEL);
 	if (ret < 0)
 		goto out_kfree_cdev;
 	cdev->id = ret;
@@ -951,7 +951,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	put_device(&cdev->device);
 	cdev = NULL;
 out_ida_remove:
-	ida_simple_remove(&thermal_cdev_ida, id);
+	ida_free(&thermal_cdev_ida, id);
 out_kfree_cdev:
 	kfree(cdev);
 	return ERR_PTR(ret);
@@ -1110,7 +1110,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	mutex_unlock(&thermal_list_lock);
 
-	ida_simple_remove(&thermal_cdev_ida, cdev->id);
+	ida_free(&thermal_cdev_ida, cdev->id);
 	device_del(&cdev->device);
 	thermal_cooling_device_destroy_sysfs(cdev);
 	kfree(cdev->type);
@@ -1227,7 +1227,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	INIT_LIST_HEAD(&tz->thermal_instances);
 	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
-	id = ida_simple_get(&thermal_tz_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&thermal_tz_ida, GFP_KERNEL);
 	if (id < 0) {
 		result = id;
 		goto free_tz;
@@ -1318,7 +1318,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	put_device(&tz->device);
 	tz = NULL;
 remove_id:
-	ida_simple_remove(&thermal_tz_ida, id);
+	ida_free(&thermal_tz_ida, id);
 free_tz:
 	kfree(tz);
 	return ERR_PTR(result);
@@ -1378,7 +1378,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_set_governor(tz, NULL);
 
 	thermal_remove_hwmon_sysfs(tz);
-	ida_simple_remove(&thermal_tz_ida, tz->id);
+	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
-- 
2.25.1

