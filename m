Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1CC52F2FB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352802AbiETSe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352681AbiETSeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:34:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A285FF06;
        Fri, 20 May 2022 11:34:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u27so11789227wru.8;
        Fri, 20 May 2022 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GvSQBhpvLDyleu1LIfP8VMG0wWB85CIJW6YgQSKRQow=;
        b=j8WOrlNFUeG3r+YDMsurwgDUfVhCy+6sY15G27qSeJ6zBhCyBEw1Grn4zjFwVjMsRB
         y0//yAd/WOUGXbXI7ZdGaGG1uiWABD6y20n9GAPi2NtOsChdihJIJDSWYlv1aLClg8YB
         f+dLj82vxePduYXHoGnzOKNRXc/5Jyt+hyW3LHjL8Lhg00bk6HA700sF7alrsvh3kNS6
         nYhy61QXst7HVg/gmqLMayBcQd/ZqAFXI8qyxzxmMKrXVeXJPO90AcznBgNexiAYOThY
         R/Qnr5eitHhAaalCdl93SnicBVYPqZQCdoSsiefqQuUbwx+l4IZ+F90Dcbd6sbnCCkzd
         xUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GvSQBhpvLDyleu1LIfP8VMG0wWB85CIJW6YgQSKRQow=;
        b=mJebUDAVwONvw6/oTjoHrlIQbl2BnPxXUUdfu4bA6SIcreAfjWcsCngeWhCdo4edu+
         +pI39aEdoMdm4E0xMiQK7LCOHwAAc2zP9yQHrWHzBFl7XO70v7kqVZqhr+4MuJD5f791
         bkoC8K6KzSNiW0nrG1hhtzvui3fURtjrCfrbqk6kq1quTGFtVTGkwV4h/gsLvOOQaH+l
         znOa3raiDVmuV92bpLWboRYXN4b5yXJpqfC/03OeJutFcuWnSzANALXTzUCD3M+PiAqW
         xUXcf3MZhgBq01knJCDk8puvePzzhazKXtkZ4+r4/I7B/y8V60EbLBfra2HX1msTUPdO
         6cyg==
X-Gm-Message-State: AOAM532qTjXZUjVikIHLRsPkzJWry0CRg8kNP3/fMQz3+uFallWikPdL
        2ixPMvwLP+01rJb/G0UMK8Y=
X-Google-Smtp-Source: ABdhPJymYAYSUfXRKsn0YR3ilQcBY4C5ohTnSx6mbeXGe3fsjIGMyVJPc0guX9pECLmCHnRxQz8c3g==
X-Received: by 2002:a5d:64c8:0:b0:20c:6970:fb22 with SMTP id f8-20020a5d64c8000000b0020c6970fb22mr9279097wri.424.1653071682985;
        Fri, 20 May 2022 11:34:42 -0700 (PDT)
Received: from xws.localdomain (pd9e5a9fe.dip0.t-ipconnect.de. [217.229.169.254])
        by smtp.gmail.com with ESMTPSA id r9-20020adfa149000000b0020e62feca05sm3252081wrr.32.2022.05.20.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:34:42 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] platform/surface: aggregator: Allow notifiers to avoid communication on unregistering
Date:   Fri, 20 May 2022 20:34:14 +0200
Message-Id: <20220520183422.7185-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520183422.7185-1-luzmaximilian@gmail.com>
References: <20220520183422.7185-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SSAM client devices have been (physically) hot-removed,
communication attempts with those devices may fail and time out. This
can even extend to event notifiers, due to which timeouts may occur
during device removal, slowing down that process.

Add a parameter to the notifier unregister function that allows skipping
communication with the EC to prevent this. Furthermore, add wrappers for
registering and unregistering notifiers belonging to SSAM client devices
that automatically check if the device has been marked as hot-removed
and communication should be avoided.

