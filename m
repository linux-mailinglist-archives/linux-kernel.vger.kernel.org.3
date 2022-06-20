Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D975511B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiFTHnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbiFTHnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F99A6418
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655710988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZUNmq+SKtB8IP20c0SQTXtLsVBfIbeKTb4f/dBL0tMs=;
        b=Oob3RNfE9CyGj/q7fotZKH9cSguoE5tW+zeg2dhXmNUeAWJNgudyyxnev5nu+djz9bZYXT
        y/VA+0kJG69OBGU5+bqeqhx5maiXUSJfFRTd8c8TVg5pU+BX9xpqZ9F1tUy2sZ98IYxbS8
        2t/LmjDbu2kXM6eJve2W6fVnl79d6fc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-czD0OaIeNQauw7EnkZNbLw-1; Mon, 20 Jun 2022 03:43:04 -0400
X-MC-Unique: czD0OaIeNQauw7EnkZNbLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0D45811E81;
        Mon, 20 Jun 2022 07:43:02 +0000 (UTC)
Received: from localhost (ovpn-13-50.pek2.redhat.com [10.72.13.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76A10C44AE3;
        Mon, 20 Jun 2022 07:43:01 +0000 (UTC)
Date:   Mon, 20 Jun 2022 15:42:58 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH 3/5] arm64: kdump: Remove some redundant checks in
 map_mem()
Message-ID: <YrAlAsgBcudz77pu@MiWiFi-R3L-srv>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613080932.663-4-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/22 at 04:09pm, Zhen Lei wrote:
> arm64_memblock_init()
> 	if (!IS_ENABLED(CONFIG_ZONE_DMA/DMA32))
> 		reserve_crashkernel()
> 			//initialize crashk_res when
> 			//"crashkernel=" is correctly specified
> paging_init()
> 	map_mem()
> 
> As shown in the above pseudo code, the crashk_res.end can only be
> initialized to non-zero when both "!IS_ENABLED(CONFIG_ZONE_DMA/DMA32)"
> and crash_mem_map are true. So some checks in map_mem() can be adjusted
> or optimized.

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/mm/mmu.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 626ec32873c6c36..6028a5757e4eae2 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -529,12 +529,12 @@ static void __init map_mem(pgd_t *pgdp)
>  
>  #ifdef CONFIG_KEXEC_CORE
>  	if (crash_mem_map) {
> -		if (IS_ENABLED(CONFIG_ZONE_DMA) ||
> -		    IS_ENABLED(CONFIG_ZONE_DMA32))
> -			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> -		else if (crashk_res.end)
> +		if (crashk_res.end)
>  			memblock_mark_nomap(crashk_res.start,
>  			    resource_size(&crashk_res));
> +		else if (IS_ENABLED(CONFIG_ZONE_DMA) ||
> +			 IS_ENABLED(CONFIG_ZONE_DMA32))
> +			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  	}
>  #endif
>  
> @@ -571,16 +571,13 @@ static void __init map_mem(pgd_t *pgdp)
>  	 * through /sys/kernel/kexec_crash_size interface.
>  	 */
>  #ifdef CONFIG_KEXEC_CORE
> -	if (crash_mem_map &&
> -	    !IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) {
> -		if (crashk_res.end) {
> -			__map_memblock(pgdp, crashk_res.start,
> -				       crashk_res.end + 1,
> -				       PAGE_KERNEL,
> -				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> -			memblock_clear_nomap(crashk_res.start,
> -					     resource_size(&crashk_res));
> -		}
> +	if (crashk_res.end) {
> +		__map_memblock(pgdp, crashk_res.start,
> +			       crashk_res.end + 1,
> +			       PAGE_KERNEL,
> +			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> +		memblock_clear_nomap(crashk_res.start,
> +				     resource_size(&crashk_res));
>  	}
>  #endif
>  }
> -- 
> 2.25.1
> 

