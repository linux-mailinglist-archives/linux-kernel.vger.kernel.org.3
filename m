Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E35875C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiHBDDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiHBDDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:03:47 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D71219281
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:03:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VL9W-L4_1659409422;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VL9W-L4_1659409422)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 11:03:42 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org, xiang@kernel.org
Subject: [RFC PATCH 0/9] cachefiles: content map
Date:   Tue,  2 Aug 2022 11:03:33 +0800
Message-Id: <20220802030342.46302-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Patchset
===============
Git tree:

    https://github.com/lostjeffle/linux.git jingbo/dev-fscache-bitmap-v1

Gitweb:

    https://github.com/lostjeffle/linux/commits/jingbo/dev-fscache-bitmap-v1


[Introduction]
==============

Besides the SEEK_[DATA|HOLE] llseek mechanism provided by the backing
filesystem, this patch set is going to introduce a bitmap based
mechanism, in which a self-maintained bitmap is used to track if the
file range has been cached by the backing file.


[Design]
========

[Content Map]
The content map is allocated/expanded/shorten in unit of PAGE_SIZE,
which is multiples times of the block size of the backing filesystem,
so that the backing content map file can be easily punched hole if the
content map gets truncated or invalidated. Each bit of the content map
indicates the existence of 4KB data of the backing file, thus each
(4K sized) chunk of content map covers 128MB data of the backing file.

In the lookup phase, for the case when the backing file already exists,
the content map is loaded from the backing content map file. When the
backing file gets written, the content map gets updated on the
completion of the write (i.e. cachefiles_write_complete()).

When the backing file is truncated to a larger size, we need to expand
the content map accordingly. However the expansion of the content map is
done in a lazy expansion way. That is, the expansion of the content map
is delayed to the point when the content map needs to be marked, inside
cachefiles_write_complete(), i.e. iocb.ki_complete() callback. It shall
be safe to allocate memory with GFP_KERNEL inside the iocb.ki_complete()
callback, since the callback is scheduled by workqueue for DIRECT IO.

While for the case where the backing file doesn't exist, i.e. a new
tmpfile is created as the backing file, the content map will not be
allocated at the lookup phase. Instead, it will be expanded at runtime
in the same way described above.

When the backing file is truncated to a smaller size, only the tailing
part that exceeds the new size gets zeroed, while the content map itself
is not truncated.

Thus the content map size may be smaller or larger than the actual size
of the backing file.


[Backing Content Map File]
The content map is permanentized to the backing content map file.
Currently each sub-directory under one volume maintains one backing
content map file, so that the cacehfilesd only needs to remove the whole
sub-directory (including the content map file and backing files in the
sub-directory) as usual when it's going to cull the whole sub-directory
or volume.

In this case, the content map file will be shared among all backing
files under the same sub-directory. Thus the offset of the content map
in the backing content map file needs to be stored in the xattr for each
backing file. Besides, since the content map size may be smaller or
larger than the actual size of the backing file as we described above,
the content map size also needs to be stored in the xattr of the backing
file.

When expanding the content map, a new offset inside the backing content
map file also needs to be allocated, with the old range starting from
the old offset getting punched hole. Currently the new offset is always
allocated in an appending style, i.e. the previous hole will not be
reused.


[Time Sequence]
===============
I haven't do much work on this yet though... Actually there are three
actions when filling the cache:

1. write data to the backing file
2. write content map to the backing content map file
3. flush the content of xattr to disk

Currently action 1 is through DIRECT IO, while action 2 is buffered IO.
To make sure the content map is flushed to disk _before_ xattr gets
flushed to disk, the backing content map file is opened with O_DSYNC, so
that the following write to the backing content map file will only
return when the written data has been flushed to disk.


[TEST]
======
It passes the test cases for on-demand mode[1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/tests/fscache?h=experimental-tests-fscache

It also passes xfstests on NFS 4.0 with fscache enabled.

The performance test is still under progress.


Jingbo Xu (9):
  cachefiles: improve FSCACHE_COOKIE_NO_DATA_TO_READ optimization
  cachefiles: add content map file helpers
  cachefiles: allocate per-subdir content map files
  cachefiles: alloc/load/save content map
  cachefiles: mark content map on write to the backing file
  cachefiles: check content map on read/write
  cachefiles: free content map on invalidate
  cachefiles: resize content map on resize
  cachefiles: cull content map file on cull

 fs/cachefiles/Makefile      |   3 +-
 fs/cachefiles/content-map.c | 333 ++++++++++++++++++++++++++++++++++++
 fs/cachefiles/interface.c   |  10 +-
 fs/cachefiles/internal.h    |  31 ++++
 fs/cachefiles/io.c          |  59 +++++--
 fs/cachefiles/namei.c       |  96 +++++++++++
 fs/cachefiles/ondemand.c    |   5 +-
 fs/cachefiles/volume.c      |  14 +-
 fs/cachefiles/xattr.c       |  26 +++
 fs/fscache/cookie.c         |   2 +-
 10 files changed, 558 insertions(+), 21 deletions(-)
 create mode 100644 fs/cachefiles/content-map.c

-- 
2.27.0

