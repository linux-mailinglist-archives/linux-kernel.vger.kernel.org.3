Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE8A512155
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiD0Spa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiD0SpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26ECFF6EBC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651083940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Azb2TbvWQfmEAnpys5BwuBTX0B6MFXRWq3B5YYe0k7A=;
        b=ScVZPm7x0XjbveZdxnJ/PxklX8A6qxPS0R8zGObLZYr0MMneatrYHZT29iqYgJrKEBpvrd
        PpRAWO5hWe/1z2g2ty9fXqee4nutZLQ01aX+qrkF+fCzhR8bs+HQ73gHpozHRiowG/W/tt
        WsMwW9fL+EVBjHFmjGZWUoptNftNNmI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-4WXgLbCNO4O4qiTaWKWJ4g-1; Wed, 27 Apr 2022 14:25:31 -0400
X-MC-Unique: 4WXgLbCNO4O4qiTaWKWJ4g-1
Received: by mail-qt1-f197.google.com with SMTP id j9-20020ac85c49000000b002f37e06e8ffso1695003qtj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Azb2TbvWQfmEAnpys5BwuBTX0B6MFXRWq3B5YYe0k7A=;
        b=RM/UfQzvkqKOlP0jQr4Jd5ln+Z1NaOgI7YuvyuMq5TvKK7KG/9B+xMlp0Q95vlHP10
         vxrq3V1qyuxZjdH89ewtQfapHrIulCnSSIyfbztow8q+VNhh+XyloW2PiSGH5RLUA1FC
         J391+be6TjFUL0IIiS9KfWfH3yy14N37HZGheDUyU7y2UGiTP2SWcwpfj4RGMPUWD9on
         KDAtEa3f27qQisNpF+/y6G8fm0vYmhMXXz7kVQtTAV+OGPt0XsTwHa1K7YFlqVAICNuh
         yBqn5bqrzsM0BmrZlxLlXrjCaM0KHjlONlXqLj8b+O1wxB3zeIbBkPE4po3zNnsRaIxA
         vjRA==
X-Gm-Message-State: AOAM533be805DotGWOzzrzZdOYcAJjAXUb5q0HkCP8qESQV21ajlsk5h
        NxkUqf5hyEomIOvlX/4cO0TuF04XQsULkLLJnP2vceeZjsJOeEPXdjotqUUhRqyDuse39UvAxw7
        yTT+posqcaiKF5fe3O/Xn2Rjn
X-Received: by 2002:ac8:7e83:0:b0:2f1:ffd5:3925 with SMTP id w3-20020ac87e83000000b002f1ffd53925mr20056336qtj.292.1651083930036;
        Wed, 27 Apr 2022 11:25:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+IDGY+i1jOv0Pc3j4PVJtyg3nmzPeTBWtCpd9SWD7ZLjXSFUxZkvnXX/DRmn1w1A4y2IsqQ==
X-Received: by 2002:ac8:7e83:0:b0:2f1:ffd5:3925 with SMTP id w3-20020ac87e83000000b002f1ffd53925mr20056303qtj.292.1651083929285;
        Wed, 27 Apr 2022 11:25:29 -0700 (PDT)
