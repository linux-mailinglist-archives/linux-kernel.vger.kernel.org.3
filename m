Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842DA500466
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbiDNCpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 22:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiDNCpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:45:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D433E15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 19:42:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C3C9B827EC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12E1C385A3;
        Thu, 14 Apr 2022 02:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649904168;
        bh=36DzzE0zFDY0+1eEpGlav//54lccCGWjd8+KNiyp/0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUJay3KuNMjYKs3umQ64L2QtcGkKJDk81kuC0XTjgOd+8MJB3EliCD1FpByvEInaF
         7ni4Ssghq79zqEwoUr1q2NKPrnG5jx1I6Fca1eR3vFKpUkFZcSKvPxecO7Ilb5uaC0
         3eHH8HNY+vv/fQ1yY+K2eKFn1Can0F1D4QmOkNAwkJmmB21FgQFBDoXo6DOmMwhenU
         pmcCd9paycCmONEWoKDpD8bBLksOPNagmfxclGyPsu9tKqXvuqRknYck3h0K//tAZn
         MC3noDTXIakBd25BKB1/R061hsZsJZe1OFU72nZIHoFV05i41+cre04/VbgVwHtndn
         JsaA1m2taWiaw==
Date:   Wed, 13 Apr 2022 19:42:47 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Wu Yan <wu-yan@tcl.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tang.ding@tcl.com
Subject: Re: [PATCH] f2fs: avoid deadlock in gc thread under low memory
Message-ID: <YleKJySnkWZ1eh/O@google.com>
References: <660530eb62e71fb6520d3596704162e5@sslemail.net>
 <YlcBxSA5qYN4z1ia@google.com>
 <39c4ded0-09c0-3e38-85cb-5535099b177d@tcl.com>
 <YleEXOHl1Vhlr3x3@google.com>
 <ba76460f-4e22-634a-d46f-78e1fd4ac10e@tcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba76460f-4e22-634a-d46f-78e1fd4ac10e@tcl.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14, Wu Yan wrote:
