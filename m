Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E105449BDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiAYVGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiAYVGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:06:20 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409F3C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:06:20 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y17so10194426plg.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WPDtSBJktDbv4eAC/x0jLV8l6Q6L/WIY+zqIPINFKvA=;
        b=XkeIKkTwAYYHbvql2pSI88YuuMaJcTZKhmTnKhGh8vuwECNv4jN36Wzk0IDE/w7RAp
         J6zHY/7zITPOA++MFEuvK9ESFJW1PqXnQLexNJIvqybRp/ivjuCDWWGM1BKjOXa0iRC9
         Vv4qScYyqXm/HcnguyMwz5nLC/sU8thZakOKUGd/BVjyoxSj/qJyGkYY2YH02erPAjcf
         FyWebAfguY+29gVGtmlseVYfOAO4bOeuKIB/oP3Sm5J5q3KLHEbYfdfduaQVt5F24zTa
         kC0RhsTlU098RyrLsovW3Lb+FiSI3B6lAsDiVGTUcZNJJ9wR/T9bJtzRds051Py3c0sY
         qjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WPDtSBJktDbv4eAC/x0jLV8l6Q6L/WIY+zqIPINFKvA=;
        b=ZyHcOAhTKWcrrZER+kbTenSsTlnEOH0ER/xRZkHJ57qJN35RyNGZXzD+PtuhvSpEVY
         4bQKaJGNgPwRhFrj6QnaQUg9nGBTcCDq4rXcc4MsNmifnKn260KOz/vr/KgU+u+Vk7j/
         BCawsdOJENzpYoKlIbbS5r68DDxdz4nRwgMnM0UTV1LTkRRLu/SIU9Bm0oWwcHgkhc+k
         9crnQBZPKQ/Xn2rKY8QrYmmtjzJgf8e2yidVKcC/hpFJ07DuirNfQHMVY/bp3PFnc8s7
         sg58GxeXV7T2jaXQOgii7LgpCOQ4tlnFDRVTH8D1NOSsQZBTpxuitukOBeWIjH6Rpf9j
         W1Cg==
X-Gm-Message-State: AOAM531VgiFQK0LXkfBSyrXis0xnUJpGiKkOyAut1z/V9j17qEPjuM78
        AbiriqDXyCsIohRBnszFAcFb5F/E3hY=
X-Google-Smtp-Source: ABdhPJxIlbzYrgef5H0QNhsFgTamCDKhB6YR+2vbJzqxpBxsmza4tjRqDld1/5iAcZVJ0lTc4dgndg==
X-Received: by 2002:a17:90b:1a87:: with SMTP id ng7mr5478959pjb.233.1643144779536;
        Tue, 25 Jan 2022 13:06:19 -0800 (PST)
Received: from google.com ([2620:15c:211:201:23a4:12ed:4652:dade])
        by smtp.gmail.com with ESMTPSA id j8sm22080994pfc.127.2022.01.25.13.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 13:06:19 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 25 Jan 2022 13:06:17 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RESEND][PATCH v2] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <YfBmSaMa826ZhFT4@google.com>
References: <YedXhpwURNTkW1Z3@google.com>
 <YefX1t4owjlx/m5I@dhcp22.suse.cz>
 <YejkUlnnYeED1pC5@google.com>
 <YekcNmBqcpO9BYWv@dhcp22.suse.cz>
 <YenPK/JVNOhbxjtr@google.com>
 <YeqEBAKJ6NUjLQhr@dhcp22.suse.cz>
 <YessDywpsnCyrfIy@google.com>
 <Ye54ELlNBpeHoXsj@dhcp22.suse.cz>
 <Ye8mi80ObVZvLdS1@google.com>
 <Ye/Bgc1bH979cXwy@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye/Bgc1bH979cXwy@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:23:13AM +0100, Michal Hocko wrote:
