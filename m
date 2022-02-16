Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8778B4B7E58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344067AbiBPDJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:09:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344059AbiBPDJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:09:16 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF4F9A99A;
        Tue, 15 Feb 2022 19:09:04 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V4b8YHT_1644980935;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V4b8YHT_1644980935)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 11:09:02 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     xfs <linux-xfs@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 0/3] xfs: some end COW remapping optimization
Date:   Wed, 16 Feb 2022 11:08:51 +0800
Message-Id: <20220216030854.30180-1-hsiangkao@linux.alibaba.com>
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

xfstests seems survived. Comments are much welcomed and
thanks for your time!

Thanks,
Gao Xiang

Changes since v1:
 - fix missing tmp_logflags initialization;
 - drop unnecessary realtime inode check pointed out by Darrick.

Gao Xiang (3):
  xfs: get rid of LEFT, RIGHT, PREV in
    xfs_bmap_add_extent_unwritten_real()
  xfs: introduce xfs_bmap_update_extent_real()
  xfs: introduce xfs_bremapi_from_cowfork()

 fs/xfs/libxfs/xfs_bmap.c | 377 +++++++++++++++++++++++++--------------
 fs/xfs/libxfs/xfs_bmap.h |   7 +-
 fs/xfs/xfs_reflink.c     |  24 +--
 3 files changed, 252 insertions(+), 156 deletions(-)

-- 
2.24.4

