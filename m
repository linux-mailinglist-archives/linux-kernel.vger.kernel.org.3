Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F8153327B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbiEXUcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiEXUcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BF425D648
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653424320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=U0rOiqh9m2/Mle4syUk7RumO4vsRDPkOvL2ayAOEWv0=;
        b=NrpJzb/Wvw6FqIjmewlrpGpSUeowMD95TjkDPPsolTXTUfqroYrugmN4qqm7aIjZbvEY7o
        ugYGIUFNEhA2icdyX+jM4LSdnz6jE8j+warCIvXA3rlxIo0L1q05NB/CRZYK1e9YNQpJLQ
        V3094yh0/8yvVYWZtExRaO4jANyk36Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-XxrYU_LeMpqLlX_iCCpWeQ-1; Tue, 24 May 2022 16:31:57 -0400
X-MC-Unique: XxrYU_LeMpqLlX_iCCpWeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3DC4185A79C;
        Tue, 24 May 2022 20:31:56 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB8982166B2A;
        Tue, 24 May 2022 20:31:56 +0000 (UTC)
Date:   Tue, 24 May 2022 15:31:55 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 5.19
Message-ID: <20220524203155.GA4585@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.19

This set includes several large patches to improve endian handling and
remove sparse warnings.  The code previously used in/out, in-place
endianness conversion functions.  Other code cleanup includes the list
iterator changes.  Finally, a long standing bug was found and fixed,
caused by missed decrement on an lock struct ref count.

Thanks,
Dave

Alexander Aring (25):
      dlm: fix missing check in validate_lock_args
      dlm: fix plock invalid read
      dlm: replace sanity checks with WARN_ON
      dlm: cleanup plock_op vs plock_xop
      dlm: rearrange async condition return
      dlm: improve plock logging if interrupted
      dlm: remove unnecessary INIT_LIST_HEAD()
      dlm: move global to static inits
      dlm: add __CHECKER__ for false positives
      dlm: use __le types for options header
      dlm: use __le types for dlm header
      dlm: use __le types for rcom messages
      dlm: use __le types for dlm messages
      dlm: move conversion to compile time
      dlm: remove __user conversion warnings
      dlm: remove found label in dlm_master_lookup
      dlm: cleanup lock handling in dlm_master_lookup
      dlm: check required context while close
      dlm: fix wake_up() calls for pending remove
      dlm: fix pending remove if msg allocation fails
      fs: dlm: cast resource pointer to uintptr_t
      dlm: fix missing lkb refcount handling
      dlm: remove unnecessary error assign
      dlm: use kref_put_lock in put_rsb
      dlm: use kref_put_lock in __put_lkb

Dan Carpenter (1):
      dlm: uninitialized variable on error in dlm_listen_for_all()

Jakob Koschel (2):
      dlm: remove usage of list iterator for list_add() after the loop body
      dlm: replace usage of found with dedicated list iterator variable


 fs/dlm/dir.c          |   2 +-
 fs/dlm/dlm_internal.h |  66 ++++----
 fs/dlm/lock.c         | 654 ++++++++++++++++++++++++++++++++++++++++------------------------------------
 fs/dlm/lockspace.c    |  12 ++
 fs/dlm/lockspace.h    |   1 +
 fs/dlm/lowcomms.c     |  12 +-
 fs/dlm/member.c       |  11 +-
 fs/dlm/midcomms.c     |  61 ++++---
 fs/dlm/plock.c        | 178 ++++++++++-----------
 fs/dlm/rcom.c         | 120 +++++++-------
 fs/dlm/recover.c      |  49 +++---
 fs/dlm/requestqueue.c |  20 ++-
 fs/dlm/user.c         |  16 +-
 fs/dlm/util.c         |  92 +----------
 fs/dlm/util.h         |   8 +-
 15 files changed, 633 insertions(+), 669 deletions(-)

