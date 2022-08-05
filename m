Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCCC58B0C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241534AbiHEUM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbiHEUMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DB1C1A3AC
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659730372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EWmziQ+zkkO5p4AUbX/aH6NjevdABku8Grwyp4hC0jQ=;
        b=OkJJay4yjv/I6GlDEQOW7L2XLRinvLC/oBWDwEf0uH6wbLTnEQVt7QaF3HsQfatPfXwWEx
        eYVvX5LyKizle1q+D1tDESSjPS5/9QDnklMT+7xpIitquzoccztZAWde3XQzOOoxRAqoPs
        9A19FKGpXU+EPoUyvHZO8UgVe8L65Co=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-q3dwFkIRPA66pN-OBAdp7w-1; Fri, 05 Aug 2022 16:12:51 -0400
X-MC-Unique: q3dwFkIRPA66pN-OBAdp7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 078F43C0CD5A;
        Fri,  5 Aug 2022 20:12:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8880C28125;
        Fri,  5 Aug 2022 20:12:49 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes
Date:   Fri,  5 Aug 2022 22:12:48 +0200
Message-Id: <20220805201248.123846-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes.

Thank you very much,
Andreas

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.19-rc4-fixes

for you to fetch changes up to 446279168e030fd0ed68e2bba336bef8bb3da352:

  Merge part of branch 'for-next.instantiate' into for-next (2022-08-05 18:37:03 +0200)

----------------------------------------------------------------
gfs2 fixes

- Instantiate glocks ouside of the glock state engine, in the contect of
  the process taking the glock.  This moves unnecessary complexity out
  of the core glock code.  Clean up the instantiate logic to be more
  sensible.

- In gfs2_glock_async_wait(), cancel pending locking request upon
  failure.  Make sure all glocks are left in a consistent state.

- Various other minor cleanups and fixes.

----------------------------------------------------------------
Andreas Gruenbacher (9):
      gfs2: Minor gfs2_glock_nq_m cleanup
      gfs2: Fix up gfs2_glock_async_wait
      gfs2: Instantiate glocks ouside of glock state engine
      gfs2: Revert 'Fix "truncate in progress" hang'
      gfs2: Add new go_held glock operation
      gfs2: Make go_instantiate take a glock
      gfs2: Use better variable name
      gfs2: List traversal in do_promote is safe
      Merge part of branch 'for-next.instantiate' into for-next

Bob Peterson (2):
      gfs2: Rewrap overlong comment in do_promote
      gfs2: do_promote glock holder stealing fix

Minghao Chi (1):
      gfs2: Remove redundant NULL check before kfree

Zhang Jiaming (1):
      gfs2: Fix spelling mistake in comment

 fs/gfs2/dir.c        |   2 +-
 fs/gfs2/file.c       |   3 +-
 fs/gfs2/glock.c      | 200 ++++++++++++++++++++-------------------------------
 fs/gfs2/glock.h      |   2 +-
 fs/gfs2/glops.c      |  31 ++++----
 fs/gfs2/incore.h     |   6 +-
 fs/gfs2/lock_dlm.c   |   2 +-
 fs/gfs2/main.c       |   1 -
 fs/gfs2/ops_fstype.c |   2 -
 fs/gfs2/quota.c      |  28 +-------
 fs/gfs2/rgrp.c       |  12 ++--
 fs/gfs2/rgrp.h       |   5 +-
 fs/gfs2/super.c      |   2 +-
 fs/gfs2/xattr.c      |   2 +-
 14 files changed, 111 insertions(+), 187 deletions(-)

