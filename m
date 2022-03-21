Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8FC4E31F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353458AbiCUUlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350375AbiCUUlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:41:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A2D1FA4C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47D2861192
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A26C340E8;
        Mon, 21 Mar 2022 20:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647895173;
        bh=y7g4//qbSpEtgblpCFF3s9kIPm6pzICsJ7vhm6u/aQs=;
        h=Date:From:To:Cc:Subject:From;
        b=IO7xIvdk8tJoMtmAmb1PeEcpR/MYnA6+V07fPbtqicCkA7qP8DvJibzGEOO3vO6QS
         k7PjTY7+O54XW7S/bxYNH8TVgfVfsMCefGzujf9tqunEmv2v4UMDp0HRtyuXGxGddx
         MMbSLsM/xk617nqiNvdWRLxMEDr8BvrD7aY4ILcGhe6RU1ZXzo1ClAw2eKYKncAHDR
         vjtQ7vUn+WDIcQgrPKmSiKHlw+C44xoXZ+iKQu+cszsjV1OuXf7IZ5QpGfBzPKhkFO
         mw1jZUPnkAlF5VdHARaymR9PEbH2nwD39JknVIduorzk//0EGPaBQ/DgbHC2mKazxg
         QHWo+p62Zqsrw==
Date:   Mon, 21 Mar 2022 13:39:32 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs for 5.18
Message-ID: <YjjihIZuvZpUjaSs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The following changes since commit dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0:

  Merge tag 'powerpc-5.17-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2022-01-23 17:52:42 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.18

for you to fetch changes up to 5b5b4f85b01604389f7a0f11ef180a725bf0e2d4:

  f2fs: fix to do sanity check on .cp_pack_total_block_count (2022-03-21 09:10:21 -0700)

----------------------------------------------------------------
f2fs-for-5.18

In this cycle, f2fs has some performance improvements for Android workloads such
as using read-unfair rwsems and adding some sysfs entries to control GCs and
discard commands in more details. In addtiion, it has some tunings to improve
the recovery speed after sudden power-cut.

Enhancement:
 - add reader-unfair rwsems with F2FS_UNFAIR_RWSEM
  : will replace with generic API support
 - adjust to make the readahead/recovery flow more efficiently
 - sysfs entries to control issue speeds of GCs and Discard commands
 - enable idmapped mounts

Bug fix:
 - correct wrong error handling routines
 - fix missing conditions in quota
 - fix a potential deadlock between writeback and block plug routines
 - fix a deadlock btween freezefs and evict_inode

We've added some boundary checks to avoid kernel panics on corrupted images,
and several minor code clean-ups.

----------------------------------------------------------------
Bart Van Assche (1):
      f2fs: Restore rwsem lockdep support

Chao Yu (11):
      f2fs: fix to enable ATGC correctly via gc_idle sysfs interface
      f2fs: fix to unlock page correctly in error path of is_alive()
      f2fs: adjust readahead block number during recovery
      f2fs: introduce F2FS_IPU_HONOR_OPU_WRITE ipu policy
      f2fs: support idmapped mounts
      f2fs: fix to avoid potential deadlock
      f2fs: fix to do sanity check on curseg->alloc_type
      f2fs: compress: fix to print raw data size in error path of lz4 decompression
      f2fs: initialize sbi->gc_mode explicitly
      f2fs: use aggressive GC policy during f2fs_disable_checkpoint()
      f2fs: fix to do sanity check on .cp_pack_total_block_count

Daeho Jeong (2):
      f2fs: introduce gc_urgent_mid mode
      f2fs: make gc_urgent and gc_segment_mode sysfs node readable

Fengnan Chang (1):
      f2fs: fix compressed file start atomic write may cause data corruption

Jaegeuk Kim (6):
      f2fs: add a way to limit roll forward recovery time
      f2fs: fix missing free nid in f2fs_handle_failed_inode
      f2fs: avoid an infinite loop in f2fs_sync_dirty_inodes
      f2fs: introduce F2FS_UNFAIR_RWSEM to support unfair rwsem
      f2fs: don't get FREEZE lock in f2fs_evict_inode in frozen fs
      f2fs: use spin_lock to avoid hang

Jia Yang (1):
      f2fs: remove unnecessary read for F2FS_FITS_IN_INODE

Juhyung Park (1):
      f2fs: quota: fix loop condition at f2fs_quota_sync()

Konstantin Vyshetsky (2):
      f2fs: move discard parameters into discard_cmd_control
      f2fs: expose discard related parameters in sysfs

Tim Murray (1):
      f2fs: move f2fs to use reader-unfair rwsems

Wang Xiaojun (1):
      f2fs: remove redundant parameter judgment

 Documentation/ABI/testing/sysfs-fs-f2fs |  54 ++++++++--
 fs/f2fs/Kconfig                         |   7 ++
 fs/f2fs/acl.c                           |  21 ++--
 fs/f2fs/checkpoint.c                    |  58 +++++++----
 fs/f2fs/compress.c                      |  11 +-
 fs/f2fs/data.c                          |  76 ++++++++------
 fs/f2fs/debug.c                         |  25 +++--
 fs/f2fs/dir.c                           |  12 +--
 fs/f2fs/f2fs.h                          | 154 +++++++++++++++++++++++-----
 fs/f2fs/file.c                          | 175 ++++++++++++++++----------------
 fs/f2fs/gc.c                            |  53 +++++-----
 fs/f2fs/inline.c                        |   4 +-
 fs/f2fs/inode.c                         |   7 +-
 fs/f2fs/namei.c                         |  78 +++++++-------
 fs/f2fs/node.c                          |  92 +++++++++--------
 fs/f2fs/node.h                          |   3 +
 fs/f2fs/recovery.c                      |  35 ++++++-
 fs/f2fs/segment.c                       |  73 +++++++------
 fs/f2fs/segment.h                       |   5 +-
 fs/f2fs/super.c                         |  91 ++++++++++-------
 fs/f2fs/sysfs.c                         |  40 +++++++-
 fs/f2fs/verity.c                        |   4 +-
 fs/f2fs/xattr.c                         |  12 +--
 23 files changed, 699 insertions(+), 391 deletions(-)
