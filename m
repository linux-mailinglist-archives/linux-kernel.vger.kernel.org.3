Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD7B5329C8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiEXLzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiEXLzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:55:49 -0400
Received: from outbound-smtp23.blacknight.com (outbound-smtp23.blacknight.com [81.17.249.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346E45D18B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:55:47 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp23.blacknight.com (Postfix) with ESMTPS id 97465BF12A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:55:45 +0100 (IST)
Received: (qmail 17315 invoked from network); 24 May 2022 11:55:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 May 2022 11:55:45 -0000
Date:   Tue, 24 May 2022 12:55:43 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 3/6] mm/page_alloc: Split out buddy removal code from
 rmqueue into separate helper
Message-ID: <20220524115543.GX3441@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220512085043.5234-4-mgorman@techsingularity.net>
 <20220523160921.k34jjbpd62bmc7fj@wubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220523160921.k34jjbpd62bmc7fj@wubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 05:09:21PM +0100, Qais Yousef wrote:
> On 05/12/22 09:50, Mel Gorman wrote:
> > This is a preparation page to allow the buddy removal code to be reused
> > in a later patch.
> > 
> > No functional change.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > Tested-by: Minchan Kim <minchan@kernel.org>
> > Acked-by: Minchan Kim <minchan@kernel.org>
> > ---
> 
> I see this splat when this patch is applied on 5.10.107 kernel:
> 

<SNIP>

> I could resolve it by applying this patch:
> 
> 	diff --git a/mm/vmstat.c b/mm/vmstat.c
> 	index 80c1e0a0f094e..92fb0c08296ef 100644
> 	--- a/mm/vmstat.c
> 	+++ b/mm/vmstat.c
> 	@@ -957,11 +957,11 @@ void __inc_numa_state(struct zone *zone,
> 		u16 __percpu *p = pcp->vm_numa_stat_diff + item;
> 		u16 v;
> 
> 	-       v = __this_cpu_inc_return(*p);
> 	+       v = this_cpu_inc_return(*p);
> 
> 		if (unlikely(v > NUMA_STATS_THRESHOLD)) {
> 			zone_numa_state_add(v, zone, item);
> 	-               __this_cpu_write(*p, 0);
> 	+               this_cpu_write(*p, 0);
> 		}
> 	 }
> 

5.18 does not have __inc_numa_state() so it's likely you are missing
backports, probably f19298b9516c1a031b34b4147773457e3efe743b at minimum.

-- 
Mel Gorman
SUSE Labs
