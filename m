Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E3A516DCE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384393AbiEBKEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384346AbiEBKEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:04:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17BC2645
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:00:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 33C57210E5;
        Mon,  2 May 2022 10:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651485645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTKK1xDtnmXAYeBi+dPbi8yteaHw0P2nDeN1SBWNaj0=;
        b=MgkEFVOILNEsJGU7lV+W1Duv+D56s8qcIPD4uiurhbUaI/fFhxuJSLbeXuUPNPmp3T3LwB
        R8LwQ+czdbKNkckdwJ54YxfupZX0dszqy2x2mwyobcMoRGhMdLOwgVeXLBw9NYfsakApZx
        MF9gYw0I7LGB3sNLonS1iTGeVvrNLko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651485645;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTKK1xDtnmXAYeBi+dPbi8yteaHw0P2nDeN1SBWNaj0=;
        b=Nj3KJAWkFC19kauBWwlkVq6mk+bTmGIo7dy42UvYuLm4H1AizBwqdlXYcPuTlnjyD92aF5
        MrexEt86CBj5ENCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10CF513491;
        Mon,  2 May 2022 10:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xXQUA82rb2J9NgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 02 May 2022 10:00:45 +0000
Message-ID: <49b0d611-e116-c78d-cf14-6d5f96ae500e@suse.cz>
Date:   Mon, 2 May 2022 12:00:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Wonhyuk Yang <vvghjk1234@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220430002555.3881-1-vvghjk1234@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Patch v3] mm/slub: Remove repeated action in calculate_order()
In-Reply-To: <20220430002555.3881-1-vvghjk1234@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/22 02:25, Wonhyuk Yang wrote:
> To calculate order, calc_slab_order() is called repeatly changing the
> fract_leftover. Thus, the branch which is not dependent on
> fract_leftover is executed repeatly. So make it run only once.
> 
> Plus, when min_object reached to 1, we set fract_leftover to 1. In
> this case, we can calculate order by max(slub_min_order,
> get_order(size)) instead of calling calc_slab_order().
> 
> No functional impact expected.
> 
> Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
> 
>  mm/slub.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ed5c2c03a47a..1fe4d62b72b8 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3795,9 +3795,6 @@ static inline unsigned int calc_slab_order(unsigned int size,
>  	unsigned int min_order = slub_min_order;
>  	unsigned int order;
>  
> -	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
> -		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
> -
>  	for (order = max(min_order, (unsigned int)get_order(min_objects * size));
>  			order <= max_order; order++) {
>  
> @@ -3820,6 +3817,11 @@ static inline int calculate_order(unsigned int size)
>  	unsigned int max_objects;
>  	unsigned int nr_cpus;
>  
> +	if (unlikely(order_objects(slub_min_order, size) > MAX_OBJS_PER_PAGE)) {
> +		order = get_order(size * MAX_OBJS_PER_PAGE) - 1;
> +		goto out;
> +	}

Hm interestingly, both before and after your patch, MAX_OBJS_PER_PAGE might
be theoretically overflowed not by slub_min_order, but then with higher
orders. Seems to be prevented only as a side-effect of fragmentation close
to none, thus higher orders not attempted. Would be maybe less confusing to
check that explicitly. Even if that's wasteful, but this is not really perf
critical code.

> +
>  	/*
>  	 * Attempt to find best configuration for a slab. This
>  	 * works by first attempting to generate a layout with
> @@ -3865,14 +3867,8 @@ static inline int calculate_order(unsigned int size)
>  	 * We were unable to place multiple objects in a slab. Now
>  	 * lets see if we can place a single object there.
>  	 */
> -	order = calc_slab_order(size, 1, slub_max_order, 1);
> -	if (order <= slub_max_order)
> -		return order;
> -
> -	/*
> -	 * Doh this slab cannot be placed using slub_max_order.
> -	 */
> -	order = calc_slab_order(size, 1, MAX_ORDER, 1);
> +	order = max_t(unsigned int, slub_min_order, get_order(size));

If we failed to assign order above, then AFAICS it means even slub_min_order
will not give us more than 1 object per slub. Thus it doesn't make sense to
use it in a max() formula, and we can just se get_order(), no?

> +out:
>  	if (order < MAX_ORDER)
>  		return order;
>  	return -ENOSYS;

