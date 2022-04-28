Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510CA512E73
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbiD1Icu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344123AbiD1IbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:31:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6BDA0BDF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:27:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 804C41F8A8;
        Thu, 28 Apr 2022 08:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651134469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nqfEAJYikez5yuRaJWQFVEnr7bTvqklH6kJ7XEyZeH4=;
        b=TYPIqdG6C2kNSXwfoxobkb0T7Qrlkecz89DW0NUUSRJk8G1Cl1McWKfb63f8rCvjK2Z1w9
        hltCqgILrPkBWZf7D6lZQrTVsQ9bYGNjEQQXo2D58+bj+Zbr/uJommfLuFr/ZVITaGpYKs
        3TdHSODcKkMVn6eBxvw3c05nJoauKJs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4287913491;
        Thu, 28 Apr 2022 08:27:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sDPlDgVQamIBLgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 08:27:49 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v2 06/19] xen/sound: switch xen_snd_front to use INVALID_GRANT_REF
Date:   Thu, 28 Apr 2022 10:27:30 +0200
Message-Id: <20220428082743.16593-7-jgross@suse.com>
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
 sound/xen/xen_snd_front_evtchnl.c | 4 ++--
 sound/xen/xen_snd_front_evtchnl.h | 9 ---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/xen/xen_snd_front_evtchnl.c b/sound/xen/xen_snd_front_evtchnl.c
index ecbc294fc59a..3e21369c8216 100644
--- a/sound/xen/xen_snd_front_evtchnl.c
+++ b/sound/xen/xen_snd_front_evtchnl.c
@@ -167,7 +167,7 @@ static void evtchnl_free(struct xen_snd_front_info *front_info,
 		xenbus_free_evtchn(front_info->xb_dev, channel->port);
 
 	/* End access and free the page. */
-	if (channel->gref != GRANT_INVALID_REF)
+	if (channel->gref != INVALID_GRANT_REF)
 		gnttab_end_foreign_access(channel->gref, page);
 	else
 		free_page(page);
@@ -207,7 +207,7 @@ static int evtchnl_alloc(struct xen_snd_front_info *front_info, int index,
 	channel->index = index;
 	channel->front_info = front_info;
 	channel->state = EVTCHNL_STATE_DISCONNECTED;
-	channel->gref = GRANT_INVALID_REF;
+	channel->gref = INVALID_GRANT_REF;
 	page = get_zeroed_page(GFP_KERNEL);
 	if (!page) {
 		ret = -ENOMEM;
diff --git a/sound/xen/xen_snd_front_evtchnl.h b/sound/xen/xen_snd_front_evtchnl.h
index cbe51fd1ec15..3675fba70564 100644
--- a/sound/xen/xen_snd_front_evtchnl.h
+++ b/sound/xen/xen_snd_front_evtchnl.h
@@ -15,15 +15,6 @@
 
 struct xen_snd_front_info;
 
-#ifndef GRANT_INVALID_REF
-/*
- * FIXME: usage of grant reference 0 as invalid grant reference:
- * grant reference 0 is valid, but never exposed to a PV driver,
- * because of the fact it is already in use/reserved by the PV console.
- */
-#define GRANT_INVALID_REF	0
-#endif
-
 /* Timeout in ms to wait for backend to respond. */
 #define VSND_WAIT_BACK_MS	3000
 
-- 
2.34.1

