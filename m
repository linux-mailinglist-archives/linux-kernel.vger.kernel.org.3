Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4348E7D7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbiANJu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiANJux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:50:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09BBC061574;
        Fri, 14 Jan 2022 01:50:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33DDF61EAA;
        Fri, 14 Jan 2022 09:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11901C36AEA;
        Fri, 14 Jan 2022 09:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642153852;
        bh=qPzNVCCoAO7JZYE7iYAZoPJpbmPs2eM2hLzOcfDeZ5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNt1sa9GkIaJprmWQxUHodyPtEBvTEBvTU5VRbhBXxfMfnCbS0h6hvDUpkUrURMXC
         6ocweaUvLEmsf0P+Uf0vOQQtOel7bvY6Kxp17F/bAZNWVgP+C5ktQqc7E6dZ27dars
         IyLHg4K7IIpT2fbjLY/8JOCXD5JpTU+5HFLFMopmssk26sY5EH3JNfOSRX3+R6ca+z
         48j83R/ZrFCvEIVOep9QDtPjd2WkwmOZf/jiSahxaIR1ecvBYMPpHcrQydOTc4DMy5
         l538BfzFVnBh6pKbN5fNa//79MGVfqSPR++qLGX++FI41Nhf7fnx8zdrbtTtYZlLt/
         jVqPuAmOdEXXQ==
Date:   Fri, 14 Jan 2022 11:50:42 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v5 1/5] mm/memblock: Tag memblocks with crypto
 capabilities
Message-ID: <YeFHcrUUopm5xrtZ@kernel.org>
References: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
 <20220113213027.457282-2-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113213027.457282-2-martin.fernandez@eclypsium.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 06:30:23PM -0300, Martin Fernandez wrote:
> Add the capability to mark regions of the memory memory_type able of
> hardware memory encryption.
> 
> Also add the capability to query if all regions of a memory node are
> able to do hardware memory encryption to call it when initializing the
> nodes.
> 
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  include/linux/memblock.h |  5 ++++
>  mm/memblock.c            | 49 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 9dc7cb239d21..374c03e10b2e 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -41,6 +41,7 @@ extern unsigned long long max_possible_pfn;
>   * via a driver, and never indicated in the firmware-provided memory map as
>   * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
>   * kernel resource tree.
> + * @MEMBLOCK_CRYPTO_CAPABLE: capable of hardware encryption
>   */
>  enum memblock_flags {
>  	MEMBLOCK_NONE		= 0x0,	/* No special request */
> @@ -48,6 +49,7 @@ enum memblock_flags {
>  	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
>  	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>  	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> +	MEMBLOCK_CRYPTO_CAPABLE = 0x10,  /* capable of hardware encryption */

Nit: please keep the comments aligned with TAB.

>  };
>  
>  /**
> @@ -121,6 +123,9 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
>  void memblock_trim_memory(phys_addr_t align);
>  bool memblock_overlaps_region(struct memblock_type *type,
>  			      phys_addr_t base, phys_addr_t size);
> +bool memblock_node_is_crypto_capable(int nid);
> +int memblock_mark_crypto_capable(phys_addr_t base, phys_addr_t size);
> +int memblock_clear_crypto_capable(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 1018e50566f3..61ec50647469 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -191,6 +191,27 @@ bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
>  	return i < type->cnt;
>  }
>  
> +/**
> + * memblock_node_is_crypto_capable - get if whole node is capable
> + * of encryption
> + * @nid: number of node
> + *
> + * Iterate over all memory memblock_type and find if all regions under
> + * node @nid are capable of hardware encryption.

Please add Return: description, otherwise kernel-doc is unhappy

> + */
> +bool __init_memblock memblock_node_is_crypto_capable(int nid)
> +{
> +	struct memblock_region *region;
> +
> +	for_each_mem_region(region) {
> +		if ((memblock_get_region_node(region) == nid) &&
> +		    !(region->flags & MEMBLOCK_CRYPTO_CAPABLE))
> +			return false;
> +	}

As we discussed on v3, please add a printk if the same node has both
crypto-capable and not crypto-capable regions.

https://lore.kernel.org/all/Ya++1FwWzKr2wYQH@kernel.org/

> +
> +	return true;
> +}
> +
>  /**
>   * __memblock_find_range_bottom_up - find free area utility in bottom-up
>   * @start: start of candidate range
> @@ -885,6 +906,34 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
>  	return 0;
>  }
>  
> +/**
> + * memblock_mark_crypto_capable - Mark memory regions capable of hardware
> + * encryption with flag MEMBLOCK_CRYPTO_CAPABLE.
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int __init_memblock memblock_mark_crypto_capable(phys_addr_t base,
> +						 phys_addr_t size)
> +{
> +	return memblock_setclr_flag(base, size, 1, MEMBLOCK_CRYPTO_CAPABLE);
> +}
> +
> +/**
> + * memblock_clear_crypto_capable - Clear flag MEMBLOCK_CRYPTO for a
> + * specified region.
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int __init_memblock memblock_clear_crypto_capable(phys_addr_t base,
> +						  phys_addr_t size)
> +{
> +	return memblock_setclr_flag(base, size, 0, MEMBLOCK_CRYPTO_CAPABLE);
> +}
> +
>  /**
>   * memblock_mark_hotplug - Mark hotpluggable memory with flag MEMBLOCK_HOTPLUG.
>   * @base: the base phys addr of the region
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
