Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B12C595F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiHPPjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbiHPPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:38:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D2B85F8F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:37:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE7E43487D;
        Tue, 16 Aug 2022 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660664223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Z32l5W23yTSTP0OL/EUtz6ANPUmFtsKosb80qSNkvk=;
        b=BFFhVNm3HGgXF7L/30aCbLh/sS/lMdy/88gpyjJjwfqASsooG2hcQE0QnqSLjA850kefHe
        vuApyXb/Xl4zA5q/BKmSPV12f+jZin2uP5aqVhsSwMNAJbW4o4+SwrKdpODliopvAvJy8+
        KXlbZP4pttisG8jI508wjeTjQ0mAn/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660664223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Z32l5W23yTSTP0OL/EUtz6ANPUmFtsKosb80qSNkvk=;
        b=Aoh92dWT4WKneM8Mi4pdBou8wIW4W4QrbeDoH1bLm9JKQFT4IMUgKmezmrgYnMWMVcnCiK
        jc1WDYbAPwwXAJBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F70013B1A;
        Tue, 16 Aug 2022 15:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QKp/Ip+5+2LKJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 16 Aug 2022 15:37:03 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] drm/udl: Fix inconsistent urbs.count value during udl_free_urb_list()
Date:   Tue, 16 Aug 2022 17:36:53 +0200
Message-Id: <20220816153655.27526-11-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220816153655.27526-1-tiwai@suse.de>
References: <20220816153655.27526-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current design, udl_get_urb() may be called asynchronously
during the driver freeing its URL list via udl_free_urb_list().
The problem is that the sync is determined by comparing the urbs.count
and urbs.available fields, while we clear urbs.count field only once
after udl_free_urb_list() finishes, i.e. during udl_free_urb_list(),
the state becomes inconsistent.

For fixing this inconsistency and also for hardening the locking
scheme, this patch does a slight refactoring of the code around
udl_get_urb() and udl_free_urb_list().  Now urbs.count is updated in
the same spinlock at extracting a URB from the list in
udl_free_url_list().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/udl/udl_drv.h  |  8 +-------
 drivers/gpu/drm/udl/udl_main.c | 37 ++++++++++++++++++++++++----------
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index 5923d2e02bc8..d943684b5bbb 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -74,13 +74,7 @@ static inline struct usb_device *udl_to_usb_device(struct udl_device *udl)
 int udl_modeset_init(struct drm_device *dev);
 struct drm_connector *udl_connector_init(struct drm_device *dev);
 
-struct urb *udl_get_urb_timeout(struct drm_device *dev, long timeout);
-
-#define GET_URB_TIMEOUT	HZ
-static inline struct urb *udl_get_urb(struct drm_device *dev)
-{
-	return udl_get_urb_timeout(dev, GET_URB_TIMEOUT);
-}
+struct urb *udl_get_urb(struct drm_device *dev);
 
 int udl_submit_urb(struct drm_device *dev, struct urb *urb, size_t len);
 int udl_sync_pending_urbs(struct drm_device *dev);
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 8bbb4e2861fb..19dc8317e843 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -28,6 +28,8 @@
 static uint udl_num_urbs = WRITES_IN_FLIGHT;
 module_param_named(numurbs, udl_num_urbs, uint, 0600);
 
+static struct urb *__udl_get_urb(struct udl_device *udl, long timeout);
+
 static int udl_parse_vendor_descriptor(struct udl_device *udl)
 {
 	struct usb_device *udev = udl_to_usb_device(udl);
@@ -151,15 +153,17 @@ void udl_urb_completion(struct urb *urb)
 static void udl_free_urb_list(struct drm_device *dev)
 {
 	struct udl_device *udl = to_udl(dev);
-	int count = udl->urbs.count;
 	struct urb_node *unode;
 	struct urb *urb;
 
 	DRM_DEBUG("Waiting for completes and freeing all render urbs\n");
 
 	/* keep waiting and freeing, until we've got 'em all */
-	while (count--) {
-		urb = udl_get_urb_timeout(dev, MAX_SCHEDULE_TIMEOUT);
+	while (udl->urbs.count) {
+		spin_lock_irq(&udl->urbs.lock);
+		urb = __udl_get_urb(udl, MAX_SCHEDULE_TIMEOUT);
+		udl->urbs.count--;
+		spin_unlock_irq(&udl->urbs.lock);
 		if (WARN_ON(!urb))
 			break;
 		unode = urb->context;
@@ -169,7 +173,8 @@ static void udl_free_urb_list(struct drm_device *dev)
 		usb_free_urb(urb);
 		kfree(unode);
 	}
-	udl->urbs.count = 0;
+
+	wake_up(&udl->urbs.sleep);
 }
 
 static int udl_alloc_urb_list(struct drm_device *dev, int count, size_t size)
@@ -233,33 +238,43 @@ static int udl_alloc_urb_list(struct drm_device *dev, int count, size_t size)
 	return udl->urbs.count;
 }
 
-struct urb *udl_get_urb_timeout(struct drm_device *dev, long timeout)
+static struct urb *__udl_get_urb(struct udl_device *udl, long timeout)
 {
-	struct udl_device *udl = to_udl(dev);
-	struct urb_node *unode = NULL;
+	struct urb_node *unode;
+
+	assert_spin_locked(&udl->urbs.lock);
 
 	if (!udl->urbs.count)
 		return NULL;
 
 	/* Wait for an in-flight buffer to complete and get re-queued */
-	spin_lock_irq(&udl->urbs.lock);
 	if (!wait_event_lock_irq_timeout(udl->urbs.sleep,
 					 !list_empty(&udl->urbs.list),
 					 udl->urbs.lock, timeout)) {
 		DRM_INFO("wait for urb interrupted: available: %d\n",
 			 udl->urbs.available);
-		goto unlock;
+		return NULL;
 	}
 
 	unode = list_first_entry(&udl->urbs.list, struct urb_node, entry);
 	list_del_init(&unode->entry);
 	udl->urbs.available--;
 
-unlock:
-	spin_unlock_irq(&udl->urbs.lock);
 	return unode ? unode->urb : NULL;
 }
 
+#define GET_URB_TIMEOUT	HZ
+struct urb *udl_get_urb(struct drm_device *dev)
+{
+	struct udl_device *udl = to_udl(dev);
+	struct urb *urb;
+
+	spin_lock_irq(&udl->urbs.lock);
+	urb = __udl_get_urb(udl, GET_URB_TIMEOUT);
+	spin_unlock_irq(&udl->urbs.lock);
+	return urb;
+}
+
 int udl_submit_urb(struct drm_device *dev, struct urb *urb, size_t len)
 {
 	struct udl_device *udl = to_udl(dev);
-- 
2.35.3

