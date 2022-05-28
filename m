Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B716E536E8F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 23:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiE1VSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 17:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiE1VSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 17:18:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B1EBF55
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:18:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05CB5B8091D
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 21:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B0FC34119;
        Sat, 28 May 2022 21:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653772690;
        bh=bdVK0S6unup8QwUoNJ+TWIngI+wu05UsfjpqzIce53A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lMLT/8zjNL8UW586SsXRgRCzdCRdDW+Pgc7yf5SBDZd8NhO2AxWRrwbG9s6n0bKFz
         nzztLSCvLtnXhPbPy70TgxScg6PtHExb+/ImrzJmXWMGh3OhDMgHQhtOg+ZFZlyk/z
         5+enSryXaJvV3F5j0zL3YHa30Qf/h78R6ehBO9BE=
Date:   Sat, 28 May 2022 14:18:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, michael@michaellarabel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch v5] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
Message-Id: <20220528141809.732788db257253396462c79e@linux-foundation.org>
In-Reply-To: <YmrWK/KoU1zrAxPI@fuller.cnet>
References: <YhUI1wUtV8yguijO@fuller.cnet>
        <YhUKRzEKxMvlGQ5n@fuller.cnet>
        <YiI+a9gTr/UBCf0X@fuller.cnet>
        <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
        <Yin7hDxdt0s/x+fp@fuller.cnet>
        <YkWyLaom/r7jXgbA@zn.tnic>
        <YmrWK/KoU1zrAxPI@fuller.cnet>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 15:00:11 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:

> On Thu, Mar 31, 2022 at 03:52:45PM +0200, Borislav Petkov wrote:
> > On Thu, Mar 10, 2022 at 10:22:12AM -0300, Marcelo Tosatti wrote:
> > > 
> ...
>
> > 
> > Someone pointed me at this:
> > 
> > https://www.phoronix.com/scan.php?page=news_item&px=Linux-518-Stress-NUMA-Goes-Boom
> > 
> > which says this one causes a performance regression with stress-ng's
> > NUMA test...
> 
> Michael,
> 
> This is probably do_migrate_pages that is taking too long due to
> synchronize_rcu().
> 
> Switching to synchronize_rcu_expedited() should probably fix it...
> Can you give it a try, please?

I guess not.

Is anyone else able to demonstrate a stress-ng performance regression
due to ff042f4a9b0508?  And if so, are they able to try Marcelo's
one-liner?

> diff --git a/mm/swap.c b/mm/swap.c
> index bceff0cb559c..04a8bbf9817a 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -879,7 +879,7 @@ void lru_cache_disable(void)
>  	 * lru_disable_count = 0 will have exited the critical
>  	 * section when synchronize_rcu() returns.
>  	 */
> -	synchronize_rcu();
> +	synchronize_rcu_expedited();
>  #ifdef CONFIG_SMP
>  	__lru_add_drain_all(true);
>  #else
> 
> 
