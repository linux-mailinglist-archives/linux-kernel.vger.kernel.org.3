Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137B9476F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbhLPKwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:52:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231342AbhLPKwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639651951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K8uTzGYoOBRJY7w+8Ql8RIVF0k5wL483NDOt+n6WV+4=;
        b=K0yjGxetYG0wi3kMZYwWL1tsYpqw/t/wa81aXTVYmvy2LtiwAEUjaGsAS4zRG9WOrLhiCL
        gJUQxLmfBQAIkabdD1SG/t487PmCt5EMnbWl/EyS7Hrq7loKoV2HGqDfT/M6ENYbWaIdt0
        DluTJC5KEjO0VYPVncPbXhrkfYG6rCk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-MYZTv_cEMBeNGInN_flzbg-1; Thu, 16 Dec 2021 05:52:29 -0500
X-MC-Unique: MYZTv_cEMBeNGInN_flzbg-1
Received: by mail-wr1-f69.google.com with SMTP id x20-20020adfbb54000000b001a0d044e20fso2513640wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=K8uTzGYoOBRJY7w+8Ql8RIVF0k5wL483NDOt+n6WV+4=;
        b=Vhx9NLXnvi8TGgOX1yz0jOebsVp7+DLTHhLQJ7DkWA2KebdY9sEEudKmjukDDFPp4o
         l4PVaw2ma70de30zX7CVPpd1uHcrGee+bfM3hJnMACRpgI0idpZV/FvQYKN2j3HAjhBA
         h7l0WSrFUv1vMJ76GFuqXYrLxCI/Z0A8YOnqMHruMiJgPIvolWwVgrNax1hHf+LoZJ8e
         ZePP9Lumc+1EexBi1lzcTs3Je/1IGZmNdvkk6fiMav/G1COiT/vrBWlUOp5Aezwk9gZg
         NMELORzHrAaUVT27mjebfcWDqqd01KylF4uhMrmA0wmmjANExJpRblmVi9xbFEEdUdx3
         zZdA==
X-Gm-Message-State: AOAM531fHFreFag74DWCsZrlEPDryOfzoNhzazXID5STww8vm08k/sVj
        aaieGCdCsPzje83CBcbNDGTgp2b+eb28qE3Rmiz0HU0w81aNpPDD2BPgsi4yR1C4SJm6hg9SjAn
        WL+SZ4fBXvbDSrT2ONTs5ZlPG
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr8498336wrx.56.1639651948619;
        Thu, 16 Dec 2021 02:52:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHuwZkDO7xDTGVXnkIzmCOOqyhEHNs5qWSXjlASQ9huiT2CqWmGIwoAlwyq1QAUc8hqk8taw==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr8498324wrx.56.1639651948362;
        Thu, 16 Dec 2021 02:52:28 -0800 (PST)
Received: from [192.168.3.132] (p4ff23dcd.dip0.t-ipconnect.de. [79.242.61.205])
        by smtp.gmail.com with ESMTPSA id e11sm5582137wrq.28.2021.12.16.02.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 02:52:27 -0800 (PST)
Message-ID: <0091b689-54b6-7cc9-d5ee-ae12a2f8376d@redhat.com>
Date:   Thu, 16 Dec 2021 11:52:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 3/5] mm_zone: add function to check if managed dma zone
 exists
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        cl@linux.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, stable@vger.kernel.org
References: <20211213122712.23805-1-bhe@redhat.com>
 <20211213122712.23805-4-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211213122712.23805-4-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.21 13:27, Baoquan He wrote:
> In some places of the current kernel, it assumes that dma zone must have
> managed pages if CONFIG_ZONE_DMA is enabled. While this is not always true.
> E.g in kdump kernel of x86_64, only low 1M is presented and locked down
> at very early stage of boot, so that there's no managed pages at all in
> DMA zone. This exception will always cause page allocation failure if page
> is requested from DMA zone.
> 
> Here add function has_managed_dma() and the relevant helper functions to
> check if there's DMA zone with managed pages. It will be used in later
> patches.
> 
> Fixes: 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v2->v3:
>  Rewrite has_managed_dma() in a simpler and more efficient way which is
>  sugggested by DavidH. 
> 
>  include/linux/mmzone.h |  9 +++++++++
>  mm/page_alloc.c        | 15 +++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 58e744b78c2c..6e1b726e9adf 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1046,6 +1046,15 @@ static inline int is_highmem_idx(enum zone_type idx)
>  #endif
>  }
>  
> +#ifdef CONFIG_ZONE_DMA
> +bool has_managed_dma(void);
> +#else
> +static inline bool has_managed_dma(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  /**
>   * is_highmem - helper function to quickly check if a struct zone is a
>   *              highmem zone or not.  This is an attempt to keep references
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5952749ad40..7c7a0b5de2ff 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9460,3 +9460,18 @@ bool take_page_off_buddy(struct page *page)
>  	return ret;
>  }
>  #endif
> +
> +#ifdef CONFIG_ZONE_DMA
> +bool has_managed_dma(void)
> +{
> +	struct pglist_data *pgdat;
> +
> +	for_each_online_pgdat(pgdat) {
> +		struct zone *zone = &pgdat->node_zones[ZONE_DMA];
> +
> +		if (managed_zone(zone))
> +			return true;
> +	}
> +	return false;
> +}
> +#endif /* CONFIG_ZONE_DMA */
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

