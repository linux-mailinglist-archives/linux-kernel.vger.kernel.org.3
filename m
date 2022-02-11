Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5FD4B238E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349258AbiBKKkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:40:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349283AbiBKKkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:40:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC4625F5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:40:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18E3DB82950
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691E5C340E9;
        Fri, 11 Feb 2022 10:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644575997;
        bh=epNf5a++0MNgic0Ddcu/sWPTzxUU2JKWCnmcuxoxMf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+KwGIaahMH2W44YXM1ZixMDEUJhV/OA0A8G7KY/XfL25XNoO3eKDus9SOUQ1B/t7
         crRIGCn6FcuE65Aje7whQbuaV8+DSDf29hbNQ0reHb8t44EVkwcrxJVDJUdCqpl29f
         z+oIOHQVcS1n8BLoiOzD7/2q/JAyrdQR7oNO12BzYbmVsrILmZabtajLmesKci4bbJ
         wNGQ6ddv2E7bn//wLkPs4nddZEWCK1+t991DOay9gJgwaSGgApmb/mHYT4WsZgmlS9
         2KzDFW+0W+SXmJZpoQbdso+TEkaT8rJXlyD8linQbvq1xoIbWWpneIHWqlFw7d9k3N
         OYuBUQbic/CBw==
Date:   Fri, 11 Feb 2022 12:39:47 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 24/49] mm/vmstat: replace cpumask_weight with
 cpumask_empty where appropriate
Message-ID: <YgY88xvaXsA/CUTp@kernel.org>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-25-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224933.379149-25-yury.norov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:49:08PM -0800, Yury Norov wrote:
> mm/vmstat.c code calls cpumask_weight() to check if any bit of a given
> cpumask is set. We can do it more efficiently with cpumask_empty() because
> cpumask_empty() stops traversing the cpumask as soon as it finds first set
> bit, while cpumask_weight() counts all bits unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/vmstat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index d5cc8d739fac..27a94afd4ee5 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -2041,7 +2041,7 @@ static void __init init_cpu_node_state(void)
>  	int node;
>  
>  	for_each_online_node(node) {
> -		if (cpumask_weight(cpumask_of_node(node)) > 0)
> +		if (!cpumask_empty(cpumask_of_node(node)))
>  			node_set_state(node, N_CPU);
>  	}
>  }
> @@ -2068,7 +2068,7 @@ static int vmstat_cpu_dead(unsigned int cpu)
>  
>  	refresh_zone_stat_thresholds();
>  	node_cpus = cpumask_of_node(node);
> -	if (cpumask_weight(node_cpus) > 0)
> +	if (!cpumask_empty(node_cpus))
>  		return 0;
>  
>  	node_clear_state(node, N_CPU);
> -- 
> 2.32.0
> 
> 

-- 
Sincerely yours,
Mike.
