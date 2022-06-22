Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D9A55493B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355851AbiFVJDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354955AbiFVJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:03:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5692F13CE7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:03:30 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t25so26636239lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4UKmOtPuqR9ZV79ZF3RUEUPJlPzQswRYnZS88Bovo1w=;
        b=nTUI5zRn9XS6bFDBR+nn0BgevUpzBla/1rPpk2D8wbRjchNnEZ4dQCt+Ds9Qr53GdN
         aEtiOHS0r65exrhiuv5b2y8mPrUXKMFgPwGujno39obnVBN9gt+8aIyrnztYaRq3Fbui
         JzzEUZwXoq4VsEp6JMDLpt+udclYKzaUjh/v+7ocMGsGRKGfxQuC4Fdu3Ls0KDfOmVmk
         +QVTKT/p5bKbotHeUqjvhGo0ISegQdJeKSK25gt4IaFFQg2ZEqBN9pqu+m/5h8sK6LQ2
         6N/qDT6zFeg/hN3960avfIIQiZrarFaQ9vZCrw+Yb1Iq3o6SygQNayDuyUdLwUUxww1U
         1N+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4UKmOtPuqR9ZV79ZF3RUEUPJlPzQswRYnZS88Bovo1w=;
        b=x/SUEi53P0vrH/kWuXJHPVIw6jXjZ7zqQWbY3ioSVwXZlHBKebyuLTDfF81uUxPFen
         vCkPof4IdS3tmhf/S+EknwPJQyXliobk6yGRzz4sGXd0fj6bFyWZuxSEMiX3qfW1udlx
         nxiMditrZbVkCbslJNmgWUeeWPqeEPgOS//bH2H4eFSGLTccKUIuFLmxY7ykGLfrHt4w
         q11Tr4KZkP8TkcJhPoV+2EcrnAkIF57F++Ij5C7aPwUis4unMAO22YbwdAhs+5fQKqf2
         pEIP90TuyG/fb95dJ9JA3n0G6XIfI6RsfvZQa9TzV51NTvD4Xej66GcbeiIAsDbAVgLm
         ajVA==
X-Gm-Message-State: AJIora9ZQU3304LQ50lDp8hJszK+MeRxyTBwWFfPy3cSDjcs9SUFxGPi
        KPH12LhgkJEvAgZdD5bzykc=
X-Google-Smtp-Source: AGRyM1sukuX1vlem6ZPvfyVXPKMVb8vOqm4ADCvt+D12LzgOZZdGRu1UVCFtQUeaa8AXFbgvr2AMNg==
X-Received: by 2002:a05:6512:3f6:b0:47f:6dff:dab9 with SMTP id n22-20020a05651203f600b0047f6dffdab9mr1563227lfq.645.1655888607690;
        Wed, 22 Jun 2022 02:03:27 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id j5-20020a056512344500b0047f81438160sm547727lfr.112.2022.06.22.02.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:03:26 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] xen: don't require virtio with grants for non-PV
 guests
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-arm-kernel@lists.infradead.org,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20220622063838.8854-1-jgross@suse.com>
 <20220622063838.8854-4-jgross@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <a8ce8ad3-aa3b-ea87-34cf-6532a272e9d8@gmail.com>
Date:   Wed, 22 Jun 2022 12:03:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220622063838.8854-4-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.06.22 09:38, Juergen Gross wrote:

Hello Juergen

