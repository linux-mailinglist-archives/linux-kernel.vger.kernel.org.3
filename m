Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C0E569533
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiGFWVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiGFWVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:21:06 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8875619003;
        Wed,  6 Jul 2022 15:21:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id BA20310C7E67;
        Thu,  7 Jul 2022 08:21:01 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o9DOF-00FOOw-VZ; Thu, 07 Jul 2022 08:21:00 +1000
Date:   Thu, 7 Jul 2022 08:20:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     djwong@kernel.org, dchinner@redhat.com, chandan.babu@oracle.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: fix potential memory leak in xfs_bmap_add_attrfork()
Message-ID: <20220706222059.GL227878@dread.disaster.area>
References: <20220706082237.2255887-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706082237.2255887-1-niejianglei2021@163.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62c60ace
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=Byx-y9mGAAAA:8 a=7-415B0cAAAA:8
        a=xmMFYpAlcJMcLWuR8zQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 04:22:37PM +0800, Jianglei Nie wrote:
> xfs_bmap_add_attrfork() allocates a memory chunk for ip->i_afp with
> xfs_ifork_alloc(). When some error occurs, the function goto trans_cancel;
> without releasing the ip->i_afp, which will lead to a memory leak.

Where does it leak? Do you ahve a KASAN report?

> We should release the ip->i_afp with kmem_cache_free() and set "ip->i_afp
> = NULL" if ip->i_afp is not NULL pointer.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 6833110d1bd4..0c99726c0968 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -1088,6 +1088,10 @@ xfs_bmap_add_attrfork(
>  trans_cancel:
>  	xfs_trans_cancel(tp);
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	if (ip->i_afp) {
> +		kmem_cache_free(xfs_ifork_cache, ip->i_afp);
> +		ip->a_afp = NULL;
                    ^^^^^

Please compile and test your changes before proposing them for
inclusion.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
