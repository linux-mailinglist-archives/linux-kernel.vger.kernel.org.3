Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658FB595F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiHPPit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbiHPPiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:38:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830B6832CB
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:37:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 370543471E;
        Tue, 16 Aug 2022 15:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660664222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLnZ81N68p1pCRNQDGd4aZufCAeqClMy0Swaf735zVw=;
        b=0s5Av3B6KNoTHWiXK0NNOTDIFFCPmJxC10giYosPgbzQ9XaTPEeSeooEAhZEOceNA1DUnW
        y52NTaKnpXJf2ifIe8hNUx1kN/F7ePk2JJiRKjNrM9Nrrzze3316Oak3/a49OqhGhjrqXL
        4itUSqKO/x0HtNvnd7ODcDUEpjF1w1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660664222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLnZ81N68p1pCRNQDGd4aZufCAeqClMy0Swaf735zVw=;
        b=ZSGd0x1axx4rukLQ6BtzKxJXIm47o4Cjh1gbmvA0yxcm04X0oUDw1Wno4dWnGhuOCapt8H
        eDGrXdHzQroZo2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D35DC139B7;
        Tue, 16 Aug 2022 15:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4DnbMp25+2LKJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 16 Aug 2022 15:37:01 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] Revert "drm/udl: Kill pending URBs at suspend and disconnect"
Date:   Tue, 16 Aug 2022 17:36:47 +0200
Message-Id: <20220816153655.27526-5-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220816153655.27526-1-tiwai@suse.de>
References: <20220816153655.27526-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts the recent fix commit
  e25d5954264d ("drm/udl: Kill pending URBs at suspend and disconnect")
as it turned out to lead to potential hangup at a disconnection, and
it doesn't help much for suspend/resume problem, either.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/udl/udl_drv.h     |  2 --
 drivers/gpu/drm/udl/udl_main.c    | 25 +++----------------------
 drivers/gpu/drm/udl/udl_modeset.c |  2 --
 3 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index 37c14b0ff1fc..5923d2e02bc8 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -39,7 +39,6 @@ struct urb_node {
 
 struct urb_list {
 	struct list_head list;
-	struct list_head in_flight;
 	spinlock_t lock;
 	wait_queue_head_t sleep;
 	int available;
@@ -85,7 +84,6 @@ static inline struct urb *udl_get_urb(struct drm_device *dev)
 
 int udl_submit_urb(struct drm_device *dev, struct urb *urb, size_t len);
 int udl_sync_pending_urbs(struct drm_device *dev);
-void udl_kill_pending_urbs(struct drm_device *dev);
 void udl_urb_completion(struct urb *urb);
 
 int udl_init(struct udl_device *udl);
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 7d1e6bbc165c..a9f6b710b254 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -135,7 +135,7 @@ void udl_urb_completion(struct urb *urb)
 	urb->transfer_buffer_length = udl->urbs.size; /* reset to actual */
 
 	spin_lock_irqsave(&udl->urbs.lock, flags);
-	list_move(&unode->entry, &udl->urbs.list);
+	list_add_tail(&unode->entry, &udl->urbs.list);
 	udl->urbs.available++;
 	spin_unlock_irqrestore(&udl->urbs.lock, flags);
 
@@ -180,7 +180,6 @@ static int udl_alloc_urb_list(struct drm_device *dev, int count, size_t size)
 retry:
 	udl->urbs.size = size;
 	INIT_LIST_HEAD(&udl->urbs.list);
-	INIT_LIST_HEAD(&udl->urbs.in_flight);
 
 	init_waitqueue_head(&udl->urbs.sleep);
 	udl->urbs.count = 0;
@@ -247,7 +246,7 @@ struct urb *udl_get_urb_timeout(struct drm_device *dev, long timeout)
 	}
 
 	unode = list_first_entry(&udl->urbs.list, struct urb_node, entry);
-	list_move(&unode->entry, &udl->urbs.in_flight);
+	list_del_init(&unode->entry);
 	udl->urbs.available--;
 
 unlock:
@@ -281,7 +280,7 @@ int udl_sync_pending_urbs(struct drm_device *dev)
 	spin_lock_irq(&udl->urbs.lock);
 	/* 2 seconds as a sane timeout */
 	if (!wait_event_lock_irq_timeout(udl->urbs.sleep,
-					 list_empty(&udl->urbs.in_flight),
+					 udl->urbs.available == udl->urbs.count,
 					 udl->urbs.lock,
 					 msecs_to_jiffies(2000)))
 		ret = -ETIMEDOUT;
@@ -289,23 +288,6 @@ int udl_sync_pending_urbs(struct drm_device *dev)
 	return ret;
 }
 
-/* kill pending URBs */
-void udl_kill_pending_urbs(struct drm_device *dev)
-{
-	struct udl_device *udl = to_udl(dev);
-	struct urb_node *unode;
-
-	spin_lock_irq(&udl->urbs.lock);
-	while (!list_empty(&udl->urbs.in_flight)) {
-		unode = list_first_entry(&udl->urbs.in_flight,
-					 struct urb_node, entry);
-		spin_unlock_irq(&udl->urbs.lock);
-		usb_kill_urb(unode->urb);
-		spin_lock_irq(&udl->urbs.lock);
-	}
-	spin_unlock_irq(&udl->urbs.lock);
-}
-
 int udl_init(struct udl_device *udl)
 {
 	struct drm_device *dev = &udl->drm;
@@ -354,7 +336,6 @@ int udl_drop_usb(struct drm_device *dev)
 {
 	struct udl_device *udl = to_udl(dev);
 
-	udl_kill_pending_urbs(dev);
 	udl_free_urb_list(dev);
 	put_device(udl->dmadev);
 	udl->dmadev = NULL;
diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 187aba2d7825..c34d564773a3 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -398,8 +398,6 @@ udl_simple_display_pipe_disable(struct drm_simple_display_pipe *pipe)
 	struct urb *urb;
 	char *buf;
 
-	udl_kill_pending_urbs(dev);
-
 	urb = udl_get_urb(dev);
 	if (!urb)
 		return;
-- 
2.35.3

