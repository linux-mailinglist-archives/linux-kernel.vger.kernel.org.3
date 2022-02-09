Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A04AEB38
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbiBIHhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbiBIHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:37:03 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB2C0613CA;
        Tue,  8 Feb 2022 23:37:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0V4-AWIs_1644392216;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V4-AWIs_1644392216)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 15:37:03 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     xfs <linux-xfs@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 0/3] xfs: some end COW remapping optimization
Date:   Wed,  9 Feb 2022 15:36:52 +0800
Message-Id: <20220209073655.22162-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Currently, xfs_reflink_end_cow_extent() will unconditionally unmap an
extent from DATA fork and then remap an extent from COW fork. It seems
somewhat ineffective since for many cases we could update real bmbt
records directly by sightly enhancing old
xfs_bmap_add_extent_unwritten_real() implementation, thus reduce some
measurable extra metadata overhead.

It's important to us since, actually, we're planing to use a modified
alway-cow like atomic write approach internally for database
applications, therefore it'd be nice to do some optimization over
simple end COW approach. Also I think it's still generic and can
benefit other reflink use cases as well.

I did some tests with ramdisk in order to measure metadata overhead:

echo 1 > /sys/fs/xfs/debug/always_cow
mkfs.xfs -f -mreflink=1 /dev/ram0
mount /dev/ram0 testdir
fio -filename=testdir/1 -size=1G -ioengine=psync -bs=4k -rw=randwrite -overwrite=1 -direct=1 -end_fsync=1 -name=job1

Test results as below:
Vanilla:
(1)   iops        : min= 7986, max=16434, avg=12505.76, stdev=2400.05, samples=41
(2)   iops        : min= 7636, max=16376, avg=12474.19, stdev=2258.18, samples=42
(3)   iops        : min= 8346, max=16439, avg=12227.95, stdev=2432.12, samples=42
(4)   iops        : min= 8580, max=16496, avg=12779.41, stdev=2297.42, samples=41
(5)   iops        : min= 8286, max=16556, avg=12500.76, stdev=2123.90, samples=41

Patched:
(1)   iops        : min= 7086, max=17132, avg=12931.20, stdev=2729.10, samples=40
(2)   iops        : min= 7704, max=17508, avg=13204.62, stdev=2507.70, samples=39
(3)   iops        : min= 8736, max=17634, avg=13253.08, stdev=2545.18, samples=39
(4)   iops        : min= 7188, max=17550, avg=12928.40, stdev=2633.64, samples=40
(5)   iops        : min= 8268, max=17446, avg=12837.55, stdev=2717.98, samples=40

It's still immature so far yet xfstests seems survived.
Comments are much welcomed and thanks for your time!

Thanks,
Gao Xiang

Gao Xiang (3):
  xfs: get rid of LEFT, RIGHT, PREV in
    xfs_bmap_add_extent_unwritten_real()
  xfs: introduce xfs_bmap_update_extent_real()
  xfs: introduce xfs_bremapi_from_cowfork()

 fs/xfs/libxfs/xfs_bmap.c | 378 +++++++++++++++++++++++++--------------
 fs/xfs/libxfs/xfs_bmap.h |   7 +-
 fs/xfs/xfs_reflink.c     |  24 +--
 3 files changed, 253 insertions(+), 156 deletions(-)

-- 
2.24.4

