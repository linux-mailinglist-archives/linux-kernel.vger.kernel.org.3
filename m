Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723D5531F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiEWXUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiEWXUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:20:12 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AC6A39144;
        Mon, 23 May 2022 16:20:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 83835536962;
        Tue, 24 May 2022 09:20:10 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntHLN-00FbuB-57; Tue, 24 May 2022 09:20:09 +1000
Date:   Tue, 24 May 2022 09:20:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG report] security_inode_alloc return -ENOMEM let xfs shutdown
Message-ID: <20220523232009.GW1098723@dread.disaster.area>
References: <5a3a9cdc-33c3-4196-b8f7-bfec485eae5b@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a3a9cdc-33c3-4196-b8f7-bfec485eae5b@linux.dev>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=628c16aa
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=opuActzyEHSy3JkQVnQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 04:51:50PM +0800, Jackie Liu wrote:
> Hello Maintainer and developer.
> 
>    Syzkaller report an filesystem shutdown for me, It's very easy to
> trigger and also exists on the latest kernel version 5.18-rc7.

Shutdown is a perfectly reasonable way to handle a failure that we
can't recover cleanly from.

> dmesg shows:
> 
> [  285.725893] FAULT_INJECTION: forcing a failure.
>                name failslab, interval 1, probability 0, space 0, times 0
> [  285.729625] CPU: 7 PID: 18034 Comm: syz-executor Not tainted 4.19.90-43+
> #7
> [  285.731420] Source Version: b62cabdd86181d386998660ebf34ca653addd6c9
> [  285.733051] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
> 02/06/2015
> [  285.734796] Call trace:
> [  285.735614]  dump_backtrace+0x0/0x3e0
> [  285.736609]  show_stack+0x2c/0x38
> [  285.737525]  dump_stack+0x164/0x1fc
> [  285.738489]  should_fail+0x5c0/0x688
> [  285.739555]  __should_failslab+0x118/0x180
> [  285.740725]  should_failslab+0x2c/0x78
> [  285.741808]  kmem_cache_alloc_trace+0x270/0x410
> [  285.743120]  security_inode_alloc+0x100/0x1a8
> [  285.744356]  inode_init_always+0x48c/0xa28
> [  285.745524]  xfs_iget_cache_hit+0x9c0/0x2f28
> [  285.746739]  xfs_iget+0x33c/0x9e0
> [  285.747708]  xfs_ialloc+0x218/0x11c0
> [  285.748752]  xfs_dir_ialloc+0xe8/0x480
> [  285.749832]  xfs_create+0x5bc/0x1220
> [  285.750871]  xfs_generic_create+0x42c/0x568
> [  285.752053]  xfs_vn_mknod+0x48/0x58
> [  285.753067]  xfs_vn_create+0x40/0x50
> [  285.754106]  lookup_open+0x960/0x1580
> [  285.755176]  do_last+0xd44/0x2180
> [  285.756149]  path_openat+0x1a0/0x6d0
> [  285.757187]  do_filp_open+0x14c/0x208
> [  285.758245]  do_sys_open+0x340/0x470
> [  285.759289]  __arm64_sys_openat+0x98/0xd8
> [  285.760438]  el0_svc_common+0x230/0x3f0
> [  285.761541]  el0_svc_handler+0x144/0x1a8
> [  285.762674]  el0_svc+0x8/0x1b0
> [  285.763737] security_inode_alloc:796
> [  285.764733] inode_init_always:202
> [  285.765669] xfs_create:1213
> [  285.766485] XFS (dm-0): Internal error xfs_trans_cancel at line 1046 of
> file fs/xfs/xfs_trans.c.  Caller xfs_create+0x700/0x1220
> [  285.769503] CPU: 7 PID: 18034 Comm: syz-executor Not tainted 4.19.90-43+
> #7
> [  285.771275] Source Version: b62cabdd86181d386998660ebf34ca653addd6c9
> [  285.772892] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
> 02/06/2015
> [  285.774625] Call trace:
> [  285.775335]  dump_backtrace+0x0/0x3e0
> [  285.776324]  show_stack+0x2c/0x38
> [  285.777236]  dump_stack+0x164/0x1fc
> [  285.778188]  xfs_error_report+0xdc/0xe0
> [  285.779292]  xfs_trans_cancel+0x490/0x878
> [  285.780439]  xfs_create+0x700/0x1220
> [  285.781477]  xfs_generic_create+0x42c/0x568
> [  285.782673]  xfs_vn_mknod+0x48/0x58
> [  285.783687]  xfs_vn_create+0x40/0x50
> [  285.784724]  lookup_open+0x960/0x1580
> [  285.785782]  do_last+0xd44/0x2180
> [  285.786760]  path_openat+0x1a0/0x6d0
> [  285.787791]  do_filp_open+0x14c/0x208
> [  285.788844]  do_sys_open+0x340/0x470
> [  285.789880]  __arm64_sys_openat+0x98/0xd8
> [  285.791039]  el0_svc_common+0x230/0x3f0
> [  285.792139]  el0_svc_handler+0x144/0x1a8
> [  285.793260]  el0_svc+0x8/0x1b0
> [  285.794283] XFS (dm-0): xfs_do_force_shutdown(0x8) called from line 1047
> of file fs/xfs/xfs_trans.c.  Return address = 00000000a4a366b9
> [  285.816187] XFS (dm-0): Corruption of in-memory data detected. Shutting
> down filesystem
> [  285.818476] XFS (dm-0): Please umount the filesystem and rectify the
> problem(s)

Yup, that's a shutdown with a dirty transaction because memory
allocation failed in the middle of a transaction. XFS can not
tolerate memory allocation failure within the scope of a dirty
transactions and, in practice, this almost never happens. Indeed,
I've never seen this allocation from security_inode_alloc():

int lsm_inode_alloc(struct inode *inode)
{
        if (!lsm_inode_cache) {
                inode->i_security = NULL;
                return 0;
        }

>>>>>   inode->i_security = kmem_cache_zalloc(lsm_inode_cache, GFP_NOFS);
        if (inode->i_security == NULL)
                return -ENOMEM;
        return 0;
}

fail in all my OOM testing. Hence, to me, this is a theoretical
failure as I've never, ever seen this allocation fail in production
or test systems, even when driving them hard into OOM with excessive
inode allocation and triggering the OOM killer repeatedly until the
system kills init....

Hence I don't think there's anything we need to change here right
now. If users start hitting this, then we're going to have add new
memalloc_nofail_save/restore() functionality to XFS transaction
contexts. But until then, I don't think we need to worry about
syzkaller intentionally hitting this shutdown.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