> Commit fa1f57421e0b ("xen/virtio: Enable restricted memory access using
> Xen grant mappings") introduced a new requirement for using virtio
> devices: the backend now needs to support the VIRTIO_F_ACCESS_PLATFORM
> feature.
>
> This is an undue requirement for non-PV guests, as those can be operated
> with existing backends without any problem, as long as those backends
> are running in dom0.
>
> Per default allow virtio devices without grant support for non-PV
> guests.
>
> On Arm require VIRTIO_F_ACCESS_PLATFORM for devices having been listed
> in the device tree to use grants.
>
> Add a new config item to always force use of grants for virtio.
>
> Fixes: fa1f57421e0b ("xen/virtio: Enable restricted memory access using Xen grant mappings")
> Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - remove command line parameter (Christoph Hellwig)
> V3:
> - rebase to callback method


Patch looks good, just one NIT ...


> ---
>   arch/arm/xen/enlighten.c     |  4 +++-
>   arch/x86/xen/enlighten_hvm.c |  4 +++-
>   arch/x86/xen/enlighten_pv.c  |  5 ++++-
>   drivers/xen/Kconfig          |  9 +++++++++
>   drivers/xen/grant-dma-ops.c  | 10 ++++++++++
>   include/xen/xen-ops.h        |  6 ++++++
>   include/xen/xen.h            |  8 --------
>   7 files changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 1f9c3ba32833..93c8ccbf2982 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -34,6 +34,7 @@
>   #include <linux/timekeeping.h>
>   #include <linux/timekeeper_internal.h>
>   #include <linux/acpi.h>
> +#include <linux/virtio_anchor.h>
>   
>   #include <linux/mm.h>
>   
> @@ -443,7 +444,8 @@ static int __init xen_guest_init(void)
>   	if (!xen_domain())
>   		return 0;
>   
> -	xen_set_restricted_virtio_memory_access();
> +	if (IS_ENABLED(CONFIG_XEN_VIRTIO))
> +		virtio_set_mem_acc_cb(xen_virtio_mem_acc);
>   
>   	if (!acpi_disabled)
>   		xen_acpi_guest_init();
> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
> index 8b71b1dd7639..28762f800596 100644
> --- a/arch/x86/xen/enlighten_hvm.c
> +++ b/arch/x86/xen/enlighten_hvm.c
> @@ -4,6 +4,7 @@
>   #include <linux/cpu.h>
>   #include <linux/kexec.h>
>   #include <linux/memblock.h>
> +#include <linux/virtio_anchor.h>
>   
>   #include <xen/features.h>
>   #include <xen/events.h>
> @@ -195,7 +196,8 @@ static void __init xen_hvm_guest_init(void)
>   	if (xen_pv_domain())
>   		return;
>   
> -	xen_set_restricted_virtio_memory_access();
> +	if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT))
> +		virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
>   
>   	init_hvm_pv_info();
>   
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index e3297b15701c..5aaae8a77f55 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -31,6 +31,7 @@
>   #include <linux/gfp.h>
>   #include <linux/edd.h>
>   #include <linux/reboot.h>
> +#include <linux/virtio_anchor.h>
>   
>   #include <xen/xen.h>
>   #include <xen/events.h>
> @@ -109,7 +110,9 @@ static DEFINE_PER_CPU(struct tls_descs, shadow_tls_desc);
>   
>   static void __init xen_pv_init_platform(void)
>   {
> -	xen_set_restricted_virtio_memory_access();
> +	/* PV guests can't operate virtio devices without grants. */
> +	if (IS_ENABLED(CONFIG_XEN_VIRTIO))
> +		virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
>   
>   	populate_extra_pte(fix_to_virt(FIX_PARAVIRT_BOOTMAP));
>   
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index bfd5f4f706bc..a65bd92121a5 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -355,4 +355,13 @@ config XEN_VIRTIO
>   
>   	  If in doubt, say n.
>   
> +config XEN_VIRTIO_FORCE_GRANT
> +	bool "Require Xen virtio support to use grants"
> +	depends on XEN_VIRTIO
> +	help
> +	  Require virtio for Xen guests to use grant mappings.
> +	  This will avoid the need to give the backend the right to map all
> +	  of the guest memory. This will need support on the backend side
> +	  (e.g. qemu or kernel, depending on the virtio device types used).
> +
>   endmenu
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index fc0142484001..8973fc1e9ccc 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -12,6 +12,8 @@
>   #include <linux/of.h>
>   #include <linux/pfn.h>
>   #include <linux/xarray.h>
> +#include <linux/virtio_anchor.h>
> +#include <linux/virtio.h>
>   #include <xen/xen.h>
>   #include <xen/xen-ops.h>
>   #include <xen/grant_table.h>
> @@ -287,6 +289,14 @@ bool xen_is_grant_dma_device(struct device *dev)
>   	return has_iommu;
>   }
>   
> +bool xen_virtio_mem_acc(struct virtio_device *dev)
> +{
> +	if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT))
> +		return true;
> +
> +	return xen_is_grant_dma_device(dev->dev.parent);
> +}


    ... I am thinking would it be better to move this to xen/xen-ops.h 
