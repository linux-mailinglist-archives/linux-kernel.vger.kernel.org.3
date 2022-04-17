Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C5A5045F2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 03:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiDQBqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 21:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiDQBqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 21:46:06 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B372B1EC66
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 18:43:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso4352865pjj.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 18:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YGLhajMrQZ0HNv4gi0NLxOpmUqsJjdy2hqp78V6xiwY=;
        b=g//V0jscMI2Iyi2QAQ+PFI2DZw+WBUeb1QJwsZJbLNu7fgV9Th/w+uwsLB5E7zAhI9
         yygUNRHTbNBt9yDOep7SnjvKtg6Cxe0AqZfDkAQyNJeICjR9ZhWWkbLaLap1N3oSdA/+
         O1bkxjJuTmaRSzucphnqxJfqfZPkKUmiLat/pdTy+TTaI5ej/z60OJI8OcDXAFiElWhl
         jDaXE0XACzc4ZlmZ0S1/90AjwKDyiGbelicBz08DAlgQGBbDIblDSU5uQ4w3i4/k9OCq
         E5UrugBJ8OSw5OOfy2KSzL6fZaWqLXeMY6JwXoVK8HdYmbUsovmdAzpTn9CYOWrfzEFj
         NLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YGLhajMrQZ0HNv4gi0NLxOpmUqsJjdy2hqp78V6xiwY=;
        b=FDYLbDPGSXqqYKnMy720xwSNlvO3X8iG2PQR1kVOrs14KcRA+ny2j07+yPV9VdeIVr
         zVyOqJ7DHPNMyi0equN+AsEMAAag/djpKXsKbS+FwsxNS94wma2KVfntfBkpwMeLeL3N
         GpJtVwhDVPT+1DVsHADAC+AK5ZrJ6NIPm57Q9lXxcA2h7IbzaxBbDwMPDHlk4OFcZiXy
         tCMmymFnsv5YjmJDG7xcEdauHnwHLhVkaPveplzjKX8nWBsBSRswjr6SMT5s58UY0x7Z
         NVRiNc0v5ZMUldu/eQ7ya520G6Qy0KkRWpHOUpZVxwOCWeNinSKRAle2rz+6KhoH59cw
         iYTA==
X-Gm-Message-State: AOAM532QoDLNgfWp+AK1QSPXbqsMwFRbw9r/gNE8VxG1Ag+Az7O/apQD
        eJ+6SdqnXOSG7UGoXfTIodg=
X-Google-Smtp-Source: ABdhPJyOwejMu2zDtBa0GmDs8EK961A5N3tydC83+EkD4XBsRu3AhBC5J/Bj8v/SxRY99nVJptNTtg==
X-Received: by 2002:a17:902:ea0a:b0:158:acff:ff89 with SMTP id s10-20020a170902ea0a00b00158acffff89mr5593131plg.88.1650159810180;
        Sat, 16 Apr 2022 18:43:30 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78399000000b00505f75651e7sm7049105pfm.158.2022.04.16.18.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 18:43:28 -0700 (PDT)
Date:   Sun, 17 Apr 2022 10:43:20 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/slub: Remove repeated action in calculate_order()
Message-ID: <YltwuNz4N5BKRFDT@hyeyoo>
References: <20220416074059.526970-1-vvghjk1234@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416074059.526970-1-vvghjk1234@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2022 at 04:40:59PM +0900, Wonhyuk Yang wrote:
> To calculate order, calc_slab_order() is called repeatly changing the
> fract_leftover. Thus, the branch which is not dependent on
> fract_leftover is executed repeatly. So make it run only once.
> 
> Plus, when min_object reached to 0, we set fract_leftover to 1. In

Maybe you mean when min_object reached 1.

> this case, we can calculate order by max(slub_min_order,
> get_order(size)) instead of calling calc_slab_order().
> 
> No functional impact expected.
> Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
> ---
> V1 -> V2: Fix typo miss in a commit message
> 
>  mm/slub.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ed5c2c03a47a..e7a394d7b75a 100644
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
> +	order = max_t(unsigned int, slub_min_order, (unsigned int)get_order(size));
> +out:

You don't need to cast value of get_order(size). max_t() does cast both operands.

>  	if (order < MAX_ORDER)
>  		return order;
>  	return -ENOSYS;

For the correctness of the patch, I don't see any problem about the
code.

But to be honest I'm a bit skeptical about saving some cycles in
calculating slab order. It's done only when creating caches (usually in boot
process).

> -- 
> 2.30.2
> 
> 

-- 
Thanks,
Hyeonggon
