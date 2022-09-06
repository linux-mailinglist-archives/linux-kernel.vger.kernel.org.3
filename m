Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F3E5AE167
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiIFHkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbiIFHj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:39:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252F323141
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:39:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AFDCE1F966;
        Tue,  6 Sep 2022 07:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662449995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MFrqvGzeWUMBgRnnt6RmzgBnVbJb1zQ0TJYrr0s+8lU=;
        b=YbMMu99v+YQF+axHLa4iY8zCInUofABW6JVreUid+LDTwvG9dnO2cY62V/+NM15HWgAVvM
        D6LW0mnziREwrkitUYyAJ9BPw61WnUAz7b5YNgBvWs7829PivZ+Tz5DjzNbmqXp7pgO7MS
        JqggKb8ax6n60UbxAbPHeijtK9KbiJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662449995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MFrqvGzeWUMBgRnnt6RmzgBnVbJb1zQ0TJYrr0s+8lU=;
        b=3ERnL2zKHaOh/88VP1Xzb2Bb24VVNPBS4m0jdSEIxK3vNTkXYTzcytevRfG4D0DpT6eZFl
        nSRzsWQ4jG0ChwBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 932E613A7A;
        Tue,  6 Sep 2022 07:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WMkLI0v5FmPeOgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 06 Sep 2022 07:39:55 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] drm/udl: Fix potential URB leaks
Date:   Tue,  6 Sep 2022 09:39:48 +0200
Message-Id: <20220906073951.2085-9-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906073951.2085-1-tiwai@suse.de>
References: <20220906073951.2085-1-tiwai@suse.de>
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

A couple of error handlings forgot to process the URB completion.
Those are both with WARN_ON() so should be visible, but we must fix
them in anyway.

Fixes: 7350b2a3fbc6 ("drm/udl: Replace BUG_ON() with WARN_ON()")
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/udl/udl_main.c     | 8 +++++---
 drivers/gpu/drm/udl/udl_transfer.c | 5 ++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 2b7eafd48ec2..de28eeff3155 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -260,11 +260,13 @@ int udl_submit_urb(struct drm_device *dev, struct urb *urb, size_t len)
 	struct udl_device *udl = to_udl(dev);
 	int ret;
 
-	if (WARN_ON(len > udl->urbs.size))
-		return -EINVAL;
-
+	if (WARN_ON(len > udl->urbs.size)) {
+		ret = -EINVAL;
+		goto error;
+	}
 	urb->transfer_buffer_length = len; /* set to actual payload len */
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
+ error:
 	if (ret) {
 		udl_urb_completion(urb); /* because no one else will */
 		DRM_ERROR("usb_submit_urb error %x\n", ret);
diff --git a/drivers/gpu/drm/udl/udl_transfer.c b/drivers/gpu/drm/udl/udl_transfer.c
index a431208dda85..b57844632dbd 100644
--- a/drivers/gpu/drm/udl/udl_transfer.c
+++ b/drivers/gpu/drm/udl/udl_transfer.c
@@ -180,8 +180,11 @@ int udl_render_hline(struct drm_device *dev, int log_bpp, struct urb **urb_ptr,
 	u8 *cmd = *urb_buf_ptr;
 	u8 *cmd_end = (u8 *) urb->transfer_buffer + urb->transfer_buffer_length;
 
-	if (WARN_ON(!(log_bpp == 1 || log_bpp == 2)))
+	if (WARN_ON(!(log_bpp == 1 || log_bpp == 2))) {
+		/* need to finish URB at error from this function */
+		udl_urb_completion(urb);
 		return -EINVAL;
+	}
 
 	line_start = (u8 *) (front + byte_offset);
 	next_pixel = line_start;
-- 
2.35.3

