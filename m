Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7113B572266
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiGLSTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiGLSTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E8EAA44CC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657649986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HBVU4IspHDrnrcyIoqlnie5sQugFMOd8l1t9ZS54c+o=;
        b=N9WN4in2c1d+1JJm9DK3Nfj6Nlb8kEcm9qogmTkNgJJeS+LKNO0aUCOSBwhIjHkKMlIX4D
        CMLgOXdS39R03i/v/86fWkeFviYE8E7+lpFATNnAKclGdlwTWkxXSb+NBk3IwyB6GfriET
        54ZoYA3CZu14g6I/4dG8sNzqYNGQ7xo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-MtLyb6AgPyKh9VgzWV-G1g-1; Tue, 12 Jul 2022 14:19:43 -0400
X-MC-Unique: MtLyb6AgPyKh9VgzWV-G1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE749299E779;
        Tue, 12 Jul 2022 18:19:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.18.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B444414A7EA;
        Tue, 12 Jul 2022 18:19:31 +0000 (UTC)
From:   Joel Slebodnick <jslebodn@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Slebodnick <jslebodn@redhat.com>, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        athierry@redhat.com, gustavoars@kernel.org, keescook@chromium.org,
        stefan.wahren@i2se.com, gascoar@gmail.com, ojaswin98@gmail.com,
        len.baker@gmx.com, jakobkoschel@gmail.com,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, jsavitz@redhat.com
Subject: [PATCH] remove custom return values in vc04_services
Date:   Tue, 12 Jul 2022 14:19:28 -0400
Message-Id: <20220712181928.17547-1-jslebodn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all instances of enum vchiq_status from vc04_services and replace
them with regular linux error values.

VCHIQ_SUCCESS replaced with 0, VCHIQ_ERROR replaced with -EINVAL, and
VCHIQ_RETRY replaced (for the most part) with -EINTR as VCHIQ_RETRY
often is returned from an interruptable function call.

The exceptions to this are vchiq_send_remote_use() and
vchiq_send_remote_use_active() as they return a VCHIQ_RETRY but have
been changed to return -EINVAL instead of -EINTR. This is because when
the conn_state is VCHIQ_CONNSTATE_DISCONNECTED, the state is not valid
to continue on in the function

Signed-off-by: Joel Slebodnick <jslebodn@redhat.com>
---
 .../bcm2835-audio/bcm2835-vchiq.c             |  10 +-
 .../include/linux/raspberrypi/vchiq.h         |  67 +++---
 drivers/staging/vc04_services/interface/TODO  |   5 -
 .../interface/vchiq_arm/vchiq_arm.c           | 122 +++++-----
 .../interface/vchiq_arm/vchiq_arm.h           |  12 +-
 .../interface/vchiq_arm/vchiq_core.c          | 220 +++++++++---------
 .../interface/vchiq_arm/vchiq_core.h          |  18 +-
 .../interface/vchiq_arm/vchiq_dev.c           |  38 ++-
 .../interface/vchiq_arm/vchiq_ioctl.h         |   8 +-
 9 files changed, 238 insertions(+), 262 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index e429b33b4d39..e3c1362b4add 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -89,15 +89,15 @@ static int bcm2835_audio_send_simple(struct bcm2835_audio_instance *instance,
 	return bcm2835_audio_send_msg(instance, &m, wait);
 }
 
