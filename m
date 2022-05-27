Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297AE535EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349765AbiE0KwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiE0KwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:52:23 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF6255480
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:52:21 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L8hRV5VkYz1JCTk;
        Fri, 27 May 2022 18:50:46 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 18:52:19 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 18:52:19 +0800
From:   keliu <liuke94@huawei.com>
To:     <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>, <greybus-dev@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] drivers: greybus: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 11:13:48 +0000
Message-ID: <20220527111348.3444003-1-liuke94@huawei.com>
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
 drivers/greybus/es2.c       |  4 ++--
 drivers/greybus/hd.c        | 12 ++++++------
 drivers/greybus/interface.c |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
index e89cca015095..c861fb2acd8a 100644
--- a/drivers/greybus/es2.c
+++ b/drivers/greybus/es2.c
@@ -522,7 +522,7 @@ static int es2_cport_allocate(struct gb_host_device *hd, int cport_id,
 		return -EINVAL;
 	}
 
-	return ida_simple_get(id_map, ida_start, ida_end, GFP_KERNEL);
+	return ida_alloc_range(id_map, ida_start, ida_end - 1, GFP_KERNEL);
 }
 
 static void es2_cport_release(struct gb_host_device *hd, u16 cport_id)
@@ -535,7 +535,7 @@ static void es2_cport_release(struct gb_host_device *hd, u16 cport_id)
 		return;
 	}
 
-	ida_simple_remove(&hd->cport_id_map, cport_id);
+	ida_free(&hd->cport_id_map, cport_id);
 }
 
 static int cport_enable(struct gb_host_device *hd, u16 cport_id,
diff --git a/drivers/greybus/hd.c b/drivers/greybus/hd.c
index 72b21bf2d7d3..6ff5b0cfd539 100644
--- a/drivers/greybus/hd.c
+++ b/drivers/greybus/hd.c
@@ -50,7 +50,7 @@ int gb_hd_cport_reserve(struct gb_host_device *hd, u16 cport_id)
 	struct ida *id_map = &hd->cport_id_map;
 	int ret;
 
-	ret = ida_simple_get(id_map, cport_id, cport_id + 1, GFP_KERNEL);
+	ret = ida_alloc_range(id_map, cport_id, cport_id, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(&hd->dev, "failed to reserve cport %u\n", cport_id);
 		return ret;
@@ -64,7 +64,7 @@ void gb_hd_cport_release_reserved(struct gb_host_device *hd, u16 cport_id)
 {
 	struct ida *id_map = &hd->cport_id_map;
 
-	ida_simple_remove(id_map, cport_id);
+	ida_free(id_map, cport_id);
 }
 EXPORT_SYMBOL_GPL(gb_hd_cport_release_reserved);
 
@@ -89,7 +89,7 @@ int gb_hd_cport_allocate(struct gb_host_device *hd, int cport_id,
 		return -EINVAL;
 	}
 
-	return ida_simple_get(id_map, ida_start, ida_end, GFP_KERNEL);
+	return ida_alloc_range(id_map, ida_start, ida_end - 1, GFP_KERNEL);
 }
 
 /* Locking: Caller guarantees serialisation */
@@ -100,7 +100,7 @@ void gb_hd_cport_release(struct gb_host_device *hd, u16 cport_id)
 		return;
 	}
 
-	ida_simple_remove(&hd->cport_id_map, cport_id);
+	ida_free(&hd->cport_id_map, cport_id);
 }
 
 static void gb_hd_release(struct device *dev)
@@ -111,7 +111,7 @@ static void gb_hd_release(struct device *dev)
 
 	if (hd->svc)
 		gb_svc_put(hd->svc);
-	ida_simple_remove(&gb_hd_bus_id_map, hd->bus_id);
+	ida_free(&gb_hd_bus_id_map, hd->bus_id);
 	ida_destroy(&hd->cport_id_map);
 	kfree(hd);
 }
@@ -162,7 +162,7 @@ struct gb_host_device *gb_hd_create(struct gb_hd_driver *driver,
 	if (!hd)
 		return ERR_PTR(-ENOMEM);
 
-	ret = ida_simple_get(&gb_hd_bus_id_map, 1, 0, GFP_KERNEL);
+	ret = ida_alloc_min(&gb_hd_bus_id_map, 1, GFP_KERNEL);
 	if (ret < 0) {
 		kfree(hd);
 		return ERR_PTR(ret);
diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
index 9ec949a438ef..f685e5f7b7b1 100644
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -131,8 +131,8 @@ static int gb_interface_route_create(struct gb_interface *intf)
 	int ret;
 
 	/* Allocate an interface device id. */
-	ret = ida_simple_get(&svc->device_id_map,
-			     GB_SVC_DEVICE_ID_MIN, GB_SVC_DEVICE_ID_MAX + 1,
+	ret = ida_alloc_range(&svc->device_id_map,
+			     GB_SVC_DEVICE_ID_MIN, GB_SVC_DEVICE_ID_MAX,
 			     GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(&intf->dev, "failed to allocate device id: %d\n", ret);
@@ -165,7 +165,7 @@ static int gb_interface_route_create(struct gb_interface *intf)
 	 * XXX anymore.
 	 */
 err_ida_remove:
-	ida_simple_remove(&svc->device_id_map, device_id);
+	ida_free(&svc->device_id_map, device_id);
 
 	return ret;
 }
@@ -178,7 +178,7 @@ static void gb_interface_route_destroy(struct gb_interface *intf)
 		return;
 
 	gb_svc_route_destroy(svc, svc->ap_intf_id, intf->interface_id);
-	ida_simple_remove(&svc->device_id_map, intf->device_id);
+	ida_free(&svc->device_id_map, intf->device_id);
 	intf->device_id = GB_INTERFACE_DEVICE_ID_BAD;
 }
 
-- 
2.25.1

