Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ECC47919B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbhLQQk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:40:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35892 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239189AbhLQQk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:40:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D77E3B82954
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 16:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576C8C36AE8;
        Fri, 17 Dec 2021 16:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639759255;
        bh=DuCWxOF8xwW5JZgXvfMFgH5c57m8bIZ61WHsH+oFdhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4LmZfE+x3MA1XLc2RxCqg/y7GwxPw4nBjYm+1Ehsxu8hCKpDJ2iAFY9w2MaAth0b
         14mCH2sbG4y7uw66bK1WYXvCj+Qx9ZVJAh34lCqbNRPr47FTCx+Zk43S+pIAST4bMj
         /gvGCkJgYUXykwwYo9xpkKu//x7AXo0kDHDNWjrgqU8ICRuKcSLlifAmRX8Jd8Uqa6
         xPNetUG9TJguYQPxrU+z+o3/xxi502uZXfjRJxtA8qFzBQYVbLg3zkRN7vAGkVPZQP
         619/i4CENsIawt2jvx3vsc7oI1/iZyFuIIslUQR19R1qowlMjrKxW34/GmlKTUn63l
         FW1Chc6eP+UcA==
Date:   Fri, 17 Dec 2021 08:40:53 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Zhiguo Niu <niuzhiguo84@gmail.com>
Cc:     Chao Yu <chao@kernel.org>,
        =?utf-8?B?5aSP6Z2ZIChKaW5nIFhpYSk=?= <Jing.Xia@unisoc.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH Vx 1/1] f2fs: Avoid deadlock between writeback
 and checkpoint
Message-ID: <Yby9lU7aAC1kWYlL@google.com>
References: <YZU0TFBH6k2Q6fJZ@google.com>
 <e28d4963-d816-b568-dec8-60a79a9fe88d@kernel.org>
 <e25053e9-f97e-6a2f-3bac-acfcd689fdcb@kernel.org>
 <Yaf1J/GtTrJekmtn@google.com>
 <f0fa20e0-7c03-c454-d5a7-62457663412b@kernel.org>
 <YakNSfMyzGAe2y42@google.com>
 <80bc28c5-f050-05a9-e9a8-ff42781a191a@kernel.org>
 <YbjqI0qvbxbW9aDz@google.com>
 <YbvKGpea/C/UnT6J@google.com>
 <CAHJ8P3KwWXAgRQRD5N6Ut6uEQX8ap368Pm9HOz3gapVS4ymHmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHJ8P3KwWXAgRQRD5N6Ut6uEQX8ap368Pm9HOz3gapVS4ymHmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17, Zhiguo Niu wrote:
> Hi Jaegeuk,
> 
> As f2fs_write_node_pages codes:
> 
> 2060  <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/fs/f2fs/node.c#2060>
> 	blk_start_plug
> <http://172.29.60.15:8083/s?defs=blk_start_plug&project=sprdroidr_trunk>(&plug
> <http://172.29.60.15:8083/s?defs=plug&project=sprdroidr_trunk>);2061
> <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/fs/f2fs/node.c#2061>
> 	f2fs_sync_node_pages
> <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/fs/f2fs/node.c#f2fs_sync_node_pages>(sbi
> <http://172.29.60.15:8083/s?defs=sbi&project=sprdroidr_trunk>, wbc
> <http://172.29.60.15:8083/s?defs=wbc&project=sprdroidr_trunk>, *true*,
> FS_NODE_IO <http://172.29.60.15:8083/s?defs=FS_NODE_IO&project=sprdroidr_trunk>);2062
>  <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/fs/f2fs/node.c#2062>
> 	blk_finish_plug
> <http://172.29.60.15:8083/s?defs=blk_finish_plug&project=sprdroidr_trunk>(&plug
> <http://172.29.60.15:8083/s?defs=plug&project=sprdroidr_trunk>);
> 
> 
> if writeback to sync node pages, blk_statr_plug in line 2060 just do nothing