Received: from fedora.hitronhub.home (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a040b00b0069f95b27869sm792220qkp.125.2022.04.27.11.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:25:28 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Adrien Thierry <athierry@redhat.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vchiq_arm: use standard print helpers
Date:   Wed, 27 Apr 2022 14:24:37 -0400
Message-Id: <20220427182439.424963-1-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the custom debug print macros with the standard dev_err() and
friends.

This handles TODO item "Cleanup logging mechanism".

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 158 +++---
 .../interface/vchiq_arm/vchiq_connected.c     |   7 +-
 .../interface/vchiq_arm/vchiq_connected.h     |   4 +-
 .../interface/vchiq_arm/vchiq_core.c          | 495 ++++++++----------
 .../interface/vchiq_arm/vchiq_core.h          |  43 +-
 .../interface/vchiq_arm/vchiq_debugfs.c       | 105 ----
 .../interface/vchiq_arm/vchiq_dev.c           |  88 ++--
 7 files changed, 344 insertions(+), 556 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 0596ac61e286..664940e6d9e9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -58,10 +58,6 @@
 #define KEEPALIVE_VER 1
 #define KEEPALIVE_VER_MIN KEEPALIVE_VER
 
-/* Run time control of log level, based on KERN_XXX level. */
-int vchiq_arm_log_level = VCHIQ_LOG_DEFAULT;
-int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
-
 DEFINE_SPINLOCK(msg_queue_spinlock);
 struct vchiq_state g_state;
 
@@ -253,7 +249,7 @@ create_pagelist(char *buf, char __user *ubuf,
 	pagelist = dma_alloc_coherent(g_dev, pagelist_size, &dma_addr,
 				      GFP_KERNEL);
 
-	vchiq_log_trace(vchiq_arm_log_level, "%s - %pK", __func__, pagelist);
+	dev_dbg(g_dev, "%s - %pK", __func__, pagelist);
 
 	if (!pagelist)
 		return NULL;
@@ -308,9 +304,7 @@ create_pagelist(char *buf, char __user *ubuf,
 						   type == PAGELIST_READ, pages);
 
 		if (actual_pages != num_pages) {
-			vchiq_log_info(vchiq_arm_log_level,
-				       "%s - only %d/%d pages locked",
-				       __func__, actual_pages, num_pages);
+			dev_info(g_dev, "only %d/%d pages locked", actual_pages, num_pages);
 
 			/* This is probably due to the process being killed */
 			if (actual_pages > 0)
@@ -404,8 +398,8 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
 	struct page **pages = pagelistinfo->pages;
 	unsigned int num_pages = pagelistinfo->num_pages;
 
-	vchiq_log_trace(vchiq_arm_log_level, "%s - %pK, %d",
-			__func__, pagelistinfo->pagelist, actual);
+	dev_dbg(g_dev, "%s - %pK, %d",
+		__func__, pagelistinfo->pagelist, actual);
 
 	/*
 	 * NOTE: dma_unmap_sg must be called before the
@@ -519,7 +513,7 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 	*(char **)&g_fragments_base[i * g_fragments_size] = NULL;
 	sema_init(&g_free_fragments_sema, MAX_FRAGMENTS);
 
-	err = vchiq_init_state(state, vchiq_slot_zero);
+	err = vchiq_init_state(state, vchiq_slot_zero, dev);
 	if (err)
 		return err;
 
@@ -548,8 +542,8 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 	}
 
 	g_dev = dev;
-	vchiq_log_info(vchiq_arm_log_level, "vchiq_init - done (slots %pK, phys %pad)",
-		       vchiq_slot_zero, &slot_phys);
+	dev_info(dev, "vchiq_init - done (slots %pK, phys %pad)",
+		 vchiq_slot_zero, &slot_phys);
 
 	vchiq_call_connected_callbacks();
 
@@ -675,18 +669,16 @@ int vchiq_initialise(struct vchiq_instance **instance_out)
 		usleep_range(500, 600);
 	}
 	if (i == VCHIQ_INIT_RETRIES) {
-		vchiq_log_error(vchiq_core_log_level, "%s: videocore not initialized\n", __func__);
+		dev_err(g_dev, "videocore not initialized\n");
 		ret = -ENOTCONN;
 		goto failed;
 	} else if (i > 0) {
-		vchiq_log_warning(vchiq_core_log_level,
-				  "%s: videocore initialized after %d retries\n", __func__, i);
+		dev_warn(g_dev, "videocore initialized after %d retries\n", i);
 	}
 
 	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
 	if (!instance) {
-		vchiq_log_error(vchiq_core_log_level,
-				"%s: error allocating vchiq instance\n", __func__);
+		dev_err(g_dev, "error allocating vchiq instance\n");
 		ret = -ENOMEM;
 		goto failed;
 	}
@@ -701,7 +693,7 @@ int vchiq_initialise(struct vchiq_instance **instance_out)
 	ret = 0;
 
 failed:
-	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, ret);
+	dev_dbg(g_dev, "%s(%p): returning %d", __func__, instance, ret);
 
 	return ret;
 }
@@ -714,8 +706,8 @@ void free_bulk_waiter(struct vchiq_instance *instance)
 	list_for_each_entry_safe(waiter, next,
 				 &instance->bulk_waiter_list, list) {
 		list_del(&waiter->list);
-		vchiq_log_info(vchiq_arm_log_level, "bulk_waiter - cleaned up %pK for pid %d",
-			       waiter, waiter->pid);
+		dev_info(instance->state->dev, "bulk_waiter - cleaned up %pK for pid %d",
+			 waiter, waiter->pid);
 		kfree(waiter);
 	}
 }
@@ -733,7 +725,7 @@ enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance)
 
 	mutex_unlock(&state->mutex);
 
-	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
+	dev_dbg(state->dev, "%s(%p): returning %d", __func__, instance, status);
 
 	free_bulk_waiter(instance);
 	kfree(instance);
@@ -753,7 +745,7 @@ enum vchiq_status vchiq_connect(struct vchiq_instance *instance)
 	struct vchiq_state *state = instance->state;
 
 	if (mutex_lock_killable(&state->mutex)) {
-		vchiq_log_trace(vchiq_core_log_level, "%s: call to mutex_lock failed", __func__);
+		dev_dbg(state->dev, "%s: call to mutex_lock failed", __func__);
 		status = VCHIQ_RETRY;
 		goto failed;
 	}
@@ -765,7 +757,7 @@ enum vchiq_status vchiq_connect(struct vchiq_instance *instance)
 	mutex_unlock(&state->mutex);
 
 failed:
-	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
+	dev_dbg(state->dev, "%s(%p): returning %d", __func__, instance, status);
 
 	return status;
 }
@@ -796,7 +788,7 @@ vchiq_add_service(struct vchiq_instance *instance,
 		status = VCHIQ_ERROR;
 	}
 
-	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
+	dev_dbg(state->dev, "%s(%p): returning %d", __func__, instance, status);
 
 	return status;
 }
@@ -827,7 +819,7 @@ vchiq_open_service(struct vchiq_instance *instance,
 	}
 
 failed:
-	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
+	dev_dbg(state->dev, "%s(%p): returning %d", __func__, instance, status);
 
 	return status;
 }
@@ -954,7 +946,7 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
 	} else {
 		waiter = kzalloc(sizeof(*waiter), GFP_KERNEL);
 		if (!waiter) {
-			vchiq_log_error(vchiq_core_log_level, "%s - out of memory", __func__);
+			dev_err(instance->state->dev, "out of memory");
 			return VCHIQ_ERROR;
 		}
 	}
@@ -977,8 +969,8 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
 		mutex_lock(&instance->bulk_waiter_list_mutex);
 		list_add(&waiter->list, &instance->bulk_waiter_list);
 		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		vchiq_log_info(vchiq_arm_log_level, "saved bulk_waiter %pK for pid %d", waiter,
-			       current->pid);
+		dev_info(instance->state->dev, "saved bulk_waiter %pK for pid %d", waiter,
+			 current->pid);
 	}
 
 	return status;
@@ -990,6 +982,7 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	       void *bulk_userdata)
 {
 	struct vchiq_completion_data_kernel *completion;
+	struct device *dev = instance->state->dev;
 	int insert;
 
 	DEBUG_INITIALISE(g_state.local);
@@ -998,13 +991,13 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	while ((insert - instance->completion_remove) >= MAX_COMPLETIONS) {
 		/* Out of space - wait for the client */
 		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
-		vchiq_log_trace(vchiq_arm_log_level, "%s - completion queue full", __func__);
+		dev_dbg(dev, "%s - completion queue full", __func__);
 		DEBUG_COUNT(COMPLETION_QUEUE_FULL_COUNT);
 		if (wait_for_completion_interruptible(&instance->remove_event)) {
-			vchiq_log_info(vchiq_arm_log_level, "service_callback interrupted");
+			dev_info(dev, "service_callback interrupted");
 			return VCHIQ_RETRY;
 		} else if (instance->closing) {
-			vchiq_log_info(vchiq_arm_log_level, "service_callback closing");
+			dev_info(dev, "service_callback closing");
 			return VCHIQ_SUCCESS;
 		}
 		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
@@ -1059,6 +1052,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 	struct vchiq_service *service;
 	struct vchiq_instance *instance;
 	bool skip_completion = false;
+	struct device *dev;
 
 	DEBUG_INITIALISE(g_state.local);
 
@@ -1086,11 +1080,12 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 	vchiq_service_get(service);
 	rcu_read_unlock();
 
-	vchiq_log_trace(vchiq_arm_log_level,
-			"%s - service %lx(%d,%p), reason %d, header %lx, instance %lx, bulk_userdata %lx",
-			__func__, (unsigned long)user_service, service->localport,
-			user_service->userdata, reason, (unsigned long)header,
-			(unsigned long)instance, (unsigned long)bulk_userdata);
+	dev = instance->state->dev;
+
+	dev_dbg(dev, "%s - service %lx(%d,%p), reason %d, header %lx, instance %lx, bulk_userdata %lx",
+		__func__, (unsigned long)user_service, service->localport,
+		user_service->userdata, reason, (unsigned long)header,
+		(unsigned long)instance, (unsigned long)bulk_userdata);
 
 	if (header && user_service->is_vchi) {
 		spin_lock(&msg_queue_spinlock);
@@ -1099,7 +1094,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 			spin_unlock(&msg_queue_spinlock);
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 			DEBUG_COUNT(MSG_QUEUE_FULL_COUNT);
-			vchiq_log_trace(vchiq_arm_log_level, "%s - msg queue full", __func__);
+			dev_dbg(dev, "%s - msg queue full", __func__);
 			/*
 			 * If there is no MESSAGE_AVAILABLE in the completion
 			 * queue, add one
@@ -1108,8 +1103,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 				instance->completion_remove) < 0) {
 				enum vchiq_status status;
 
-				vchiq_log_info(vchiq_arm_log_level,
-					       "Inserting extra MESSAGE_AVAILABLE");
+				dev_info(dev, "Inserting extra MESSAGE_AVAILABLE");
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				status = add_completion(instance, reason, NULL, user_service,
 							bulk_userdata);
@@ -1122,12 +1116,12 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 			if (wait_for_completion_interruptible(&user_service->remove_event)) {
-				vchiq_log_info(vchiq_arm_log_level, "%s interrupted", __func__);
+				dev_info(dev, "%s interrupted", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				vchiq_service_put(service);
 				return VCHIQ_RETRY;
 			} else if (instance->closing) {
-				vchiq_log_info(vchiq_arm_log_level, "%s closing", __func__);
+				dev_info(dev, "%s closing", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				vchiq_service_put(service);
 				return VCHIQ_ERROR;
@@ -1322,7 +1316,7 @@ vchiq_keepalive_vchiq_callback(enum vchiq_reason reason,
 			       struct vchiq_header *header,
 			       unsigned int service_user, void *bulk_user)
 {
-	vchiq_log_error(vchiq_susp_log_level, "%s callback reason %d", __func__, reason);
+	dev_err(g_dev, "callback reason %d", reason);
 	return 0;
 }
 
@@ -1332,6 +1326,8 @@ vchiq_keepalive_thread_func(void *v)
 	struct vchiq_state *state = (struct vchiq_state *)v;
 	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
 
+	struct device *dev = state->dev;
+
 	enum vchiq_status status;
 	struct vchiq_instance *instance;
 	unsigned int ka_handle;
@@ -1346,22 +1342,19 @@ vchiq_keepalive_thread_func(void *v)
 
 	ret = vchiq_initialise(&instance);
 	if (ret) {
-		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_initialise failed %d", __func__,
-				ret);
+		dev_err(dev, "vchiq_initialise failed %d", ret);
 		goto exit;
 	}
 
 	status = vchiq_connect(instance);
 	if (status != VCHIQ_SUCCESS) {
-		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_connect failed %d", __func__,
-				status);
+		dev_err(dev, "vchiq_connect failed %d", status);
 		goto shutdown;
 	}
 
 	status = vchiq_add_service(instance, &params, &ka_handle);
 	if (status != VCHIQ_SUCCESS) {
-		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_open_service failed %d", __func__,
-				status);
+		dev_err(dev, "vchiq_open_service failed %d", status);
 		goto shutdown;
 	}
 
@@ -1369,7 +1362,7 @@ vchiq_keepalive_thread_func(void *v)
 		long rc = 0, uc = 0;
 
 		if (wait_for_completion_interruptible(&arm_state->ka_evt)) {
-			vchiq_log_error(vchiq_susp_log_level, "%s interrupted", __func__);
+			dev_err(dev, "interrupted");
 			flush_signals(current);
 			continue;
 		}
@@ -1389,16 +1382,13 @@ vchiq_keepalive_thread_func(void *v)
 			atomic_inc(&arm_state->ka_use_ack_count);
 			status = vchiq_use_service(ka_handle);
 			if (status != VCHIQ_SUCCESS) {
-				vchiq_log_error(vchiq_susp_log_level,
-						"%s vchiq_use_service error %d", __func__, status);
+				dev_err(dev, "vchiq_use_service error %d", status);
 			}
 		}
 		while (rc--) {
 			status = vchiq_release_service(ka_handle);
 			if (status != VCHIQ_SUCCESS) {
-				vchiq_log_error(vchiq_susp_log_level,
-						"%s vchiq_release_service error %d", __func__,
-						status);
+				dev_err(dev, "vchiq_release_service error %d", status);
 			}
 		}
 	}
@@ -1433,7 +1423,7 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 			service->client_id);
 		entity_uc = &service->service_use_count;
 	} else {
-		vchiq_log_error(vchiq_susp_log_level, "%s null service ptr", __func__);
+		dev_err(state->dev, "null service ptr");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1442,8 +1432,8 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 	local_uc = ++arm_state->videocore_use_count;
 	++(*entity_uc);
 
-	vchiq_log_trace(vchiq_susp_log_level, "%s %s count %d, state count %d", __func__, entity,
-			*entity_uc, local_uc);
+	dev_dbg(state->dev, "%s %s count %d, state count %d", __func__, entity,
+		*entity_uc, local_uc);
 
 	write_unlock_bh(&arm_state->susp_res_lock);
 
@@ -1462,7 +1452,7 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 	}
 
 out:
-	vchiq_log_trace(vchiq_susp_log_level, "%s exit %d", __func__, ret);
+	dev_dbg(state->dev, "%s exit %d", __func__, ret);
 	return ret;
 }
 
@@ -1500,14 +1490,14 @@ vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
 	--arm_state->videocore_use_count;
 	--(*entity_uc);
 
-	vchiq_log_trace(vchiq_susp_log_level, "%s %s count %d, state count %d", __func__, entity,
-			*entity_uc, arm_state->videocore_use_count);
+	dev_dbg(state->dev, "%s %s count %d, state count %d", __func__, entity,
+		*entity_uc, arm_state->videocore_use_count);
 
 unlock:
 	write_unlock_bh(&arm_state->susp_res_lock);
 
 out:
-	vchiq_log_trace(vchiq_susp_log_level, "%s exit %d", __func__, ret);
+	dev_dbg(state->dev, "%s exit %d", __func__, ret);
 	return ret;
 }
 
@@ -1681,18 +1671,17 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 	read_unlock_bh(&arm_state->susp_res_lock);
 
 	if (only_nonzero)
-		vchiq_log_warning(vchiq_susp_log_level, "Too many active services (%d). Only dumping up to first %d services with non-zero use-count",
-				  active_services, found);
+		dev_warn(state->dev, "Too many active services (%d). Only dumping up to first %d services with non-zero use-count",
+			 active_services, found);
 
 	for (i = 0; i < found; i++) {
-		vchiq_log_warning(vchiq_susp_log_level, "----- %c%c%c%c:%d service count %d %s",
-				  VCHIQ_FOURCC_AS_4CHARS(service_data[i].fourcc),
-				  service_data[i].clientid, service_data[i].use_count,
-				  service_data[i].use_count ? nz : "");
+		dev_warn(state->dev, "----- %c%c%c%c:%d service count %d %s",
+			 VCHIQ_FOURCC_AS_4CHARS(service_data[i].fourcc),
+			 service_data[i].clientid, service_data[i].use_count,
+			 service_data[i].use_count ? nz : "");
 	}
-	vchiq_log_warning(vchiq_susp_log_level, "----- VCHIQ use count %d", peer_count);
-	vchiq_log_warning(vchiq_susp_log_level, "--- Overall vchiq instance use count %d",
-			  vc_use_count);
+	dev_warn(state->dev, "----- VCHIQ use count %d", peer_count);
+	dev_warn(state->dev, "--- Overall vchiq instance use count %d", vc_use_count);
 
 	kfree(service_data);
 }
@@ -1714,10 +1703,10 @@ vchiq_check_service(struct vchiq_service *service)
 	read_unlock_bh(&arm_state->susp_res_lock);
 
 	if (ret == VCHIQ_ERROR) {
-		vchiq_log_error(vchiq_susp_log_level,
-				"%s ERROR - %c%c%c%c:%d service count %d, state count %d", __func__,
-				VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc), service->client_id,
-				service->service_use_count, arm_state->videocore_use_count);
+		dev_err(service->state->dev,
+			"ERROR - %c%c%c%c:%d service count %d, state count %d",
+			VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc), service->client_id,
+			service->service_use_count, arm_state->videocore_use_count);
 		vchiq_dump_service_use_state(service->state);
 	}
 out:
@@ -1731,8 +1720,8 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
 	char threadname[16];
 
-	vchiq_log_info(vchiq_susp_log_level, "%d: %s->%s", state->id,
-		       get_conn_state_name(oldstate), get_conn_state_name(newstate));
+	dev_dbg(state->dev, "%d: %s->%s", state->id,
+		get_conn_state_name(oldstate), get_conn_state_name(newstate));
 	if (state->conn_state != VCHIQ_CONNSTATE_CONNECTED)
 		return;
 
@@ -1750,9 +1739,7 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 					      (void *)state,
 					      threadname);
 	if (IS_ERR(arm_state->ka_thread)) {
-		vchiq_log_error(vchiq_susp_log_level,
-				"vchiq: FATAL: couldn't create thread %s",
-				threadname);
+		dev_err(state->dev, "vchiq: FATAL: couldn't create thread %s", threadname);
 	} else {
 		wake_up_process(arm_state->ka_thread);
 	}
@@ -1819,9 +1806,9 @@ static int vchiq_probe(struct platform_device *pdev)
 
 	vchiq_debugfs_init();
 
-	vchiq_log_info(vchiq_arm_log_level,
-		       "vchiq: platform initialised - version %d (min %d)",
-		       VCHIQ_VERSION, VCHIQ_VERSION_MIN);
+	dev_info(&pdev->dev,
+		 "vchiq: platform initialised - version %d (min %d)",
+		 VCHIQ_VERSION, VCHIQ_VERSION_MIN);
 
 	/*
 	 * Simply exit on error since the function handles cleanup in
@@ -1829,8 +1816,7 @@ static int vchiq_probe(struct platform_device *pdev)
 	 */
 	err = vchiq_register_chrdev(&pdev->dev);
 	if (err) {
-		vchiq_log_warning(vchiq_arm_log_level,
-				  "Failed to initialize vchiq cdev");
+		dev_warn(&pdev->dev, "Failed to initialize vchiq cdev");
 		goto error_exit;
 	}
 
@@ -1840,7 +1826,7 @@ static int vchiq_probe(struct platform_device *pdev)
 	return 0;
 
 failed_platform_init:
-	vchiq_log_warning(vchiq_arm_log_level, "could not initialize vchiq platform");
+	dev_warn(&pdev->dev, "could not initialize vchiq platform");
 error_exit:
 	return err;
 }
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index bdb0ab617d8b..fa9395eb8f7f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -27,7 +27,7 @@ static void connected_init(void)
  * be made immediately, otherwise it will be deferred until
  * vchiq_call_connected_callbacks is called.
  */
-void vchiq_add_connected_callback(void (*callback)(void))
+void vchiq_add_connected_callback(struct device *dev, void (*callback)(void))
 {
 	connected_init();
 
@@ -39,9 +39,8 @@ void vchiq_add_connected_callback(void (*callback)(void))
 		callback();
 	} else {
 		if (g_num_deferred_callbacks >= MAX_CALLBACKS) {
-			vchiq_log_error(vchiq_core_log_level,
-					"There already %d callback registered - please increase MAX_CALLBACKS",
-					g_num_deferred_callbacks);
+			dev_err(dev, "There already %d callback registered - please increase MAX_CALLBACKS",
+				g_num_deferred_callbacks);
 		} else {
 			g_deferred_callback[g_num_deferred_callbacks] =
 				callback;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h
index 4caf5e30099d..355fe9d0f068 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h
@@ -4,7 +4,9 @@
 #ifndef VCHIQ_CONNECTED_H
 #define VCHIQ_CONNECTED_H
 
-void vchiq_add_connected_callback(void (*callback)(void));
+#include <linux/device.h>
+
+void vchiq_add_connected_callback(struct device *dev, void (*callback)(void));
 void vchiq_call_connected_callbacks(void);
 
 #endif /* VCHIQ_CONNECTED_H */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 8f99272dbd6f..b943071179e1 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -12,7 +12,9 @@
 #include <linux/kref.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
+#include <linux/dev_printk.h>
 
+#include "vchiq_arm.h"
 #include "vchiq_core.h"
 
 #define VCHIQ_SLOT_HANDLER_STACK 8192
@@ -102,10 +104,7 @@ static_assert((unsigned int)VCHIQ_PORT_MAX <
 
 #define BULK_INDEX(x) ((x) & (VCHIQ_NUM_SERVICE_BULKS - 1))
 
-#define SRVTRACE_LEVEL(srv) \
-	(((srv) && (srv)->trace) ? VCHIQ_LOG_TRACE : vchiq_core_msg_log_level)
-#define SRVTRACE_ENABLED(srv, lev) \
-	(((srv) && (srv)->trace) || (vchiq_core_msg_log_level >= (lev)))
+#define SRVTRACE_ENABLED(srv) ((srv) && (srv)->trace)
 
 #define NO_CLOSE_RECVD	0
 #define CLOSE_RECVD	1
@@ -153,11 +152,6 @@ static inline void check_sizes(void)
 	BUILD_BUG_ON_NOT_POWER_OF_2(VCHIQ_MAX_SERVICES);
 }
 
-/* Run time control of log level, based on KERN_XXX level. */
-int vchiq_core_log_level = VCHIQ_LOG_DEFAULT;
-int vchiq_core_msg_log_level = VCHIQ_LOG_DEFAULT;
-int vchiq_sync_log_level = VCHIQ_LOG_DEFAULT;
-
 DEFINE_SPINLOCK(bulk_waiter_spinlock);
 static DEFINE_SPINLOCK(quota_spinlock);
 
@@ -227,10 +221,10 @@ static const char *msg_type_str(unsigned int msg_type)
 static inline void
 set_service_state(struct vchiq_service *service, int newstate)
 {
-	vchiq_log_info(vchiq_core_log_level, "%d: srv:%d %s->%s",
-		       service->state->id, service->localport,
-		       srvstate_names[service->srvstate],
-		       srvstate_names[newstate]);
+	dev_dbg(service->state->dev, "%d: srv:%d %s->%s",
+		service->state->id, service->localport,
+		srvstate_names[service->srvstate],
+		srvstate_names[newstate]);
 	service->srvstate = newstate;
 }
 
@@ -249,8 +243,7 @@ find_service_by_handle(unsigned int handle)
 		return service;
 	}
 	rcu_read_unlock();
-	vchiq_log_info(vchiq_core_log_level,
-		       "Invalid service handle 0x%x", handle);
+	dev_info(vchiq_states[0]->dev, "Invalid service handle 0x%x", handle);
 	return NULL;
 }
 
@@ -270,8 +263,7 @@ find_service_by_port(struct vchiq_state *state, unsigned int localport)
 		}
 		rcu_read_unlock();
 	}
-	vchiq_log_info(vchiq_core_log_level,
-		       "Invalid port %u", localport);
+	dev_info(state->dev, "Invalid port %u", localport);
 	return NULL;
 }
 
