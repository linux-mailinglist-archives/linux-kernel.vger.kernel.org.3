Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69808464130
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhK3WTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:19:45 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:34488 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhK3WTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:19:43 -0500
Received: by mail-ot1-f48.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso32301760otj.1;
        Tue, 30 Nov 2021 14:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T59yjRvPcbWOKoUxdTO62y1BQorOr6NcoUwNDk8i+VM=;
        b=IYXgZhVQO/wxXgbOKn+WHoZpJtBp1NTLRs8tZG4GuBQl0PCppVBnw1LsGg7St6/l4O
         esTsZ99FCxkS/GtXEBJpgn7/AAs8NnS+Nur5c59hyotyFZXV477ohTJOMWbgQkCCMpUn
         +9RGyWcTIyDzUxZto/IiK8rgtVMomu4TcaLcUV+NLz/yWAl8QyAnB+kxTyfFVjQn1fX2
         mH6cG2bgiKPtNgl8TOwCkRSw4F3gIW1aviclcofk+5E76kvJTGNjc0uuufhYTl0GH0nR
         v9lcvG42+HaWjhYV8UEbENxKC2Z6SXx0Mirbdpmn/qt6W2tandX6F/4P3nO1CTWl1LkB
         t40A==
X-Gm-Message-State: AOAM532NG0gcwcbDuOU+PMCJz7ozgNAnIq7BAwOjhmf11jbu36UvUB7Q
        Tae9CIbl3JEdhr8KaoBrug==
X-Google-Smtp-Source: ABdhPJyQZxRpJ8Oes6rHpmTqF4skhy7f5op1iHR2HGyXwvc1N3UrOasp3Lypdn+IpEHkhKbjgss5mw==
X-Received: by 2002:a9d:4e93:: with SMTP id v19mr1970722otk.146.1638310582805;
        Tue, 30 Nov 2021 14:16:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m12sm3352717ots.59.2021.11.30.14.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:16:21 -0800 (PST)
Received: (nullmailer pid 3107725 invoked by uid 1000);
        Tue, 30 Nov 2021 22:16:20 -0000
Date:   Tue, 30 Nov 2021 16:16:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
Subject: Re: [PATCH v16 10/11] of: fdt: Add memory for devices by DT property
 "linux,usable-memory-range"
Message-ID: <YaaitPTArUZEriob@robh.at.kernel.org>
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
 <20211123124646.1995-11-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123124646.1995-11-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 08:46:45PM +0800, Zhen Lei wrote:
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
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/of/fdt.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 37b477a51175359..1ea2a0b1657e3a9 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -967,6 +967,15 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
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
> @@ -974,10 +983,9 @@ static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>   */
>  static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
>  {
> -	const __be32 *prop;
> -	int len;
> -	phys_addr_t cap_mem_addr;
> -	phys_addr_t cap_mem_size;
> +	struct memblock_region rgn[MAX_USABLE_RANGES] = {0};
> +	const __be32 *prop, *endp;
> +	int len, i = 0;
>  
>  	if ((long)node < 0)
>  		return;
> @@ -985,16 +993,24 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
>  	pr_debug("Looking for usable-memory-range property... ");
>  
>  	prop = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
> -	if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
> +	if (!prop)

if (!prop || (len % (dt_root_addr_cells + dt_root_size_cells)))

>  		return;
>  
> -	cap_mem_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
> -	cap_mem_size = dt_mem_next_cell(dt_root_size_cells, &prop);
> +	endp = prop + (len / sizeof(__be32));
> +	while ((endp - prop) >= (dt_root_addr_cells + dt_root_size_cells)) {

for (i = 0; i < MAX_USABLE_RANGES, prop < endp; i++) {

> +		rgn[i].base = dt_mem_next_cell(dt_root_addr_cells, &prop);
> +		rgn[i].size = dt_mem_next_cell(dt_root_size_cells, &prop);
> +
> +		pr_debug("cap_mem_regions[%d]: base=%pa, size=%pa\n",
> +			 i, &rgn[i].base, &rgn[i].size);
>  
> -	pr_debug("cap_mem_start=%pa cap_mem_size=%pa\n", &cap_mem_addr,
> -		 &cap_mem_size);
> +		if (++i >= MAX_USABLE_RANGES)
> +			break;

And drop this if.

> +	}
>  
> -	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> +	memblock_cap_memory_range(rgn[0].base, rgn[0].size);
> +	for (i = 1; i < MAX_USABLE_RANGES && rgn[i].size; i++)

s/ &&/,/

> +		memblock_add(rgn[i].base, rgn[i].size);
>  }
>  
>  #ifdef CONFIG_SERIAL_EARLYCON
> -- 
> 2.25.1
> 
> 

