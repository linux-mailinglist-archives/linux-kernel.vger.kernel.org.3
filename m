Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276D453592D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244558AbiE0GOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiE0GOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:14:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8955D66C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:14:01 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L8ZGM0Gknz1JCD4;
        Fri, 27 May 2022 14:12:27 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:13:59 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:13:59 +0800
From:   keliu <liuke94@huawei.com>
To:     <vaibhav.sr@gmail.com>, <mgreer@animalcreek.com>,
        <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>, <vireshk@kernel.org>,
        <pure.logic@nexus-software.ie>, <greybus-dev@lists.linaro.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] staging: greybus: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 06:35:28 +0000
Message-ID: <20220527063528.2356712-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
 drivers/staging/greybus/audio_manager.c  |  8 ++++----
 drivers/staging/greybus/authentication.c |  4 ++--
 drivers/staging/greybus/fw-download.c    |  4 ++--
 drivers/staging/greybus/fw-management.c  | 12 ++++++------
 drivers/staging/greybus/gbphy.c          |  4 ++--
 drivers/staging/greybus/loopback.c       |  6 +++---
 drivers/staging/greybus/raw.c            |  6 +++---
 drivers/staging/greybus/vibrator.c       |  6 +++---
 8 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
index 9a3f7c034ab4..fa43d35bbcec 100644
--- a/drivers/staging/greybus/audio_manager.c
+++ b/drivers/staging/greybus/audio_manager.c
@@ -44,14 +44,14 @@ int gb_audio_manager_add(struct gb_audio_manager_module_descriptor *desc)
 	int id;
 	int err;
 
-	id = ida_simple_get(&module_id, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&module_id, GFP_KERNEL);
 	if (id < 0)
 		return id;
 
 	err = gb_audio_manager_module_create(&module, manager_kset,
 					     id, desc);
 	if (err) {
-		ida_simple_remove(&module_id, id);
+		ida_free(&module_id, id);
 		return err;
 	}
 
@@ -78,7 +78,7 @@ int gb_audio_manager_remove(int id)
 	list_del(&module->list);
 	kobject_put(&module->kobj);
 	up_write(&modules_rwsem);
-	ida_simple_remove(&module_id, id);
+	ida_free(&module_id, id);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gb_audio_manager_remove);
@@ -92,7 +92,7 @@ void gb_audio_manager_remove_all(void)
 
 	list_for_each_entry_safe(module, next, &modules_list, list) {
 		list_del(&module->list);
-		ida_simple_remove(&module_id, module->id);
+		ida_free(&module_id, module->id);
 		kobject_put(&module->kobj);
 	}
 
diff --git a/drivers/staging/greybus/authentication.c b/drivers/staging/greybus/authentication.c
index 297e69f011c7..01dd1cd958ea 100644
--- a/drivers/staging/greybus/authentication.c
+++ b/drivers/staging/greybus/authentication.c
@@ -348,7 +348,7 @@ int gb_cap_connection_init(struct gb_connection *connection)
 err_del_cdev:
 	cdev_del(&cap->cdev);
 err_remove_ida:
-	ida_simple_remove(&cap_minors_map, minor);
+	ida_free(&cap_minors_map, minor);
 err_connection_disable:
 	gb_connection_disable(connection);
 err_list_del:
@@ -372,7 +372,7 @@ void gb_cap_connection_exit(struct gb_connection *connection)
 
 	device_destroy(cap_class, cap->dev_num);
 	cdev_del(&cap->cdev);
-	ida_simple_remove(&cap_minors_map, MINOR(cap->dev_num));
+	ida_free(&cap_minors_map, MINOR(cap->dev_num));
 
 	/*
 	 * Disallow any new ioctl operations on the char device and wait for
diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
index 543692c567f9..83652cb04d53 100644
--- a/drivers/staging/greybus/fw-download.c
+++ b/drivers/staging/greybus/fw-download.c
@@ -63,7 +63,7 @@ static void fw_req_release(struct kref *kref)
 	 * just hope that it never happens.
 	 */
 	if (!fw_req->timedout)
