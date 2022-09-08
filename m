Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC2F5B1957
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiIHJwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiIHJv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:51:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C39412953C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:51:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C9CC41FA59;
        Thu,  8 Sep 2022 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662630680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bR6925bATQ7HBwtVi4TMBDIx4hc6ASExKA+1S58qoA=;
        b=zGEde7fmTnmSuqSBrK84rEO6QfGia6W5j/bX4CNRoVA3lZOhuPKRfow6JCdHDLcJoQ4jXt
        W1LxpgDrmZaz69UkoDHpTDv8A6yqYYrKoMfEieIpS2LXGe13ZQTXJZ/J2FrfRnJpWjidB7
        ZQKfz7A7bislKbNfJKX+dq9s9/VBP9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662630680;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bR6925bATQ7HBwtVi4TMBDIx4hc6ASExKA+1S58qoA=;
        b=Kf83t+qWarwS74WtM3omM3CvLALSUMAzFkoX13tfnkn3atW+If2WGp0k/MRmzWyyz149UC
        kIu7fbwjcaRvOOCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9678813A72;
        Thu,  8 Sep 2022 09:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cHcSJBi7GWNrUgAAMHmgww
        (envelope-from <tiwai@suse.de>); Thu, 08 Sep 2022 09:51:20 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/12] drm/udl: Sync pending URBs at the end of suspend
Date:   Thu,  8 Sep 2022 11:51:15 +0200
Message-Id: <20220908095115.23396-13-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220908095115.23396-1-tiwai@suse.de>
References: <20220908095115.23396-1-tiwai@suse.de>
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

It's better to perform the sync at the very last of the suspend
instead of the pipe-disable function, so that we can catch all pending
URBs (if any).

While we're at it, drop the error code from udl_sync_pending_urb()
since we basically ignore it; instead, give a clear error message
indicating a problem.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/udl/udl_drv.c     | 8 +++++++-
 drivers/gpu/drm/udl/udl_drv.h     | 2 +-
 drivers/gpu/drm/udl/udl_main.c    | 6 ++----
 drivers/gpu/drm/udl/udl_modeset.c | 2 --
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 0ba88e5472a9..91effdcefb6d 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -21,8 +21,14 @@ static int udl_usb_suspend(struct usb_interface *interface,
 			   pm_message_t message)
 {
 	struct drm_device *dev = usb_get_intfdata(interface);
+	int ret;
 
-	return drm_mode_config_helper_suspend(dev);
+	ret = drm_mode_config_helper_suspend(dev);
+	if (ret)
+		return ret;
+
+	udl_sync_pending_urbs(dev);
+	return 0;
 }
 
 static int udl_usb_resume(struct usb_interface *interface)
diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index d943684b5bbb..b4cc7cc568c7 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -77,7 +77,7 @@ struct drm_connector *udl_connector_init(struct drm_device *dev);
 struct urb *udl_get_urb(struct drm_device *dev);
 
 int udl_submit_urb(struct drm_device *dev, struct urb *urb, size_t len);
-int udl_sync_pending_urbs(struct drm_device *dev);
+void udl_sync_pending_urbs(struct drm_device *dev);
 void udl_urb_completion(struct urb *urb);
 
 int udl_init(struct udl_device *udl);
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 829edb60a987..061cb88c08a2 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -290,10 +290,9 @@ int udl_submit_urb(struct drm_device *dev, struct urb *urb, size_t len)
 }
 
 /* wait until all pending URBs have been processed */
-int udl_sync_pending_urbs(struct drm_device *dev)
+void udl_sync_pending_urbs(struct drm_device *dev)
 {
 	struct udl_device *udl = to_udl(dev);
-	int ret = 0;
 
 	spin_lock_irq(&udl->urbs.lock);
 	/* 2 seconds as a sane timeout */
@@ -301,9 +300,8 @@ int udl_sync_pending_urbs(struct drm_device *dev)
 					 udl->urbs.available == udl->urbs.count,
 					 udl->urbs.lock,
 					 msecs_to_jiffies(2000)))
-		ret = -ETIMEDOUT;
+		drm_err(dev, "Timeout for syncing pending URBs\n");
 	spin_unlock_irq(&udl->urbs.lock);
-	return ret;
 }
 
 int udl_init(struct udl_device *udl)
diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 0142fc6a478a..d4f409f6d533 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -378,8 +378,6 @@ udl_simple_display_pipe_disable(struct drm_simple_display_pipe *pipe)
 	buf = udl_dummy_render(buf);
 
 	udl_submit_urb(dev, urb, buf - (char *)urb->transfer_buffer);
-
-	udl_sync_pending_urbs(dev);
 }
 
 static void
-- 
2.35.3

