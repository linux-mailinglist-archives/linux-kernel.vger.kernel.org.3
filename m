Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478B854A12C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244988AbiFMVRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351873AbiFMVQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 346A544769
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655153860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DMpM3RLOLxV7DfG66nG4CpZkyo8uEbAIJok5x0MS5a8=;
        b=NLpxM91+jN0Uik7f/N0lzHKLc2F/oz4EmhtRVsviImQuaV3oIVsU845RPNpsIdNZzaXOIQ
        xkZsXUR6jHPgKzdzs56ElhbmC8M8KlrDpAUalOjOUxi7rviYL+KyXIdeZdy7/cvwq7hvWq
        cucYLnrTojWn4eTcU/3HzE6cdAUO3MM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-dI3TZdh2OSmOOoTBm5bLAQ-1; Mon, 13 Jun 2022 16:57:36 -0400
X-MC-Unique: dI3TZdh2OSmOOoTBm5bLAQ-1
Received: by mail-pg1-f197.google.com with SMTP id 72-20020a63014b000000b003fce454aaf2so3898528pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DMpM3RLOLxV7DfG66nG4CpZkyo8uEbAIJok5x0MS5a8=;
        b=o88wD/XPsjdNvuYDXuPJkMNxMPogT0P/Ht0qWGLs4aSCnJEjvHNxDuS77DfcL4VRSe
         OGP78sVf/IeNZNdUWzbAqWPZfPT2qcgW+A9XNELi6AF73xRx/T5hMqe7QPl6X1fiDlWq
         j2JX/Aiv01ghToOOqW5Q5hCRC9i8RsKY5kJbSExA9yxhNs7oF0DAPw2/1Zp+yHmjtBCE
         Djec4GSbI6tb4aDXJ+qAeLhFYwyg4QJZZ7EIgzer7IEqbrsojUhKvTp5Yahc1LtwgRLu
         Hww2W0OjVKOrP14WEtZlADHzr8GnSGyfe3+zk/y8Psh1DTJ7Lao6rF/iPoK3u4m+02Vu
         63JA==
X-Gm-Message-State: AJIora/k6rtrmyLgVEKRdLm2L98wzncDtcd1WtVYP8ulx99pepIQhV61
        skZzVw2ABNFv99rKQBZU3881Gn63H25Q9qDHdRs7/UP6FYKDXVIpxGzoOfETLFDBrekH+qgG17Q
        EiijaWbBWnRw1LERDxTPyTT9k
X-Received: by 2002:a17:902:eb85:b0:168:b028:573b with SMTP id q5-20020a170902eb8500b00168b028573bmr1140652plg.158.1655153855685;
        Mon, 13 Jun 2022 13:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uxvz2BCjhipic+Mg5uJOgnZfWvk5iX8yen2Z2mULX6gqvzjjwLap/PzmGC93Z+zJ4AwPc2Pw==
X-Received: by 2002:a17:902:eb85:b0:168:b028:573b with SMTP id q5-20020a170902eb8500b00168b028573bmr1140628plg.158.1655153855376;
        Mon, 13 Jun 2022 13:57:35 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id iz19-20020a170902ef9300b001636c0b98a7sm5545154plb.226.2022.06.13.13.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:57:35 -0700 (PDT)
Date:   Mon, 13 Jun 2022 13:57:34 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Message-ID: <20220613205734.3x7i46bnsofzerr4@cantor>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512151309.330068-1-steve.wahl@hpe.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> To support up to 64 sockets with 10 DMAR units each (640), make the
> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> set.
> 
> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> fails to boot properly.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
> 
> Note that we could not find a reason for connecting
> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> it seemed like the two would continue to match on earlier processors.
> There doesn't appear to be kernel code that assumes that the value of
> one is related to the other.
> 
> v2: Make this value a config option, rather than a fixed constant.  The default
> values should match previous configuration except in the MAXSMP case.  Keeping the
> value at a power of two was requested by Kevin Tian.
> 
>  drivers/iommu/intel/Kconfig | 6 ++++++
>  include/linux/dmar.h        | 6 +-----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 247d0f2d5fdf..fdbda77ac21e 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -9,6 +9,12 @@ config DMAR_PERF
>  config DMAR_DEBUG
>  	bool
>  
> +config DMAR_UNITS_SUPPORTED
> +	int "Number of DMA Remapping Units supported"

Also, should there be a "depends on (X86 || IA64)" here?

> +	default 1024 if MAXSMP
> +	default 128  if X86_64
> +	default 64
> +
>  config INTEL_IOMMU
>  	bool "Support for Intel IOMMU using DMA Remapping Devices"
>  	depends on PCI_MSI && ACPI && (X86 || IA64)
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index 45e903d84733..0c03c1845c23 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -18,11 +18,7 @@
>  
>  struct acpi_dmar_header;
>  
> -#ifdef	CONFIG_X86
> -# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
> -#else
> -# define	DMAR_UNITS_SUPPORTED	64
> -#endif
> +#define	DMAR_UNITS_SUPPORTED	CONFIG_DMAR_UNITS_SUPPORTED
>  
>  /* DMAR Flags */
>  #define DMAR_INTR_REMAP		0x1
> -- 
> 2.26.2
> 

