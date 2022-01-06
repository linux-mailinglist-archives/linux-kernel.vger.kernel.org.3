Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE454864A9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbiAFM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:58:02 -0500
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:57559 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239070AbiAFM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:58:01 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 8CB8ABABCE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 12:58:00 +0000 (GMT)
Received: (qmail 5988 invoked from network); 6 Jan 2022 12:58:00 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.169])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Jan 2022 12:58:00 -0000
Date:   Thu, 6 Jan 2022 12:57:58 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     DaeRo Lee <skseofh@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan.c: no need to double-check if free pages are
 under high-watermark
Message-ID: <20220106125758.GY3366@techsingularity.net>
References: <20220102033129.12913-1-skseofh@gmail.com>
 <20220106094650.GX3366@techsingularity.net>
 <CAATEi5=Cmt__5mQLcis5dO9ncc5nyQgiGD22UXtLsgJH5ZbwkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAATEi5=Cmt__5mQLcis5dO9ncc5nyQgiGD22UXtLsgJH5ZbwkA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 09:03:34PM +0900, DaeRo Lee wrote:
> > > @@ -4355,7 +4355,7 @@ static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
> > >  static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
> > >                               unsigned int highest_zoneidx)
> > >  {
> > > -     long remaining = 0;
> > > +     long remaining = ~0;
> > >       DEFINE_WAIT(wait);
> > >
> > >       if (freezing(current) || kthread_should_stop())
> >
> > While this does avoid calling prepare_kswapd_sleep() twice if the pgdat
> > is balanced on the first try, it then does not restore the vmstat
> > thresholds and doesn't call schedul() for kswapd to go to sleep.
> 
> I intended not to call prepare_kswapd_sleep() twice when the pgdat is NOT
> balanced on the first try:)
> 

Stupid typo on my part.

> > @@ -4406,11 +4412,11 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
> >         }
> >
> >         /*
> > -        * After a short sleep, check if it was a premature sleep. If not, then
> > -        * go fully to sleep until explicitly woken up.
> > +        * If balanced to the high watermark, restore vmstat thresholds and
> > +        * kswapd goes to sleep. If kswapd remains awake, account whether
> > +        * the low or high watermark was hit quickly.
> >          */
> > -       if (!remaining &&
> > -           prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
> > +       if (balanced) {
> >                 trace_mm_vmscan_kswapd_sleep(pgdat->node_id);
> >
> >                 /*
> 
> But, I think what you did is more readable and nice.
> Thanks!
> 

Feel free to pick it up, rerun your tests to ensure it's behaving as
expected and resend! Include something in the changelog about user-visible
effects if any (or a note saying that it reduces unnecssary overhead)
and resend with me added to the cc.

> > > @@ -4331,7 +4331,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> > >       /*
> > >        * Return the order kswapd stopped reclaiming at as
> > >        * prepare_kswapd_sleep() takes it into account. If another caller
> > > -      * entered the allocator slow path while kswapd was awake, order will
> > > +      * entered the allqocator slow path while kswapd was awake, order will
> > >        * remain at the higher level.
> > >        */
> > >       return sc.order;
> >
> > This hunk just adds a typo, drop it.
> 
> Sorry about that;;

No need to be sorry, it happens :)

Thanks!

-- 
Mel Gorman
SUSE Labs