-		ida_simple_remove(&fw_req->fw_download->id_map,
+		ida_free(&fw_req->fw_download->id_map,
 				  fw_req->firmware_id);
 
 	kfree(fw_req);
@@ -212,7 +212,7 @@ static struct fw_request *find_firmware(struct fw_download *fw_download,
 	return fw_req;
 
 err_free_id:
-	ida_simple_remove(&fw_download->id_map, fw_req->firmware_id);
+	ida_free(&fw_download->id_map, fw_req->firmware_id);
 err_free_req:
 	kfree(fw_req);
 
diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
index 687c6405c65b..a386a5607c7e 100644
--- a/drivers/staging/greybus/fw-management.c
+++ b/drivers/staging/greybus/fw-management.c
@@ -177,7 +177,7 @@ static int fw_mgmt_load_and_validate_operation(struct fw_mgmt *fw_mgmt,
 				GB_FW_MGMT_TYPE_LOAD_AND_VALIDATE_FW, &request,
 				sizeof(request), NULL, 0);
 	if (ret) {
-		ida_simple_remove(&fw_mgmt->id_map,
+		ida_free(&fw_mgmt->id_map,
 				  fw_mgmt->intf_fw_request_id);
 		fw_mgmt->intf_fw_request_id = 0;
 		dev_err(fw_mgmt->parent,
@@ -217,7 +217,7 @@ static int fw_mgmt_interface_fw_loaded_operation(struct gb_operation *op)
 		return -ENODEV;
 	}
 
-	ida_simple_remove(&fw_mgmt->id_map, fw_mgmt->intf_fw_request_id);
+	ida_free(&fw_mgmt->id_map, fw_mgmt->intf_fw_request_id);
 	fw_mgmt->intf_fw_request_id = 0;
 	fw_mgmt->intf_fw_status = request->status;
 	fw_mgmt->intf_fw_major = le16_to_cpu(request->major);
@@ -327,7 +327,7 @@ static int fw_mgmt_backend_fw_update_operation(struct fw_mgmt *fw_mgmt,
 				GB_FW_MGMT_TYPE_BACKEND_FW_UPDATE, &request,
 				sizeof(request), NULL, 0);
 	if (ret) {
-		ida_simple_remove(&fw_mgmt->id_map,
+		ida_free(&fw_mgmt->id_map,
 				  fw_mgmt->backend_fw_request_id);
 		fw_mgmt->backend_fw_request_id = 0;
 		dev_err(fw_mgmt->parent,
@@ -366,7 +366,7 @@ static int fw_mgmt_backend_fw_updated_operation(struct gb_operation *op)
 		return -ENODEV;
 	}
 
-	ida_simple_remove(&fw_mgmt->id_map, fw_mgmt->backend_fw_request_id);
+	ida_free(&fw_mgmt->id_map, fw_mgmt->backend_fw_request_id);
 	fw_mgmt->backend_fw_request_id = 0;
 	fw_mgmt->backend_fw_status = request->status;
 
@@ -642,7 +642,7 @@ int gb_fw_mgmt_connection_init(struct gb_connection *connection)
 err_del_cdev:
 	cdev_del(&fw_mgmt->cdev);
 err_remove_ida:
-	ida_simple_remove(&fw_mgmt_minors_map, minor);
+	ida_free(&fw_mgmt_minors_map, minor);
 err_connection_disable:
 	gb_connection_disable(connection);
 err_list_del:
@@ -666,7 +666,7 @@ void gb_fw_mgmt_connection_exit(struct gb_connection *connection)
 
 	device_destroy(fw_mgmt_class, fw_mgmt->dev_num);
 	cdev_del(&fw_mgmt->cdev);
-	ida_simple_remove(&fw_mgmt_minors_map, MINOR(fw_mgmt->dev_num));
+	ida_free(&fw_mgmt_minors_map, MINOR(fw_mgmt->dev_num));
 
 	/*
 	 * Disallow any new ioctl operations on the char device and wait for
diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
index 5a5c17a4519b..751d1d580982 100644
--- a/drivers/staging/greybus/gbphy.c
+++ b/drivers/staging/greybus/gbphy.c
@@ -46,7 +46,7 @@ static void gbphy_dev_release(struct device *dev)
 {
 	struct gbphy_device *gbphy_dev = to_gbphy_dev(dev);
 
-	ida_simple_remove(&gbphy_id, gbphy_dev->id);
+	ida_free(&gbphy_id, gbphy_dev->id);
 	kfree(gbphy_dev);
 }
 
@@ -231,7 +231,7 @@ static struct gbphy_device *gb_gbphy_create_dev(struct gb_bundle *bundle,
 
 	gbphy_dev = kzalloc(sizeof(*gbphy_dev), GFP_KERNEL);
 	if (!gbphy_dev) {
-		ida_simple_remove(&gbphy_id, id);
+		ida_free(&gbphy_id, id);
 		return ERR_PTR(-ENOMEM);
 	}
 
diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 2471448ba42a..fca69aff9abf 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -1029,7 +1029,7 @@ static int gb_loopback_probe(struct gb_bundle *bundle,
 	gb->file = debugfs_create_file(name, S_IFREG | 0444, gb_dev.root, gb,
 				       &gb_loopback_dbgfs_latency_fops);
 
-	gb->id = ida_simple_get(&loopback_ida, 0, 0, GFP_KERNEL);
+	gb->id = ida_alloc(&loopback_ida, GFP_KERNEL);
 	if (gb->id < 0) {
 		retval = gb->id;
 		goto out_debugfs_remove;
@@ -1080,7 +1080,7 @@ static int gb_loopback_probe(struct gb_bundle *bundle,
 out_connection_disable:
 	gb_connection_disable(connection);
 out_ida_remove:
-	ida_simple_remove(&loopback_ida, gb->id);
+	ida_free(&loopback_ida, gb->id);
 out_debugfs_remove:
 	debugfs_remove(gb->file);
 out_connection_destroy:
@@ -1122,7 +1122,7 @@ static void gb_loopback_disconnect(struct gb_bundle *bundle)
 	spin_unlock_irqrestore(&gb_dev.lock, flags);
 
 	device_unregister(gb->dev);
-	ida_simple_remove(&loopback_ida, gb->id);
+	ida_free(&loopback_ida, gb->id);
 
 	gb_connection_destroy(gb->connection);
 	kfree(gb);
diff --git a/drivers/staging/greybus/raw.c b/drivers/staging/greybus/raw.c
index 2a375f407d38..cfaa7ab42ffc 100644
--- a/drivers/staging/greybus/raw.c
+++ b/drivers/staging/greybus/raw.c
@@ -178,7 +178,7 @@ static int gb_raw_probe(struct gb_bundle *bundle,
 	raw->connection = connection;
 	greybus_set_drvdata(bundle, raw);
 
-	minor = ida_simple_get(&minors, 0, 0, GFP_KERNEL);
+	minor = ida_alloc(&minors, GFP_KERNEL);
 	if (minor < 0) {
 		retval = minor;
 		goto error_connection_destroy;
@@ -211,7 +211,7 @@ static int gb_raw_probe(struct gb_bundle *bundle,
 	gb_connection_disable(connection);
 
 error_remove_ida:
-	ida_simple_remove(&minors, minor);
+	ida_free(&minors, minor);
 
 error_connection_destroy:
 	gb_connection_destroy(connection);
@@ -232,7 +232,7 @@ static void gb_raw_disconnect(struct gb_bundle *bundle)
 	device_destroy(raw_class, raw->dev);
 	cdev_del(&raw->cdev);
 	gb_connection_disable(connection);
-	ida_simple_remove(&minors, MINOR(raw->dev));
+	ida_free(&minors, MINOR(raw->dev));
 	gb_connection_destroy(connection);
 
 	mutex_lock(&raw->list_lock);
diff --git a/drivers/staging/greybus/vibrator.c b/drivers/staging/greybus/vibrator.c
index 0e2b188e5ca3..ccc409280fb5 100644
--- a/drivers/staging/greybus/vibrator.c
+++ b/drivers/staging/greybus/vibrator.c
@@ -154,7 +154,7 @@ static int gb_vibrator_probe(struct gb_bundle *bundle,
 	 * there is a "real" device somewhere in the kernel for this, but I
 	 * can't find it at the moment...
 	 */
-	vib->minor = ida_simple_get(&minors, 0, 0, GFP_KERNEL);
+	vib->minor = ida_alloc(&minors, GFP_KERNEL);
 	if (vib->minor < 0) {
 		retval = vib->minor;
 		goto err_connection_disable;
@@ -174,7 +174,7 @@ static int gb_vibrator_probe(struct gb_bundle *bundle,
 	return 0;
 
 err_ida_remove:
-	ida_simple_remove(&minors, vib->minor);
+	ida_free(&minors, vib->minor);
 err_connection_disable:
 	gb_connection_disable(connection);
 err_connection_destroy:
@@ -198,7 +198,7 @@ static void gb_vibrator_disconnect(struct gb_bundle *bundle)
 		turn_off(vib);
 
 	device_unregister(vib->dev);
-	ida_simple_remove(&minors, vib->minor);
+	ida_free(&minors, vib->minor);
 	gb_connection_disable(vib->connection);
 	gb_connection_destroy(vib->connection);
 	kfree(vib);
-- 
2.25.1

