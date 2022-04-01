Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71B74EEF25
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346791AbiDAOVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbiDAOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:21:44 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0A14C7B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:19:54 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id v13so2205939qkv.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 07:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ACCW8/bZraS0ZT4HrvKJE4Pim6an9ErxJI12ETZ6D8I=;
        b=etQwil6Hu1/NkwZEZI+ruAJC/+UQAuF2gjvBW+a4Ih820ydCI9emF5h5zgBE+pBPJV
         cuMaeIl8o+BQ30fEKqE0/wlfYBp+snjQpdzrj5JN4TG+yiRvP/oPCU3+kp6Cf01O5tJo
         KJcVxHHO3W1AuJK9ejBbe5awuERLWJNVwHF8oktiI38J+1x67GYhGWNV1N5WXpQ3C5Kh
         GR7suSkXiXE8inO+YigNntJAtBSWcDWuAzQkZl0vPVu0Og95P59hGBr8dfBPbAow2QFE
         cWslkhRfXsp/OPJK7IxYXWnENGPOs5PXsiHNQyXdEMHd+IDjV2DdPQ8IqIh9RCHDfOOC
         RCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ACCW8/bZraS0ZT4HrvKJE4Pim6an9ErxJI12ETZ6D8I=;
        b=ulIkFLrnRjTu6txA1F8lPrP17CNIx0w4D6HY3uD+M4bE4J6JCLIaYAsGoZyTmS5dIG
         w3x6kUY/o7JL8f1Djs71yJIzwbl53thRY2bQp85/3exqCAhyNiinqMt+KKTyTrSA1N7g
         SPGVkG8YUnXu0Fc6JbGxo5jt0hfAwPTtaarn5uWYiAC6Z9BGqFhkNg2HNsBPco+4KXh2
         c9Amaew5yLOugsBGqqLANtvlyENyj2QYJQnk10Ik+jiU5pq8Nr859qcdHJmjHxDmV4G5
         0uc0sJFJZjtIl1pe8NBwTlsQeL/27Dr0IP/5ZUqUgZVQy1Q5Y4AI4tMthBzkntk6Ej8X
         D9Gw==
X-Gm-Message-State: AOAM533GEFnC8x5v5MhC4AKc1M3TRNYb3s2AW/vmKo61rmBQfaIstb8n
        vgvvbTI4opJgUoQ/hstEnbjPvg==
X-Google-Smtp-Source: ABdhPJwUx/m0xIPLwWyjukTkeRO9Ht5F0EMHxDa8njMh8pspLckalcH4xcSuiH46I/amIZ6JQPChYA==
X-Received: by 2002:a05:620a:4486:b0:67e:ccd4:990c with SMTP id x6-20020a05620a448600b0067eccd4990cmr6785363qkp.643.1648822793423;
        Fri, 01 Apr 2022 07:19:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id y11-20020ac85f4b000000b002e1e038a8fdsm1843780qta.13.2022.04.01.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 07:19:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1naI7z-00ATnc-C8; Fri, 01 Apr 2022 11:19:51 -0300
Date:   Fri, 1 Apr 2022 11:19:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     xieming <xieming@kylinos.cn>
Cc:     marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com,
        alex.williamson@redhat.com, sashal@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kvm/arm64: fixed passthrough gpu into vm on arm64
Message-ID: <20220401141951.GP64706@ziepe.ca>
References: <20220401090828.614167-1-xieming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401090828.614167-1-xieming@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 05:08:28PM +0800, xieming wrote:
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 51b791c750f1..6f66efb71743 100644
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1452,7 +1452,14 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  	}
>  
>  	vma->vm_private_data = vdev;
> +#ifdef CONFIG_ARM64
> +	if (vfio_pci_is_vga(pdev))
> +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> +	else
> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +#else
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +#endif

This is a user visible change if VFIO starts making things write
combining then userspace has to have different barriers around MMIO.

Also this problem is bigger than just GPUs, lots of devices use write
combining memory for their BARs and will do so inside VMs as well - so
testing for 'pci_is_vga' is also not right.

I think you need to solve this by having userspace somehow request the
cachability type for the mmap (though I'm not sure how KVM will know
what to do with that), or by having kvm always force write combining
for all ioremaps..

> +/**
> + * is_vma_write_combine - check if VMA is mapped with writecombine or not
> + * Return true if VMA mapped with MT_NORMAL_NC otherwise fasle
> + */
> +static inline bool is_vma_write_combine(struct vm_area_struct *vma)
> +{
> +	pteval_t pteval = pgprot_val(vma->vm_page_prot);
> +
> +	return ((pteval & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_NC));
> +}

Shouldn't KVM be copying the exact pgprot bits from the VMA to the
KVM PTEs when it is mirroring them? eg the difference between
pgprot_device and pgprot_noncached() seems relevant to preserve as well.

> @@ -1209,7 +1221,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>  	pfn = __phys_to_pfn(pa);
>  
>  	for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
> -		pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE);
> +		pte_t pte = pfn_pte(pfn, writecombine ? PAGE_S2_NC : PAGE_S2_DEVICE);

Please don't send patches to the mailing list that are against such
old kernels, this code was deleted in 2020.

Jason
