Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE651768F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386929AbiEBSem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386911AbiEBSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C4C3614D
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651516260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sX9IPjZzNegxu8ysaGBmB7nYN8pL7VVRWVEhz+Com/0=;
        b=faZjhYN3YUZCwLI5D6wiPCHqGgb+cMiguTIXbFu0lyI4ElEC8UkWYfXQhaumdwhhPxfIBZ
        uUed/yIra8CkD64zAugJKg8n/Zylk6TBijSpKPrwsCPVHJTnGWzjjIlNz/FL6589Lj2KTI
        N4A2cl6ZL2U1vjF2RR9JzCOA7OOJAsI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-rMMqOpe2M3uhHEWhWhPu0w-1; Mon, 02 May 2022 14:30:59 -0400
X-MC-Unique: rMMqOpe2M3uhHEWhWhPu0w-1
Received: by mail-qk1-f200.google.com with SMTP id d186-20020a3768c3000000b0069fcfacbea0so3484071qkc.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sX9IPjZzNegxu8ysaGBmB7nYN8pL7VVRWVEhz+Com/0=;
        b=fRxHf65me/tweRHkX4ES3ZQbw7svg7jbZs7LScYKTC2DyXBAI46MoGBYUz4kn4vRzf
         BhMltqGoy64nFgGaGSFqKk3BMMJxpj1T9q9GygQS3iO79rsb8EM+BuvsEjxT/53+RenL
         FT0b9QXepuC3dywGbYTnOFmlvKNBJC7RRaLtClRfl2sLIUebw+aseJDzrES5SH25vtn5
         C3lS9+Th41UkaDUF6NAbBP20BF/VzIR8ERa8OVdnVbmBq5MamDAONFKueyJo28dD0VPu
         5woERjyrzh6t0a4V72fho2j404EpSvYaaZbt2xdY4HwuARVSAdCHuOnromWQe/lFC6/3
         DOhA==
X-Gm-Message-State: AOAM531nFyTZ9K72oTaO2SJdcpKXWJ3tV6gzOtaL5OcRLVtZKT3Pr/cE
        dddv7VC5Qi+LoP3hrl9VRwl3/dpOR1vERYy6XwugpbaPCn+VAfs9zfdjXgA2N9fbeB6HP+1nKsf
        RCTik94OqF3LzAmd/DftToJEb
X-Received: by 2002:a05:622a:2c8:b0:2f3:a3d3:5bb with SMTP id a8-20020a05622a02c800b002f3a3d305bbmr6027772qtx.593.1651516258026;
        Mon, 02 May 2022 11:30:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNS7ss0/2w6Y63gGyneuMpGrLhb1WodEg5wU/DlQmQJDMVH9bUuXqF4onwapZsNXUQFkcVNg==
X-Received: by 2002:a05:622a:2c8:b0:2f3:a3d3:5bb with SMTP id a8-20020a05622a02c800b002f3a3d305bbmr6027738qtx.593.1651516257589;
        Mon, 02 May 2022 11:30:57 -0700 (PDT)
