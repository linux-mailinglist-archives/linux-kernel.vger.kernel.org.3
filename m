Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B269536ADE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 07:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355806AbiE1FMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 01:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiE1FMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 01:12:42 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E27CCB41CF;
        Fri, 27 May 2022 22:12:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EE07A10C8B4E;
        Sat, 28 May 2022 15:12:40 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nuokg-00HIOO-Pz; Sat, 28 May 2022 15:12:38 +1000
Date:   Sat, 28 May 2022 15:12:38 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] f2fs: add sysfs entry to avoid FUA
Message-ID: <20220528051238.GX1098723@dread.disaster.area>
References: <20220527205955.3251982-1-jaegeuk@kernel.org>
 <YpFDw3mQjN1LBd2j@gmail.com>
 <20220527235509.GW1098723@dread.disaster.area>
 <YpFsOLz/GScXvhkb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpFsOLz/GScXvhkb@google.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6291af49
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=8RavHqeXKao-3GyEar0A:9 a=CjuIK1q_8ugA:10 a=igBNqPyMv6gA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 05:26:32PM -0700, Jaegeuk Kim wrote:
> On 05/28, Dave Chinner wrote:
> > On Fri, May 27, 2022 at 09:33:55PM +0000, Eric Biggers wrote:
> > > [+Cc linux-block for FUA, and linux-xfs for iomap]
> > 
> > linux-fsdevel should really be used for iomap stuff...
> > 
> > > 
> > > On Fri, May 27, 2022 at 01:59:55PM -0700, Jaegeuk Kim wrote:
> > > > Some UFS storage gives slower performance on FUA than write+cache_flush.
> > > > Let's give a way to manage it.
> > > > 
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > 
> > > Should the driver even be saying that it has FUA support in this case?  If the
> > > driver didn't claim FUA support, that would also solve this problem.
> > 
> > Agreed, this is a hardware problem that need to addressed with a
> > driver quirk to stop it advertising FUA support. The high level
> > fs/iomap code should always issue FUA writes where possible and
> > the lower layers tell the block layer whether to issue the FUA as
> > a FUA or write+cache flush pair.
> 
> I was thinking to turn off FUA in driver side quickly tho, one concern
> was the bandwidth vs. latency. What if the device can support FUA having
> short latency while giving low bandwidth?

Seriously, how is a user supposed to know this sort of thing about
the hardware they are using? They don't, and to expect them to not
only know about the existing of a weird sysfs knob, let alone how it
applies to their hardware and their workload is totally
unreasonable.

If the hardware has non-deterministic FUA write performance, or
requires very careful switch over between cache flushes and FUA to
get the most out of the hardware, then that's not something we can
tune or optimise for - that's just broken hardware and the drive
should quirk the brokeness away so nobody has to care about it. Tell
the hardware manufacturer to fix their hardware, don't try to hack
around it in software and then expect the user to know how to tune
for that broken hardware.

> In that case, we still have
> a room to utilize FUA for small-sized  writes such as filesystem metadata
> writes, but avoid DIO w/ FUA for sequential write stream.

Strawman.

We don't use FUA for normal DIO writes - they only get used for
O_DSYNC writes, in which case we either use FUA if the device
supports it, or we do a normal write followed by a cache flush.
If there are metadata updates that the O_DSYNC needs to also flush,
we don't use FUA by let the fileystem issue a cache flush in the
most optimal possible after the write completes.

Either way, using O_DSYNC DIO writes for streaming, sequential data
is a really poor choice for an application to make. Normal DIO
writes followed by fdatasync() to flush the metadata and caches once
will be much faster and far more efficient than a metadata and cache
flush after every single data write, FUA or not.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
