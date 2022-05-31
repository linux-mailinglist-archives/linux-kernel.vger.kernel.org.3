Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA67539861
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbiEaVCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiEaVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:02:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDAD8E186
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12D2C61309
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 21:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D15C385A9;
        Tue, 31 May 2022 21:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654030924;
        bh=zimXZZGRYReHBNE2SVCnLEGfZzXqmrfhmRSoT8zU2z0=;
        h=Date:From:To:Cc:Subject:From;
        b=oe8biq0UdICPQEUrWhL4com6oFsfxX7JQZ6n1lKum1VLmhnL5aW7dvr0Y/vZErCo+
         Q9vEXDkSLvy7RwM0cP+9mFM5hRuDo7V4WifUzWPgGzAa8BBqWedLASGA5W1hMR1BRu
         vkWiEcZYJHwQmCXEtwOLF0FpJE7UvVA+cmn4spF/346CGwZLydxlhgghEMD0lVxvD+
         p+HVQ5DF2d88YYhrCY+wGevhl4b5iHv40RQ1gDgNVUCswKWTvCOFgrdK/aTcv8NVhW
         V+eJ72ku6BtwZiO5NZsp1jR22b9CkktOyOG9WTqOYoEp4/4Icbwd5xEWxMGRv22oJQ
         0jt+JhdQxYgew==
Date:   Tue, 31 May 2022 14:02:02 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs for 5.19
Message-ID: <YpaCSoxxcWCqo8FQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit d615b5416f8a1afeb82d13b238f8152c572d59c0:

  Merge tag 'f2fs-fix-5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2022-04-25 10:53:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.19-rc1

for you to fetch changes up to 2d1fe8a86bf5e0663866fd0da83c2af1e1b0e362:

  f2fs: fix to tag gcing flag on page during file defragment (2022-05-27 13:58:42 -0700)

----------------------------------------------------------------
f2fs-for-5.19

In this round, we've refactored the existing atomic write support implemented
by in-memory operations to have storing data in disk temporarily, which can give
us a benefit to accept more atomic writes. At the same time, we removed the
existing volatile write support. We've also revisited the file pinning and GC
flows and found some corner cases which contributeed abnormal system behaviours.
As usual, there're several minor code refactoring for readability, sanity check,
and clean ups.

Enhancement
 - allow compression for mmap files in compress_mode=user
 - kill volatile write support
 - change the current atomic write way
 - give priority to select unpinned section for foreground GC
 - introduce data read/write showing path info
 - remove unnecessary f2fs_lock_op in f2fs_new_inode

Bug fix
 - fix the file pinning flow during checkpoint=disable and GCs
 - fix foreground and background GCs to select the right victims and get free
   sections on time
 - fix GC flags on defragmenting pages
 - avoid an infinite loop to flush node pages
 - fix fallocate to use file_modified to update permissions consistently

----------------------------------------------------------------
Byungki Lee (1):
      f2fs: write checkpoint during FG_GC

Chao Liu (1):
      f2fs: make f2fs_read_inline_data() more readable

Chao Yu (13):
      f2fs: check pinfile in gc_data_segment() in advance
      f2fs: don't set GC_FAILURE_PIN for background GC
      f2fs: fix to do sanity check on inline_dots inode
      f2fs: fix to clear dirty inode in f2fs_evict_inode()
      f2fs: fix to avoid f2fs_bug_on() in dec_valid_node_count()
      f2fs: fix to do sanity check on block address in f2fs_do_zero_range()
      f2fs: fix deadloop in foreground GC
      f2fs: fix to do sanity check on total_data_blocks
      f2fs: give priority to select unpinned section for foreground GC
      f2fs: fix fallocate to use file_modified to update permissions consistently
      f2fs: fix to do sanity check for inline inode
      f2fs: avoid unneeded error handling for revoke_entry_slab allocation
      f2fs: fix to tag gcing flag on page during file defragment

Daeho Jeong (1):
      f2fs: change the current atomic write way

Dongliang Mu (1):
      f2fs: remove WARN_ON in f2fs_is_valid_blkaddr

Eric Biggers (2):
      f2fs: reject test_dummy_encryption when !CONFIG_FS_ENCRYPTION
      f2fs: don't use casefolded comparison for "." and ".."

Jaegeuk Kim (10):
      f2fs: remove unnecessary f2fs_lock_op in f2fs_new_inode
      f2fs: introduce data read/write showing path info
      f2fs: use flush command instead of FUA for zoned device
      f2fs: avoid infinite loop to flush node pages
      f2fs: stop allocating pinned sections if EAGAIN happens
      f2fs: don't need inode lock for system hidden quota
      f2fs: kill volatile write support
      f2fs: introduce f2fs_gc_control to consolidate f2fs_gc parameters
      f2fs: keep wait_ms if EAGAIN happens
      f2fs: do not stop GC when requiring a free section

Jakob Koschel (3):
      f2fs: fix dereference of stale list iterator after loop body
      f2fs: Remove usage of list iterator pas the loop for list_move_tail()
      f2fs: replace usage of found with dedicated list iterator variable

Julia Lawall (1):
      f2fs: fix typo in comment

Luis Chamberlain (2):
      f2fs: call bdev_zone_sectors() only once on init_blkz_info()
      f2fs: ensure only power of 2 zone sizes are allowed

Niels Dossche (1):
      f2fs: extend stat_lock to avoid potential race in statfs

Sungjong Seo (1):
      f2fs: allow compression for mmap files in compress_mode=user

Weichao Guo (1):
      f2fs: skip GC if possible when checkpoint disabling

Yufen Yu (2):
      f2fs: add f2fs_init_write_merge_io function
      f2fs: replace F2FS_I(inode) and sbi by the local variable

 fs/f2fs/checkpoint.c        |  16 +-
 fs/f2fs/data.c              | 213 +++++++++++++-------
 fs/f2fs/debug.c             |  18 +-
 fs/f2fs/dir.c               |   3 +-
 fs/f2fs/f2fs.h              | 133 ++++++-------
 fs/f2fs/file.c              | 307 +++++++++++++----------------
 fs/f2fs/gc.c                | 186 ++++++++++++------
 fs/f2fs/hash.c              |  11 +-
 fs/f2fs/inline.c            |  29 ++-
 fs/f2fs/inode.c             |  34 ++--
 fs/f2fs/namei.c             |  38 ++--
 fs/f2fs/node.c              |  29 ++-
 fs/f2fs/node.h              |   1 -
 fs/f2fs/segment.c           | 460 +++++++++++++++++---------------------------
 fs/f2fs/segment.h           |  40 ++--
 fs/f2fs/super.c             |  88 ++++-----
 fs/f2fs/verity.c            |   2 +-
 include/trace/events/f2fs.h | 141 +++++++++++---
 18 files changed, 926 insertions(+), 823 deletions(-)
