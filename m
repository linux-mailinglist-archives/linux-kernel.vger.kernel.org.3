Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED9C4FFA58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbiDMPh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiDMPhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C06D4BFF7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649864102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sk1v32UTIyZH37LdAUzNEF5obtPm583SsWSiAI9jtSE=;
        b=T47WVfK+S/0reqSNxLcifYv3PqD72x0HzVI/o/5p7TyXqHWsijt9+gFfEZM4/8+NbJrqAq
        7dG1jc9u5tf4ty7kX5nvcabYE+ubtT9aMP6qlhCiyOtlce4H81UQ4GkGUsITFoPqz+Vzdr
        hH5cUaDwZZJfp1xkBGtH4kEgA2C4tz8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-LhXBCQdeMm2JQunRUBAsEg-1; Wed, 13 Apr 2022 11:35:00 -0400
X-MC-Unique: LhXBCQdeMm2JQunRUBAsEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5040585A5BC;
        Wed, 13 Apr 2022 15:35:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8ED7AC27E9D;
        Wed, 13 Apr 2022 15:34:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Dave Wysochanski <dwysocha@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>, Jeff Layton <jlayton@kernel.org>,
        linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fscache: Miscellaneous fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2266867.1649864097.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 13 Apr 2022 16:34:57 +0100
Message-ID: <2266868.1649864097@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
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

Here's a collection of fscache and cachefiles fixes and misc small
cleanups.  The two main fixes are:

 (1) Add a missing unmark of the inode in-use mark in an error path.

 (2) Fix a KASAN slab-out-of-bounds error when setting the xattr on a
     cachefiles volume due to the wrong length being given to memcpy().

In addition, there's the removal of an unused parameter, removal of an
unused Kconfig option, conditionalising a bit of procfs-related stuff and
some doc fixes.

David

Link: https://lore.kernel.org/r/164945915630.773423.14655306154231712324.s=
tgit@warthog.procyon.org.uk/

---
The following changes since commit 42e7a03d3badebd4e70aea5362d6914dfc7c220=
b:

  Merge tag 'hyperv-fixes-signed-20220407' of git://git.kernel.org/pub/scm=
/linux/kernel/git/hyperv/linux (2022-04-07 06:35:34 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fscache-fixes-20220413

for you to fetch changes up to 61132ceeda723d2c48cbc2610ca3213a7fcb083b:

  fscache: remove FSCACHE_OLD_API Kconfig option (2022-04-08 23:54:37 +010=
0)

----------------------------------------------------------------
fscache fixes

----------------------------------------------------------------
Dave Wysochanski (1):
      cachefiles: Fix KASAN slab-out-of-bounds in cachefiles_set_volume_xa=
ttr

Jeffle Xu (1):
      cachefiles: unmark inode in use in error path

Yue Hu (6):
      docs: filesystems: caching/backend-api.rst: correct two relinquish A=
PIs use
      docs: filesystems: caching/backend-api.rst: fix an object withdrawn =
API
      fscache: Remove the cookie parameter from fscache_clear_page_bits()
      fscache: Move fscache_cookies_seq_ops specific code under CONFIG_PRO=
C_FS
      fscache: Use wrapper fscache_set_cache_state() directly when relinqu=
ishing
      fscache: remove FSCACHE_OLD_API Kconfig option

 Documentation/filesystems/caching/backend-api.rst |  8 +++---
 Documentation/filesystems/caching/netfs-api.rst   | 25 +++++++++--------
 fs/afs/write.c                                    |  3 +--
 fs/cachefiles/namei.c                             | 33 ++++++++++++++++--=
-----
 fs/cachefiles/xattr.c                             |  2 +-
 fs/fscache/Kconfig                                |  3 ---
 fs/fscache/cache.c                                |  2 +-
 fs/fscache/cookie.c                               |  4 ++-
 fs/fscache/internal.h                             |  4 +++
 fs/fscache/io.c                                   |  5 ++--
 include/linux/fscache.h                           |  4 +--
 11 files changed, 53 insertions(+), 40 deletions(-)

