Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9814C5307
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiBZBZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiBZBZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:25:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AACBD7CB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 17:24:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C9DE61DFB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 01:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFBCC340E7;
        Sat, 26 Feb 2022 01:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645838681;
        bh=zgGPUxVPsTpIy2I0cC4JKCrYsg0+Z/RpLMyz/fQOXdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0lBVT3nlB5B/iU/UTefLiWv7Wvb2JHPpDeZW/IQSNOSJrZsz3lRngCvQqTaXyAIy/
         2nEozshcWrL5nwDcMZgVgNbJFrk2lgOOxwF9kIewlVf4ESaC3RyIPe3WWZkkiW7cOs
         tKKVhQkTzalPdnnG+9rnUguUVdWvcDdWp+4Q3rGk=
Date:   Fri, 25 Feb 2022 17:24:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     cgel.zte@gmail.com
Cc:     naoya.horiguchi@nec.com, mhocko@kernel.org, minchan@kernel.org,
        hannes@cmpxchg.org, rogerq@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guo.ziliang@zte.com.cn,
        Zeal Robot <zealci@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH linux-next] mm: swap: get rid of deadloop in swapin
 readahead
Message-Id: <20220225172440.ec62edf97b405d32061bcb37@linux-foundation.org>
In-Reply-To: <20220221111749.1928222-1-cgel.zte@gmail.com>
References: <20220221111749.1928222-1-cgel.zte@gmail.com>
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

On Mon, 21 Feb 2022 11:17:49 +0000 cgel.zte@gmail.com wrote:

> From: Guo Ziliang <guo.ziliang@zte.com.cn>
> 
> In our testing, a deadloop task was found. Through sysrq printing, same 
> stack was found every time, as follows:
> __swap_duplicate+0x58/0x1a0
> swapcache_prepare+0x24/0x30
> __read_swap_cache_async+0xac/0x220
> read_swap_cache_async+0x58/0xa0
> swapin_readahead+0x24c/0x628
> do_swap_page+0x374/0x8a0
> __handle_mm_fault+0x598/0xd60
> handle_mm_fault+0x114/0x200
> do_page_fault+0x148/0x4d0
> do_translation_fault+0xb0/0xd4
> do_mem_abort+0x50/0xb0
> 
> The reason for the deadloop is that swapcache_prepare() always returns
> EEXIST, indicating that SWAP_HAS_CACHE has not been cleared, so that
> it cannot jump out of the loop. We suspect that the task that clears
> the SWAP_HAS_CACHE flag never gets a chance to run. We try to lower
> the priority of the task stuck in a deadloop so that the task that
> clears the SWAP_HAS_CACHE flag will run. The results show that the
> system returns to normal after the priority is lowered.
> 
> In our testing, multiple real-time tasks are bound to the same core,
> and the task in the deadloop is the highest priority task of the
> core, so the deadloop task cannot be preempted.
> 
> Although cond_resched() is used by __read_swap_cache_async, it is an
> empty function in the preemptive system and cannot achieve the purpose
> of releasing the CPU. A high-priority task cannot release the CPU
> unless preempted by a higher-priority task. But when this task
> is already the highest priority task on this core, other tasks
> will not be able to be scheduled. So we think we should replace
> cond_resched() with schedule_timeout_uninterruptible(1),
> schedule_timeout_interruptible will call set_current_state
> first to set the task state, so the task will be removed
> from the running queue, so as to achieve the purpose of
> giving up the CPU and prevent it from running in kernel
> mode for too long.
> 
> ...
>
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -478,7 +478,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
>  		 * in swap_map, but not yet added its page to swap cache.
>  		 */
> -		cond_resched();
> +		schedule_timeout_uninterruptible(1);
>  	}
>  
>  	/*

Sigh.  I guess yes, we should do this, at least in a short-term,
backportable-to-stable way.

But busy-waiting while hoping that someone else will save us isn't an
attractive design.  Hugh, have you ever thought about something more
deterministic in there?

Thanks.
