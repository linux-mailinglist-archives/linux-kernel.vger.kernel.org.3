Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3AF5312AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiEWQJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbiEWQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:09:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D8D463BC2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:09:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AF75106F;
        Mon, 23 May 2022 09:09:25 -0700 (PDT)
Received: from wubuntu (unknown [10.57.67.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AC653F73D;
        Mon, 23 May 2022 09:09:23 -0700 (PDT)
Date:   Mon, 23 May 2022 17:09:21 +0100
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
Message-ID: <20220523160921.k34jjbpd62bmc7fj@wubuntu>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220512085043.5234-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220512085043.5234-4-mgorman@techsingularity.net>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/22 09:50, Mel Gorman wrote:
> This is a preparation page to allow the buddy removal code to be reused
> in a later patch.
> 
> No functional change.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Tested-by: Minchan Kim <minchan@kernel.org>
> Acked-by: Minchan Kim <minchan@kernel.org>
> ---

I see this splat when this patch is applied on 5.10.107 kernel:

	[  132.779332] CPU: 1 PID: 203 Comm: klogd Not tainted 5.10.107-00039-g83962808e276 #28
	[  132.782470] BUG: using __this_cpu_add_return() in preemptible [00000000] code: udhcpc/229
	[  132.787809] Hardware name: ARM Juno development board (r2) (DT)
	[  132.787841] Call trace:
	[  132.787881]  dump_backtrace+0x0/0x2c0
	[  132.787921]  show_stack+0x18/0x28
	[  132.787963]  dump_stack_lvl+0x108/0x150
	[  132.788003]  dump_stack+0x1c/0x58
	[  132.788049]  check_preemption_disabled+0xf4/0x108
	[  132.788095]  __this_cpu_preempt_check+0x20/0x2c
	[  132.788135]  __inc_numa_state+0x3c/0x120
	[  132.788177]  get_page_from_freelist+0xd6c/0x1ac8
	[  132.788220]  __alloc_pages_nodemask+0x224/0x1780
	[  132.797359] caller is __this_cpu_preempt_check+0x20/0x2c
	[  132.803579]  alloc_pages_current+0xb0/0x150
	[  132.803621]  allocate_slab+0x2d0/0x408
	[  132.803662]  ___slab_alloc+0x43c/0x640
	[  132.803704]  __slab_alloc.isra.0+0x70/0xc8
	[  132.803747]  __kmalloc_node_track_caller+0x10c/0x2d8
	[  132.803792]  __kmalloc_reserve.isra.0+0x80/0x160
	[  132.803835]  __alloc_skb+0xd0/0x2a8
	[  132.883893]  alloc_skb_with_frags+0x64/0x2a0
	[  132.888632]  sock_alloc_send_pskb+0x420/0x438
	[  132.893465]  unix_dgram_sendmsg+0x1d4/0x930
	[  132.898112]  __sys_sendto+0x16c/0x230
	[  132.902198]  __arm64_sys_sendto+0x78/0x98
	[  132.906654]  el0_svc_common.constprop.0+0xac/0x278

I could resolve it by applying this patch:

	diff --git a/mm/vmstat.c b/mm/vmstat.c
	index 80c1e0a0f094e..92fb0c08296ef 100644
	--- a/mm/vmstat.c
	+++ b/mm/vmstat.c
	@@ -957,11 +957,11 @@ void __inc_numa_state(struct zone *zone,
		u16 __percpu *p = pcp->vm_numa_stat_diff + item;
		u16 v;

	-       v = __this_cpu_inc_return(*p);
	+       v = this_cpu_inc_return(*p);

		if (unlikely(v > NUMA_STATS_THRESHOLD)) {
			zone_numa_state_add(v, zone, item);
	-               __this_cpu_write(*p, 0);
	+               this_cpu_write(*p, 0);
		}
	 }

AFAICT zone_statistics() no longer protected by the spin_lock_irqsave(), so
preemption no longer disabled.

You need to have CONFIG_NUMA and CONFIG_DEBUG_PREEMPT enabled to reproduce
this.

HTH

Thanks!

--
Qais Yousef
