Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D1D4C70AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbiB1Pd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbiB1Pd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:33:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A219013F45
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:33:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 476CD60FD8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF41C340EE;
        Mon, 28 Feb 2022 15:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646062396;
        bh=WyaUKD0KNG92cBo3Esei4c8zkTolBVRdBS/KulblFow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LAY3gW5hFuQ8oUSh1itgzAjoL6/E96p44FjK1U3pvv4mRVto83GNRzWzCWYNlGJ0j
         El70OsW5IK4qSjOH0UHpn+ZlE91FyYwPx1RoSRFSXkB1bFyDFO+7MGAP0gJwFaK21E
         60QQfyBVeyFUarU9vjnmEfoc4k9PB4B4CNmLnbkw=
Date:   Mon, 28 Feb 2022 07:33:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgel.zte@gmail.com, naoya.horiguchi@nec.com, minchan@kernel.org,
        hannes@cmpxchg.org, rogerq@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guo.ziliang@zte.com.cn,
        Zeal Robot <zealci@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH linux-next] mm: swap: get rid of deadloop in swapin
 readahead
Message-Id: <20220228073315.c855e15b108089187a40d2b0@linux-foundation.org>
In-Reply-To: <YhyAfSTkXFmIam9+@dhcp22.suse.cz>
References: <20220221111749.1928222-1-cgel.zte@gmail.com>
        <YhyAfSTkXFmIam9+@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 08:57:49 +0100 Michal Hocko <mhocko@suse.com> wrote:

> On Mon 21-02-22 11:17:49, cgel.zte@gmail.com wrote:
> > From: Guo Ziliang <guo.ziliang@zte.com.cn>
> > 
> > In our testing, a deadloop task was found. Through sysrq printing, same 
> > stack was found every time, as follows:
> > __swap_duplicate+0x58/0x1a0
> > swapcache_prepare+0x24/0x30
> > __read_swap_cache_async+0xac/0x220
> > read_swap_cache_async+0x58/0xa0
> > swapin_readahead+0x24c/0x628
> > do_swap_page+0x374/0x8a0
> > __handle_mm_fault+0x598/0xd60
> > handle_mm_fault+0x114/0x200
> > do_page_fault+0x148/0x4d0
> > do_translation_fault+0xb0/0xd4
> > do_mem_abort+0x50/0xb0
> > 
> > The reason for the deadloop is that swapcache_prepare() always returns
> > EEXIST, indicating that SWAP_HAS_CACHE has not been cleared, so that
> > it cannot jump out of the loop. We suspect that the task that clears
> > the SWAP_HAS_CACHE flag never gets a chance to run. We try to lower
> > the priority of the task stuck in a deadloop so that the task that
> > clears the SWAP_HAS_CACHE flag will run. The results show that the
> > system returns to normal after the priority is lowered.
> > 
> > In our testing, multiple real-time tasks are bound to the same core,
> > and the task in the deadloop is the highest priority task of the
> > core, so the deadloop task cannot be preempted.
> > 
> > Although cond_resched() is used by __read_swap_cache_async, it is an
> > empty function in the preemptive system and cannot achieve the purpose
> > of releasing the CPU. A high-priority task cannot release the CPU
> > unless preempted by a higher-priority task. But when this task
> > is already the highest priority task on this core, other tasks
> > will not be able to be scheduled. So we think we should replace
> > cond_resched() with schedule_timeout_uninterruptible(1),
> > schedule_timeout_interruptible will call set_current_state
> > first to set the task state, so the task will be removed
> > from the running queue, so as to achieve the purpose of
> > giving up the CPU and prevent it from running in kernel
> > mode for too long.
> 
> I am sorry but I really do not see how this case is any different from
> any other kernel code path being hogged by a RT task. We surely
> shouldn't put sleeps into all random paths which are doing cond_resched
> at the moment. 

But this cond_resched() is different from most.  This one is attempting
to yield the CPU so this task can make progress.  And cond_resched()
simply isn't an appropriate way of doing this because under this fairly
common situation, it's a no-op.