-static enum vchiq_status audio_vchi_callback(enum vchiq_reason reason,
-					     struct vchiq_header *header,
-					     unsigned int handle, void *userdata)
+static int audio_vchi_callback(enum vchiq_reason reason,
+			       struct vchiq_header *header,
+			       unsigned int handle, void *userdata)
 {
 	struct bcm2835_audio_instance *instance = vchiq_get_service_userdata(handle);
 	struct vc_audio_msg *m;
 
 	if (reason != VCHIQ_MESSAGE_AVAILABLE)
-		return VCHIQ_SUCCESS;
+		return 0;
 
 	m = (void *)header->data;
 	if (m->type == VC_AUDIO_MSG_TYPE_RESULT) {
@@ -115,7 +115,7 @@ static enum vchiq_status audio_vchi_callback(enum vchiq_reason reason,
 	}
 
 	vchiq_release_message(handle, header);
-	return VCHIQ_SUCCESS;
+	return 0;
 }
 
 static int
diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
index c93f2f3e87bb..81aa87654d3a 100644
--- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
+++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
@@ -17,12 +17,6 @@ enum vchiq_reason {
 	VCHIQ_BULK_RECEIVE_ABORTED    /* service, -, bulk_userdata */
 };
 
-enum vchiq_status {
-	VCHIQ_ERROR   = -1,
-	VCHIQ_SUCCESS = 0,
-	VCHIQ_RETRY   = 1
-};
-
 enum vchiq_bulk_mode {
 	VCHIQ_BULK_MODE_CALLBACK,
 	VCHIQ_BULK_MODE_BLOCKING,
@@ -55,10 +49,10 @@ struct vchiq_element {
 
 struct vchiq_service_base {
 	int fourcc;
-	enum vchiq_status (*callback)(enum vchiq_reason reason,
-				      struct vchiq_header *header,
-				      unsigned int handle,
-				      void *bulk_userdata);
+	int (*callback)(enum vchiq_reason reason,
+			struct vchiq_header *header,
+			unsigned int handle,
+			void *bulk_userdata);
 	void *userdata;
 };
 
@@ -71,10 +65,10 @@ struct vchiq_completion_data_kernel {
 
 struct vchiq_service_params_kernel {
 	int fourcc;
-	enum vchiq_status (*callback)(enum vchiq_reason reason,
-				      struct vchiq_header *header,
-				      unsigned int handle,
-				      void *bulk_userdata);
+	int (*callback)(enum vchiq_reason reason,
+			struct vchiq_header *header,
+			unsigned int handle,
+			void *bulk_userdata);
 	void *userdata;
 	short version;       /* Increment for non-trivial changes */
 	short version_min;   /* Update for incompatible changes */
@@ -82,29 +76,26 @@ struct vchiq_service_params_kernel {
 
 struct vchiq_instance;
 
-extern enum vchiq_status vchiq_initialise(struct vchiq_instance **pinstance);
-extern enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance);
-extern enum vchiq_status vchiq_connect(struct vchiq_instance *instance);
-extern enum vchiq_status vchiq_open_service(struct vchiq_instance *instance,
-	const struct vchiq_service_params_kernel *params,
-	unsigned int *pservice);
-extern enum vchiq_status vchiq_close_service(unsigned int service);
-extern enum vchiq_status vchiq_use_service(unsigned int service);
-extern enum vchiq_status vchiq_release_service(unsigned int service);
-extern void vchiq_msg_queue_push(unsigned int handle, struct vchiq_header *header);
-extern void           vchiq_release_message(unsigned int service,
-	struct vchiq_header *header);
-extern int vchiq_queue_kernel_message(unsigned int handle, void *data,
-				      unsigned int size);
-extern enum vchiq_status vchiq_bulk_transmit(unsigned int service,
-	const void *data, unsigned int size, void *userdata,
-	enum vchiq_bulk_mode mode);
-extern enum vchiq_status vchiq_bulk_receive(unsigned int service,
-	void *data, unsigned int size, void *userdata,
-	enum vchiq_bulk_mode mode);
-extern void *vchiq_get_service_userdata(unsigned int service);
-extern enum vchiq_status vchiq_get_peer_version(unsigned int handle,
-	short *peer_version);
-extern struct vchiq_header *vchiq_msg_hold(unsigned int handle);
+int vchiq_initialise(struct vchiq_instance **pinstance);
+int vchiq_shutdown(struct vchiq_instance *instance);
+int vchiq_connect(struct vchiq_instance *instance);
+int vchiq_open_service(struct vchiq_instance *instance,
+		       const struct vchiq_service_params_kernel *params,
+		       unsigned int *pservice);
+int vchiq_close_service(unsigned int service);
+int vchiq_use_service(unsigned int service);
+int vchiq_release_service(unsigned int service);
+void vchiq_msg_queue_push(unsigned int handle, struct vchiq_header *header);
+void vchiq_release_message(unsigned int service, struct vchiq_header *header);
+int vchiq_queue_kernel_message(unsigned int handle, void *data,
+			       unsigned int size);
+int vchiq_bulk_transmit(unsigned int service, const void *data,
+			unsigned int size, void *userdata,
+			enum vchiq_bulk_mode mode);
+int vchiq_bulk_receive(unsigned int service, void *data, unsigned int size,
+		       void *userdata, enum vchiq_bulk_mode mode);
+void *vchiq_get_service_userdata(unsigned int service);
+int vchiq_get_peer_version(unsigned int handle, short *peer_version);
+struct vchiq_header *vchiq_msg_hold(unsigned int handle);
 
 #endif /* VCHIQ_H */
diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
index 97085a0b3223..6d9d4a800aa7 100644
--- a/drivers/staging/vc04_services/interface/TODO
+++ b/drivers/staging/vc04_services/interface/TODO
@@ -40,11 +40,6 @@ beneficial to go over all of them and, if correct, comment on their merits.
 Extra points to whomever confidently reviews the remote_event_*() family of
 functions.
 
-* Get rid of custom function return values
-
-Most functions use a custom set of return values, we should force proper Linux
-error numbers. Special care is needed for VCHIQ_RETRY.
-
 * Reformat core code with more sane indentations
 
 The code follows the 80 characters limitation yet tends to go 3 or 4 levels of
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 0596ac61e286..c87b2ef5a59c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -152,7 +152,7 @@ static struct device *g_dev;
 
 static DEFINE_SEMAPHORE(g_free_fragments_mutex);
 
-static enum vchiq_status
+static int
 vchiq_blocking_bulk_transfer(unsigned int handle, void *data,
 			     unsigned int size, enum vchiq_bulk_dir dir);
 
@@ -720,13 +720,13 @@ void free_bulk_waiter(struct vchiq_instance *instance)
 	}
 }
 
-enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance)
+int vchiq_shutdown(struct vchiq_instance *instance)
 {
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 	struct vchiq_state *state = instance->state;
 
 	if (mutex_lock_killable(&state->mutex))
-		return VCHIQ_RETRY;
+		return -EINTR;
 
 	/* Remove all services */
 	vchiq_shutdown_internal(state, instance);
@@ -747,19 +747,19 @@ static int vchiq_is_connected(struct vchiq_instance *instance)
 	return instance->connected;
 }
 
-enum vchiq_status vchiq_connect(struct vchiq_instance *instance)
+int vchiq_connect(struct vchiq_instance *instance)
 {
-	enum vchiq_status status;
+	int status;
 	struct vchiq_state *state = instance->state;
 
 	if (mutex_lock_killable(&state->mutex)) {
 		vchiq_log_trace(vchiq_core_log_level, "%s: call to mutex_lock failed", __func__);
-		status = VCHIQ_RETRY;
+		status = -EINTR;
 		goto failed;
 	}
 	status = vchiq_connect_internal(state, instance);
 
-	if (status == VCHIQ_SUCCESS)
+	if (!status)
 		instance->connected = 1;
 
 	mutex_unlock(&state->mutex);
@@ -771,12 +771,12 @@ enum vchiq_status vchiq_connect(struct vchiq_instance *instance)
 }
 EXPORT_SYMBOL(vchiq_connect);
 
-static enum vchiq_status
+static int
 vchiq_add_service(struct vchiq_instance *instance,
 		  const struct vchiq_service_params_kernel *params,
 		  unsigned int *phandle)
 {
-	enum vchiq_status status;
+	int status;
 	struct vchiq_state *state = instance->state;
 	struct vchiq_service *service = NULL;
 	int srvstate;
@@ -791,9 +791,9 @@ vchiq_add_service(struct vchiq_instance *instance,
 
 	if (service) {
 		*phandle = service->handle;
-		status = VCHIQ_SUCCESS;
+		status = 0;
 	} else {
-		status = VCHIQ_ERROR;
+		status = -EINVAL;
 	}
 
 	vchiq_log_trace(vchiq_core_log_level, "%s(%p): returning %d", __func__, instance, status);
@@ -801,12 +801,12 @@ vchiq_add_service(struct vchiq_instance *instance,
 	return status;
 }
 
-enum vchiq_status
+int
 vchiq_open_service(struct vchiq_instance *instance,
 		   const struct vchiq_service_params_kernel *params,
 		   unsigned int *phandle)
 {
-	enum vchiq_status   status = VCHIQ_ERROR;
+	int    status = -EINVAL;
 	struct vchiq_state   *state = instance->state;
 	struct vchiq_service *service = NULL;
 
@@ -820,7 +820,7 @@ vchiq_open_service(struct vchiq_instance *instance,
 	if (service) {
 		*phandle = service->handle;
 		status = vchiq_open_service_internal(service, current->pid);
-		if (status != VCHIQ_SUCCESS) {
+		if (status) {
 			vchiq_remove_service(service->handle);
 			*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
 		}
@@ -833,11 +833,11 @@ vchiq_open_service(struct vchiq_instance *instance,
 }
 EXPORT_SYMBOL(vchiq_open_service);
 
-enum vchiq_status
+int
 vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
 		    void *userdata, enum vchiq_bulk_mode mode)
 {
-	enum vchiq_status status;
+	int status;
 
 	while (1) {
 		switch (mode) {
@@ -853,15 +853,15 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
 							      VCHIQ_BULK_TRANSMIT);
 			break;
 		default:
-			return VCHIQ_ERROR;
+			return -EINVAL;
 		}
 
 		/*
-		 * vchiq_*_bulk_transfer() may return VCHIQ_RETRY, so we need
+		 * vchiq_*_bulk_transfer() may be interrupted, so we need
 		 * to implement a retry mechanism since this function is
 		 * supposed to block until queued
 		 */
-		if (status != VCHIQ_RETRY)
+		if (status != -EINTR)
 			break;
 
 		msleep(1);
@@ -871,11 +871,11 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
 }
 EXPORT_SYMBOL(vchiq_bulk_transmit);
 
-enum vchiq_status vchiq_bulk_receive(unsigned int handle, void *data,
-				     unsigned int size, void *userdata,
-				     enum vchiq_bulk_mode mode)
+int vchiq_bulk_receive(unsigned int handle, void *data,
+		       unsigned int size, void *userdata,
+		       enum vchiq_bulk_mode mode)
 {
-	enum vchiq_status status;
+	int status;
 
 	while (1) {
 		switch (mode) {
@@ -890,15 +890,15 @@ enum vchiq_status vchiq_bulk_receive(unsigned int handle, void *data,
 							      VCHIQ_BULK_RECEIVE);
 			break;
 		default:
-			return VCHIQ_ERROR;
+			return -EINVAL;
 		}
 
 		/*
-		 * vchiq_*_bulk_transfer() may return VCHIQ_RETRY, so we need
+		 * vchiq_*_bulk_transfer() may be interrupted, so we need
 		 * to implement a retry mechanism since this function is
 		 * supposed to block until queued
 		 */
-		if (status != VCHIQ_RETRY)
+		if (status != -EINTR)
 			break;
 
 		msleep(1);
@@ -908,18 +908,18 @@ enum vchiq_status vchiq_bulk_receive(unsigned int handle, void *data,
 }
 EXPORT_SYMBOL(vchiq_bulk_receive);
 
-static enum vchiq_status
+static int
 vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
 			     enum vchiq_bulk_dir dir)
 {
 	struct vchiq_instance *instance;
 	struct vchiq_service *service;
-	enum vchiq_status status;
+	int status;
 	struct bulk_waiter_node *waiter = NULL, *iter;
 
 	service = find_service_by_handle(handle);
 	if (!service)
-		return VCHIQ_ERROR;
+		return -EINVAL;
 
 	instance = service->instance;
 
@@ -955,14 +955,14 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
 		waiter = kzalloc(sizeof(*waiter), GFP_KERNEL);
 		if (!waiter) {
 			vchiq_log_error(vchiq_core_log_level, "%s - out of memory", __func__);
-			return VCHIQ_ERROR;
+			return -EINVAL;
 		}
 	}
 
 	status = vchiq_bulk_transfer(handle, data, NULL, size,
 				     &waiter->bulk_waiter,
 				     VCHIQ_BULK_MODE_BLOCKING, dir);
-	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) || !waiter->bulk_waiter.bulk) {
+	if ((status != -EINTR) || fatal_signal_pending(current) || !waiter->bulk_waiter.bulk) {
 		struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
 
 		if (bulk) {
@@ -984,7 +984,7 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
 	return status;
 }
 
-static enum vchiq_status
+static int
 add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 	       struct vchiq_header *header, struct user_service *user_service,
 	       void *bulk_userdata)
@@ -1002,10 +1002,10 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 		DEBUG_COUNT(COMPLETION_QUEUE_FULL_COUNT);
 		if (wait_for_completion_interruptible(&instance->remove_event)) {
 			vchiq_log_info(vchiq_arm_log_level, "service_callback interrupted");
-			return VCHIQ_RETRY;
+			return -EINTR;
 		} else if (instance->closing) {
 			vchiq_log_info(vchiq_arm_log_level, "service_callback closing");
-			return VCHIQ_SUCCESS;
+			return 0;
 		}
 		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 	}
@@ -1042,10 +1042,10 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 
 	complete(&instance->insert_event);
 
-	return VCHIQ_SUCCESS;
+	return 0;
 }
 
-enum vchiq_status
+int
 service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 		 unsigned int handle, void *bulk_userdata)
 {
@@ -1068,7 +1068,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 	service = handle_to_service(handle);
 	if (WARN_ON(!service)) {
 		rcu_read_unlock();
-		return VCHIQ_SUCCESS;
+		return 0;
 	}
 
 	user_service = (struct user_service *)service->base.userdata;
@@ -1076,7 +1076,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 
 	if (!instance || instance->closing) {
 		rcu_read_unlock();
-		return VCHIQ_SUCCESS;
+		return 0;
 	}
 
 	/*
@@ -1106,14 +1106,14 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 			 */
 			if ((user_service->message_available_pos -
 				instance->completion_remove) < 0) {
-				enum vchiq_status status;
+				int status;
 
 				vchiq_log_info(vchiq_arm_log_level,
 					       "Inserting extra MESSAGE_AVAILABLE");
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				status = add_completion(instance, reason, NULL, user_service,
 							bulk_userdata);
-				if (status != VCHIQ_SUCCESS) {
+				if (status) {
 					DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 					vchiq_service_put(service);
 					return status;
@@ -1125,12 +1125,12 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 				vchiq_log_info(vchiq_arm_log_level, "%s interrupted", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				vchiq_service_put(service);
-				return VCHIQ_RETRY;
+				return -EINTR;
 			} else if (instance->closing) {
 				vchiq_log_info(vchiq_arm_log_level, "%s closing", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				vchiq_service_put(service);
-				return VCHIQ_ERROR;
+				return -EINVAL;
 			}
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 			spin_lock(&msg_queue_spinlock);
@@ -1161,7 +1161,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 	vchiq_service_put(service);
 
 	if (skip_completion)
-		return VCHIQ_SUCCESS;
+		return 0;
 
 	return add_completion(instance, reason, header, user_service,
 		bulk_userdata);
@@ -1317,7 +1317,7 @@ vchiq_get_state(void)
  * Autosuspend related functionality
  */
 
-static enum vchiq_status
+static int
 vchiq_keepalive_vchiq_callback(enum vchiq_reason reason,
 			       struct vchiq_header *header,
 			       unsigned int service_user, void *bulk_user)
@@ -1332,7 +1332,7 @@ vchiq_keepalive_thread_func(void *v)
 	struct vchiq_state *state = (struct vchiq_state *)v;
 	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
 
-	enum vchiq_status status;
+	int status;
 	struct vchiq_instance *instance;
 	unsigned int ka_handle;
 	int ret;
@@ -1352,14 +1352,14 @@ vchiq_keepalive_thread_func(void *v)
 	}
 
 	status = vchiq_connect(instance);
-	if (status != VCHIQ_SUCCESS) {
+	if (status) {
 		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_connect failed %d", __func__,
 				status);
 		goto shutdown;
 	}
 
 	status = vchiq_add_service(instance, &params, &ka_handle);
-	if (status != VCHIQ_SUCCESS) {
+	if (status) {
 		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_open_service failed %d", __func__,
 				status);
 		goto shutdown;
@@ -1388,14 +1388,14 @@ vchiq_keepalive_thread_func(void *v)
 		while (uc--) {
 			atomic_inc(&arm_state->ka_use_ack_count);
 			status = vchiq_use_service(ka_handle);
-			if (status != VCHIQ_SUCCESS) {
+			if (status) {
 				vchiq_log_error(vchiq_susp_log_level,
 						"%s vchiq_use_service error %d", __func__, status);
 			}
 		}
 		while (rc--) {
 			status = vchiq_release_service(ka_handle);
-			if (status != VCHIQ_SUCCESS) {
+			if (status) {
 				vchiq_log_error(vchiq_susp_log_level,
 						"%s vchiq_release_service error %d", __func__,
 						status);
@@ -1448,13 +1448,13 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 	write_unlock_bh(&arm_state->susp_res_lock);
 
 	if (!ret) {
-		enum vchiq_status status = VCHIQ_SUCCESS;
+		int status = 0;
 		long ack_cnt = atomic_xchg(&arm_state->ka_use_ack_count, 0);
 
-		while (ack_cnt && (status == VCHIQ_SUCCESS)) {
+		while (ack_cnt && (!status)) {
 			/* Send the use notify to videocore */
 			status = vchiq_send_remote_use_active(state);
-			if (status == VCHIQ_SUCCESS)
+			if (!status)
 				ack_cnt--;
 			else
 				atomic_add(ack_cnt, &arm_state->ka_use_ack_count);
@@ -1589,10 +1589,10 @@ vchiq_instance_set_trace(struct vchiq_instance *instance, int trace)
 	instance->trace = (trace != 0);
 }
 
-enum vchiq_status
+int
 vchiq_use_service(unsigned int handle)
 {
-	enum vchiq_status ret = VCHIQ_ERROR;
+	int ret = -EINVAL;
 	struct vchiq_service *service = find_service_by_handle(handle);
 
 	if (service) {
@@ -1603,10 +1603,10 @@ vchiq_use_service(unsigned int handle)
 }
 EXPORT_SYMBOL(vchiq_use_service);
 
-enum vchiq_status
+int
 vchiq_release_service(unsigned int handle)
 {
-	enum vchiq_status ret = VCHIQ_ERROR;
+	int ret = -EINVAL;
 	struct vchiq_service *service = find_service_by_handle(handle);
 
 	if (service) {
@@ -1697,11 +1697,11 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 	kfree(service_data);
 }
 
-enum vchiq_status
+int
 vchiq_check_service(struct vchiq_service *service)
 {
 	struct vchiq_arm_state *arm_state;
-	enum vchiq_status ret = VCHIQ_ERROR;
+	int ret = -EINVAL;
 
 	if (!service || !service->state)
 		goto out;
@@ -1710,10 +1710,10 @@ vchiq_check_service(struct vchiq_service *service)
 
 	read_lock_bh(&arm_state->susp_res_lock);
 	if (service->service_use_count)
-		ret = VCHIQ_SUCCESS;
+		ret = 0;
 	read_unlock_bh(&arm_state->susp_res_lock);
 
-	if (ret == VCHIQ_ERROR) {
+	if (ret) {
 		vchiq_log_error(vchiq_susp_log_level,
 				"%s ERROR - %c%c%c%c:%d service count %d, state count %d", __func__,
 				VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc), service->client_id,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 2aa46b119a46..03c2780594ea 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -85,13 +85,13 @@ extern struct vchiq_state g_state;
 extern struct vchiq_state *
 vchiq_get_state(void);
 
-enum vchiq_status
+int
 vchiq_use_service(unsigned int handle);
 
-extern enum vchiq_status
+extern int
 vchiq_release_service(unsigned int handle);
 
-extern enum vchiq_status
+extern int
 vchiq_check_service(struct vchiq_service *service);
 
 extern void
@@ -100,10 +100,10 @@ vchiq_dump_platform_use_state(struct vchiq_state *state);
 extern void
 vchiq_dump_service_use_state(struct vchiq_state *state);
 
-extern enum vchiq_status
+extern int
 vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 		   enum USE_TYPE_E use_type);
-extern enum vchiq_status
+extern int
 vchiq_release_internal(struct vchiq_state *state,
 		       struct vchiq_service *service);
 
@@ -137,7 +137,7 @@ static inline int vchiq_register_chrdev(struct device *parent) { return 0; }
 
 #endif /* IS_ENABLED(CONFIG_VCHIQ_CDEV) */
 
-extern enum vchiq_status
+extern int
 service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 		 unsigned int handle, void *bulk_userdata);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 8f99272dbd6f..3b08560b52a0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -457,21 +457,21 @@ mark_service_closing(struct vchiq_service *service)
 	mark_service_closing_internal(service, 0);
 }
 
-static inline enum vchiq_status
+static inline int
 make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 		      struct vchiq_header *header, void *bulk_userdata)
 {
-	enum vchiq_status status;
+	int status;
 
 	vchiq_log_trace(vchiq_core_log_level, "%d: callback:%d (%s, %pK, %pK)",
 			service->state->id, service->localport, reason_names[reason],
 			header, bulk_userdata);
 	status = service->base.callback(reason, header, service->handle, bulk_userdata);
-	if (status == VCHIQ_ERROR) {
+	if (status && (status != -EINTR)) {
 		vchiq_log_warning(vchiq_core_log_level,
 				  "%d: ignoring ERROR from callback to service %x",
 				  service->state->id, service->handle);
-		status = VCHIQ_SUCCESS;
+		status = 0;
 	}
 
 	if (reason != VCHIQ_MESSAGE_AVAILABLE)
@@ -891,7 +891,7 @@ copy_message_data(ssize_t (*copy_callback)(void *context, void *dest, size_t off
 }
 
 /* Called by the slot handler and application threads */
-static enum vchiq_status
+static int
 queue_message(struct vchiq_state *state, struct vchiq_service *service,
 	      int msgid,
 	      ssize_t (*copy_callback)(void *context, void *dest,
@@ -913,7 +913,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 
 	if (!(flags & QMFLAGS_NO_MUTEX_LOCK) &&
 	    mutex_lock_killable(&state->slot_mutex))
-		return VCHIQ_RETRY;
+		return -EINTR;
 
 	if (type == VCHIQ_MSG_DATA) {
 		int tx_end_index;
@@ -921,7 +921,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		if (!service) {
 			WARN(1, "%s: service is NULL\n", __func__);
 			mutex_unlock(&state->slot_mutex);
-			return VCHIQ_ERROR;
+			return -EINVAL;
 		}
 
 		WARN_ON(flags & (QMFLAGS_NO_MUTEX_LOCK |
@@ -930,7 +930,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		if (service->closing) {
 			/* The service has been closed */
 			mutex_unlock(&state->slot_mutex);
-			return VCHIQ_ERROR;
+			return -EINVAL;
 		}
 
 		quota = &state->service_quotas[service->localport];
@@ -954,7 +954,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			mutex_unlock(&state->slot_mutex);
 
 			if (wait_for_completion_interruptible(&state->data_quota_event))
-				return VCHIQ_RETRY;
+				return -EINTR;
 
 			mutex_lock(&state->slot_mutex);
 			spin_lock(&quota_spinlock);
@@ -978,15 +978,15 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			VCHIQ_SERVICE_STATS_INC(service, quota_stalls);
 			mutex_unlock(&state->slot_mutex);
 			if (wait_for_completion_interruptible(&quota->quota_event))
-				return VCHIQ_RETRY;
+				return -EINTR;
 			if (service->closing)
-				return VCHIQ_ERROR;
+				return -EINVAL;
 			if (mutex_lock_killable(&state->slot_mutex))
-				return VCHIQ_RETRY;
+				return -EINTR;
 			if (service->srvstate != VCHIQ_SRVSTATE_OPEN) {
 				/* The service has been closed */
 				mutex_unlock(&state->slot_mutex);
-				return VCHIQ_ERROR;
+				return -EINVAL;
 			}
 			spin_lock(&quota_spinlock);
 			tx_end_index = SLOT_QUEUE_INDEX_FROM_POS(state->local_tx_pos + stride - 1);
@@ -1006,7 +1006,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		 */
 		if (!(flags & QMFLAGS_NO_MUTEX_LOCK))
 			mutex_unlock(&state->slot_mutex);
-		return VCHIQ_RETRY;
+		return -EINTR;
 	}
 
 	if (type == VCHIQ_MSG_DATA) {
@@ -1028,7 +1028,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		if (callback_result < 0) {
 			mutex_unlock(&state->slot_mutex);
 			VCHIQ_SERVICE_STATS_INC(service, error_count);
-			return VCHIQ_ERROR;
+			return -EINVAL;
 		}
 
 		if (SRVTRACE_ENABLED(service,
@@ -1126,11 +1126,11 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 
 	remote_event_signal(&state->remote->trigger);
 
-	return VCHIQ_SUCCESS;
+	return 0;
 }
 
 /* Called by the slot handler and application threads */
-static enum vchiq_status
+static int
 queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 		   int msgid,
 		   ssize_t (*copy_callback)(void *context, void *dest,
@@ -1145,7 +1145,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 
 	if (VCHIQ_MSG_TYPE(msgid) != VCHIQ_MSG_RESUME &&
 	    mutex_lock_killable(&state->sync_mutex))
-		return VCHIQ_RETRY;
+		return -EINTR;
 
 	remote_event_wait(&state->sync_release_event, &local->sync_release);
 
@@ -1175,7 +1175,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 	if (callback_result < 0) {
 		mutex_unlock(&state->slot_mutex);
 		VCHIQ_SERVICE_STATS_INC(service, error_count);
-		return VCHIQ_ERROR;
+		return -EINVAL;
 	}
 
 	if (service) {
@@ -1213,7 +1213,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 	if (VCHIQ_MSG_TYPE(msgid) != VCHIQ_MSG_PAUSE)
 		mutex_unlock(&state->sync_mutex);
 
-	return VCHIQ_SUCCESS;
+	return 0;
 }
 
 static inline void
@@ -1289,11 +1289,11 @@ get_bulk_reason(struct vchiq_bulk *bulk)
 }
 
 /* Called by the slot handler - don't hold the bulk mutex */
-static enum vchiq_status
+static int
 notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 	     int retry_poll)
 {
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 
 	vchiq_log_trace(vchiq_core_log_level, "%d: nb:%d %cx - p=%x rn=%x r=%x", service->state->id,
 			service->localport, (queue == &service->bulk_tx) ? 't' : 'r',
@@ -1338,7 +1338,7 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 						get_bulk_reason(bulk);
 				status = make_service_callback(service, reason,	NULL,
 							       bulk->userdata);
-				if (status == VCHIQ_RETRY)
+				if (status == -EINTR)
 					break;
 			}
 		}
@@ -1347,9 +1347,9 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 		complete(&service->bulk_remove_event);
 	}
 	if (!retry_poll)
-		status = VCHIQ_SUCCESS;
+		status = 0;
 
-	if (status == VCHIQ_RETRY)
+	if (status == -EINTR)
 		request_poll(service->state, service, (queue == &service->bulk_tx) ?
 			     VCHIQ_POLL_TXNOTIFY : VCHIQ_POLL_RXNOTIFY);
 
@@ -1388,13 +1388,12 @@ poll_services_of_group(struct vchiq_state *state, int group)
 			 */
 			service->public_fourcc = VCHIQ_FOURCC_INVALID;
 
-			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD) !=
-							 VCHIQ_SUCCESS)
+			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD))
 				request_poll(state, service, VCHIQ_POLL_REMOVE);
 		} else if (service_flags & BIT(VCHIQ_POLL_TERMINATE)) {
 			vchiq_log_info(vchiq_core_log_level, "%d: ps - terminate %d<->%d",
 				       state->id, service->localport, service->remoteport);
-			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD) != VCHIQ_SUCCESS)
+			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD))
 				request_poll(state, service, VCHIQ_POLL_TERMINATE);
 		}
 		if (service_flags & BIT(VCHIQ_POLL_TXNOTIFY))
@@ -1517,14 +1516,14 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 		/* Acknowledge the OPEN */
 		if (service->sync) {
 			if (queue_message_sync(state, NULL, openack_id, memcpy_copy_callback,
-					       &ack_payload, sizeof(ack_payload), 0) == VCHIQ_RETRY)
+					       &ack_payload, sizeof(ack_payload), 0) == -EINTR)
 				goto bail_not_ready;
 
 			/* The service is now open */
 			set_service_state(service, VCHIQ_SRVSTATE_OPENSYNC);
 		} else {
 			if (queue_message(state, NULL, openack_id, memcpy_copy_callback,
-					  &ack_payload, sizeof(ack_payload), 0) == VCHIQ_RETRY)
+					  &ack_payload, sizeof(ack_payload), 0) == -EINTR)
 				goto bail_not_ready;
 
 			/* The service is now open */
@@ -1539,7 +1538,7 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 fail_open:
 	/* No available service, or an invalid request - send a CLOSE */
 	if (queue_message(state, NULL, MAKE_CLOSE(0, VCHIQ_MSG_SRCPORT(msgid)),
-			  NULL, NULL, 0, 0) == VCHIQ_RETRY)
+			  NULL, NULL, 0, 0) == -EINTR)
 		goto bail_not_ready;
 
 	return 1;
@@ -1678,7 +1677,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 
 		mark_service_closing_internal(service, 1);
 
-		if (vchiq_close_service_internal(service, CLOSE_RECVD) == VCHIQ_RETRY)
+		if (vchiq_close_service_internal(service, CLOSE_RECVD) == -EINTR)
 			goto bail_not_ready;
 
 		vchiq_log_info(vchiq_core_log_level, "Close Service %c%c%c%c s:%u d:%d",
@@ -1695,7 +1694,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			claim_slot(state->rx_info);
 			DEBUG_TRACE(PARSE_LINE);
 			if (make_service_callback(service, VCHIQ_MESSAGE_AVAILABLE, header,
-						  NULL) == VCHIQ_RETRY) {
+						  NULL) == -EINTR) {
 				DEBUG_TRACE(PARSE_LINE);
 				goto bail_not_ready;
 			}
@@ -1793,7 +1792,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		if (state->conn_state != VCHIQ_CONNSTATE_PAUSE_SENT) {
 			/* Send a PAUSE in response */
 			if (queue_message(state, NULL, MAKE_PAUSE, NULL, NULL, 0,
-					  QMFLAGS_NO_MUTEX_UNLOCK) == VCHIQ_RETRY)
+					  QMFLAGS_NO_MUTEX_UNLOCK) == -EINTR)
 				goto bail_not_ready;
 		}
 		/* At this point slot_mutex is held */
@@ -1910,7 +1909,7 @@ handle_poll(struct vchiq_state *state)
 
 	case VCHIQ_CONNSTATE_PAUSING:
 		if (queue_message(state, NULL, MAKE_PAUSE, NULL, NULL, 0,
-				  QMFLAGS_NO_MUTEX_UNLOCK) != VCHIQ_RETRY) {
+				  QMFLAGS_NO_MUTEX_UNLOCK) != -EINTR) {
 			vchiq_set_conn_state(state, VCHIQ_CONNSTATE_PAUSE_SENT);
 		} else {
 			/* Retry later */
@@ -1920,7 +1919,7 @@ handle_poll(struct vchiq_state *state)
 
 	case VCHIQ_CONNSTATE_RESUMING:
 		if (queue_message(state, NULL, MAKE_RESUME, NULL, NULL, 0,
-				  QMFLAGS_NO_MUTEX_LOCK) != VCHIQ_RETRY) {
+				  QMFLAGS_NO_MUTEX_LOCK) != -EINTR) {
 			vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTED);
 		} else {
 			/*
@@ -2074,9 +2073,9 @@ sync_func(void *v)
 			if ((service->remoteport == remoteport) &&
 			    (service->srvstate == VCHIQ_SRVSTATE_OPENSYNC)) {
 				if (make_service_callback(service, VCHIQ_MESSAGE_AVAILABLE, header,
-							  NULL) == VCHIQ_RETRY)
+							  NULL) == -EINTR)
 					vchiq_log_error(vchiq_sync_log_level,
-							"synchronous callback to service %d returns VCHIQ_RETRY",
+							"synchronous callback to service %d has been interrupted",
 							localport);
 			}
 			break;
@@ -2478,7 +2477,7 @@ vchiq_add_service_internal(struct vchiq_state *state,
 	return service;
 }
 
-enum vchiq_status
+int
 vchiq_open_service_internal(struct vchiq_service *service, int client_id)
 {
 	struct vchiq_open_payload payload = {
@@ -2487,7 +2486,7 @@ vchiq_open_service_internal(struct vchiq_service *service, int client_id)
 		service->version,
 		service->version_min
 	};
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 
 	service->client_id = client_id;
 	vchiq_use_service_internal(service);
@@ -2498,12 +2497,12 @@ vchiq_open_service_internal(struct vchiq_service *service, int client_id)
 			       sizeof(payload),
 			       QMFLAGS_IS_BLOCKING);
 
-	if (status != VCHIQ_SUCCESS)
+	if (status)
 		return status;
 
 	/* Wait for the ACK/NAK */
 	if (wait_for_completion_interruptible(&service->remove_event)) {
-		status = VCHIQ_RETRY;
+		status = -EINTR;
 		vchiq_release_service_internal(service);
 	} else if ((service->srvstate != VCHIQ_SRVSTATE_OPEN) &&
 		   (service->srvstate != VCHIQ_SRVSTATE_OPENSYNC)) {
@@ -2513,11 +2512,10 @@ vchiq_open_service_internal(struct vchiq_service *service, int client_id)
 					service->state->id,
 					srvstate_names[service->srvstate],
 					kref_read(&service->ref_count));
-		status = VCHIQ_ERROR;
+		status = -EINVAL;
 		VCHIQ_SERVICE_STATS_INC(service, error_count);
 		vchiq_release_service_internal(service);
 	}
-
 	return status;
 }
 
@@ -2584,7 +2582,7 @@ release_service_messages(struct vchiq_service *service)
 static int
 do_abort_bulks(struct vchiq_service *service)
 {
-	enum vchiq_status status;
+	int status;
 
 	/* Abort any outstanding bulk transfers */
 	if (mutex_lock_killable(&service->bulk_mutex))
@@ -2594,17 +2592,17 @@ do_abort_bulks(struct vchiq_service *service)
 	mutex_unlock(&service->bulk_mutex);
 
 	status = notify_bulks(service, &service->bulk_tx, NO_RETRY_POLL);
-	if (status != VCHIQ_SUCCESS)
+	if (status)
 		return 0;
 
 	status = notify_bulks(service, &service->bulk_rx, NO_RETRY_POLL);
-	return (status == VCHIQ_SUCCESS);
+	return (!status);
 }
 
-static enum vchiq_status
+static int
 close_service_complete(struct vchiq_service *service, int failstate)
 {
-	enum vchiq_status status;
+	int status;
 	int is_server = (service->public_fourcc != VCHIQ_FOURCC_INVALID);
 	int newstate;
 
@@ -2631,12 +2629,12 @@ close_service_complete(struct vchiq_service *service, int failstate)
 		vchiq_log_error(vchiq_core_log_level, "%s(%x) called in state %s", __func__,
 				service->handle, srvstate_names[service->srvstate]);
 		WARN(1, "%s in unexpected state\n", __func__);
-		return VCHIQ_ERROR;
+		return -EINVAL;
 	}
 
 	status = make_service_callback(service, VCHIQ_SERVICE_CLOSED, NULL, NULL);
 
-	if (status != VCHIQ_RETRY) {
+	if (status != -EINTR) {
 		int uc = service->service_use_count;
 		int i;
 		/* Complete the close process */
@@ -2661,16 +2659,15 @@ close_service_complete(struct vchiq_service *service, int failstate)
 	} else {
 		set_service_state(service, failstate);
 	}
-
 	return status;
 }
 
 /* Called by the slot handler */
-enum vchiq_status
+int
 vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 {
 	struct vchiq_state *state = service->state;
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 	int is_server = (service->public_fourcc != VCHIQ_FOURCC_INVALID);
 	int close_id = MAKE_CLOSE(service->localport,
 				  VCHIQ_MSG_DSTPORT(service->remoteport));
@@ -2688,7 +2685,7 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 					__func__, srvstate_names[service->srvstate]);
 		} else if (is_server) {
 			if (service->srvstate == VCHIQ_SRVSTATE_LISTENING) {
-				status = VCHIQ_ERROR;
+				status = -EINVAL;
 			} else {
 				service->client_id = 0;
 				service->remoteport = VCHIQ_PORT_FREE;
@@ -2717,16 +2714,16 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 	case VCHIQ_SRVSTATE_OPEN:
 		if (close_recvd) {
 			if (!do_abort_bulks(service))
-				status = VCHIQ_RETRY;
+				status = -EINTR;
 		}
 
 		release_service_messages(service);
 
-		if (status == VCHIQ_SUCCESS)
+		if (!status)
 			status = queue_message(state, service, close_id, NULL,
 					       NULL, 0, QMFLAGS_NO_MUTEX_UNLOCK);
 
-		if (status != VCHIQ_SUCCESS) {
+		if (status) {
 			if (service->srvstate == VCHIQ_SRVSTATE_OPENSYNC)
 				mutex_unlock(&state->sync_mutex);
 			break;
@@ -2756,11 +2753,11 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 			break;
 
 		if (!do_abort_bulks(service)) {
-			status = VCHIQ_RETRY;
+			status = -EINTR;
 			break;
 		}
 
-		if (status == VCHIQ_SUCCESS)
+		if (!status)
 			status = close_service_complete(service, VCHIQ_SRVSTATE_CLOSERECVD);
 		break;
 
@@ -2824,7 +2821,7 @@ vchiq_free_service_internal(struct vchiq_service *service)
 	vchiq_service_put(service);
 }
 
-enum vchiq_status
+int
 vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instance)
 {
 	struct vchiq_service *service;
@@ -2840,21 +2837,21 @@ vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instanc
 
 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED) {
 		if (queue_message(state, NULL, MAKE_CONNECT, NULL, NULL, 0,
-				  QMFLAGS_IS_BLOCKING) == VCHIQ_RETRY)
-			return VCHIQ_RETRY;
+				  QMFLAGS_IS_BLOCKING) == -EINTR)
+			return -EINTR;
 
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTING);
 	}
 
 	if (state->conn_state == VCHIQ_CONNSTATE_CONNECTING) {
 		if (wait_for_completion_interruptible(&state->connect))
-			return VCHIQ_RETRY;
+			return -EINTR;
 
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTED);
 		complete(&state->connect);
 	}
 
-	return VCHIQ_SUCCESS;
+	return 0;
 }
 
 void