@@ -291,8 +283,7 @@ find_service_for_instance(struct vchiq_instance *instance, unsigned int handle)
 		return service;
 	}
 	rcu_read_unlock();
-	vchiq_log_info(vchiq_core_log_level,
-		       "Invalid service handle 0x%x", handle);
+	dev_info(instance->state->dev, "Invalid service handle 0x%x", handle);
 	return NULL;
 }
 
@@ -314,8 +305,7 @@ find_closed_service_for_instance(struct vchiq_instance *instance, unsigned int h
 		return service;
 	}
 	rcu_read_unlock();
-	vchiq_log_info(vchiq_core_log_level,
-		       "Invalid service handle 0x%x", handle);
+	dev_info(instance->state->dev, "Invalid service handle 0x%x", handle);
 	return service;
 }
 
@@ -463,14 +453,14 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 {
 	enum vchiq_status status;
 
-	vchiq_log_trace(vchiq_core_log_level, "%d: callback:%d (%s, %pK, %pK)",
-			service->state->id, service->localport, reason_names[reason],
-			header, bulk_userdata);
+	dev_dbg(service->state->dev, "%d: callback:%d (%s, %pK, %pK)",
+		service->state->id, service->localport, reason_names[reason],
+		header, bulk_userdata);
 	status = service->base.callback(reason, header, service->handle, bulk_userdata);
 	if (status == VCHIQ_ERROR) {
-		vchiq_log_warning(vchiq_core_log_level,
-				  "%d: ignoring ERROR from callback to service %x",
-				  service->state->id, service->handle);
+		dev_warn(service->state->dev,
+			 "%d: ignoring ERROR from callback to service %x",
+			 service->state->id, service->handle);
 		status = VCHIQ_SUCCESS;
 	}
 
@@ -485,8 +475,8 @@ vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newstate)
 {
 	enum vchiq_connstate oldstate = state->conn_state;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: %s->%s", state->id, conn_state_names[oldstate],
-		       conn_state_names[newstate]);
+	dev_dbg(state->dev, "%d: %s->%s", state->id, conn_state_names[oldstate],
+		conn_state_names[newstate]);
 	state->conn_state = newstate;
 	vchiq_platform_conn_state_changed(state, oldstate, newstate);
 }
@@ -732,10 +722,10 @@ process_free_data_message(struct vchiq_state *state, u32 *service_found,
 		 */
 		complete(&quota->quota_event);
 	} else if (count == 0) {
-		vchiq_log_error(vchiq_core_log_level,
-				"service %d message_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
-				port, quota->message_use_count, header, msgid, header->msgid,
-				header->size);
+		dev_err(state->dev,
+			"service %d message_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
+			port, quota->message_use_count, header, msgid, header->msgid,
+			header->size);
 		WARN(1, "invalid message use count\n");
 	}
 	if (!BITSET_IS_SET(service_found, port)) {
@@ -754,12 +744,12 @@ process_free_data_message(struct vchiq_state *state, u32 *service_found,
 			 * it has dropped below its quota
 			 */
 			complete(&quota->quota_event);
-			vchiq_log_trace(vchiq_core_log_level, "%d: pfq:%d %x@%pK - slot_use->%d",
-					state->id, port, header->size, header, count - 1);
+			dev_dbg(state->dev, "%d: pfq:%d %x@%pK - slot_use->%d",
+				state->id, port, header->size, header, count - 1);
 		} else {
-			vchiq_log_error(vchiq_core_log_level,
-					"service %d slot_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
-					port, count, header, msgid, header->msgid, header->size);
+			dev_err(state->dev,
+				"service %d slot_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
+				port, count, header, msgid, header->msgid, header->size);
 			WARN(1, "bad slot use count\n");
 		}
 	}
