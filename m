Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6938B508BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380104AbiDTPNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380103AbiDTPMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:12:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC2F3EAB6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:10:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A2221F756;
        Wed, 20 Apr 2022 15:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650467402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ij8UfjCLrmWlzw8p3dv1NeerjjrG+tJoiHZZthvTeTI=;
        b=JFTWSh6PJxJNJV7oRKcYWQSPPmYpfiNbr7bGGF1C4FLcMUoeH5mugdJwUSjRTpmafzW3Z6
        3/rnOYNY53Prw7TUqwIAO/wr+1hE9sHaZ8juMfZMr2ylg+TetOlsdH5uDLkAimH+CRHSO4
        /xH4WD232P0oiT57WD4l/KlJ4lYa0c0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B21313AD5;
        Wed, 20 Apr 2022 15:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8E1yCUoiYGJILQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 20 Apr 2022 15:10:02 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH 17/18] xen/sndfront: use xenbus_setup_ring() and xenbus_teardown_ring()
Date:   Wed, 20 Apr 2022 17:09:41 +0200
Message-Id: <20220420150942.31235-18-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420150942.31235-1-jgross@suse.com>
References: <20220420150942.31235-1-jgross@suse.com>
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

Simplify sndfront's ring creation and removal via xenbus_setup_ring()
and xenbus_teardown_ring().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 sound/xen/xen_snd_front_evtchnl.c | 41 +++++++------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/sound/xen/xen_snd_front_evtchnl.c b/sound/xen/xen_snd_front_evtchnl.c
index 3e21369c8216..32d42fd3f7ac 100644
--- a/sound/xen/xen_snd_front_evtchnl.c
+++ b/sound/xen/xen_snd_front_evtchnl.c
@@ -143,12 +143,12 @@ void xen_snd_front_evtchnl_flush(struct xen_snd_front_evtchnl *channel)
 static void evtchnl_free(struct xen_snd_front_info *front_info,
 			 struct xen_snd_front_evtchnl *channel)
 {
-	unsigned long page = 0;
+	void *page = NULL;
 
 	if (channel->type == EVTCHNL_TYPE_REQ)
-		page = (unsigned long)channel->u.req.ring.sring;
+		page = channel->u.req.ring.sring;
 	else if (channel->type == EVTCHNL_TYPE_EVT)
-		page = (unsigned long)channel->u.evt.page;
+		page = channel->u.evt.page;
 
 	if (!page)
 		return;
@@ -167,10 +167,7 @@ static void evtchnl_free(struct xen_snd_front_info *front_info,
 		xenbus_free_evtchn(front_info->xb_dev, channel->port);
 
 	/* End access and free the page. */
-	if (channel->gref != INVALID_GRANT_REF)
-		gnttab_end_foreign_access(channel->gref, page);
-	else
-		free_page(page);
+	xenbus_teardown_ring(&page, 1, &channel->gref);
 
 	memset(channel, 0, sizeof(*channel));
 }
@@ -196,8 +193,7 @@ static int evtchnl_alloc(struct xen_snd_front_info *front_info, int index,
 			 enum xen_snd_front_evtchnl_type type)
 {
 	struct xenbus_device *xb_dev = front_info->xb_dev;
-	unsigned long page;
-	grant_ref_t gref;
+	void *page;
 	irq_handler_t handler;
 	char *handler_name = NULL;
 	int ret;
@@ -207,12 +203,9 @@ static int evtchnl_alloc(struct xen_snd_front_info *front_info, int index,
 	channel->index = index;
 	channel->front_info = front_info;
 	channel->state = EVTCHNL_STATE_DISCONNECTED;
-	channel->gref = INVALID_GRANT_REF;
-	page = get_zeroed_page(GFP_KERNEL);
-	if (!page) {
-		ret = -ENOMEM;
+	ret = xenbus_setup_ring(xb_dev, GFP_KERNEL, &page, 1, &channel->gref);
+	if (ret)
 		goto fail;
-	}
 
 	handler_name = kasprintf(GFP_KERNEL, "%s-%s", XENSND_DRIVER_NAME,
 				 type == EVTCHNL_TYPE_REQ ?
@@ -226,33 +219,19 @@ static int evtchnl_alloc(struct xen_snd_front_info *front_info, int index,
 	mutex_init(&channel->ring_io_lock);
 
 	if (type == EVTCHNL_TYPE_REQ) {
-		struct xen_sndif_sring *sring = (struct xen_sndif_sring *)page;
+		struct xen_sndif_sring *sring = page;
 
 		init_completion(&channel->u.req.completion);
 		mutex_init(&channel->u.req.req_io_lock);
 		SHARED_RING_INIT(sring);
 		FRONT_RING_INIT(&channel->u.req.ring, sring, XEN_PAGE_SIZE);
 
-		ret = xenbus_grant_ring(xb_dev, sring, 1, &gref);
-		if (ret < 0) {
-			channel->u.req.ring.sring = NULL;
-			goto fail;
-		}
-
 		handler = evtchnl_interrupt_req;
 	} else {
-		ret = gnttab_grant_foreign_access(xb_dev->otherend_id,
-						  virt_to_gfn((void *)page), 0);
-		if (ret < 0)
-			goto fail;
-
-		channel->u.evt.page = (struct xensnd_event_page *)page;
-		gref = ret;
+		channel->u.evt.page = page;
 		handler = evtchnl_interrupt_evt;
 	}
 
-	channel->gref = gref;
-
 	ret = xenbus_alloc_evtchn(xb_dev, &channel->port);
 	if (ret < 0)
 		goto fail;
@@ -279,8 +258,6 @@ static int evtchnl_alloc(struct xen_snd_front_info *front_info, int index,
 	return 0;
 
 fail:
-	if (page)
-		free_page(page);
 	kfree(handler_name);
 	dev_err(&xb_dev->dev, "Failed to allocate ring: %d\n", ret);
 	return ret;
-- 
2.34.1

