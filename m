Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D844E3300
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiCUWrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiCUWrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:47:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FAE2AB89C;
        Mon, 21 Mar 2022 15:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 888C3B81AAA;
        Mon, 21 Mar 2022 22:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412CAC340E8;
        Mon, 21 Mar 2022 22:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647901286;
        bh=YdRuUQ7n1xMKIOQKXhmD50thxaX6B8sq7j5Ta8xBOgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjrrZhGi7hE60DXYpI8kfKjkj+BhXTfVQpSXi9BT1Apy9rZmUoILwCuqgWgjXu0yf
         JpgH6Z6s4/G6nT/DnXwgZ/ye3OJr1CCaWjJjutJGCsRzVrZPt3zg4WKTr3ZlGlzZpr
         1OQ3Udyb8DbZ+RPAKFG/RAhmqPtk31O9WLmwicpipRwY5r7RXeIed9dqsrIDHxlomJ
         s4cO7P3CBiQfItlhxWaNLlyXHwOgldO1SRlMnF44TORG4zwkn5i6PxWBGob4XqZ5T/
         /DPTr1cAGh3NUUjALHlSPYMO+C+5+nASO3V3YD5Ev0lSNOtwdt65XTaxUShbUweoF6
         TQkJfmnr1r0mQ==
Date:   Mon, 21 Mar 2022 15:21:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] xfs: some end COW remapping optimization
Message-ID: <20220321222125.GN8241@magnolia>
References: <20220216030854.30180-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216030854.30180-1-hsiangkao@linux.alibaba.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 11:08:51AM +0800, Gao Xiang wrote:
> Hi folks,
> 
> Currently, xfs_reflink_end_cow_extent() will unconditionally unmap an
> extent from DATA fork and then remap an extent from COW fork. It seems
> somewhat ineffective since for many cases we could update real bmbt
> records directly by sightly enhancing old
> xfs_bmap_add_extent_unwritten_real() implementation, thus reduce some
> measurable extra metadata overhead.

Does it work with rmap enabled?

Reading between the lines, I'm guessing the performance boost might
come from avoiding a transaction roll and (possibly) reducing the need
to log bmbt updates?  Particularly in the worst case where we split the
bmbt only to rejoin the blocks immediately after.

Recently, Dave and Allison have been pondering making an addition to the
deferred log item code so that we could ->finish_item the first defer op
in the same transaction that logs the caller's deferred operations.
Might that get you most of the speed advantage that you're seeking?

> It's important to us since, actually, we're planing to use a modified
> alway-cow like atomic write approach internally for database
> applications, therefore it'd be nice to do some optimization over
> simple end COW approach. Also I think it's still generic and can
> benefit other reflink use cases as well.

Hmm, that sounds /awfully/ similar to what sqlite does with f2fs' atomic
write ioctls.

Alternately, would this[1] feature that's been sitting around in
djwong-dev since late 2019 help?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=atomic-file-updates

--D

> 
> I did some tests with ramdisk in order to measure metadata overhead:
> 
> echo 1 > /sys/fs/xfs/debug/always_cow
> mkfs.xfs -f -mreflink=1 /dev/ram0
> mount /dev/ram0 testdir
> fio -filename=testdir/1 -size=1G -ioengine=psync -bs=4k -rw=randwrite -overwrite=1 -direct=1 -end_fsync=1 -name=job1
> 
> Test results as below:
> Vanilla:
> (1)   iops        : min= 7986, max=16434, avg=12505.76, stdev=2400.05, samples=41
> (2)   iops        : min= 7636, max=16376, avg=12474.19, stdev=2258.18, samples=42
> (3)   iops        : min= 8346, max=16439, avg=12227.95, stdev=2432.12, samples=42
> (4)   iops        : min= 8580, max=16496, avg=12779.41, stdev=2297.42, samples=41
> (5)   iops        : min= 8286, max=16556, avg=12500.76, stdev=2123.90, samples=41
> 
> Patched:
> (1)   iops        : min= 7086, max=17132, avg=12931.20, stdev=2729.10, samples=40
> (2)   iops        : min= 7704, max=17508, avg=13204.62, stdev=2507.70, samples=39
> (3)   iops        : min= 8736, max=17634, avg=13253.08, stdev=2545.18, samples=39
> (4)   iops        : min= 7188, max=17550, avg=12928.40, stdev=2633.64, samples=40
> (5)   iops        : min= 8268, max=17446, avg=12837.55, stdev=2717.98, samples=40
> 
> xfstests seems survived. Comments are much welcomed and
> thanks for your time!
> 
> Thanks,
> Gao Xiang
> 
> Changes since v1:
>  - fix missing tmp_logflags initialization;
>  - drop unnecessary realtime inode check pointed out by Darrick.
> 
> Gao Xiang (3):
>   xfs: get rid of LEFT, RIGHT, PREV in
>     xfs_bmap_add_extent_unwritten_real()
>   xfs: introduce xfs_bmap_update_extent_real()
>   xfs: introduce xfs_bremapi_from_cowfork()
> 
>  fs/xfs/libxfs/xfs_bmap.c | 377 +++++++++++++++++++++++++--------------
>  fs/xfs/libxfs/xfs_bmap.h |   7 +-
>  fs/xfs/xfs_reflink.c     |  24 +--
>  3 files changed, 252 insertions(+), 156 deletions(-)
> 
> -- 
> 2.24.4
> 