@@ -800,9 +790,9 @@ process_free_queue(struct vchiq_state *state, u32 *service_found,
 		 */
 		rmb();
 
-		vchiq_log_trace(vchiq_core_log_level, "%d: pfq %d=%pK %x %x",
-				state->id, slot_index, data, local->slot_queue_recycle,
-				slot_queue_available);
+		dev_dbg(state->dev, "%d: pfq %d=%pK %x %x",
+			state->id, slot_index, data, local->slot_queue_recycle,
+			slot_queue_available);
 
 		/* Initialise the bitmask for services which have used this slot */
 		memset(service_found, 0, length);
@@ -822,9 +812,9 @@ process_free_queue(struct vchiq_state *state, u32 *service_found,
 
 			pos += calc_stride(header->size);
 			if (pos > VCHIQ_SLOT_SIZE) {
-				vchiq_log_error(vchiq_core_log_level,
-						"pfq - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
-						pos, header, msgid, header->msgid, header->size);
+				dev_err(state->dev,
+					"pfq - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
+					pos, header, msgid, header->msgid, header->size);
 				WARN(1, "invalid slot position\n");
 			}
 		}
@@ -971,10 +961,9 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		       ((tx_end_index != quota->previous_tx_index) &&
 			(quota->slot_use_count == quota->slot_quota))) {
 			spin_unlock(&quota_spinlock);
-			vchiq_log_trace(vchiq_core_log_level,
-					"%d: qm:%d %s,%zx - quota stall (msg %d, slot %d)",
-					state->id, service->localport, msg_type_str(type), size,
-					quota->message_use_count, quota->slot_use_count);
+			dev_dbg(state->dev, "%d: qm:%d %s,%zx - quota stall (msg %d, slot %d)",
+				state->id, service->localport, msg_type_str(type), size,
+				quota->message_use_count, quota->slot_use_count);
 			VCHIQ_SERVICE_STATS_INC(service, quota_stalls);
 			mutex_unlock(&state->slot_mutex);
 			if (wait_for_completion_interruptible(&quota->quota_event))
@@ -1014,9 +1003,9 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		int tx_end_index;
 		int slot_use_count;
 
-		vchiq_log_info(vchiq_core_log_level, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
-			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
-			       VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
+		dev_dbg(state->dev, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
+			msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
+			VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 
 		WARN_ON(flags & (QMFLAGS_NO_MUTEX_LOCK |
 				 QMFLAGS_NO_MUTEX_UNLOCK));
@@ -1031,8 +1020,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			return VCHIQ_ERROR;
 		}
 
-		if (SRVTRACE_ENABLED(service,
-				     VCHIQ_LOG_INFO))
+		if (SRVTRACE_ENABLED(service))
 			vchiq_log_dump_mem("Sent", 0,
 					   header->data,
 					   min_t(size_t, 16, callback_result));
@@ -1066,17 +1054,16 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		spin_unlock(&quota_spinlock);
 
 		if (slot_use_count)
-			vchiq_log_trace(vchiq_core_log_level,
-					"%d: qm:%d %s,%zx - slot_use->%d (hdr %p)", state->id,
-					service->localport, msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-					size, slot_use_count, header);
+			dev_dbg(state->dev, "%d: qm:%d %s,%zx - slot_use->%d (hdr %p)", state->id,
+				service->localport, msg_type_str(VCHIQ_MSG_TYPE(msgid)),
+				size, slot_use_count, header);
 
 		VCHIQ_SERVICE_STATS_INC(service, ctrl_tx_count);
 		VCHIQ_SERVICE_STATS_ADD(service, ctrl_tx_bytes, size);
 	} else {
-		vchiq_log_info(vchiq_core_log_level, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
-			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
-			       VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
+		dev_dbg(state->dev, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
+			msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
+			VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 		if (size != 0) {
 			/*
 			 * It is assumed for now that this code path
@@ -1104,11 +1091,11 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			? service->base.fourcc
 			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 
-		vchiq_log_info(SRVTRACE_LEVEL(service),
-			       "Sent Msg %s(%u) to %c%c%c%c s:%u d:%d len:%zu",
-			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
-			       VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
-			       VCHIQ_MSG_DSTPORT(msgid), size);
+		dev_dbg(state->dev,
+			"Sent Msg %s(%u) to %c%c%c%c s:%u d:%d len:%zu",
+			msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
+			VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
+			VCHIQ_MSG_DSTPORT(msgid), size);
 	}
 
 	/* Make sure the new header is visible to the peer. */
@@ -1140,6 +1127,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 	struct vchiq_shared_state *local;
 	struct vchiq_header *header;
 	ssize_t callback_result;
+	int svc_fourcc;
 
 	local = state->local;
 
@@ -1158,15 +1146,15 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 		int oldmsgid = header->msgid;
 
 		if (oldmsgid != VCHIQ_MSGID_PADDING)
-			vchiq_log_error(vchiq_core_log_level, "%d: qms - msgid %x, not PADDING",
-					state->id, oldmsgid);
+			dev_err(state->dev, "%d: qms - msgid %x, not PADDING",
+				state->id, oldmsgid);
 	}
 
-	vchiq_log_info(vchiq_sync_log_level,
-		       "%d: qms %s@%pK,%x (%d->%d)", state->id,
-		       msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-		       header, size, VCHIQ_MSG_SRCPORT(msgid),
-		       VCHIQ_MSG_DSTPORT(msgid));
+	dev_dbg(state->dev,
+		"%d: qms %s@%pK,%x (%d->%d)", state->id,
+		msg_type_str(VCHIQ_MSG_TYPE(msgid)),
+		header, size, VCHIQ_MSG_SRCPORT(msgid),
+		VCHIQ_MSG_DSTPORT(msgid));
 
 	callback_result =
 		copy_message_data(copy_callback, context,
@@ -1179,8 +1167,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 	}
 
 	if (service) {
-		if (SRVTRACE_ENABLED(service,
-				     VCHIQ_LOG_INFO))
+		if (SRVTRACE_ENABLED(service))
 			vchiq_log_dump_mem("Sent", 0,
 					   header->data,
 					   min_t(size_t, 16, callback_result));
@@ -1194,19 +1181,14 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 	header->size = size;
 	header->msgid = msgid;
 
-	if (vchiq_sync_log_level >= VCHIQ_LOG_TRACE) {
-		int svc_fourcc;
+	svc_fourcc = service
+		? service->base.fourcc
+		: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 
-		svc_fourcc = service
-			? service->base.fourcc
-			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
-
-		vchiq_log_trace(vchiq_sync_log_level,
-				"Sent Sync Msg %s(%u) to %c%c%c%c s:%u d:%d len:%d",
-				msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
-				VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
-				VCHIQ_MSG_DSTPORT(msgid), size);
-	}
+	dev_dbg(state->dev, "Sent Sync Msg %s(%u) to %c%c%c%c s:%u d:%d len:%d",
+		msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
+		VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
+		VCHIQ_MSG_DSTPORT(msgid), size);
 
 	remote_event_signal(&state->remote->sync_trigger);
 
@@ -1258,9 +1240,9 @@ release_slot(struct vchiq_state *state, struct vchiq_slot_info *slot_info,
 			VCHIQ_SLOT_QUEUE_MASK] =
 			SLOT_INDEX_FROM_INFO(state, slot_info);
 		state->remote->slot_queue_recycle = slot_queue_recycle + 1;
-		vchiq_log_info(vchiq_core_log_level, "%d: %s %d - recycle->%x", state->id, __func__,
-			       SLOT_INDEX_FROM_INFO(state, slot_info),
-			       state->remote->slot_queue_recycle);
+		dev_dbg(state->dev, "%d: %s %d - recycle->%x", state->id, __func__,
+			SLOT_INDEX_FROM_INFO(state, slot_info),
+			state->remote->slot_queue_recycle);
 
 		/*
 		 * A write barrier is necessary, but remote_event_signal
@@ -1295,9 +1277,9 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 {
 	enum vchiq_status status = VCHIQ_SUCCESS;
 
-	vchiq_log_trace(vchiq_core_log_level, "%d: nb:%d %cx - p=%x rn=%x r=%x", service->state->id,
-			service->localport, (queue == &service->bulk_tx) ? 't' : 'r',
-			queue->process, queue->remote_notify, queue->remove);
+	dev_dbg(service->state->dev, "%d: nb:%d %cx - p=%x rn=%x r=%x", service->state->id,
+		service->localport, (queue == &service->bulk_tx) ? 't' : 'r',
+		queue->process, queue->remote_notify, queue->remove);
 
 	queue->remote_notify = queue->process;
 
@@ -1377,9 +1359,9 @@ poll_services_of_group(struct vchiq_state *state, int group)
 
 		service_flags = atomic_xchg(&service->poll_flags, 0);
 		if (service_flags & BIT(VCHIQ_POLL_REMOVE)) {
-			vchiq_log_info(vchiq_core_log_level, "%d: ps - remove %d<->%d",
-				       state->id, service->localport,
-				       service->remoteport);
+			dev_dbg(state->dev, "%d: ps - remove %d<->%d",
+				state->id, service->localport,
+				service->remoteport);
 
 			/*
 			 * Make it look like a client, because
@@ -1392,8 +1374,8 @@ poll_services_of_group(struct vchiq_state *state, int group)
 							 VCHIQ_SUCCESS)
 				request_poll(state, service, VCHIQ_POLL_REMOVE);
 		} else if (service_flags & BIT(VCHIQ_POLL_TERMINATE)) {
-			vchiq_log_info(vchiq_core_log_level, "%d: ps - terminate %d<->%d",
-				       state->id, service->localport, service->remoteport);
+			dev_dbg(state->dev, "%d: ps - terminate %d<->%d",
+				state->id, service->localport, service->remoteport);
 			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD) != VCHIQ_SUCCESS)
 				request_poll(state, service, VCHIQ_POLL_TERMINATE);
 		}
@@ -1422,9 +1404,9 @@ abort_outstanding_bulks(struct vchiq_service *service,
 {
 	int is_tx = (queue == &service->bulk_tx);
 
-	vchiq_log_trace(vchiq_core_log_level, "%d: aob:%d %cx - li=%x ri=%x p=%x",
-			service->state->id, service->localport, is_tx ? 't' : 'r',
-			queue->local_insert, queue->remote_insert, queue->process);
+	dev_dbg(service->state->dev, "%d: aob:%d %cx - li=%x ri=%x p=%x",
+		service->state->id, service->localport, is_tx ? 't' : 'r',
+		queue->local_insert, queue->remote_insert, queue->process);
 
 	WARN_ON((int)(queue->local_insert - queue->process) < 0);
 	WARN_ON((int)(queue->remote_insert - queue->process) < 0);
@@ -1443,11 +1425,11 @@ abort_outstanding_bulks(struct vchiq_service *service,
 		if (queue->process != queue->local_insert) {
 			vchiq_complete_bulk(bulk);
 
-			vchiq_log_info(SRVTRACE_LEVEL(service),
-				       "%s %c%c%c%c d:%d ABORTED - tx len:%d, rx len:%d",
-				       is_tx ? "Send Bulk to" : "Recv Bulk from",
-				       VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
-				       service->remoteport, bulk->size, bulk->remote_size);
+			dev_dbg(service->state->dev,
+				"%s %c%c%c%c d:%d ABORTED - tx len:%d, rx len:%d",
+				is_tx ? "Send Bulk to" : "Recv Bulk from",
+				VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
+				service->remoteport, bulk->size, bulk->remote_size);
 		} else {
 			/* fabricate a matching dummy bulk */
 			bulk->data = 0;
@@ -1480,8 +1462,8 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 
 	payload = (struct vchiq_open_payload *)header->data;
 	fourcc = payload->fourcc;
-	vchiq_log_info(vchiq_core_log_level, "%d: prs OPEN@%pK (%d->'%c%c%c%c')",
-		       state->id, header, localport, VCHIQ_FOURCC_AS_4CHARS(fourcc));
+	dev_dbg(state->dev, "%d: prs OPEN@%pK (%d->'%c%c%c%c')",
+		state->id, header, localport, VCHIQ_FOURCC_AS_4CHARS(fourcc));
 
 	service = get_listening_service(state, fourcc);
 	if (!service)
@@ -1493,11 +1475,9 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 
 	if ((service->version < version_min) || (version < service->version_min)) {
 		/* Version mismatch */
-		vchiq_loud_error_header();
-		vchiq_loud_error("%d: service %d (%c%c%c%c) version mismatch - local (%d, min %d) vs. remote (%d, min %d)",
-				 state->id, service->localport, VCHIQ_FOURCC_AS_4CHARS(fourcc),
-				 service->version, service->version_min, version, version_min);
-		vchiq_loud_error_footer();
+		dev_err(state->dev, "%d: service %d (%c%c%c%c) version mismatch - local (%d, min %d) vs. remote (%d, min %d)",
+			state->id, service->localport, VCHIQ_FOURCC_AS_4CHARS(fourcc),
+			service->version, service->version_min, version, version_min);
 		vchiq_service_put(service);
 		service = NULL;
 		goto fail_open;
@@ -1605,17 +1585,17 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 				vchiq_service_put(service);
 			service = get_connected_service(state, remoteport);
 			if (service)
-				vchiq_log_warning(vchiq_core_log_level,
-						  "%d: prs %s@%pK (%d->%d) - found connected service %d",
-						  state->id, msg_type_str(type), header,
-						  remoteport, localport, service->localport);
+				dev_warn(state->dev,
+					 "%d: prs %s@%pK (%d->%d) - found connected service %d",
+					 state->id, msg_type_str(type), header,
+					 remoteport, localport, service->localport);
 		}
 
 		if (!service) {
-			vchiq_log_error(vchiq_core_log_level,
-					"%d: prs %s@%pK (%d->%d) - invalid/closed service %d",
-					state->id, msg_type_str(type), header, remoteport,
-					localport, localport);
+			dev_err(state->dev,
+				"%d: prs %s@%pK (%d->%d) - invalid/closed service %d",
+				state->id, msg_type_str(type), header, remoteport,
+				localport, localport);
 			goto skip_message;
 		}
 		break;
@@ -1623,25 +1603,25 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		break;
 	}
 
-	if (SRVTRACE_ENABLED(service, VCHIQ_LOG_INFO)) {
+	if (SRVTRACE_ENABLED(service)) {
 		int svc_fourcc;
 
 		svc_fourcc = service
 			? service->base.fourcc
 			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
-		vchiq_log_info(SRVTRACE_LEVEL(service),
-			       "Rcvd Msg %s(%u) from %c%c%c%c s:%d d:%d len:%d",
-			       msg_type_str(type), type, VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
-			       remoteport, localport, size);
+		dev_dbg(state->dev,
+			"Rcvd Msg %s(%u) from %c%c%c%c s:%d d:%d len:%d",
+			msg_type_str(type), type, VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
+			remoteport, localport, size);
 		if (size > 0)
 			vchiq_log_dump_mem("Rcvd", 0, header->data, min(16, size));
 	}
 
 	if (((unsigned long)header & VCHIQ_SLOT_MASK) +
 	    calc_stride(size) > VCHIQ_SLOT_SIZE) {
-		vchiq_log_error(vchiq_core_log_level,
-				"header %pK (msgid %x) - size %x too big for slot",
-				header, (unsigned int)msgid, (unsigned int)size);
+		dev_err(state->dev,
+			"header %pK (msgid %x) - size %x too big for slot",
+			header, (unsigned int)msgid, (unsigned int)size);
 		WARN(1, "oversized for slot\n");
 	}
 
@@ -1658,36 +1638,36 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 				header->data;
 			service->peer_version = payload->version;
 		}
-		vchiq_log_info(vchiq_core_log_level, "%d: prs OPENACK@%pK,%x (%d->%d) v:%d",
-			       state->id, header, size, remoteport, localport,
-			       service->peer_version);
+		dev_dbg(state->dev, "%d: prs OPENACK@%pK,%x (%d->%d) v:%d",
+			state->id, header, size, remoteport, localport,
+			service->peer_version);
 		if (service->srvstate == VCHIQ_SRVSTATE_OPENING) {
 			service->remoteport = remoteport;
 			set_service_state(service, VCHIQ_SRVSTATE_OPEN);
 			complete(&service->remove_event);
 		} else {
-			vchiq_log_error(vchiq_core_log_level, "OPENACK received in state %s",
-					srvstate_names[service->srvstate]);
+			dev_err(state->dev, "OPENACK received in state %s",
+				srvstate_names[service->srvstate]);
 		}
 		break;
 	case VCHIQ_MSG_CLOSE:
 		WARN_ON(size); /* There should be no data */
 
-		vchiq_log_info(vchiq_core_log_level, "%d: prs CLOSE@%pK (%d->%d)",
-			       state->id, header, remoteport, localport);
+		dev_dbg(state->dev, "%d: prs CLOSE@%pK (%d->%d)",
+			state->id, header, remoteport, localport);
 
 		mark_service_closing_internal(service, 1);
 
 		if (vchiq_close_service_internal(service, CLOSE_RECVD) == VCHIQ_RETRY)
 			goto bail_not_ready;
 
-		vchiq_log_info(vchiq_core_log_level, "Close Service %c%c%c%c s:%u d:%d",
-			       VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
-			       service->localport, service->remoteport);
+		dev_dbg(state->dev, "Close Service %c%c%c%c s:%u d:%d",
+			VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
+			service->localport, service->remoteport);
 		break;
 	case VCHIQ_MSG_DATA:
-		vchiq_log_info(vchiq_core_log_level, "%d: prs DATA@%pK,%x (%d->%d)",
-			       state->id, header, size, remoteport, localport);
+		dev_dbg(state->dev, "%d: prs DATA@%pK,%x (%d->%d)",
+			state->id, header, size, remoteport, localport);
 
 		if ((service->remoteport == remoteport) &&
 		    (service->srvstate == VCHIQ_SRVSTATE_OPEN)) {
@@ -1706,7 +1686,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		}
 		break;
 	case VCHIQ_MSG_CONNECT:
-		vchiq_log_info(vchiq_core_log_level, "%d: prs CONNECT@%pK", state->id, header);
+		dev_dbg(state->dev, "%d: prs CONNECT@%pK", state->id, header);
 		state->version_common =	((struct vchiq_slot_zero *)
 					 state->slot_data)->version;
 		complete(&state->connect);
@@ -1737,11 +1717,11 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			}
 			if ((int)(queue->remote_insert -
 				queue->local_insert) >= 0) {
-				vchiq_log_error(vchiq_core_log_level,
-						"%d: prs %s@%pK (%d->%d) unexpected (ri=%d,li=%d)",
-						state->id, msg_type_str(type), header, remoteport,
-						localport, queue->remote_insert,
-						queue->local_insert);
+				dev_err(state->dev,
+					"%d: prs %s@%pK (%d->%d) unexpected (ri=%d,li=%d)",
+					state->id, msg_type_str(type), header, remoteport,
+					localport, queue->remote_insert,
+					queue->local_insert);
 				mutex_unlock(&service->bulk_mutex);
 				break;
 			}
@@ -1758,14 +1738,14 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			bulk->actual = *(int *)header->data;
 			queue->remote_insert++;
 
-			vchiq_log_info(vchiq_core_log_level, "%d: prs %s@%pK (%d->%d) %x@%pad",
-				       state->id, msg_type_str(type), header, remoteport, localport,
-				       bulk->actual, &bulk->data);
+			dev_dbg(state->dev, "%d: prs %s@%pK (%d->%d) %x@%pad",
+				state->id, msg_type_str(type), header, remoteport, localport,
+				bulk->actual, &bulk->data);
 
-			vchiq_log_trace(vchiq_core_log_level, "%d: prs:%d %cx li=%x ri=%x p=%x",
-					state->id, localport,
-					(type == VCHIQ_MSG_BULK_RX_DONE) ? 'r' : 't',
-					queue->local_insert, queue->remote_insert, queue->process);
+			dev_dbg(state->dev, "%d: prs:%d %cx li=%x ri=%x p=%x",
+				state->id, localport,
+				(type == VCHIQ_MSG_BULK_RX_DONE) ? 'r' : 't',
+				queue->local_insert, queue->remote_insert, queue->process);
 
 			DEBUG_TRACE(PARSE_LINE);
 			WARN_ON(queue->process == queue->local_insert);
@@ -1778,16 +1758,16 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		}
 		break;
 	case VCHIQ_MSG_PADDING:
-		vchiq_log_trace(vchiq_core_log_level, "%d: prs PADDING@%pK,%x",
-				state->id, header, size);
+		dev_dbg(state->dev, "%d: prs PADDING@%pK,%x",
+			state->id, header, size);
 		break;
 	case VCHIQ_MSG_PAUSE:
 		/* If initiated, signal the application thread */
-		vchiq_log_trace(vchiq_core_log_level, "%d: prs PAUSE@%pK,%x",
-				state->id, header, size);
+		dev_dbg(state->dev, "%d: prs PAUSE@%pK,%x",
+			state->id, header, size);
 		if (state->conn_state == VCHIQ_CONNSTATE_PAUSED) {
-			vchiq_log_error(vchiq_core_log_level, "%d: PAUSE received in state PAUSED",
-					state->id);
+			dev_err(state->dev, "%d: PAUSE received in state PAUSED",
+				state->id);
 			break;
 		}
 		if (state->conn_state != VCHIQ_CONNSTATE_PAUSE_SENT) {
@@ -1800,8 +1780,8 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_PAUSED);
 		break;
 	case VCHIQ_MSG_RESUME:
-		vchiq_log_trace(vchiq_core_log_level, "%d: prs RESUME@%pK,%x",
-				state->id, header, size);
+		dev_dbg(state->dev, "%d: prs RESUME@%pK,%x",
+			state->id, header, size);
 		/* Release the slot mutex */
 		mutex_unlock(&state->slot_mutex);
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTED);
@@ -1817,8 +1797,8 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		break;
 
 	default:
-		vchiq_log_error(vchiq_core_log_level, "%d: prs invalid msgid %x@%pK,%x",
-				state->id, msgid, header, size);
+		dev_err(state->dev, "%d: prs invalid msgid %x@%pK,%x",
+			state->id, msgid, header, size);
 		WARN(1, "invalid message\n");
 		break;
 	}
