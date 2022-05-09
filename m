Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5635206C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiEIVnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiEIVnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:43:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDBD12EA14
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A3F16173E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 21:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EC9C385BA;
        Mon,  9 May 2022 21:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652132353;
        bh=H2dwaPwrXL4nxxXBdrMYB4OYXvEzLLPVoM3JTYQ5/l8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Me4tlFG4jGnLbuMeyoXfSkn5ct7XSBu3oHjHxskr6Fpm7aFmYoNMlvHM6QLhqvMbc
         tPpOOo4ntqvnBaahgw60upteBF05PNLgjTAaVZ2BBJHkP+xenkUOZG5P9BVoZqmJ4V
         6QXU5VSj2B6uogMr4U+u4JWx4vTnEhF0hoVHBGXueVpLhsyHQj3wTA70E/R0ZcRCCw
         jWBsrRIBUu6+2LgYxAeipVJBCaiFtAaq9O3LEtz5tnxSAhfRpuUoT4x8BZHKQkamXy
         ZgZ5DkQWP2ewyhCNgnsUHZxThyGny2cUFN7u3HrvAbNSua7hViTu0JF2ItIrLlX8Ol
         feJ9kW4H8CUWw==
Date:   Mon, 9 May 2022 14:39:12 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2 4/7] xen/virtio: Enable restricted memory access using
 Xen grant mappings
In-Reply-To: <1651947548-4055-5-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205091426080.43560@ubuntu-linux-20-04-desktop>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com> <1651947548-4055-5-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2022, Oleksandr Tyshchenko wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> In order to support virtio in Xen guests add a config option XEN_VIRTIO
> enabling the user to specify whether in all Xen guests virtio should
> be able to access memory via Xen grant mappings only on the host side.
> 
> Also set PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS feature from the guest
> initialization code on Arm and x86 if CONFIG_XEN_VIRTIO is enabled.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

The patch looks OK to me

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> Changes V1 -> V2:
>    - new patch, split required changes from commit:
>     "[PATCH V1 3/6] xen/virtio: Add option to restrict memory access under Xen"
>    - rework according to new platform_has() infrastructure
> ---
>  arch/arm/xen/enlighten.c     |  2 ++
>  arch/x86/xen/enlighten_hvm.c |  2 ++
>  arch/x86/xen/enlighten_pv.c  |  2 ++
>  drivers/xen/Kconfig          | 11 +++++++++++
>  include/xen/xen.h            |  8 ++++++++
>  5 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 07eb69f..1f9c3ba 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -443,6 +443,8 @@ static int __init xen_guest_init(void)
>  	if (!xen_domain())
>  		return 0;
>  
> +	xen_set_restricted_virtio_memory_access();
> +
>  	if (!acpi_disabled)
>  		xen_acpi_guest_init();
>  	else
> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
> index 517a9d8..8b71b1d 100644
> --- a/arch/x86/xen/enlighten_hvm.c
> +++ b/arch/x86/xen/enlighten_hvm.c
> @@ -195,6 +195,8 @@ static void __init xen_hvm_guest_init(void)
>  	if (xen_pv_domain())
>  		return;
>  
> +	xen_set_restricted_virtio_memory_access();
> +
>  	init_hvm_pv_info();
>  
>  	reserve_shared_info();
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index 5038edb..fcd5d5d 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -109,6 +109,8 @@ static DEFINE_PER_CPU(struct tls_descs, shadow_tls_desc);
>  
>  static void __init xen_pv_init_platform(void)
>  {
> +	xen_set_restricted_virtio_memory_access();
> +
>  	populate_extra_pte(fix_to_virt(FIX_PARAVIRT_BOOTMAP));
>  
>  	set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index 313a9127..a7bd8ce 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -339,4 +339,15 @@ config XEN_GRANT_DMA_OPS
>  	bool
>  	select DMA_OPS
>  
> +config XEN_VIRTIO
> +	bool "Xen virtio support"
> +	depends on VIRTIO
> +	select XEN_GRANT_DMA_OPS
> +	help
> +	  Enable virtio support for running as Xen guest. Depending on the
> +	  guest type this will require special support on the backend side
> +	  (qemu or kernel, depending on the virtio device types used).
> +
> +	  If in doubt, say n.
> +
>  endmenu
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index a99bab8..0780a81 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -52,6 +52,14 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>  extern u64 xen_saved_max_mem_size;
>  #endif
>  
> +#include <linux/platform-feature.h>
> +
> +static inline void xen_set_restricted_virtio_memory_access(void)
> +{
> +	if (IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_domain())
> +		platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> +}
> +
>  #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
>  int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
>  void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
