Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210C25045FA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 04:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiDQCJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 22:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiDQCJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 22:09:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8F731537
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 19:07:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id be5so9898453plb.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 19:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QHd9CQFIYlOCi6fBEm7pnjqFGa8zbI3JTmRYYQX8W44=;
        b=RgOopmUfrgVixcUJfSi6UvD4IxlD5NakuaHEXATlspyZ5Hpb7JkBfT6Uu87pVs0YQK
         4eLP27IXOtAaA3l2QYgfMBjxrOM+s2EMu0WHurykaTf9KocSc4FMrvPxnHEWFpugwxdP
         TsYvWgy0yyph1Q2bFOORkdV+D5CFGU3M9t8y0R+NzCWindZkVoCN2WpSwy7UNGDJ5gaD
         hxfjmeJ6qzuiv61Npd0LT0sAH8IUx3yLep86t/V/m7aHf+yAT8qJOg4KtbZ9eApTHUFz
         +jrjz5uABJ3CJS2yycto49ii2FP4FSotEzsQ42O32H3hB96Iqng4sBvXviLNqFjUrvqU
         KPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QHd9CQFIYlOCi6fBEm7pnjqFGa8zbI3JTmRYYQX8W44=;
        b=CB/monauhd5ikreGnm3derK2KS0nFpOXT+Lj7OiHM8VfTpQxB0ltjVyQXOO8P4a931
         SrxflzRFl9IKY6i5E2vNuGl1iIognDHAfLZo2X1PsfAC1UdKGh4gPnNlxfuK9K8z/bH9
         JiME+DvMN/cf+n4kVdmtodd6QwZc94LijQxQwskVpCZytKkiVLQlGkSQEH6mXKBbRZNL
         wY3QrRkckC71JXxLdxcogpkM5tkytdtm4uYwYcFwqgpD5KB3mR5P1niOXJqaFr11+Vvu
         7t5t7tkWzUcdBxkx2/7ofwfTHWf086+YBpZopIERw3dqlmVSLcUesftft4nziMfM8uIP
         gxaw==
X-Gm-Message-State: AOAM530P21bjyslat8usZTUrBdapaH9JzvlAKMnCGizzvbo6nv1X2hJv
        HHhHGI2WgQjPEKzH4eSVrA0=
X-Google-Smtp-Source: ABdhPJyqQ+TKMVoT2fZeDnbZltdybRQpDs17aA6HMgvlJZOchOADOShcBVERF4ZK5loqxJ5PEWMpFw==
X-Received: by 2002:a17:902:6bc2:b0:158:a26b:5884 with SMTP id m2-20020a1709026bc200b00158a26b5884mr5616991plt.38.1650161233610;
        Sat, 16 Apr 2022 19:07:13 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id y20-20020aa79af4000000b0050832e3caadsm7275065pfp.216.2022.04.16.19.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 19:07:12 -0700 (PDT)
Date:   Sun, 17 Apr 2022 11:07:04 +0900
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
Message-ID: <Ylt2SG4DdtBrb1fq@hyeyoo>
References: <20220416074059.526970-1-vvghjk1234@gmail.com>
 <YltwuNz4N5BKRFDT@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YltwuNz4N5BKRFDT@hyeyoo>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 10:43:20AM +0900, Hyeonggon Yoo wrote:
> On Sat, Apr 16, 2022 at 04:40:59PM +0900, Wonhyuk Yang wrote:
> > To calculate order, calc_slab_order() is called repeatly changing the
> > fract_leftover. Thus, the branch which is not dependent on
> > fract_leftover is executed repeatly. So make it run only once.
> > 
> > Plus, when min_object reached to 0, we set fract_leftover to 1. In
> 
> Maybe you mean when min_object reached 1.
> 
> > this case, we can calculate order by max(slub_min_order,
> > get_order(size)) instead of calling calc_slab_order().
> > 
> > No functional impact expected.
> > Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
> > ---
> > V1 -> V2: Fix typo miss in a commit message
> > 
> >  mm/slub.c | 18 +++++++-----------
> >  1 file changed, 7 insertions(+), 11 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index ed5c2c03a47a..e7a394d7b75a 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3795,9 +3795,6 @@ static inline unsigned int calc_slab_order(unsigned int size,
> >  	unsigned int min_order = slub_min_order;
> >  	unsigned int order;
> >  
> > -	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
> > -		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
> > -
> >  	for (order = max(min_order, (unsigned int)get_order(min_objects * size));
> >  			order <= max_order; order++) {
> >  
> > @@ -3820,6 +3817,11 @@ static inline int calculate_order(unsigned int size)
> >  	unsigned int max_objects;
> >  	unsigned int nr_cpus;
> >  
> > +	if (unlikely(order_objects(slub_min_order, size) > MAX_OBJS_PER_PAGE)) {
> > +		order = get_order(size * MAX_OBJS_PER_PAGE) - 1;
> > +		goto out;
> > +	}
> > +
> >  	/*
> >  	 * Attempt to find best configuration for a slab. This
> >  	 * works by first attempting to generate a layout with
> > @@ -3865,14 +3867,8 @@ static inline int calculate_order(unsigned int size)
> >  	 * We were unable to place multiple objects in a slab. Now
> >  	 * lets see if we can place a single object there.
> >  	 */
> > -	order = calc_slab_order(size, 1, slub_max_order, 1);
> > -	if (order <= slub_max_order)
> > -		return order;
> > -
> > -	/*
> > -	 * Doh this slab cannot be placed using slub_max_order.
> > -	 */
> > -	order = calc_slab_order(size, 1, MAX_ORDER, 1);
> > +	order = max_t(unsigned int, slub_min_order, (unsigned int)get_order(size));
> > +out:
> 
> You don't need to cast value of get_order(size). max_t() does cast both operands.
> 
> >  	if (order < MAX_ORDER)
> >  		return order;
> >  	return -ENOSYS;
> 
> For the correctness of the patch, I don't see any problem about the
> code.
> 
> But to be honest I'm a bit skeptical about saving some cycles in
> calculating slab order. It's done only when creating caches (usually in boot
> process).

But yeah, maybe it's worth for better maintenance of code.

So after considering my comments, feel free to add:
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> > -- 
> > 2.30.2
> > 
> > 
> 
> -- 
> Thanks,
> Hyeonggon

-- 
Thanks,
Hyeonggon
