Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7459A559E60
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiFXQHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiFXQHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:07:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7C15534A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:07:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C7BB41F8BF;
        Fri, 24 Jun 2022 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656086856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8wsGpUN1UHHjvwIixiG/ch3Vuvqb7p7EhnrZz6CUSYE=;
        b=QrRyewZrCg6LT4hn5tCGnl9MAX7vPMxkYVG+zpI1aTS5sbpOUnliLWiA2UdkNiE71nQh3F
        alPLupPQSY/RdqfutXxd7gJ5yMtMyaNlTv7kJp4esqU1y0OimrKaT8lPfHaa4IG/0pOaVk
        QGu25m49rZ6c+Tsp/hxfqdJkFraXFVE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9145D13480;
        Fri, 24 Jun 2022 16:07:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A5s3IUjhtWJDTQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 24 Jun 2022 16:07:36 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v5.19-rc4
Date:   Fri, 24 Jun 2022 18:07:36 +0200
Message-Id: <20220624160736.14606-1-jgross@suse.com>
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

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.19a-rc4-tag

xen: branch for v5.19-rc4

It contains the following fixes:

- A rare deadlock in Qubes-OS between the i915 driver and Xen grant
  unmapping, solved by making the unmapping fully asynchronous
- A bug in the Xen blkfront driver caused by incomplete error handling
- A fix for undefined behavior (shifting a signed int by 31 bits)
- A fix in the Xen drmfront driver avoiding a WARN()

Thanks.

Juergen

 drivers/block/xen-blkfront.c            |  19 ++--
 drivers/gpu/drm/xen/xen_drm_front_gem.c |   2 +-
 drivers/xen/features.c                  |   2 +-
 drivers/xen/gntdev-common.h             |   7 ++
 drivers/xen/gntdev.c                    | 157 +++++++++++++++++++++-----------
 5 files changed, 127 insertions(+), 60 deletions(-)

Demi Marie Obenour (1):
      xen/gntdev: Avoid blocking in unmap_grant_pages()

Jason Andryuk (1):
      xen-blkfront: Handle NULL gendisk

Julien Grall (1):
      x86/xen: Remove undefined behavior in setup_features()

Oleksandr Tyshchenko (1):
      drm/xen: Add missing VM_DONTEXPAND flag in mmap callback