> On 4/14/22 10:18, Jaegeuk Kim wrote:
> > On 04/14, Wu Yan wrote:
> > > On 4/14/22 01:00, Jaegeuk Kim wrote:
> > > > On 04/13, Rokudo Yan wrote:
> > > > > There is a potential deadlock in gc thread may happen
> > > > > under low memory as below:
> > > > > 
> > > > > gc_thread_func
> > > > >    -f2fs_gc
> > > > >     -do_garbage_collect
> > > > >      -gc_data_segment
> > > > >       -move_data_block
> > > > >        -set_page_writeback(fio.encrypted_page);
> > > > >        -f2fs_submit_page_write
> > > > > as f2fs_submit_page_write try to do io merge when possible, so the
> > > > > encrypted_page is marked PG_writeback but may not submit to block
> > > > > layer immediately, if system enter low memory when gc thread try
> > > > > to move next data block, it may do direct reclaim and enter fs layer
> > > > > as below:
> > > > >      -move_data_block
> > > > >       -f2fs_grab_cache_page(index=?, for_write=false)
> > > > >        -grab_cache_page
> > > > >         -find_or_create_page
> > > > >          -pagecache_get_page
> > > > >           -__page_cache_alloc --  __GFP_FS is set
> > > > >            -alloc_pages_node
> > > > >             -__alloc_pages
> > > > >              -__alloc_pages_slowpath
> > > > >               -__alloc_pages_direct_reclaim
> > > > >                -__perform_reclaim
> > > > >                 -try_to_free_pages
> > > > >                  -do_try_to_free_pages
> > > > >                   -shrink_zones
> > > > >                    -mem_cgroup_soft_limit_reclaim
> > > > >                     -mem_cgroup_soft_reclaim
> > > > >                      -mem_cgroup_shrink_node
> > > > >                       -shrink_node_memcg
> > > > >                        -shrink_list
> > > > >                         -shrink_inactive_list
> > > > >                          -shrink_page_list
> > > > >                           -wait_on_page_writeback -- the page is marked
> > > > >                          writeback during previous move_data_block call
> > > > > 
> > > > > the gc thread wait for the encrypted_page writeback complete,
> > > > > but as gc thread held sbi->gc_lock, the writeback & sync thread
> > > > > may blocked waiting for sbi->gc_lock, so the bio contain the
> > > > > encrypted_page may nerver submit to block layer and complete the
> > > > > writeback, which cause deadlock. To avoid this deadlock condition,
> > > > > we mark the gc thread with PF_MEMALLOC_NOFS flag, then it will nerver
> > > > > enter fs layer when try to alloc cache page during move_data_block.
> > > > > 
> > > > > Signed-off-by: Rokudo Yan <wu-yan@tcl.com>
> > > > > ---
> > > > >    fs/f2fs/gc.c | 6 ++++++
> > > > >    1 file changed, 6 insertions(+)
> > > > > 
> > > > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > > > index e020804f7b07..cc71f77b98c8 100644
> > > > > --- a/fs/f2fs/gc.c
> > > > > +++ b/fs/f2fs/gc.c
> > > > > @@ -38,6 +38,12 @@ static int gc_thread_func(void *data)
> > > > >    	wait_ms = gc_th->min_sleep_time;
> > > > > +	/*
> > > > > +	 * Make sure that no allocations from gc thread will ever
> > > > > +	 * recurse to the fs layer to avoid deadlock as it will
> > > > > +	 * hold sbi->gc_lock during garbage collection
> > > > > +	 */
> > > > > +	memalloc_nofs_save();
> > > > 
> > > > I think this cannot cover all the f2fs_gc() call cases. Can we just avoid by:
> > > > 
> > > > --- a/fs/f2fs/gc.c
> > > > +++ b/fs/f2fs/gc.c
> > > > @@ -1233,7 +1233,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
> > > >                                   CURSEG_ALL_DATA_ATGC : CURSEG_COLD_DATA;
> > > > 
> > > >           /* do not read out */
> > > > -       page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
> > > > +       page = f2fs_grab_cache_page(inode->i_mapping, bidx, true);
> > > >           if (!page)
> > > >                   return -ENOMEM;
> > > > 
> > > > Thanks,
> > > > 
> > > > >    	set_freezable();
> > > > >    	do {
> > > > >    		bool sync_mode, foreground = false;
> > > > > -- 
> > > > > 2.25.1
> > > 
> > > Hi, Jaegeuk
> > > 
> > > I'm not sure if any other case may trigger the issue, but the stack traces I
> > > have caught so far are all the same as below:
> > > 
> > > f2fs_gc-253:12  D 226966.808196 572 302561 150976 0x1200840 0x0 572
> > > 237207473347056
> > > <ffffff889d88668c> __switch_to+0x134/0x150
> > > <ffffff889e764b6c> __schedule+0xd5c/0x1100
> > > <ffffff889e76554c> io_schedule+0x90/0xc0
> > > <ffffff889d9fb880> wait_on_page_bit+0x194/0x208
> > > <ffffff889da167b4> shrink_page_list+0x62c/0xe74
> > > <ffffff889da1d354> shrink_inactive_list+0x2c0/0x698
> > > <ffffff889da181f4> shrink_node_memcg+0x3dc/0x97c
> > > <ffffff889da17d44> mem_cgroup_shrink_node+0x144/0x218
> > > <ffffff889da6610c> mem_cgroup_soft_limit_reclaim+0x188/0x47c
> > > <ffffff889da17a40> do_try_to_free_pages+0x204/0x3a0
> > > <ffffff889da176c8> try_to_free_pages+0x35c/0x4d0
> > > <ffffff889da05d60> __alloc_pages_nodemask+0x7a4/0x10d0
> > > <ffffff889d9fc82c> pagecache_get_page+0x184/0x2ec
> > 
> > Is this deadlock trying to grab a lock, instead of waiting for writeback?
> > Could you share all the backtraces of the tasks?
> > 
> > For writeback above, looking at the code, f2fs_gc uses three mappings, meta,
> > node, and data, and meta/node inodes are masking GFP_NOFS in f2fs_iget(),
> > while data inode does not. So, the above f2fs_grab_cache_page() in
> > move_data_block() is actually calling w/o NOFS.
> > 
> > > <ffffff889dbf8860> do_garbage_collect+0xfe0/0x2828
> > > <ffffff889dbf7434> f2fs_gc+0x4a0/0x8ec
> > > <ffffff889dbf6bf4> gc_thread_func+0x240/0x4d4
> > > <ffffff889d8de9b0> kthread+0x17c/0x18c
> > > <ffffff889d88567c> ret_from_fork+0x10/0x18
> > > 
> > > Thanks
> > > yanwu
> 
> Hi, Jaegeuk
> 
> The gc thread is blocked on wait_on_page_writeback(encrypted page submit
> before) when it try grab data inode page, the parsed stack traces as below:
> 
> ppid=572 pid=572 D cpu=1 prio=120 wait=378s f2fs_gc-253:12
>    Native callstack:
> 	vmlinux  wait_on_page_bit_common(page=0xFFFFFFBF7D2CD700, state=2,
> lock=false) + 304                                <mm/filemap.c:1035>
> 	vmlinux  wait_on_page_bit(page=0xFFFFFFBF7D2CD700, bit_nr=15) + 400
> 
>                             <mm/filemap.c:1074>
> 	vmlinux  wait_on_page_writeback(page=0xFFFFFFBF7D2CD700) + 36
> 
>                             <include/linux/pagemap.h:557>
> 	vmlinux  shrink_page_list(page_list=0xFFFFFF8011E83418,
> pgdat=contig_page_data, sc=0xFFFFFF8011E835B8, ttu_flags=0,
> stat=0xFFFFFF8011E833F0, force_reclaim=false) + 1576  <mm/vmscan.c:1171>
> 	vmlinux  shrink_inactive_list(lruvec=0xFFFFFFE003C304C0,
> sc=0xFFFFFF8011E835B8, lru=LRU_INACTIVE_FILE) + 700
> <mm/vmscan.c:1966>
> 	vmlinux  shrink_list(lru=LRU_INACTIVE_FILE, lruvec=0xFFFFFF8011E834B8,
> sc=0xFFFFFF8011E835B8) + 128                            <mm/vmscan.c:2350>
> 	vmlinux  shrink_node_memcg(pgdat=contig_page_data,
> memcg=0xFFFFFFE003C1A300, sc=0xFFFFFF8011E835B8,
> lru_pages=0xFFFFFF8011E835B0) + 984 <mm/vmscan.c:2726>
> 	vmlinux  mem_cgroup_shrink_node(memcg=0xFFFFFFE003C1A300,
> gfp_mask=21102794, noswap=false, pgdat=contig_page_data,
> nr_scanned=0xFFFFFF8011E836A0) + 320                   <mm/vmscan.c:3416>
> 	vmlinux  mem_cgroup_soft_reclaim(root_memcg=0xFFFFFFE003C1A300,
> pgdat=contig_page_data) + 164
> <mm/memcontrol.c:1643>
> 	vmlinux  mem_cgroup_soft_limit_reclaim(pgdat=contig_page_data, order=0,
> gfp_mask=21102794, total_scanned=0xFFFFFF8011E83720) + 388
> <mm/memcontrol.c:2913>
> 	vmlinux  shrink_zones(zonelist=contig_page_data + 14784,
> sc=0xFFFFFF8011E83790) + 352
> <mm/vmscan.c:3094>
> 	vmlinux  do_try_to_free_pages(zonelist=contig_page_data + 14784,
> sc=0xFFFFFF8011E83790) + 512
> <mm/vmscan.c:3164>
> 	vmlinux  try_to_free_pages(zonelist=contig_page_data + 14784, order=0,
> gfp_mask=21102794, nodemask=0) + 856
> <mm/vmscan.c:3370>
> 	vmlinux  __perform_reclaim(gfp_mask=300431548, order=0,
> ac=0xFFFFFF8011E83900) + 60
> <mm/page_alloc.c:3831>
> 	vmlinux  __alloc_pages_direct_reclaim(gfp_mask=300431548, order=0,
> alloc_flags=300431604, ac=0xFFFFFF8011E83900) + 60
> <mm/page_alloc.c:3853>
> 	vmlinux  __alloc_pages_slowpath(gfp_mask=300431548, order=0,
> ac=0xFFFFFF8011E83900) + 1244
> <mm/page_alloc.c:4240>
> 	vmlinux  __alloc_pages_nodemask() + 1952
> 
>                             <mm/page_alloc.c:4463>
> 	vmlinux  __alloc_pages(gfp_mask=21102794, order=0, preferred_nid=0) + 16
> <include/linux/gfp.h:515>
> 	vmlinux  __alloc_pages_node(nid=0, gfp_mask=21102794, order=0) + 16
> 
>                             <include/linux/gfp.h:528>
> 	vmlinux  alloc_pages_node(nid=0, gfp_mask=21102794, order=0) + 16
> 
>                             <include/linux/gfp.h:542>
> 	vmlinux  __page_cache_alloc(gfp=21102794) + 16
> 
>                             <include/linux/pagemap.h:226>
> 	vmlinux  pagecache_get_page() + 384
> 
>                             <mm/filemap.c:1520>
> 	vmlinux  find_or_create_page(offset=209) + 112
> 
>                             <include/linux/pagemap.h:333>
> 	vmlinux  grab_cache_page(index=209) + 112
> 
>                             <include/linux/pagemap.h:399>
> 	vmlinux  f2fs_grab_cache_page(index=209, for_write=false) + 112

Ok, I think this should be enough.

--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1233,7 +1233,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
                                  CURSEG_ALL_DATA_ATGC : CURSEG_COLD_DATA;

          /* do not read out */
-       page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
+       page = f2fs_grab_cache_page(inode->i_mapping, bidx, true);
          if (!page)
                  return -ENOMEM;

> 
>                             <fs/f2fs/f2fs.h:2429>
> 	vmlinux  move_data_block(inode=0xFFFFFFDFD578EEA0, gc_type=300432152,
> segno=21904, off=145) + 3584                             <fs/f2fs/gc.c:1119>
> 	vmlinux  gc_data_segment(sbi=0xFFFFFFE007C03000, sum=0xFFFFFF8011E83B10,
> gc_list=0xFFFFFF8011E83AB8, segno=21904, gc_type=300432152) + 3644
> <fs/f2fs/gc.c:1475>
> 	vmlinux  do_garbage_collect(sbi=0xFFFFFFE007C03000, start_segno=21904,
> gc_list=0xFFFFFF8011E83CF0, gc_type=0) + 4060
> <fs/f2fs/gc.c:1592>
> 	vmlinux  f2fs_gc(sbi=0xFFFFFFE007C03000, background=true, segno=4294967295)
> + 1180                                         <fs/f2fs/gc.c:1684>
> 	vmlinux  gc_thread_func(data=0xFFFFFFE007C03000) + 572
> 
>                             <fs/f2fs/gc.c:118>
> 	vmlinux  kthread() + 376
> 
>                             <kernel/kthread.c:232>
> 	vmlinux  ret_from_fork() +
> 
> Thanks
> yanwu
