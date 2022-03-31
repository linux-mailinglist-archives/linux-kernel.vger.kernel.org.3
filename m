Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922AA4EE348
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241864AbiCaVXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbiCaVXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:23:43 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1955323D779;
        Thu, 31 Mar 2022 14:21:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B677B10E7293;
        Fri,  1 Apr 2022 08:21:53 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1na2Eq-00CEYy-AF; Fri, 01 Apr 2022 08:21:52 +1100
Date:   Fri, 1 Apr 2022 08:21:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     wang.yi59@zte.com.cn
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, cheng.lin130@zte.com.cn
Subject: Re: [PATCH] xfs: getattr ignore blocks beyond eof
Message-ID: <20220331212152.GG1544202@dread.disaster.area>
References: <20220331053340.GE1544202@dread.disaster.area>
 <202203311632074775168@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203311632074775168@zte.com.cn>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62461b72
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=1RTuLK3dAAAA:8 a=7-415B0cAAAA:8
        a=CJxDh8eq4twOAiMNBa0A:9 a=CjuIK1q_8ugA:10 a=kRpfLKi8w9umh8uBmg1i:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 04:32:07PM +0800, wang.yi59@zte.com.cn wrote:
> > We do not, and have not ever tried to, hide allocation or block
> > usage artifacts from userspace because any application that depends
> > on specific block allocation patterns or accounting from the
> > filesystem is broken by design.
> >
> > Every filesystem accounts blocks differently, and more often than
> > not the block count exposed to userspace also includes metadata
> > blocks (extent maps, xattr blocks, etc) and it might multiple count
> > other blocks (e.g. shared extents). Hence so you can't actually
> > use it for anything useful in userspace except reporting how many
> > blocks this file *might* use.
> >
> > If your application is dependent on block counts exactly matching
> > the file data space for waht ever reason, then what speculative
> > preallocation does is the least of your problems.
> >
> 
> Thanks for your explaination.
> 
> Unfortunately, the app I'm using evaluates diskusage by querying
> the changes of the backend filesystem (XFS) file before and after
> the operation.

What application is this?

What is it trying to use this information for?

I'm trying to understand why someone thought this was a good idea,
and without actually being able to look up the code and see what it
is using the information for, I can't really say much more than
"this seems broken by design".

> Without giving up the benefits of preallocation, the
> app's statistics will become obsolete and no chance to correct it
> at a small cost, because of the silence reclaim of posteof blocks.
> That is the app's problem.

Yes it is.

> Posteof blocks will be reclaimed sooner or later, it seems reasonable

No, that is not guaranteed. If you the extend the file again, those
post eof blocks will no longer be post-eof blocks and instead
contain user data. Also, fallocate() can allocate post-eof blocks,
and in that case they can be retained permanently because the user
asked them to be placed beyond EOF.

So the assertion that post-eof blocks always get removed sooner or
later is not actually true.

> to ignore them directly during query. This is my humble opinion in
> this patch. At the query moment, it's not real, but it will become so
> eventually. It's a speculative result for query.

No, it's the _correct_ result for the current state of the file
being queried. The statx() man page says:

st_blocks
     This field indicates the number of blocks allocated to the
     file, in 512-byte units.  (This may be smaller than st_size/512
     when the file has holes.)

The POSIX specification just defines it as "Number of blocks
allocated for this object."

Neither say anything about how the filesystem should or shouldn't
account those blocks, that it must be stable, that it must reflect
the amount of data written to the file, etc. ALl they say is that
it is the amount of blocks allocated for that file.

As it is, hiding space usage like you propose is likely to cause
more problems than it solaves, because not du will not report all
the disk space used by a file and hence we'll end up with other
users reporting that the disk space reported by du does not match up
with the space the filesytem is using. Which, of course is also
expected, because reflink/dedupe result in du multiple counting
shared blocks.

IOWs, userspace tracking and aggregation of filesystem space usage
just doesn't work, and so papering over behaviours that expose the
fact it doesn't and can't work are in no-ones best interests.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
