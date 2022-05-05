Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC1651BD8D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356257AbiEEK6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiEEK6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:58:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292225373E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:54:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so7701724pjq.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0goD14Q1e/CsgbECNnLR7yDE1KrrNCX6z5lnWWhtC+8=;
        b=zHk/g7TJ6/WF8TlubpawAkRyttxAK4JOj/oucV1uu/VJt3BWVNbj/am/Ee5e+YmrIF
         ZUu7WPyc/uGl95YsITpFgvBYMu4kUAPGHRu/nrGbvOH7Rhgf8L5YqmnzEI4wjTFBnpIp
         W7J2rjOQ1Bbe/VijvOMAHx+3my5uxQlJDzXhlGV9A1bUyzxL+iTfqVeKNL/Hl7xWWTUj
         ITgr0XOepz0AqJKWZn7WmkQk/YkUglEHSqbplJ49QZ1jPIPr5tw2pHO0J8hy+Kc42U+K
         0/pxA0szWAdevPNGnjUljmrkE7UQKOpZkae5GZAGqcQ/nVpzfn/CF3rWFhUeJhR3C/04
         qnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0goD14Q1e/CsgbECNnLR7yDE1KrrNCX6z5lnWWhtC+8=;
        b=BhaidutWzKHh8IlKcScDjsQ7JSbXMBbDxXxqtwRmE/ihbym258lvL2vaBhfxCRN1sV
         CXV6LmShz6I7Q+6ia2RWzjbZ6cQdTUXKFXOj7aS3d4Csac+o5Yb1XIxxupoVrv//McNv
         9CCz4uP2sFS1dNuro+6MzupbZ1d6yDY7Gr1hktGQu2TE+6FVkqMOTtPvmzFuYLNC2FjC
         rtFbsOxbBkaWXg02Xt7gf024XuivEyYZIN/sRGiCsFV7s4UaAN3SEQLqkFnGWEcBAB4v
         EWU046E6WOIHyKAsiCjFfwHpWGokHva5cZtLLGT8FqKl+wS+S9xgOog3bUMvmS23cWQY
         ojjQ==
X-Gm-Message-State: AOAM5313/6fp4W+0oH/DcIXRGmDo7/sTHpeNhXlZ7wJNh1EMH5eLJR9C
        3bq3eyZngfg26ptpnIf/p5hwIg==
X-Google-Smtp-Source: ABdhPJzNVqmW8bCjPVkalYOgID+2aRbODpiJd6bGg8bopO4SSb17YHiEC0pa6zl+N4/OKoTzcHPqlw==
X-Received: by 2002:a17:90b:350d:b0:1dc:6680:6f1d with SMTP id ls13-20020a17090b350d00b001dc66806f1dmr5344660pjb.27.1651748062717;
        Thu, 05 May 2022 03:54:22 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902728500b0015e8d4eb22asm1226760pll.116.2022.05.05.03.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 03:54:22 -0700 (PDT)
Date:   Thu, 5 May 2022 18:54:18 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/kfence: reset PG_slab and memcg_data before
 freeing __kfence_pool
Message-ID: <YnOs2k0REk9428LA@FVFYT0MHHV2J.usts.net>
References: <20220505073920.1880661-1-42.hyeyoo@gmail.com>
 <20220505101337.1997819-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505101337.1997819-1-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 07:13:37PM +0900, Hyeonggon Yoo wrote:
> When kfence fails to initialize kfence pool, it frees the pool.
> But it does not reset PG_slab flag and memcg_data of struct page.
> 
> Below is a BUG because of this. Let's fix it by resetting PG_slab
> and memcg_data before free.
> 
> [    0.089149] BUG: Bad page state in process swapper/0  pfn:3d8e06
> [    0.089149] page:ffffea46cf638180 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3d8e06
> [    0.089150] memcg:ffffffff94a475d1
> [    0.089150] flags: 0x17ffffc0000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
> [    0.089151] raw: 0017ffffc0000200 ffffea46cf638188 ffffea46cf638188 0000000000000000
> [    0.089152] raw: 0000000000000000 0000000000000000 00000000ffffffff ffffffff94a475d1
> [    0.089152] page dumped because: page still charged to cgroup
> [    0.089153] Modules linked in:
> [    0.089153] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B   W         5.18.0-rc1+ #965
> [    0.089154] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [    0.089154] Call Trace:
> [    0.089155]  <TASK>
> [    0.089155]  dump_stack_lvl+0x49/0x5f
> [    0.089157]  dump_stack+0x10/0x12
> [    0.089158]  bad_page.cold+0x63/0x94
> [    0.089159]  check_free_page_bad+0x66/0x70
> [    0.089160]  __free_pages_ok+0x423/0x530
> [    0.089161]  __free_pages_core+0x8e/0xa0
> [    0.089162]  memblock_free_pages+0x10/0x12
> [    0.089164]  memblock_free_late+0x8f/0xb9
> [    0.089165]  kfence_init+0x68/0x92
> [    0.089166]  start_kernel+0x789/0x992
> [    0.089167]  x86_64_start_reservations+0x24/0x26
> [    0.089168]  x86_64_start_kernel+0xa9/0xaf
> [    0.089170]  secondary_startup_64_no_verify+0xd5/0xdb
> [    0.089171]  </TASK>
> 
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Fixes: 8f0b36497303 ("mm: kfence: fix objcgs vector allocation")
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Reviewed-by: Marco Elver <elver@google.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
> 
> v2 -> v3:
> 	- Add Reviewed-by: tags from Marco and Muchun. Thanks!
> 	- Initialize folio where it is defined.
> 
>  mm/kfence/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index a203747ad2c0..b7d3a9667f00 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -642,6 +642,14 @@ static bool __init kfence_init_pool_early(void)
>  	 * fails for the first page, and therefore expect addr==__kfence_pool in
>  	 * most failure cases.
>  	 */
> +	for (char *p = (char *)addr; p < __kfence_pool + KFENCE_POOL_SIZE; p += PAGE_SIZE) {
> +		struct folio *folio = virt_to_folio(p);
> +

After more thinking, I think it is better to use 'struct slab *'
to define a local variable since we already use this struct
throughout slab core. What do you think?

Thanks.

> +		__folio_clear_slab(folio);
> +#ifdef CONFIG_MEMCG
> +		folio->memcg_data = 0;
> +#endif
> +	}
>  	memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
>  	__kfence_pool = NULL;
>  	return false;
> -- 
> 2.32.0
> 
> 
