Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6979A544591
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiFIIW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiFIIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:22:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789D859977;
        Thu,  9 Jun 2022 01:22:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 37DE221DE0;
        Thu,  9 Jun 2022 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654762972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3bSkabX8VgHADh3/J147QctYpANZTcxqp+PhwF48u7U=;
        b=jMHryVCYuHawC8UOHpKcsOosXeHxW+FWCNtyiRu7CrzD8dXe+rw8dgb/6rSgelBzFyBECw
        O1mwjUGNz188J1OPSbAyJwhyi8EbF0z6CPOi5zi2ZEgPAoEu9rtGxHCYEnySZRQCVEc3TQ
        T93o5lbPtgRBKBNV8Sw14H7cLysPZX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654762972;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3bSkabX8VgHADh3/J147QctYpANZTcxqp+PhwF48u7U=;
        b=oXSJNwov56gM336GaG/zxSS+pY3oeJyBVKxahb+8lYCLEp9j6LS7wEY7WPhdYWLKiwrp44
        BmphxTQFJRMN8ADw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02FC813A8C;
        Thu,  9 Jun 2022 08:22:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sVlZO9utoWKpSgAAMHmgww
        (envelope-from <tiwai@suse.de>); Thu, 09 Jun 2022 08:22:51 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: uvcvideo: Fix spurious DMA max segment size warnings
Date:   Thu,  9 Jun 2022 10:22:46 +0200
Message-Id: <20220609082246.13182-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As default, the DMA max segment size is set to 64k, and uvcvideo may
overflow that size easily, resulting in a warning like:

  DMA-API: xhci_hcd 0000:00:14.0: mapping sg segment longer than device claims to support [len=98304] [max=65536]

Explicitly set up the DMA max segment size for avoiding spurious kernel
warnings.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/usb/uvc/uvc_video.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 1b4cc934109e..25aa6e6a6906 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -2160,6 +2160,8 @@ int uvc_video_init(struct uvc_streaming *stream)
 	for_each_uvc_urb(uvc_urb, stream)
 		INIT_WORK(&uvc_urb->work, uvc_video_copy_data_work);
 
+	dma_set_max_seg_size(uvc_stream_to_dmadev(stream), UINT_MAX);
+
 	return 0;
 }
 
-- 
2.35.3

