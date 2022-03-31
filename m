Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10904EE26C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbiCaUNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiCaUNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C553E1C7EA4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648757518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jBPSjnhwpWFALN0L6yWTQywPWw7srfjFAJx0tzMpuE8=;
        b=QJ5DL15dIc7utid2NKRVX0EF5Aq1orRD1uPvyVGl/qKJlTmfDbafo3hDbU5jKH+tM1nGua
        N/ubg8gqrieeN6d/BaFJb11kUQ7juLmmabO1r/7oY1ZewY0VkHsppgE1PSInuHWfVFtMyZ
        S0R9/SfUjY4Q8Om+XhwYIP7Ys9jQE4I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-zuo-fhELNOmRYjNCvOKKlA-1; Thu, 31 Mar 2022 16:11:57 -0400
X-MC-Unique: zuo-fhELNOmRYjNCvOKKlA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ECDF2800161;
        Thu, 31 Mar 2022 20:11:56 +0000 (UTC)
Received: from max.com (unknown [10.40.195.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3216C401DAD;
        Thu, 31 Mar 2022 20:11:52 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs fixes for 5.18-rc1
Date:   Thu, 31 Mar 2022 22:11:49 +0200
Message-Id: <20220331201149.566786-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes for 5.18-rc1.

Thanks,
Andreas

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.17-rc4-fixes

for you to fetch changes up to 27ca8273fda398638ca994a207323a85b6d81190:

  gfs2: Make sure FITRIM minlen is rounded up to fs block size (2022-03-31 20:35:38 +0200)

----------------------------------------------------------------
gfs2 fixes

* To avoid deadlocks, actively cancel dlm locking requests when we give
  up on them.  Further dlm operations on the same lock will return
  -EBUSY until the cancel has been completed, so in that case, wait and
  repeat.  (This is rare.)
* Lock inversion fixes in gfs2_inode_lookup() and gfs2_create_inode().
* Some more fallout from the gfs2 mmap + page fault deadlock fixes
  (merge c03098d4b9ad7).
* Various other minor bug fixes and cleanups.

----------------------------------------------------------------
Andreas Gruenbacher (12):
      gfs2: gfs2_setattr_size error path fix
      gfs2: Expect -EBUSY after canceling dlm locking requests
      gfs2: cancel timed-out glock requests
      gfs2: Switch lock order of inode and iopen glock
      gfs2: Make use of list_is_first
      gfs2: Initialize gh_error in gfs2_glock_nq
      gfs2: Fix should_fault_in_pages() logic
      gfs2: Disable page faults during lockless buffered reads
      gfs2: Minor retry logic cleanup
      gfs2: Fix gfs2_file_buffered_write endless loop workaround
      gfs2: Remove dead code in gfs2_file_read_iter
      gfs2: Make sure not to return short direct writes

Andrew Price (1):
      gfs2: Make sure FITRIM minlen is rounded up to fs block size

Bob Peterson (2):
      gfs2: assign rgrp glock before compute_bitstructs
      gfs2: Remove return value for gfs2_indirect_init

 fs/gfs2/bmap.c     |  9 ++++----
 fs/gfs2/file.c     | 68 ++++++++++++++++++++++++++----------------------------
 fs/gfs2/glock.c    | 14 +++++++++--
 fs/gfs2/inode.c    | 51 ++++++++++++++++++++++------------------
 fs/gfs2/lock_dlm.c | 15 +++++++++++-
 fs/gfs2/rgrp.c     | 19 ++++++++-------
 fs/gfs2/rgrp.h     |  2 +-
 fs/gfs2/super.c    |  2 +-
 8 files changed, 104 insertions(+), 76 deletions(-)