@@ -2871,15 +2868,15 @@ vchiq_shutdown_internal(struct vchiq_state *state, struct vchiq_instance *instan
 	}
 }
 
-enum vchiq_status
+int
 vchiq_close_service(unsigned int handle)
 {
 	/* Unregister the service */
 	struct vchiq_service *service = find_service_by_handle(handle);
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 
 	if (!service)
-		return VCHIQ_ERROR;
+		return -EINVAL;
 
 	vchiq_log_info(vchiq_core_log_level, "%d: close_service:%d",
 		       service->state->id, service->localport);
@@ -2888,14 +2885,14 @@ vchiq_close_service(unsigned int handle)
 	    (service->srvstate == VCHIQ_SRVSTATE_LISTENING) ||
 	    (service->srvstate == VCHIQ_SRVSTATE_HIDDEN)) {
 		vchiq_service_put(service);
-		return VCHIQ_ERROR;
+		return -EINVAL;
 	}
 
 	mark_service_closing(service);
 
 	if (current == service->state->slot_handler_thread) {
 		status = vchiq_close_service_internal(service, NO_CLOSE_RECVD);
-		WARN_ON(status == VCHIQ_RETRY);
+		WARN_ON(status == -EINTR);
 	} else {
 		/* Mark the service for termination by the slot handler */
 		request_poll(service->state, service, VCHIQ_POLL_TERMINATE);
@@ -2903,7 +2900,7 @@ vchiq_close_service(unsigned int handle)
 
 	while (1) {
 		if (wait_for_completion_interruptible(&service->remove_event)) {
-			status = VCHIQ_RETRY;
+			status = -EINTR;
 			break;
 		}
 
@@ -2918,10 +2915,10 @@ vchiq_close_service(unsigned int handle)
 				  srvstate_names[service->srvstate]);
 	}
 
