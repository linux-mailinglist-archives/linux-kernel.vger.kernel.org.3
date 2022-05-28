Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649985369E1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 03:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351704AbiE1Bml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 21:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiE1Bmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 21:42:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CD913C1DE;
        Fri, 27 May 2022 18:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 172B2B82649;
        Sat, 28 May 2022 01:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD6BC34113;
        Sat, 28 May 2022 01:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653702156;
        bh=j+FxAMoUxjrnMrkR7+D1UfkLzawirXG78XCfbEzPawQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R0J7/2/Z1LOYV6ZvC1PmKypkWwchOrYxwuMKAaqcXJCLnOBI88CcuguJD/eVPIiD2
         IsG0nubaNWnNBM8znoo03xQnRefWQPH9rizLT2ZwJdACppyXUh7yWz/5eLaZxwIWl2
         h+v2nxcdpsZoXSTlMZ//vPxAFjloY8TS3atKPXPvMRZfNrtEbZPq0O5NN9lqDtR/mk
         dvzcW2qG5BE8/0LnkGXadkRLYjyZ4FIoeMgRP9u0Uz+wf3xJzt+2zQGV5JvClIkEYu
         1uvQaMaphfvDY5ijvLX149ZhOgdk68QXAS3j4+vz7lWkVsRGywmr7bQgwTh0QPBn3E
         x/DziNugDCEPQ==
Date:   Fri, 27 May 2022 18:42:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] f2fs: add sysfs entry to avoid FUA
Message-ID: <YpF+DIuXQFhzflag@magnolia>
References: <20220527205955.3251982-1-jaegeuk@kernel.org>
 <YpFDw3mQjN1LBd2j@gmail.com>
 <YpF1gPrQY3UFsgwC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpF1gPrQY3UFsgwC@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 06:06:08PM -0700, Jaegeuk Kim wrote:
> On 05/27, Eric Biggers wrote:
> > [+Cc linux-block for FUA, and linux-xfs for iomap]
> > 
> > On Fri, May 27, 2022 at 01:59:55PM -0700, Jaegeuk Kim wrote:
> > > Some UFS storage gives slower performance on FUA than write+cache_flush.
> > > Let's give a way to manage it.
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > 
> > Should the driver even be saying that it has FUA support in this case?  If the
> > driver didn't claim FUA support, that would also solve this problem.
> 
> I think there's still some benefit to use FUA such as small chunk writes
> for checkpoint.
> 
> > 
> > > ---
> > >  Documentation/ABI/testing/sysfs-fs-f2fs | 7 +++++++
> > >  fs/f2fs/data.c                          | 2 ++
> > >  fs/f2fs/f2fs.h                          | 1 +
> > >  fs/f2fs/sysfs.c                         | 2 ++
> > >  4 files changed, 12 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> > > index 9b583dd0298b..cd96b09d7182 100644
> > > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > > @@ -434,6 +434,7 @@ Date:		April 2020
> > >  Contact:	"Daeho Jeong" <daehojeong@google.com>
> > >  Description:	Give a way to change iostat_period time. 3secs by default.
> > >  		The new iostat trace gives stats gap given the period.
> > > +
> > >  What:		/sys/fs/f2fs/<disk>/max_io_bytes
> > >  Date:		December 2020
> > >  Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> > > @@ -442,6 +443,12 @@ Description:	This gives a control to limit the bio size in f2fs.
> > >  		whereas, if it has a certain bytes value, f2fs won't submit a
> > >  		bio larger than that size.
> > >  
> > > +What:		/sys/fs/f2fs/<disk>/no_fua_dio
> > > +Date:		May 2022
> > > +Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> > > +Description:	This gives a signal to iomap, which should not use FUA for
> > > +		direct IOs. Default: 0.
> > 
> > iomap is an implementation detail, so it shouldn't be mentioned in UAPI
> > documentation.  UAPI documentation should describe user-visible behavior only.
> 
> Ok.
> 
> > 
> > > +
> > >  What:		/sys/fs/f2fs/<disk>/stat/sb_status
> > >  Date:		December 2020
> > >  Contact:	"Chao Yu" <yuchao0@huawei.com>
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index f5f2b7233982..23486486eab2 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -4153,6 +4153,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > >  	if ((inode->i_state & I_DIRTY_DATASYNC) ||
> > >  	    offset + length > i_size_read(inode))
> > >  		iomap->flags |= IOMAP_F_DIRTY;
> > > +	if (F2FS_I_SB(inode)->no_fua_dio)
> > > +		iomap->flags |= IOMAP_F_DIRTY;
> > 
> > This is overloading the IOMAP_F_DIRTY flag to mean something other than dirty.
> > Perhaps this flag needs to be renamed, or a new flag should be added?
> 
> I'm not sure it's acceptable to add another flag for f2fs only.

I think Al and willy have been throwing around patches to tell
iomap_dio_rw or someone that the caller will handle cache flushes and
that it shouldn't initiate them on its own; would that help here?

--D

> > 
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index e10838879538..c2400ea0080b 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -1671,6 +1671,7 @@ struct f2fs_sb_info {
> > >  	int dir_level;				/* directory level */
> > >  	int readdir_ra;				/* readahead inode in readdir */
> > >  	u64 max_io_bytes;			/* max io bytes to merge IOs */
> > > +	int no_fua_dio;				/* avoid FUA in DIO */
> > 
> > Make this a bool?
> 
> Done.
> 
> > 
> > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > index 4c50aedd5144..24d628ca92cc 100644
> > > --- a/fs/f2fs/sysfs.c
> > > +++ b/fs/f2fs/sysfs.c
> > > @@ -771,6 +771,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_period_ms, iostat_period_ms);
> > >  #endif
> > >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
> > >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_io_bytes, max_io_bytes);
> > > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, no_fua_dio, no_fua_dio);
> > >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_pin_file_thresh, gc_pin_file_threshold);
> > >  F2FS_RW_ATTR(F2FS_SBI, f2fs_super_block, extension_list, extension_list);
> > >  #ifdef CONFIG_F2FS_FAULT_INJECTION
> > > @@ -890,6 +891,7 @@ static struct attribute *f2fs_attrs[] = {
> > >  #endif
> > >  	ATTR_LIST(readdir_ra),
> > >  	ATTR_LIST(max_io_bytes),
> > > +	ATTR_LIST(no_fua_dio),
> > 
> > Where is it validated that only valid values (0 or 1) can be written to this
> > file?
> 
> Added.
> 
> > 
> > - Eric
