Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0029A493229
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbiASBK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiASBK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:10:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EE3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 17:10:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64CF2B8173F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AAAC340E0;
        Wed, 19 Jan 2022 01:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642554655;
        bh=L1emoT2JOCxKxebRi7Jb6xfIULWVJUwDe1hefYltELs=;
        h=Date:From:To:Cc:Subject:From;
        b=tT8sBap/Ew0TeE/Rn/AiIxbj5kmqgTN3/4NepTVSZ/QbjGGACNeuXbJawRbPJhyE9
         kIhzG/jfgBf972E4yq6/4z6oyV87WVIQ1lO2FgBWSeeWHL6g0W9yZFsQpY9PaQd2hU
         5ZF+YFNECCELCmpRRvliZF0bZelAscRl3RLbbwRm37jCq0eECR8DQ+KFUnRQwW0eqR
         R4IkwV+jet8/sulw3Qy0jkpSiIMIeNz09AYJtlUHCH1iY00v9yV5Cpt1mea87wWIOu
         OZnuwhgghebmo5jAL7eQU/ijoTVhM3VgnyJkj4N2uUxVb4Dv0tcKjzb1AHUsrYDEET
         szcuXq9uF2fLg==
Date:   Tue, 18 Jan 2022 17:10:53 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs update for 5.17-rc1
Message-ID: <YedlHVEa4sdbvB2F@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks as always,

The following changes since commit 8ab774587903771821b59471cc723bba6d893942:

  Merge tag 'trace-v5.16-5' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2021-11-14 19:07:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.17-rc1

for you to fetch changes up to 5fed0be8583f08c1548b4dcd9e5ee0d1133d0730:

  f2fs: do not allow partial truncation on pinned file (2022-01-10 09:05:09 -0800)

----------------------------------------------------------------
f2fs-for-5.17-rc1

In this round, we've tried to address some performance issues in f2fs_checkpoint
and direct IO flows. Also, there was a work to enhance the page cache management
used for compression. Other than them, we've done typical work including sysfs,
code clean-ups, tracepoint, sanity check, in addition to bug fixes on corner
cases.

Enhancement:
 - use iomap for direct IO
 - try to avoid lock contention to improve f2fs_ckpt speed
 - avoid unnecessary memory allocation in compression flow
 - POSIX_FADV_DONTNEED drops the page cache containing compression pages
 - add some sysfs entries (gc_urgent_high_remaining, pending_discard)

Bug fix:
 - try not to expose unwritten blocks to user by DIO
   : this was added to avoid merge conflict; another patch is coming to address
     other missing case.
 - relax minor error condition for file pinning feature used in Android OTA
 - fix potential deadlock case in compression flow
 - should not truncate any block on pinned file

In addition, we've done some code clean-ups and tracepoint/sanity check
improvement.

----------------------------------------------------------------
Chao Yu (9):
      f2fs: fix to do sanity check on inode type during garbage collection
      f2fs: fix to avoid panic in is_alive() if metadata is inconsistent
      f2fs: fix to do sanity check in is_alive()
      f2fs: fix to do sanity check on last xattr entry in __f2fs_setxattr()
      f2fs: clean up __find_inline_xattr() with __find_xattr()
      f2fs: support fault injection to f2fs_trylock_op()
      f2fs: fix to check available space of CP area correctly in update_ckpt_flags()
      f2fs: fix to reserve space for IO align feature
      f2fs: don't drop compressed page cache in .{invalidate,release}page

Daeho Jeong (1):
      f2fs: add gc_urgent_high_remaining sysfs node

Eric Biggers (5):
      f2fs: rework write preallocations
      f2fs: reduce indentation in f2fs_file_write_iter()
      f2fs: fix the f2fs_file_write_iter tracepoint
      f2fs: implement iomap operations
      f2fs: use iomap for direct I/O

Fengnan Chang (4):
      f2fs: compress: reduce one page array alloc and free when write compressed page
      f2fs: fix remove page failed in invalidate compress pages
      f2fs: support POSIX_FADV_DONTNEED drop compressed page cache
      f2fs: remove redunant invalidate compress pages

Hyeong-Jun Kim (1):
      f2fs: compress: fix potential deadlock of compress file

Jaegeuk Kim (8):
      f2fs: do not expose unwritten blocks to user by DIO
      f2fs: show more DIO information in tracepoint
      f2fs: show number of pending discard commands
      f2fs: avoid duplicate call of mark_inode_dirty
      f2fs: avoid EINVAL by SBI_NEED_FSCK when pinning a file
      f2fs: avoid down_write on nat_tree_lock during checkpoint
      f2fs: do not bother checkpoint by f2fs_get_node_info
      f2fs: do not allow partial truncation on pinned file

Yang Li (1):
      f2fs: Simplify bool conversion

 Documentation/ABI/testing/sysfs-fs-f2fs |  12 +
 Documentation/filesystems/f2fs.rst      |   1 +
 fs/f2fs/Kconfig                         |   1 +
 fs/f2fs/checkpoint.c                    |   6 +-
 fs/f2fs/compress.c                      |  84 +++---
 fs/f2fs/data.c                          | 351 +++++-----------------
 fs/f2fs/f2fs.h                          |  43 ++-
 fs/f2fs/file.c                          | 509 ++++++++++++++++++++++++++------
 fs/f2fs/gc.c                            |  26 +-
 fs/f2fs/inline.c                        |   4 +-
 fs/f2fs/inode.c                         |  18 +-
 fs/f2fs/iostat.c                        |  40 ++-
 fs/f2fs/node.c                          |  23 +-
 fs/f2fs/recovery.c                      |   2 +-
 fs/f2fs/segment.c                       |   2 +-
 fs/f2fs/segment.h                       |   3 +-
 fs/f2fs/super.c                         |  46 +++
 fs/f2fs/sysfs.c                         |  26 +-
 fs/f2fs/xattr.c                         |  40 +--
 include/trace/events/f2fs.h             |  27 +-
 20 files changed, 759 insertions(+), 505 deletions(-)

