Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1A45256D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358025AbiELVFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239241AbiELVFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:05:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742427D00A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A026AB80AEA
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F39C385B8;
        Thu, 12 May 2022 21:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652389510;
        bh=8b8yIycXYuwnaJ406/9sz6HbsqXEqBJ0DuflynEfHaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=of152Ns5DycT3vO6iszfj6AWOFGbEbDPjkhrOYNdImgrcMooMjA4MvdWcDG6Y/PM1
         Tm5f0kPtcl5UtZY40pcVAtSo69hcG4DuUnkFb/8s1FRGOPInWaxrp3Ed/2tr5YycR7
         /oMvQM1VEZX/i2o9ebq1wkLyRE6PHLU4njRcAPxmF+yuVijvjyEkajceNCXPnQVCxj
         rYmH/DgoneaW61+a4Dko/g0QHVLPmqT9KZwjqwqYANzRHzzPdu/s6vGil0UwP5mL8a
         asRonNPdJZsAEs4Sncc/cx7P+bJlI6ktJglh6Y2J8Dj+FFxCALm1WvJaTgjikHU3r8
         u4gcRx2NJSo7Q==
Date:   Thu, 12 May 2022 14:05:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 4/5] f2fs: do not stop GC when requiring a
 free section
Message-ID: <Yn12hPhKOqWNGpdM@google.com>
References: <20220506232032.1264078-1-jaegeuk@kernel.org>
 <20220506232032.1264078-4-jaegeuk@kernel.org>
 <77e870dd-fd7a-f58e-79fb-d0e5b8fbfc16@kernel.org>
 <YnlHdgHix+3qlc1a@google.com>
 <42c23c83-1914-e8dd-c765-df3d6d872532@kernel.org>
 <Ynvoszmp7+64NdZg@google.com>
 <ab569309-f639-33af-ebb3-909a02158d02@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab569309-f639-33af-ebb3-909a02158d02@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12, Chao Yu wrote:
> On 2022/5/12 0:47, Jaegeuk Kim wrote:
> > > > > > @@ -147,6 +147,7 @@ static int gc_thread_func(void *data)
> > > > > >     		gc_control.init_gc_type = sync_mode ? FG_GC : BG_GC;
> > > > > >     		gc_control.no_bg_gc = foreground;
> > > > > > +		gc_control.nr_free_secs = foreground ? 1 : 0;
> 
> [snip]
> 
> > 
> > I mean gc_control->nr_free_secs should be 0.
> 
> [snip]
> 
> > > > > > @@ -528,7 +528,8 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
> > > > > >     				.init_gc_type = BG_GC,
> > > > > >     				.no_bg_gc = true,
> > > > > >     				.should_migrate_blocks = false,
> > > > > > -				.err_gc_skipped = false };
> > > > > > +				.err_gc_skipped = false,
> > > > > > +				.nr_free_secs = 1 };
> 
> Oh, so, in above two paths, when .nr_free_secs is 1, no_bg_gc should be true
> to keep skipping BG_GC flow.
> 
> How about adding a check condition in f2fs_gc() to avoid invalid argument
> usage in future?

Sent out v2. Could you please check?

> 
> From: Chao Yu <chao@kernel.org>
> 
> ---
>  fs/f2fs/gc.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 385282017317..a98276fd3cc1 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1799,10 +1799,19 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>  			gc_type = FG_GC;
>  	}
> 
> -	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
> -	if (gc_type == BG_GC && gc_control->no_bg_gc) {
> -		ret = -EINVAL;
> -		goto stop;
> +	if (gc_type == BG_GC) {
> +		/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
> +		if (gc_control->no_bg_gc) {
> +			ret = -EINVAL;
> +			goto stop;
> +		}
> +		/*
> +		 * BG_GC never guarantee that blocks are migrated synchronously.
> +		 */
> +		if (gc_control->nr_free_secs) {
> +			ret = -EINVAL;
> +			goto stop;
> +		}
>  	}
>  retry:
>  	ret = __get_victim(sbi, &segno, gc_type);
> -- 
> 2.25.1
> 
> 
> 
> Thanks,