-	if ((status == VCHIQ_SUCCESS) &&
+	if ((!status) &&
 	    (service->srvstate != VCHIQ_SRVSTATE_FREE) &&
 	    (service->srvstate != VCHIQ_SRVSTATE_LISTENING))
-		status = VCHIQ_ERROR;
+		status = -EINVAL;
 
 	vchiq_service_put(service);
 
@@ -2929,22 +2926,22 @@ vchiq_close_service(unsigned int handle)
 }
 EXPORT_SYMBOL(vchiq_close_service);
 
-enum vchiq_status
+int
 vchiq_remove_service(unsigned int handle)
 {
 	/* Unregister the service */
 	struct vchiq_service *service = find_service_by_handle(handle);
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 
 	if (!service)
-		return VCHIQ_ERROR;
+		return -EINVAL;
 
 	vchiq_log_info(vchiq_core_log_level, "%d: remove_service:%d",
 		       service->state->id, service->localport);
 
 	if (service->srvstate == VCHIQ_SRVSTATE_FREE) {
 		vchiq_service_put(service);
-		return VCHIQ_ERROR;
+		return -EINVAL;
 	}
 
 	mark_service_closing(service);
@@ -2958,14 +2955,14 @@ vchiq_remove_service(unsigned int handle)
 		service->public_fourcc = VCHIQ_FOURCC_INVALID;
 
 		status = vchiq_close_service_internal(service, NO_CLOSE_RECVD);
-		WARN_ON(status == VCHIQ_RETRY);
+		WARN_ON(status == -EINTR);
 	} else {
 		/* Mark the service for removal by the slot handler */
 		request_poll(service->state, service, VCHIQ_POLL_REMOVE);
 	}
 	while (1) {
 		if (wait_for_completion_interruptible(&service->remove_event)) {
-			status = VCHIQ_RETRY;
+			status = -EINTR;
 			break;
 		}
 
@@ -2979,26 +2976,25 @@ vchiq_remove_service(unsigned int handle)
 				  srvstate_names[service->srvstate]);
 	}
 
