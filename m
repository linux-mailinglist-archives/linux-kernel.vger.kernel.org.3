Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4ED47AA91
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhLTNsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:48:20 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30147 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhLTNsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:48:18 -0500
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JHgpY2PqCz8vms;
        Mon, 20 Dec 2021 21:45:57 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 21:48:15 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 20 Dec
 2021 21:48:15 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH v5 00/14] Some bugfixs for ubi/ubifs
Date:   Mon, 20 Dec 2021 21:59:37 +0800
Message-ID: <20211220135951.4075801-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
  1. Add new fix for ubifs, "ubifs: Fix to add refcount once page is set
  private"
  2. Update "ubifs: Rename whiteout atomically":
     1) Move inode mode in create_whiteout()
     2) Don't check O_SYNC for whiteout, because it inherits from the old_dir
     3) Remove useless 'synced_i_size ' assignment for whiteout, because
	it's always be zero.
     4) Remove unused variable 'ui' in create_whiteout()
  3. Update "ubifs: setflags: Make dirtied_ino_d 8 bytes aligned":
     1) Align dirtied_ino_d with 8 bytes.

v2->v3:
  1. Update "ubifs: Rename whiteout atomically":
     1) Fix misspelling 'have already check the old dir inode' ->
        'have already checked the old dir inode'
     2) Fix misspelling "Whiteout don't have non-zero size" ->
        "Whiteout  have non-zero size"
  2. Update "ubifs: Fix to add refcount once page is set private"
     1) Fix commit message to explain the root cause.
  3. Update "ubi: fastmap: Add all fastmap pebs into 'ai->fastmap' when
     fm->used_blocks>=2"
     1) Add fastmap used pebs into 'ai' in for-loop, rather than in
        two-steps(Add pebs [pnum<UBI_FM_MAX_START] then add pebs
	[pnum>=UBI_FM_MAX_START] into 'ai').

v3->v4:
  1. Update "ubifs: Add missing iput if do_tmpfile() failed in rename whiteout":
     1) Move whiteout cleanup into do_tmpfile() according to Sascha's advice
  2. Add new fix for ubifs, "ubifs: ubifs_writepage: Mark page dirty after
     writing inode failed"

v4->v5:
  1. Add new fix for ubifs, "ubifs: ubifs_releasepage: Remove ubifs_assert(0)
     to valid this process"

Zhihao Cheng (14):
  ubifs: rename_whiteout: Fix double free for whiteout_ui->data
  ubifs: Fix deadlock in concurrent rename whiteout and inode writeback
  ubifs: Fix wrong number of inodes locked by ui_mutex in ubifs_inode
    comment
  ubifs: Add missing iput if do_tmpfile() failed in rename whiteout
  ubifs: Rename whiteout atomically
  ubifs: Fix 'ui->dirty' race between do_tmpfile() and writeback work
  ubifs: Rectify space amount budget for mkdir/tmpfile operations
  ubifs: setflags: Make dirtied_ino_d 8 bytes aligned
  ubifs: Fix read out-of-bounds in ubifs_wbuf_write_nolock()
  ubifs: Fix to add refcount once page is set private
  ubi: fastmap: Return error code if memory allocation fails in
    add_aeb()
  ubi: fastmap: Add all fastmap pebs into 'ai->fastmap' when
    fm->used_blocks>=2
  ubifs: ubifs_writepage: Mark page dirty after writing inode failed
  ubifs: ubifs_releasepage: Remove ubifs_assert(0) to valid this process

 drivers/mtd/ubi/fastmap.c |  63 ++++------
 fs/ubifs/dir.c            | 235 +++++++++++++++++++++++---------------
 fs/ubifs/file.c           |  45 +++++---
 fs/ubifs/io.c             |  34 +++++-
 fs/ubifs/ioctl.c          |   2 +-
 fs/ubifs/journal.c        |  52 +++++++--
 fs/ubifs/ubifs.h          |   2 +-
 7 files changed, 272 insertions(+), 161 deletions(-)

-- 
2.31.1

