Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B334B2BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352039AbiBKRYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:24:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiBKRYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:24:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E050E1FC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:24:07 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 297751EC03E3;
        Fri, 11 Feb 2022 18:24:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644600242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VHO1rlJsL0gC/vjZZEr5k6jYVR14u21w5w5uJcS9kxw=;
        b=dWH24iq7aFxlIJJVGetMuRlsn6Ka+c9voSSXFLPYULM34Y4PnSQ0kco5PRtWDn8qDd5UhA
        DzLzKV1TYdrb75qU+oAW7nFhGo0gFMPCZ5CmuIQNDNw0BR2/02t4tBBbtR6J14nYlvBPIF
        MgY7BdVQqgj3EZb82dsTy0xZUq1cMHA=
Date:   Fri, 11 Feb 2022 18:24:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        daniel.kiper@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 1/2] x86/boot: Fix memremap of setup_indirect structures
Message-ID: <YgabtFd4Nkpgi+oW@zn.tnic>
References: <1643303056-22272-1-git-send-email-ross.philipson@oracle.com>
 <1643303056-22272-2-git-send-email-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1643303056-22272-2-git-send-email-ross.philipson@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:04:15PM -0500, Ross Philipson wrote:
> As documented, the setup_indirect structure is nested inside
> the setup_data structures in the setup_data list. The code currently
> accesses the fields inside the setup_indirect structure but only
> the sizeof(struct setup_data) is being memremapped. No crash
> occurred but this is just due to how the area is remapped under the
> covers.
> 
> The fix is to properly memremap both the setup_data and setup_indirect

s/The fix is to properly/Properly/

> structures in these cases before accessing them.
> 
> Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
> 

No need for that space - Fixes belongs with the rest of the tags.

> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

