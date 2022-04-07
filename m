Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA844F811A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbiDGOAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiDGOA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:00:28 -0400
Received: from outbound-smtp17.blacknight.com (outbound-smtp17.blacknight.com [46.22.139.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7B21945C1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:58:27 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id D7C721C380C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:58:25 +0100 (IST)
Received: (qmail 8699 invoked from network); 7 Apr 2022 13:58:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Apr 2022 13:58:25 -0000
Date:   Thu, 7 Apr 2022 14:56:50 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     DaeRo Lee <skseofh@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan.c: no need to double-check if free pages are
 under high-watermark
Message-ID: <20220407135650.GA20204@techsingularity.net>
References: <20220102033129.12913-1-skseofh@gmail.com>
 <20220106094650.GX3366@techsingularity.net>
 <CAATEi5=Cmt__5mQLcis5dO9ncc5nyQgiGD22UXtLsgJH5ZbwkA@mail.gmail.com>
 <20220106125758.GY3366@techsingularity.net>
 <20220326155022.6pqxcfazjaw47eu5@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220326155022.6pqxcfazjaw47eu5@master>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 03:50:22PM +0000, Wei Yang wrote:
> On Thu, Jan 06, 2022 at 12:57:58PM +0000, Mel Gorman wrote:
> >On Thu, Jan 06, 2022 at 09:03:34PM +0900, DaeRo Lee wrote:
> >> > > @@ -4355,7 +4355,7 @@ static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
> >> > >  static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
> >> > >                               unsigned int highest_zoneidx)
> >> > >  {
> >> > > -     long remaining = 0;
> >> > > +     long remaining = ~0;
> >> > >       DEFINE_WAIT(wait);
> >> > >
> >> > >       if (freezing(current) || kthread_should_stop())
> >> >
> >> > While this does avoid calling prepare_kswapd_sleep() twice if the pgdat
> >> > is balanced on the first try, it then does not restore the vmstat
> >> > thresholds and doesn't call schedul() for kswapd to go to sleep.
> >> 
> >> I intended not to call prepare_kswapd_sleep() twice when the pgdat is NOT
> >> balanced on the first try:)
> >> 
> >
> >Stupid typo on my part.
> >
> >> > @@ -4406,11 +4412,11 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
> >> >         }
> >> >
> >> >         /*
> >> > -        * After a short sleep, check if it was a premature sleep. If not, then
> >> > -        * go fully to sleep until explicitly woken up.
> >> > +        * If balanced to the high watermark, restore vmstat thresholds and
> >> > +        * kswapd goes to sleep. If kswapd remains awake, account whether
> >> > +        * the low or high watermark was hit quickly.
> >> >          */
> >> > -       if (!remaining &&
> >> > -           prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
> >> > +       if (balanced) {
> >> >                 trace_mm_vmscan_kswapd_sleep(pgdat->node_id);
> >> >
> >> >                 /*
> >> 
> >> But, I think what you did is more readable and nice.
> >> Thanks!
> >> 
> >
> >Feel free to pick it up, rerun your tests to ensure it's behaving as
> >expected and resend! Include something in the changelog about user-visible
> >effects if any (or a note saying that it reduces unnecssary overhead)
> >and resend with me added to the cc.
> >
> 
> Hi, All
> 
> Seems this thread stops here. I don't see following patch and current upstream
> doesn't include this change.
> 
> May I continue this? Of course, with author-ship from DaeRo Lee <skseofh@gmail.com>.
> 

I've no objections. When I said "Feel free to pick it up", I meant that
I was ok with you taking the patch and putting your team on it.

> Mel,
> 
> Would you mind suggesting some cases that I could do to see the effects from
> this change? Such as the overhead or throughput? Or what cases you expect?
> 

I don't have any suggestions on artificially triggering it. I had assumed
you had encountered the bug in practice and had a test case but it would
be ok to note that the patch is a theoretical fix based on code review.

-- 
Mel Gorman
SUSE Labs
