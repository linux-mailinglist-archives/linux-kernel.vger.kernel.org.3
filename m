Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A86E5AE154
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbiIFHkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiIFHj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:39:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD623BF8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:39:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C6DF33781;
        Tue,  6 Sep 2022 07:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662449995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvVW75pSWEXq7CYezqMwR/bNGlxupt7EmzHbZX5yzGE=;
        b=GYY17wlUpqt/68A6LlOqB/y7LqrZQmHoFLnvB4AjlIJZWQoc8PTYoBYNoiaeM17TqGm0fa
        u3ANdMwoiLPYFqBwnktTQk/IlSplZfbTUYVGxcux+i7LH5sdUkDTOxqI0PlRK8LeT3R/5b
        bSgkw03tI0eFL9sGBYXGlp7VTiOJgq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662449995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvVW75pSWEXq7CYezqMwR/bNGlxupt7EmzHbZX5yzGE=;
        b=mtok9KpQsfzTAtew8ximkHG6hThPza0m3pgX+nKNVSt2vmXYlDL+1qt7Uqo5PZm9C/cR27
        M6LFPsuUF0mm5dCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24DF213A7A;
        Tue,  6 Sep 2022 07:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +GRtCEv5FmPeOgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 06 Sep 2022 07:39:55 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] drm/udl: Suppress error print for -EPROTO at URB completion
Date:   Tue,  6 Sep 2022 09:39:45 +0200
Message-Id: <20220906073951.2085-6-tiwai@suse.de>
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

The driver may receive -EPROTO at the URB completion when the device
gets disconnected, and it's a normal situation.  Suppress the error
print for that, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/udl/udl_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index a9f6b710b254..6aed6e0f669c 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -126,6 +126,7 @@ void udl_urb_completion(struct urb *urb)
 	if (urb->status) {
 		if (!(urb->status == -ENOENT ||
 		    urb->status == -ECONNRESET ||
+		    urb->status == -EPROTO ||
 		    urb->status == -ESHUTDOWN)) {
 			DRM_ERROR("%s - nonzero write bulk status received: %d\n",
 				__func__, urb->status);
-- 
2.35.3

