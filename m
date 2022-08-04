Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210875898E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbiHDH6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiHDH6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:58:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F7D2A43B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:58:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1168D20C1D;
        Thu,  4 Aug 2022 07:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659599914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49kxYTbGrjOgOVb5REr+889AVTZUvS522O21Up1xYtA=;
        b=c+UAGiIB3aCXunSF7Nt8pWeM+qG+If9rT0dkxaI4R6tFDXc0h6rVOUeuRMIJjGxfG/WY2Y
        MyO25GdAzugPZB2cjvkvpP9+3lAsPUovmKCTZmuOxFRkEKE8kfUOlNz78EMXyzu70puKxw
        y4Ylg/CtZVLjeCf0/ICdbFSHz4sd3vM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659599914;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49kxYTbGrjOgOVb5REr+889AVTZUvS522O21Up1xYtA=;
        b=lqUsrCubml93K3Us5q8XscJFujSz/3tJ6sNbz3sqEblyTc1+9KZN5gNqcZvPrObOKZlKHJ
        GXzuOeWU/r2DWqDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC82A13AE1;
        Thu,  4 Aug 2022 07:58:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +NIdNSl862IlJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Thu, 04 Aug 2022 07:58:33 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     dri-devel@lists.freedesktop.org
Cc:     Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/udl: Sync pending URBs at suspend / disconnect
Date:   Thu,  4 Aug 2022 09:58:24 +0200
Message-Id: <20220804075826.27036-3-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220804075826.27036-1-tiwai@suse.de>
References: <20220804075826.27036-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to wait for finishing to process the all URBs after disabling
the pipe; otherwise pending URBs may stray at suspend/resume, leading
to a possible memory corruption in a worst case.

Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/udl/udl_drv.h     |  1 +
 drivers/gpu/drm/udl/udl_main.c    | 17 +++++++++++++++++
 drivers/gpu/drm/udl/udl_modeset.c |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index e008686ec738..f01e50c5b7b7 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -83,6 +83,7 @@ static inline struct urb *udl_get_urb(struct drm_device *dev)
 }
 
 int udl_submit_urb(struct drm_device *dev, struct urb *urb, size_t len);
+int udl_sync_pending_urbs(struct drm_device *dev);
 void udl_urb_completion(struct urb *urb);
 
 int udl_init(struct udl_device *udl);
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 67fd41e59b80..93615648414b 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -270,6 +270,23 @@ int udl_submit_urb(struct drm_device *dev, struct urb *urb, size_t len)
 	return ret;
 }
 
+/* wait until all pending URBs have been processed */
+int udl_sync_pending_urbs(struct drm_device *dev)
+{
+	struct udl_device *udl = to_udl(dev);
+	int ret = 0;
+
+	spin_lock_irq(&udl->urbs.lock);
+	/* 2 seconds as a sane timeout */
+	if (!wait_event_lock_irq_timeout(udl->urbs.sleep,
+					 udl->urbs.available == udl->urbs.count,
+					 udl->urbs.lock,
+					 msecs_to_jiffies(2000)))
+		ret = -ETIMEDOUT;
+	spin_unlock_irq(&udl->urbs.lock);
+	return ret;
+}
+
 int udl_init(struct udl_device *udl)
 {
 	struct drm_device *dev = &udl->drm;
diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index e67c40a48fb4..50025606b6ad 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -408,6 +408,8 @@ udl_simple_display_pipe_disable(struct drm_simple_display_pipe *pipe)
 	buf = udl_dummy_render(buf);
 
 	udl_submit_urb(dev, urb, buf - (char *)urb->transfer_buffer);
+
+	udl_sync_pending_urbs(dev);
 }
 
 static void
-- 
2.35.3