-	if ((status == VCHIQ_SUCCESS) &&
+	if ((!status) &&
 	    (service->srvstate != VCHIQ_SRVSTATE_FREE))
-		status = VCHIQ_ERROR;
+		status = -EINVAL;
 
 	vchiq_service_put(service);
-
 	return status;
 }
 
 /*
  * This function may be called by kernel threads or user threads.
- * User threads may receive VCHIQ_RETRY to indicate that a signal has been
+ * User threads may receive -EINTR to indicate that a signal has been
  * received and the call should be retried after being returned to user
  * context.
  * When called in blocking mode, the userdata field points to a bulk_waiter
  * structure.
  */
-enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __user *uoffset,
-				      int size, void *userdata, enum vchiq_bulk_mode mode,
-				      enum vchiq_bulk_dir dir)
+int vchiq_bulk_transfer(unsigned int handle, void *offset, void __user *uoffset,
+			int size, void *userdata, enum vchiq_bulk_mode mode,
+			enum vchiq_bulk_dir dir)
 {
 	struct vchiq_service *service = find_service_by_handle(handle);
 	struct vchiq_bulk_queue *queue;
@@ -3008,7 +3004,7 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __
 	const char dir_char = (dir == VCHIQ_BULK_TRANSMIT) ? 't' : 'r';
 	const int dir_msgtype = (dir == VCHIQ_BULK_TRANSMIT) ?
 		VCHIQ_MSG_BULK_TX : VCHIQ_MSG_BULK_RX;
-	enum vchiq_status status = VCHIQ_ERROR;
+	int status = -EINVAL;
 	int payload[2];
 
 	if (!service)
@@ -3020,7 +3016,7 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __
 	if (!offset && !uoffset)
 		goto error_exit;
 
-	if (vchiq_check_service(service) != VCHIQ_SUCCESS)
+	if (vchiq_check_service(service))
 		goto error_exit;
 
 	switch (mode) {
@@ -3047,7 +3043,7 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __
 		&service->bulk_tx : &service->bulk_rx;
 
 	if (mutex_lock_killable(&service->bulk_mutex)) {
-		status = VCHIQ_RETRY;
+		status = -EINTR;
 		goto error_exit;
 	}
 
@@ -3056,11 +3052,11 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __
 		do {
 			mutex_unlock(&service->bulk_mutex);
 			if (wait_for_completion_interruptible(&service->bulk_remove_event)) {
-				status = VCHIQ_RETRY;
+				status = -EINTR;
 				goto error_exit;
 			}
 			if (mutex_lock_killable(&service->bulk_mutex)) {
-				status = VCHIQ_RETRY;
+				status = -EINTR;
 				goto error_exit;
 			}
 		} while (queue->local_insert == queue->remove +
@@ -3089,7 +3085,7 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __
 	 * claim it here to ensure that isn't happening
 	 */
 	if (mutex_lock_killable(&state->slot_mutex)) {
-		status = VCHIQ_RETRY;
+		status = -EINTR;
 		goto cancel_bulk_error_exit;
 	}
 
@@ -3109,7 +3105,7 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __
 			       QMFLAGS_IS_BLOCKING |
 			       QMFLAGS_NO_MUTEX_LOCK |
 			       QMFLAGS_NO_MUTEX_UNLOCK);
-	if (status != VCHIQ_SUCCESS)
+	if (status)
 		goto unlock_both_error_exit;
 
 	queue->local_insert++;
@@ -3124,14 +3120,14 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __
 waiting:
 	vchiq_service_put(service);
 
-	status = VCHIQ_SUCCESS;
+	status = 0;
 
 	if (bulk_waiter) {
 		bulk_waiter->bulk = bulk;
 		if (wait_for_completion_interruptible(&bulk_waiter->event))
-			status = VCHIQ_RETRY;
+			status = -EINTR;
 		else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
-			status = VCHIQ_ERROR;
+			status = -EINVAL;
 	}
 
 	return status;
@@ -3149,7 +3145,7 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle, void *offset, void __
 	return status;
 }
 
-enum vchiq_status
+int
 vchiq_queue_message(unsigned int handle,
 		    ssize_t (*copy_callback)(void *context, void *dest,
 					     size_t offset, size_t maxsize),
@@ -3157,13 +3153,13 @@ vchiq_queue_message(unsigned int handle,
 		    size_t size)
 {
 	struct vchiq_service *service = find_service_by_handle(handle);
-	enum vchiq_status status = VCHIQ_ERROR;
+	int status = -EINVAL;
 	int data_id;
 
 	if (!service)
 		goto error_exit;
 
-	if (vchiq_check_service(service) != VCHIQ_SUCCESS)
+	if (vchiq_check_service(service))
 		goto error_exit;
 
 	if (!size) {
@@ -3188,7 +3184,7 @@ vchiq_queue_message(unsigned int handle,
 					    copy_callback, context, size, 1);
 		break;
 	default:
-		status = VCHIQ_ERROR;
+		status = -EINVAL;
 		break;
 	}
 
@@ -3201,18 +3197,18 @@ vchiq_queue_message(unsigned int handle,
 
 int vchiq_queue_kernel_message(unsigned int handle, void *data, unsigned int size)
 {
-	enum vchiq_status status;
+	int status;
 
 	while (1) {
 		status = vchiq_queue_message(handle, memcpy_copy_callback,
 					     data, size);
 
 		/*
-		 * vchiq_queue_message() may return VCHIQ_RETRY, so we need to
+		 * vchiq_queue_message() may be interrupted, so we need to
 		 * implement a retry mechanism since this function is supposed
 		 * to block until queued
 		 */
-		if (status != VCHIQ_RETRY)
+		if (status != -EINTR)
 			break;
 
 		msleep(1);
@@ -3264,27 +3260,25 @@ release_message_sync(struct vchiq_state *state, struct vchiq_header *header)
 	remote_event_signal(&state->remote->sync_release);
 }
 
-enum vchiq_status
+int
 vchiq_get_peer_version(unsigned int handle, short *peer_version)
 {
-	enum vchiq_status status = VCHIQ_ERROR;
+	int status = -EINVAL;
 	struct vchiq_service *service = find_service_by_handle(handle);
 
 	if (!service)
 		goto exit;
 
-	if (vchiq_check_service(service) != VCHIQ_SUCCESS)
+	if (vchiq_check_service(service))
 		goto exit;
 
 	if (!peer_version)
 		goto exit;
 
 	*peer_version = service->peer_version;
-	status = VCHIQ_SUCCESS;
+	status = 0;
 
 exit:
-	if (service)
-		vchiq_service_put(service);
 	return status;
 }
 EXPORT_SYMBOL(vchiq_get_peer_version);
@@ -3626,18 +3620,18 @@ vchiq_loud_error_footer(void)
 			"============================================================================");
 }
 
-enum vchiq_status vchiq_send_remote_use(struct vchiq_state *state)
+int vchiq_send_remote_use(struct vchiq_state *state)
 {
 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
-		return VCHIQ_RETRY;
+		return -EINVAL;
 
 	return queue_message(state, NULL, MAKE_REMOTE_USE, NULL, NULL, 0, 0);
 }
 
-enum vchiq_status vchiq_send_remote_use_active(struct vchiq_state *state)
+int vchiq_send_remote_use_active(struct vchiq_state *state)
 {
 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
-		return VCHIQ_RETRY;
+		return -EINVAL;
 
 	return queue_message(state, NULL, MAKE_REMOTE_USE_ACTIVE,
 			     NULL, NULL, 0, 0);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 1ddc661642a9..4ae72f064fff 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -459,7 +459,7 @@ vchiq_init_slots(void *mem_base, int mem_size);
 extern int
 vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero);
 
-extern enum vchiq_status
+extern int
 vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instance);
 
 struct vchiq_service *
@@ -468,10 +468,10 @@ vchiq_add_service_internal(struct vchiq_state *state,
 			   int srvstate, struct vchiq_instance *instance,
 			   void (*userdata_term)(void *userdata));
 
-extern enum vchiq_status
+extern int
 vchiq_open_service_internal(struct vchiq_service *service, int client_id);
 
-extern enum vchiq_status
+extern int
 vchiq_close_service_internal(struct vchiq_service *service, int close_recvd);
 
 extern void
@@ -486,7 +486,7 @@ vchiq_shutdown_internal(struct vchiq_state *state, struct vchiq_instance *instan
 extern void
 remote_event_pollall(struct vchiq_state *state);
 
-extern enum vchiq_status
+extern int
 vchiq_bulk_transfer(unsigned int handle, void *offset, void __user *uoffset,
 		    int size, void *userdata, enum vchiq_bulk_mode mode,
 		    enum vchiq_bulk_dir dir);
@@ -547,7 +547,7 @@ vchiq_service_get(struct vchiq_service *service);
 extern void
 vchiq_service_put(struct vchiq_service *service);
 
-extern enum vchiq_status
+extern int
 vchiq_queue_message(unsigned int handle,
 		    ssize_t (*copy_callback)(void *context, void *dest,
 					     size_t offset, size_t maxsize),
@@ -579,13 +579,13 @@ void vchiq_on_remote_release(struct vchiq_state *state);
 
 int vchiq_platform_init_state(struct vchiq_state *state);
 
-enum vchiq_status vchiq_check_service(struct vchiq_service *service);
+int vchiq_check_service(struct vchiq_service *service);
 
 void vchiq_on_remote_use_active(struct vchiq_state *state);
 
-enum vchiq_status vchiq_send_remote_use(struct vchiq_state *state);
+int vchiq_send_remote_use(struct vchiq_state *state);
 
-enum vchiq_status vchiq_send_remote_use_active(struct vchiq_state *state);
+int vchiq_send_remote_use_active(struct vchiq_state *state);
 
 void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 				       enum vchiq_connstate oldstate,
@@ -595,7 +595,7 @@ void vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newsta
 
 void vchiq_log_dump_mem(const char *label, u32 addr, const void *void_mem, size_t num_bytes);
 
-enum vchiq_status vchiq_remove_service(unsigned int service);
+int vchiq_remove_service(unsigned int service);
 
 int vchiq_get_client_id(unsigned int service);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 66bbfec332ba..062604a95b79 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -112,7 +112,7 @@ vchiq_ioc_queue_message(unsigned int handle, struct vchiq_element *elements,
 			unsigned long count)
 {
 	struct vchiq_io_copy_callback_context context;
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 	unsigned long i;
 	size_t total_size = 0;
 
@@ -130,11 +130,7 @@ vchiq_ioc_queue_message(unsigned int handle, struct vchiq_element *elements,
 	status = vchiq_queue_message(handle, vchiq_ioc_copy_element_data,
 				     &context, total_size);
 
-	if (status == VCHIQ_ERROR)
-		return -EIO;
-	else if (status == VCHIQ_RETRY)
-		return -EINTR;
-	return 0;
+	return (status == -EINVAL) ? -EIO : status;
 }
 
 static int vchiq_ioc_create_service(struct vchiq_instance *instance,
@@ -142,7 +138,7 @@ static int vchiq_ioc_create_service(struct vchiq_instance *instance,
 {
 	struct user_service *user_service = NULL;
 	struct vchiq_service *service;
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 	struct vchiq_service_params_kernel params;
 	int srvstate;
 
@@ -190,9 +186,9 @@ static int vchiq_ioc_create_service(struct vchiq_instance *instance,
 
 	if (args->is_open) {
 		status = vchiq_open_service_internal(service, instance->pid);
-		if (status != VCHIQ_SUCCESS) {
+		if (status) {
 			vchiq_remove_service(service->handle);
-			return (status == VCHIQ_RETRY) ?
+			return (status == -EINTR) ?
 				-EINTR : -EIO;
 		}
 	}
@@ -338,7 +334,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		goto out;
 	}
 
-	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
+	if ((status != -EINTR) || fatal_signal_pending(current) ||
 	    !waiter->bulk_waiter.bulk) {
 		if (waiter->bulk_waiter.bulk) {
 			/* Cancel the signal when the transfer completes. */
@@ -364,9 +360,9 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 	vchiq_service_put(service);
 	if (ret)
 		return ret;
-	else if (status == VCHIQ_ERROR)
+	else if (status == -EINVAL)
 		return -EIO;
-	else if (status == VCHIQ_RETRY)
+	else if (status == -EINTR)
 		return -EINTR;
 	return 0;
 }
@@ -577,7 +573,7 @@ static long
 vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct vchiq_instance *instance = file->private_data;
-	enum vchiq_status status = VCHIQ_SUCCESS;
+	int status = 0;
 	struct vchiq_service *service = NULL;
 	long ret = 0;
 	int i, rc;
@@ -598,12 +594,12 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 							   instance, &i))) {
 			status = vchiq_remove_service(service->handle);
 			vchiq_service_put(service);
-			if (status != VCHIQ_SUCCESS)
+			if (status)
 				break;
 		}
 		service = NULL;
 
-		if (status == VCHIQ_SUCCESS) {
+		if (!status) {
 			/* Wake the completion thread and ask it to exit */
 			instance->closing = 1;
 			complete(&instance->insert_event);
@@ -627,7 +623,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		status = vchiq_connect_internal(instance->state, instance);
 		mutex_unlock(&instance->state->mutex);
 
-		if (status == VCHIQ_SUCCESS)
+		if (!status)
 			instance->connected = 1;
 		else
 			vchiq_log_error(vchiq_arm_log_level,
@@ -675,7 +671,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			status = (cmd == VCHIQ_IOC_CLOSE_SERVICE) ?
 				 vchiq_close_service(service->handle) :
 				 vchiq_remove_service(service->handle);
-			if (status != VCHIQ_SUCCESS)
+			if (status)
 				break;
 		}
 
@@ -686,7 +682,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		 */
 		if (user_service->close_pending &&
 		    wait_for_completion_interruptible(&user_service->close_event))
-			status = VCHIQ_RETRY;
+			status = -EINTR;
 		break;
 	}
 
@@ -862,13 +858,13 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		vchiq_service_put(service);
 
 	if (ret == 0) {
-		if (status == VCHIQ_ERROR)
+		if (status == -EINVAL)
 			ret = -EIO;
-		else if (status == VCHIQ_RETRY)
+		else if (status == -EINTR)
 			ret = -EINTR;
 	}
 
-	if ((status == VCHIQ_SUCCESS) && (ret < 0) && (ret != -EINTR) && (ret != -EWOULDBLOCK))
+	if ((!status) && (ret < 0) && (ret != -EINTR) && (ret != -EWOULDBLOCK))
 		vchiq_log_info(vchiq_arm_log_level,
 			       "  ioctl instance %pK, cmd %s -> status %d, %ld",
 			       instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index 86d77f2eeea5..96f50beace44 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -12,10 +12,10 @@
 
 struct vchiq_service_params {
 	int fourcc;
-	enum vchiq_status __user (*callback)(enum vchiq_reason reason,
-				      struct vchiq_header *header,
-				      unsigned int handle,
-				      void *bulk_userdata);
+	int __user (*callback)(enum vchiq_reason reason,
+			       struct vchiq_header *header,
+			       unsigned int handle,
+			       void *bulk_userdata);
 	void __user *userdata;
 	short version;       /* Increment for non-trivial changes */
 	short version_min;   /* Update for incompatible changes */
-- 
2.36.1

