Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313CB478078
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbhLPXWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:22:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43560 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbhLPXWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:22:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88E3C61FA8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 23:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41F0C36AE7;
        Thu, 16 Dec 2021 23:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639696923;
        bh=0sq4J29DTaWN6NaDou/0Z1Z236WmcTA3/R0Mr0+u04w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pT3/oHrJ2etfYhP9Bz8y1f4JSiwwg8Oqge6nVaEnfZcRt71wM1G2H+SmyYoXV+aNV
         L6NFBXbP1iX9/xdWymhXv0x0NO8KXJMoeVCm+7Qzt3Jk5WS6oQk8vaJtNWIrNvZeNo
         ILYIhAv7l+oAwr0TtbSXoZBuVNPmDxMFq5Rs2diwTTJ7spMGVuvi0BiREmVUnci0mq
         5D7KL5HY9URvykf/4xB2MR2smDWhh4laQh0i7PsaSB1z+E4MhbafKPvEQisY7CRZ1b
         l+UBVG/6B1X9i39k4+9619g7631h2UyO8lxbSj2Wdpt+Wru1jbvuw+em1qMYo7sgQA
         8jy0QSp0sES5Q==
Date:   Thu, 16 Dec 2021 15:22:02 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Jing.Xia@unisoc.com, niuzhiguo84@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH Vx 1/1] f2fs: Avoid deadlock between writeback
 and checkpoint
Message-ID: <YbvKGpea/C/UnT6J@google.com>
References: <1636438608-27597-1-git-send-email-niuzhiguo84@gmail.com>
 <YZU0TFBH6k2Q6fJZ@google.com>
 <e28d4963-d816-b568-dec8-60a79a9fe88d@kernel.org>
 <e25053e9-f97e-6a2f-3bac-acfcd689fdcb@kernel.org>
 <Yaf1J/GtTrJekmtn@google.com>
 <f0fa20e0-7c03-c454-d5a7-62457663412b@kernel.org>
 <YakNSfMyzGAe2y42@google.com>
 <80bc28c5-f050-05a9-e9a8-ff42781a191a@kernel.org>
 <YbjqI0qvbxbW9aDz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbjqI0qvbxbW9aDz@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14, Jaegeuk Kim wrote:
> On 12/03, Chao Yu wrote:
> > On 2021/12/3 2:15, Jaegeuk Kim wrote:
> > > On 12/02, Chao Yu wrote:
> > > > On 2021/12/2 6:20, Jaegeuk Kim wrote:
> > > > > On 11/20, Chao Yu wrote:
> > > > > > On 2021/11/18 14:46, Chao Yu wrote:
> > > > > > > On 2021/11/18 0:56, Jaegeuk Kim wrote:
> > > > > > > > On 11/09, niuzhiguo84@gmail.com wrote:
> > > > > > > > > From: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > > > > > > > 
> > > > > > > > > There could be a scenario as following:
> > > > > > > > > The inodeA and inodeB are in b_io queue of writeback
> > > > > > > > > inodeA : f2fs's node inode
> > > > > > > > > inodeB : a dir inode with only one dirty pages, and the node page
> > > > > > > > > of inodeB cached into inodeA
> > > > > > > > > 
> > > > > > > > > writeback:
> > > > > > > > > 
> > > > > > > > > wb_workfn
> > > > > > > > > wb_writeback
> > > > > > > > > blk_start_plug
> > > > > > > > >             loop {
> > > > > > > > >             queue_io
> > > > > > > > >             progress=__writeback_inodes_wb
> > > > > > > > >                     __writeback_single_inode
> > > > > > > > >                             do_writepages
> > > > > > > > >                                     f2fs_write_data_pages
> > > > > > > > >                                     wbc->pages_skipped +=get_dirty_pages
> > > > > > > > >                             inode->i_state &= ~dirty
> > > > > > > > >                     wrote++
> > > > > > > > >                     requeue_inode
> > > > > > > > >             }
> > > > > > > > > blk_finish_plug
> > > > > > > > > 
> > > > > > > > > checkpoint:
> > > > > > > > > 
> > > > > > > > > f2fs_write_checkpoint
> > > > > > > > > f2fs_sync_dirty_inodes
> > > > > > > > > filemap_fdatawrite
> > > > > > > > > do_writepages
> > > > > > > > > f2fs_write_data_pages
> > > > > > > > >             f2fs_write_single_data_page
> > > > > > > > >                     f2fs_do_write_data_page
> > > > > > > > >                             set_page_writeback
> > > > > > > > >                             f2fs_outplace_write_data
> > > > > > > > >                                     f2fs_update_data_blkaddr
> > > > > > > > >                                             f2fs_wait_on_page_writeback
> > > > > > > > >                     inode_dec_dirty_pages
> > > > > > > > > 
> > > > > > > > > 1. Writeback thread flush inodeA, and push it's bio request in task's plug;
> > > > > > > > > 2. Checkpoint thread writes inodeB's dirty page, and then wait its node
> > > > > > > > >         page writeback cached into inodeA which is in writeback task's plug
> > > > > > > > > 3. Writeback thread flush inodeB and skip writing the dirty page as
> > > > > > > > >         wb_sync_req[DATA] > 0.
> > > > > > > > > 4. As none of the inodeB's page is marked as PAGECACHE_TAG_DIRTY, writeback
> > > > > > > > >         thread clear inodeB's dirty state.
> > > > > > > > > 5. Then inodeB is moved from b_io to b_dirty because of pages_skipped > 0
> > > > > > > > >         as checkpoint thread is stuck before dec dirty_pages.
> > > > > > > > > 
> > > > > > > > > This patch collect correct pages_skipped according to the tag state in
> > > > > > > > > page tree of inode
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > > > > > > > Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> > > > > > > > > ---
> > > > > > > > >      fs/f2fs/data.c | 4 +++-
> > > > > > > > >      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > > > > > > index f4fd6c246c9a..e98628e3868c 100644
> > > > > > > > > --- a/fs/f2fs/data.c
> > > > > > > > > +++ b/fs/f2fs/data.c
> > > > > > > > > @@ -3237,7 +3237,9 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
> > > > > > > > >      	return ret;
> > > > > > > > >      skip_write:
> > > > > > > > > -	wbc->pages_skipped += get_dirty_pages(inode);
> > > > > > > > > +	wbc->pages_skipped +=
> > > > > > > > > +		mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ?
> > > > > > > > 
> > > > > > > > Is there any race condition to get 0, if there's any dirty page? IOWs, it
> > > > > > > 
> > > > > > > Quoted from Jing Xia's explanation:
> > > > > > > 
> > > > > > > [T:writeback]				[T:checkpoint]
> > > > > > 
> > > > > > My bad, [1] should be here:
> > > > > > 
> > > > > > bio contains NodeA was plugged in writeback threads
> > > > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > > 					- do_writepages  -- sync write inodeB, inc wb_sync_req[DATA]
> > > > > > > 					 - f2fs_write_data_pages
> > > > > > > 					  - f2fs_write_single_data_page -- write last dirty page
> > > > > > > 					   - f2fs_do_write_data_page
> > > > > > > 					    - set_page_writeback  -- clear page dirty flag and
> > > > > > > 					    PAGECACHE_TAG_DIRTY tag in radix tree
> > > > > > > 					    - f2fs_outplace_write_data
> > > > > > > 					     - f2fs_update_data_blkaddr
> > > > > > > 					      - f2fs_wait_on_page_writeback -- wait NodeA to writeback here
> > > > > > > 					   - inode_dec_dirty_pages
> > > > > > 
> > > > > > > bio contains NodeA was plugged in writeback threads
> > > > > > 
> > > > > > [1]
> > > > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > > - writeback_sb_inodes
> > > > > > >      - writeback_single_inode
> > > > > > >       - do_writepages
> > > > > > >        - f2fs_write_data_pages -- skip writepages due to wb_sync_req[DATA]
> > > > > > >         - wbc->pages_skipped += get_dirty_pages() -- PAGECACHE_TAG_DIRTY is not set but get_dirty_pages() returns one
> > > > > > >      - requeue_inode -- requeue inode to wb->b_dirty queue due to non-zero.pages_skipped
> > > > > 
> > > > > So, my question was why this is the problem?
> > > > 
> > > > kworker will loop writebacking this requeued inode.
> > > 
> > > Does it make a problem?
> > 
> > The problem here is kworker will loop for ever.
> 
> Could you point out where it goes in the loop?

