Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80657526C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 23:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384575AbiEMVHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 17:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377240AbiEMVHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 17:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7963F26C5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652476034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sh5oKvIJmcZ6Z8sDauzoGErE3sFVtMbnI9oXNJC+aqg=;
        b=SGgcGj6+4NBltCoRLmEF+RlGdnFc0ZlArfy3WS+PkbtL4KwyTzOAT5q0zvS9THwOiYPj5o
        rRJ6uQZuNg9B9PEGxtrfGEJIKERqD045VBJI15rM41zmyuuhOQMKy47F9d7uWncYqEULjY
        UTS/ua8DGitpNn1yng1IsMRtVZNJ5aU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-QMnSpe2LOgSym1AGbzKdYQ-1; Fri, 13 May 2022 17:07:13 -0400
X-MC-Unique: QMnSpe2LOgSym1AGbzKdYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2E6C800882;
        Fri, 13 May 2022 21:07:12 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.194.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8084C40D2820;
        Fri, 13 May 2022 21:07:11 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes
Date:   Fri, 13 May 2022 23:07:10 +0200
Message-Id: <20220513210710.4124506-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

we've finally identified commit dc732906c245 ("gfs2: Introduce flag for glock
holder auto-demotion") to be the other cause of the filesystem corruption we've
been seeing.  This feature isn't strictly necessary anymore, so we've decided
to stop using it for now.  With this and the gfs_iomap_end rounding fix you've
already seen ("gfs2: Fix filesystem block deallocation for short writes" in
this pull request), we're corruption free again now.

Would you like to still pull these fixes for v5.18, or should we send them in
the next merge window?

Thanks again for all the help you've provided.

Andreas

The following changes since commit 4a2316a1eda4ef3ced18c7f08f7cb3726bcae44b:

  Merge tag 'gfs2-v5.18-rc4-fix2' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2022-04-28 09:50:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.18-rc4-fix3

for you to fetch changes up to e1fa9ea85ce89207d2ac0316da35a4a7736801f9:

  gfs2: Stop using glock holder auto-demotion for now (2022-05-13 22:32:52 +0200)

----------------------------------------------------------------
gfs2 fixes

- Fix filesystem block deallocation for short writes.
- Stop using glock holder auto-demotion for now.
- Get rid of buffered writes inefficiencies due to page
  faults being disabled.
- Minor other cleanups.

----------------------------------------------------------------
Andreas Gruenbacher (7):
      gfs2: Fix filesystem block deallocation for short writes
      gfs2: Variable rename
      gfs2: Clean up use of fault_in_iov_iter_{read,write}able
      gfs2: Pull return value test out of should_fault_in_pages
      gfs2: Align read and write chunks to the page cache
      gfs2: buffered write prefaulting
      gfs2: Stop using glock holder auto-demotion for now

 fs/gfs2/bmap.c |  11 +++--
 fs/gfs2/file.c | 139 ++++++++++++++++++++++++++-------------------------------
 2 files changed, 68 insertions(+), 82 deletions(-)

