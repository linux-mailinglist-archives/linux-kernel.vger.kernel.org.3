Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BE84EE307
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241623AbiCaVGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbiCaVGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:06:09 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F8863BD2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:04:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B2D1E609B3CB;
        Thu, 31 Mar 2022 23:04:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KXq5bdCwI6eH; Thu, 31 Mar 2022 23:04:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4380A614E2F4;
        Thu, 31 Mar 2022 23:04:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qpofYdCL9ADw; Thu, 31 Mar 2022 23:04:20 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2A640609B3CB;
        Thu, 31 Mar 2022 23:04:20 +0200 (CEST)
Date:   Thu, 31 Mar 2022 23:04:20 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <678407645.204324.1648760660133.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] JFFS2, UBI and UBIFS fixes for 5.18
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: dHWwhMT9Bg43NSBogJ+HKHdWxxbsHQ==
Thread-Topic: JFFS2, UBI and UBIFS fixes for 5.18
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit aa39cc675799bc92da153af9a13d6f969c348e82:

  jffs2: GC deadlock reading a page that is used in jffs2_write_begin() (2021-12-23 22:33:41 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.18-rc1

for you to fetch changes up to 705757274599e2e064dd3054aabc74e8af31a095:

  ubifs: rename_whiteout: correct old_dir size computing (2022-03-17 23:34:07 +0100)


Please note that there is a minor merge conflict with the folio tree tree
between commits
3b67db8a6ca8 ("ubifs: Fix to add refcount once page is set private")
and
c337f2f4f746 ("ubifs: Convert from invalidatepage to invalidate_folio").

I'll happily review your merge resolution.

----------------------------------------------------------------
This pull request contains fixes for JFFS2, UBI and UBIFS

JFFS2:
        - Fixes for various memory issues

UBI:
        - Fix for a race condition in cdev ioctl handler

UBIFS:
	- Fixes for O_TMPFILE and whiteout handling
	- Fixes for various memory issues

----------------------------------------------------------------
Baokun Li (5):
      ubi: Fix race condition between ctrl_cdev_ioctl and ubi_cdev_ioctl
      jffs2: fix use-after-free in jffs2_clear_xattr_subsystem
      jffs2: fix memory leak in jffs2_do_mount_fs
      jffs2: fix memory leak in jffs2_scan_medium
      ubifs: rename_whiteout: correct old_dir size computing

Zhihao Cheng (11):
      ubifs: rename_whiteout: Fix double free for whiteout_ui->data
      ubifs: Fix deadlock in concurrent rename whiteout and inode writeback
      ubifs: Fix wrong number of inodes locked by ui_mutex in ubifs_inode comment
      ubifs: Add missing iput if do_tmpfile() failed in rename whiteout
      ubifs: Rename whiteout atomically
      ubifs: Fix 'ui->dirty' race between do_tmpfile() and writeback work
      ubifs: Rectify space amount budget for mkdir/tmpfile operations
      ubifs: setflags: Make dirtied_ino_d 8 bytes aligned
      ubifs: Fix read out-of-bounds in ubifs_wbuf_write_nolock()
      ubifs: Fix to add refcount once page is set private
      ubi: fastmap: Return error code if memory allocation fails in add_aeb()

hongnanli (1):
      fs/jffs2: fix comments mentioning i_mutex

 drivers/mtd/ubi/build.c   |   9 +-
 drivers/mtd/ubi/fastmap.c |  28 ++++--
 drivers/mtd/ubi/vmt.c     |   8 +-
 fs/jffs2/build.c          |   4 +-
 fs/jffs2/fs.c             |   2 +-
 fs/jffs2/jffs2_fs_i.h     |   4 +-
 fs/jffs2/scan.c           |   6 +-
 fs/ubifs/dir.c            | 238 ++++++++++++++++++++++++++++------------------
 fs/ubifs/file.c           |  14 +--
 fs/ubifs/io.c             |  34 ++++++-
 fs/ubifs/ioctl.c          |   2 +-
 fs/ubifs/journal.c        |  52 ++++++++--
 fs/ubifs/ubifs.h          |   2 +-
 13 files changed, 259 insertions(+), 144 deletions(-)
