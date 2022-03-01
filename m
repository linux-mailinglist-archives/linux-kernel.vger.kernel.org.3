Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ACD4C81EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiCAEIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiCAEIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:08:34 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386A413D0C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:07:51 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id t21so12104339qkg.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ATs+2zvlcUXwoOfc2+8pBh5llMbfalOtn8fz/EX5EGc=;
        b=mIs4rbZH8g7HLklLXX9y95CN8lgS3GadmtId2UZY5I0/bipf9HtA0LJpRg2lbfWZRl
         GW8hXP1xQGsw8pG2JmuZSD4ZHk+R22EC6C3ZAtY3LMc7133UpaVmEBRAhD4zbZTpDVp2
         wKAK7ilDsvlZsquKmDdOAtMjcd77UCrnvyZs1ztYwk74gcKEdEf2keRPEhT+Atq6vowX
         e4dOHD8I3VHm/Jlh53e8mW6q1n1/716mp6QJmyCFzq4QnP1PuI+Px/Rh51tysQbxMU2h
         9U+JGxIIb5Z696VeXCEM6afXHLY6zmNFPpjdEDzugW3HKtxLuSuvtEdoVOl0UXkR4LmJ
         VgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ATs+2zvlcUXwoOfc2+8pBh5llMbfalOtn8fz/EX5EGc=;
        b=xUcFFMqDZr8S4/s8WhuG09aRu5Pi2iv44uz/IEQw+wpR5Edf+eVxr4kBgvsnlvdMRb
         4tz40k9WO3kDXm0D7D2eqzBnyKknS6T6xgZ+GkjOMGHLyyBw8JGTFjdYnATrbLaIoWWC
         lNkD9tFM8QeaKr9tQHX03nXKQ1toO3O5z8UyCEnh8xhVnOeuQxOBoHh1RDhrb9Qp7pbV
         uLdXONbJKVoPE2eD9E8kl2/cp2XmzJ0P4NF7DRQieyTAky/im7MW7kuR/i0Kml1iFXCC
         GFNNRnk2QaBZ+qWOlxDoAEhzzG3Gut0Qz6vBjgoBFUIo/PBk6HeeTNEDKZ8noQ7TZL+K
         Lk/A==
X-Gm-Message-State: AOAM532zDPwtBDL6gF84Tmt7qfiP1ENoATDU0YChdCZaf8N5QvovCd6c
        wiHWq8s1kB533prOuw/wmNmEYA==
X-Google-Smtp-Source: ABdhPJyd/fRFEvf6DOsvS0K7H8Fsy6UPyM5KbguSJGGNP2uukSSxaFyONQ5GLew9JibxDb9zTK4uyg==
X-Received: by 2002:a05:620a:14b7:b0:62c:df91:7798 with SMTP id x23-20020a05620a14b700b0062cdf917798mr12916967qkj.445.1646107670157;
        Mon, 28 Feb 2022 20:07:50 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 23-20020a370a17000000b00479cd6a3e61sm5912788qkk.113.2022.02.28.20.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 20:07:49 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:07:33 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     cgel.zte@gmail.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, rogerq@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        guo.ziliang@zte.com.cn, Zeal Robot <zealci@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH linux-next] mm: swap: get rid of deadloop in swapin
 readahead
In-Reply-To: <20220225172440.ec62edf97b405d32061bcb37@linux-foundation.org>
Message-ID: <b2715e40-dc61-1589-de19-ea4c3bd3f674@google.com>
References: <20220221111749.1928222-1-cgel.zte@gmail.com> <20220225172440.ec62edf97b405d32061bcb37@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022, Andrew Morton wrote:
> On Mon, 21 Feb 2022 11:17:49 +0000 cgel.zte@gmail.com wrote:
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
> > 
> > ...
> >
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -478,7 +478,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
> >  		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
> >  		 * in swap_map, but not yet added its page to swap cache.
> >  		 */
> > -		cond_resched();
> > +		schedule_timeout_uninterruptible(1);
> >  	}
> >  
> >  	/*
> 
> Sigh.  I guess yes, we should do this, at least in a short-term,
> backportable-to-stable way.
> 
> But busy-waiting while hoping that someone else will save us isn't an
> attractive design.  Hugh, have you ever thought about something more
> deterministic in there?

Not something more deterministic, no: I think that would entail
heavier locking, perhaps slowing down hotter paths, just to avoid
this swap oddity.

This loop was written long before there was a preemptive kernel:
it was appropriate then, and almost never needed more than one retry
to complete; but preemption changed the story without us realizing.

Sigh here too.  I commend the thread on it from July 2018:
https://lore.kernel.org/linux-mm/2018072514403228778860@wingtech.com/

There the 4.9-stable user proposed preempt_disable(), I agreed but
found the patch provided insufficient, and offered another 4.9 patch
further down the thread.  Your preference at the time was msleep(1).

I was working on a similar patch for 4.18, but have not completed it
yet ;) and don't remember how satisfied or not I was with that one;
and wonder if I'm any more likely to get it finished by 2026.  It's
clear that I put much more thought into it back then than just now.

Maybe someone else would have a go: my 4.9 patch in that thread
shows most of it, but might need a lot of work to update to 5.17.

And it also gathered some temporary debug stats on how often this
happens: I'm not conscious of using RT at all, but was disturbed to see
how long an ordinary preemptive kernel was sometimes spinning there.
So I think I agree with you more than Michal on that: RT just makes
the bad behaviour more obvious.

Hugh
