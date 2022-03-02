Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF794C99E1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 01:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbiCBAd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 19:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiCBAd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 19:33:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47FC9FC0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 16:32:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45F2361506
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F57C340EE;
        Wed,  2 Mar 2022 00:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646181164;
        bh=hsN8LPpCJcyecCitmc0hAjyVwKbdXCBm88fiaaIV8mA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lEyApmR8z17UqqiscwiebeBSFFRYAKrvU0EKctGxXbp7r7bIlM2MAk+iqVfWD8wBZ
         bcnTgw2SSTzytsigv6XSOFo1M9iFUJRHPuFjwBRJbaGHxxO7R6mV6KoA5wwBodfMnk
         Gp6Dw/xpZ2HpkhieTHPXYb8u9ifhDhX7y6Oygdg0=
Date:   Tue, 1 Mar 2022 16:32:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     cgel.zte@gmail.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, rogerq@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        guo.ziliang@zte.com.cn, Zeal Robot <zealci@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH linux-next] mm: swap: get rid of deadloop in swapin
 readahead
Message-Id: <20220301163243.33e8fc82e567512e54a78560@linux-foundation.org>
In-Reply-To: <b2715e40-dc61-1589-de19-ea4c3bd3f674@google.com>
References: <20220221111749.1928222-1-cgel.zte@gmail.com>
        <20220225172440.ec62edf97b405d32061bcb37@linux-foundation.org>
        <b2715e40-dc61-1589-de19-ea4c3bd3f674@google.com>
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

On Mon, 28 Feb 2022 20:07:33 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> > > --- a/mm/swap_state.c
> > > +++ b/mm/swap_state.c
> > > @@ -478,7 +478,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
> > >  		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
> > >  		 * in swap_map, but not yet added its page to swap cache.
> > >  		 */
> > > -		cond_resched();
> > > +		schedule_timeout_uninterruptible(1);
> > >  	}
> > >  
> > >  	/*
> > 
> > Sigh.  I guess yes, we should do this, at least in a short-term,
> > backportable-to-stable way.
> > 
> > But busy-waiting while hoping that someone else will save us isn't an
> > attractive design.  Hugh, have you ever thought about something more
> > deterministic in there?
> 
> Not something more deterministic, no: I think that would entail
> heavier locking, perhaps slowing down hotter paths, just to avoid
> this swap oddity.
> 
> This loop was written long before there was a preemptive kernel:
> it was appropriate then, and almost never needed more than one retry
> to complete; but preemption changed the story without us realizing.
> 
> Sigh here too.  I commend the thread on it from July 2018:
> https://lore.kernel.org/linux-mm/2018072514403228778860@wingtech.com/
> 
> There the 4.9-stable user proposed preempt_disable(), I agreed but
> found the patch provided insufficient, and offered another 4.9 patch
> further down the thread.  Your preference at the time was msleep(1).
> 
> I was working on a similar patch for 4.18, but have not completed it
> yet ;) and don't remember how satisfied or not I was with that one;
> and wonder if I'm any more likely to get it finished by 2026.  It's
> clear that I put much more thought into it back then than just now.
> 
> Maybe someone else would have a go: my 4.9 patch in that thread
> shows most of it, but might need a lot of work to update to 5.17.
> 
> And it also gathered some temporary debug stats on how often this
> happens: I'm not conscious of using RT at all, but was disturbed to see
> how long an ordinary preemptive kernel was sometimes spinning there.
> So I think I agree with you more than Michal on that: RT just makes
> the bad behaviour more obvious.

Thanks as always.

Using msleep() seems pretty pointless so I plan to go ahead with patch
as-is, with a cc:stable.  None of it is pretty, but it's better than
what we have now, yes?

