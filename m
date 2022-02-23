Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D74C138D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbiBWNGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiBWNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:06:12 -0500
Received: from outbound-smtp40.blacknight.com (outbound-smtp40.blacknight.com [46.22.139.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1889893190
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:05:44 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id A9B3B1C3CBA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:05:42 +0000 (GMT)
Received: (qmail 9630 invoked from network); 23 Feb 2022 13:05:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Feb 2022 13:05:42 -0000
Date:   Wed, 23 Feb 2022 13:05:40 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/6] mm/page_alloc: Free pages in a single pass during
 bulk free
Message-ID: <20220223130540.GF4423@techsingularity.net>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-6-mgorman@techsingularity.net>
 <Yg2qhJyTovY2oQhe@ziqianlu-nuc9qn>
 <20220217093113.GU3366@techsingularity.net>
 <Yg8ec9MLblOkHTY9@ziqianlu-nuc9qn>
 <YhOVzktqtWIJFjiJ@ziqianlu-nuc9qn>
 <YhYa7PzhzEqRYXHp@ziqianlu-nuc9qn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YhYa7PzhzEqRYXHp@ziqianlu-nuc9qn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 07:30:52PM +0800, Aaron Lu wrote:
> On Mon, Feb 21, 2022 at 09:38:22PM +0800, Aaron Lu wrote:
> > On Fri, Feb 18, 2022 at 12:20:03PM +0800, Aaron Lu wrote:
> > > On Thu, Feb 17, 2022 at 09:31:13AM +0000, Mel Gorman wrote:
> > > > On Thu, Feb 17, 2022 at 09:53:08AM +0800, Aaron Lu wrote:
> > > > > > 2-socket CascadeLake (40 cores, 80 CPUs HT enabled)
> > > > > >                                                     5.17.0-rc3                 5.17.0-rc3
> > > > > >                                                        vanilla           mm-highpcpopt-v2
> > > > > > Hmean     page_fault1-processes-2        2694662.26 (   0.00%)      2695780.35 (   0.04%)
> > > > > > Hmean     page_fault1-processes-5        6425819.34 (   0.00%)      6435544.57 *   0.15%*
> > > > > > Hmean     page_fault1-processes-8        9642169.10 (   0.00%)      9658962.39 (   0.17%)
> > > > > > Hmean     page_fault1-processes-12      12167502.10 (   0.00%)     12190163.79 (   0.19%)
> > > > > > Hmean     page_fault1-processes-21      15636859.03 (   0.00%)     15612447.26 (  -0.16%)
> > > > > > Hmean     page_fault1-processes-30      25157348.61 (   0.00%)     25169456.65 (   0.05%)
> > > > > > Hmean     page_fault1-processes-48      27694013.85 (   0.00%)     27671111.46 (  -0.08%)
> > > > > > Hmean     page_fault1-processes-79      25928742.64 (   0.00%)     25934202.02 (   0.02%) <--
> > > > > > Hmean     page_fault1-processes-110     25730869.75 (   0.00%)     25671880.65 *  -0.23%*
> > > > > > Hmean     page_fault1-processes-141     25626992.42 (   0.00%)     25629551.61 (   0.01%)
> > > > > > Hmean     page_fault1-processes-172     25611651.35 (   0.00%)     25614927.99 (   0.01%)
> > > > > > Hmean     page_fault1-processes-203     25577298.75 (   0.00%)     25583445.59 (   0.02%)
> > > > > > Hmean     page_fault1-processes-234     25580686.07 (   0.00%)     25608240.71 (   0.11%)
> > > > > > Hmean     page_fault1-processes-265     25570215.47 (   0.00%)     25568647.58 (  -0.01%)
> > > > > > Hmean     page_fault1-processes-296     25549488.62 (   0.00%)     25543935.00 (  -0.02%)
> > > > > > Hmean     page_fault1-processes-320     25555149.05 (   0.00%)     25575696.74 (   0.08%)
> > > > > > 
> > > > > > The differences are mostly within the noise and the difference close to
> > > > > > $nr_cpus is negligible.
> > > > > 
> > > > > I have queued will-it-scale/page_fault1/processes/$nr_cpu on 2 4-sockets
> > > > > servers: CascadeLake and CooperLaker and will let you know the result
> > > > > once it's out.
> > > > > 
> > > > 
> > > > Thanks, 4 sockets and a later generation would be nice to cover.
> > > > 
> > > > > I'm using 'https://github.com/hnaz/linux-mm master' and doing the
> > > > > comparison with commit c000d687ce22("mm/page_alloc: simplify how many
> > > > > pages are selected per pcp list during bulk free") and commit 8391e0a7e172
> > > > > ("mm/page_alloc: free pages in a single pass during bulk free") there.
> > > > > 
> > > > 
> > > > The baseline looks fine. It's different to what I used but the page_alloc
> > > > shouldn't have much impact.
> > > > 
> > > > When looking at will-it-scale, please pay attention to lower CPU counts
> > > > as well and take account changes in standard deviation. Looking at the
> > > 
> > > I'll also test nr_task=4/16/64 on the 4sockets CooperLake(nr_cpu=144) then.
> > > 
> > 
> > For the record, these tests don't show any visible performance changes
> > on CooperLake.
> 
> One thing I just noticed is that, zone lock contention increased to some
> extent. I'm not sure if this is worrisome so I suppose I should at least
> mention it here.
> 
> The nr_task=100% test on the 4 sockets Cooper Lake showed that zone lock
> contention increased from 13.56% to 20.16% and for nr_task=16, it
> increased from 4.75% to 6.18%.
> 
> The reason is probably due to more code are now inside the lock and when
> there is contention, it will make things worse. I'm aware of that
> nr_task=100% is a rare case and this patchset is meant to improve things
> when there is very little contention, which should be the common case.
> So I guess that's just the tradeoff we have to make...
> 

I think it's a reasonable tradeoff. The page_fault1 will-it-scale is
an extreme case that exercises severe contention for the zone lock with
both allocators and freeing contending for the lock at the same time. I
think it's reasonable to optimise for the common case of completing the
bulk freeing as quickly as possible. If anything, I think will-it-scale
would benefit more if zone->lock was split to cover regions within a zone
instead of protecting an entire zone which could be hundreds of GB in size.

-- 
Mel Gorman
SUSE Labs
