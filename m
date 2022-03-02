Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F5A4CA121
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240639AbiCBJrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbiCBJrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:47:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8E8986D9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:46:32 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A27E21121;
        Wed,  2 Mar 2022 09:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646214391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zU0omcjj6FNIaoNnjAuvB9rjRyhqvWJLX6/CjwTASF8=;
        b=QW0dRsrypn1bL/WOIg/fcK0vKQ622cJBIy91DRi1HftPB079qk0Qp3mgboAmt1E+D0+Tnm
        hNk7pvvJ3+hre162gXcLEsjySGt59/5GrwLPA4kkRTyr1lOVUWO2Vo9cQ0WmVOVteMnq4y
        As5ox4USY1QcQJoDDh11k4LmjzdsFpU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1DE3CA3B85;
        Wed,  2 Mar 2022 09:46:28 +0000 (UTC)
Date:   Wed, 2 Mar 2022 10:46:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgel.zte@gmail.com, naoya.horiguchi@nec.com, minchan@kernel.org,
        hannes@cmpxchg.org, rogerq@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guo.ziliang@zte.com.cn,
        Zeal Robot <zealci@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH linux-next] mm: swap: get rid of deadloop in swapin
 readahead
Message-ID: <Yh889CjjSxigdEAY@dhcp22.suse.cz>
References: <20220221111749.1928222-1-cgel.zte@gmail.com>
 <YhyAfSTkXFmIam9+@dhcp22.suse.cz>
 <20220228073315.c855e15b108089187a40d2b0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228073315.c855e15b108089187a40d2b0@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-02-22 07:33:15, Andrew Morton wrote:
> On Mon, 28 Feb 2022 08:57:49 +0100 Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Mon 21-02-22 11:17:49, cgel.zte@gmail.com wrote:
> > > From: Guo Ziliang <guo.ziliang@zte.com.cn>
> > > 
> > > In our testing, a deadloop task was found. Through sysrq printing, same 
> > > stack was found every time, as follows:
> > > __swap_duplicate+0x58/0x1a0
> > > swapcache_prepare+0x24/0x30
> > > __read_swap_cache_async+0xac/0x220
> > > read_swap_cache_async+0x58/0xa0
> > > swapin_readahead+0x24c/0x628
> > > do_swap_page+0x374/0x8a0
> > > __handle_mm_fault+0x598/0xd60
> > > handle_mm_fault+0x114/0x200
> > > do_page_fault+0x148/0x4d0
> > > do_translation_fault+0xb0/0xd4
> > > do_mem_abort+0x50/0xb0
> > > 
> > > The reason for the deadloop is that swapcache_prepare() always returns
> > > EEXIST, indicating that SWAP_HAS_CACHE has not been cleared, so that
> > > it cannot jump out of the loop. We suspect that the task that clears
> > > the SWAP_HAS_CACHE flag never gets a chance to run. We try to lower
> > > the priority of the task stuck in a deadloop so that the task that
> > > clears the SWAP_HAS_CACHE flag will run. The results show that the
> > > system returns to normal after the priority is lowered.
> > > 
> > > In our testing, multiple real-time tasks are bound to the same core,
> > > and the task in the deadloop is the highest priority task of the
> > > core, so the deadloop task cannot be preempted.
> > > 
> > > Although cond_resched() is used by __read_swap_cache_async, it is an
> > > empty function in the preemptive system and cannot achieve the purpose
> > > of releasing the CPU. A high-priority task cannot release the CPU
> > > unless preempted by a higher-priority task. But when this task
> > > is already the highest priority task on this core, other tasks
> > > will not be able to be scheduled. So we think we should replace
> > > cond_resched() with schedule_timeout_uninterruptible(1),
> > > schedule_timeout_interruptible will call set_current_state
> > > first to set the task state, so the task will be removed
> > > from the running queue, so as to achieve the purpose of
> > > giving up the CPU and prevent it from running in kernel
> > > mode for too long.
> > 
> > I am sorry but I really do not see how this case is any different from
> > any other kernel code path being hogged by a RT task. We surely
> > shouldn't put sleeps into all random paths which are doing cond_resched
> > at the moment. 
> 
> But this cond_resched() is different from most.  This one is attempting
> to yield the CPU so this task can make progress.  And cond_resched()
> simply isn't an appropriate way of doing this because under this fairly
> common situation, it's a no-op.

I might be really missing something but I really do not see how is this
any different from the page allocator path which only does cond_resched
as well (well, except for throttling but that might just not trigger).
Or other paths which just do cond_resched while waiting for a progress
somewhere else.

Not that I like this situation but !PREEMPT kernel with RT priority
tasks is rather limited and full of potential priblems IMHO.
-- 
Michal Hocko
SUSE Labs
