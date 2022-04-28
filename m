Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98461512E79
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344474AbiD1Id4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344202AbiD1IbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:31:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DF6A0BEC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:27:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A49C61F88C;
        Thu, 28 Apr 2022 08:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651134471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzS6PLrR2PHAizt1+i4tl6giJjA8snqDfs2l2Q2VBs0=;
        b=nFFFyryTPJUwSGLm0DOiWi5pBKFreuwVT6dtG6vv7wwwjuQBZiXQURV9kZVktg8KWsLx1t
        ilLRU/ya4Wl0h4xf0vilOs5Q1STs8uNfcYkc77DBM7WYb0v8XRhp6kV9DQJWf22LPv4YH4
        YeMQaNn8uOAEoouaJA49F3Fl0qU4Z08=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 695A913491;
        Thu, 28 Apr 2022 08:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eDY0GAdQamIBLgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 08:27:51 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 14/19] xen/drmfront: use xenbus_setup_ring() and xenbus_teardown_ring()
Date:   Thu, 28 Apr 2022 10:27:38 +0200
Message-Id: <20220428082743.16593-15-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220428082743.16593-1-jgross@suse.com>
References: <20220428082743.16593-1-jgross@suse.com>
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

Simplify drmfront's ring creation and removal via xenbus_setup_ring()
and xenbus_teardown_ring().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c | 43 ++++++---------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c b/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
index 4006568b9e32..e52afd792346 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
@@ -123,12 +123,12 @@ static irqreturn_t evtchnl_interrupt_evt(int irq, void *dev_id)
 static void evtchnl_free(struct xen_drm_front_info *front_info,
 			 struct xen_drm_front_evtchnl *evtchnl)
 {
-	unsigned long page = 0;
+	void *page = NULL;
 
 	if (evtchnl->type == EVTCHNL_TYPE_REQ)
-		page = (unsigned long)evtchnl->u.req.ring.sring;
+		page = evtchnl->u.req.ring.sring;
 	else if (evtchnl->type == EVTCHNL_TYPE_EVT)
-		page = (unsigned long)evtchnl->u.evt.page;
+		page = evtchnl->u.evt.page;
 	if (!page)
 		return;
 
@@ -147,8 +147,7 @@ static void evtchnl_free(struct xen_drm_front_info *front_info,
 		xenbus_free_evtchn(front_info->xb_dev, evtchnl->port);
 
 	/* end access and free the page */
-	if (evtchnl->gref != INVALID_GRANT_REF)
-		gnttab_end_foreign_access(evtchnl->gref, page);
+	xenbus_teardown_ring(&page, 1, &evtchnl->gref);
 
 	memset(evtchnl, 0, sizeof(*evtchnl));
 }
@@ -158,8 +157,7 @@ static int evtchnl_alloc(struct xen_drm_front_info *front_info, int index,
 			 enum xen_drm_front_evtchnl_type type)
 {
 	struct xenbus_device *xb_dev = front_info->xb_dev;
-	unsigned long page;
-	grant_ref_t gref;
+	void *page;
 	irq_handler_t handler;
 	int ret;
 
@@ -168,44 +166,25 @@ static int evtchnl_alloc(struct xen_drm_front_info *front_info, int index,
 	evtchnl->index = index;
 	evtchnl->front_info = front_info;
 	evtchnl->state = EVTCHNL_STATE_DISCONNECTED;
-	evtchnl->gref = INVALID_GRANT_REF;
 
-	page = get_zeroed_page(GFP_NOIO | __GFP_HIGH);
-	if (!page) {
-		ret = -ENOMEM;
+	ret = xenbus_setup_ring(xb_dev, GFP_NOIO | __GFP_HIGH, &page,
+				1, &evtchnl->gref);
+	if (ret)
 		goto fail;
-	}
 
 	if (type == EVTCHNL_TYPE_REQ) {
 		struct xen_displif_sring *sring;
 
 		init_completion(&evtchnl->u.req.completion);
 		mutex_init(&evtchnl->u.req.req_io_lock);
-		sring = (struct xen_displif_sring *)page;
-		SHARED_RING_INIT(sring);
-		FRONT_RING_INIT(&evtchnl->u.req.ring, sring, XEN_PAGE_SIZE);
-
-		ret = xenbus_grant_ring(xb_dev, sring, 1, &gref);
-		if (ret < 0) {
-			evtchnl->u.req.ring.sring = NULL;
-			free_page(page);
-			goto fail;
-		}
+		sring = page;
+		XEN_FRONT_RING_INIT(&evtchnl->u.req.ring, sring, XEN_PAGE_SIZE);
 
 		handler = evtchnl_interrupt_ctrl;
 	} else {
-		ret = gnttab_grant_foreign_access(xb_dev->otherend_id,
-						  virt_to_gfn((void *)page), 0);
-		if (ret < 0) {
-			free_page(page);
-			goto fail;
-		}
-
-		evtchnl->u.evt.page = (struct xendispl_event_page *)page;
-		gref = ret;
+		evtchnl->u.evt.page = page;
 		handler = evtchnl_interrupt_evt;
 	}
-	evtchnl->gref = gref;
 
 	ret = xenbus_alloc_evtchn(xb_dev, &evtchnl->port);
 	if (ret < 0)
-- 
2.34.1