Note that non-SSAM client devices can generally not be hot-removed, so
also add a convenience wrapper for those, defaulting to allow
communication.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../driver-api/surface_aggregator/client.rst  |  6 +-
 .../platform/surface/aggregator/controller.c  | 53 ++++++++++-----
 include/linux/surface_aggregator/controller.h | 24 ++++++-
 include/linux/surface_aggregator/device.h     | 66 +++++++++++++++++++
 4 files changed, 128 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/surface_aggregator/client.rst b/Documentation/driver-api/surface_aggregator/client.rst
index e519d374c378..27f95abdbe99 100644
--- a/Documentation/driver-api/surface_aggregator/client.rst
+++ b/Documentation/driver-api/surface_aggregator/client.rst
@@ -17,6 +17,8 @@
 .. |SSAM_DEVICE| replace:: :c:func:`SSAM_DEVICE`
 .. |ssam_notifier_register| replace:: :c:func:`ssam_notifier_register`
 .. |ssam_notifier_unregister| replace:: :c:func:`ssam_notifier_unregister`
+.. |ssam_device_notifier_register| replace:: :c:func:`ssam_device_notifier_register`
+.. |ssam_device_notifier_unregister| replace:: :c:func:`ssam_device_notifier_unregister`
 .. |ssam_request_sync| replace:: :c:func:`ssam_request_sync`
 .. |ssam_event_mask| replace:: :c:type:`enum ssam_event_mask <ssam_event_mask>`
 
@@ -312,7 +314,9 @@ Handling Events
 To receive events from the SAM EC, an event notifier must be registered for
 the desired event via |ssam_notifier_register|. The notifier must be
 unregistered via |ssam_notifier_unregister| once it is not required any
-more.
+more. For |ssam_device| type clients, the |ssam_device_notifier_register| and
+|ssam_device_notifier_unregister| wrappers should be preferred as they properly
+handle hot-removal of client devices.
 
 Event notifiers are registered by providing (at minimum) a callback to call
 in case an event has been received, the registry specifying how the event
diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index b8c377b3f932..6de834b52b63 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -2199,16 +2199,26 @@ static int ssam_nf_refcount_enable(struct ssam_controller *ctrl,
 }
 
 /**
- * ssam_nf_refcount_disable_free() - Disable event for reference count entry if it is
- * no longer in use and free the corresponding entry.
+ * ssam_nf_refcount_disable_free() - Disable event for reference count entry if
+ * it is no longer in use and free the corresponding entry.
  * @ctrl:  The controller to disable the event on.
  * @entry: The reference count entry for the event to be disabled.
  * @flags: The flags used for enabling the event on the EC.
+ * @ec:    Flag specifying if the event should actually be disabled on the EC.
  *
- * If the reference count equals zero, i.e. the event is no longer requested by
- * any client, the event will be disabled and the corresponding reference count
- * entry freed. The reference count entry must not be used any more after a
- * call to this function.
+ * If ``ec`` equals ``true`` and the reference count equals zero (i.e. the
+ * event is no longer requested by any client), the specified event will be
+ * disabled on the EC via the corresponding request.
+ *
+ * If ``ec`` equals ``false``, no request will be sent to the EC and the event
+ * can be considered in a detached state (i.e. no longer used but still
+ * enabled). Disabling an event via this method may be required for
+ * hot-removable devices, where event disable requests may time out after the
+ * device has been physically removed.
+ *
+ * In both cases, if the reference count equals zero, the corresponding
+ * reference count entry will be freed. The reference count entry must not be
+ * used any more after a call to this function.
  *
  * Also checks if the flags used for disabling the event match the flags used
  * for enabling the event and warns if they do not (regardless of reference
@@ -2223,7 +2233,7 @@ static int ssam_nf_refcount_enable(struct ssam_controller *ctrl,
  * returns the status of the event-enable EC command.
  */
 static int ssam_nf_refcount_disable_free(struct ssam_controller *ctrl,
-					 struct ssam_nf_refcount_entry *entry, u8 flags)
+					 struct ssam_nf_refcount_entry *entry, u8 flags, bool ec)
 {
 	const struct ssam_event_registry reg = entry->key.reg;
 	const struct ssam_event_id id = entry->key.id;
@@ -2232,8 +2242,9 @@ static int ssam_nf_refcount_disable_free(struct ssam_controller *ctrl,
 
 	lockdep_assert_held(&nf->lock);
 
-	ssam_dbg(ctrl, "disabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
-		 reg.target_category, id.target_category, id.instance, entry->refcount);
+	ssam_dbg(ctrl, "%s event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
+		 ec ? "disabling" : "detaching", reg.target_category, id.target_category,
+		 id.instance, entry->refcount);
 
 	if (entry->flags != flags) {
 		ssam_warn(ctrl,
@@ -2242,7 +2253,7 @@ static int ssam_nf_refcount_disable_free(struct ssam_controller *ctrl,
 			  id.instance);
 	}
 
-	if (entry->refcount == 0) {
+	if (ec && entry->refcount == 0) {
 		status = ssam_ssh_event_disable(ctrl, reg, id, flags);
 		kfree(entry);
 	}
@@ -2322,20 +2333,26 @@ int ssam_notifier_register(struct ssam_controller *ctrl, struct ssam_event_notif
 EXPORT_SYMBOL_GPL(ssam_notifier_register);
 
 /**
- * ssam_notifier_unregister() - Unregister an event notifier.
- * @ctrl: The controller the notifier has been registered on.
- * @n:    The event notifier to unregister.
+ * __ssam_notifier_unregister() - Unregister an event notifier.
+ * @ctrl:    The controller the notifier has been registered on.
+ * @n:       The event notifier to unregister.
+ * @disable: Whether to disable the corresponding event on the EC.
  *
  * Unregister an event notifier. Decrement the usage counter of the associated
  * SAM event if the notifier is not marked as an observer. If the usage counter
- * reaches zero, the event will be disabled.
+ * reaches zero and ``disable`` equals ``true``, the event will be disabled.
+ *
+ * Useful for hot-removable devices, where communication may fail once the
+ * device has been physically removed. In that case, specifying ``disable`` as
+ * ``false`` avoids communication with the EC.
  *
  * Return: Returns zero on success, %-ENOENT if the given notifier block has
  * not been registered on the controller. If the given notifier block was the
  * last one associated with its specific event, returns the status of the
  * event-disable EC-command.
  */
-int ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_notifier *n)
+int __ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_notifier *n,
+			       bool disable)
 {
 	u16 rqid = ssh_tc_to_rqid(n->event.id.target_category);
 	struct ssam_nf_refcount_entry *entry;
@@ -2373,7 +2390,7 @@ int ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_not
 			goto remove;
 		}
 
-		status = ssam_nf_refcount_disable_free(ctrl, entry, n->event.flags);
+		status = ssam_nf_refcount_disable_free(ctrl, entry, n->event.flags, disable);
 	}
 
 remove:
@@ -2383,7 +2400,7 @@ int ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_not
 
 	return status;
 }
-EXPORT_SYMBOL_GPL(ssam_notifier_unregister);
+EXPORT_SYMBOL_GPL(__ssam_notifier_unregister);
 
 /**
  * ssam_controller_event_enable() - Enable the specified event.
@@ -2477,7 +2494,7 @@ int ssam_controller_event_disable(struct ssam_controller *ctrl,
 		return -ENOENT;
 	}
 
-	status = ssam_nf_refcount_disable_free(ctrl, entry, flags);
+	status = ssam_nf_refcount_disable_free(ctrl, entry, flags, true);
 
 	mutex_unlock(&nf->lock);
 	return status;
diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
index 74bfdffaf7b0..50a2b4926c06 100644
--- a/include/linux/surface_aggregator/controller.h
+++ b/include/linux/surface_aggregator/controller.h
@@ -835,8 +835,28 @@ struct ssam_event_notifier {
 int ssam_notifier_register(struct ssam_controller *ctrl,
 			   struct ssam_event_notifier *n);
 
-int ssam_notifier_unregister(struct ssam_controller *ctrl,
-			     struct ssam_event_notifier *n);
+int __ssam_notifier_unregister(struct ssam_controller *ctrl,
+			       struct ssam_event_notifier *n, bool disable);
+
+/**
+ * ssam_notifier_unregister() - Unregister an event notifier.
+ * @ctrl:    The controller the notifier has been registered on.
+ * @n:       The event notifier to unregister.
+ *
+ * Unregister an event notifier. Decrement the usage counter of the associated
+ * SAM event if the notifier is not marked as an observer. If the usage counter
+ * reaches zero, the event will be disabled.
+ *
+ * Return: Returns zero on success, %-ENOENT if the given notifier block has
+ * not been registered on the controller. If the given notifier block was the
+ * last one associated with its specific event, returns the status of the
+ * event-disable EC-command.
+ */
+static inline int ssam_notifier_unregister(struct ssam_controller *ctrl,
+					   struct ssam_event_notifier *n)
+{
+	return __ssam_notifier_unregister(ctrl, n, true);
+}
 
 int ssam_controller_event_enable(struct ssam_controller *ctrl,
 				 struct ssam_event_registry reg,
diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index 491aa7e9f4bc..ad245c6b00d0 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -472,4 +472,70 @@ static inline void ssam_remove_clients(struct device *dev) {}
 				    sdev->uid.instance, ret);		\
 	}
 
