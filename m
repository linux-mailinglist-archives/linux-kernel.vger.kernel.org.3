Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE40358CC25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbiHHQcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiHHQcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:32:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90EEAE58
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 468086113A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 16:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F44C433C1;
        Mon,  8 Aug 2022 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659976318;
        bh=cwNxKvCPscZzMfVxaKfuYUk0NZE66nFLFWd0ssdUEOk=;
        h=Date:From:To:Cc:Subject:From;
        b=t68tgDzyCdSC6LtPZIPI/eCQvTRhbqymjJ27LjTeg9+95pCIRpXllkilBrra7LLIK
         AdL4KJ/P25otAyGMAIW0T83PXokxoSMeNA0mNPMK3NvcZjLtqid6VulmRd3/2pKO9B
         w9i3AOzxOXDIZNhJLwOl48mclWK7bCXDSV1f9FxL6APyQ2LGNKl97fo/bFiuCk7hne
         mx79HZ2Xd4Xj3Xnz8oTA1Q3SMOrMLMabmwM+eUM56h13z1Lvpxi4T+w74PUaWsGi5N
         Ml4PoTMnIeHnrNP5lr3z+pB4mSJKR8J92gj0RiKBVuYfu6ZYimG2ZEGhECL/V7XNSA
         IFb0Z4/eKIfXA==
Date:   Mon, 8 Aug 2022 09:31:56 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs for 6.0
Message-ID: <YvE6fO1r0znOdr60@google.com>
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

The following changes since commit 0840a7914caa14315a3191178a9f72c742477860:

  Merge tag 'char-misc-5.19-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc (2022-06-25 10:07:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.0

for you to fetch changes up to 01fc4b9a6ed8eacb64e5609bab7ac963e1c7e486:

  f2fs: use onstack pages instead of pvec (2022-08-05 04:20:55 -0700)

----------------------------------------------------------------
f2fs-for-6.0

In this cycle, we mainly fixed some corner cases that manipulate a per-file
compression flag inappropriately. And, we found f2fs counted valid blocks in a
section incorrectly when zone capacity is set, and thus, fixed it with
additional sysfs entry to check it easily. Lastly, this series includes
several patches with respect to the new atomic write support such as a
couple of bug fixes and re-adding atomic_write_abort support that we removed
by mistake in the previous release.

Enhancement:
 - add sysfs entries to understand atomic write operations and zone
   capacity
 - introduce memory mode to get a hint for low-memory devices
 - adjust the waiting time of foreground GC
 - decompress clusters under softirq to avoid non-deterministic latency
 - do not skip updating inode when retrying to flush node page
 - enforce single zone capacity

Bug fix:
 - set the compression/no-compression flags correctly
 - revive F2FS_IOC_ABORT_VOLATILE_WRITE
 - check inline_data during compressed inode conversion
 - understand zone capacity when calculating valid block count

As usual, the series includes several minor clean-ups and sanity checks.

----------------------------------------------------------------
Chao Liu (2):
      f2fs: allow compression of files without blocks
      f2fs: fix to remove F2FS_COMPR_FL and tag F2FS_NOCOMP_FL at the same time

Chao Yu (8):
      f2fs: initialize page_array_entry slab only if compression feature is on
      f2fs: fix to invalidate META_MAPPING before DIO write
      f2fs: fix to check inline_data during compressed inode conversion
      f2fs: invalidate meta pages only for post_read required inode
      f2fs: fix to avoid use f2fs_bug_on() in f2fs_new_node_page()
      f2fs: obsolete unused MAX_DISCARD_BLOCKS
      f2fs: fix to do sanity check on segment type in build_sit_entries()
      f2fs: clean up f2fs_abort_atomic_write()

Daeho Jeong (4):
      f2fs: introduce memory mode
      f2fs: introduce sysfs atomic write statistics
      f2fs: revive F2FS_IOC_ABORT_VOLATILE_WRITE
      f2fs: handle decompress only post processing in softirq

Eric Biggers (1):
      f2fs: use the updated test_dummy_encryption helper functions

Eunhee Rho (1):
      f2fs: remove device type check for direct IO

Fabio M. De Francesco (1):
      f2fs: Delete f2fs_copy_page() and replace with memcpy_page()

Fengnan Chang (2):
      f2fs: intorduce f2fs_all_cluster_page_ready
      f2fs: use onstack pages instead of pvec

Jack Qiu (1):
      f2fs: optimize error handling in redirty_blocks

Jaegeuk Kim (5):
      f2fs: do not skip updating inode when retrying to flush node page
      f2fs: enforce single zone capacity
      f2fs: adjust zone capacity when considering valid block count
      f2fs: add a sysfs entry to show zone capacity
      f2fs: do not set compression bit if kernel doesn't support

Jaewook Kim (1):
      f2fs: do not allow to decompress files have FI_COMPRESS_RELEASED

Ye Bin (1):
      f2fs: fix null-ptr-deref in f2fs_get_dnode_of_data

duguowei (1):
      f2fs: remove redundant code for gc condition

qixiaoyu1 (1):
      f2fs: don't bother wait_ms by foreground gc

 Documentation/ABI/testing/sysfs-fs-f2fs |  30 +++++
 Documentation/filesystems/f2fs.rst      |   5 +
 fs/f2fs/compress.c                      | 229 +++++++++++++++++++++-----------
 fs/f2fs/data.c                          |  82 +++++++-----
 fs/f2fs/debug.c                         |   2 +-
 fs/f2fs/f2fs.h                          | 102 ++++++++++----
 fs/f2fs/file.c                          |  79 +++++++----
 fs/f2fs/gc.c                            |  11 +-
 fs/f2fs/gc.h                            |  21 ++-
 fs/f2fs/inode.c                         |   3 +-
 fs/f2fs/node.c                          |  14 +-
 fs/f2fs/segment.c                       |  79 ++++++-----
 fs/f2fs/segment.h                       |  11 +-
 fs/f2fs/super.c                         |  90 ++++++++-----
 fs/f2fs/sysfs.c                         |  56 ++++++++
 include/uapi/linux/f2fs.h               |   2 +-
 16 files changed, 562 insertions(+), 254 deletions(-)
