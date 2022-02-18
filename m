Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0784BB1AC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 06:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiBRF4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 00:56:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiBRFz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:55:59 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F410E187E25;
        Thu, 17 Feb 2022 21:55:41 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0V4npCvx_1645163738;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V4npCvx_1645163738)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Feb 2022 13:55:39 +0800
Date:   Fri, 18 Feb 2022 13:55:37 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfs: add missing cmap->br_state = XFS_EXT_NORM update
Message-ID: <Yg802fTm0n31FC+T@B-P7TQMD6M-0146.local>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220217095542.68085-1-hsiangkao@linux.alibaba.com>
 <20220218054032.GO8313@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218054032.GO8313@magnolia>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darrick,

On Thu, Feb 17, 2022 at 09:40:32PM -0800, Darrick J. Wong wrote:
> On Thu, Feb 17, 2022 at 05:55:42PM +0800, Gao Xiang wrote:
> > COW extents are already converted into written real extents after
> > xfs_reflink_convert_cow_locked(), therefore cmap->br_state should
> > reflect it.
> > 
> > Otherwise, there is another necessary unwritten convertion
> > triggered in xfs_dio_write_end_io() for direct I/O cases.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> I /think/ this looks ok.  Does it test ok too?  AFAICT nothing in the
> iomap/writeback machinery cares the incorrect state because we always
> set IOMAP_F_SHARED (which triggers COW) so I think this is simply a fix
> for directio, like you said?

Yeah, I think so, from the code logic buffered i/o seems no impacted...
And the unnecessary unwritten convertion under direct i/o takes
noticeable extra overhead in our workloads...

I checked my last night xfstests, it seems it stops unexpectedly (maybe
due to some environmental problem). I will rerun tests today and
feedback later.

Thanks,
Gao Xiang

> 
> --D
> 
> > ---
> > From the logic itself and runtime tracing, IMO, it seems true.
> > Kindly correct me here if my understanding is wrong.
> > 
> >  fs/xfs/xfs_reflink.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> > index 75bd2e03cd5b..5f0a364739a5 100644
> > --- a/fs/xfs/xfs_reflink.c
> > +++ b/fs/xfs/xfs_reflink.c
> > @@ -424,7 +424,10 @@ xfs_reflink_allocate_cow(
> >  	if (!convert_now || cmap->br_state == XFS_EXT_NORM)
> >  		return 0;
> >  	trace_xfs_reflink_convert_cow(ip, cmap);
> > -	return xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
> > +	error = xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
> > +	if (!error)
> > +		cmap->br_state = XFS_EXT_NORM;
> > +	return error;
> >  
> >  out_trans_cancel:
> >  	xfs_trans_cancel(tp);
> > -- 
> > 2.24.4
> > 
