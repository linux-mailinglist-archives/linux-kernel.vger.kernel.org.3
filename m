Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A3251BE1C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355396AbiEELhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiEELhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:37:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C5C25C44
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:33:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id r9so3940096pjo.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 04:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kmuFsmMbScXqNpJKevjdoCTx8wEqO5EzwJvGHLtPy5Y=;
        b=TYH0Dyz10TR6mI8byBxOTAE/d4FWaSoLnmjYYE6gNf9TxRn0/7YsDYgoWircT5IP0N
         7Jf4G/6xEWIRlwurNKxK9t7OvbXgxtX6PdCEwWWffrjqnMDX7rdHpb4uUf1P3ybF2Wpt
         ZuWxdOOpvE2Uf8+aUUUl2SGqzsQP3bocH20H5GBdfHwrZlpqHpy6GklQ5jidn2hsZ10h
         76Dov4K3HIN94fEKUEOqxsmQw2KL0OGlSS/Z/umWKEw8tinz3f+4xPxKYLyTksG2H8y8
         IlrZ6vwlR92OTSIeR56kWXSn8v88BaNrFCoHOfnTmlBiD2IeIEWjPU06TxuZLh4IRLOg
         KgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kmuFsmMbScXqNpJKevjdoCTx8wEqO5EzwJvGHLtPy5Y=;
        b=tiQqo4WgtehgAhuQZTgshM7I+ocfOi29Cny4HP/8RMxesU+lYyQhZGwcz+0OCz6Puj
         nLDkwxpt1MtaLGOHfTvNxNXu0MItwsuk60jB/i0AlFpyoRpAfPeTA/mFS7N+oHMPCCjj
         WcEZdMwW03tjDpFQfhz6iEGBb5JISPkMtD66VepqEy98aev/dWbfjGpRlqXzNpXxMKFs
         EaGU9mWsVl4pDjO9O8iNfCUuiT3nUdaiXlHwDc72E9NRWXzYGsvmJLcfLl1cP0c1poCM
         6HMG8S+RtAeh+VdtEttyaTHKe2bX0hQEyGyhjgVlkIqI/4tqBfkkJ+LBe8BGp8qiWwEC
         ihFw==
X-Gm-Message-State: AOAM530Pl6aS+9FCywblz34waOPOLsxKT5+Pig9ljV89riDkI8chzwG0
        SjaN5R5KsobeH4EKJNSPGQsJQXp5jbM=
X-Google-Smtp-Source: ABdhPJzmigFknhavmOH0RXnf30nGm1L9Uv6+t0G3al3oC8qiPS2XWcxMg3ZRyAUvfOD5N/M15+5wXQ==
X-Received: by 2002:a17:903:2d0:b0:14d:8a8d:cb1 with SMTP id s16-20020a17090302d000b0014d8a8d0cb1mr26801364plk.50.1651750422195;
        Thu, 05 May 2022 04:33:42 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a1a0700b001dbf2aac185sm1257143pjk.1.2022.05.05.04.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:33:41 -0700 (PDT)
Date:   Thu, 5 May 2022 20:33:36 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/kfence: reset PG_slab and memcg_data before
 freeing __kfence_pool
Message-ID: <YnO2EIB6LzaBKEvi@hyeyoo>
References: <20220505073920.1880661-1-42.hyeyoo@gmail.com>
 <20220505101337.1997819-1-42.hyeyoo@gmail.com>
 <YnOs2k0REk9428LA@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnOs2k0REk9428LA@FVFYT0MHHV2J.usts.net>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 06:54:18PM +0800, Muchun Song wrote:
> On Thu, May 05, 2022 at 07:13:37PM +0900, Hyeonggon Yoo wrote:
> > When kfence fails to initialize kfence pool, it frees the pool.
> > But it does not reset PG_slab flag and memcg_data of struct page.
> > 
> > Below is a BUG because of this. Let's fix it by resetting PG_slab
> > and memcg_data before free.
> > 
> > [    0.089149] BUG: Bad page state in process swapper/0  pfn:3d8e06
> > [    0.089149] page:ffffea46cf638180 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3d8e06
> > [    0.089150] memcg:ffffffff94a475d1
> > [    0.089150] flags: 0x17ffffc0000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
> > [    0.089151] raw: 0017ffffc0000200 ffffea46cf638188 ffffea46cf638188 0000000000000000
> > [    0.089152] raw: 0000000000000000 0000000000000000 00000000ffffffff ffffffff94a475d1
> > [    0.089152] page dumped because: page still charged to cgroup
> > [    0.089153] Modules linked in:
> > [    0.089153] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B   W         5.18.0-rc1+ #965
> > [    0.089154] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> > [    0.089154] Call Trace:
> > [    0.089155]  <TASK>
> > [    0.089155]  dump_stack_lvl+0x49/0x5f
> > [    0.089157]  dump_stack+0x10/0x12
> > [    0.089158]  bad_page.cold+0x63/0x94
> > [    0.089159]  check_free_page_bad+0x66/0x70
> > [    0.089160]  __free_pages_ok+0x423/0x530
> > [    0.089161]  __free_pages_core+0x8e/0xa0
> > [    0.089162]  memblock_free_pages+0x10/0x12
> > [    0.089164]  memblock_free_late+0x8f/0xb9
> > [    0.089165]  kfence_init+0x68/0x92
> > [    0.089166]  start_kernel+0x789/0x992
> > [    0.089167]  x86_64_start_reservations+0x24/0x26
> > [    0.089168]  x86_64_start_kernel+0xa9/0xaf
> > [    0.089170]  secondary_startup_64_no_verify+0xd5/0xdb
> > [    0.089171]  </TASK>
> > 
> > Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> > Fixes: 8f0b36497303 ("mm: kfence: fix objcgs vector allocation")
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Reviewed-by: Marco Elver <elver@google.com>
> > Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> > 
> > v2 -> v3:
> > 	- Add Reviewed-by: tags from Marco and Muchun. Thanks!
> > 	- Initialize folio where it is defined.
> > 
> >  mm/kfence/core.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > index a203747ad2c0..b7d3a9667f00 100644
> > --- a/mm/kfence/core.c
> > +++ b/mm/kfence/core.c
> > @@ -642,6 +642,14 @@ static bool __init kfence_init_pool_early(void)
> >  	 * fails for the first page, and therefore expect addr==__kfence_pool in
> >  	 * most failure cases.
> >  	 */
> > +	for (char *p = (char *)addr; p < __kfence_pool + KFENCE_POOL_SIZE; p += PAGE_SIZE) {
> > +		struct folio *folio = virt_to_folio(p);
> > +
> 
> After more thinking, I think it is better to use 'struct slab *'
> to define a local variable since we already use this struct
> throughout slab core. What do you think?
>

I think that may not be better.

In the code we're freeing folios (so not going to reuse it again in slab/kfence).
And it may not be Slab depending on why kfence_init_pool() failed.

> Thanks.
> 
> > +		__folio_clear_slab(folio);
> > +#ifdef CONFIG_MEMCG
> > +		folio->memcg_data = 0;
> > +#endif
> > +	}
> >  	memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
> >  	__kfence_pool = NULL;
> >  	return false;
> > -- 
> > 2.32.0
> > 
> > 

-- 
Thanks,
Hyeonggon
