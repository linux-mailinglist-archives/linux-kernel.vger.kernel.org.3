Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D404BB191
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 06:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiBRFk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 00:40:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBRFku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:40:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4307B1AA269;
        Thu, 17 Feb 2022 21:40:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 676E261E35;
        Fri, 18 Feb 2022 05:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78F8C340E9;
        Fri, 18 Feb 2022 05:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645162832;
        bh=npU0q+aWjpOCJAPfRSm2roJbCcVRMII0xlJ8ZhmEpic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XlRBqokrCEx/I/jWGklZxZvqAltCdn4Fu8i/CcZKsBPH9ZOaU85wSwVW47kqwbZrg
         kvGtan5YIpn8ZlNiKuWMx2cAqOrMoLTM72aDOejVhc730kYtbUnvIM5uUHzhWcVzu5
         vZ4givqMBu2X7K8e1MAvdSvfC0mQ4PCi5Ps/lgYCc3b+BL1yMj91zGinoSqOxL3pw2
         WJ2E9gkcYukNE1y+J/Wp7j5DidkOF6xWK992igx5EthbuSpPjQLg6PxELsrB2t933N
         ZEZEyklpf/RA6izO5FLDggBxdWbiYdJz/+CCm3YLvlQXf1EybhHxJxzG04Fr+y+Rzn
         qpGatU0++6fDQ==
Date:   Thu, 17 Feb 2022 21:40:32 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfs: add missing cmap->br_state = XFS_EXT_NORM update
Message-ID: <20220218054032.GO8313@magnolia>
References: <20220217095542.68085-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217095542.68085-1-hsiangkao@linux.alibaba.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 05:55:42PM +0800, Gao Xiang wrote:
> COW extents are already converted into written real extents after
> xfs_reflink_convert_cow_locked(), therefore cmap->br_state should
> reflect it.
> 
> Otherwise, there is another necessary unwritten convertion
> triggered in xfs_dio_write_end_io() for direct I/O cases.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

I /think/ this looks ok.  Does it test ok too?  AFAICT nothing in the
iomap/writeback machinery cares the incorrect state because we always
set IOMAP_F_SHARED (which triggers COW) so I think this is simply a fix
for directio, like you said?

--D

> ---
> From the logic itself and runtime tracing, IMO, it seems true.
> Kindly correct me here if my understanding is wrong.
> 
>  fs/xfs/xfs_reflink.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 75bd2e03cd5b..5f0a364739a5 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -424,7 +424,10 @@ xfs_reflink_allocate_cow(
>  	if (!convert_now || cmap->br_state == XFS_EXT_NORM)
>  		return 0;
>  	trace_xfs_reflink_convert_cow(ip, cmap);
> -	return xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
> +	error = xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
> +	if (!error)
> +		cmap->br_state = XFS_EXT_NORM;
> +	return error;
>  
>  out_trans_cancel:
>  	xfs_trans_cancel(tp);
> -- 
> 2.24.4
> 