Isn't it a different task's plug, yes?

> 
> 
> 
> 3449  <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/block/blk-core.c#3449>
> *void* blk_start_plug
> <http://172.29.60.15:8083/s?refs=blk_start_plug&project=sprdroidr_trunk>(*struct*
> blk_plug <http://172.29.60.15:8083/s?defs=blk_plug&project=sprdroidr_trunk>
> *plug <http://172.29.60.15:8083/s?refs=plug&project=sprdroidr_trunk>)3450
>  <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/block/blk-core.c#3450>
> {3451  <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/block/blk-core.c#3451>
> 	*struct* task_struct
> <http://172.29.60.15:8083/s?defs=task_struct&project=sprdroidr_trunk>
> *tsk <http://172.29.60.15:8083/s?refs=tsk&project=sprdroidr_trunk> =
> current <http://172.29.60.15:8083/s?defs=current&project=sprdroidr_trunk>;3452
>  <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/block/blk-core.c#3452>
> 3453  <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/block/blk-core.c#3453>
> 	/*3454  <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/block/blk-core.c#3454>
> 	 * If this is a nested plug, don't actually assign it.3455
> <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/block/blk-core.c#3455>
> 	 */3456  <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/block/blk-core.c#3456>
> 	*if* (tsk <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/block/blk-core.c#tsk>->plug
> <http://172.29.60.15:8083/s?defs=plug&project=sprdroidr_trunk>)3457
> <http://172.29.60.15:8083/xref/sprdroidr_trunk/bsp/kernel/kernel4.14/block/blk-core.c#3457>
> 		*return*;
> 
> so the NodeA IO is pulged in writeback and stuck.
> 
> 
> thanks
> 
> Jaegeuk Kim <jaegeuk@kernel.org> 于2021年12月17日周五 07:22写道：
> 
> > On 12/14, Jaegeuk Kim wrote:
> > > On 12/03, Chao Yu wrote:
> > > > On 2021/12/3 2:15, Jaegeuk Kim wrote:
> > > > > On 12/02, Chao Yu wrote:
> > > > > > On 2021/12/2 6:20, Jaegeuk Kim wrote:
> > > > > > > On 11/20, Chao Yu wrote:
> > > > > > > > On 2021/11/18 14:46, Chao Yu wrote:
> > > > > > > > > On 2021/11/18 0:56, Jaegeuk Kim wrote:
> > > > > > > > > > On 11/09, niuzhiguo84@gmail.com wrote:
> > > > > > > > > > > From: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > > > > > > > > >
> > > > > > > > > > > There could be a scenario as following:
> > > > > > > > > > > The inodeA and inodeB are in b_io queue of writeback
> > > > > > > > > > > inodeA : f2fs's node inode
> > > > > > > > > > > inodeB : a dir inode with only one dirty pages, and the
> > node page
> > > > > > > > > > > of inodeB cached into inodeA
> > > > > > > > > > >
> > > > > > > > > > > writeback:
> > > > > > > > > > >
> > > > > > > > > > > wb_workfn
> > > > > > > > > > > wb_writeback
> > > > > > > > > > > blk_start_plug
> > > > > > > > > > >             loop {
> > > > > > > > > > >             queue_io
> > > > > > > > > > >             progress=__writeback_inodes_wb
> > > > > > > > > > >                     __writeback_single_inode
> > > > > > > > > > >                             do_writepages
> > > > > > > > > > >                                     f2fs_write_data_pages
> > > > > > > > > > >                                     wbc->pages_skipped
> > +=get_dirty_pages
> > > > > > > > > > >                             inode->i_state &= ~dirty
> > > > > > > > > > >                     wrote++
> > > > > > > > > > >                     requeue_inode
> > > > > > > > > > >             }
> > > > > > > > > > > blk_finish_plug
> > > > > > > > > > >
> > > > > > > > > > > checkpoint:
> > > > > > > > > > >
> > > > > > > > > > > f2fs_write_checkpoint
> > > > > > > > > > > f2fs_sync_dirty_inodes
> > > > > > > > > > > filemap_fdatawrite
> > > > > > > > > > > do_writepages
> > > > > > > > > > > f2fs_write_data_pages
> > > > > > > > > > >             f2fs_write_single_data_page
> > > > > > > > > > >                     f2fs_do_write_data_page
> > > > > > > > > > >                             set_page_writeback
> > > > > > > > > > >                             f2fs_outplace_write_data
> > > > > > > > > > >
> >  f2fs_update_data_blkaddr
> > > > > > > > > > >
> >  f2fs_wait_on_page_writeback
> > > > > > > > > > >                     inode_dec_dirty_pages
> > > > > > > > > > >
> > > > > > > > > > > 1. Writeback thread flush inodeA, and push it's bio
> > request in task's plug;
> > > > > > > > > > > 2. Checkpoint thread writes inodeB's dirty page, and
> > then wait its node
> > > > > > > > > > >         page writeback cached into inodeA which is in
> > writeback task's plug
> > > > > > > > > > > 3. Writeback thread flush inodeB and skip writing the
> > dirty page as
> > > > > > > > > > >         wb_sync_req[DATA] > 0.
> > > > > > > > > > > 4. As none of the inodeB's page is marked as
> > PAGECACHE_TAG_DIRTY, writeback
> > > > > > > > > > >         thread clear inodeB's dirty state.
> > > > > > > > > > > 5. Then inodeB is moved from b_io to b_dirty because of
> > pages_skipped > 0
> > > > > > > > > > >         as checkpoint thread is stuck before dec
> > dirty_pages.
> > > > > > > > > > >
> > > > > > > > > > > This patch collect correct pages_skipped according to
> > the tag state in
> > > > > > > > > > > page tree of inode
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > > > > > > > > > Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> > > > > > > > > > > ---
> > > > > > > > > > >      fs/f2fs/data.c | 4 +++-
> > > > > > > > > > >      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > > > > > > > > index f4fd6c246c9a..e98628e3868c 100644
> > > > > > > > > > > --- a/fs/f2fs/data.c
> > > > > > > > > > > +++ b/fs/f2fs/data.c
> > > > > > > > > > > @@ -3237,7 +3237,9 @@ static int
> > __f2fs_write_data_pages(struct address_space *mapping,
> > > > > > > > > > >       return ret;
> > > > > > > > > > >      skip_write:
> > > > > > > > > > > -     wbc->pages_skipped += get_dirty_pages(inode);
> > > > > > > > > > > +     wbc->pages_skipped +=
> > > > > > > > > > > +             mapping_tagged(inode->i_mapping,
> > PAGECACHE_TAG_DIRTY) ?
> > > > > > > > > >
> > > > > > > > > > Is there any race condition to get 0, if there's any dirty
> > page? IOWs, it
> > > > > > > > >
> > > > > > > > > Quoted from Jing Xia's explanation:
> > > > > > > > >
> > > > > > > > > [T:writeback]                             [T:checkpoint]
> > > > > > > >
> > > > > > > > My bad, [1] should be here:
> > > > > > > >
> > > > > > > > bio contains NodeA was plugged in writeback threads
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > >                                   - do_writepages  -- sync
> > write inodeB, inc wb_sync_req[DATA]
> > > > > > > > >                                    - f2fs_write_data_pages
> > > > > > > > >                                     -
> > f2fs_write_single_data_page -- write last dirty page
> > > > > > > > >                                      -
> > f2fs_do_write_data_page
> > > > > > > > >                                       - set_page_writeback
> > -- clear page dirty flag and
> > > > > > > > >                                       PAGECACHE_TAG_DIRTY
> > tag in radix tree
> > > > > > > > >                                       -
> > f2fs_outplace_write_data
> > > > > > > > >                                        -
> > f2fs_update_data_blkaddr
> > > > > > > > >                                         -
> > f2fs_wait_on_page_writeback -- wait NodeA to writeback here
> > > > > > > > >                                      - inode_dec_dirty_pages
> > > > > > > >
> > > > > > > > > bio contains NodeA was plugged in writeback threads
> > > > > > > >
> > > > > > > > [1]
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > > - writeback_sb_inodes
> > > > > > > > >      - writeback_single_inode
> > > > > > > > >       - do_writepages
> > > > > > > > >        - f2fs_write_data_pages -- skip writepages due to
> > wb_sync_req[DATA]
> > > > > > > > >         - wbc->pages_skipped += get_dirty_pages() --
> > PAGECACHE_TAG_DIRTY is not set but get_dirty_pages() returns one
> > > > > > > > >      - requeue_inode -- requeue inode to wb->b_dirty queue
> > due to non-zero.pages_skipped
> > > > > > >
> > > > > > > So, my question was why this is the problem?
> > > > > >
> > > > > > kworker will loop writebacking this requeued inode.
> > > > >
> > > > > Does it make a problem?
> > > >
> > > > The problem here is kworker will loop for ever.
> > >
> > > Could you point out where it goes in the loop?
> >
> > How can we have NodeA IO being stuck in the plug forever?
> > I think f2fs_write_node_pages() should have flushed it before.
> >
> > >
> > > >
> > > > Thanks,
> > > >
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > > seems the current condition is just requeuing the inode as
> > dirty, but next
> > > > > > > > > > flushing time will remove it from dirty list. Is this
> > giving too much overheads?
> > > > > > > > >
> > > > > > > > > I prefer to let writeback thread call blk_flush_plug() after
> > skipping
> > > > > > > > > writepages() due to wb_sync_req[DATA/NODE] check condition,
> > thoughts?
> > > > > > > > >
> > > > > > > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > > > > > > index 9f754aaef558..b6e1ed73f8f5 100644
> > > > > > > > > --- a/fs/f2fs/data.c
> > > > > > > > > +++ b/fs/f2fs/data.c
> > > > > > > > > @@ -3087,6 +3087,8 @@ static int
> > f2fs_write_cache_pages(struct address_space *mapping,
> > > > > > > > >                           /* give a priority to WB_SYNC
> > threads */
> > > > > > > > >                           if
> > (atomic_read(&sbi->wb_sync_req[DATA]) &&
> > > > > > > > >                                           wbc->sync_mode ==
> > WB_SYNC_NONE) {
> > > > > > > > > +                         if (current->plug)
> > > > > > > > > +
> >  blk_flush_plug(current->plug, false);
> > > > > > > > >                                   done = 1;
> > > > > > > > >                                   break;
> > > > > > > > >                           }
> > > > > > > > > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > > > > > > > > index 556fcd8457f3..dd9a817d8dab 100644
> > > > > > > > > --- a/fs/f2fs/node.c
> > > > > > > > > +++ b/fs/f2fs/node.c
> > > > > > > > > @@ -1946,6 +1946,8 @@ int f2fs_sync_node_pages(struct
> > f2fs_sb_info *sbi,
> > > > > > > > >                           if
> > (atomic_read(&sbi->wb_sync_req[NODE]) &&
> > > > > > > > >                                           wbc->sync_mode ==
> > WB_SYNC_NONE) {
> > > > > > > > >                                   done = 1;
> > > > > > > > > +                         if (current->plug)
> > > > > > > > > +
> >  blk_flush_plug(current->plug, false);
> > > > > > > > >                                   break;
> > > > > > > > >                           }
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > +             get_dirty_pages(inode) : 0;
> > > > > > > > > > >       trace_f2fs_writepages(mapping->host, wbc, DATA);
> > > > > > > > > > >       return 0;
> > > > > > > > > > >      }
> > > > > > > > > > > --
> > > > > > > > > > > 2.28.0
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > _______________________________________________
> > > > > > > > > Linux-f2fs-devel mailing list
> > > > > > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > > > > >
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > > > > > > >
> > >
> > >
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >
