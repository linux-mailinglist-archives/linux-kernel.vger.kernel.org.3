Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC82C595F78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbiHPPjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbiHPPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:38:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3ED844CE
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:37:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 494121FE9D;
        Tue, 16 Aug 2022 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660664223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5V5Vy14t6jdiTGaKqlIcvrv64izEzAevML5/nEKPwug=;
        b=c7ttlbP9rj/J6LQWG8oBHVatxuxxLAeXMWL6JQU80+Z66a1gEeq/zh4ilaCCIwNUJ/X8hP
        G8lizUGENB8qLtoWYBLIqpo8d+uSHO53bMQEvz9+Qv63RUJVhWjMx5xxZpsAqA/SDWjVG2
        3gr5hg+uQfeqblPII4rge0fJLUSEIv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660664223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5V5Vy14t6jdiTGaKqlIcvrv64izEzAevML5/nEKPwug=;
        b=sCAWcOUkr0to58YSxSVvEhhlhHOGQq1UfTwXu5UMtmB/gIDxUwVzYjhvljptfRSWcIPvXD
        H50ONnaOWuFTNvCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 249FC139B7;
        Tue, 16 Aug 2022 15:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cL/YAZ+5+2LKJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 16 Aug 2022 15:37:03 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] drm/udl: Add parameter to set number of URBs
Date:   Tue, 16 Aug 2022 17:36:50 +0200
Message-Id: <20220816153655.27526-8-tiwai@suse.de>
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

From: Thomas Zimmermann <tzimmermann@suse.de>

For further debugging and optimization purpose, allow users to adjust
the number of URBs via a new module parameter, numurbs.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/udl/udl_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 2b7eafd48ec2..3c97f647883f 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -8,6 +8,8 @@
  * Copyright (C) 2009 Bernie Thompson <bernie@plugable.com>
  */
 
+#include <linux/moduleparam.h>
+
 #include <drm/drm.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -23,6 +25,9 @@
 #define WRITES_IN_FLIGHT (20)
 #define MAX_VENDOR_DESCRIPTOR_SIZE 256
 
+static uint udl_num_urbs = WRITES_IN_FLIGHT;
+module_param_named(numurbs, udl_num_urbs, uint, 0600);
+
 static int udl_parse_vendor_descriptor(struct udl_device *udl)
 {
 	struct usb_device *udev = udl_to_usb_device(udl);
@@ -294,6 +299,8 @@ int udl_init(struct udl_device *udl)
 	struct drm_device *dev = &udl->drm;
 	int ret = -ENOMEM;
 
+	drm_info(dev, "pre-allocating %d URBs\n", udl_num_urbs);
+
 	DRM_DEBUG("\n");
 
 	udl->dmadev = usb_intf_get_dma_device(to_usb_interface(dev->dev));
@@ -311,7 +318,7 @@ int udl_init(struct udl_device *udl)
 	if (udl_select_std_channel(udl))
 		DRM_ERROR("Selecting channel failed\n");
 
-	if (!udl_alloc_urb_list(dev, WRITES_IN_FLIGHT, MAX_TRANSFER)) {
+	if (!udl_alloc_urb_list(dev, udl_num_urbs, MAX_TRANSFER)) {
 		DRM_ERROR("udl_alloc_urb_list failed\n");
 		goto err;
 	}
-- 
2.35.3

