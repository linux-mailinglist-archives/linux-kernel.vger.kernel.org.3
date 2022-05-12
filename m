Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04849524397
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbiELDov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiELDor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:44:47 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204849809D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:44:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 204so3671146pfx.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eeIOFs3Zsk1WG7JFtEjA/i1tDZMezk35qDyAeCBM+EM=;
        b=iNK2cXUXdbjPaWYNSzHx/04+0ZNvMnEF4rN/hFqqGZtuMQnRVLAyyJefxqvLZ58UDS
         w7z2F1m1FaSjc11BJ0/97o8mdzA0LllrU2rCOr33EWXk/o+Atx24qV3z3jmZpRZdvO6X
         OjiGnIyyo4/ylfzHV6nt11YpS4Oxs07lP/8/GND2bFOGpszoswCGMwY9fzSASe8n7UXn
         52myBOWyeEEtcWj7DeDlmvyW6Nfo5TkEKLGjVm3CmxBslnTM68yVwG5wL4gOD26KTttT
         ndyw13SKKcSK0SGw+/NRf/bSnLYJjoHCxir+3m3ktijZjuFvLt58rLM5tbSjeXWGpE4y
         Ij8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eeIOFs3Zsk1WG7JFtEjA/i1tDZMezk35qDyAeCBM+EM=;
        b=XBX5a58U2OI4K1sleHwMlAbxie59wOyPNK0CMgZZNGV+7zLcsKLCsrHEH7QRyH5UsW
         0TQZML+0Mv+GajHUhxJ5hTCnF32QM+OeNpIjMVVyaeh6TnC9wR6hT7k+vrfSsdNJQDja
         jx7EaawYqp6JaaXJuSTeMABRkqGpDlZ24yI0wwJvoD77pYKHJf/s6IBNyFG6hfNBh0ah
         9nCrM7ZCJJTHo+Wq1JTHIm4NwduDjwxo1ve8IguTRX4VHoSc7rkLWaCwrZ9BoxojvDHr
         0qd2UKJHynYYOuyNIuh7SIaz7SZjcSfAaZ4Lq7WIEdpxPfwtykKIDBGqmj3dSm52N0z0
         dGFg==
X-Gm-Message-State: AOAM532vW6dCDDEUFbJqirDBdkE2SalyzGeYr+3Q8yZoonoO5M5NYUP9
        BSlWoID7a1c45zUVdASlCUs=
X-Google-Smtp-Source: ABdhPJytajbBH+2uAtUsa+iGiFeqxfpgp8mmGxD7WzklKuzcsgf6JZhrM5deeWHWi6U/CBa40aybdA==
X-Received: by 2002:a63:d30f:0:b0:3db:48a0:c6d8 with SMTP id b15-20020a63d30f000000b003db48a0c6d8mr3434016pgg.93.1652327085542;
        Wed, 11 May 2022 20:44:45 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:69ef:9c87:7816:4f74])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7850b000000b0050dc76281fbsm2469410pfn.213.2022.05.11.20.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:44:44 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 11 May 2022 20:44:43 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <YnyCqwY4DxcZ/NjM@google.com>
References: <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
 <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxczoehQJ+x6m9Y@google.com>
 <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
 <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 07:18:56PM -0700, John Hubbard wrote:
> On 5/11/22 18:08, John Hubbard wrote:
> > On 5/11/22 18:03, Minchan Kim wrote:
> > > > 
> > > > Or there might be some code path that really hates a READ_ONCE() in
> > > > that place.
> > > 
> > > My worry about chaning __get_pfnblock_flags_mask is it's called
> > > multiple hot places in mm codes so I didn't want to add overhead
> > > to them.
> > 
> > ...unless it really does generate the same code as is already there,
> > right? Let me check that real quick.
> > 
> 
> It does change the generated code slightly. I don't know if this will
> affect performance here or not. But just for completeness, here you go:
> 
> free_one_page() originally has this (just showing the changed parts):
> 
>     mov    0x8(%rdx,%rax,8),%rbx
>     and    $0x3f,%ecx
>     shr    %cl,%rbx
>     and    $0x7,
> 
> 
> And after applying this diff:
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0e42038382c1..df1f8e9a294f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -482,7 +482,7 @@ unsigned long __get_pfnblock_flags_mask(const struct
> page *page,
>         word_bitidx = bitidx / BITS_PER_LONG;
>         bitidx &= (BITS_PER_LONG-1);
> 
> -       word = bitmap[word_bitidx];
> +       word = READ_ONCE(bitmap[word_bitidx]);
>         return (word >> bitidx) & mask;
>  }
> 
> 
> ...it now does an extra memory dereference:
> 
>     lea    0x8(%rdx,%rax,8),%rax
>     and    $0x3f,%ecx
>     mov    (%rax),%rbx
>     shr    %cl,%rbx
>     and    $0x7,%ebx
> 

Thanks for checking, John.

I don't want to have the READ_ONCE in __get_pfnblock_flags_mask 
atm even though it's an extra memory dereference for specific
architecutre and specific compiler unless other callsites *do*
need it.

We choose the choice(i.e., having __READ_ONCE in is_pinanble_
page) for *potential* cases(e.g., aggressive LTO for future)
and if it's an extra memory dereference atm, it would be multiple
instructions *potentailly* as having more change or different
compiler and/or arches now or later. It's out of scope in
this patch.