> On Mon 24-01-22 14:22:03, Minchan Kim wrote:
> [...]
> >  CPU 0                               CPU 1
> > 
> >  lru_cache_disable                  lru_cache_disable
> >    ret = atomic_inc_return;(ret = 1)
> >                                      
> >                                     ret = atomic_inc_return;(ret = 2)
> >                                     
> >    lru_add_drain_all(true);         
> >                                     lru_add_drain_all(false)
> >                                     mutex_lock() is holding
> >    mutex_lock() is waiting
> > 
> >                                     IPI with !force_all_cpus
> >                                     ...
> >                                     ...
> >                                     IPI done but it skipped some CPUs
> >                
> >      ..
> >      ..
> >  
> > 
> > Thus, lru_cache_disable on CPU 1 doesn't run with every CPUs so it
> > introduces race of lru_disable_count so some pages on cores
> > which didn't run the IPI could accept upcoming pages into per-cpu
> > cache.
> 
> Yes, that is certainly possible but the question is whether it really
> matters all that much. The race would require also another racer to be
> adding a page to an _empty_ pcp list at the same time.
> 
> pagevec_add_and_need_flush
>   1) pagevec_add # add to pcp list
>   2) lru_cache_disabled
>     atomic_read(lru_disable_count) = 0
>   # no flush but the page is on pcp
> 
> There is no strong memory ordering between 1 and 2 and that is why we
> need an IPI to enforce it in general IIRC.

Correct.

> 
> But lru_cache_disable is not a strong synchronization primitive. It aims
> at providing a best effort means to reduce false positives, right? IMHO

Nope. d479960e44f27, mm: disable LRU pagevec during the migration temporarily

Originally, it was designed to close the race fundamentally.

> it doesn't make much sense to aim for perfection because all users of
> this interface already have to live with temporary failures and pcp
> caches is not the only reason to fail - e.g. short lived page pins.

short lived pages are true but that doesn't mean we need to make the
allocation faster. As I mentioned, the IPI takes up to hundreds
milliseconds easily once CPUs are fully booked. If we reduce the
cost, we could spend the time more productive works. I am working
on making CMA more determinstic and this patch is one of parts.

> 
> That being said, I would rather live with a best effort and simpler
> implementation approach rather than aim for perfection in this case.
> The scheme is already quite complex and another lock in the mix doesn't

lru_add_drain_all already hides the whole complexity inside and
lru_cache_disable adds A simple synchroniztion to keep ordering
on top of it. That's natural SW stack and I don't see too complication
here.

> make it any easier to follow. If others believe that another lock makes

Disagree. lru_cache_disable is designed to guarantee closing the race
you are opening again so the other code in allocator since disabling
per-cpu cache doesn't need to consider the race at all. It's more
simple/deterministic and we could make other stuff based on it(e.g.,
zone->pcp). 

> the implementation more straightforward I will not object but I would go
> with the following.
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index ae8d56848602..c140c3743b9e 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -922,7 +922,8 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
>   */
>  void lru_cache_disable(void)
>  {
> -	atomic_inc(&lru_disable_count);
> +	int count = atomic_inc_return(&lru_disable_count);
> +
>  #ifdef CONFIG_SMP
>  	/*
>  	 * lru_add_drain_all in the force mode will schedule draining on
> @@ -931,8 +932,28 @@ void lru_cache_disable(void)
>  	 * The atomic operation doesn't need to have stronger ordering
>  	 * requirements because that is enforeced by the scheduling
>  	 * guarantees.
> +	 * Please note that there is a potential for a race condition:
> +	 * CPU0				CPU1			CPU2
> +	 * pagevec_add_and_need_flush
> +	 *   pagevec_add # to the empty list
> +	 *   lru_cache_disabled
> +	 *     atomic_read # 0
> +	 *   				lru_cache_disable	lru_cache_disable
> +	 *				  atomic_inc_return (1)
> +	 *				  			  atomic_inc_return (2)
> +	 *				  __lru_add_drain_all(true)
> +	 *				  			  __lru_add_drain_all(false)
> +	 *				  			    mutex_lock
> +	 *				    mutex_lock
> +	 *				    			    # skip cpu0 (pagevec_add not visible yet)
> +	 *				    			    mutex_unlock
> +	 *				    			 # fail because of pcp(0) pin
> +	 *				    queue_work_on(0)
> +	 *
> +	 * but the scheme is a best effort and the above race quite unlikely
> +	 * to matter in real life.
>  	 */
> -	__lru_add_drain_all(true);
> +	__lru_add_drain_all(count == 1);
>  #else
>  	lru_add_and_bh_lrus_drain();
>  #endif
> -- 
> Michal Hocko
> SUSE Labs
