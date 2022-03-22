Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967C54E3702
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiCVC7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiCVC7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:59:19 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD1C33EEDB;
        Mon, 21 Mar 2022 19:57:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0V7tXCnQ_1647917867;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7tXCnQ_1647917867)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Mar 2022 10:57:49 +0800
Date:   Tue, 22 Mar 2022 10:57:47 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] xfs: some end COW remapping optimization
Message-ID: <Yjk7K2yTqpJZLsx5@B-P7TQMD6M-0146.local>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220216030854.30180-1-hsiangkao@linux.alibaba.com>
 <20220321222125.GN8241@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220321222125.GN8241@magnolia>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darrick,

On Mon, Mar 21, 2022 at 03:21:25PM -0700, Darrick J. Wong wrote:
> On Wed, Feb 16, 2022 at 11:08:51AM +0800, Gao Xiang wrote:
> > Hi folks,
> > 
> > Currently, xfs_reflink_end_cow_extent() will unconditionally unmap an
> > extent from DATA fork and then remap an extent from COW fork. It seems
> > somewhat ineffective since for many cases we could update real bmbt
> > records directly by sightly enhancing old
> > xfs_bmap_add_extent_unwritten_real() implementation, thus reduce some
> > measurable extra metadata overhead.
> 
> Does it work with rmap enabled?

Yeah, I've tested with rmap enabled. But for now, I have to prioritize
`erofs over fscache' stuff since it's really needed for cloud vendors and
cloud-native ecosystem to achieve high-dense and proformance image
solution for runC and Kata containers. And this patchset still left
some work to do (since our tester found some cases could cause
performance degration but I haven't checked/confirm it yet.)

> Reading between the lines, I'm guessing the performance boost might
> come from avoiding a transaction roll and (possibly) reducing the need
> to log bmbt updates?  Particularly in the worst case where we split the
> bmbt only to rejoin the blocks immediately after.
> 
> Recently, Dave and Allison have been pondering making an addition to the
> deferred log item code so that we could ->finish_item the first defer op
> in the same transaction that logs the caller's deferred operations.
> Might that get you most of the speed advantage that you're seeking?

Ok, I will recheck later after my container stuff are almost done..

> 
> > It's important to us since, actually, we're planing to use a modified
> > alway-cow like atomic write approach internally for database
> > applications, therefore it'd be nice to do some optimization over
> > simple end COW approach. Also I think it's still generic and can
> > benefit other reflink use cases as well.
> 
> Hmm, that sounds /awfully/ similar to what sqlite does with f2fs' atomic
> write ioctls.
> 
> Alternately, would this[1] feature that's been sitting around in
> djwong-dev since late 2019 help?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=atomic-file-updates
> 

The problem is that, for example, mysql directly uses direct I/O to
write data, and we don't want to touch applications (since there are
still old e.g. mysql versions in production.) so a transparent COW
atomic write would be much helpful for products (yeah, I admit it's a
bit tricky, but until applications choose to use swapext, we still
need some way that we don't need to touch database apps).

Thanks for the reply and the time!

Thanks,
Gao Xiang 

> --D
> 
> > 
> > I did some tests with ramdisk in order to measure metadata overhead:
> > 
> > echo 1 > /sys/fs/xfs/debug/always_cow
> > mkfs.xfs -f -mreflink=1 /dev/ram0
> > mount /dev/ram0 testdir
> > fio -filename=testdir/1 -size=1G -ioengine=psync -bs=4k -rw=randwrite -overwrite=1 -direct=1 -end_fsync=1 -name=job1
> > 
> > Test results as below:
> > Vanilla:
> > (1)   iops        : min= 7986, max=16434, avg=12505.76, stdev=2400.05, samples=41
> > (2)   iops        : min= 7636, max=16376, avg=12474.19, stdev=2258.18, samples=42
> > (3)   iops        : min= 8346, max=16439, avg=12227.95, stdev=2432.12, samples=42
> > (4)   iops        : min= 8580, max=16496, avg=12779.41, stdev=2297.42, samples=41
> > (5)   iops        : min= 8286, max=16556, avg=12500.76, stdev=2123.90, samples=41
> > 
> > Patched:
> > (1)   iops        : min= 7086, max=17132, avg=12931.20, stdev=2729.10, samples=40
> > (2)   iops        : min= 7704, max=17508, avg=13204.62, stdev=2507.70, samples=39
> > (3)   iops        : min= 8736, max=17634, avg=13253.08, stdev=2545.18, samples=39
> > (4)   iops        : min= 7188, max=17550, avg=12928.40, stdev=2633.64, samples=40
> > (5)   iops        : min= 8268, max=17446, avg=12837.55, stdev=2717.98, samples=40
> > 
> > xfstests seems survived. Comments are much welcomed and
> > thanks for your time!
> > 
> > Thanks,
> > Gao Xiang
> > 
> > Changes since v1:
> >  - fix missing tmp_logflags initialization;
> >  - drop unnecessary realtime inode check pointed out by Darrick.
> > 
> > Gao Xiang (3):
> >   xfs: get rid of LEFT, RIGHT, PREV in
> >     xfs_bmap_add_extent_unwritten_real()
> >   xfs: introduce xfs_bmap_update_extent_real()
> >   xfs: introduce xfs_bremapi_from_cowfork()
> > 
> >  fs/xfs/libxfs/xfs_bmap.c | 377 +++++++++++++++++++++++++--------------
> >  fs/xfs/libxfs/xfs_bmap.h |   7 +-
> >  fs/xfs/xfs_reflink.c     |  24 +--
> >  3 files changed, 252 insertions(+), 156 deletions(-)
> > 
> > -- 
> > 2.24.4
> > 
