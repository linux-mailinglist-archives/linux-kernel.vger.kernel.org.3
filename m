Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7BC53B91D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiFBMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiFBMtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:49:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490818CB3D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:49:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y32so7633959lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bsTLsgBWur6uu9OlkhXTdmb21vQyR52FOVipLjd+uS4=;
        b=GZkGTjvTy9vObELpqI+097O57dXF5yumiXJgnYzhdM7ygzRIoboJ8wrZ3gCamVGTCU
         QNYYb5e/uRuAIHGgX2smRbqAkJg8mzLIaV4x+yKwlgplMlxEnTI6flgAgoqf6vhFBeCW
         mXjdZA0DzqYmVkVWOr813LlXgcFH1N7PzRnRSG/XzG2uzqFxEHXFtHjzBhBlVVVPSQuN
         IB/jp8hnT+K1YSVRfvUfN+xm8bBkHoy1thxoOaneRgIiHH6bpepKVH6Bo0kRjiAIEkbv
         p9voW4PVhGvhzCZqlHTqFeVxuZjRDIdOoNFtW7MxydtdhHPbJ2K4+7dKAT4nwQg25duf
         q3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bsTLsgBWur6uu9OlkhXTdmb21vQyR52FOVipLjd+uS4=;
        b=g0UAT8XZW2rCXWAWShRoUIXmqEOMw/nL38Oo5gLA+JDAAqJZ7e9SK15/CLE1w7/laU
         Gfi0y4o7h+o8b2F4XnWkijXTzIN8cz1sNBrDNpygrS0JBCw3p8ycZIJ3svsJfWoIinxh
         ceLiy+ADs4gki0RaJmX+2zqYfnWqF75BWh4+z5YZYmj/IKC7gj8oE6d8rUhFlVJyzMZm
         035rB6fJNwqrrGmK8QnlZab2wpRrnHCnourN2zYmV7HukR+x1Ewvc1CdGhRVbSDjLd4a
         YxCEiCjXdIzpH9+PD6Y4GRzpvbcMAtYy/Uj+0ovenqil7gffWx/wn1Irc84BP4ayxJwN
         g/rQ==
X-Gm-Message-State: AOAM533NjaNEMU4IMwbJs5H+XZgiWCm1yzZX6zGvwBhicvO3RafMRh8o
        A3ym0JjFyVow4mjPT5rugvE=
X-Google-Smtp-Source: ABdhPJwaXlD35k4IsIKvKitQcl/ikmFVgXqey4Sag2YEYkD87wMAyzyt3YWXxh8dBVecrMjoKXujNg==
X-Received: by 2002:a19:5f1d:0:b0:478:f072:8dc9 with SMTP id t29-20020a195f1d000000b00478f0728dc9mr3498506lfb.440.1654174154472;
        Thu, 02 Jun 2022 05:49:14 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id v17-20020a2e9f51000000b00253e37c971asm832692ljk.75.2022.06.02.05.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 05:49:13 -0700 (PDT)
Subject: Re: [PATCH V3 4/8] xen/virtio: Enable restricted memory access using
 Xen grant mappings
From:   Oleksandr <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
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
References: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
 <1653944417-17168-5-git-send-email-olekstysh@gmail.com>
Message-ID: <c2ae069d-ec95-50ea-1789-b2a667d6fb4c@gmail.com>
Date:   Thu, 2 Jun 2022 15:49:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1653944417-17168-5-git-send-email-olekstysh@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31.05.22 00:00, Oleksandr Tyshchenko wrote:

Hello all.

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
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
> Changes V1 -> V2:
>     - new patch, split required changes from commit:
>      "[PATCH V1 3/6] xen/virtio: Add option to restrict memory access under Xen"
>     - rework according to new platform_has() infrastructure
>
> Changes V2 -> V3:
>     - add Stefano's R-b

May I please ask for the ack or comments for x86 side here?



> ---
>   arch/arm/xen/enlighten.c     |  2 ++
>   arch/x86/xen/enlighten_hvm.c |  2 ++
>   arch/x86/xen/enlighten_pv.c  |  2 ++
>   drivers/xen/Kconfig          | 11 +++++++++++
>   include/xen/xen.h            |  8 ++++++++
>   5 files changed, 25 insertions(+)
>
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 07eb69f..1f9c3ba 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -443,6 +443,8 @@ static int __init xen_guest_init(void)
>   	if (!xen_domain())
>   		return 0;
>   
> +	xen_set_restricted_virtio_memory_access();
> +
>   	if (!acpi_disabled)
>   		xen_acpi_guest_init();
>   	else
> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
> index 517a9d8..8b71b1d 100644
> --- a/arch/x86/xen/enlighten_hvm.c
> +++ b/arch/x86/xen/enlighten_hvm.c
> @@ -195,6 +195,8 @@ static void __init xen_hvm_guest_init(void)
>   	if (xen_pv_domain())
>   		return;
>   
> +	xen_set_restricted_virtio_memory_access();
> +
>   	init_hvm_pv_info();
>   
>   	reserve_shared_info();
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index ca85d14..30d24fe 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -108,6 +108,8 @@ static DEFINE_PER_CPU(struct tls_descs, shadow_tls_desc);
>   
>   static void __init xen_pv_init_platform(void)
>   {
> +	xen_set_restricted_virtio_memory_access();
> +
>   	populate_extra_pte(fix_to_virt(FIX_PARAVIRT_BOOTMAP));
>   
>   	set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index 313a9127..a7bd8ce 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -339,4 +339,15 @@ config XEN_GRANT_DMA_OPS
>   	bool
>   	select DMA_OPS
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
>   endmenu
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index a99bab8..0780a81 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -52,6 +52,14 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>   extern u64 xen_saved_max_mem_size;
>   #endif
>   
> +#include <linux/platform-feature.h>
> +
> +static inline void xen_set_restricted_virtio_memory_access(void)
> +{
> +	if (IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_domain())
> +		platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> +}
> +
>   #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
>   int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
>   void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);

-- 
Regards,

Oleksandr Tyshchenko

