Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A9E470F53
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 01:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbhLKAVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 19:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbhLKAVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 19:21:52 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B289FC061714;
        Fri, 10 Dec 2021 16:18:16 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id l25so35789qkl.5;
        Fri, 10 Dec 2021 16:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mlm9Yo2fGn0AqBp45ADNXrOv88mqmu6A63sda0f6E1s=;
        b=RX39SFlfdOxHAqS+INm2sm3L+V8aE2vHzGYwZc7Z6O8++ZSR9f+GawyCmby1CIaoRM
         Lrtv18xnlVzFLxb5ABJpFsn+6pu7ThfEywVaGT07bUf41t43v9wRV3iGsGA6tIuOnSQ5
         FQePXDCDE33uy5IANxSQijAjz3kEBbV1luVBEHaNxPL2iQGsW6iCWkZJWFkKNZfaSxAK
         ruWngnsXHgl0SNBVKuxH3TFjZOPZFdY9KKwkoYVQk/bpp1On+qHe5NAgrktLIQqsmKzM
         MlcwtDgylrUTCvGtPNnzCcDrTevKpqLxGhLKZTJN1um8/t2obNJ+0WB+7rL1wLgtVTFK
         m/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mlm9Yo2fGn0AqBp45ADNXrOv88mqmu6A63sda0f6E1s=;
        b=DEanyIE8egOqci1hIiDVrBeA6DqGY6/h3YtfsPptrBBPT9GQ3S5d7wLsES/KWebahm
         rz+bIiJLxXDt6SsoQWl/Btmjv41sSnZ/ax9GEFzgajlbewgpRkrx0nSKxDYhq5cTyQV0
         rhJJDa35xVguG8otgQyybCz9SIY7Wrmu+Xx9DiuV1yDRI2PfkqU8PvVXb4Y72gcWxZ65
         UUPEcUDP6mlb4PUcTUJd0jZtgAvrXT4JNNrP0WWfHAD+uh0Ri5o7wEh6sxF5cNXmW6gs
         5e/QRKD/lA3u2bLuocdsa/SCCZC6hy2gfZC8cv/i3WaMp52KepdsBDgcD/r2WeS3s4Rq
         Ra2w==
X-Gm-Message-State: AOAM533kpM+ClwALJDG9Y1YvrBQTSOipFJo/btlPOs5GJjRn9udGscUh
        zkDoMr/sjCVGwQxOjP3zygQ=
X-Google-Smtp-Source: ABdhPJygr3XKYzIP3B9EL1WjBpFumN0p1QaCY9Vp93wLbAk1tRXvlXlKzpYUi9FDqGDZ2YA4LzVVqQ==
X-Received: by 2002:a05:620a:892:: with SMTP id b18mr22963163qka.360.1639181895771;
        Fri, 10 Dec 2021 16:18:15 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id d187sm2079168qkc.122.2021.12.10.16.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 16:18:15 -0800 (PST)
Subject: Re: [PATCH v2] of/fdt: Rework early_init_dt_scan_memory() to call
 directly
To:     Rob Herring <robh@kernel.org>, John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20211208155839.4084795-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ee19c270-40bd-526a-da40-231325a116ea@gmail.com>
Date:   Fri, 10 Dec 2021 18:18:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208155839.4084795-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 10:58 AM, Rob Herring wrote:
> Use of the of_scan_flat_dt() function predates libfdt and is discouraged
> as libfdt provides a nicer set of APIs. Rework
> early_init_dt_scan_memory() to be called directly and use libfdt.
> 
> Cc: John Crispin <john@phrozen.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: linux-mips@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - ralink: Use 'if' instead of 'else if'
>  - early_init_dt_scan_memory: continue instead of return on no reg
>  - Fix indentation
> ---
>  arch/mips/ralink/of.c      | 19 +++--------
>  arch/powerpc/kernel/prom.c | 16 ++++-----
>  drivers/of/fdt.c           | 68 ++++++++++++++++++++------------------
>  include/linux/of_fdt.h     |  3 +-
>  4 files changed, 49 insertions(+), 57 deletions(-)

Reviewed-by: Frank Rowand <frank.rowand@sony.com>

-Frank

