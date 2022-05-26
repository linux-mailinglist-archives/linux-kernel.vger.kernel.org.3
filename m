Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430A45348D3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346153AbiEZCVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345086AbiEZCU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:20:59 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE02ABCE89;
        Wed, 25 May 2022 19:20:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 69E7D10E6B42;
        Thu, 26 May 2022 12:20:55 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nu37N-00GSNd-2U; Thu, 26 May 2022 12:20:53 +1000
Date:   Thu, 26 May 2022 12:20:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, djwong@kernel.org
Subject: [GIT PULL] xfs: new code for 5.19
Message-ID: <20220526022053.GY2306852@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=628ee408
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
        a=7-415B0cAAAA:8 a=b1eTU9gVrWpk-Boai5cA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
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
of minutes ago, though the diffstat I got on merge:

105 files changed, 4862 insertions(+), 2773 deletions(-)

is slightly different to the diffstat the pull request generated.

If I've made any mistakes or done stuff that is considered wrong or
out of date, let me know and I'll fix them up - it's been a while
since I built a tree for upstream merge.

This is a big update with lots of new code. The tag describes them
all, so I'll just touch on teh higlights. The two main new features
are Large Extent Counts and Logged Attribute Replay - these are two
new foundational features that we are building more complex future
features on top of.

For upcoming functionality, we need to be able to store hundreds of
millions of xattrs per inode. The Large Extent Count feature removes
the limits that prevent this scale of xattr storage, and while we
were modifying the on disk extent count format we also increased the
number of data extents we support per inode from 2^32 to 2^47.

We also need to be able to modify xattrs as part of larger atomic
transactions rather than as standalone transactions. The Logged
Attribute Replay feature introduces the infrastructure that allows
us to use intents to record the attribute modifications in the
journal before we start them, hence allowing other atomic
transactions to log attribute modification intents and then defer
the actual modification to later. If we then crash, log recovery
then guarantees that the attribute is replayed in the context of the
atomic transaction that logged the intent.

A significant chunk of the commits in this merge are for the base
attribute replay functionality along with fixes, improvements and
cleanups related to this new functioanlity.  Allison deserves a big
round of thanks for her ongoing work to get this functionality into
XFS.

There are also many other smaller changes and improvements, so
overall this is one of the bigger XFS merge requests in some time.

I will be following up next week with another smaller pull request -
we already have another round of fixes and improvements to the
logged attribute replay functionality just about ready to go.
They'll soak and test over the next week, and I'll send a pull
request for them near the end of the merge window.

Thanks!

-Dave.


The following changes since commit 9a5280b312e2e7898b6397b2ca3cfd03f67d7be1:

  xfs: reorder iunlink remove operation in xfs_ifree (2022-04-21 08:45:16 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.19-for-linus

for you to fetch changes up to efd409a4329f6927795be5ae080cd3ec8c014f49:

  Merge branch 'xfs-5.19-quota-warn-remove' into xfs-5.19-for-next (2022-05-12 15:23:07 +1000)

----------------------------------------------------------------
xfs: Changes for 5.19-rc1

This update includes:
- support for printk message indexing.
- large extent counts to provide support for up to 2^47 data extents and 2^32
  attribute extents, allowing us to scale beyond 4 billion data extents
  to billions of xattrs per inode.
- conversion of various flags fields to be consistently declared as
  unsigned bit fields.
- improvements to realtime extent accounting and converts them to per-cpu
  counters to match all the other block and inode accounting.
- reworks core log formatting code to reduce iterations, have a shorter, cleaner
  fast path and generally be easier to understand and maintain.
- improvements to rmap btree searches that reduce overhead by up
  to 30% resulting in xfs_scrub runtime reductions of 15%.
- improvements to reflink that remove the size limitations in remapping operations
  and greatly reduce the size of transaction reservations.
- reworks the minimum log size calculations to allow us to change transaction
  reservations without changing the minimum supported log size.
- removal of quota warning support as it has never been used on Linux.
- intent whiteouts to allow us to cancel intents that are completed entirely
  in memory rather than having use CPU and disk bandwidth formatting and writing
  them into the journal when it is not necessary. This makes rmap, reflink and
  extent freeing slightly more efficient, but provides massive improvements
  for....
- Logged Attribute Replay feature support. This is a fundamental change to the
  way we modify attributes, laying the foundation for future integration of
  attribute modifications as part of other atomic transactional operations the
  filesystem performs.
- Lots of cleanups and fixes for the logged attribute replay functionality.

----------------------------------------------------------------
Allison Henderson (14):
      xfs: Fix double unlock in defer capture code
      xfs: Return from xfs_attr_set_iter if there are no more rmtblks to process
      xfs: Set up infrastructure for log attribute replay
      xfs: Implement attr logging and replay
      xfs: Skip flip flags for delayed attrs
      xfs: Add xfs_attr_set_deferred and xfs_attr_remove_deferred
      xfs: Remove unused xfs_attr_*_args
      xfs: Add log attribute error tag
      xfs: Add larp debug option
      xfs: Merge xfs_delattr_context into xfs_attr_item
      xfs: Add helper function xfs_attr_leaf_addname
      xfs: Add helper function xfs_init_attr_trans
      xfs: add leaf split error tag
      xfs: add leaf to node error tag

Brian Foster (1):
      xfs: fix soft lockup via spinning in filestream ag selection loop

Catherine Hoang (3):
      xfs: remove quota warning limit from struct xfs_quota_limits
      xfs: remove warning counters from struct xfs_dquot_res
      xfs: don't set quota warning values

Chandan Babu R (19):
      xfs: Move extent count limits to xfs_format.h
      xfs: Define max extent length based on on-disk format definition
      xfs: Introduce xfs_iext_max_nextents() helper
      xfs: Use xfs_extnum_t instead of basic data types
      xfs: Introduce xfs_dfork_nextents() helper
      xfs: Use basic types to define xfs_log_dinode's di_nextents and di_anextents
      xfs: Promote xfs_extnum_t and xfs_aextnum_t to 64 and 32-bits respectively
      xfs: Introduce XFS_SB_FEAT_INCOMPAT_NREXT64 and associated per-fs feature bit
      xfs: Introduce XFS_FSOP_GEOM_FLAGS_NREXT64
      xfs: Introduce XFS_DIFLAG2_NREXT64 and associated helpers
      xfs: Use uint64_t to count maximum blocks that can be used by BMBT
      xfs: Introduce macros to represent new maximum extent counts for data/attr forks
      xfs: Replace numbered inode recovery error messages with descriptive ones
      xfs: Introduce per-inode 64-bit extent counters
      xfs: Directory's data fork extent counter can never overflow
      xfs: Conditionally upgrade existing inodes to use large extent counters
      xfs: Decouple XFS_IBULK flags from XFS_IWALK flags
      xfs: Enable bulkstat ioctl to support 64-bit per-inode extent counters
      xfs: Add XFS_SB_FEAT_INCOMPAT_NREXT64 to the list of supported flags

Christoph Hellwig (2):
      xfs: change the type of ic_datap
      xfs: remove xlog_verify_dest_ptr

Darrick J. Wong (16):
      xfs: pass explicit mount pointer to rtalloc query functions
      xfs: recalculate free rt extents after log recovery
      xfs: use a separate frextents counter for rt extent reservations
      xfs: capture buffer ops in the xfs_buf tracepoints
      xfs: simplify xfs_rmap_lookup_le call sites
      xfs: speed up rmap lookups by using non-overlapped lookups when possible
      xfs: speed up write operations by using non-overlapped lookups when possible
      xfs: count EFIs when deciding to ask for a continuation of a refcount update
      xfs: stop artificially limiting the length of bunmap calls
      xfs: remove a __xfs_bunmapi call from reflink
      xfs: create shadow transaction reservations for computing minimum log size
      xfs: report "max_resp" used for min log size computation
      xfs: reduce the absurdly large log operation count
      xfs: reduce transaction reservations with reflink
      xfs: rewrite xfs_reflink_end_cow to use intents
      xfs: rename xfs_*alloc*_log_count to _block_count

Dave Chinner (73):
      xfs: factor out the CIL transaction header building
      xfs: only CIL pushes require a start record
      xfs: embed the xlog_op_header in the unmount record
      xfs: embed the xlog_op_header in the commit record
      xfs: log tickets don't need log client id
      xfs: move log iovec alignment to preparation function
      xfs: reserve space and initialise xlog_op_header in item formatting
      xfs: log ticket region debug is largely useless
      xfs: pass lv chain length into xlog_write()
      xfs: introduce xlog_write_full()
      xfs: introduce xlog_write_partial()
      xfs: xlog_write() no longer needs contwr state
      xfs: xlog_write() doesn't need optype anymore
      xfs: CIL context doesn't need to count iovecs
      xfs: convert attr type flags to unsigned.
      xfs: convert scrub type flags to unsigned.
      xfs: convert bmap extent type flags to unsigned.
      xfs: convert bmapi flags to unsigned.
      xfs: convert AGF log flags to unsigned.
      xfs: convert AGI log flags to unsigned.
      xfs: convert btree buffer log flags to unsigned.
      xfs: convert buffer log item flags to unsigned.
      xfs: convert da btree operations flags to unsigned.
      xfs: convert dquot flags to unsigned.
      xfs: convert log item tracepoint flags to unsigned.
      xfs: convert inode lock flags to unsigned.
      xfs: convert ptag flags to unsigned.
      xfs: convert quota options flags to unsigned.
      xfs: convert shutdown reasons to unsigned.
      xfs: convert log ticket and iclog flags to unsigned.
      Merge branch 'guilt/5.19-miscellaneous' into xfs-5.19-for-next
      Merge branch 'guilt/xfs-unsigned-flags-5.18' into xfs-5.19-for-next
      Merge branch 'guilt/xlog-write-rework' into xfs-5.19-for-next
      Merge tag 'large-extent-counters-v9' of https://github.com/chandanr/linux into xfs-5.19-for-next
      xfs: zero inode fork buffer at allocation
      xfs: fix potential log item leak
      xfs: hide log iovec alignment constraints
      xfs: don't commit the first deferred transaction without intents
      xfs: add log item flags to indicate intents
      xfs: tag transactions that contain intent done items
      xfs: factor and move some code in xfs_log_cil.c
      xfs: add log item method to return related intents
      xfs: whiteouts release intents that are not in the AIL
      xfs: intent item whiteouts
      xfs: detect self referencing btree sibling pointers
      xfs: validate inode fork size against fork format
      xfs: set XFS_FEAT_NLINK correctly
      xfs: validate v5 feature fields
      Merge branch 'guilt/xfs-5.19-misc-2' into xfs-5.19-for-next
      Merge branch 'guilt/xlog-intent-whiteouts' into xfs-5.19-for-next
      Merge tag 'rmap-speedups-5.19_2022-04-28' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-5.19-for-next
      Merge tag 'reflink-speedups-5.19_2022-04-28' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-5.19-for-next
      Merge branch 'guilt/xfs-5.19-fuzz-fixes' into xfs-5.19-for-next
      xfs: avoid empty xattr transaction when attrs are inline
      xfs: initialise attrd item to zero
      xfs: make xattri_leaf_bp more useful
      xfs: rework deferred attribute operation setup
      xfs: separate out initial attr_set states
      xfs: kill XFS_DAC_LEAF_ADDNAME_INIT
      xfs: consolidate leaf/node states in xfs_attr_set_iter
      xfs: split remote attr setting out from replace path
      xfs: XFS_DAS_LEAF_REPLACE state only needed if !LARP
      xfs: remote xattr removal in xfs_attr_set_iter() is conditional
      xfs: clean up final attr removal in xfs_attr_set_iter
      xfs: xfs_attr_set_iter() does not need to return EAGAIN
      xfs: introduce attr remove initial states into xfs_attr_set_iter
      xfs: switch attr remove to xfs_attri_set_iter
      xfs: remove xfs_attri_remove_iter
      xfs: use XFS_DA_OP flags in deferred attr ops
      xfs: ATTR_REPLACE algorithm with LARP enabled needs rework
      xfs: detect empty attr leaf blocks in xfs_attr3_leaf_verify
      xfs: can't use kmem_zalloc() for attribute buffers
      Merge branch 'xfs-5.19-quota-warn-remove' into xfs-5.19-for-next

Eric Sandeen (1):
      xfs: revert "xfs: actually bump warning counts when we send warnings"

Jonathan Lassoff (2):
      xfs: Simplify XFS logging methods.
      xfs: Add XFS messages to printk index

Kaixu Xia (1):
      xfs: simplify local variable assignment in file write code

Matthew Wilcox (Oracle) (1):
      xfs: Use generic_file_open()

Yang Xu (1):
      xfs: improve __xfs_set_acl

 fs/xfs/Makefile                 |    1 +
 fs/xfs/libxfs/xfs_alloc.c       |   12 +-
 fs/xfs/libxfs/xfs_alloc.h       |    2 +-
 fs/xfs/libxfs/xfs_attr.c        | 1644 +++++++++++++++++++--------------------
 fs/xfs/libxfs/xfs_attr.h        |  198 ++++-
 fs/xfs/libxfs/xfs_attr_leaf.c   |   64 +-
 fs/xfs/libxfs/xfs_attr_remote.c |   37 +-
 fs/xfs/libxfs/xfs_attr_remote.h |    6 +-
 fs/xfs/libxfs/xfs_bmap.c        |  167 ++--
 fs/xfs/libxfs/xfs_bmap.h        |   58 +-
 fs/xfs/libxfs/xfs_bmap_btree.c  |    9 +-
 fs/xfs/libxfs/xfs_btree.c       |  150 +++-
 fs/xfs/libxfs/xfs_btree.h       |   26 +-
 fs/xfs/libxfs/xfs_da_btree.c    |    4 +
 fs/xfs/libxfs/xfs_da_btree.h    |   25 +-
 fs/xfs/libxfs/xfs_da_format.h   |    9 +-
 fs/xfs/libxfs/xfs_defer.c       |   54 +-
 fs/xfs/libxfs/xfs_defer.h       |    3 +
 fs/xfs/libxfs/xfs_dir2.c        |    8 +
 fs/xfs/libxfs/xfs_errortag.h    |    8 +-
 fs/xfs/libxfs/xfs_format.h      |  189 +++--
 fs/xfs/libxfs/xfs_fs.h          |   41 +-
 fs/xfs/libxfs/xfs_ialloc.c      |    8 +-
 fs/xfs/libxfs/xfs_ialloc.h      |    2 +-
 fs/xfs/libxfs/xfs_inode_buf.c   |  118 ++-
 fs/xfs/libxfs/xfs_inode_fork.c  |   51 +-
 fs/xfs/libxfs/xfs_inode_fork.h  |   76 +-
 fs/xfs/libxfs/xfs_log_format.h  |   79 +-
 fs/xfs/libxfs/xfs_log_recover.h |    2 +
 fs/xfs/libxfs/xfs_log_rlimit.c  |   75 +-
 fs/xfs/libxfs/xfs_quota_defs.h  |   50 +-
 fs/xfs/libxfs/xfs_refcount.c    |   14 +-
 fs/xfs/libxfs/xfs_refcount.h    |   13 +-
 fs/xfs/libxfs/xfs_rmap.c        |  161 ++--
 fs/xfs/libxfs/xfs_rmap.h        |    7 +-
 fs/xfs/libxfs/xfs_rtbitmap.c    |    9 +-
 fs/xfs/libxfs/xfs_sb.c          |   80 +-
 fs/xfs/libxfs/xfs_shared.h      |   24 +-
 fs/xfs/libxfs/xfs_trans_resv.c  |  225 ++++--
 fs/xfs/libxfs/xfs_trans_resv.h  |   16 +-
 fs/xfs/libxfs/xfs_types.h       |   11 +-
 fs/xfs/scrub/bmap.c             |   26 +-
 fs/xfs/scrub/common.c           |    2 +
 fs/xfs/scrub/inode.c            |   20 +-
 fs/xfs/scrub/rtbitmap.c         |    9 +-
 fs/xfs/xfs_acl.c                |    4 +-
 fs/xfs/xfs_acl.h                |    8 +-
 fs/xfs/xfs_attr_item.c          |  824 ++++++++++++++++++++
 fs/xfs/xfs_attr_item.h          |   46 ++
 fs/xfs/xfs_attr_list.c          |    1 +
 fs/xfs/xfs_bmap_item.c          |   27 +-
 fs/xfs/xfs_bmap_util.c          |   27 +-
 fs/xfs/xfs_buf_item.h           |   24 +-
 fs/xfs/xfs_dquot.c              |   18 +-
 fs/xfs/xfs_dquot.h              |    8 -
 fs/xfs/xfs_error.c              |    9 +
 fs/xfs/xfs_error.h              |   20 +-
 fs/xfs/xfs_extfree_item.c       |   23 +-
 fs/xfs/xfs_file.c               |   24 +-
 fs/xfs/xfs_filestream.c         |    7 +-
 fs/xfs/xfs_fsmap.c              |    6 +-
 fs/xfs/xfs_fsops.c              |    7 +-
 fs/xfs/xfs_globals.c            |    1 +
 fs/xfs/xfs_icache.c             |    9 +-
 fs/xfs/xfs_icreate_item.c       |    1 +
 fs/xfs/xfs_inode.c              |   80 +-
 fs/xfs/xfs_inode.h              |   29 +-
 fs/xfs/xfs_inode_item.c         |   48 +-
 fs/xfs/xfs_inode_item_recover.c |  145 +++-
 fs/xfs/xfs_ioctl.c              |    7 +-
 fs/xfs/xfs_ioctl32.c            |    2 +
 fs/xfs/xfs_iomap.c              |   33 +-
 fs/xfs/xfs_iops.c               |    4 +-
 fs/xfs/xfs_itable.c             |   15 +-
 fs/xfs/xfs_itable.h             |    5 +-
 fs/xfs/xfs_iwalk.h              |    2 +-
 fs/xfs/xfs_log.c                |  807 +++++++++----------
 fs/xfs/xfs_log.h                |   90 ++-
 fs/xfs/xfs_log_cil.c            |  391 ++++++----
 fs/xfs/xfs_log_priv.h           |   89 +--
 fs/xfs/xfs_log_recover.c        |    2 +
 fs/xfs/xfs_message.c            |   58 +-
 fs/xfs/xfs_message.h            |   55 +-
 fs/xfs/xfs_mount.c              |   91 ++-
 fs/xfs/xfs_mount.h              |   32 +-
 fs/xfs/xfs_ondisk.h             |    2 +
 fs/xfs/xfs_qm.c                 |    9 -
 fs/xfs/xfs_qm.h                 |    5 -
 fs/xfs/xfs_qm_syscalls.c        |   26 +-
 fs/xfs/xfs_quotaops.c           |    8 +-
 fs/xfs/xfs_refcount_item.c      |   25 +-
 fs/xfs/xfs_reflink.c            |  100 ++-
 fs/xfs/xfs_rmap_item.c          |   25 +-
 fs/xfs/xfs_rtalloc.c            |   41 +
 fs/xfs/xfs_rtalloc.h            |    9 +-
 fs/xfs/xfs_super.c              |   18 +-
 fs/xfs/xfs_symlink.c            |    5 -
 fs/xfs/xfs_sysctl.h             |    1 +
 fs/xfs/xfs_sysfs.c              |   24 +
 fs/xfs/xfs_trace.h              |  100 ++-
 fs/xfs/xfs_trans.c              |   52 +-
 fs/xfs/xfs_trans.h              |   38 +-
 fs/xfs/xfs_trans_dquot.c        |    4 +-
 fs/xfs/xfs_xattr.c              |    2 +-
 104 files changed, 4690 insertions(+), 2676 deletions(-)
 create mode 100644 fs/xfs/xfs_attr_item.c
 create mode 100644 fs/xfs/xfs_attr_item.h
-- 
Dave Chinner
david@fromorbit.com
