Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCDB4A7D86
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348877AbiBCBvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348855AbiBCBvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:51:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C347C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 17:51:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B109B832E4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 01:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B437C004E1;
        Thu,  3 Feb 2022 01:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643853099;
        bh=5xWMoKazPBC7l0qgnFDC3xj6OCZTLGyt4YlZVtHxSeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufs5LljrmMBqF2sJN+x2I2nMIQGp1G+e9lt0ne6Di5D8BOUMCTIm7y0m+Lc3ZVJYn
         l0xEFSmgeNSgvZGlTCuT13JrCpLt2gvRJ9Ye39e668VAV/d624+Z29xNZgdameXg1M
         V+58ONiSVJmoo6uznFybe04Jh8v5IBzpSaIffE0MXRCevOMGYwlulFB4xOd/ycjk2B
         pRxaSA1HoZYuR1dSBYocVl7akzZsjdSHmEQK35BISYHYOr549nukIt1SYA+XuDF1Ne
         TyxORKH4ADCC+cdCkYOLexQYWLocX+eVxPpj4tFepQdU7fnSq7EgsXgCnvtSxGmBbZ
         X8+PjhC1EHnEw==
Date:   Wed, 2 Feb 2022 17:51:37 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Zhiguo Niu <zhiguo.niu@unisoc.com>,
        Jing Xia <jing.xia@unisoc.com>
Subject: Re: [PATCH] f2fs: fix to avoid potential deadlock
Message-ID: <Yfs1KRgwgzSOvocR@google.com>
References: <20220127054449.24711-1-chao@kernel.org>
 <YfMVxzdhat01ca7m@google.com>
 <e434b0a4-a66a-eebc-cafc-f0bad03c3fa5@kernel.org>
 <YfSMMpj2GrYXAJK2@google.com>
 <51be77f1-6e85-d46d-d0d3-c06d2055a190@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51be77f1-6e85-d46d-d0d3-c06d2055a190@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29, Chao Yu wrote:
> On 2022/1/29 8:37, Jaegeuk Kim wrote:
> > On 01/28, Chao Yu wrote:
> > > On 2022/1/28 5:59, Jaegeuk Kim wrote:
> > > > On 01/27, Chao Yu wrote:
> > > > > Quoted from Jing Xia's report, there is a potential deadlock may happen
> > > > > between kworker and checkpoint as below:
> > > > > 
> > > > > [T:writeback]				[T:checkpoint]
> > > > > - wb_writeback
> > > > >    - blk_start_plug
> > > > > bio contains NodeA was plugged in writeback threads
> > > > 
> > > > I'm still trying to understand more precisely. So, how is it possible to
> > > > have bio having node write in this current context?
> > > 
> > > IMO, after above blk_start_plug(), it may plug some inode's node page in kworker
> > > during writebacking node_inode's data page (which should be node page)?
> > 
> > Wasn't that added into a different task->plug?
> 
> I'm not sure I've got your concern correctly...
> 
> Do you mean NodeA and other IOs from do_writepages() were plugged in
> different local plug variables?

I think so.

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 					- do_writepages  -- sync write inodeB, inc wb_sync_req[DATA]
> > > > > 					 - f2fs_write_data_pages
> > > > > 					  - f2fs_write_single_data_page -- write last dirty page
> > > > > 					   - f2fs_do_write_data_page
> > > > > 					    - set_page_writeback  -- clear page dirty flag and
> > > > > 					    PAGECACHE_TAG_DIRTY tag in radix tree
> > > > > 					    - f2fs_outplace_write_data
> > > > > 					     - f2fs_update_data_blkaddr
> > > > > 					      - f2fs_wait_on_page_writeback -- wait NodeA to writeback here
> > > > > 					   - inode_dec_dirty_pages
> > > > >    - writeback_sb_inodes
> > > > >     - writeback_single_inode
> > > > >      - do_writepages
> > > > >       - f2fs_write_data_pages -- skip writepages due to wb_sync_req[DATA]
> > > > >        - wbc->pages_skipped += get_dirty_pages() -- PAGECACHE_TAG_DIRTY is not set but get_dirty_pages() returns one
> > > > >     - requeue_inode -- requeue inode to wb->b_dirty queue due to non-zero.pages_skipped
> > > > >    - blk_finish_plug
> > > > > 
> > > > > Let's try to avoid deadlock condition by forcing unplugging previous bio via
> > > > > blk_finish_plug(current->plug) once we'v skipped writeback in writepages()
> > > > > due to valid sbi->wb_sync_req[DATA/NODE].
> > > > > 
> > > > > Fixes: 687de7f1010c ("f2fs: avoid IO split due to mixed WB_SYNC_ALL and WB_SYNC_NONE")
> > > > > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > > > Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > ---
> > > > >    fs/f2fs/data.c | 6 +++++-
> > > > >    fs/f2fs/node.c | 6 +++++-
> > > > >    2 files changed, 10 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > > index 76d6fe7b0c8f..932a4c81acaf 100644
> > > > > --- a/fs/f2fs/data.c
> > > > > +++ b/fs/f2fs/data.c
> > > > > @@ -3174,8 +3174,12 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
> > > > >    	/* to avoid spliting IOs due to mixed WB_SYNC_ALL and WB_SYNC_NONE */
> > > > >    	if (wbc->sync_mode == WB_SYNC_ALL)
> > > > >    		atomic_inc(&sbi->wb_sync_req[DATA]);
> > > > > -	else if (atomic_read(&sbi->wb_sync_req[DATA]))
> > > > > +	else if (atomic_read(&sbi->wb_sync_req[DATA])) {
> > > > > +		/* to avoid potential deadlock */
> > > > > +		if (current->plug)
> > > > > +			blk_finish_plug(current->plug);
> > > > >    		goto skip_write;
> > > > > +	}
> > > > >    	if (__should_serialize_io(inode, wbc)) {
> > > > >    		mutex_lock(&sbi->writepages);
> > > > > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > > > > index 556fcd8457f3..69c6bcaf5aae 100644
> > > > > --- a/fs/f2fs/node.c
> > > > > +++ b/fs/f2fs/node.c
> > > > > @@ -2106,8 +2106,12 @@ static int f2fs_write_node_pages(struct address_space *mapping,
> > > > >    	if (wbc->sync_mode == WB_SYNC_ALL)
> > > > >    		atomic_inc(&sbi->wb_sync_req[NODE]);
> > > > > -	else if (atomic_read(&sbi->wb_sync_req[NODE]))
> > > > > +	else if (atomic_read(&sbi->wb_sync_req[NODE])) {
> > > > > +		/* to avoid potential deadlock */
> > > > > +		if (current->plug)
> > > > > +			blk_finish_plug(current->plug);
> > > > >    		goto skip_write;
> > > > > +	}
> > > > >    	trace_f2fs_writepages(mapping->host, wbc, NODE);
> > > > > -- 
> > > > > 2.32.0