> @@ -1015,18 +1019,23 @@ void __init e820__reserve_setup_data(void)
>  						 sizeof(*data) + data->len,
>  						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
>  
> -		if (data->type == SETUP_INDIRECT &&
> -		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> -			e820__range_update(((struct setup_indirect *)data->data)->addr,
> -					   ((struct setup_indirect *)data->data)->len,
> -					   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -			e820__range_update_kexec(((struct setup_indirect *)data->data)->addr,
> -						 ((struct setup_indirect *)data->data)->len,
> -						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> +		if (data->type == SETUP_INDIRECT) {
> +			len += data->len;
> +			early_memunmap(data, sizeof(*data));
> +			data = early_memremap(pa_data, len);

Do I see it correctly that early_memremap() can return NULL?

> +			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> +				e820__range_update(((struct setup_indirect *)data->data)->addr,
> +						   ((struct setup_indirect *)data->data)->len,
> +						   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> +				e820__range_update_kexec(((struct setup_indirect *)data->data)->addr,
> +							 ((struct setup_indirect *)data->data)->len,
> +							 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> +			}
>  		}
>  
> -		pa_data = data->next;
> -		early_memunmap(data, sizeof(*data));
> +		pa_data = pa_next;
> +		early_memunmap(data, len);
>  	}
>  
>  	e820__update_table(e820_table);
> diff --git a/arch/x86/kernel/kdebugfs.c b/arch/x86/kernel/kdebugfs.c
> index 64b6da9..e5c72d8 100644
> --- a/arch/x86/kernel/kdebugfs.c
> +++ b/arch/x86/kernel/kdebugfs.c
> @@ -92,7 +92,8 @@ static int __init create_setup_data_nodes(struct dentry *parent)
>  	struct setup_data *data;
>  	int error;
>  	struct dentry *d;
> -	u64 pa_data;
> +	u64 pa_data, pa_next;
> +	u32 len;
>  	int no = 0;

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

Please fix all cases in your patch.

>  	d = debugfs_create_dir("setup_data", parent);
> @@ -112,12 +113,27 @@ static int __init create_setup_data_nodes(struct dentry *parent)
>  			error = -ENOMEM;
>  			goto err_dir;
>  		}
> -
> -		if (data->type == SETUP_INDIRECT &&
> -		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> -			node->paddr = ((struct setup_indirect *)data->data)->addr;
> -			node->type  = ((struct setup_indirect *)data->data)->type;
> -			node->len   = ((struct setup_indirect *)data->data)->len;
> +		pa_next = data->next;
> +
> +		if (data->type == SETUP_INDIRECT) {
> +			len = sizeof(*data) + data->len;
> +			memunmap(data);
> +			data = memremap(pa_data, len, MEMREMAP_WB);
> +			if (!data) {

Yap, you need similar error handling above.

> +				kfree(node);
> +				error = -ENOMEM;
> +				goto err_dir;
> +			}
> +
> +			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> +				node->paddr = ((struct setup_indirect *)data->data)->addr;
> +				node->type  = ((struct setup_indirect *)data->data)->type;
> +				node->len   = ((struct setup_indirect *)data->data)->len;

Pls use a helper variable here to not have this ugly casting on each line.

> +			} else {
> +				node->paddr = pa_data;
> +				node->type  = data->type;
> +				node->len   = data->len;
> +			}
>  		} else {
>  			node->paddr = pa_data;
>  			node->type  = data->type;
> @@ -125,7 +141,7 @@ static int __init create_setup_data_nodes(struct dentry *parent)
>  		}
>  
>  		create_setup_data_node(d, no, node);
> -		pa_data = data->next;
> +		pa_data = pa_next;
>  
>  		memunmap(data);
>  		no++;
> diff --git a/arch/x86/kernel/ksysfs.c b/arch/x86/kernel/ksysfs.c
> index d0a1912..4e8b794 100644
> --- a/arch/x86/kernel/ksysfs.c
> +++ b/arch/x86/kernel/ksysfs.c
> @@ -93,24 +93,35 @@ static int __init get_setup_data_size(int nr, size_t *size)
>  {
>  	int i = 0;
>  	struct setup_data *data;
> -	u64 pa_data = boot_params.hdr.setup_data;
> +	u64 pa_data = boot_params.hdr.setup_data, pa_next;
> +	u32 len;
>  
>  	while (pa_data) {
>  		data = memremap(pa_data, sizeof(*data), MEMREMAP_WB);
>  		if (!data)
>  			return -ENOMEM;
> +		pa_next = data->next;
> +
>  		if (nr == i) {
> -			if (data->type == SETUP_INDIRECT &&
> -			    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
> -				*size = ((struct setup_indirect *)data->data)->len;
> -			else
> +			if (data->type == SETUP_INDIRECT) {
> +				len = sizeof(*data) + data->len;
> +				memunmap(data);
> +				data = memremap(pa_data, len, MEMREMAP_WB);
> +				if (!data)
> +					return -ENOMEM;
> +
> +				if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
> +					*size = ((struct setup_indirect *)data->data)->len;

Ditto.

> +				else
> +					*size = data->len;
> +			} else
>  				*size = data->len;

Put the else branch in {} too pls, even if it is a single statement.
Below too.

>  
>  			memunmap(data);
>  			return 0;
>  		}
>  
> -		pa_data = data->next;
> +		pa_data = pa_next;
>  		memunmap(data);
>  		i++;
>  	}
> @@ -122,6 +133,7 @@ static ssize_t type_show(struct kobject *kobj,
>  {
>  	int nr, ret;
>  	u64 paddr;
> +	u32 len;
>  	struct setup_data *data;
>  
>  	ret = kobj_to_setup_data_nr(kobj, &nr);
> @@ -135,9 +147,14 @@ static ssize_t type_show(struct kobject *kobj,
>  	if (!data)
>  		return -ENOMEM;
>  
> -	if (data->type == SETUP_INDIRECT)
> +	if (data->type == SETUP_INDIRECT) {
> +		len = sizeof(*data) + data->len;
> +		memunmap(data);
> +		data = memremap(paddr, len, MEMREMAP_WB);
> +		if (!data)
> +			return -ENOMEM;

<---- newline here.

>  		ret = sprintf(buf, "0x%x\n", ((struct setup_indirect *)data->data)->type);
> -	else
> +	} else
>  		ret = sprintf(buf, "0x%x\n", data->type);
>  	memunmap(data);
>  	return ret;
> @@ -165,10 +182,25 @@ static ssize_t setup_data_data_read(struct file *fp,
>  	if (!data)
>  		return -ENOMEM;
>  
> -	if (data->type == SETUP_INDIRECT &&
> -	    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> -		paddr = ((struct setup_indirect *)data->data)->addr;
> -		len = ((struct setup_indirect *)data->data)->len;
> +	if (data->type == SETUP_INDIRECT) {
> +		len = sizeof(*data) + data->len;
> +		memunmap(data);
> +		data = memremap(paddr, len, MEMREMAP_WB);
> +		if (!data)
> +			return -ENOMEM;
> +
> +		if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> +			paddr = ((struct setup_indirect *)data->data)->addr;
> +			len = ((struct setup_indirect *)data->data)->len;

Again a helper var pls.

> +		} else {
> +			/*
> +			 * Even though this is technically undefined, return
> +			 * the data as though it is a normal setup_data struct.
> +			 * This will at least allow it to be inspected.
> +			 */
> +			paddr += sizeof(*data);
> +			len = data->len;
> +		}
>  	} else {
>  		paddr += sizeof(*data);
>  		len = data->len;
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index f7a132e..6e29c20 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -370,20 +370,29 @@ static void __init parse_setup_data(void)
>  static void __init memblock_x86_reserve_range_setup_data(void)
>  {
>  	struct setup_data *data;
> -	u64 pa_data;
> +	u64 pa_data, pa_next;
> +	u32 len;
>  
>  	pa_data = boot_params.hdr.setup_data;
>  	while (pa_data) {
>  		data = early_memremap(pa_data, sizeof(*data));
> +		len = sizeof(*data);
> +		pa_next = data->next;
> +
>  		memblock_reserve(pa_data, sizeof(*data) + data->len);
>  
> -		if (data->type == SETUP_INDIRECT &&
> -		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
> -			memblock_reserve(((struct setup_indirect *)data->data)->addr,
> -					 ((struct setup_indirect *)data->data)->len);
> +		if (data->type == SETUP_INDIRECT) {
> +			len += data->len;
> +			early_memunmap(data, sizeof(*data));
> +			data = early_memremap(pa_data, len);
>  
> -		pa_data = data->next;
> -		early_memunmap(data, sizeof(*data));
> +			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
> +				memblock_reserve(((struct setup_indirect *)data->data)->addr,
> +						 ((struct setup_indirect *)data->data)->len);

Ditto.

> +		}
> +
> +		pa_data = pa_next;
> +		early_memunmap(data, len);
>  	}
>  }
>  
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 026031b..b45e86e 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -636,10 +636,15 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
>  			return true;
>  		}
>  
> -		if (data->type == SETUP_INDIRECT &&
> -		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> -			paddr = ((struct setup_indirect *)data->data)->addr;
> -			len = ((struct setup_indirect *)data->data)->len;
> +		if (data->type == SETUP_INDIRECT) {
> +			memunmap(data);
> +			data = memremap(paddr, sizeof(*data) + len,
> +					MEMREMAP_WB | MEMREMAP_DEC);
> +
> +			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> +				paddr = ((struct setup_indirect *)data->data)->addr;
> +				len = ((struct setup_indirect *)data->data)->len;

Ditto.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
