Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2959F233
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiHXDwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiHXDwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:52:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8208491F0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:52:41 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y127so12344003pfy.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=1mJLK6hvchjehsHzEl3FcCuJd52Ags4MhBAkvBSrkO8=;
        b=V+BeboyB52pIWv5vpduP3TvkOHnga0om6vi5F3s495lrnJuoBjUVULAGmQLyDwLdDl
         GTRSmL4+VnRRqPfjqE11cqxzklZWYfwlDrsZt8GpPWrQrEA3TJQL/cfT6BxaSjjQDCVW
         NYXeP6Ak4AEYA0dliJ8FAFzCZcWBGNgHKeRzmqN9SyoOFdkIqbO/+eb4nfzskJo2IyXG
         L4ORtgiC81jxctyH9LqJtHRPkfDKgRrluePFneMaqI4pyvy1BuQKNPdrvDKevcBpKAHX
         4bFM0A0+Ko3WZKDZNLTG0f3PgIdvmFtsgNxxtBBSMdffNoNXY4/Q8e54zCjmN6nPfKcK
         YDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1mJLK6hvchjehsHzEl3FcCuJd52Ags4MhBAkvBSrkO8=;
        b=rtd65GZc9f1kpS4sQnEMHcxhVcCiydz39Bf4R+AnG0OecrMM8iOTvNVF8Q2uuHRQ9/
         ETnhjl9MwdAVH7HZhOuKk6txJq395ZUzk1LkM+uWe2W9Ya1uvxRGu9tvjtA+JOxn1aBu
         fPBr9yJxSLUPBfU5tsVoEswhmX7vnD+Dj5mETxRCfVPfjnZfVcaaVrvJhLuvVXzmTJqb
         qeh6vGqxGYtB2pSwBN1RfApQ4cNZV88SwAIHhMKdhj5N0yk6YJyfx4+lU0Q9+R0z5jfK
         DOGg6B4S5sGkLDzZtKzVUIAm9MGVNLDmTgg0REmkFHn5gwu+U5tgHpwy/6HzurarunQz
         HoFg==
X-Gm-Message-State: ACgBeo3EdenYUvbmTWQAAzlBhy/y3vSOd0WkKe7j3rJCR3GSeW5AhMVC
        kXatQJv5hRl4RgegaAC86QRtHQcgcz8=
X-Google-Smtp-Source: AA6agR7cClUSDCatrPT9FUgvkp/iEkKXYWo4duadMIVvuwxovtg6k3PR/0vMD7RwpYeFoxcctLpTcA==
X-Received: by 2002:a63:204d:0:b0:42a:5e9b:44b6 with SMTP id r13-20020a63204d000000b0042a5e9b44b6mr17366133pgm.372.1661313161070;
        Tue, 23 Aug 2022 20:52:41 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b0016ed20eacd2sm11420310plg.150.2022.08.23.20.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 20:52:39 -0700 (PDT)
Date:   Wed, 24 Aug 2022 12:52:34 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 17/17] mm/sl[au]b: check if large object is valid in
 __ksize()
Message-ID: <YwWggsHYEDFfmsM6@hyeyoo>
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
 <20220817101826.236819-18-42.hyeyoo@gmail.com>
 <66e25026-a86a-0157-3671-cf66eb53964c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66e25026-a86a-0157-3671-cf66eb53964c@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 05:12:01PM +0200, Vlastimil Babka wrote:
> On 8/17/22 12:18, Hyeonggon Yoo wrote:
> > If address of large object is not beginning of folio or size of
> > the folio is too small, it must be invalid. BUG() in such cases.
> > 
> > Cc: Marco Elver <elver@google.com>
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/slab_common.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 9c273a5fb0d7..98d029212682 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -984,8 +984,11 @@ size_t __ksize(const void *object)
> >  
> >  	folio = virt_to_folio(object);
> >  
> > -	if (unlikely(!folio_test_slab(folio)))
> > +	if (unlikely(!folio_test_slab(folio))) {
> > +		BUG_ON(folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE);
> > +		BUG_ON(object != folio_address(folio));
> >  		return folio_size(folio);
> > +	}
> >  
> >  	return slab_ksize(folio_slab(folio)->slab_cache);
> >  }
> 
> In light of latest Linus' rant on BUG_ON() [1] I'm changing it to WARN_ON
> and return 0, as it was in v3.
> 
> [1] https://lore.kernel.org/all/CAHk-=wiEAH+ojSpAgx_Ep=NKPWHU8AdO3V56BXcCsU97oYJ1EA@mail.gmail.com/

Okay. I'm fine with that.

> 
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 98d029212682..a80c3a5e194d 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -985,8 +985,10 @@ size_t __ksize(const void *object)
>  	folio = virt_to_folio(object);
>  
>  	if (unlikely(!folio_test_slab(folio))) {
> -		BUG_ON(folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE);
> -		BUG_ON(object != folio_address(folio));
> +		if (WARN_ON(folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE))
> +			return 0;
> +		if (WARN_ON(object != folio_address(folio)))
> +			return 0;
>  		return folio_size(folio);
>  	}
>  
> 

-- 
Thanks,
Hyeonggon
