Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E9532044
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 03:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiEXB2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 21:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiEXB2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 21:28:13 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03D276FA11;
        Mon, 23 May 2022 18:28:09 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5958410E6ADA;
        Tue, 24 May 2022 11:28:07 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntJLC-00FeDQ-6a; Tue, 24 May 2022 11:28:06 +1000
Date:   Tue, 24 May 2022 11:28:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     liuzhengyuan <liuzhengyuan@kylinos.cn>,
        =?utf-8?B?6IOh5rW3?= <huhai@kylinos.cn>, zhangshida@kylinos.cn,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG report] security_inode_alloc return -ENOMEM let xfs shutdown
Message-ID: <20220524012806.GY1098723@dread.disaster.area>
References: <5a3a9cdc-33c3-4196-b8f7-bfec485eae5b@linux.dev>
 <20220523232009.GW1098723@dread.disaster.area>
 <a05dfccc-33ff-4857-b68d-ddd64cae11d0@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a05dfccc-33ff-4857-b68d-ddd64cae11d0@linux.dev>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=628c34a9
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=ODNmBjawUs2uzPs7Eu4A:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 08:52:30AM +0800, Jackie Liu wrote:
> 在 2022/5/24 上午7:20, Dave Chinner 写道:
> > On Mon, May 23, 2022 at 04:51:50PM +0800, Jackie Liu wrote:
> > Yup, that's a shutdown with a dirty transaction because memory
> > allocation failed in the middle of a transaction. XFS can not
> > tolerate memory allocation failure within the scope of a dirty
> > transactions and, in practice, this almost never happens. Indeed,
> > I've never seen this allocation from security_inode_alloc():
> > 
> > int lsm_inode_alloc(struct inode *inode)
> > {
> >          if (!lsm_inode_cache) {
> >                  inode->i_security = NULL;
> >                  return 0;
> >          }
> > 
> > > > > > >    inode->i_security = kmem_cache_zalloc(lsm_inode_cache, GFP_NOFS);
> >          if (inode->i_security == NULL)
> >                  return -ENOMEM;
> >          return 0;
> > }
> > 
> > fail in all my OOM testing. Hence, to me, this is a theoretical
> > failure as I've never, ever seen this allocation fail in production
> > or test systems, even when driving them hard into OOM with excessive
> > inode allocation and triggering the OOM killer repeatedly until the
> > system kills init....
> > 
> > Hence I don't think there's anything we need to change here right
> > now. If users start hitting this, then we're going to have add new
> > memalloc_nofail_save/restore() functionality to XFS transaction
> > contexts. But until then, I don't think we need to worry about
> > syzkaller intentionally hitting this shutdown.
> 
> Thanks Dave.
> 
>   In the actual test, the x86 or arm64 device test will trigger this error
> more easily when FAILSLAB is turned on. After our internal discussion, we
> can try again through such a patch. Anyway, thank you for your reply.

What kernel is the patch against? It doesn't match a current TOT
kernel...

> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index ceee27b70384..360304409c0c 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -435,6 +435,7 @@ xfs_iget_cache_hit(
>                                 wake_up_bit(&ip->i_flags, __XFS_INEW_BIT);
>                         ASSERT(ip->i_flags & XFS_IRECLAIMABLE);
>                         trace_xfs_iget_reclaim_fail(ip);
> +                       error = -EAGAIN;
>                         goto out_error;
>                 }

Ok, I can see what you are suggesting here - it might work if we get
it right. :)

We don't actually want (or need) an unconditional retry. This will
turn persistent memory allocation failure into a CPU burning
livelock rather than -ENOMEM being returned. It might work for a
one-off memory failure, but it's not viable for long term failure as
tends to happen when the system goes deep into OOM territory.

It also ignores the fact that we can return ENOMEM without
consequences from this path if we are not in a transaction - any
pathwalk lookup can have ENOMEM safely returned to it, and that will
propagate the error to userspace. Same with bulkstat lookups, etc.
So we still want them to fail with ENOMEM, not retry indefinitely.

Likely what we want to do is add conditions to the xfs_iget() lookup
tail to detect ENOMEM when tp != NULL. IN that case, we can then run
memalloc_retry_wait(GFP_NOFS) before retrying the lookup. That's in
line with what we do in other places that cannot tolerate allocation
failure (e.g. kmem_alloc(), xfs_buf_alloc_pages()) so it may make
sense to do the same thing here....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