> 
> diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
> index 0135376c5de5..35a87a2da10b 100644
> --- a/arch/mips/ralink/of.c
> +++ b/arch/mips/ralink/of.c
> @@ -53,17 +53,6 @@ void __init device_tree_init(void)
>  	unflatten_and_copy_device_tree();
>  }
>  
> -static int memory_dtb;
> -
> -static int __init early_init_dt_find_memory(unsigned long node,
> -				const char *uname, int depth, void *data)
> -{
> -	if (depth == 1 && !strcmp(uname, "memory@0"))
> -		memory_dtb = 1;
> -
> -	return 0;
> -}
> -
>  void __init plat_mem_setup(void)
>  {
>  	void *dtb;
> @@ -77,10 +66,10 @@ void __init plat_mem_setup(void)
>  	dtb = get_fdt();
>  	__dt_setup_arch(dtb);
>  
> -	of_scan_flat_dt(early_init_dt_find_memory, NULL);
> -	if (memory_dtb)
> -		of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> -	else if (soc_info.mem_detect)
> +	if (!early_init_dt_scan_memory())
> +		return;
> +
> +	if (soc_info.mem_detect)
>  		soc_info.mem_detect();
>  	else if (soc_info.mem_size)
>  		memblock_add(soc_info.mem_base, soc_info.mem_size * SZ_1M);
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 6e1a106f02eb..63762a3b75e8 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -532,19 +532,19 @@ static int  __init early_init_drmem_lmb(struct drmem_lmb *lmb,
>  }
>  #endif /* CONFIG_PPC_PSERIES */
>  
> -static int __init early_init_dt_scan_memory_ppc(unsigned long node,
> -						const char *uname,
> -						int depth, void *data)
> +static int __init early_init_dt_scan_memory_ppc(void)
>  {
>  #ifdef CONFIG_PPC_PSERIES
> -	if (depth == 1 &&
> -	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
> +	const void *fdt = initial_boot_params;
> +	int node = fdt_path_offset(fdt, "/ibm,dynamic-reconfiguration-memory");
> +
> +	if (node > 0) {
>  		walk_drmem_lmbs_early(node, NULL, early_init_drmem_lmb);
>  		return 0;
>  	}
>  #endif
>  	
> -	return early_init_dt_scan_memory(node, uname, depth, data);
> +	return early_init_dt_scan_memory();
>  }
>  
>  /*
> @@ -749,7 +749,7 @@ void __init early_init_devtree(void *params)
>  
>  	/* Scan memory nodes and rebuild MEMBLOCKs */
>  	early_init_dt_scan_root();
> -	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
> +	early_init_dt_scan_memory_ppc();
>  
>  	parse_early_param();
>  
> @@ -858,7 +858,7 @@ void __init early_get_first_memblock_info(void *params, phys_addr_t *size)
>  	 */
>  	add_mem_to_memblock = 0;
>  	early_init_dt_scan_root();
> -	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
> +	early_init_dt_scan_memory_ppc();
>  	add_mem_to_memblock = 1;
>  
>  	if (size)
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 5e216555fe4f..a835c458f50a 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1078,49 +1078,53 @@ u64 __init dt_mem_next_cell(int s, const __be32 **cellp)
>  /*
>   * early_init_dt_scan_memory - Look for and parse memory nodes
>   */
> -int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
> -				     int depth, void *data)
> +int __init early_init_dt_scan_memory(void)
>  {
> -	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> -	const __be32 *reg, *endp;
> -	int l;
> -	bool hotpluggable;
> +	int node;
> +	const void *fdt = initial_boot_params;
>  
> -	/* We are scanning "memory" nodes only */
> -	if (type == NULL || strcmp(type, "memory") != 0)
> -		return 0;
> +	fdt_for_each_subnode(node, fdt, 0) {
> +		const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> +		const __be32 *reg, *endp;
> +		int l;
> +		bool hotpluggable;
>  
> -	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
> -	if (reg == NULL)
> -		reg = of_get_flat_dt_prop(node, "reg", &l);
> -	if (reg == NULL)
> -		return 0;
> +		/* We are scanning "memory" nodes only */
> +		if (type == NULL || strcmp(type, "memory") != 0)
> +			continue;
>  
> -	endp = reg + (l / sizeof(__be32));
> -	hotpluggable = of_get_flat_dt_prop(node, "hotpluggable", NULL);
> +		reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
> +		if (reg == NULL)
> +			reg = of_get_flat_dt_prop(node, "reg", &l);
> +		if (reg == NULL)
> +			continue;
>  
> -	pr_debug("memory scan node %s, reg size %d,\n", uname, l);
> +		endp = reg + (l / sizeof(__be32));
> +		hotpluggable = of_get_flat_dt_prop(node, "hotpluggable", NULL);
>  
> -	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
> -		u64 base, size;
> +		pr_debug("memory scan node %s, reg size %d,\n",
> +			 fdt_get_name(fdt, node, NULL), l);
>  
> -		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
> -		size = dt_mem_next_cell(dt_root_size_cells, &reg);
> +		while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
> +			u64 base, size;
>  
> -		if (size == 0)
> -			continue;
> -		pr_debug(" - %llx, %llx\n", base, size);
> +			base = dt_mem_next_cell(dt_root_addr_cells, &reg);
> +			size = dt_mem_next_cell(dt_root_size_cells, &reg);
>  
> -		early_init_dt_add_memory_arch(base, size);
> +			if (size == 0)
> +				continue;
> +			pr_debug(" - %llx, %llx\n", base, size);
>  
> -		if (!hotpluggable)
> -			continue;
> +			early_init_dt_add_memory_arch(base, size);
>  
> -		if (memblock_mark_hotplug(base, size))
> -			pr_warn("failed to mark hotplug range 0x%llx - 0x%llx\n",
> -				base, base + size);
> -	}
> +			if (!hotpluggable)
> +				continue;
>  
> +			if (memblock_mark_hotplug(base, size))
> +				pr_warn("failed to mark hotplug range 0x%llx - 0x%llx\n",
> +					base, base + size);
> +		}
> +	}
>  	return 0;
>  }
>  
> @@ -1271,7 +1275,7 @@ void __init early_init_dt_scan_nodes(void)
>  		pr_warn("No chosen node found, continuing without\n");
>  
>  	/* Setup memory, calling early_init_dt_add_memory_arch */
> -	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> +	early_init_dt_scan_memory();
>  
>  	/* Handle linux,usable-memory-range property */
>  	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index df3d31926c3c..914739f3c192 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -59,8 +59,7 @@ extern unsigned long of_get_flat_dt_root(void);
>  extern uint32_t of_get_flat_dt_phandle(unsigned long node);
>  
>  extern int early_init_dt_scan_chosen(char *cmdline);
> -extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
> -				     int depth, void *data);
> +extern int early_init_dt_scan_memory(void);
>  extern int early_init_dt_scan_chosen_stdout(void);
>  extern void early_init_fdt_scan_reserved_mem(void);
>  extern void early_init_fdt_reserve_self(void);
> 


