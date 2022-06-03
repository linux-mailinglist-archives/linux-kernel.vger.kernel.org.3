Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C54353CA27
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244227AbiFCMrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiFCMrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:47:14 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2505D5F41
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:47:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 51AF4609B3C1;
        Fri,  3 Jun 2022 14:47:09 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CPGJgO34VG6Q; Fri,  3 Jun 2022 14:47:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C2DD5609B3C2;
        Fri,  3 Jun 2022 14:47:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PlKBWE2AaC1S; Fri,  3 Jun 2022 14:47:08 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 994E7609B3C1;
        Fri,  3 Jun 2022 14:47:08 +0200 (CEST)
Date:   Fri, 3 Jun 2022 14:47:08 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <735024820.130152.1654260428562.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] JFFS2, UBI and UBIFS updates for v5.19-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: 1D42N45nL6ShMgyGtxZkZMfsOi2J+w==
Thread-Topic: JFFS2, UBI and UBIFS updates for v5.19-rc1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.19-rc1

for you to fetch changes up to 8c03a1c21d72210f81cb369cc528e3fde4b45411:

  ubi: ubi_create_volume: Fix use-after-free when volume creation failed (2022-05-27 16:49:41 +0200)

----------------------------------------------------------------
This pull request contains fixes for JFFS2, UBI and UBIFS

JFFS2:
        - Fixes for a memory leak

UBI:
        - Fixes for fastmap (UAF, high CPU usage)

UBIFS:
        - Minor cleanups

----------------------------------------------------------------
Baokun Li (1):
      jffs2: fix memory leak in jffs2_do_fill_super

Haowen Bai (2):
      jffs2: Use kzalloc instead of kmalloc/memset
      ubifs: Use NULL instead of using plain integer as pointer

Minghao Chi (1):
      ubifs: Simplify the return expression of run_gc()

Zhihao Cheng (3):
      ubi: fastmap: Fix high cpu usage of ubi_bgt by making sure wl_pool not empty
      ubi: fastmap: Check wl_pool for free peb before wear leveling
      ubi: ubi_create_volume: Fix use-after-free when volume creation failed

 drivers/mtd/ubi/fastmap-wl.c | 121 +++++++++++++++++++++++++++++++++++--------
 drivers/mtd/ubi/fastmap.c    |  11 ----
 drivers/mtd/ubi/ubi.h        |   4 +-
 drivers/mtd/ubi/vmt.c        |   1 -
 drivers/mtd/ubi/wl.c         |  33 ++++++++----
 drivers/mtd/ubi/wl.h         |   2 +
 fs/jffs2/erase.c             |   6 +--
 fs/jffs2/fs.c                |   1 +
 fs/ubifs/budget.c            |   7 +--
 fs/ubifs/xattr.c             |   2 +-
 10 files changed, 129 insertions(+), 59 deletions(-)
