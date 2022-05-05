Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C35451C010
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378494AbiEENEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378648AbiEENEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:04:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D5323174
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:00:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d5so6006194wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGukWjN41YXunuHxiJ6v8MoB3BMhKLGHT/yPujsOYE4=;
        b=Di4KSmN2FEodAD7lFMKM//ME8zqBRzDiFN9JSNNrXpGoZkzZRpwH7FzfEjSRcmbcfx
         lJtdemxD5INqyiVcGQ3nySkkngToLYeD3EHhvaVkl67QSkcnUwRzZ2kLQ1rycYIpenLE
         yqOx8R1S1HwvPK+keCmqRnR56l4fnqrndEFj+Sq2FUfNato0sftXAokYLucDAoKtvOxW
         Gco8rfwH7ieNa8ChBxegXLa4K0QixoM1FpAT0jgyC3slx3yQJ1KlVWNGklmMnWurMhyP
         KP8GFgQ+TWcoNuG7xShEeeiYVI5rfQrWx2uFNvlEO+rVxXd9E7jqC+9xWGLcvbzoe9L3
         ilEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGukWjN41YXunuHxiJ6v8MoB3BMhKLGHT/yPujsOYE4=;
        b=Bu7spJ74vG9v/HJ1yafj1bIShKH0b/T/Kw/19Rnx8jiOcf71Cd6gbNmbzmeBpi3Y2H
         RAf7SgWktDgBnDPxGb8oH2YtwobLYb8cRVXD0I7cjzg8NMdRQaFHs8rTUhp/44SysirD
         PUE5/BDwNfoicsc9fHZCHf+oN+DXxo+os3euK67NnZOqqsf/LHCLMq7eGteAm+gfiYWn
         9ZoXGhBIaLrCFmmfX7BbTcaF8B/rIjFSo+47TvThbcX51p/Ce31eM9jeH+3LGDoYfXys
         2Ab+c4A6NZmmylHdNVNfaPGA5qJ42+AP+JdffRcJvzaNXKtgWPP7gC5frJf6+BUwK5G+
         sGWw==
X-Gm-Message-State: AOAM533tZjam1EL5IPlEoBnAQp5AG/Sulpatciffw24pM45p0koXTpS7
        zxR6d7cWC755cEtoLS4/iZrEEQ==
X-Google-Smtp-Source: ABdhPJxjtASToxRPCpk4uJFbbWje3gNccF30PaUNbYTd7HVydvY5Fa4RgqOnAT2p8ElPqwb22oVDAQ==
X-Received: by 2002:adf:ecc7:0:b0:20a:dba3:a516 with SMTP id s7-20020adfecc7000000b0020adba3a516mr20355168wro.143.1651755624061;
        Thu, 05 May 2022 06:00:24 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:786b:6d06:626e:af02])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe3c9000000b0020c5253d8eesm1209895wrm.58.2022.05.05.06.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:00:23 -0700 (PDT)
Date:   Thu, 5 May 2022 15:00:18 +0200
From:   Marco Elver <elver@google.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/kfence: reset PG_slab and memcg_data before
 freeing __kfence_pool
Message-ID: <YnPKYtxgIpIk+pF2@elver.google.com>
References: <YnPG3pQrqfcgOlVa@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnPG3pQrqfcgOlVa@hyeyoo>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 09:45PM +0900, Hyeonggon Yoo wrote:
> When kfence fails to initialize kfence pool, it frees the pool.
> But it does not reset memcg_data and PG_slab flag.
> 
> Below is a BUG because of this. Let's fix it by resetting memcg_data
> and PG_slab flag before free.
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

Reviewed-by: Marco Elver <elver@google.com>

Thank you both.

> ---
> 
> v3 -> v4:
> 	- Use struct slab instead of folio and reset memcg_data and
> 	  clear PG_slab only if PG_slab flag is set (virt_to_slab() != NULL).
> 	  
> 	  Thanks Muchun. Now it looks much better and still works.
> 
> 	- Remove Reviewed-by: tags as the code changed. Please add new
> 	  one if the patch still looks good to you.
> 
>  mm/kfence/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index a203747ad2c0..58dfac1828ce 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -642,6 +642,16 @@ static bool __init kfence_init_pool_early(void)
>  	 * fails for the first page, and therefore expect addr==__kfence_pool in
>  	 * most failure cases.
>  	 */
> +	for (char *p = (char *)addr; p < __kfence_pool + KFENCE_POOL_SIZE; p += PAGE_SIZE) {
> +		struct slab *slab = virt_to_slab(p);
> +
> +		if (!slab)
> +			continue;
> +#ifdef CONFIG_MEMCG
> +		slab->memcg_data = 0;
> +#endif
> +		__folio_clear_slab(slab_folio(slab));
> +	}
>  	memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
>  	__kfence_pool = NULL;
>  	return false;
> -- 
> 2.32.0