@@ -1928,7 +1908,7 @@ handle_poll(struct vchiq_state *state)
 			 * since the PAUSE should have flushed
 			 * through outstanding messages.
 			 */
-			vchiq_log_error(vchiq_core_log_level, "Failed to send RESUME message");
+			dev_err(state->dev, "Failed to send RESUME message");
 		}
 		break;
 	default:
@@ -2005,6 +1985,7 @@ sync_func(void *v)
 	struct vchiq_header *header =
 		(struct vchiq_header *)SLOT_DATA_FROM_INDEX(state,
 			state->remote->slot_sync);
+	int svc_fourcc;
 
 	while (1) {
 		struct vchiq_service *service;
@@ -2025,27 +2006,22 @@ sync_func(void *v)
 		service = find_service_by_port(state, localport);
 
 		if (!service) {
-			vchiq_log_error(vchiq_sync_log_level,
-					"%d: sf %s@%pK (%d->%d) - invalid/closed service %d",
-					state->id, msg_type_str(type), header,
-					remoteport, localport, localport);
+			dev_err(state->dev,
+				"%d: sf %s@%pK (%d->%d) - invalid/closed service %d",
+				state->id, msg_type_str(type), header,
+				remoteport, localport, localport);
 			release_message_sync(state, header);
 			continue;
 		}
 
-		if (vchiq_sync_log_level >= VCHIQ_LOG_TRACE) {
-			int svc_fourcc;
-
-			svc_fourcc = service
-				? service->base.fourcc
-				: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
-			vchiq_log_trace(vchiq_sync_log_level,
-					"Rcvd Msg %s from %c%c%c%c s:%d d:%d len:%d",
-					msg_type_str(type), VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
-					remoteport, localport, size);
-			if (size > 0)
-				vchiq_log_dump_mem("Rcvd", 0, header->data, min(16, size));
-		}
+		svc_fourcc = service
+			? service->base.fourcc
+			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
+		dev_dbg(state->dev, "Rcvd Msg %s from %c%c%c%c s:%d d:%d len:%d",
+			msg_type_str(type), VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
+			remoteport, localport, size);
+		if (size > 0)
+			vchiq_log_dump_mem("Rcvd", 0, header->data, min(16, size));
 
 		switch (type) {
 		case VCHIQ_MSG_OPENACK:
@@ -2055,9 +2031,9 @@ sync_func(void *v)
 					header->data;
 				service->peer_version = payload->version;
 			}
-			vchiq_log_info(vchiq_sync_log_level, "%d: sf OPENACK@%pK,%x (%d->%d) v:%d",
-				       state->id, header, size, remoteport, localport,
-				       service->peer_version);
+			dev_dbg(state->dev, "%d: sf OPENACK@%pK,%x (%d->%d) v:%d",
+				state->id, header, size, remoteport, localport,
+				service->peer_version);
 			if (service->srvstate == VCHIQ_SRVSTATE_OPENING) {
 				service->remoteport = remoteport;
 				set_service_state(service, VCHIQ_SRVSTATE_OPENSYNC);
@@ -2068,22 +2044,22 @@ sync_func(void *v)
 			break;
 
 		case VCHIQ_MSG_DATA:
-			vchiq_log_trace(vchiq_sync_log_level, "%d: sf DATA@%pK,%x (%d->%d)",
-					state->id, header, size, remoteport, localport);
+			dev_dbg(state->dev, "%d: sf DATA@%pK,%x (%d->%d)",
+				state->id, header, size, remoteport, localport);
 
 			if ((service->remoteport == remoteport) &&
 			    (service->srvstate == VCHIQ_SRVSTATE_OPENSYNC)) {
 				if (make_service_callback(service, VCHIQ_MESSAGE_AVAILABLE, header,
 							  NULL) == VCHIQ_RETRY)
-					vchiq_log_error(vchiq_sync_log_level,
-							"synchronous callback to service %d returns VCHIQ_RETRY",
-							localport);
+					dev_err(state->dev,
+						"synchronous callback to service %d returns VCHIQ_RETRY",
+						localport);
 			}
 			break;
 
 		default:
-			vchiq_log_error(vchiq_sync_log_level, "%d: sf unexpected msgid %x@%pK,%x",
-					state->id, msgid, header, size);
+			dev_err(state->dev, "%d: sf unexpected msgid %x@%pK,%x",
+				state->id, msgid, header, size);
 			release_message_sync(state, header);
 			break;
 		}
@@ -2116,8 +2092,7 @@ vchiq_init_slots(void *mem_base, int mem_size)
 	num_slots -= first_data_slot;
 
 	if (num_slots < 4) {
-		vchiq_log_error(vchiq_core_log_level, "%s - insufficient memory %x bytes",
-				__func__, mem_size);
+		dev_err(vchiq_states[0]->dev, "insufficient memory %x bytes", mem_size);
 		return NULL;
 	}
 
@@ -2142,7 +2117,7 @@ vchiq_init_slots(void *mem_base, int mem_size)
 }
 
 int
-vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
+vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, struct device *dev)
 {
 	struct vchiq_shared_state *local;
 	struct vchiq_shared_state *remote;
@@ -2158,17 +2133,17 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 	remote = &slot_zero->master;
 
 	if (local->initialised) {
-		vchiq_loud_error_header();
 		if (remote->initialised)
-			vchiq_loud_error("local state has already been initialised");
+			dev_err(dev, "local state has already been initialised");
 		else
-			vchiq_loud_error("master/slave mismatch two slaves");
-		vchiq_loud_error_footer();
+			dev_err(dev, "master/slave mismatch two slaves");
 		return -EINVAL;
 	}
 
 	memset(state, 0, sizeof(struct vchiq_state));
 
+	state->dev = dev;
+
 	/*
 	 * initialize shared state pointers
 	 */
@@ -2239,9 +2214,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 	state->slot_handler_thread = kthread_create(&slot_handler_func, (void *)state, threadname);
 
 	if (IS_ERR(state->slot_handler_thread)) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("couldn't create thread %s", threadname);
-		vchiq_loud_error_footer();
+		dev_err(state->dev, "couldn't create thread %s", threadname);
 		return PTR_ERR(state->slot_handler_thread);
 	}
 	set_user_nice(state->slot_handler_thread, -19);
@@ -2249,9 +2222,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 	snprintf(threadname, sizeof(threadname), "vchiq-recy/%d", state->id);
 	state->recycle_thread = kthread_create(&recycle_func, (void *)state, threadname);
 	if (IS_ERR(state->recycle_thread)) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("couldn't create thread %s", threadname);
-		vchiq_loud_error_footer();
+		dev_err(state->dev, "couldn't create thread %s", threadname);
 		ret = PTR_ERR(state->recycle_thread);
 		goto fail_free_handler_thread;
 	}
@@ -2260,9 +2231,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 	snprintf(threadname, sizeof(threadname), "vchiq-sync/%d", state->id);
 	state->sync_thread = kthread_create(&sync_func, (void *)state, threadname);
 	if (IS_ERR(state->sync_thread)) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("couldn't create thread %s", threadname);
-		vchiq_loud_error_footer();
+		dev_err(state->dev, "couldn't create thread %s", threadname);
 		ret = PTR_ERR(state->sync_thread);
 		goto fail_free_recycle_thread;
 	}
@@ -2339,7 +2308,7 @@ EXPORT_SYMBOL(vchiq_msg_hold);
 static int vchiq_validate_params(const struct vchiq_service_params_kernel *params)
 {
 	if (!params->callback || !params->fourcc) {
-		vchiq_loud_error("Can't add service, invalid params\n");
+		dev_err(vchiq_states[0]->dev, "Can't add service, invalid params\n");
 		return -EINVAL;
 	}
 
@@ -2469,9 +2438,9 @@ vchiq_add_service_internal(struct vchiq_state *state,
 	/* Bring this service online */
 	set_service_state(service, srvstate);
 
-	vchiq_log_info(vchiq_core_msg_log_level, "%s Service %c%c%c%c SrcPort:%d",
-		       (srvstate == VCHIQ_SRVSTATE_OPENING) ? "Open" : "Add",
-		       VCHIQ_FOURCC_AS_4CHARS(params->fourcc), service->localport);
+	dev_dbg(state->dev, "%s Service %c%c%c%c SrcPort:%d",
+		(srvstate == VCHIQ_SRVSTATE_OPENING) ? "Open" : "Add",
+		VCHIQ_FOURCC_AS_4CHARS(params->fourcc), service->localport);
 
 	/* Don't unlock the service - leave it with a ref_count of 1. */
 
@@ -2508,11 +2477,11 @@ vchiq_open_service_internal(struct vchiq_service *service, int client_id)
 	} else if ((service->srvstate != VCHIQ_SRVSTATE_OPEN) &&
 		   (service->srvstate != VCHIQ_SRVSTATE_OPENSYNC)) {
 		if (service->srvstate != VCHIQ_SRVSTATE_CLOSEWAIT)
-			vchiq_log_error(vchiq_core_log_level,
-					"%d: osi - srvstate = %s (ref %u)",
-					service->state->id,
-					srvstate_names[service->srvstate],
-					kref_read(&service->ref_count));
+			dev_err(service->state->dev,
+				"%d: osi - srvstate = %s (ref %u)",
+				service->state->id,
+				srvstate_names[service->srvstate],
+				kref_read(&service->ref_count));
 		status = VCHIQ_ERROR;
 		VCHIQ_SERVICE_STATS_INC(service, error_count);
 		vchiq_release_service_internal(service);
@@ -2567,14 +2536,14 @@ release_service_messages(struct vchiq_service *service)
 			int port = VCHIQ_MSG_DSTPORT(msgid);
 
 			if ((port == service->localport) && (msgid & VCHIQ_MSGID_CLAIMED)) {
-				vchiq_log_info(vchiq_core_log_level, "  fsi - hdr %pK", header);
+				dev_dbg(state->dev, "  fsi - hdr %pK", header);
 				release_slot(state, slot_info, header, NULL);
 			}
 			pos += calc_stride(header->size);
 			if (pos > VCHIQ_SLOT_SIZE) {
-				vchiq_log_error(vchiq_core_log_level,
-						"fsi - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
-						pos, header, msgid, header->msgid, header->size);
+				dev_err(state->dev,
+					"fsi - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
+					pos, header, msgid, header->msgid, header->size);
 				WARN(1, "invalid slot position\n");
 			}
 		}
@@ -2628,8 +2597,8 @@ close_service_complete(struct vchiq_service *service, int failstate)
 	case VCHIQ_SRVSTATE_LISTENING:
 		break;
 	default:
-		vchiq_log_error(vchiq_core_log_level, "%s(%x) called in state %s", __func__,
-				service->handle, srvstate_names[service->srvstate]);
+		dev_err(service->state->dev, "%s(%x) called in state %s", __func__,
+			service->handle, srvstate_names[service->srvstate]);
 		WARN(1, "%s in unexpected state\n", __func__);
 		return VCHIQ_ERROR;
 	}
@@ -2675,8 +2644,8 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 	int close_id = MAKE_CLOSE(service->localport,
 				  VCHIQ_MSG_DSTPORT(service->remoteport));
 
