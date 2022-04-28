Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C03F512E83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbiD1IbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344131AbiD1IbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:31:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF106A0BDB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:27:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3AA1321873;
        Thu, 28 Apr 2022 08:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651134469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tOhV6YQDouFKSF4kDrscgmAnoCYSHdFmpTsct9Kqzek=;
        b=h6hwiM9FHRpDwvATx8ZJwxdJgF4aQmHGQmkHLtLJrYUY3ATb3CYZi1lh3cJIcZpfglwM82
        FnnkX9Ux6gOptve9MuodDmBZFvSvzzfaQd9rtWom4I0jgM9qfoQTzXUk9eOHuFfhhQ3J0o
        Hsizgzz4vnGMgdDhowBzhKzpG3NUYfc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0188D13491;
        Thu, 28 Apr 2022 08:27:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EMGoOgRQamIBLgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 08:27:48 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 05/19] xen/drm: switch xen_drm_front to use INVALID_GRANT_REF
Date:   Thu, 28 Apr 2022 10:27:29 +0200
Message-Id: <20220428082743.16593-6-jgross@suse.com>
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

Instead of using a private macro for an invalid grant reference use
the common one.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/gpu/drm/xen/xen_drm_front.h         | 9 ---------
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c | 4 ++--
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.h b/drivers/gpu/drm/xen/xen_drm_front.h
index cefafe859aba..a987c78abe41 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.h
+++ b/drivers/gpu/drm/xen/xen_drm_front.h
@@ -80,15 +80,6 @@ struct drm_pending_vblank_event;
 /* timeout in ms to wait for backend to respond */
 #define XEN_DRM_FRONT_WAIT_BACK_MS	3000
 
-#ifndef GRANT_INVALID_REF
-/*
- * Note on usage of grant reference 0 as invalid grant reference:
- * grant reference 0 is valid, but never exposed to a PV driver,
- * because of the fact it is already in use/reserved by the PV console.
- */
-#define GRANT_INVALID_REF	0
-#endif
-
 struct xen_drm_front_info {
 	struct xenbus_device *xb_dev;
 	struct xen_drm_front_drm_info *drm_info;
diff --git a/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c b/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
index 08b526eeec16..4006568b9e32 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
@@ -147,7 +147,7 @@ static void evtchnl_free(struct xen_drm_front_info *front_info,
 		xenbus_free_evtchn(front_info->xb_dev, evtchnl->port);
 
 	/* end access and free the page */
-	if (evtchnl->gref != GRANT_INVALID_REF)
+	if (evtchnl->gref != INVALID_GRANT_REF)
 		gnttab_end_foreign_access(evtchnl->gref, page);
 
 	memset(evtchnl, 0, sizeof(*evtchnl));
@@ -168,7 +168,7 @@ static int evtchnl_alloc(struct xen_drm_front_info *front_info, int index,
 	evtchnl->index = index;
 	evtchnl->front_info = front_info;
 	evtchnl->state = EVTCHNL_STATE_DISCONNECTED;
-	evtchnl->gref = GRANT_INVALID_REF;
+	evtchnl->gref = INVALID_GRANT_REF;
 
 	page = get_zeroed_page(GFP_NOIO | __GFP_HIGH);
 	if (!page) {
-- 
2.34.1

