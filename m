Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E2F482672
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 04:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiAAD5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 22:57:20 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:36749 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231981AbiAAD5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 22:57:19 -0500
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6A7C18A80B1;
        Sat,  1 Jan 2022 14:57:17 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n3VW8-009v9G-La; Sat, 01 Jan 2022 14:57:16 +1100
Date:   Sat, 1 Jan 2022 14:57:16 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] net/tls: Remove redundant initialization of mp
Message-ID: <20220101035716.GF945095@dread.disaster.area>
References: <20211231122352.14275-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231122352.14275-1-jiapeng.chong@linux.alibaba.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61cfd11d
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=SRrdq9N9AAAA:8 a=7-415B0cAAAA:8
        a=cCNTWZp2dwuWsVUTxxUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 08:23:52PM +0800, Jiapeng Chong wrote:
> mp is being initialized to log->l_mp but this is never read
> as record is overwritten later on. Remove the redundant
> initialization.

The compiler is not smart enough to just elide the second "mp =
log->l_mp;" assignment?


> Cleans up the following clang-analyzer warning:
> 
> fs/xfs/xfs_log_recover.c:3543:20: warning: Value stored to 'mp' during
> its initialization is never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/xfs/xfs_log_recover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
> index 8ecb9a8567b7..9142efbdc670 100644
> --- a/fs/xfs/xfs_log_recover.c
> +++ b/fs/xfs/xfs_log_recover.c
> @@ -3540,7 +3540,7 @@ STATIC void
>  xlog_recover_check_summary(
>  	struct xlog		*log)
>  {
> -	struct xfs_mount	*mp = log->l_mp;
> +	struct xfs_mount	*mp;
>  	struct xfs_perag	*pag;
>  	struct xfs_buf		*agfbp;
>  	struct xfs_buf		*agibp;

You removed the wrong initialisation line. Leave this one here and
remove the standalone one.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
