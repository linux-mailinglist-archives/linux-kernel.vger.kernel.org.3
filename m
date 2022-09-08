Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676845B1941
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiIHJvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiIHJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:51:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F680112E7C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:51:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B92963372C;
        Thu,  8 Sep 2022 09:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662630678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=r7T3YAjulaRn5e4LHbBsLxYuASM55+Otot1t/CvftwE=;
        b=IgMdqiupQ6U7KQHbulMYrZUJgjBGHnNXE2zjuxS78utZsPrNOUhiJcZdfR65c8/OGuXzn1
        1vA+09RJWEodv3tYSw8hKiMOqWSS+urFL6EbZmQ6peCy8iGwuNz6tKXGGlPgk9cpbdKxGI
        ZCVlLFYz2+uyeSksG6cZqLWB4T7MOpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662630678;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=r7T3YAjulaRn5e4LHbBsLxYuASM55+Otot1t/CvftwE=;
        b=OvZJF4G5m329KR9SBsVZMvdWrrLRTCEX6/qA7O7iSM/3HTehKfZaRvF6hisD0/QeSsp3iQ
        Y4DQJKsryoLstnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95C3B13A6D;
        Thu,  8 Sep 2022 09:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OKuEIxa7GWNrUgAAMHmgww
        (envelope-from <tiwai@suse.de>); Thu, 08 Sep 2022 09:51:18 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/12] drm/udl: More fixes
Date:   Thu,  8 Sep 2022 11:51:03 +0200
Message-Id: <20220908095115.23396-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
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

Hi,

this is another respin of patch set for cleaning up and fixes for UDL
driver [*].  It covers the PM problems, regressions in the previous
patch set, fixes for the stalls on some systems, as well as more
hardening.


thanks,

Takashi

[*] v2: https://lore.kernel.org/r/20220906073951.2085-1-tiwai@suse.de

===

v2->v3:
- More fix on Restore-on-display-mode patch, suggested by Daniel
- Yet more fix for ubs.count check patch, suggested by Thomas
- Another patch for passing rectangle directly, suggested by Thomas
- Put more Acks from Daniel and Thomas

v1->v2: cleanups as suggested by Thomas
- Drop numurbs parameter patch
- Clean up / simplify clipping patch
- Code cleanup and changes for urb management patch
- Put Acks on some given patches

===

Takashi Iwai (10):
  drm/udl: Restore display mode on resume
  Revert "drm/udl: Kill pending URBs at suspend and disconnect"
  drm/udl: Suppress error print for -EPROTO at URB completion
  drm/udl: Increase the default URB list size to 20
  drm/udl: Drop unneeded alignment
  drm/udl: Pass rectangle directly to udl_handle_damage()
  drm/udl: Fix potential URB leaks
  drm/udl: Fix inconsistent urbs.count value during udl_free_urb_list()
  drm/udl: Don't re-initialize stuff at retrying the URB list allocation
  drm/udl: Sync pending URBs at the end of suspend

Thomas Zimmermann (2):
  drm/udl: Add reset_resume
  drm/udl: Enable damage clipping

 drivers/gpu/drm/udl/udl_drv.c      | 19 +++++-
 drivers/gpu/drm/udl/udl_drv.h      | 13 +----
 drivers/gpu/drm/udl/udl_main.c     | 93 +++++++++++++++---------------
 drivers/gpu/drm/udl/udl_modeset.c  | 54 ++++-------------
 drivers/gpu/drm/udl/udl_transfer.c | 45 ++-------------
 5 files changed, 80 insertions(+), 144 deletions(-)

-- 
2.35.3