+
+/* -- Helpers for client-device notifiers. ---------------------------------- */
+
+/**
+ * ssam_device_notifier_register() - Register an event notifier for the
+ * specified client device.
+ * @sdev: The device the notifier should be registered on.
+ * @n:    The event notifier to register.
+ *
+ * Register an event notifier. Increment the usage counter of the associated
+ * SAM event if the notifier is not marked as an observer. If the event is not
+ * marked as an observer and is currently not enabled, it will be enabled
+ * during this call. If the notifier is marked as an observer, no attempt will
+ * be made at enabling any event and no reference count will be modified.
+ *
+ * Notifiers marked as observers do not need to be associated with one specific
+ * event, i.e. as long as no event matching is performed, only the event target
+ * category needs to be set.
+ *
+ * Return: Returns zero on success, %-ENOSPC if there have already been
+ * %INT_MAX notifiers for the event ID/type associated with the notifier block
+ * registered, %-ENOMEM if the corresponding event entry could not be
+ * allocated, %-ENODEV if the device is marked as hot-removed. If this is the
+ * first time that a notifier block is registered for the specific associated
+ * event, returns the status of the event-enable EC-command.
+ */
+static inline int ssam_device_notifier_register(struct ssam_device *sdev,
+						struct ssam_event_notifier *n)
+{
+	/*
+	 * Note that this check does not provide any guarantees whatsoever as
+	 * hot-removal could happen at any point and we can't protect against
+	 * it. Nevertheless, if we can detect hot-removal, bail early to avoid
+	 * communication timeouts.
+	 */
+	if (ssam_device_is_hot_removed(sdev))
+		return -ENODEV;
+
+	return ssam_notifier_register(sdev->ctrl, n);
+}
+
+/**
+ * ssam_device_notifier_unregister() - Unregister an event notifier for the
+ * specified client device.
+ * @sdev: The device the notifier has been registered on.
+ * @n:    The event notifier to unregister.
+ *
+ * Unregister an event notifier. Decrement the usage counter of the associated
+ * SAM event if the notifier is not marked as an observer. If the usage counter
+ * reaches zero, the event will be disabled.
+ *
+ * In case the device has been marked as hot-removed, the event will not be
+ * disabled on the EC, as in those cases any attempt at doing so may time out.
+ *
+ * Return: Returns zero on success, %-ENOENT if the given notifier block has
+ * not been registered on the controller. If the given notifier block was the
+ * last one associated with its specific event, returns the status of the
+ * event-disable EC-command.
+ */
+static inline int ssam_device_notifier_unregister(struct ssam_device *sdev,
+						  struct ssam_event_notifier *n)
+{
+	return __ssam_notifier_unregister(sdev->ctrl, n,
+					  !ssam_device_is_hot_removed(sdev));
+}
+
 #endif /* _LINUX_SURFACE_AGGREGATOR_DEVICE_H */
-- 
2.36.1