-	vchiq_log_info(vchiq_core_log_level, "%d: csi:%d,%d (%s)", service->state->id,
-		       service->localport, close_recvd, srvstate_names[service->srvstate]);
+	dev_dbg(state->dev, "%d: csi:%d,%d (%s)", service->state->id,
+		service->localport, close_recvd, srvstate_names[service->srvstate]);
 
 	switch (service->srvstate) {
 	case VCHIQ_SRVSTATE_CLOSED:
@@ -2684,8 +2653,8 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 	case VCHIQ_SRVSTATE_LISTENING:
 	case VCHIQ_SRVSTATE_CLOSEWAIT:
 		if (close_recvd) {
-			vchiq_log_error(vchiq_core_log_level, "%s(1) called in state %s",
-					__func__, srvstate_names[service->srvstate]);
+			dev_err(service->state->dev, "%s(1) called in state %s",
+				__func__, srvstate_names[service->srvstate]);
 		} else if (is_server) {
 			if (service->srvstate == VCHIQ_SRVSTATE_LISTENING) {
 				status = VCHIQ_ERROR;
@@ -2772,8 +2741,8 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 		break;
 
 	default:
-		vchiq_log_error(vchiq_core_log_level, "%s(%d) called in state %s", __func__,
-				close_recvd, srvstate_names[service->srvstate]);
+		dev_err(state->dev, "%s(%d) called in state %s", __func__,
+			close_recvd, srvstate_names[service->srvstate]);
 		break;
 	}
 
@@ -2786,8 +2755,8 @@ vchiq_terminate_service_internal(struct vchiq_service *service)
 {
 	struct vchiq_state *state = service->state;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: tsi - (%d<->%d)", state->id,
-		       service->localport, service->remoteport);
+	dev_dbg(state->dev, "%d: tsi - (%d<->%d)", state->id,
+		service->localport, service->remoteport);
 
 	mark_service_closing(service);
 
@@ -2801,7 +2770,7 @@ vchiq_free_service_internal(struct vchiq_service *service)
 {
 	struct vchiq_state *state = service->state;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: fsi - (%d)", state->id, service->localport);
+	dev_dbg(state->dev, "%d: fsi - (%d)", state->id, service->localport);
 
 	switch (service->srvstate) {
 	case VCHIQ_SRVSTATE_OPENING:
@@ -2811,8 +2780,8 @@ vchiq_free_service_internal(struct vchiq_service *service)
 	case VCHIQ_SRVSTATE_CLOSEWAIT:
 		break;
 	default:
-		vchiq_log_error(vchiq_core_log_level, "%d: fsi - (%d) in state %s", state->id,
-				service->localport, srvstate_names[service->srvstate]);
+		dev_err(state->dev, "%d: fsi - (%d) in state %s", state->id,
+			service->localport, srvstate_names[service->srvstate]);
 		return;
 	}
 
@@ -2881,8 +2850,8 @@ vchiq_close_service(unsigned int handle)
 	if (!service)
 		return VCHIQ_ERROR;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: close_service:%d",
-		       service->state->id, service->localport);
+	dev_dbg(service->state->dev, "%d: close_service:%d",
+		service->state->id, service->localport);
 
 	if ((service->srvstate == VCHIQ_SRVSTATE_FREE) ||
 	    (service->srvstate == VCHIQ_SRVSTATE_LISTENING) ||
@@ -2912,10 +2881,10 @@ vchiq_close_service(unsigned int handle)
 		    (service->srvstate == VCHIQ_SRVSTATE_OPEN))
 			break;
 
-		vchiq_log_warning(vchiq_core_log_level,
-				  "%d: close_service:%d - waiting in state %s",
-				  service->state->id, service->localport,
-				  srvstate_names[service->srvstate]);
+		dev_warn(service->state->dev,
+			 "%d: close_service:%d - waiting in state %s",
+			 service->state->id, service->localport,
+			 srvstate_names[service->srvstate]);
 	}
 
 	if ((status == VCHIQ_SUCCESS) &&
@@ -2939,8 +2908,8 @@ vchiq_remove_service(unsigned int handle)
 	if (!service)
 		return VCHIQ_ERROR;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: remove_service:%d",
-		       service->state->id, service->localport);
+	dev_dbg(service->state->dev, "%d: remove_service:%d",
+		service->state->id, service->localport);
 
 	if (service->srvstate == VCHIQ_SRVSTATE_FREE) {
 		vchiq_service_put(service);
@@ -2973,10 +2942,10 @@ vchiq_remove_service(unsigned int handle)
 		    (service->srvstate == VCHIQ_SRVSTATE_OPEN))
 			break;
 
-		vchiq_log_warning(vchiq_core_log_level,
-				  "%d: remove_service:%d - waiting in state %s",
-				  service->state->id, service->localport,
-				  srvstate_names[service->srvstate]);
+		dev_warn(service->state->dev,
+			 "%d: remove_service:%d - waiting in state %s",
+			 service->state->id, service->localport,
+			 srvstate_names[service->srvstate]);
 	}
 
 	if ((status == VCHIQ_SUCCESS) &&
@@ -3080,9 +3049,9 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __
 
 	wmb();
 
-	vchiq_log_info(vchiq_core_log_level, "%d: bt (%d->%d) %cx %x@%pad %pK",
-		       state->id, service->localport, service->remoteport,
-		       dir_char, size, &bulk->data, userdata);
+	dev_dbg(state->dev, "%d: bt (%d->%d) %cx %x@%pad %pK",
+		state->id, service->localport, service->remoteport,
+		dir_char, size, &bulk->data, userdata);
 
 	/*
 	 * The slot mutex must be held when the service is being closed, so
@@ -3117,9 +3086,9 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __
 	mutex_unlock(&state->slot_mutex);
 	mutex_unlock(&service->bulk_mutex);
 
-	vchiq_log_trace(vchiq_core_log_level, "%d: bt:%d %cx li=%x ri=%x p=%x",
-			state->id, service->localport, dir_char, queue->local_insert,
-			queue->remote_insert, queue->process);
+	dev_dbg(state->dev, "%d: bt:%d %cx li=%x ri=%x p=%x",
+		state->id, service->localport, dir_char, queue->local_insert,
+		queue->remote_insert, queue->process);
 
 waiting:
 	vchiq_service_put(service);
@@ -3606,26 +3575,6 @@ int vchiq_dump_service_state(void *dump_context, struct vchiq_service *service)
 	return err;
 }
 
-void
-vchiq_loud_error_header(void)
-{
-	vchiq_log_error(vchiq_core_log_level,
-			"============================================================================");
-	vchiq_log_error(vchiq_core_log_level,
-			"============================================================================");
-	vchiq_log_error(vchiq_core_log_level, "=====");
-}
-
-void
-vchiq_loud_error_footer(void)
-{
-	vchiq_log_error(vchiq_core_log_level, "=====");
-	vchiq_log_error(vchiq_core_log_level,
-			"============================================================================");
-	vchiq_log_error(vchiq_core_log_level,
-			"============================================================================");
-}
-
 enum vchiq_status vchiq_send_remote_use(struct vchiq_state *state)
 {
 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
@@ -3672,9 +3621,9 @@ void vchiq_log_dump_mem(const char *label, u32 addr, const void *void_mem, size_
 		*s++ = '\0';
 
 		if (label && (*label != '\0'))
-			vchiq_log_trace(VCHIQ_LOG_TRACE, "%s: %08x: %s", label, addr, line_buf);
+			dev_dbg(vchiq_states[0]->dev, "%s: %08x: %s", label, addr, line_buf);
 		else
-			vchiq_log_trace(VCHIQ_LOG_TRACE, "%08x: %s", addr, line_buf);
+			dev_dbg(vchiq_states[0]->dev, "%08x: %s", addr, line_buf);
 
 		addr += 16;
 		mem += 16;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 82b7bd7b54b2..b1c1dd50873a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -30,39 +30,6 @@
 #define VCHIQ_SLOT_SIZE     4096
 #define VCHIQ_MAX_MSG_SIZE  (VCHIQ_SLOT_SIZE - sizeof(struct vchiq_header))
 
-/* Run time control of log level, based on KERN_XXX level. */
-#define VCHIQ_LOG_DEFAULT  4
-#define VCHIQ_LOG_ERROR    3
-#define VCHIQ_LOG_WARNING  4
-#define VCHIQ_LOG_INFO     6
-#define VCHIQ_LOG_TRACE    7
-
-#define VCHIQ_LOG_PREFIX   KERN_INFO "vchiq: "
-
-#ifndef vchiq_log_error
-#define vchiq_log_error(cat, fmt, ...) \
-	do { if (cat >= VCHIQ_LOG_ERROR) \
-		printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
-#endif
-#ifndef vchiq_log_warning
-#define vchiq_log_warning(cat, fmt, ...) \
-	do { if (cat >= VCHIQ_LOG_WARNING) \
-		 printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
-#endif
-#ifndef vchiq_log_info
-#define vchiq_log_info(cat, fmt, ...) \
-	do { if (cat >= VCHIQ_LOG_INFO) \
-		printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
-#endif
-#ifndef vchiq_log_trace
-#define vchiq_log_trace(cat, fmt, ...) \
-	do { if (cat >= VCHIQ_LOG_TRACE) \
-		printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
-#endif
-
-#define vchiq_loud_error(...) \
-	vchiq_log_error(vchiq_core_log_level, "===== " __VA_ARGS__)
-
 #define VCHIQ_SLOT_MASK        (VCHIQ_SLOT_SIZE - 1)
 #define VCHIQ_SLOT_QUEUE_MASK  (VCHIQ_MAX_SLOTS_PER_SIDE - 1)
 #define VCHIQ_SLOT_ZERO_SLOTS  DIV_ROUND_UP(sizeof(struct vchiq_slot_zero), \
@@ -315,6 +282,8 @@ struct vchiq_slot_zero {
 };
 
 struct vchiq_state {
+	struct device *dev;
+
 	int id;
 	int initialised;
 	enum vchiq_connstate conn_state;
@@ -458,7 +427,7 @@ extern struct vchiq_slot_zero *
 vchiq_init_slots(void *mem_base, int mem_size);
 
 extern int
-vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero);
+vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, struct device *dev);
 
 extern enum vchiq_status
 vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instance);
@@ -498,12 +467,6 @@ vchiq_dump_state(void *dump_context, struct vchiq_state *state);
 extern int
 vchiq_dump_service_state(void *dump_context, struct vchiq_service *service);
 
-extern void
-vchiq_loud_error_header(void);
-
-extern void
-vchiq_loud_error_footer(void);
-
 extern void
 request_poll(struct vchiq_state *state, struct vchiq_service *service,
 	     int poll_type);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index dc667afd1f8c..a9170fe21159 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -11,104 +11,10 @@
 
 #ifdef CONFIG_DEBUG_FS
 
-#define DEBUGFS_WRITE_BUF_SIZE 256
-
-#define VCHIQ_LOG_ERROR_STR   "error"
-#define VCHIQ_LOG_WARNING_STR "warning"
-#define VCHIQ_LOG_INFO_STR    "info"
-#define VCHIQ_LOG_TRACE_STR   "trace"
-
 /* Global 'vchiq' debugfs and clients entry used by all instances */
 static struct dentry *vchiq_dbg_dir;
 static struct dentry *vchiq_dbg_clients;
 
-/* Log category debugfs entries */
-struct vchiq_debugfs_log_entry {
-	const char *name;
-	void *plevel;
-};
-
-static struct vchiq_debugfs_log_entry vchiq_debugfs_log_entries[] = {
-	{ "core", &vchiq_core_log_level },
-	{ "msg",  &vchiq_core_msg_log_level },
-	{ "sync", &vchiq_sync_log_level },
-	{ "susp", &vchiq_susp_log_level },
-	{ "arm",  &vchiq_arm_log_level },
-};
-
-static int debugfs_log_show(struct seq_file *f, void *offset)
-{
-	int *levp = f->private;
-	char *log_value = NULL;
-
-	switch (*levp) {
-	case VCHIQ_LOG_ERROR:
-		log_value = VCHIQ_LOG_ERROR_STR;
-		break;
-	case VCHIQ_LOG_WARNING:
-		log_value = VCHIQ_LOG_WARNING_STR;
-		break;
-	case VCHIQ_LOG_INFO:
-		log_value = VCHIQ_LOG_INFO_STR;
-		break;
-	case VCHIQ_LOG_TRACE:
-		log_value = VCHIQ_LOG_TRACE_STR;
-		break;
-	default:
-		break;
-	}
-
-	seq_printf(f, "%s\n", log_value ? log_value : "(null)");
-
-	return 0;
-}
-
-static int debugfs_log_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, debugfs_log_show, inode->i_private);
-}
-
-static ssize_t debugfs_log_write(struct file *file,
-	const char __user *buffer,
-	size_t count, loff_t *ppos)
-{
-	struct seq_file *f = (struct seq_file *)file->private_data;
-	int *levp = f->private;
-	char kbuf[DEBUGFS_WRITE_BUF_SIZE + 1];
-
-	memset(kbuf, 0, DEBUGFS_WRITE_BUF_SIZE + 1);
-	if (count >= DEBUGFS_WRITE_BUF_SIZE)
-		count = DEBUGFS_WRITE_BUF_SIZE;
-
-	if (copy_from_user(kbuf, buffer, count))
-		return -EFAULT;
-	kbuf[count - 1] = 0;
-
-	if (strncmp("error", kbuf, strlen("error")) == 0)
-		*levp = VCHIQ_LOG_ERROR;
-	else if (strncmp("warning", kbuf, strlen("warning")) == 0)
-		*levp = VCHIQ_LOG_WARNING;
-	else if (strncmp("info", kbuf, strlen("info")) == 0)
-		*levp = VCHIQ_LOG_INFO;
-	else if (strncmp("trace", kbuf, strlen("trace")) == 0)
-		*levp = VCHIQ_LOG_TRACE;
-	else
-		*levp = VCHIQ_LOG_DEFAULT;
-
-	*ppos += count;
-
-	return count;
-}
-
-static const struct file_operations debugfs_log_fops = {
-	.owner		= THIS_MODULE,
-	.open		= debugfs_log_open,
-	.write		= debugfs_log_write,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int debugfs_usecount_show(struct seq_file *f, void *offset)
 {
 	struct vchiq_instance *instance = f->private;
@@ -205,19 +111,8 @@ void vchiq_debugfs_remove_instance(struct vchiq_instance *instance)
 
 void vchiq_debugfs_init(void)
 {
-	struct dentry *dir;
-	int i;
-
 	vchiq_dbg_dir = debugfs_create_dir("vchiq", NULL);
 	vchiq_dbg_clients = debugfs_create_dir("clients", vchiq_dbg_dir);
-
-	/* create an entry under <debugfs>/vchiq/log for each log category */
-	dir = debugfs_create_dir("log", vchiq_dbg_dir);
-
-	for (i = 0; i < ARRAY_SIZE(vchiq_debugfs_log_entries); i++)
-		debugfs_create_file(vchiq_debugfs_log_entries[i].name, 0644,
-				    dir, vchiq_debugfs_log_entries[i].plevel,
-				    &debugfs_log_fops);
 }
 
 /* remove all the debugfs entries */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 66bbfec332ba..cefbee12d0bc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -37,6 +37,8 @@ static const char *const ioctl_names[] = {
 	"CLOSE_DELIVERED"
 };
 
+static struct miscdevice vchiq_miscdev;
+
 static_assert(ARRAY_SIZE(ioctl_names) == (VCHIQ_IOC_MAX + 1));
 
 static void
@@ -47,9 +49,8 @@ user_service_free(void *userdata)
 
 static void close_delivered(struct user_service *user_service)
 {
-	vchiq_log_info(vchiq_arm_log_level,
-		       "%s(handle=%x)",
-		       __func__, user_service->service->handle);
+	dev_dbg(vchiq_miscdev.this_device, "%s(handle=%x)", __func__,
+		user_service->service->handle);
 
 	if (user_service->close_pending) {
 		/* Allow the underlying service to be culled */
@@ -235,8 +236,7 @@ static int vchiq_ioc_dequeue_message(struct vchiq_instance *instance,
 			spin_unlock(&msg_queue_spinlock);
 			DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
 			if (wait_for_completion_interruptible(&user_service->insert_event)) {
-				vchiq_log_info(vchiq_arm_log_level,
-					       "DEQUEUE_MESSAGE interrupted");
+				dev_dbg(vchiq_miscdev.this_device, "DEQUEUE_MESSAGE interrupted");
 				ret = -EINTR;
 				break;
 			}
@@ -271,9 +271,9 @@ static int vchiq_ioc_dequeue_message(struct vchiq_instance *instance,
 			ret = -EFAULT;
 		}
 	} else {
-		vchiq_log_error(vchiq_arm_log_level,
-				"header %pK: bufsize %x < size %x",
-				header, args->bufsize, header->size);
+		dev_err(vchiq_miscdev.this_device,
+			"header %pK: bufsize %x < size %x",
+			header, args->bufsize, header->size);
 		WARN(1, "invalid size\n");
 		ret = -EMSGSIZE;
 	}
@@ -318,13 +318,13 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		}
 		mutex_unlock(&instance->bulk_waiter_list_mutex);
 		if (!waiter) {
-			vchiq_log_error(vchiq_arm_log_level,
-					"no bulk_waiter found for pid %d", current->pid);
+			dev_err(vchiq_miscdev.this_device,
+				"no bulk_waiter found for pid %d", current->pid);
 			ret = -ESRCH;
 			goto out;
 		}
-		vchiq_log_info(vchiq_arm_log_level,
-			       "found bulk_waiter %pK for pid %d", waiter, current->pid);
+		dev_dbg(vchiq_miscdev.this_device,
+			"found bulk_waiter %pK for pid %d", waiter, current->pid);
 		userdata = &waiter->bulk_waiter;
 	} else {
 		userdata = args->userdata;
@@ -355,8 +355,8 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		mutex_lock(&instance->bulk_waiter_list_mutex);
 		list_add(&waiter->list, &instance->bulk_waiter_list);
 		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		vchiq_log_info(vchiq_arm_log_level,
-			       "saved bulk_waiter %pK for pid %d", waiter, current->pid);
+		dev_dbg(vchiq_miscdev.this_device,
+			"saved bulk_waiter %pK for pid %d", waiter, current->pid);
 
 		ret = put_user(mode_waiting, mode);
 	}
@@ -455,8 +455,7 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 		mutex_lock(&instance->completion_mutex);
 		if (rc) {
 			DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-			vchiq_log_info(vchiq_arm_log_level,
-				       "AWAIT_COMPLETION interrupted");
+			dev_dbg(vchiq_miscdev.this_device, "AWAIT_COMPLETION interrupted");
 			ret = -EINTR;
 			goto out;
 		}
@@ -501,10 +500,10 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 			msglen = header->size + sizeof(struct vchiq_header);
 			/* This must be a VCHIQ-style service */
 			if (args->msgbufsize < msglen) {
-				vchiq_log_error(vchiq_arm_log_level,
-						"header %pK: msgbufsize %x < msglen %x",
-						header, args->msgbufsize, msglen);
-						WARN(1, "invalid message size\n");
+				dev_err(vchiq_miscdev.this_device,
+					"header %pK: msgbufsize %x < msglen %x",
+					header, args->msgbufsize, msglen);
+					WARN(1, "invalid message size\n");
 				if (ret == 0)
 					ret = -EMSGSIZE;
 				break;
@@ -579,13 +578,13 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct vchiq_instance *instance = file->private_data;
 	enum vchiq_status status = VCHIQ_SUCCESS;
 	struct vchiq_service *service = NULL;
+	struct device *dev = vchiq_miscdev.this_device;
 	long ret = 0;
 	int i, rc;
 
-	vchiq_log_trace(vchiq_arm_log_level,
-			"%s - instance %pK, cmd %s, arg %lx", __func__, instance,
-			((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) && (_IOC_NR(cmd) <= VCHIQ_IOC_MAX)) ?
-			ioctl_names[_IOC_NR(cmd)] : "<invalid>", arg);
+	dev_dbg(dev, "%s - instance %pK, cmd %s, arg %lx", __func__, instance,
+		((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) && (_IOC_NR(cmd) <= VCHIQ_IOC_MAX)) ?
+		ioctl_names[_IOC_NR(cmd)] : "<invalid>", arg);
 
 	switch (cmd) {
 	case VCHIQ_IOC_SHUTDOWN:
@@ -618,9 +617,8 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 		rc = mutex_lock_killable(&instance->state->mutex);
 		if (rc) {
-			vchiq_log_error(vchiq_arm_log_level,
-					"vchiq: connect: could not lock mutex for state %d: %d",
-					instance->state->id, rc);
+			dev_err(dev, "vchiq: connect: could not lock mutex for state %d: %d",
+				instance->state->id, rc);
 			ret = -EINTR;
 			break;
 		}
@@ -630,8 +628,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (status == VCHIQ_SUCCESS)
 			instance->connected = 1;
 		else
-			vchiq_log_error(vchiq_arm_log_level,
-					"vchiq: could not connect: %d", status);
+			dev_err(dev, "vchiq: could not connect: %d", status);
 		break;
 
 	case VCHIQ_IOC_CREATE_SERVICE: {
@@ -700,11 +697,10 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				vchiq_use_service_internal(service) :
 				vchiq_release_service_internal(service);
 			if (ret) {
-				vchiq_log_error(vchiq_susp_log_level,
-						"%s: cmd %s returned error %ld for service %c%c%c%c:%03d",
-						__func__, (cmd == VCHIQ_IOC_USE_SERVICE) ?
-						"VCHIQ_IOC_USE_SERVICE" :
-						"VCHIQ_IOC_RELEASE_SERVICE",
+				dev_err(dev, "cmd %s returned error %ld for service %c%c%c%c:%03d",
+					(cmd == VCHIQ_IOC_USE_SERVICE) ?
+					"VCHIQ_IOC_USE_SERVICE" :
+					"VCHIQ_IOC_RELEASE_SERVICE",
 					ret,
 					VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
 					service->client_id);
@@ -869,15 +865,13 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 
 	if ((status == VCHIQ_SUCCESS) && (ret < 0) && (ret != -EINTR) && (ret != -EWOULDBLOCK))
-		vchiq_log_info(vchiq_arm_log_level,
-			       "  ioctl instance %pK, cmd %s -> status %d, %ld",
-			       instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
-			       ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);
+		dev_dbg(dev, "  ioctl instance %pK, cmd %s -> status %d, %ld",
+			instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
+			ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);
 	else
-		vchiq_log_trace(vchiq_arm_log_level,
-				"  ioctl instance %pK, cmd %s -> status %d, %ld",
-				instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
-				ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);
+		dev_dbg(dev, "  ioctl instance %pK, cmd %s -> status %d, %ld",
+			instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
+			ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);
 
 	return ret;
 }
@@ -1168,11 +1162,11 @@ static int vchiq_open(struct inode *inode, struct file *file)
 	struct vchiq_state *state = vchiq_get_state();
 	struct vchiq_instance *instance;
 
-	vchiq_log_info(vchiq_arm_log_level, "vchiq_open");
+	dev_dbg(vchiq_miscdev.this_device, "vchiq_open");
 
 	if (!state) {
-		vchiq_log_error(vchiq_arm_log_level,
-				"vchiq has no connection to VideoCore");
+		dev_err(vchiq_miscdev.this_device,
+			"vchiq has no connection to VideoCore");
 		return -ENOTCONN;
 	}
 
@@ -1204,8 +1198,8 @@ static int vchiq_release(struct inode *inode, struct file *file)
 	int ret = 0;
 	int i;
 
-	vchiq_log_info(vchiq_arm_log_level, "%s: instance=%lx", __func__,
-		       (unsigned long)instance);
+	dev_dbg(vchiq_miscdev.this_device, "%s: instance=%lx", __func__,
+		(unsigned long)instance);
 
 	if (!state) {
 		ret = -EPERM;

base-commit: 5fe7856ad59afc56a6ff35d091bfaddd1d4f4bce
-- 
2.35.1

