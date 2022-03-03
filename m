Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A152E4CC80E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbiCCVbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiCCVbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:31:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7010169382
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:30:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D4FCB825B1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0A7C340EC;
        Thu,  3 Mar 2022 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646343030;
        bh=IvX1BiJgviipXegKU6yjvsiv/Z1mRoYaLMflNtLg+yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBnWAlsTCTyaZInpwiLdjRBC7/ndMEHjcq9eAWykSX160Dt2JJGa8ekTMmZ829l+9
         e3y/H6wwEs97VOBFKQ3RLRhrCYIcOaFPbN16HPCRfmGhzTT99mbhDNHhaUFy8DZn9b
         vfprHt+YnK72F1EzF6AVtd3KQDoWiBqs15I9m0dYvLM7FCdt10ePTP9jTyIDjYePxG
         BjR/8Dt7BeLyCFczoSb6LYHohyW5pRgfaIaKb2ypwt5kiM/MFxNw9bobvklerJOckk
         sWhYSVW3/JK9eWc61f7rqO8Ff3biO4BYjOmqU8ucSM22rRSlOj+/VfV/UqNj6IpFqB
         aVoLD3Ez5KYRA==
Date:   Thu, 3 Mar 2022 13:30:28 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Jing Xia <jing.xia@unisoc.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Zhiguo Niu <zhiguo.niu@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential deadlock
Message-ID: <YiEzdKAWmFBwGmvJ@google.com>
References: <YfSMMpj2GrYXAJK2@google.com>
 <51be77f1-6e85-d46d-d0d3-c06d2055a190@kernel.org>
 <Yfs1KRgwgzSOvocR@google.com>
 <86a175d3-c438-505b-1dbc-4ef6e8b5adcb@kernel.org>
 <5b5e20d1-877f-b321-b341-c0f233ee976c@kernel.org>
 <51826b5f-e480-994a-4a72-39ff4572bb3f@kernel.org>
 <Yh8AAOjxTItKTwPQ@google.com>
 <c0d3528b-e6b4-8557-4c2b-e26a972d8aaa@kernel.org>
 <Yh/JSlaIw49gV+15@google.com>
 <f1aa6b0d-bb48-f0e3-f9e2-5b1199a9635d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1aa6b0d-bb48-f0e3-f9e2-5b1199a9635d@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03, Chao Yu wrote:
> On 2022/3/3 3:45, Jaegeuk Kim wrote:
> > On 03/02, Chao Yu wrote:
> > > On 2022/3/2 13:26, Jaegeuk Kim wrote:
> > > > On 03/02, Chao Yu wrote:
> > > > > ping,
> > > > > 
> > > > > On 2022/2/25 11:02, Chao Yu wrote:
> > > > > > On 2022/2/3 22:57, Chao Yu wrote:
> > > > > > > On 2022/2/3 9:51, Jaegeuk Kim wrote:
> > > > > > > > On 01/29, Chao Yu wrote:
> > > > > > > > > On 2022/1/29 8:37, Jaegeuk Kim wrote:
> > > > > > > > > > On 01/28, Chao Yu wrote:
> > > > > > > > > > > On 2022/1/28 5:59, Jaegeuk Kim wrote:
> > > > > > > > > > > > On 01/27, Chao Yu wrote:
> > > > > > > > > > > > > Quoted from Jing Xia's report, there is a potential deadlock may happen
> > > > > > > > > > > > > between kworker and checkpoint as below:
> > > > > > > > > > > > > 
> > > > > > > > > > > > > [T:writeback]                [T:checkpoint]
> > > > > > > > > > > > > - wb_writeback
> > > > > > > > > > > > >       - blk_start_plug
> > > > > > > > > > > > > bio contains NodeA was plugged in writeback threads
> > > > > > > > > > > > 
> > > > > > > > > > > > I'm still trying to understand more precisely. So, how is it possible to
> > > > > > > > > > > > have bio having node write in this current context?
> > > > > > > > > > > 
> > > > > > > > > > > IMO, after above blk_start_plug(), it may plug some inode's node page in kworker
> > > > > > > > > > > during writebacking node_inode's data page (which should be node page)?
> > > > > > > > > > 
> > > > > > > > > > Wasn't that added into a different task->plug?
> > > > > > > > > 
> > > > > > > > > I'm not sure I've got your concern correctly...
> > > > > > > > > 
> > > > > > > > > Do you mean NodeA and other IOs from do_writepages() were plugged in
> > > > > > > > > different local plug variables?
> > > > > > > > 
> > > > > > > > I think so.
> > > > > > > 
> > > > > > > I guess block plug helper says it doesn't allow to use nested plug, so there
> > > > > > > is only one plug in kworker thread?
> > > > 
> > > > Is there only one kworker thread that flushes node and inode pages?
> > > 
> > > IIRC, =one kworker per block device?
> > 
> > If there's one kworker only, f2fs_write_node_pages() should have flushed its
> > plug?
> 
> No, f2fs_write_node_pages() failed to attach local plug into current->plug due to
> current has attached plug from wb_writeback(), and also, f2fs_write_node_pages()
> will fail to flush current->plug due to its local plug doesn't match current->plug.
> 
> void blk_start_plug_nr_ios()
> {
> 	if (tsk->plug)
> 		return;
> ...
> }
> 
> void blk_finish_plug(struct blk_plug *plug)
> {
> 	if (plug == current->plug) {
> 		__blk_flush_plug(plug, false);
> 		current->plug = NULL;
> 	}
> }

