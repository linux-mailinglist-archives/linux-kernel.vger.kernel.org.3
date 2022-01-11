Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07F148A90E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348767AbiAKIC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:02:58 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:44266 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiAKIC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:02:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C3C03614E2CB;
        Tue, 11 Jan 2022 09:02:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wfkZJKRbZZQs; Tue, 11 Jan 2022 09:02:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 62121614E2CF;
        Tue, 11 Jan 2022 09:02:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ixt6GZdbcyyU; Tue, 11 Jan 2022 09:02:55 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 392BC614E2CB;
        Tue, 11 Jan 2022 09:02:55 +0100 (CET)
Date:   Tue, 11 Jan 2022 09:02:55 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1617448966.248428.1641888175120.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] JFFS2, UBI and UBIFS changes for 5.17
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Index: fyrxjW5e9rHUHWYPDWEjg37yKpfbtw==
Thread-Topic: JFFS2, UBI and UBIFS changes for 5.17
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit a7904a538933c525096ca2ccde1e60d0ee62c08e:

  Linux 5.16-rc6 (2021-12-19 14:14:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.17-rc1

for you to fetch changes up to aa39cc675799bc92da153af9a13d6f969c348e82:

  jffs2: GC deadlock reading a page that is used in jffs2_write_begin() (2021-12-23 22:33:41 +0100)

----------------------------------------------------------------
This pull request contains the following changes for JFFS2, UBI and UBIFS:

JFFS2:
- Fix for a deadlock in jffs2_write_begin()

UBI:
- Fixes in comments

UBIFS:
- Expose error counters in sysfs
- Many bugfixes found by Hulk Robot and others

----------------------------------------------------------------
Alexander Dahl (1):
      ubifs: Fix spelling mistakes

Baokun Li (3):
      ubifs: fix slab-out-of-bounds in ubifs_change_lp
      ubifs: fix double return leb in ubifs_garbage_collect
      ubifs: read-only if LEB may always be taken in ubifs_garbage_collect

Cai Huoqing (1):
      ubifs: Make use of the helper macro kthread_run()

Dan Carpenter (1):
      ubifs: fix snprintf() length check

Kai Song (1):
      ubi: Fix a mistake in comment

Kyeong Yoo (1):
      jffs2: GC deadlock reading a page that is used in jffs2_write_begin()

Petr Cvachoucek (1):
      ubifs: Error path in ubifs_remount_rw() seems to wrongly free write buffers

Stefan Schaeckeler (2):
      ubifs: Export filesystem error counters
      ubifs: Document sysfs nodes

 Documentation/ABI/testing/sysfs-fs-ubifs |  35 +++++++
 MAINTAINERS                              |   1 +
 drivers/mtd/ubi/debug.c                  |   2 +-
 fs/jffs2/file.c                          |  40 +++++---
 fs/ubifs/Makefile                        |   2 +-
 fs/ubifs/dir.c                           |   4 +-
 fs/ubifs/gc.c                            |  19 +++-
 fs/ubifs/io.c                            |  21 +++++
 fs/ubifs/replay.c                        |   2 +-
 fs/ubifs/super.c                         |  23 +++--
 fs/ubifs/sysfs.c                         | 153 +++++++++++++++++++++++++++++++
 fs/ubifs/ubifs.h                         |  35 +++++++
 12 files changed, 309 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-ubifs
 create mode 100644 fs/ubifs/sysfs.c
