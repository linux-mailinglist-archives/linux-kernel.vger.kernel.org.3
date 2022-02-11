Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D132C4B2387
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbiBKKlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:41:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349277AbiBKKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:41:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD8BDB3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:40:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6896CB828F1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18843C340E9;
        Fri, 11 Feb 2022 10:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644576049;
        bh=GnpbNG9DkJjep49DVx8HI24joSzwMLLTieup5YugTdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUhbWdeEScjiu+LktwI9YVlzovSs5OK4RLBicuIjwtQyKpvlQTPexSM1EOubd9rh4
         XiMC8lfMshUgwwPqkgCtc0T3JOUCvXEf/Owa5tJIE2ljGpQLBouWgTK9Tex/2+UMQa
         vQGlR3RIQxJvIxIpIoGHbUmr4ZDfiWU2Hlb4wPDDRTdyJWC7QUu2lXKIw40iQWV7cW
         iIXojmClz9lxGMOoy6lJgXWBSTpEDrm8/OJDfZxawPQzETANJQsjHjvkTjMoEV5uf/
         58+W6PGF9kZhh70oxZgjaGKT1pbQYmorCx0OVsuIh+XPQ8YqrHFpwHacP/vbClpTsD
         LKOD1eIzfnoYQ==
Date:   Fri, 11 Feb 2022 12:40:37 +0200
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
Subject: Re: [PATCH 46/49] mm/mempolicy: replace nodes_weight with
 nodes_weight_eq
Message-ID: <YgY9JfnA4YX5I/6p@kernel.org>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-47-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224933.379149-47-yury.norov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:49:30PM -0800, Yury Norov wrote:
> do_migrate_pages() calls nodes_weight() to compare the weight
> of nodemask with a given number. We can do it more efficiently with
> nodes_weight_eq() because conditional nodes_weight() may stop
> traversing the nodemask earlier, as soon as condition is (or is not)
> met.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/mempolicy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 7c852793d9e8..56efd00b1b6e 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1154,7 +1154,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
>  			 *          [0-7] - > [3,4,5] moves only 0,1,2,6,7.
>  			 */
>  
> -			if ((nodes_weight(*from) != nodes_weight(*to)) &&
> +			if (!nodes_weight_eq(*from, nodes_weight(*to)) &&
>  						(node_isset(s, *to)))
>  				continue;
>  
> -- 
> 2.32.0
> 
> 

-- 
Sincerely yours,
Mike.
