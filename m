Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA15F5AE147
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiIFHkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiIFHj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:39:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E8523143
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:39:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F7EA336E4;
        Tue,  6 Sep 2022 07:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662449994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4hFdCuz1aZgzmgtnY0njr/afmoWuavqMx5WcOQEpdOI=;
        b=COpvJ5d7tbAStYGhO7bc1zFXuUGKOb84iPIzkhLGUPAMkEwYhh68Dpc+0B1hFi1uhGTE+W
        KE5n1VS8NfhAYQubOl8V/ROcV/kQwTRjF4bHyI0+98T6CPE0pMXOG/Fjxnfg39LSzBdiqf
        EAw6mGGSK0oG4NLM76ZPHA7JOJ8ipKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662449994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4hFdCuz1aZgzmgtnY0njr/afmoWuavqMx5WcOQEpdOI=;
        b=SsK9gb+qMRiNOhlwAW0W6mmxii6Nh0CKLY+0XskfgUak3e1lEIjAirAscWAacj/KOeCKp6
        0iZJDHBDSbYghEBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ED2D13A7A;
        Tue,  6 Sep 2022 07:39:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O7OFDkr5FmPeOgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 06 Sep 2022 07:39:54 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] drm/udl: More fixes
Date:   Tue,  6 Sep 2022 09:39:40 +0200
Message-Id: <20220906073951.2085-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
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

Hi,

this is a revised patch set for cleaning up and fixes for UDL driver.
It covers the PM problems, regressions in the previous patch set,
fixes for the stalls on some systems, as well as more hardening.


Takashi

===

v1->v2: cleanups as suggested by Thomas
- Drop numurbs parameter patch
- Clean up / simplify clipping patch
- Code cleanup and changes for urb management patch
- Put Acks on some given patches

===

Takashi Iwai (8):
  Revert "drm/udl: Kill pending URBs at suspend and disconnect"
  drm/udl: Suppress error print for -EPROTO at URB completion
  drm/udl: Increase the default URB list size to 20
  drm/udl: Drop unneeded alignment
  drm/udl: Fix potential URB leaks
  drm/udl: Fix inconsistent urbs.count value during udl_free_urb_list()
  drm/udl: Don't re-initialize stuff at retrying the URB list allocation
  drm/udl: Sync pending URBs at the end of suspend

Thomas Zimmermann (3):
  drm/udl: Restore display mode on resume
  drm/udl: Add reset_resume
  drm/udl: Enable damage clipping

 drivers/gpu/drm/udl/udl_drv.c      | 19 +++++-
 drivers/gpu/drm/udl/udl_drv.h      | 13 +---
 drivers/gpu/drm/udl/udl_main.c     | 95 +++++++++++++++---------------
 drivers/gpu/drm/udl/udl_modeset.c  | 36 ++---------
 drivers/gpu/drm/udl/udl_transfer.c | 45 ++------------
 5 files changed, 75 insertions(+), 133 deletions(-)

-- 
2.35.3

