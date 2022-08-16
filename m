Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB4A595F48
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiHPPi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbiHPPiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:38:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDEF659C4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:37:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97A781FE53;
        Tue, 16 Aug 2022 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660664220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=P009cW09xrhcJJVDDp3flRZgQWcxLyS3VXOA3fJen8U=;
        b=t7tQ66YPO6qthRPGmocjobqeUAC9p7q/CHWmlwYNkFipHxUbu2VGqIpDliqJfeOl0Odbx1
        PbMnnp6saElm5aUpA4XycMDdntJOQp3ncDttf+/icWaSFl3sIV6cVzlQJey3a7FvKllX0m
        2TD6Kdmjt+sO/kfc6HaWEwHz7cWGTqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660664220;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=P009cW09xrhcJJVDDp3flRZgQWcxLyS3VXOA3fJen8U=;
        b=LEdS3+yxjJypiO+qzOQmG4/0ZUg8C2FFXE1wCxX1V3TuXGJvSMe4EyL65mGtSb+83SdZOQ
        fQdXC3o9NiSM9TAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E09F139B7;
        Tue, 16 Aug 2022 15:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s+AkFpy5+2LKJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 16 Aug 2022 15:37:00 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] drm/udl: More fixes
Date:   Tue, 16 Aug 2022 17:36:43 +0200
Message-Id: <20220816153655.27526-1-tiwai@suse.de>
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

this patch set contains more fixes for UDL driver, to be applied on
top of my previous patch set [*].  It covers the PM problems,
regressions in the previous patch set, fixes for the stalls on some
systems, as well as more hardening.


Takashi

[*] https://lore.kernel.org/r/20220804075826.27036-1-tiwai@suse.de

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

Thomas Zimmermann (4):
  drm/udl: Restore display mode on resume
  drm/udl: Add reset_resume
  drm/udl: Enable damage clipping
  drm/udl: Add parameter to set number of URBs

 drivers/gpu/drm/udl/udl_drv.c      | 19 +++++-
 drivers/gpu/drm/udl/udl_drv.h      | 13 +---
 drivers/gpu/drm/udl/udl_main.c     | 97 +++++++++++++++---------------
 drivers/gpu/drm/udl/udl_modeset.c  | 42 ++++---------
 drivers/gpu/drm/udl/udl_transfer.c | 45 ++------------
 5 files changed, 86 insertions(+), 130 deletions(-)

-- 
2.35.3