as grant-dma-ops.c is generic (not only for virtio, although the virtio 
is the first use-case)


diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 8973fc1..fc01424 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -12,8 +12,6 @@
  #include <linux/of.h>
  #include <linux/pfn.h>
  #include <linux/xarray.h>
-#include <linux/virtio_anchor.h>
-#include <linux/virtio.h>
  #include <xen/xen.h>
  #include <xen/xen-ops.h>
  #include <xen/grant_table.h>
@@ -289,14 +287,6 @@ bool xen_is_grant_dma_device(struct device *dev)
         return has_iommu;
  }

-bool xen_virtio_mem_acc(struct virtio_device *dev)
-{
-       if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT))
-               return true;
-
-       return xen_is_grant_dma_device(dev->dev.parent);
-}
-
  void xen_grant_setup_dma_ops(struct device *dev)
  {
         struct xen_grant_dma_data *data;
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 98c399a..a9ae51b 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -6,6 +6,7 @@
  #include <linux/notifier.h>
  #include <linux/efi.h>
  #include <linux/virtio_anchor.h>
+#include <linux/virtio.h>
  #include <xen/features.h>
  #include <asm/xen/interface.h>
  #include <xen/interface/vcpu.h>
@@ -218,7 +219,13 @@ static inline void xen_preemptible_hcall_end(void) { }
  #ifdef CONFIG_XEN_GRANT_DMA_OPS
  void xen_grant_setup_dma_ops(struct device *dev);
  bool xen_is_grant_dma_device(struct device *dev);
-bool xen_virtio_mem_acc(struct virtio_device *dev);
+static inline bool xen_virtio_mem_acc(struct virtio_device *dev)
+{
+       if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT))
+               return true;
+
+       return xen_is_grant_dma_device(dev->dev.parent);
+}
  #else
  static inline void xen_grant_setup_dma_ops(struct device *dev)
  {


> +
>   void xen_grant_setup_dma_ops(struct device *dev)
>   {
>   	struct xen_grant_dma_data *data;
> diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
> index 80546960f8b7..98c399a960a3 100644
> --- a/include/xen/xen-ops.h
> +++ b/include/xen/xen-ops.h
> @@ -5,6 +5,7 @@
>   #include <linux/percpu.h>
>   #include <linux/notifier.h>
>   #include <linux/efi.h>
> +#include <linux/virtio_anchor.h>
>   #include <xen/features.h>
>   #include <asm/xen/interface.h>
>   #include <xen/interface/vcpu.h>
> @@ -217,6 +218,7 @@ static inline void xen_preemptible_hcall_end(void) { }
>   #ifdef CONFIG_XEN_GRANT_DMA_OPS
>   void xen_grant_setup_dma_ops(struct device *dev);
>   bool xen_is_grant_dma_device(struct device *dev);
> +bool xen_virtio_mem_acc(struct virtio_device *dev);
>   #else
>   static inline void xen_grant_setup_dma_ops(struct device *dev)
>   {
> @@ -225,6 +227,10 @@ static inline bool xen_is_grant_dma_device(struct device *dev)
>   {
>   	return false;
>   }
> +static inline bool xen_virtio_mem_acc(struct virtio_device *dev)
> +{
> +	return false;
> +}
>   #endif /* CONFIG_XEN_GRANT_DMA_OPS */
>   
>   #endif /* INCLUDE_XEN_OPS_H */
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index ac5a144c6a65..a99bab817523 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -52,14 +52,6 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>   extern u64 xen_saved_max_mem_size;
>   #endif
>   
> -#include <linux/virtio_anchor.h>
> -
> -static inline void xen_set_restricted_virtio_memory_access(void)
> -{
> -	if (IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_domain())
> -		virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
> -}
> -
>   #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
>   int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
>   void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);

-- 
Regards,

Oleksandr Tyshchenko

