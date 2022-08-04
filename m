Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620425898DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239345AbiHDH6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiHDH6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:58:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC5213E14
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:58:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B16443745A;
        Thu,  4 Aug 2022 07:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659599913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WsPHXUyR5svouL2wdPIh4vTdx2ko6UbWtKcIEYKt+Bg=;
        b=hJul8wcNtwKy5log79W9x8J/1P3jd2Bas9ZJvMywg10BumVT5TCkDuk0h2SQHuPdAJAvNO
        5oT4C0B8MaCNh/mlIztLHECfWKiuXVDoyRLaKmTarqrmyTwC41ZyXxgi1Qj3J1f7dSFaOE
        LHcg58SGFd85hDgvFTZcCZxUTQhxlGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659599913;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WsPHXUyR5svouL2wdPIh4vTdx2ko6UbWtKcIEYKt+Bg=;
        b=0cwHv9Gczc7T10d56RWREKwdS6Bgev2S8czj41iT2ObiarjW8XZq+ygnhgiPNPawdjAR2E
        iYCSdv8L4MBohEBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AB1A13AE1;
        Thu,  4 Aug 2022 07:58:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JOULISl862IlJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Thu, 04 Aug 2022 07:58:33 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     dri-devel@lists.freedesktop.org
Cc:     Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm/udl: Fix stray URBs and cleanup
Date:   Thu,  4 Aug 2022 09:58:22 +0200
Message-Id: <20220804075826.27036-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a series of fixes for UDL driver to address the leftover URBs
at suspend/resume.  It begins with the simplification of FIFO control
code with the standard wait queue, followed by the handling of pending
URBs, and replace BUG_ON() with WARN_ON() as a cleanup.


Takashi

===

Takashi Iwai (4):
  drm/udl: Replace semaphore with a simple wait queue
  drm/udl: Sync pending URBs at suspend / disconnect
  drm/udl: Kill pending URBs at suspend and disconnect
  drm/udl: Replace BUG_ON() with WARN_ON()

 drivers/gpu/drm/udl/udl_drv.h      |  14 +++-
 drivers/gpu/drm/udl/udl_main.c     | 125 ++++++++++++++---------------
 drivers/gpu/drm/udl/udl_modeset.c  |   4 +
 drivers/gpu/drm/udl/udl_transfer.c |   3 +-
 4 files changed, 79 insertions(+), 67 deletions(-)

-- 
2.35.3

