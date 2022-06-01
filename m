Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D751053AEFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiFAWOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 18:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiFAWOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 18:14:35 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 663585F9B;
        Wed,  1 Jun 2022 15:14:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A46FA5EC461;
        Thu,  2 Jun 2022 08:14:32 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwWbn-001YiB-8s; Thu, 02 Jun 2022 08:14:31 +1000
Date:   Thu, 2 Jun 2022 08:14:31 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, djwong@kernel.org
Subject: [GIT PULL] xfs: changes for 5.19-rc1 [2nd set]
Message-ID: <20220601221431.GG227878@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6297e4c9
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=cXHwiYC6wMMmn7TOMiUA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you please pull the XFS updates for 5.19 from the tag listed
below? It merges cleanly with the TOT kernel I just pulled a couple
of minutes ago, with no difference in the diffstat below this time.

This update is largely bug fixes and cleanups for all the code
merged in the first pull request. The majority of them are to the
new logged attribute code, but there are also a couple of fixes for
other log recovery and memory leaks that have recently been found.

Some of the code in the tree predates that pull request, so there is
still a couple of empty merge commit messages. All the branches
merged since the last pull request have descriptions and SOB tags in
the merge commits to explain what was merged and where it came from.

If there's any problems with the tree, let me know and I'll fix it
up as needed.

Cheers,

Dave.
-----
The following changes since commit efd409a4329f6927795be5ae080cd3ec8c014f49:

  Merge branch 'xfs-5.19-quota-warn-remove' into xfs-5.19-for-next (2022-05-12 15:23:07 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.19-for-linus-2

for you to fetch changes up to 7146bda743e6f543af60584fad2cfbb6ce83d8ac:

  Merge branch 'guilt/xfs-5.19-larp-cleanups' into xfs-5.19-for-next (2022-05-30 10:58:59 +1000)

----------------------------------------------------------------
xfs: Changes for 5.19-rc1 [2nd set]

This update includes:
- fix refcount leak in xfs_ifree()
- fix xfs_buf_cancel structure leaks in log recovery
- fix dquot leak after failed quota check
- fix a couple of problematic ASSERTS
- fix small aim7 perf regression in from new btree sibling
  validation
- clean up log incompat feature marking for new logged attribute
  feature
- disallow logged attributes on legacy V4 filesystem formats.
- fix da state leak when freeing attr intents
- improve validation of the attr log items in recovery
- use slab caches for commonly used attr structures
- fix leaks of attr name/value buffer and reduce copying overhead
  during intent logging
- remove some dead debug code from log recovery

----------------------------------------------------------------
Brian Foster (1):
      xfs: fix xfs_ifree() error handling to not leak perag ref

Darrick J. Wong (25):
      xfs: don't leak da state when freeing the attr intent item
      xfs: don't leak the retained da state when doing a leaf to node conversion
      xfs: reject unknown xattri log item operation flags during recovery
      xfs: reject unknown xattri log item filter flags during recovery
      xfs: validate xattr name earlier in recovery
      xfs: free xfs_attrd_log_items correctly
      xfs: clean up xfs_attr_node_hasname
      xfs: put the xattr intent item op flags in their own namespace
      xfs: use a separate slab cache for deferred xattr work state
      xfs: remove struct xfs_attr_item.xattri_flags
      xfs: put attr[id] log item cache init with the others
      xfs: clean up state variable usage in xfs_attr_node_remove_attr
      xfs: rename struct xfs_attr_item to xfs_attr_intent
      xfs: do not use logged xattr updates on V4 filesystems
      xfs: share xattr name and value buffers when logging xattr updates
      xfs: purge dquots after inode walk fails during quotacheck
      xfs: don't leak btree cursor when insrec fails after a split
      xfs: refactor buffer cancellation table allocation
      xfs: don't leak xfs_buf_cancel structures when recovery fails
      xfs: convert buf_cancel_table allocation to kmalloc_array
      xfs: don't log every time we clear the log incompat flags
      xfs: implement per-mount warnings for scrub and shrink usage
      xfs: warn about LARP once per mount
      xfs: move xfs_attr_use_log_assist out of xfs_log.c
      xfs: move xfs_attr_use_log_assist usage out of libxfs

Dave Chinner (6):
      Merge branch 'guilt/xfs-5.19-misc-3' into xfs-5.19-for-next
      xfs: avoid unnecessary runtime sibling pointer endian conversions
      xfs: don't assert fail on perag references on teardown
      xfs: assert in xfs_btree_del_cursor should take into account error
      Merge branch 'guilt/xfs-5.19-recovery-buf-cancel' into xfs-5.19-for-next
      Merge branch 'guilt/xfs-5.19-larp-cleanups' into xfs-5.19-for-next

Jiapeng Chong (2):
      xfs: Remove dead code
      xfs: Remove duplicate include

Julia Lawall (1):
      xfs: fix typo in comment

Kaixu Xia (1):
      xfs: reduce IOCB_NOWAIT judgment for retry exclusive unaligned DIO

 fs/xfs/libxfs/xfs_ag.c             |   3 +-
 fs/xfs/libxfs/xfs_attr.c           | 198 +++++++++++++++++++++++---------------------------
 fs/xfs/libxfs/xfs_attr.h           |  63 ++++++++--------
 fs/xfs/libxfs/xfs_attr_remote.c    |   6 +-
 fs/xfs/libxfs/xfs_attr_remote.h    |   6 +-
 fs/xfs/libxfs/xfs_btree.c          |  63 +++++++++++-----
 fs/xfs/libxfs/xfs_da_btree.c       |  11 +++
 fs/xfs/libxfs/xfs_da_btree.h       |   1 +
 fs/xfs/libxfs/xfs_defer.c          |  67 ++++++++++++-----
 fs/xfs/libxfs/xfs_log_format.h     |  18 +++--
 fs/xfs/libxfs/xfs_log_recover.h    |  14 ++--
 fs/xfs/libxfs/xfs_symlink_remote.c |   2 +-
 fs/xfs/scrub/scrub.c               |  17 +----
 fs/xfs/xfs_acl.c                   |   3 +-
 fs/xfs/xfs_attr_item.c             | 364 +++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------
 fs/xfs/xfs_attr_item.h             |  22 ++++--
 fs/xfs/xfs_buf_item_recover.c      |  66 +++++++++++++++++
 fs/xfs/xfs_file.c                  |   2 +-
 fs/xfs/xfs_fsops.c                 |   7 +-
 fs/xfs/xfs_inode.c                 |   2 +-
 fs/xfs/xfs_ioctl.c                 |   3 +-
 fs/xfs/xfs_iops.c                  |   3 +-
 fs/xfs/xfs_log.c                   |  41 -----------
 fs/xfs/xfs_log.h                   |   7 ++
 fs/xfs/xfs_log_priv.h              |   3 -
 fs/xfs/xfs_log_recover.c           |  93 +++---------------------
 fs/xfs/xfs_message.h               |   6 ++
 fs/xfs/xfs_mount.c                 |   1 -
 fs/xfs/xfs_mount.h                 |  18 ++++-
 fs/xfs/xfs_qm.c                    |   9 ++-
 fs/xfs/xfs_super.c                 |  20 ++++++
 fs/xfs/xfs_super.h                 |   1 -
 fs/xfs/xfs_xattr.c                 |  79 +++++++++++++++++++-
 fs/xfs/xfs_xattr.h                 |  13 ++++
 34 files changed, 719 insertions(+), 513 deletions(-)
 create mode 100644 fs/xfs/xfs_xattr.h

-- 
Dave Chinner
david@fromorbit.com
