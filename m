Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E91533BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbiEYLXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241512AbiEYLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:23:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A23899CF17
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:23:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C66A23A;
        Wed, 25 May 2022 04:23:39 -0700 (PDT)
Received: from wubuntu (unknown [10.57.65.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5571B3F70D;
        Wed, 25 May 2022 04:23:37 -0700 (PDT)
Date:   Wed, 25 May 2022 12:23:34 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 3/6] mm/page_alloc: Split out buddy removal code from
 rmqueue into separate helper
Message-ID: <20220525112334.k5ovoydr4iv3wuna@wubuntu>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220512085043.5234-4-mgorman@techsingularity.net>
 <20220523160921.k34jjbpd62bmc7fj@wubuntu>
 <20220524115543.GX3441@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220524115543.GX3441@techsingularity.net>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/22 12:55, Mel Gorman wrote:
> On Mon, May 23, 2022 at 05:09:21PM +0100, Qais Yousef wrote:
> > On 05/12/22 09:50, Mel Gorman wrote:
> > > This is a preparation page to allow the buddy removal code to be reused
> > > in a later patch.
> > > 
> > > No functional change.
> > > 
> > > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > > Tested-by: Minchan Kim <minchan@kernel.org>
> > > Acked-by: Minchan Kim <minchan@kernel.org>
> > > ---
> > 
> > I see this splat when this patch is applied on 5.10.107 kernel:
> > 
> 
> <SNIP>
> 
> > I could resolve it by applying this patch:
> > 
> > 	diff --git a/mm/vmstat.c b/mm/vmstat.c
> > 	index 80c1e0a0f094e..92fb0c08296ef 100644
> > 	--- a/mm/vmstat.c
> > 	+++ b/mm/vmstat.c
> > 	@@ -957,11 +957,11 @@ void __inc_numa_state(struct zone *zone,
> > 		u16 __percpu *p = pcp->vm_numa_stat_diff + item;
> > 		u16 v;
> > 
> > 	-       v = __this_cpu_inc_return(*p);
> > 	+       v = this_cpu_inc_return(*p);
> > 
> > 		if (unlikely(v > NUMA_STATS_THRESHOLD)) {
> > 			zone_numa_state_add(v, zone, item);
> > 	-               __this_cpu_write(*p, 0);
> > 	+               this_cpu_write(*p, 0);
> > 		}
> > 	 }
> > 
> 
> 5.18 does not have __inc_numa_state() so it's likely you are missing
> backports, probably f19298b9516c1a031b34b4147773457e3efe743b at minimum.

Thanks Mel. Sorry it seems I stopped my analysis tad too soon. It seems the
dependency chain is more than that commit. I couldn't backport it on its own.

I just happened to be an accidental user of that kernel (it's an Android 5.10
tree). I did report it there too, but I thought (wrongly) this could benefit
this upstream discussion.

I'll take it there.

Thanks!

--
Qais Yousef
