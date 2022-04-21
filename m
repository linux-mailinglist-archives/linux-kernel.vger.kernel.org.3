Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5CC50A3DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389970AbiDUPXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiDUPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:23:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D350E008
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11E1EB82611
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9BEC385A5;
        Thu, 21 Apr 2022 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650554424;
        bh=VnXaPMca60V4eTXoLoQFkxHQy+dhTrGV+ZwQQzPOiT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XysGKFpao6X07LvtILT7MllAwXBLd5xWnzh76hpxd1VwqyvhtzCoodLy0v6Ac127h
         CNG7wi/4+At50gD1HtRlgEKwlZVvvyAXl5JbM2FzGOtE/p8fsmuOwv+WwQds7FHl7d
         nbGZ58O9qxYubWxvW6cLLvyQpLHdfqQcMq6lTKdtp+yoz8gQj6CgiQmUdyB65dUWUS
         I7CWrbkDYJS3sDuO7UrTB7EEU/ulZFSlsSTwBwEFZheezrfvkkojfIvVBSqIuH68On
         IknbDp33ZTlzhX332SMo3qYYx0LBjkYdYLIeNukQl9EEvdHztgOp/Qomfbjm8hLZ/C
         sJpwcvCjWf8Kg==
Date:   Thu, 21 Apr 2022 08:20:22 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: use flush command instead of FUA for zoned device
Message-ID: <YmF2Nqu8Rtc4cx52@google.com>
References: <20220419215703.1271395-1-jaegeuk@kernel.org>
 <42e10758-e50a-7aaa-dfa9-dcf6338ebaff@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e10758-e50a-7aaa-dfa9-dcf6338ebaff@opensource.wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21, Damien Le Moal wrote:
> On 4/20/22 06:57, Jaegeuk Kim wrote:
> > The block layer for zoned disk can reorder the FUA'ed IOs. Let's use flush
> > command to keep the write order.
> 
> Stricktly speaking, for a request that has data, the problem is triggered
> by REQ_PREFLUSH since in this case the request does not go through the
> scheduler and is processed through the blk-flush machinery. REQ_FUA on its
> own should not matter if the device supports it. If the device does not
> support FUA, then the same problem can happen due to POSTFLUSH (again no
> scheduler).

I think the problem is a piggy-backed data along with flush or fua whatever,
but this made me use a separate flush command.

> 
> Bypassing the scheduler leads to the write not write-locking the zone,
> which leads to reordering... Completely overlooked that case when the zone
> write locking was implemented.
> 
> Ideally, the FS should not have to care about this. blk-flush machinery
> should be a little more intelligent and process the write phase of the
> request using the scheduler. Need to look into that.

Please. I'm okay to revert this, once the block layer supports.

> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/file.c | 4 +++-
> >  fs/f2fs/node.c | 2 +-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index f08e6208e183..2aef0632f35b 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -372,7 +372,9 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
> >  	f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
> >  	clear_inode_flag(inode, FI_APPEND_WRITE);
> >  flush_out:
> > -	if (!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER)
> > +	if ((!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER) ||
> > +			(atomic && !test_opt(sbi, NOBARRIER) &&
> > +					f2fs_sb_has_blkzoned(sbi)))
> 
> Aligning the conditions and not breaking the second line would make this a
> lot easier to read...

Sure.

> 
> >  		ret = f2fs_issue_flush(sbi, inode->i_ino);
> >  	if (!ret) {
> >  		f2fs_remove_ino_entry(sbi, ino, UPDATE_INO);
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index c280f482c741..7224a980056f 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1633,7 +1633,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
> >  		goto redirty_out;
> >  	}
> >  
> > -	if (atomic && !test_opt(sbi, NOBARRIER))
> > +	if (atomic && !test_opt(sbi, NOBARRIER) && !f2fs_sb_has_blkzoned(sbi))
> >  		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
> 
> Is this really OK to do ? flush + write as different operations may not
> lead to the same result as a preflush+fua write.
> 
> Until the block layer is fixed to properly handle this, a simpler fix for
> f2fs would be to force enable the NOBARRIER option for zoned drives ? That
> would avoid these changes no ?

No, it will hurt the stability of FS metadata consistency.

> 
> Also, with all the testing we do on SMR disks and f2fs (smaller, older SMR
> disks due to the 16TB limit), we never have triggered this problem. How
> did you trigger it ?

This happens in Android only, since atomic_write for sqlite is taking this path.

> 
> >  
> >  	/* should add to global list before clearing PAGECACHE status */
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
