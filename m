Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1829C571322
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiGLHbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGLHbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 122089823A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657611074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JdO5MxAzmVOyjgWnn1pQedaEsg1HdPJj3a1oJOO8q64=;
        b=JbtPsR71iqyPBrbbkf871/FxBajXvobX7r2J0WEifnEvqrZ8d+1f4zcdGwve5QnoDpQhz0
        aQLVNXOmBVU0Xt6qUPW40kQtAZ2JxhKSljFMCmu6Cf0l/Y8OlH9fmhnfPy3ugeqTk29cPz
        aQGCJcZ+lpDac8BttHEU6QZHDoBG/vo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-LoL4Sf0hO-Odt3d2-l7Aeg-1; Tue, 12 Jul 2022 03:31:11 -0400
X-MC-Unique: LoL4Sf0hO-Odt3d2-l7Aeg-1
Received: by mail-wr1-f69.google.com with SMTP id o1-20020adfba01000000b0021b90bd28d2so1136068wrg.14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=JdO5MxAzmVOyjgWnn1pQedaEsg1HdPJj3a1oJOO8q64=;
        b=d+7USC48X2N8tKtDxlKFyBNrKADYtg8XZZ8FpoSA/IdBy4tH3XZhblBqXMl+zCFwx7
         Zqj36uit49r8kOMwVZIJ7EfIpA/N+4MlNjfhpftktAWhqfYY7FdCH5OJ5kY8fu2fJ5Fu
         y0gzhGqx2R1zxOnOh7BHGENKANNjPb+iMXJdFQylHCKl/PtHKsvcLFOzVYlPghXjBjwV
         dHPTu0e+GnQ+HTGDDOzTvlJLrfus0G/p73Wwek4SP/MSjIjxTumx7AwfJvuodBVyA6TX
         Eh81T6uztfJrK6sDtlui05bVCyZorWY71ciB6/Zu7u/9UFegD90bZ6j+KgM7dmMRI/ME
         9Log==
X-Gm-Message-State: AJIora+aPPQFmH7D1q8EQrwXF5f3DLn5Umkc18HOCr4oRJPlHHmafVxP
        M7EYac2VF2AbkIfBt7Tlkfqk/SwuSLJMwtHKDz2DH5KxOZpGawUYzvZQpH7LtmcGiybXwnvvm2D
        vXt+Zl63vfJYW+HecyXubH7Cf
X-Received: by 2002:a05:600c:15c7:b0:3a2:dd5d:2514 with SMTP id v7-20020a05600c15c700b003a2dd5d2514mr2325571wmf.31.1657611069945;
        Tue, 12 Jul 2022 00:31:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tMaOvFB7ntQolPpHbs5LGtj2RVU3jED0+l76qVjzoYSHfm86bII08rLZtbYEYslh2Mv1KxIg==
X-Received: by 2002:a05:600c:15c7:b0:3a2:dd5d:2514 with SMTP id v7-20020a05600c15c700b003a2dd5d2514mr2325544wmf.31.1657611069642;
        Tue, 12 Jul 2022 00:31:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d900:a75d:cddc:d29f:bdb3? (p200300cbc703d900a75dcddcd29fbdb3.dip0.t-ipconnect.de. [2003:cb:c703:d900:a75d:cddc:d29f:bdb3])
        by smtp.gmail.com with ESMTPSA id c9-20020adfed89000000b0021d9233e7e6sm9127869wro.54.2022.07.12.00.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:31:09 -0700 (PDT)
Message-ID: <4cf14bde-fb4c-99d9-58ce-a788a700d5f3@redhat.com>
Date:   Tue, 12 Jul 2022 09:31:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Li Chen <me@linux.beauty>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Chen <lchen@ambarella.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20220711122459.13773-1-me@linux.beauty>
 <20220711122459.13773-3-me@linux.beauty>
 <c2d4c6ac-fad7-d5b3-8cbf-f62a7db5b998@redhat.com>
 <181f0a5f2a5.cf94ce78513585.4158910057206462182@linux.beauty>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/4] mm/sparse: skip no-map memblock check when
 fill_subsection_map
In-Reply-To: <181f0a5f2a5.cf94ce78513585.4158910057206462182@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.22 06:23, Li Chen wrote:
> Hi David,
>  ---- On Mon, 11 Jul 2022 22:53:36 +0800  David Hildenbrand <david@redhat.com> wrote --- 
>  > On 11.07.22 14:24, Li Chen wrote:
>  > > From: Li Chen <lchen@ambarella.com>
>  > > 
>  > > When mhp use sparse_add_section, don't check no-map region,
>  > > so that to allow no-map reserved memory to get struct page
>  > > support.
>  > > 
>  > > Signed-off-by: Li Chen <lchen@ambarella.com>
>  > > Change-Id: I0d2673cec1b66adf695251037a00c240976b226f
>  > > ---
>  > >  mm/sparse.c | 4 +++-
>  > >  1 file changed, 3 insertions(+), 1 deletion(-)
>  > > 
>  > > diff --git a/mm/sparse.c b/mm/sparse.c
>  > > index 120bc8ea5293..a29cd1e7014f 100644
>  > > --- a/mm/sparse.c
>  > > +++ b/mm/sparse.c
>  > > @@ -690,7 +690,9 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  > >  
>  > >      if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
>  > >          rc = -EINVAL;
>  > > -    else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
>  > > +    else if (memblock_is_map_memory(PFN_PHYS(pfn)) &&
>  > > +         bitmap_intersects(map, subsection_map,
>  > > +                   SUBSECTIONS_PER_SECTION))
>  > >          rc = -EEXIST;
>  > >      else
>  > >          bitmap_or(subsection_map, map, subsection_map,
>  > 
>  > I'm not sure I follow completely what you are trying to achieve. But if
>  > you have to add memblock hacks into mm/sparse.c you're most probably
>  > doing something wrong.
>  > 
>  > Please explain why that change is necessary, and why it is safe.
> 
> In the current sparse memory model, free_area_init will insert all memblock.memory into subsection_map and no-map rmem is also a 
> memblock.memory. So, without this change, fill_subsection_map will return -EEXIST.
> 
> I would say it's not a good idea to insert no-map memblock into subsection_map, and I have no idea why sparse do this.
> So, I simply skip no-map region here.

The thing is:

if the subsection map is set, then there already *is* a memmap and you
would simply be ignoring it (and overwriting a memmap in e.g.,
ZONE_NORMAL to be in ZONE_DEVICE suddenly, which is wrong).


Reading memblock_mark_nomap():

"The memory regions marked with %MEMBLOCK_NOMAP will not be added to the
direct mapping of the physical memory. These regions will still be
covered by the memory map. The struct page representing NOMAP memory
frames in the memory map will be PageReserved()"


So having a memmap for these ranges is expected, and a direct map is not
desired. What you propose is a hack. You either have to reuse the
existing memmap (which is !ZONE_DEVICE -- not sure if that's a problem)
or we'd have to look into teaching init code to not allocate a memmap
for sub-sections that are fully nomap.

But not sure who depends on the existing memmap for nomap memory.

> 
> As for safety:
> 1. The caller of fill_subsection_map are mhp and *_memremap_pages functions, no-map regions are not related to them, so existing codes won't be broken.
> 2. This change doesn't change memblock and subsection_map.
> 

Sorry, but AFAIKT it's a hack and we need a clean way to deal with nomap
memory that already has a memmap instead.


-- 
Thanks,

David / dhildenb

