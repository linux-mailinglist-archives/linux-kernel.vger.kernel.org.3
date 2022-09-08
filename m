Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B275B1954
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiIHJwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiIHJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:51:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7412D12C48D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:51:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 94A971FA58;
        Thu,  8 Sep 2022 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662630680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=of6WZ3V2D41bq9eAXWrAwqo/XVQEcBT0lKqRfLWBsw8=;
        b=dA3/sUENNr+QbPevES849UoiZPjKzzBQcjqUkYr2gaYjptvGtfIGSZCFW+qOB9CGDhc1+L
        YZoL7dc3fBB+JdApWU+Pzh5j7DGbffr0Z480KOD4ETH7By4+NIA9vtqHyfWzKkeoDZli3T
        DFIbH/fqj10/8xftylS/AG/xER774Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662630680;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=of6WZ3V2D41bq9eAXWrAwqo/XVQEcBT0lKqRfLWBsw8=;
        b=c/8hsXgyiN1mQ/mBEemNqVIUKZPwSsJxLqLz7GWx5HmgvTOdhfCYvrqyfib+T3ruU021aV
        RxdmU+486HjTLEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7332B13A6D;
        Thu,  8 Sep 2022 09:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EDd/Gxi7GWNrUgAAMHmgww
        (envelope-from <tiwai@suse.de>); Thu, 08 Sep 2022 09:51:20 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/12] drm/udl: Don't re-initialize stuff at retrying the URB list allocation
Date:   Thu,  8 Sep 2022 11:51:14 +0200
Message-Id: <20220908095115.23396-12-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220908095115.23396-1-tiwai@suse.de>
References: <20220908095115.23396-1-tiwai@suse.de>
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

udl_alloc_urb_list() retires the allocation if there is no enough room
left, and it reinitializes the stuff unnecessarily such as the linked
list head and the waitqueue, which could be harmful.  Those should be
outside the retry loop.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/udl/udl_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 16aa4a655e7f..829edb60a987 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -182,15 +182,14 @@ static int udl_alloc_urb_list(struct drm_device *dev, int count, size_t size)
 	struct usb_device *udev = udl_to_usb_device(udl);
 
 	spin_lock_init(&udl->urbs.lock);
-
-retry:
-	udl->urbs.size = size;
 	INIT_LIST_HEAD(&udl->urbs.list);
-
 	init_waitqueue_head(&udl->urbs.sleep);
 	udl->urbs.count = 0;
 	udl->urbs.available = 0;
 
+retry:
+	udl->urbs.size = size;
+
 	while (udl->urbs.count * size < wanted_size) {
 		unode = kzalloc(sizeof(struct urb_node), GFP_KERNEL);
 		if (!unode)
-- 
2.35.3

