Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FF654D10D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347192AbiFOSjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFOSjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADDA532EEA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655318381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcdFFREUfEJEOuSG3gYO2LQRqJJ/FELQTHyfQNEdXjk=;
        b=OSZPncvsLnJk1ykjwD1bZgcf4tcF99GdxIYdVuMC3Cd7KPVIMtTf4dYUSedKaqSPUI5fi/
        VFOa2JXji2BxUKJdA6RHQYjIZGL8L0tHsvcjfn24lN3JuwWTrKHr1+G+Bthjg+pl9NyPmQ
        FPbsYUV25d61wZeCWYgDgu54v+31wPA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-J0nzay-fPmeiQ-Ikkreweg-1; Wed, 15 Jun 2022 14:39:40 -0400
X-MC-Unique: J0nzay-fPmeiQ-Ikkreweg-1
Received: by mail-pg1-f197.google.com with SMTP id y2-20020a655b42000000b0040014afa54cso6856479pgr.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RcdFFREUfEJEOuSG3gYO2LQRqJJ/FELQTHyfQNEdXjk=;
        b=ioAhhjMF4zscUP7xtqzKvj9yAmLemizFwhqncse2zprYwP9bdsPGxiVOWBW8YfhyJQ
         C7n9AZiAqBgb47wSjikCtO+d7kADbASVuFs9BhFfjro7zrpmI3hfr+QXcfwOyn0tJSZJ
         hle0oaxYZegbqDoQiUkNImLmTAQUUxuyHQAG+d2yXd9UpbeKfQJMjE+gihjmqNqJE5vk
         eajpAxCeXjwAdJGslWOTbZuaEtZkkOBXaOiPTWx/2G1e4fLuAj+v67tp2XiHeED6uGqX
         HfU85vdLhSRfltyyTEY8qY6dHXmmJteYP5Hrn39yp0zTtzbbN6BVFv7aqOjw+uWBVrqp
         600g==
X-Gm-Message-State: AJIora8KkoGDgJh1fYSBmmfuJHj9djtrj1nGe6Fh+7/2tF+zOHKli9uH
        DqZgbFhjlp+CuYsWvx621GxauIhDON62CoXNNNf5Vryc/WJw4ahyzvkL5fZ78nGfHRc9yR2VpI/
        tBSYPGkAMbRhUtImeh+JIZO70
X-Received: by 2002:a17:902:6b4c:b0:168:aa50:ddc with SMTP id g12-20020a1709026b4c00b00168aa500ddcmr881388plt.59.1655318379449;
        Wed, 15 Jun 2022 11:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sfw24CKmrnxFPIkKzt0RPQftwNck1wdP7tXppKFhlJfFekT0x1FwP0e7fCgN4lHWCzgV5KNg==
X-Received: by 2002:a17:902:6b4c:b0:168:aa50:ddc with SMTP id g12-20020a1709026b4c00b00168aa500ddcmr881361plt.59.1655318379065;
        Wed, 15 Jun 2022 11:39:39 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o1-20020a62f901000000b0051bb79437f7sm10250845pfh.37.2022.06.15.11.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 11:39:38 -0700 (PDT)
Date:   Wed, 15 Jun 2022 11:39:37 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        Kevin Tian <kevin.tian@intel.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Message-ID: <20220615183937.6k3swpax32lsdhkq@cantor>
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
 <20220615183650.32075-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615183650.32075-1-steve.wahl@hpe.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 01:36:50PM -0500, Steve Wahl wrote:
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
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

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
> v3: Make the config option dependent upon DMAR_TABLE, as it is not used without this.
> 
>  drivers/iommu/intel/Kconfig | 7 +++++++
>  include/linux/dmar.h        | 6 +-----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 39a06d245f12..07aaebcb581d 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -9,6 +9,13 @@ config DMAR_PERF
>  config DMAR_DEBUG
>  	bool
>  
> +config DMAR_UNITS_SUPPORTED
> +	int "Number of DMA Remapping Units supported"
> +	depends on DMAR_TABLE
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

