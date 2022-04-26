Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994AE51010A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351788AbiDZO6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbiDZO6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A362E64BC0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650984896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m1+l/UGo7OHrjM3HAPBBJI03KFTiilbKvsV44XOQqzw=;
        b=Lrvden761pPoBIctdhkbVJnOBojvQ+3dhZs2nQuLuJnC06DyXEK5C5Q8z2w5HumGw8PHu6
        9o0oM/ExkPnLqXURdENwm+6TFcSutTg5mxOWLhmPWeYk6bWR9Ue3ZrgqiGr8+y1KiYVAAA
        Ucj7d4M8TaOFkJMUnxvfxTL1HfKxXpU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-T44Ke54uMte1libj1AoAjQ-1; Tue, 26 Apr 2022 10:54:49 -0400
X-MC-Unique: T44Ke54uMte1libj1AoAjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06C7E80D2A3;
        Tue, 26 Apr 2022 14:54:48 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.194.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2126E14682C8;
        Tue, 26 Apr 2022 14:54:45 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fix
Date:   Tue, 26 Apr 2022 16:54:45 +0200
Message-Id: <20220426145445.2282274-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fix for 5.18-rc5.

Also, note that we're fighting with a rare case of data corruption that
seems to have been introduced by commit 00bfe02f4796 ("gfs2: Fix mmap +
page fault deadlocks for buffered I/O"; merged in v5.16).  The
corruption seems to occur in gfs2_file_buffered_write() when
fault_in_iov_iter_readable() is involved.  We do end up with data that's
written at an offset, as if after a fault-in, the position in the iocb
got out of sync with the position in the iov_iter.  The user buffer the
iov_iter points at isn't page aligned, so the corruption also isn't page
aligned.  The code all seems correct and we couldn't figure out what's
going on so far.

Thanks,
Andreas

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.18-rc4-fix

for you to fetch changes up to e57f9af73d6b0ffb5f1aeaf6cec9a751dd8535c9:

  gfs2: Don't re-check for write past EOF unnecessarily (2022-04-26 15:38:00 +0200)

----------------------------------------------------------------
gfs2 fix

- Only re-check for direct I/O writes past the end of the file after
  re-acquiring the inode glock.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Don't re-check for write past EOF unnecessarily

 fs/gfs2/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