Ah, okay. Now I see. Thanks for the chasing down.

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > > > 
> > > > > > > void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
> > > > > > > {
> > > > > > >        struct task_struct *tsk = current;
> > > > > > > 
> > > > > > >        /*
> > > > > > >         * If this is a nested plug, don't actually assign it.
> > > > > > >         */
> > > > > > >        if (tsk->plug)
> > > > > > >            return;
> > > > > > > ...
> > > > > > > }
> > > > > > 
> > > > > > Any further comments?
> > > > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > Thanks,
> > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > >                       - do_writepages  -- sync write inodeB, inc wb_sync_req[DATA]
> > > > > > > > > > > > >                        - f2fs_write_data_pages
> > > > > > > > > > > > >                         - f2fs_write_single_data_page -- write last dirty page
> > > > > > > > > > > > >                          - f2fs_do_write_data_page
> > > > > > > > > > > > >                           - set_page_writeback  -- clear page dirty flag and
> > > > > > > > > > > > >                           PAGECACHE_TAG_DIRTY tag in radix tree
> > > > > > > > > > > > >                           - f2fs_outplace_write_data
> > > > > > > > > > > > >                            - f2fs_update_data_blkaddr
> > > > > > > > > > > > >                             - f2fs_wait_on_page_writeback -- wait NodeA to writeback here
> > > > > > > > > > > > >                          - inode_dec_dirty_pages
> > > > > > > > > > > > >       - writeback_sb_inodes
> > > > > > > > > > > > >        - writeback_single_inode
> > > > > > > > > > > > >         - do_writepages
> > > > > > > > > > > > >          - f2fs_write_data_pages -- skip writepages due to wb_sync_req[DATA]
> > > > > > > > > > > > >           - wbc->pages_skipped += get_dirty_pages() -- PAGECACHE_TAG_DIRTY is not set but get_dirty_pages() returns one
> > > > > > > > > > > > >        - requeue_inode -- requeue inode to wb->b_dirty queue due to non-zero.pages_skipped
> > > > > > > > > > > > >       - blk_finish_plug
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Let's try to avoid deadlock condition by forcing unplugging previous bio via
> > > > > > > > > > > > > blk_finish_plug(current->plug) once we'v skipped writeback in writepages()
> > > > > > > > > > > > > due to valid sbi->wb_sync_req[DATA/NODE].
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Fixes: 687de7f1010c ("f2fs: avoid IO split due to mixed WB_SYNC_ALL and WB_SYNC_NONE")
> > > > > > > > > > > > > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > > > > > > > > > > > Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> > > > > > > > > > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >       fs/f2fs/data.c | 6 +++++-
> > > > > > > > > > > > >       fs/f2fs/node.c | 6 +++++-
> > > > > > > > > > > > >       2 files changed, 10 insertions(+), 2 deletions(-)
> > > > > > > > > > > > > 
> > > > > > > > > > > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > > > > > > > > > > index 76d6fe7b0c8f..932a4c81acaf 100644
> > > > > > > > > > > > > --- a/fs/f2fs/data.c
> > > > > > > > > > > > > +++ b/fs/f2fs/data.c
> > > > > > > > > > > > > @@ -3174,8 +3174,12 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
> > > > > > > > > > > > >           /* to avoid spliting IOs due to mixed WB_SYNC_ALL and WB_SYNC_NONE */
> > > > > > > > > > > > >           if (wbc->sync_mode == WB_SYNC_ALL)
> > > > > > > > > > > > >               atomic_inc(&sbi->wb_sync_req[DATA]);
> > > > > > > > > > > > > -    else if (atomic_read(&sbi->wb_sync_req[DATA]))
> > > > > > > > > > > > > +    else if (atomic_read(&sbi->wb_sync_req[DATA])) {
> > > > > > > > > > > > > +        /* to avoid potential deadlock */
> > > > > > > > > > > > > +        if (current->plug)
> > > > > > > > > > > > > +            blk_finish_plug(current->plug);
> > > > > > > > > > > > >               goto skip_write;
> > > > > > > > > > > > > +    }
> > > > > > > > > > > > >           if (__should_serialize_io(inode, wbc)) {
> > > > > > > > > > > > >               mutex_lock(&sbi->writepages);
> > > > > > > > > > > > > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > > > > > > > > > > > > index 556fcd8457f3..69c6bcaf5aae 100644
> > > > > > > > > > > > > --- a/fs/f2fs/node.c
> > > > > > > > > > > > > +++ b/fs/f2fs/node.c
> > > > > > > > > > > > > @@ -2106,8 +2106,12 @@ static int f2fs_write_node_pages(struct address_space *mapping,
> > > > > > > > > > > > >           if (wbc->sync_mode == WB_SYNC_ALL)
> > > > > > > > > > > > >               atomic_inc(&sbi->wb_sync_req[NODE]);
> > > > > > > > > > > > > -    else if (atomic_read(&sbi->wb_sync_req[NODE]))
> > > > > > > > > > > > > +    else if (atomic_read(&sbi->wb_sync_req[NODE])) {
> > > > > > > > > > > > > +        /* to avoid potential deadlock */
> > > > > > > > > > > > > +        if (current->plug)
> > > > > > > > > > > > > +            blk_finish_plug(current->plug);
> > > > > > > > > > > > >               goto skip_write;
> > > > > > > > > > > > > +    }
> > > > > > > > > > > > >           trace_f2fs_writepages(mapping->host, wbc, NODE);
> > > > > > > > > > > > > -- 
> > > > > > > > > > > > > 2.32.0
> > > > > > > 
> > > > > > > 
> > > > > > > _______________________________________________
> > > > > > > Linux-f2fs-devel mailing list
> > > > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > > > > 
> > > > > > 
> > > > > > _______________________________________________
> > > > > > Linux-f2fs-devel mailing list
> > > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
