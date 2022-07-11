Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EDF57046A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiGKNgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGKNgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD2F73DF08
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657546607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RyQr2XtUjaVXF3HOvn9hwgYpa3kaUN7VZup2EdcZGH0=;
        b=edAxIqyIepbgyoATVA/pUqUnIEd0IYGO2/8+H2ry0d+LOWqyHYvSkJjZRq/lCgJimC9gRt
        2tbcf57dmrwHw8+Xzr4OiS9b6RvuQK0AOiHABx2heiivxUs7Zm3dH+BhvvebVOGHbbPtMh
        3yLvaqqMyHlxg+RqcdS6OHO/hpJim/Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-1Keaw8EeN-27uI4bphW5vA-1; Mon, 11 Jul 2022 09:36:46 -0400
X-MC-Unique: 1Keaw8EeN-27uI4bphW5vA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58C8E1C06EC4;
        Mon, 11 Jul 2022 13:36:46 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 331AF2166B26;
        Mon, 11 Jul 2022 13:36:46 +0000 (UTC)
Date:   Mon, 11 Jul 2022 08:36:44 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 5.20
Message-ID: <20220711133644.GA27727@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
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

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.20

Changes in this set of commits:

. Delay the cleanup of interrupted posix lock requests until the
  user space result arrives. Previously, the immediate cleanup
  would lead to extraneous warnings when the result arrived.

. Tracepoint improvements, e.g. adding the lock resource name.

. Delay the completion of lockspace creation until one full recove
  cycle has completed. This allows more error cases to be returned
  the caller.

. Remove warnings from the locking layer about delayed network rep
  The recently added midcomms warnings are much more useful.

. Begin the process of deprecating two unused lock-timeout-related
  features. These features now require enabling via a Kconfig opti
  and enabling them triggers deprecation warnings. We expect to
  remove the code in v5.22.

Thanks,
Dave

Alexander Aring (19):
      fs: dlm: plock use list_first_entry
      fs: dlm: add pid to debug log
      fs: dlm: change plock interrupted message to debug again
      fs: dlm: use dlm_plock_info for do_unlock_close
      fs: dlm: change posix lock sigint handling
      fs: dlm: change ast and bast trace order
      fs: dlm: remove additional dereference of lksb
      fs: dlm: add resource name to tracepoints
      fs: dlm: update comments about recovery and membership handling
      fs: dlm: call dlm_lsop_recover_prep once
      fs: dlm: make new_lockspace() wait until recovery completes
      fs: dlm: handle recovery result outside of ls_recover
      fs: dlm: add comment about lkb IFL flags
      fs: dlm: fix grammar in lowcomms output
      fs: dlm: remove waiter warnings
      fs: dlm: remove timeout from dlm_user_adopt_orphan
      fs: dlm: add deprecation Kconfig and warnings for timeouts
      fs: dlm: don't use deprecated timeout features by default
      fs: dlm: move kref_put assert for lkb structs


 fs/dlm/Kconfig             |   9 +++
 fs/dlm/Makefile            |   2 +-
 fs/dlm/ast.c               |   4 +-
 fs/dlm/config.c            |  21 ++++---
 fs/dlm/config.h            |   3 +-
 fs/dlm/dlm_internal.h      |  32 ++++++++--
 fs/dlm/lock.c              | 143 ++++++++++++++++++---------------------------
 fs/dlm/lock.h              |  17 +++++-
 fs/dlm/lockspace.c         |  31 +++++++---
 fs/dlm/lowcomms.c          |   4 +-
 fs/dlm/member.c            |  30 +++++-----
 fs/dlm/plock.c             |  51 +++++++++++-----
 fs/dlm/recoverd.c          |  35 +++++++++--
 fs/dlm/user.c              |  21 ++++++-
 include/trace/events/dlm.h | 118 ++++++++++++++++++++++++++++++-------
 15 files changed, 351 insertions(+), 170 deletions(-)

