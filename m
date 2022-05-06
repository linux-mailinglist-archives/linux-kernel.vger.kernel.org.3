Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0151E1C5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444943AbiEFXT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 19:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444933AbiEFXT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA57E703E3
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 16:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651878972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rCa7eNjVeMppq8L/kUv69MDo2c/0xX5B3HNrUpKRUig=;
        b=RIDfblY2TSfgIExBjZibhREWfWaLxRVZfybLNaBvJV8Fnh65OAAufmW08tvPIJKE6SX2cH
        xqqTzz+QtbFJ1NDQB61Xk/2ZxGnayh4vBoP+vOhqVkuwYp3C0wdBBU17pxv3YD4qWRxyxd
        0cFccHzilWuQNeQPBOeLIf//9K2as6I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-FjaEmhX_OJa2_SLMPyjh_Q-1; Fri, 06 May 2022 19:16:07 -0400
X-MC-Unique: FjaEmhX_OJa2_SLMPyjh_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFDAD185A794;
        Fri,  6 May 2022 23:16:06 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5DE07AE3;
        Fri,  6 May 2022 23:15:59 +0000 (UTC)
Date:   Sat, 7 May 2022 07:15:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v24 4/6] of: fdt: Add memory for devices by DT property
 "linux,usable-memory-range"
Message-ID: <20220506231556.GC122876@MiWiFi-R3L-srv>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506114402.365-5-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/22 at 07:44pm, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> When reserving crashkernel in high memory, some low memory is reserved
> for crash dump kernel devices and never mapped by the first kernel.
> This memory range is advertised to crash dump kernel via DT property
> under /chosen,
>         linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>
> 
> We reused the DT property linux,usable-memory-range and made the low
> memory region as the second range "BASE2 SIZE2", which keeps compatibility
> with existing user-space and older kdump kernels.
> 
> Crash dump kernel reads this property at boot time and call memblock_add()
> to add the low memory region after memblock_cap_memory_range() has been
> called.

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>  drivers/of/fdt.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index ec315b060cd50d2..2f248d0acc04830 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -973,16 +973,24 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
>  
>  static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>  
> +/*
> + * The main usage of linux,usable-memory-range is for crash dump kernel.
> + * Originally, the number of usable-memory regions is one. Now there may
> + * be two regions, low region and high region.
> + * To make compatibility with existing user-space and older kdump, the low
> + * region is always the last range of linux,usable-memory-range if exist.
> + */
> +#define MAX_USABLE_RANGES		2
> +
>  /**
>   * early_init_dt_check_for_usable_mem_range - Decode usable memory range
>   * location from flat tree
>   */
>  void __init early_init_dt_check_for_usable_mem_range(void)
>  {
> -	const __be32 *prop;
> -	int len;
> -	phys_addr_t cap_mem_addr;
> -	phys_addr_t cap_mem_size;
> +	struct memblock_region rgn[MAX_USABLE_RANGES] = {0};
> +	const __be32 *prop, *endp;
> +	int len, i;
>  	unsigned long node = chosen_node_offset;
>  
>  	if ((long)node < 0)
> @@ -991,16 +999,21 @@ void __init early_init_dt_check_for_usable_mem_range(void)
>  	pr_debug("Looking for usable-memory-range property... ");
>  
>  	prop = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
> -	if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
> +	if (!prop || (len % (dt_root_addr_cells + dt_root_size_cells)))
>  		return;
>  
> -	cap_mem_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
> -	cap_mem_size = dt_mem_next_cell(dt_root_size_cells, &prop);
> +	endp = prop + (len / sizeof(__be32));
> +	for (i = 0; i < MAX_USABLE_RANGES && prop < endp; i++) {
> +		rgn[i].base = dt_mem_next_cell(dt_root_addr_cells, &prop);
> +		rgn[i].size = dt_mem_next_cell(dt_root_size_cells, &prop);
>  
> -	pr_debug("cap_mem_start=%pa cap_mem_size=%pa\n", &cap_mem_addr,
> -		 &cap_mem_size);
> +		pr_debug("cap_mem_regions[%d]: base=%pa, size=%pa\n",
> +			 i, &rgn[i].base, &rgn[i].size);
> +	}
>  
> -	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> +	memblock_cap_memory_range(rgn[0].base, rgn[0].size);
> +	for (i = 1; i < MAX_USABLE_RANGES && rgn[i].size; i++)
> +		memblock_add(rgn[i].base, rgn[i].size);
>  }
>  
>  #ifdef CONFIG_SERIAL_EARLYCON
> -- 
> 2.25.1
> 

