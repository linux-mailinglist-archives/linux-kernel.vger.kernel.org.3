Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63190550D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 00:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiFSWe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 18:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFSWez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 18:34:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE38A1A5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 018CBB80E08
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869F7C34114;
        Sun, 19 Jun 2022 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655678091;
        bh=9ArPk07pQBsppiwazyBIRWoKZ16tPzVNYnmugvt2wek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cBHgnH5iwJizv1FllI2HR2uHHHwTN/1WXyI/GZAluzxj6MEDcxwqThk+5wEcG3zQS
         Xo/nMax4HzTPEGbAkvDfU4EJSFquqrfquyJ9BHyLjPiPOvRO6ZpDIDMEm/z/cmv5mk
         GYbbIHUlC1kCTWDXws3wbM9xsM4MLZ+i7b5Y5P3kafXaQjX4s/odKK0Woe5mxvrK4d
         VylKDGd67kXFeu6fj0GMj85O+r3f0GVJ6tGv8G1ghOMkynagU1/Wo9fTfmlvpbFYez
         seFETcNS+PMz3IzqUkS5ttS+Iu3GWfP5ywVA+rOLX2NCvZq59DR1XBXixz0SdwKrux
         drBkckbvAraFQ==
Date:   Sun, 19 Jun 2022 15:34:49 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: run GCs synchronously given user
 requests
Message-ID: <Yq+kiXPyBsXgdYb2@google.com>
References: <20220617223106.3517374-1-jaegeuk@kernel.org>
 <20220617223106.3517374-2-jaegeuk@kernel.org>
 <c45a9c8b-c73a-76bc-6725-5d7e48e7a3f2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c45a9c8b-c73a-76bc-6725-5d7e48e7a3f2@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19, Chao Yu wrote:
> On 2022/6/18 6:31, Jaegeuk Kim wrote:
> > When users set GC_URGENT or GC_MID, they expected to do GCs right away.
> > But, there's a condition to bypass it. Let's indicate we need to do now
> > in the thread.
> 
> .should_migrate_blocks is used to force migrating blocks in full
> section, so what is the condition here? GC should not never select
> a full section, right?

I think it'll move a full section given .victim_segno is not NULL_SEGNO,
as __get_victim will give a dirty segment all the time. wdyt?

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/gc.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index d5fb426e0747..f4aa3c88118b 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -37,7 +37,6 @@ static int gc_thread_func(void *data)
> >   	unsigned int wait_ms;
> >   	struct f2fs_gc_control gc_control = {
> >   		.victim_segno = NULL_SEGNO,
> > -		.should_migrate_blocks = false,
> >   		.err_gc_skipped = false };
> >   	wait_ms = gc_th->min_sleep_time;
> > @@ -113,7 +112,10 @@ static int gc_thread_func(void *data)
> >   				sbi->gc_mode == GC_URGENT_MID) {
> >   			wait_ms = gc_th->urgent_sleep_time;
> >   			f2fs_down_write(&sbi->gc_lock);
> > +			gc_control.should_migrate_blocks = true;
> >   			goto do_gc;
> > +		} else {
> > +			gc_control.should_migrate_blocks = false;
> >   		}
> >   		if (foreground) {
> > @@ -139,7 +141,9 @@ static int gc_thread_func(void *data)
> >   		if (!foreground)
> >   			stat_inc_bggc_count(sbi->stat_info);
> > -		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
> > +		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC ||
> > +				sbi->gc_mode == GC_URGENT_HIGH ||
> > +				sbi->gc_mode == GC_URGENT_MID;
> >   		/* foreground GC was been triggered via f2fs_balance_fs() */
> >   		if (foreground)
