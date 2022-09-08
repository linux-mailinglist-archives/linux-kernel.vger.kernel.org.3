Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9512E5B193C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiIHJv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiIHJvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:51:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFC8112E79
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:51:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E37BA33800;
        Thu,  8 Sep 2022 09:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662630678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1ErYPXVLqmO4wSgRe8Qfl5K8BfkVWk802TWryoKr48=;
        b=twBOX8/r2pbp5pguSVOco7NM1nJ+2gir6mG4qY5MnfTMVonw7Gyx5JrF1Vsjk+QRcqmElY
        Yn5sqxUCZm3TdoRLgMc7yp7v6/KQpKPvyEMEc7+PaX6hhujHcDP/3wpibKKHP8HpbEZyHi
        Cl8vaA286Cd2f0r2kqCvDTH4sEGWg+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662630678;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1ErYPXVLqmO4wSgRe8Qfl5K8BfkVWk802TWryoKr48=;
        b=/C2tCWJlfKNJfd1E4rwU7BVI6WUfXZTo1Mas3ppP30Ir50bAvXEQ8kzrq8ZSoZVOIwpROf
        rPIlxPaodDXqQoAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA25813A72;
        Thu,  8 Sep 2022 09:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gHTjLBa7GWNrUgAAMHmgww
        (envelope-from <tiwai@suse.de>); Thu, 08 Sep 2022 09:51:18 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/12] drm/udl: Restore display mode on resume
Date:   Thu,  8 Sep 2022 11:51:04 +0200
Message-Id: <20220908095115.23396-2-tiwai@suse.de>
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

Restore the display mode whne resuming from suspend. Currently, the
display remains dark.

On resume, the CRTC's mode does not change, but the 'active' flag
changes to 'true'. Taking this into account when considering a mode
switch restores the display mode.

The bug is reproducable by using Gnome with udl and observing the
adapter's suspend/resume behavior.

Actually, the whole check added in udl_simple_display_pipe_enable()
about the crtc_state->mode_changed was bogus.  We should drop the
whole check and always apply the mode change in this function.

[ tiwai -- Drop the mode_changed check entirely instead, per Daniel's
  suggestion ]

Fixes: 997d33c35618 ("drm/udl: Inline DPMS code into CRTC enable and disable functions")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/udl/udl_modeset.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 169110d8fc2e..34ce5b43c5db 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -382,9 +382,6 @@ udl_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 
 	udl_handle_damage(fb, &shadow_plane_state->data[0], 0, 0, fb->width, fb->height);
 
-	if (!crtc_state->mode_changed)
-		return;
-
 	/* enable display */
 	udl_crtc_write_mode_to_hw(crtc);
 }
-- 
2.35.3

