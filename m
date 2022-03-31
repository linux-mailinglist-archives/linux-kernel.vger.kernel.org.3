Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A301A4ED340
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiCaFff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiCaFfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:35:31 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4100A1099;
        Wed, 30 Mar 2022 22:33:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9FC8D10E543E;
        Thu, 31 Mar 2022 16:33:41 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nZnRE-00ByRg-8Y; Thu, 31 Mar 2022 16:33:40 +1100
Date:   Thu, 31 Mar 2022 16:33:40 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     wang.yi59@zte.com.cn
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, cheng.lin130@zte.com.cn
Subject: Re: [PATCH] xfs: getattr ignore blocks beyond eof
Message-ID: <20220331053340.GE1544202@dread.disaster.area>
References: <20220331003826.GL27690@magnolia>
 <202203311128598207170@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203311128598207170@zte.com.cn>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62453d36
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=1RTuLK3dAAAA:8 a=7-415B0cAAAA:8
        a=iCIATYgx3w10mCWEzSQA:9 a=CjuIK1q_8ugA:10 a=kRpfLKi8w9umh8uBmg1i:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:28:59AM +0800, wang.yi59@zte.com.cn wrote:
> >> From: Cheng Lin <cheng.lin130@zte.com.cn>
> >>
> >> Blocks beyond EOF, which preallocated, will be reclaimed at some time.
> >> These blocks can be ignored when getattr.
> >>
> >> This patch will optimize query accuracy for getattr blocks.
> >Huh? This subtracts posteof blocks from the query results, which makes
> >the results *less accurate*. Those blocks are mapped to the file, hence
> >they are supposed to be counted in nblocks.
> >--D
> Yes, those blocks are mapped to the file. And the results including them are
> absolutely real for xfs, at the moment of query.
> 
> But, those blocks are like the credit without consumption, are unstalbe, and
> will be reclaimed at some time. This may cause trouble for the application.

What application is having trouble with this?

> e.g. in a case,
> 1. Firstly, write 100k data to file;
> 2. query the result;
> 3. close the file;
> 4. query the result.
> 
> fd stat wrt[96 @ 393216]: blks[896], size[397312].
> fd stat wrt[97 @ 397312]: blks[896], size[401408].
> fd stat wrt[98 @ 401408]: blks[896], size[405504].
> fd stat wrt[99 @ 405504]: blks[896], size[409600].
> lstat open: blks[896], size[409600].
> lstat close: blks[800], size[409600].
> 
> Here two problems:
> 1. why the result different before between after file close?
> 2. why the result not change after writing data, or a big change?

Because that's the way speculative preallocation works.

> The above problems can be explained by fs preallocation.
> If the impact of preallocation are closed in fs, not visible to
> the outside, the result is stable and real for the application.

You're a decade late to the party. Complaining about how visible
artifacts of speculative preallocation are going to cause the sky
to fall was something that happened when we fix implemented the
mechanism.

Once people realised how much better their filesystems resisted
fragmentation and hence aged more gracefully because the temporary
overallocation helped ensure large, contiguous extents got allocated
more often than not, those complaints went away.

Have you even considered what reflink/dedupe does to user visible
block accounting? That's right - it's a complete lie.

We do not, and have not ever tried to, hide allocation or block
usage artifacts from userspace because any application that depends
on specific block allocation patterns or accounting from the
filesystem is broken by design.

Every filesystem accounts blocks differently, and more often than
not the block count exposed to userspace also includes metadata
blocks (extent maps, xattr blocks, etc) and it might multiple count
other blocks (e.g. shared extents). Hence so you can't actually
use it for anything useful in userspace except reporting how many
blocks this file *might* use.

If your application is dependent on block counts exactly matching
the file data space for waht ever reason, then what speculative
preallocation does is the least of your problems.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
