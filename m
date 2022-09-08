Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFEB5B193D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiIHJva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiIHJvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:51:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F75B12950D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:51:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 153CE1F921;
        Thu,  8 Sep 2022 09:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662630679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y90h0r0za5ZtG0bczishRj8DeDfl2p1EUfhKR62Q6YQ=;
        b=Il6YPRJq7VyzVgRoA3eTwHN6v2zhY7jFSS0HJNLH8jGuyCQwQhvgqvHdwfEEkxOB2DQE9T
        yE6JBI4suwO1QuHsaij7aSNPSie4SNT905tmmUAUVadfi0ehjXP9IGLYNaRffTB4+m8bBk
        JIoZNrfQj51j0DlfjYVkwkkAmKWPcqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662630679;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y90h0r0za5ZtG0bczishRj8DeDfl2p1EUfhKR62Q6YQ=;
        b=s9Airb08pBDJ81c5iRLWmxN9uiXuVy7AsXSlC1jLv5Zf3ubN/lt9TSOFbll6ZaTwvfG0xE
        xVLPJ6oiLESeNHAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E50B913A6D;
        Thu,  8 Sep 2022 09:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8IwPNxa7GWNrUgAAMHmgww
        (envelope-from <tiwai@suse.de>); Thu, 08 Sep 2022 09:51:18 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/12] drm/udl: Add reset_resume
Date:   Thu,  8 Sep 2022 11:51:05 +0200
Message-Id: <20220908095115.23396-3-tiwai@suse.de>
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

From: Thomas Zimmermann <tzimmermann@suse.de>

Implement the reset_resume callback of struct usb_driver. Set the
standard channel when called.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/udl/udl_drv.c  | 11 +++++++++++
 drivers/gpu/drm/udl/udl_drv.h  |  1 +
 drivers/gpu/drm/udl/udl_main.c |  2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 5703277c6f52..0ba88e5472a9 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -32,6 +32,16 @@ static int udl_usb_resume(struct usb_interface *interface)
 	return drm_mode_config_helper_resume(dev);
 }
 
+static int udl_usb_reset_resume(struct usb_interface *interface)
+{
+	struct drm_device *dev = usb_get_intfdata(interface);
+	struct udl_device *udl = to_udl(dev);
+
+	udl_select_std_channel(udl);
+
+	return drm_mode_config_helper_resume(dev);
+}
+
 /*
  * FIXME: Dma-buf sharing requires DMA support by the importing device.
  *        This function is a workaround to make USB devices work as well.
@@ -140,6 +150,7 @@ static struct usb_driver udl_driver = {
 	.disconnect = udl_usb_disconnect,
 	.suspend = udl_usb_suspend,
 	.resume = udl_usb_resume,
+	.reset_resume = udl_usb_reset_resume,
 	.id_table = id_table,
 };
 module_usb_driver(udl_driver);
diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index 28aaf75d71cf..37c14b0ff1fc 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -95,6 +95,7 @@ int udl_render_hline(struct drm_device *dev, int log_bpp, struct urb **urb_ptr,
 		     u32 byte_offset, u32 device_byte_offset, u32 byte_width);
 
 int udl_drop_usb(struct drm_device *dev);
+int udl_select_std_channel(struct udl_device *udl);
 
 #define CMD_WRITE_RAW8   "\xAF\x60" /**< 8 bit raw write command. */
 #define CMD_WRITE_RL8    "\xAF\x61" /**< 8 bit run length command. */
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index fdafbf8f3c3c..7d1e6bbc165c 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -92,7 +92,7 @@ static int udl_parse_vendor_descriptor(struct udl_device *udl)
 /*
  * Need to ensure a channel is selected before submitting URBs
  */
-static int udl_select_std_channel(struct udl_device *udl)
+int udl_select_std_channel(struct udl_device *udl)
 {
 	static const u8 set_def_chn[] = {0x57, 0xCD, 0xDC, 0xA7,
 					 0x1C, 0x88, 0x5E, 0x15,
-- 
2.35.3

