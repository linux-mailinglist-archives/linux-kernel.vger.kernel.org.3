Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0155E777
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347242AbiF1O67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346794AbiF1O64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26E502B241
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656428334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWZyK/uRQKIBLtLS3ewqK6inJf2UuHE+gNb5lfdcjSk=;
        b=ZPw0m8LAzMIGc5kC6vGuHNroW0pbx/rHuklRDapaHEuqNRVd+X5TZDXdgCtSTb1jnjq9tk
        u3wzExI59nmud6pAWftfdcDtnTz3Ljt3oBwj3bB8x4aiBg0lYsEPnwRzRs0yIenvTldAxe
        jMnWIoHszaywymobeAfHslqwRDiT5v4=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-OqhYVtxKMo6Zmw1xYtecJg-1; Tue, 28 Jun 2022 10:58:52 -0400
X-MC-Unique: OqhYVtxKMo6Zmw1xYtecJg-1
Received: by mail-il1-f198.google.com with SMTP id o17-20020a056e02115100b002d95d6881e4so7425509ill.19
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=wWZyK/uRQKIBLtLS3ewqK6inJf2UuHE+gNb5lfdcjSk=;
        b=dXF2d0Gx9uS93IL5rlJX0sSVawPJ/jbT6Ls/jI/pCkmuEezWMWmPkSLpoxJzNTnByH
         bQsoaANCQT9VBgmeEuqD3GrzEcJHzoGE6NS0ccQodRBNg+U6PxxQCqQLGIKU0wRW/lC7
         EvNRaCwSsCh86nv0yzdmxRqqFd3SeaHpJDuEjAwidSUTnfd9FDlTo7wUbSO5qtJPmTlv
         2Wlgj894USlhTdciby+RGBeK/G/iQ6o3JaWiR84PfmDJDFctTADwMw1L3NngEA5mfVNT
         aNClokNy2Z3wO1qRvm62ID0WO06pMieBfohV5js95wqgrcAqpi/nw8rRzAV7QhGKr4Mv
         tlsw==
X-Gm-Message-State: AJIora+4tGCnPErOd/NBpQJ+AaRX/Pqxk1thWOM/LpVweGRc0ltM2dtf
        CnusBkR/9m7ww3+HuYBZQAlGl6fvtwUofiLBeUNRLuhbXhSwb2ICgHWRO1REeYHD2Tm1IHNslUo
        8TVSjmyh94nbfdraipC6y/miW
X-Received: by 2002:a02:999a:0:b0:339:f344:9f74 with SMTP id a26-20020a02999a000000b00339f3449f74mr10609368jal.43.1656428332056;
        Tue, 28 Jun 2022 07:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uANWXOfsrMsFoE5tiVeWwTUwjkf/3dlb7vOyiE6sRhu1BS85sSjEO6OydCreN5FFFY5yFCYA==
X-Received: by 2002:a02:999a:0:b0:339:f344:9f74 with SMTP id a26-20020a02999a000000b00339f3449f74mr10609338jal.43.1656428331841;
        Tue, 28 Jun 2022 07:58:51 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y13-20020a056638038d00b00332109dad56sm6082749jap.137.2022.06.28.07.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:58:51 -0700 (PDT)
Date:   Tue, 28 Jun 2022 08:58:49 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, pbonzini@redhat.com, corbet@lwn.net,
        jgg@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 10/21] vfio/pci: introduce CONFIG_VFIO_PCI_ZDEV_KVM
Message-ID: <20220628085849.1b1e67bd.alex.williamson@redhat.com>
In-Reply-To: <20220606203325.110625-11-mjrosato@linux.ibm.com>
References: <20220606203325.110625-1-mjrosato@linux.ibm.com>
        <20220606203325.110625-11-mjrosato@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jun 2022 16:33:14 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> The current contents of vfio-pci-zdev are today only useful in a KVM
> environment; let's tie everything currently under vfio-pci-zdev to
> this Kconfig statement and require KVM in this case, reducing complexity
> (e.g. symbol lookups).
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/vfio/pci/Kconfig      | 11 +++++++++++
>  drivers/vfio/pci/Makefile     |  2 +-
>  include/linux/vfio_pci_core.h |  2 +-
>  3 files changed, 13 insertions(+), 2 deletions(-)


Acked-by: Alex Williamson <alex.williamson@redhat.com>


> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 4da1914425e1..f9d0c908e738 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -44,6 +44,17 @@ config VFIO_PCI_IGD
>  	  To enable Intel IGD assignment through vfio-pci, say Y.
>  endif
>  
> +config VFIO_PCI_ZDEV_KVM
> +	bool "VFIO PCI extensions for s390x KVM passthrough"
> +	depends on S390 && KVM
> +	default y
> +	help
> +	  Support s390x-specific extensions to enable support for enhancements
> +	  to KVM passthrough capabilities, such as interpretive execution of
> +	  zPCI instructions.
> +
> +	  To enable s390x KVM vfio-pci extensions, say Y.
> +
>  source "drivers/vfio/pci/mlx5/Kconfig"
>  
>  source "drivers/vfio/pci/hisilicon/Kconfig"
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 7052ebd893e0..24c524224da5 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
>  vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
> -vfio-pci-core-$(CONFIG_S390) += vfio_pci_zdev.o
> +vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
>  obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
>  
>  vfio-pci-y := vfio_pci.o
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 23c176d4b073..63af2897939c 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -206,7 +206,7 @@ static inline int vfio_pci_igd_init(struct vfio_pci_core_device *vdev)
>  }
>  #endif
>  
> -#ifdef CONFIG_S390
> +#ifdef CONFIG_VFIO_PCI_ZDEV_KVM
>  extern int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  				       struct vfio_info_cap *caps);
>  #else