Received: from fedora.hitronhub.home (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id h12-20020ac846cc000000b002f39b99f68esm4412204qto.40.2022.05.02.11.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:30:57 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Adrien Thierry <athierry@redhat.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: vchiq_arm: get rid of global vchiq_states array
Date:   Mon,  2 May 2022 14:30:42 -0400
Message-Id: <20220502183045.206519-4-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502183045.206519-1-athierry@redhat.com>
References: <20220502183045.206519-1-athierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the global vchiq_states array. Access the vchiq state from
the vchiq instance instead.

This is part of an effort to address TODO item "Get rid of all non
essential global structures and create a proper per device structure"

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 .../bcm2835-audio/bcm2835-vchiq.c             | 33 +++++---
 .../include/linux/raspberrypi/vchiq.h         | 37 +++++----
 .../interface/vchiq_arm/vchiq_arm.c           | 29 ++++---
 .../interface/vchiq_arm/vchiq_arm.h           |  8 +-
 .../interface/vchiq_arm/vchiq_core.c          | 80 ++++++++++---------
 .../interface/vchiq_arm/vchiq_core.h          | 25 ++----
 .../interface/vchiq_arm/vchiq_dev.c           | 38 ++++-----
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 61 +++++++-------
 8 files changed, 159 insertions(+), 152 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 701abe430877..f4c2c9506d86 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -25,12 +25,14 @@ MODULE_PARM_DESC(force_bulk, "Force use of vchiq bulk for audio");
 static void bcm2835_audio_lock(struct bcm2835_audio_instance *instance)
 {
 	mutex_lock(&instance->vchi_mutex);
-	vchiq_use_service(instance->service_handle);
+	vchiq_use_service(instance->alsa_stream->chip->vchi_ctx->instance,
+			  instance->service_handle);
 }
 
 static void bcm2835_audio_unlock(struct bcm2835_audio_instance *instance)
 {
-	vchiq_release_service(instance->service_handle);
+	vchiq_release_service(instance->alsa_stream->chip->vchi_ctx->instance,
+			      instance->service_handle);
 	mutex_unlock(&instance->vchi_mutex);
 }
 
@@ -44,8 +46,8 @@ static int bcm2835_audio_send_msg_locked(struct bcm2835_audio_instance *instance
 		init_completion(&instance->msg_avail_comp);
 	}
 
-	status = vchiq_queue_kernel_message(instance->service_handle,
-					    m, sizeof(*m));
+	status = vchiq_queue_kernel_message(instance->alsa_stream->chip->vchi_ctx->instance,
+					    instance->service_handle, m, sizeof(*m));
 	if (status) {
 		dev_err(instance->dev,
 			"vchi message queue failed: %d, msg=%d\n",
@@ -89,11 +91,13 @@ static int bcm2835_audio_send_simple(struct bcm2835_audio_instance *instance,
 	return bcm2835_audio_send_msg(instance, &m, wait);
 }
 
-static enum vchiq_status audio_vchi_callback(enum vchiq_reason reason,
+static enum vchiq_status audio_vchi_callback(struct vchiq_instance *vchiq_instance,
+					     enum vchiq_reason reason,
 					     struct vchiq_header *header,
 					     unsigned int handle, void *userdata)
 {
-	struct bcm2835_audio_instance *instance = vchiq_get_service_userdata(handle);
+	struct bcm2835_audio_instance *instance = vchiq_get_service_userdata(vchiq_instance,
+									     handle);
 	struct vc_audio_msg *m;
 
 	if (reason != VCHIQ_MESSAGE_AVAILABLE)
@@ -114,7 +118,7 @@ static enum vchiq_status audio_vchi_callback(enum vchiq_reason reason,
 		dev_err(instance->dev, "unexpected callback type=%d\n", m->type);
 	}
 
-	vchiq_release_message(handle, header);
+	vchiq_release_message(vchiq_instance, instance->service_handle, header);
 	return VCHIQ_SUCCESS;
 }
 
@@ -143,7 +147,8 @@ vc_vchi_audio_init(struct vchiq_instance *vchiq_instance,
 	}
 
 	/* Finished with the service for now */
-	vchiq_release_service(instance->service_handle);
+	vchiq_release_service(instance->alsa_stream->chip->vchi_ctx->instance,
+			      instance->service_handle);
 
 	return 0;
 }
@@ -153,10 +158,12 @@ static void vc_vchi_audio_deinit(struct bcm2835_audio_instance *instance)
 	int status;
 
 	mutex_lock(&instance->vchi_mutex);
-	vchiq_use_service(instance->service_handle);
+	vchiq_use_service(instance->alsa_stream->chip->vchi_ctx->instance,
+			  instance->service_handle);
 
 	/* Close all VCHI service connections */
-	status = vchiq_close_service(instance->service_handle);
+	status = vchiq_close_service(instance->alsa_stream->chip->vchi_ctx->instance,
+				     instance->service_handle);
 	if (status) {
 		dev_err(instance->dev,
 			"failed to close VCHI service connection (status=%d)\n",
@@ -226,7 +233,7 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream)
 		goto deinit;
 
 	bcm2835_audio_lock(instance);
-	vchiq_get_peer_version(instance->service_handle,
+	vchiq_get_peer_version(vchi_ctx->instance, instance->service_handle,
 			       &instance->peer_version);
 	bcm2835_audio_unlock(instance);
 	if (instance->peer_version < 2 || force_bulk)
@@ -351,8 +358,8 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 		while (count > 0) {
 			int bytes = min(instance->max_packet, count);
 
-			status = vchiq_queue_kernel_message(instance->service_handle,
-							    src, bytes);
+			status = vchiq_queue_kernel_message(vchiq_instance,
+							    instance->service_handle, src, bytes);
 			src += bytes;
 			count -= bytes;
 		}
diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
index 715f02e7f1e1..ddb7bcdffc64 100644
--- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
+++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
@@ -53,9 +53,12 @@ struct vchiq_element {
 	unsigned int size;
 };
 
+struct vchiq_instance;
+
 struct vchiq_service_base {
 	int fourcc;
-	enum vchiq_status (*callback)(enum vchiq_reason reason,
+	enum vchiq_status (*callback)(struct vchiq_instance *instance,
+				      enum vchiq_reason reason,
 				      struct vchiq_header *header,
 				      unsigned int handle,
 				      void *bulk_userdata);
@@ -71,7 +74,8 @@ struct vchiq_completion_data_kernel {
 
 struct vchiq_service_params_kernel {
 	int fourcc;
-	enum vchiq_status (*callback)(enum vchiq_reason reason,
+	enum vchiq_status (*callback)(struct vchiq_instance *instance,
+				      enum vchiq_reason reason,
 				      struct vchiq_header *header,
 				      unsigned int handle,
 				      void *bulk_userdata);
@@ -80,31 +84,32 @@ struct vchiq_service_params_kernel {
 	short version_min;   /* Update for incompatible changes */
 };
 
-struct vchiq_instance;
-
 extern enum vchiq_status vchiq_initialise(struct vchiq_instance **pinstance);
 extern enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance);
 extern enum vchiq_status vchiq_connect(struct vchiq_instance *instance);
 extern enum vchiq_status vchiq_open_service(struct vchiq_instance *instance,
 	const struct vchiq_service_params_kernel *params,
 	unsigned int *pservice);
-extern enum vchiq_status vchiq_close_service(unsigned int service);
-extern enum vchiq_status vchiq_use_service(unsigned int service);
-extern enum vchiq_status vchiq_release_service(unsigned int service);
-extern void vchiq_msg_queue_push(unsigned int handle, struct vchiq_header *header);
-extern void           vchiq_release_message(unsigned int service,
-	struct vchiq_header *header);
-extern int vchiq_queue_kernel_message(unsigned int handle, void *data,
-				      unsigned int size);
+extern enum vchiq_status vchiq_close_service(struct vchiq_instance *instance,
+					     unsigned int service);
+extern enum vchiq_status vchiq_use_service(struct vchiq_instance *instance, unsigned int service);
+extern enum vchiq_status vchiq_release_service(struct vchiq_instance *instance,
+					       unsigned int service);
+extern void vchiq_msg_queue_push(struct vchiq_instance *instance, unsigned int handle,
+				 struct vchiq_header *header);
+extern void vchiq_release_message(struct vchiq_instance *instance, unsigned int service,
+				  struct vchiq_header *header);
+extern int vchiq_queue_kernel_message(struct vchiq_instance *instance, unsigned int handle,
+				      void *data, unsigned int size);
 extern enum vchiq_status vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int service,
 					     const void *data, unsigned int size, void *userdata,
 					     enum vchiq_bulk_mode mode);
 extern enum vchiq_status vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int service,
 					    void *data, unsigned int size, void *userdata,
 					    enum vchiq_bulk_mode mode);
-extern void *vchiq_get_service_userdata(unsigned int service);
-extern enum vchiq_status vchiq_get_peer_version(unsigned int handle,
-	short *peer_version);
-extern struct vchiq_header *vchiq_msg_hold(unsigned int handle);
+extern void *vchiq_get_service_userdata(struct vchiq_instance *instance, unsigned int service);
+extern enum vchiq_status vchiq_get_peer_version(struct vchiq_instance *instance,
+						unsigned int handle, short *peer_version);
+extern struct vchiq_header *vchiq_msg_hold(struct vchiq_instance *instance, unsigned int handle);
 
 #endif /* VCHIQ_H */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 3b447c635c3f..2e5de4b4967b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -819,7 +819,7 @@ vchiq_open_service(struct vchiq_instance *instance,
 		*phandle = service->handle;
 		status = vchiq_open_service_internal(service, current->pid);
 		if (status != VCHIQ_SUCCESS) {
-			vchiq_remove_service(service->handle);
+			vchiq_remove_service(instance, service->handle);
 			*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
 		}
 	}
@@ -914,7 +914,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 	enum vchiq_status status;
 	struct bulk_waiter_node *waiter = NULL, *iter;
 
-	service = find_service_by_handle(handle);
+	service = find_service_by_handle(instance, handle);
 	if (!service)
 		return VCHIQ_ERROR;
 
@@ -1041,8 +1041,8 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 }
 
 enum vchiq_status
-service_callback(enum vchiq_reason reason, struct vchiq_header *header,
-		 unsigned int handle, void *bulk_userdata)
+service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
+		 struct vchiq_header *header, unsigned int handle, void *bulk_userdata)
 {
 	/*
 	 * How do we ensure the callback goes to the right client?
@@ -1052,7 +1052,6 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 	 */
 	struct user_service *user_service;
 	struct vchiq_service *service;
-	struct vchiq_instance *instance;
 	bool skip_completion = false;
 
 	DEBUG_INITIALISE(g_state.local);
@@ -1060,16 +1059,15 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 
 	rcu_read_lock();
-	service = handle_to_service(handle);
+	service = handle_to_service(instance, handle);
 	if (WARN_ON(!service)) {
 		rcu_read_unlock();
 		return VCHIQ_SUCCESS;
 	}
 
 	user_service = (struct user_service *)service->base.userdata;
-	instance = user_service->instance;
 
-	if (!instance || instance->closing) {
+	if (instance->closing) {
 		rcu_read_unlock();
 		return VCHIQ_SUCCESS;
 	}
@@ -1313,7 +1311,8 @@ vchiq_get_state(void)
  */
 
 static enum vchiq_status
-vchiq_keepalive_vchiq_callback(enum vchiq_reason reason,
+vchiq_keepalive_vchiq_callback(struct vchiq_instance *instance,
+			       enum vchiq_reason reason,
 			       struct vchiq_header *header,
 			       unsigned int service_user, void *bulk_user)
 {
@@ -1382,14 +1381,14 @@ vchiq_keepalive_thread_func(void *v)
 		 */
 		while (uc--) {
 			atomic_inc(&arm_state->ka_use_ack_count);
-			status = vchiq_use_service(ka_handle);
+			status = vchiq_use_service(instance, ka_handle);
 			if (status != VCHIQ_SUCCESS) {
 				vchiq_log_error(vchiq_susp_log_level,
 						"%s vchiq_use_service error %d", __func__, status);
 			}
 		}
 		while (rc--) {
-			status = vchiq_release_service(ka_handle);
+			status = vchiq_release_service(instance, ka_handle);
 			if (status != VCHIQ_SUCCESS) {
 				vchiq_log_error(vchiq_susp_log_level,
 						"%s vchiq_release_service error %d", __func__,
@@ -1585,10 +1584,10 @@ vchiq_instance_set_trace(struct vchiq_instance *instance, int trace)
 }
 
 enum vchiq_status
-vchiq_use_service(unsigned int handle)
+vchiq_use_service(struct vchiq_instance *instance, unsigned int handle)
 {
 	enum vchiq_status ret = VCHIQ_ERROR;
-	struct vchiq_service *service = find_service_by_handle(handle);
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
 
 	if (service) {
 		ret = vchiq_use_internal(service->state, service, USE_TYPE_SERVICE);
@@ -1599,10 +1598,10 @@ vchiq_use_service(unsigned int handle)
 EXPORT_SYMBOL(vchiq_use_service);
 
 enum vchiq_status
-vchiq_release_service(unsigned int handle)
+vchiq_release_service(struct vchiq_instance *instance, unsigned int handle)
 {
 	enum vchiq_status ret = VCHIQ_ERROR;
-	struct vchiq_service *service = find_service_by_handle(handle);
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
 
 	if (service) {
 		ret = vchiq_release_internal(service->state, service);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 2aa46b119a46..2851ef6b9cd0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -86,10 +86,10 @@ extern struct vchiq_state *
 vchiq_get_state(void);
 
 enum vchiq_status
-vchiq_use_service(unsigned int handle);
+vchiq_use_service(struct vchiq_instance *instance, unsigned int handle);
 
 extern enum vchiq_status
-vchiq_release_service(unsigned int handle);
+vchiq_release_service(struct vchiq_instance *instance, unsigned int handle);
 
 extern enum vchiq_status
 vchiq_check_service(struct vchiq_service *service);
@@ -138,8 +138,8 @@ static inline int vchiq_register_chrdev(struct device *parent) { return 0; }
 #endif /* IS_ENABLED(CONFIG_VCHIQ_CDEV) */
 
 extern enum vchiq_status
-service_callback(enum vchiq_reason reason, struct vchiq_header *header,
-		 unsigned int handle, void *bulk_userdata);
+service_callback(struct vchiq_instance *vchiq_instance, enum vchiq_reason reason,
+		 struct vchiq_header *header, unsigned int handle, void *bulk_userdata);
 
 extern void
 free_bulk_waiter(struct vchiq_instance *instance);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 04eec18835da..0e9bd33078b2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -13,6 +13,7 @@
 #include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 
+#include "vchiq_arm.h"
 #include "vchiq_core.h"
 
 #define VCHIQ_SLOT_HANDLER_STACK 8192
@@ -161,7 +162,6 @@ int vchiq_sync_log_level = VCHIQ_LOG_DEFAULT;
 DEFINE_SPINLOCK(bulk_waiter_spinlock);
 static DEFINE_SPINLOCK(quota_spinlock);
 
-struct vchiq_state *vchiq_states[VCHIQ_MAX_STATES];
 static unsigned int handle_seq;
 
 static const char *const srvstate_names[] = {
@@ -234,13 +234,20 @@ set_service_state(struct vchiq_service *service, int newstate)
 	service->srvstate = newstate;
 }
 
+struct vchiq_service *handle_to_service(struct vchiq_instance *instance, unsigned int handle)
+{
+	int idx = handle & (VCHIQ_MAX_SERVICES - 1);
+
+	return rcu_dereference(instance->state->services[idx]);
+}
+
 struct vchiq_service *
-find_service_by_handle(unsigned int handle)
+find_service_by_handle(struct vchiq_instance *instance, unsigned int handle)
 {
 	struct vchiq_service *service;
 
 	rcu_read_lock();
-	service = handle_to_service(handle);
+	service = handle_to_service(instance, handle);
 	if (service && service->srvstate != VCHIQ_SRVSTATE_FREE &&
 	    service->handle == handle &&
 	    kref_get_unless_zero(&service->ref_count)) {
@@ -281,7 +288,7 @@ find_service_for_instance(struct vchiq_instance *instance, unsigned int handle)
 	struct vchiq_service *service;
 
 	rcu_read_lock();
-	service = handle_to_service(handle);
+	service = handle_to_service(instance, handle);
 	if (service && service->srvstate != VCHIQ_SRVSTATE_FREE &&
 	    service->handle == handle &&
 	    service->instance == instance &&
@@ -302,7 +309,7 @@ find_closed_service_for_instance(struct vchiq_instance *instance, unsigned int h
 	struct vchiq_service *service;
 
 	rcu_read_lock();
-	service = handle_to_service(handle);
+	service = handle_to_service(instance, handle);
 	if (service &&
 	    (service->srvstate == VCHIQ_SRVSTATE_FREE ||
 	     service->srvstate == VCHIQ_SRVSTATE_CLOSED) &&
@@ -398,26 +405,26 @@ vchiq_service_put(struct vchiq_service *service)
 }
 
 int
-vchiq_get_client_id(unsigned int handle)
+vchiq_get_client_id(struct vchiq_instance *instance, unsigned int handle)
 {
 	struct vchiq_service *service;
 	int id;
 
 	rcu_read_lock();
-	service = handle_to_service(handle);
+	service = handle_to_service(instance, handle);
 	id = service ? service->client_id : 0;
 	rcu_read_unlock();
 	return id;
 }
 
 void *
-vchiq_get_service_userdata(unsigned int handle)
+vchiq_get_service_userdata(struct vchiq_instance *instance, unsigned int handle)
 {
 	void *userdata;
 	struct vchiq_service *service;
 
 	rcu_read_lock();
-	service = handle_to_service(handle);
+	service = handle_to_service(instance, handle);
 	userdata = service ? service->base.userdata : NULL;
 	rcu_read_unlock();
 	return userdata;
@@ -466,7 +473,8 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 	vchiq_log_trace(vchiq_core_log_level, "%d: callback:%d (%s, %pK, %pK)",
 			service->state->id, service->localport, reason_names[reason],
 			header, bulk_userdata);
-	status = service->base.callback(reason, header, service->handle, bulk_userdata);
+	status = service->base.callback(service->instance, reason, header, service->handle,
+					bulk_userdata);
 	if (status == VCHIQ_ERROR) {
 		vchiq_log_warning(vchiq_core_log_level,
 				  "%d: ignoring ERROR from callback to service %x",
@@ -475,7 +483,7 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 	}
 
 	if (reason != VCHIQ_MESSAGE_AVAILABLE)
-		vchiq_release_message(service->handle, header);
+		vchiq_release_message(service->instance, service->handle, header);
 
 	return status;
 }
@@ -2149,11 +2157,6 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	char threadname[16];
 	int i, ret;
 
-	if (vchiq_states[0]) {
-		pr_err("%s: VCHIQ state already initialized\n", __func__);
-		return -EINVAL;
-	}
-
 	local = &slot_zero->slave;
 	remote = &slot_zero->master;
 
@@ -2274,8 +2277,6 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	wake_up_process(state->recycle_thread);
 	wake_up_process(state->sync_thread);
 
-	vchiq_states[0] = state;
-
 	/* Indicate readiness to the other side */
 	local->initialised = 1;
 
@@ -2289,9 +2290,10 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	return ret;
 }
 
-void vchiq_msg_queue_push(unsigned int handle, struct vchiq_header *header)
+void vchiq_msg_queue_push(struct vchiq_instance *instance, unsigned int handle,
+			  struct vchiq_header *header)
 {
-	struct vchiq_service *service = find_service_by_handle(handle);
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	int pos;
 
 	if (!service)
@@ -2311,9 +2313,9 @@ void vchiq_msg_queue_push(unsigned int handle, struct vchiq_header *header)
 }
 EXPORT_SYMBOL(vchiq_msg_queue_push);
 
-struct vchiq_header *vchiq_msg_hold(unsigned int handle)
+struct vchiq_header *vchiq_msg_hold(struct vchiq_instance *instance, unsigned int handle)
 {
-	struct vchiq_service *service = find_service_by_handle(handle);
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	struct vchiq_header *header;
 	int pos;
 
@@ -2868,16 +2870,16 @@ vchiq_shutdown_internal(struct vchiq_state *state, struct vchiq_instance *instan
 	/* Find all services registered to this client and remove them. */
 	i = 0;
 	while ((service = next_service_by_instance(state, instance, &i)) != NULL) {
-		(void)vchiq_remove_service(service->handle);
+		(void)vchiq_remove_service(instance, service->handle);
 		vchiq_service_put(service);
 	}
 }
 
 enum vchiq_status
-vchiq_close_service(unsigned int handle)
+vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 {
 	/* Unregister the service */
-	struct vchiq_service *service = find_service_by_handle(handle);
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	enum vchiq_status status = VCHIQ_SUCCESS;
 
 	if (!service)
@@ -2932,10 +2934,10 @@ vchiq_close_service(unsigned int handle)
 EXPORT_SYMBOL(vchiq_close_service);
 
 enum vchiq_status
-vchiq_remove_service(unsigned int handle)
+vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 {
 	/* Unregister the service */
-	struct vchiq_service *service = find_service_by_handle(handle);
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	enum vchiq_status status = VCHIQ_SUCCESS;
 
 	if (!service)
@@ -3002,7 +3004,7 @@ enum vchiq_status vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned
 				      void *offset, void __user *uoffset, int size, void *userdata,
 				      enum vchiq_bulk_mode mode, enum vchiq_bulk_dir dir)
 {
-	struct vchiq_service *service = find_service_by_handle(handle);
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	struct vchiq_bulk_queue *queue;
 	struct vchiq_bulk *bulk;
 	struct vchiq_state *state;
@@ -3152,13 +3154,13 @@ enum vchiq_status vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned
 }
 
 enum vchiq_status
-vchiq_queue_message(unsigned int handle,
+vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 		    ssize_t (*copy_callback)(void *context, void *dest,
 					     size_t offset, size_t maxsize),
 		    void *context,
 		    size_t size)
 {
-	struct vchiq_service *service = find_service_by_handle(handle);
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	enum vchiq_status status = VCHIQ_ERROR;
 	int data_id;
 
@@ -3201,12 +3203,13 @@ vchiq_queue_message(unsigned int handle,
 	return status;
 }
 
-int vchiq_queue_kernel_message(unsigned int handle, void *data, unsigned int size)
+int vchiq_queue_kernel_message(struct vchiq_instance *instance, unsigned int handle, void *data,
+			       unsigned int size)
 {
 	enum vchiq_status status;
 
 	while (1) {
-		status = vchiq_queue_message(handle, memcpy_copy_callback,
+		status = vchiq_queue_message(instance, handle, memcpy_copy_callback,
 					     data, size);
 
 		/*
@@ -3225,10 +3228,10 @@ int vchiq_queue_kernel_message(unsigned int handle, void *data, unsigned int siz
 EXPORT_SYMBOL(vchiq_queue_kernel_message);
 
 void
-vchiq_release_message(unsigned int handle,
+vchiq_release_message(struct vchiq_instance *instance, unsigned int handle,
 		      struct vchiq_header *header)
 {
-	struct vchiq_service *service = find_service_by_handle(handle);
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	struct vchiq_shared_state *remote;
 	struct vchiq_state *state;
 	int slot_index;
@@ -3267,10 +3270,10 @@ release_message_sync(struct vchiq_state *state, struct vchiq_header *header)
 }
 
 enum vchiq_status
-vchiq_get_peer_version(unsigned int handle, short *peer_version)
+vchiq_get_peer_version(struct vchiq_instance *instance, unsigned int handle, short *peer_version)
 {
 	enum vchiq_status status = VCHIQ_ERROR;
-	struct vchiq_service *service = find_service_by_handle(handle);
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
 
 	if (!service)
 		goto exit;
@@ -3302,9 +3305,10 @@ void vchiq_get_config(struct vchiq_config *config)
 }
 
 int
-vchiq_set_service_option(unsigned int handle, enum vchiq_service_option option, int value)
+vchiq_set_service_option(struct vchiq_instance *instance, unsigned int handle,
+			 enum vchiq_service_option option, int value)
 {
-	struct vchiq_service *service = find_service_by_handle(handle);
+	struct vchiq_service *service = find_service_by_handle(instance, handle);
 	struct vchiq_service_quota *quota;
 	int ret = -EINVAL;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 2ce54ce9f02a..e08206397076 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -450,8 +450,6 @@ extern int vchiq_core_log_level;
 extern int vchiq_core_msg_log_level;
 extern int vchiq_sync_log_level;
 
-extern struct vchiq_state *vchiq_states[VCHIQ_MAX_STATES];
-
 extern const char *
 get_conn_state_name(enum vchiq_connstate conn_state);
 
@@ -509,20 +507,10 @@ extern void
 request_poll(struct vchiq_state *state, struct vchiq_service *service,
 	     int poll_type);
 
-static inline struct vchiq_service *
-handle_to_service(unsigned int handle)
-{
-	int idx = handle & (VCHIQ_MAX_SERVICES - 1);
-	struct vchiq_state *state = vchiq_states[(handle / VCHIQ_MAX_SERVICES) &
-		(VCHIQ_MAX_STATES - 1)];
-
-	if (!state)
-		return NULL;
-	return rcu_dereference(state->services[idx]);
-}
+struct vchiq_service *handle_to_service(struct vchiq_instance *instance, unsigned int handle);
 
 extern struct vchiq_service *
-find_service_by_handle(unsigned int handle);
+find_service_by_handle(struct vchiq_instance *instance, unsigned int handle);
 
 extern struct vchiq_service *
 find_service_by_port(struct vchiq_state *state, unsigned int localport);
@@ -550,7 +538,7 @@ extern void
 vchiq_service_put(struct vchiq_service *service);
 
 extern enum vchiq_status
-vchiq_queue_message(unsigned int handle,
+vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 		    ssize_t (*copy_callback)(void *context, void *dest,
 					     size_t offset, size_t maxsize),
 		    void *context,
@@ -597,12 +585,13 @@ void vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newsta
 
 void vchiq_log_dump_mem(const char *label, u32 addr, const void *void_mem, size_t num_bytes);
 
-enum vchiq_status vchiq_remove_service(unsigned int service);
+enum vchiq_status vchiq_remove_service(struct vchiq_instance *instance, unsigned int service);
 
-int vchiq_get_client_id(unsigned int service);
+int vchiq_get_client_id(struct vchiq_instance *instance, unsigned int service);
 
 void vchiq_get_config(struct vchiq_config *config);
 
-int vchiq_set_service_option(unsigned int service, enum vchiq_service_option option, int value);
+int vchiq_set_service_option(struct vchiq_instance *instance, unsigned int service,
+			     enum vchiq_service_option option, int value);
 
 #endif
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 077e3fcbd651..7e297494437e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -108,8 +108,8 @@ static ssize_t vchiq_ioc_copy_element_data(void *context, void *dest,
 }
 
 static int
-vchiq_ioc_queue_message(unsigned int handle, struct vchiq_element *elements,
-			unsigned long count)
+vchiq_ioc_queue_message(struct vchiq_instance *instance, unsigned int handle,
+			struct vchiq_element *elements, unsigned long count)
 {
 	struct vchiq_io_copy_callback_context context;
 	enum vchiq_status status = VCHIQ_SUCCESS;
@@ -127,7 +127,7 @@ vchiq_ioc_queue_message(unsigned int handle, struct vchiq_element *elements,
 		total_size += elements[i].size;
 	}
 
-	status = vchiq_queue_message(handle, vchiq_ioc_copy_element_data,
+	status = vchiq_queue_message(instance, handle, vchiq_ioc_copy_element_data,
 				     &context, total_size);
 
 	if (status == VCHIQ_ERROR)
@@ -191,7 +191,7 @@ static int vchiq_ioc_create_service(struct vchiq_instance *instance,
 	if (args->is_open) {
 		status = vchiq_open_service_internal(service, instance->pid);
 		if (status != VCHIQ_SUCCESS) {
-			vchiq_remove_service(service->handle);
+			vchiq_remove_service(instance, service->handle);
 			return (status == VCHIQ_RETRY) ?
 				-EINTR : -EIO;
 		}
@@ -266,7 +266,7 @@ static int vchiq_ioc_dequeue_message(struct vchiq_instance *instance,
 		/* Copy to user space if msgbuf is not NULL */
 		if (!args->buf || (copy_to_user(args->buf, header->data, header->size) == 0)) {
 			ret = header->size;
-			vchiq_release_message(service->handle, header);
+			vchiq_release_message(instance, service->handle, header);
 		} else {
 			ret = -EFAULT;
 		}
@@ -529,7 +529,7 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 			}
 
 			/* Now it has been copied, the message can be released. */
-			vchiq_release_message(service->handle, header);
+			vchiq_release_message(instance, service->handle, header);
 
 			/* The completion must point to the msgbuf. */
 			user_completion.header = msgbuf;
@@ -596,7 +596,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		i = 0;
 		while ((service = next_service_by_instance(instance->state,
 							   instance, &i))) {
-			status = vchiq_remove_service(service->handle);
+			status = vchiq_remove_service(instance, service->handle);
 			vchiq_service_put(service);
 			if (status != VCHIQ_SUCCESS)
 				break;
@@ -649,7 +649,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			break;
 
 		if (put_user(args.handle, &argp->handle)) {
-			vchiq_remove_service(args.handle);
+			vchiq_remove_service(instance, args.handle);
 			ret = -EFAULT;
 		}
 	} break;
@@ -673,8 +673,8 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		 */
 		if (!user_service->close_pending) {
 			status = (cmd == VCHIQ_IOC_CLOSE_SERVICE) ?
-				 vchiq_close_service(service->handle) :
-				 vchiq_remove_service(service->handle);
+				 vchiq_close_service(instance, service->handle) :
+				 vchiq_remove_service(instance, service->handle);
 			if (status != VCHIQ_SUCCESS)
 				break;
 		}
@@ -731,7 +731,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 			if (copy_from_user(elements, args.elements,
 					   args.count * sizeof(struct vchiq_element)) == 0)
-				ret = vchiq_ioc_queue_message(args.handle, elements,
+				ret = vchiq_ioc_queue_message(instance, args.handle, elements,
 							      args.count);
 			else
 				ret = -EFAULT;
@@ -788,7 +788,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case VCHIQ_IOC_GET_CLIENT_ID: {
 		unsigned int handle = (unsigned int)arg;
 
-		ret = vchiq_get_client_id(handle);
+		ret = vchiq_get_client_id(instance, handle);
 	} break;
 
 	case VCHIQ_IOC_GET_CONFIG: {
@@ -827,7 +827,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			break;
 		}
 
-		ret = vchiq_set_service_option(args.handle, args.option,
+		ret = vchiq_set_service_option(instance, args.handle, args.option,
 					       args.value);
 	} break;
 
@@ -908,6 +908,7 @@ vchiq_compat_ioctl_create_service(struct file *file, unsigned int cmd,
 {
 	struct vchiq_create_service args;
 	struct vchiq_create_service32 args32;
+	struct vchiq_instance *instance = file->private_data;
 	long ret;
 
 	if (copy_from_user(&args32, ptrargs32, sizeof(args32)))
@@ -926,12 +927,12 @@ vchiq_compat_ioctl_create_service(struct file *file, unsigned int cmd,
 		.handle  = args32.handle,
 	};
 
-	ret = vchiq_ioc_create_service(file->private_data, &args);
+	ret = vchiq_ioc_create_service(instance, &args);
 	if (ret < 0)
 		return ret;
 
 	if (put_user(args.handle, &ptrargs32->handle)) {
-		vchiq_remove_service(args.handle);
+		vchiq_remove_service(instance, args.handle);
 		return -EFAULT;
 	}
 
@@ -960,6 +961,7 @@ vchiq_compat_ioctl_queue_message(struct file *file,
 	struct vchiq_queue_message args;
 	struct vchiq_queue_message32 args32;
 	struct vchiq_service *service;
+	struct vchiq_instance *instance = file->private_data;
 	int ret;
 
 	if (copy_from_user(&args32, arg, sizeof(args32)))
@@ -974,7 +976,7 @@ vchiq_compat_ioctl_queue_message(struct file *file,
 	if (args32.count > MAX_ELEMENTS)
 		return -EINVAL;
 
-	service = find_service_for_instance(file->private_data, args.handle);
+	service = find_service_for_instance(instance, args.handle);
 	if (!service)
 		return -EINVAL;
 
@@ -994,7 +996,7 @@ vchiq_compat_ioctl_queue_message(struct file *file,
 				compat_ptr(element32[count].data);
 			elements[count].size = element32[count].size;
 		}
-		ret = vchiq_ioc_queue_message(args.handle, elements,
+		ret = vchiq_ioc_queue_message(instance, args.handle, elements,
 					      args.count);
 	} else {
 		ret = -EINVAL;
@@ -1261,7 +1263,7 @@ static int vchiq_release(struct inode *inode, struct file *file)
 			spin_unlock(&msg_queue_spinlock);
 
 			if (header)
-				vchiq_release_message(service->handle, header);
+				vchiq_release_message(instance, service->handle, header);
 			spin_lock(&msg_queue_spinlock);
 		}
 
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 88813af8de49..a1ab7ab7e908 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -292,7 +292,7 @@ static void buffer_to_host_work_cb(struct work_struct *work)
 		/* Dummy receive to ensure the buffers remain in order */
 		len = 8;
 	/* queue the bulk submission */
-	vchiq_use_service(instance->service_handle);
+	vchiq_use_service(instance->vchiq_instance, instance->service_handle);
 	ret = vchiq_bulk_receive(instance->vchiq_instance, instance->service_handle,
 				 msg_context->u.bulk.buffer->buffer,
 				 /* Actual receive needs to be a multiple
@@ -302,7 +302,7 @@ static void buffer_to_host_work_cb(struct work_struct *work)
 				msg_context,
 				VCHIQ_BULK_MODE_CALLBACK);
 
-	vchiq_release_service(instance->service_handle);
+	vchiq_release_service(instance->vchiq_instance, instance->service_handle);
 
 	if (ret != 0)
 		pr_err("%s: ctx: %p, vchiq_bulk_receive failed %d\n",
@@ -436,15 +436,15 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 	/* no payload in message */
 	m.u.buffer_from_host.payload_in_message = 0;
 
-	vchiq_use_service(instance->service_handle);
+	vchiq_use_service(instance->vchiq_instance, instance->service_handle);
 
-	ret = vchiq_queue_kernel_message(instance->service_handle, &m,
+	ret = vchiq_queue_kernel_message(instance->vchiq_instance, instance->service_handle, &m,
 					 sizeof(struct mmal_msg_header) +
 					 sizeof(m.u.buffer_from_host));
 	if (ret)
 		atomic_dec(&port->buffers_with_vpu);
 
-	vchiq_release_service(instance->service_handle);
+	vchiq_release_service(instance->vchiq_instance, instance->service_handle);
 
 	return ret;
 }
@@ -548,11 +548,12 @@ static void bulk_abort_cb(struct vchiq_mmal_instance *instance,
 }
 
 /* incoming event service callback */
-static enum vchiq_status service_callback(enum vchiq_reason reason,
+static enum vchiq_status service_callback(struct vchiq_instance *vchiq_instance,
+					  enum vchiq_reason reason,
 					  struct vchiq_header *header,
 					  unsigned int handle, void *bulk_ctx)
 {
-	struct vchiq_mmal_instance *instance = vchiq_get_service_userdata(handle);
+	struct vchiq_mmal_instance *instance = vchiq_get_service_userdata(vchiq_instance, handle);
 	u32 msg_len;
 	struct mmal_msg *msg;
 	struct mmal_msg_context *msg_context;
@@ -572,25 +573,25 @@ static enum vchiq_status service_callback(enum vchiq_reason reason,
 		/* handling is different for buffer messages */
 		switch (msg->h.type) {
 		case MMAL_MSG_TYPE_BUFFER_FROM_HOST:
-			vchiq_release_message(handle, header);
+			vchiq_release_message(vchiq_instance, handle, header);
 			break;
 
 		case MMAL_MSG_TYPE_EVENT_TO_HOST:
 			event_to_host_cb(instance, msg, msg_len);
-			vchiq_release_message(handle, header);
+			vchiq_release_message(vchiq_instance, handle, header);
 
 			break;
 
 		case MMAL_MSG_TYPE_BUFFER_TO_HOST:
 			buffer_to_host_cb(instance, msg, msg_len);
-			vchiq_release_message(handle, header);
+			vchiq_release_message(vchiq_instance, handle, header);
 			break;
 
 		default:
 			/* messages dependent on header context to complete */
 			if (!msg->h.context) {
 				pr_err("received message context was null!\n");
-				vchiq_release_message(handle, header);
+				vchiq_release_message(vchiq_instance, handle, header);
 				break;
 			}
 
@@ -599,7 +600,7 @@ static enum vchiq_status service_callback(enum vchiq_reason reason,
 			if (!msg_context) {
 				pr_err("received invalid message context %u!\n",
 				       msg->h.context);
-				vchiq_release_message(handle, header);
+				vchiq_release_message(vchiq_instance, handle, header);
 				break;
 			}
 
@@ -678,13 +679,13 @@ static int send_synchronous_mmal_msg(struct vchiq_mmal_instance *instance,
 	DBG_DUMP_MSG(msg, (sizeof(struct mmal_msg_header) + payload_len),
 		     ">>> sync message");
 
-	vchiq_use_service(instance->service_handle);
+	vchiq_use_service(instance->vchiq_instance, instance->service_handle);
 
-	ret = vchiq_queue_kernel_message(instance->service_handle, msg,
+	ret = vchiq_queue_kernel_message(instance->vchiq_instance, instance->service_handle, msg,
 					 sizeof(struct mmal_msg_header) +
 					 payload_len);
 
-	vchiq_release_service(instance->service_handle);
+	vchiq_release_service(instance->vchiq_instance, instance->service_handle);
 
 	if (ret) {
 		pr_err("error %d queuing message\n", ret);
@@ -824,7 +825,7 @@ static int port_info_set(struct vchiq_mmal_instance *instance,
 		 port->component->handle, port->handle);
 
 release_msg:
-	vchiq_release_message(instance->service_handle, rmsg_handle);
+	vchiq_release_message(instance->vchiq_instance, instance->service_handle, rmsg_handle);
 
 	return ret;
 }
@@ -919,7 +920,7 @@ static int port_info_get(struct vchiq_mmal_instance *instance,
 	pr_debug("%s:result:%d component:0x%x port:%d\n",
 		 __func__, ret, port->component->handle, port->handle);
 
-	vchiq_release_message(instance->service_handle, rmsg_handle);
+	vchiq_release_message(instance->vchiq_instance, instance->service_handle, rmsg_handle);
 
 	return ret;
 }
@@ -967,7 +968,7 @@ static int create_component(struct vchiq_mmal_instance *instance,
 		 component->inputs, component->outputs, component->clocks);
 
 release_msg:
-	vchiq_release_message(instance->service_handle, rmsg_handle);
+	vchiq_release_message(instance->vchiq_instance, instance->service_handle, rmsg_handle);
 
 	return ret;
 }
@@ -1000,7 +1001,7 @@ static int destroy_component(struct vchiq_mmal_instance *instance,
 
 release_msg:
 
-	vchiq_release_message(instance->service_handle, rmsg_handle);
+	vchiq_release_message(instance->vchiq_instance, instance->service_handle, rmsg_handle);
 
 	return ret;
 }
@@ -1032,7 +1033,7 @@ static int enable_component(struct vchiq_mmal_instance *instance,
 	ret = -rmsg->u.component_enable_reply.status;
 
 release_msg:
-	vchiq_release_message(instance->service_handle, rmsg_handle);
+	vchiq_release_message(instance->vchiq_instance, instance->service_handle, rmsg_handle);
 
 	return ret;
 }
@@ -1065,7 +1066,7 @@ static int disable_component(struct vchiq_mmal_instance *instance,
 
 release_msg:
 
-	vchiq_release_message(instance->service_handle, rmsg_handle);
+	vchiq_release_message(instance->vchiq_instance, instance->service_handle, rmsg_handle);
 
 	return ret;
 }
@@ -1097,7 +1098,7 @@ static int get_version(struct vchiq_mmal_instance *instance,
 	*minor_out = rmsg->u.version.minor;
 
 release_msg:
-	vchiq_release_message(instance->service_handle, rmsg_handle);
+	vchiq_release_message(instance->vchiq_instance, instance->service_handle, rmsg_handle);
 
 	return ret;
 }
@@ -1139,7 +1140,7 @@ static int port_action_port(struct vchiq_mmal_instance *instance,
 		 port_action_type_names[action_type], action_type);
 
 release_msg:
-	vchiq_release_message(instance->service_handle, rmsg_handle);
+	vchiq_release_message(instance->vchiq_instance, instance->service_handle, rmsg_handle);
 
 	return ret;
 }
@@ -1187,7 +1188,7 @@ static int port_action_handle(struct vchiq_mmal_instance *instance,
 		 action_type, connect_component_handle, connect_port_handle);
 
 release_msg:
-	vchiq_release_message(instance->service_handle, rmsg_handle);
+	vchiq_release_message(instance->vchiq_instance, instance->service_handle, rmsg_handle);
 
 	return ret;
 }
@@ -1228,7 +1229,7 @@ static int port_parameter_set(struct vchiq_mmal_instance *instance,
 		 ret, port->component->handle, port->handle, parameter_id);
 
 release_msg:
-	vchiq_release_message(instance->service_handle, rmsg_handle);
+	vchiq_release_message(instance->vchiq_instance, instance->service_handle, rmsg_handle);
 
 	return ret;
 }
@@ -1287,7 +1288,7 @@ static int port_parameter_get(struct vchiq_mmal_instance *instance,
 		 ret, port->component->handle, port->handle, parameter_id);
 
 release_msg:
-	vchiq_release_message(instance->service_handle, rmsg_handle);
+	vchiq_release_message(instance->vchiq_instance, instance->service_handle, rmsg_handle);
 
 	return ret;
 }
@@ -1832,9 +1833,9 @@ int vchiq_mmal_finalise(struct vchiq_mmal_instance *instance)
 	if (mutex_lock_interruptible(&instance->vchiq_mutex))
 		return -EINTR;
 
-	vchiq_use_service(instance->service_handle);
+	vchiq_use_service(instance->vchiq_instance, instance->service_handle);
 
-	status = vchiq_close_service(instance->service_handle);
+	status = vchiq_close_service(instance->vchiq_instance, instance->service_handle);
 	if (status != 0)
 		pr_err("mmal-vchiq: VCHIQ close failed\n");
 
@@ -1922,14 +1923,14 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 		goto err_close_services;
 	}
 
-	vchiq_release_service(instance->service_handle);
+	vchiq_release_service(instance->vchiq_instance, instance->service_handle);
 
 	*out_instance = instance;
 
 	return 0;
 
 err_close_services:
-	vchiq_close_service(instance->service_handle);
+	vchiq_close_service(instance->vchiq_instance, instance->service_handle);
 	destroy_workqueue(instance->bulk_wq);
 err_free:
 	kfree(instance);
-- 
2.35.1

