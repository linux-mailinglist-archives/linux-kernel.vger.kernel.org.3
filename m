Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE1948A1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiAJVVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:21:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240270AbiAJVVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641849712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=gHA8meZUmBSNpJu5bEvfBdiKNFm5MvkjuwdU2BAWhY8=;
        b=FFqmhPnnIwG2jNEr1yAwV8vbcFMd8v8iseCo8WmdHXGIphzMOWhxjIgFJDCNF28kgugXSx
        yL3LgaOP+77wErms6aKQcQnn4Mb/3ekkHG8sEitH+Xj4QUrFBrFsd2wFDW9pHh3D8REKN0
        wq7qyjlG/Tfto6pTfhjFFOGwoddVfKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-WE9ci8-4PqOOge6Sld6WUA-1; Mon, 10 Jan 2022 16:21:48 -0500
X-MC-Unique: WE9ci8-4PqOOge6Sld6WUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D643835E22;
        Mon, 10 Jan 2022 21:21:48 +0000 (UTC)
Received: from redhat.com (unknown [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B672F5BE36;
        Mon, 10 Jan 2022 21:21:47 +0000 (UTC)
Date:   Mon, 10 Jan 2022 15:21:45 -0600
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 5.17
Message-ID: <20220110212145.GA19682@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.17

This set includes the normal collection of minor fixes and
cleanups, new kmem caches for network messaging structs,
a start on some basic tracepoints, and some new debugfs
files for inserting test messages.

(I just noticed that I failed to rebase this after skipping the
last merge window, but it appears to merge fine.)

Thanks,
Dave


Alexander Aring (31):
      fs: dlm: remove obsolete INBUF define
      fs: dlm: fix small lockspace typo
      fs: dlm: debug improvements print nodeid
      fs: dlm: remove check SCTP is loaded message
      fs: dlm: move version conversion to compile time
      fs: dlm: use dlm_recovery_stopped instead of test_bit
      fs: dlm: use dlm_recovery_stopped in condition
      fs: dlm: make dlm_callback_resume quite
      fs: dlm: initial support for tracepoints
      fs: dlm: trace socket handling
      fs: dlm: requestqueue busy wait to event based wait
      fs: dlm: ls_count busy wait to event based wait
      fs: dlm: let handle callback data as void
      fs: dlm: add debugfs rawmsg send functionality
      fs: dlm: allow create lkb with specific id range
      fs: dlm: add lkb debugfs functionality
      fs: dlm: add lkb waiters debugfs functionality
      fs: dlm: filter user dlm messages for kernel locks
      fs: dlm: remove double list_first_entry call
      fs: dlm: fix potential buffer overflow
      fs: dlm: don't call kernel_getpeername() in error_report()
      fs: dlm: replace use of socket sk_callback_lock with sock_lock
      fs: dlm: fix build with CONFIG_IPV6 disabled
      fs: dlm: use list_empty() to check last iteration
      fs: dlm: check for pending users filling buffers
      fs: dlm: use event based wait for pending remove
      fs: dlm: remove wq_alloc mutex
      fs: dlm: memory cache for midcomms hotpath
      fs: dlm: memory cache for writequeue_entry
      fs: dlm: memory cache for lowcomms hotpath
      fs: dlm: print cluster addr if non-cluster node connects

Zhang Mingyu (1):
      fs: dlm:Remove unneeded semicolon


 fs/dlm/ast.c               |  16 ++-
 fs/dlm/debug_fs.c          |  96 ++++++++++++++++-
 fs/dlm/dir.c               |   3 +-
 fs/dlm/dlm_internal.h      |  12 +--
 fs/dlm/lock.c              | 109 +++++++++++++++++--
 fs/dlm/lock.h              |   4 +
 fs/dlm/lockspace.c         |  38 ++++---
 fs/dlm/lowcomms.c          | 209 +++++++++++++++++++-----------------
 fs/dlm/lowcomms.h          |   6 +-
 fs/dlm/main.c              |   3 +
 fs/dlm/member.c            |   3 +-
 fs/dlm/memory.c            |  68 +++++++++++-
 fs/dlm/memory.h            |   6 ++
 fs/dlm/midcomms.c          |  85 ++++++++++++---
 fs/dlm/midcomms.h          |   3 +
 fs/dlm/rcom.c              |   2 +-
 fs/dlm/recoverd.c          |   3 +-
 fs/dlm/requestqueue.c      |  17 ++-
 include/trace/events/dlm.h | 260 +++++++++++++++++++++++++++++++++++++++++++++
 19 files changed, 770 insertions(+), 173 deletions(-)
 create mode 100644 include/trace/events/dlm.h