How can we have NodeA IO being stuck in the plug forever?
I think f2fs_write_node_pages() should have flushed it before.

> 
> > 
> > Thanks,
> > 
> > > 
> > > > 
> > > > Thanks,
> > > > 
> > > > > 
> > > > > > > 
> > > > > > > > seems the current condition is just requeuing the inode as dirty, but next
> > > > > > > > flushing time will remove it from dirty list. Is this giving too much overheads?
> > > > > > > 
> > > > > > > I prefer to let writeback thread call blk_flush_plug() after skipping
> > > > > > > writepages() due to wb_sync_req[DATA/NODE] check condition, thoughts?
> > > > > > > 
> > > > > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > > > > index 9f754aaef558..b6e1ed73f8f5 100644
> > > > > > > --- a/fs/f2fs/data.c
> > > > > > > +++ b/fs/f2fs/data.c
> > > > > > > @@ -3087,6 +3087,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
> > > > > > >      			/* give a priority to WB_SYNC threads */
> > > > > > >      			if (atomic_read(&sbi->wb_sync_req[DATA]) &&
> > > > > > >      					wbc->sync_mode == WB_SYNC_NONE) {
> > > > > > > +				if (current->plug)
> > > > > > > +					blk_flush_plug(current->plug, false);
> > > > > > >      				done = 1;
> > > > > > >      				break;
> > > > > > >      			}
> > > > > > > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > > > > > > index 556fcd8457f3..dd9a817d8dab 100644
> > > > > > > --- a/fs/f2fs/node.c
> > > > > > > +++ b/fs/f2fs/node.c
> > > > > > > @@ -1946,6 +1946,8 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
> > > > > > >      			if (atomic_read(&sbi->wb_sync_req[NODE]) &&
> > > > > > >      					wbc->sync_mode == WB_SYNC_NONE) {
> > > > > > >      				done = 1;
> > > > > > > +				if (current->plug)
> > > > > > > +					blk_flush_plug(current->plug, false);
> > > > > > >      				break;
> > > > > > >      			}
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > 
> > > > > > > > 
> > > > > > > > > +		get_dirty_pages(inode) : 0;
> > > > > > > > >      	trace_f2fs_writepages(mapping->host, wbc, DATA);
> > > > > > > > >      	return 0;
> > > > > > > > >      }
> > > > > > > > > -- 
> > > > > > > > > 2.28.0
> > > > > > > 
> > > > > > > 
> > > > > > > _______________________________________________
> > > > > > > Linux-f2fs-devel mailing list
> > > > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > > > > > 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
