Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AC75605E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiF2QaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiF2QaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB37E2C11C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6153761CC2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA426C34114;
        Wed, 29 Jun 2022 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656520214;
        bh=Ty+fLcDrCUsxl2YZ2pxLl0PoHycLZyiCQ/QvpV3W9X0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rqis4yST0n3Rm594Q7375njijGRebK9yXVpUBqRMNOO0+Dm1EN18uHHYYF8vJ1bTY
         C0KfkndWMWRX9fYcN0Y8XcjmEgZ31WpB7oaTw/zdJydtX86ZrajGucVqDMUxrUZVvB
         ayisW+7Sb/mBzt/b7KOXNoUEDeY0fa5WFVHBZNVF2MbuUcv4H1aNVk2k3apuXaXwZn
         cFtVm93C2o70lOs6PA+QUyfnpqIuKC9lf/f0XJQ6W0ZCKaIdwzxJzpszNjiOtzNsyw
         mbNzkNOpYLToQ1IqM+fq8U7BDgD8o9/5XdppGQ18f5getWPzNaTdxVViur23ujKX7s
         8chhmLrnSc9eQ==
Date:   Wed, 29 Jun 2022 09:30:13 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: run GCs synchronously given user
 requests
Message-ID: <Yrx+FZpqIAvQdi4A@google.com>
References: <20220617223106.3517374-1-jaegeuk@kernel.org>
 <20220617223106.3517374-2-jaegeuk@kernel.org>
 <c45a9c8b-c73a-76bc-6725-5d7e48e7a3f2@kernel.org>
 <Yq+kiXPyBsXgdYb2@google.com>
 <27138a10-a6b2-edad-1985-687a95b9039b@kernel.org>
 <YrNKMDAgB1/vtoxi@google.com>
 <bba33935-1e5f-ccc4-9bbf-2ebf7d136bac@kernel.org>
 <YrtFtkD4FZ1ILzzI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrtFtkD4FZ1ILzzI@google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28, Jaegeuk Kim wrote:
> On 06/28, Chao Yu wrote:
> > On 2022/6/23 0:58, Jaegeuk Kim wrote:
> > > On 06/22, Chao Yu wrote:
> > > > On 2022/6/20 6:34, Jaegeuk Kim wrote:
> > > > > On 06/19, Chao Yu wrote:
> > > > > > On 2022/6/18 6:31, Jaegeuk Kim wrote:
> > > > > > > When users set GC_URGENT or GC_MID, they expected to do GCs right away.
> > > > > > > But, there's a condition to bypass it. Let's indicate we need to do now
> > > > > > > in the thread.
> > > > > > 
> > > > > > .should_migrate_blocks is used to force migrating blocks in full
> > > > > > section, so what is the condition here? GC should not never select
> > > > > > a full section, right?
> > > > > 
> > > > > I think it'll move a full section given .victim_segno is not NULL_SEGNO,
> > > > > as __get_victim will give a dirty segment all the time. wdyt?
> > > > 
> > > > However, in gc_thread_fun() victim_segno is NULL_SEGNO all the time.
> > > 
> > > What do you mean? The gc_thread thread sets NULL_SEGNO, which prevents
> > > from selecting the full section. But, f2fs_ioc_flush_device will set the
> > > segno to move, and f2fs_resize_fs calls do_garbage_collect directly.
> > 
> > Yes, but I didn't get why this patch updates .should_migrate_blocks for
> > gc_thread_func() case? If this is added to avoid breaking from below condition,
> > I guess it's not necessary, since victim selected from gc_thread_func() will
> > always be dirty, so get_valid_blocks(sbi, segno, true) == BLKS_PER_SEC(sbi)
> > will be false anyway? or am I missing something?
> 
> I lost the previous test. :( IIRC, once I set GC_URGENT_HIGH, I've seen that
> f2fs_gc couldn't migrate blocks quickly, even or never succeeded. And, I
> also suspected the below condition tho, if I give force_migrate, it
> simply worked. I just realized that that may be caused by large sections
> having non-2MB-aligned zone capacity. Will check it again, as I found
> some buggy flows in that case.

Let me drop this patch, since [1] series could fix the GC issue.

[1] https://lore.kernel.org/linux-f2fs-devel/20220628234733.3330502-1-jaegeuk@kernel.org/T/#t

> 
> > 
> > 		/*
> > 		 * stop BG_GC if there is not enough free sections.
> > 		 * Or, stop GC if the segment becomes fully valid caused by
> > 		 * race condition along with SSR block allocation.
> > 		 */
> > 		if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
> > 			(!force_migrate && get_valid_blocks(sbi, segno, true) ==
> > 							BLKS_PER_SEC(sbi)))
> > 			return submitted;
> > 
> > Thanks,
> > 
> > > 
> > > > 
> > > > I guess .should_migrate_blocks should only be set to true for
> > > > F2FS_IOC_FLUSH_DEVICE/F2FS_IOC_RESIZE_FS case? rather than GC_URGENT or GC_MID
> > > > case? See commit 7dede88659df ("f2fs: fix to allow migrating fully valid segment").
> > > > 
> > > > Thanks,
> > > > 
> > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > > 
> > > > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > > > ---
> > > > > > >     fs/f2fs/gc.c | 8 ++++++--
> > > > > > >     1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > > > > > index d5fb426e0747..f4aa3c88118b 100644
> > > > > > > --- a/fs/f2fs/gc.c
> > > > > > > +++ b/fs/f2fs/gc.c
> > > > > > > @@ -37,7 +37,6 @@ static int gc_thread_func(void *data)
> > > > > > >     	unsigned int wait_ms;
> > > > > > >     	struct f2fs_gc_control gc_control = {
> > > > > > >     		.victim_segno = NULL_SEGNO,
> > > > > > > -		.should_migrate_blocks = false,
> > > > > > >     		.err_gc_skipped = false };
> > > > > > >     	wait_ms = gc_th->min_sleep_time;
> > > > > > > @@ -113,7 +112,10 @@ static int gc_thread_func(void *data)
> > > > > > >     				sbi->gc_mode == GC_URGENT_MID) {
> > > > > > >     			wait_ms = gc_th->urgent_sleep_time;
> > > > > > >     			f2fs_down_write(&sbi->gc_lock);
> > > > > > > +			gc_control.should_migrate_blocks = true;
> > > > > > >     			goto do_gc;
> > > > > > > +		} else {
> > > > > > > +			gc_control.should_migrate_blocks = false;
> > > > > > >     		}
> > > > > > >     		if (foreground) {
> > > > > > > @@ -139,7 +141,9 @@ static int gc_thread_func(void *data)
> > > > > > >     		if (!foreground)
> > > > > > >     			stat_inc_bggc_count(sbi->stat_info);
> > > > > > > -		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
> > > > > > > +		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC ||
> > > > > > > +				sbi->gc_mode == GC_URGENT_HIGH ||
> > > > > > > +				sbi->gc_mode == GC_URGENT_MID;
> > > > > > >     		/* foreground GC was been triggered via f2fs_balance_fs() */
> > > > > > >     		if (foreground)
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
