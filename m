Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1B7514EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377722AbiD2POK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbiD2POH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:14:07 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BC3D445B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:10:49 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 17so10903870lji.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pBiFdJVBK7XJGcpZMBcNpezNa6QIqErstaAn3kJpmDo=;
        b=dZwSRZ2uUt8/WpZywemY6gH9zX1bSy62uuhUOu5pOWQT+dn18k2SDQQu6GJeCR1fmI
         B9i/eUnvM463HnUn9gPQ4mIHvkU2iyDkHZb6gVT4C6czaSHmrvBGn8LgplqbU9XWyyGU
         J4w9GZKmjIVcfqj51GhpnuXtNWhRwHVmfxq8rrhs2c+yKxtv/p5YTOUohXke7TESuHwl
         ngFhgzPPHRJotN6GR9+KG4f0FM0F+tyMW9UsJtBUtKHgKcdM7uXUD7PlGvKOFStGFvkC
         ZRhqVMfg6QSxwiqmYL54PQdkBEtWRtax0cv5wzeGjGXGRBFFqty9gQWjVObdZ5Jwma+l
         W+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pBiFdJVBK7XJGcpZMBcNpezNa6QIqErstaAn3kJpmDo=;
        b=Hn+N2ZI3k0VYHgDPuHdOzJaxJWiLMZQWs/9TJ0EsQQFtcnI7/Jx/8HOu7RtTKdMrmD
         rMi4+avhJ8NIk+7BW6aMXF2McJNPtPp8wNC6oU67pmfZY5sJFSI8YIyhkqw8dji3paGT
         w9jqzdvAwjOHtml97Qa0EWOIgG8f+sFoXS6eBrC2cBbw6W2L6IeoB1bims2DSSuI/qCw
         t/2djmx4LE4bM14sDS+hpiA8LFChT+eDlqIZy1flRzfUIlcXIGwPBIpZMpVgFxpHNaeq
         Pjkeozv3MSeKzUoZGhV+bGGk1G73tC1AFj7t8obKBfx028HfnMvhIz9kVV1aF81YC1u1
         fHgQ==
X-Gm-Message-State: AOAM531wQqcJJ7HDdNMzQrLxam8WxMGoOP7JOJOHDRHxw6yLyypHRqG8
        6xvXdh20SzXr5WswIl34l+BSGW9/lJM=
X-Google-Smtp-Source: ABdhPJwIjn/TgfjiVJ+PFQMmSwVNO9odm3G/qZjzSdU0Ck0X7LMwl8OoTfIdYYrpdzx9s+oxgWnlKg==
X-Received: by 2002:a2e:9e8e:0:b0:24a:d2d4:4509 with SMTP id f14-20020a2e9e8e000000b0024ad2d44509mr24544459ljk.69.1651245047368;
        Fri, 29 Apr 2022 08:10:47 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id i14-20020a198c4e000000b0044a279d25d2sm258572lfj.244.2022.04.29.08.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 08:10:46 -0700 (PDT)
Subject: Re: [PATCH v2 19/19] xen/xenbus: eliminate xenbus_grant_ring()
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20220428082743.16593-1-jgross@suse.com>
 <20220428082743.16593-20-jgross@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <bf14e3e1-fc4d-1eee-1dfb-1ba3423f0b6f@gmail.com>
Date:   Fri, 29 Apr 2022 18:10:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220428082743.16593-20-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28.04.22 11:27, Juergen Gross wrote:


Hello Juergen


> There is no external user of xenbus_grant_ring() left, so merge it into
> the only caller xenbus_setup_ring().
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - make error message more precise (Andrew Cooper)
> ---
>   drivers/xen/xenbus/xenbus_client.c | 65 +++++++++---------------------
>   include/xen/xenbus.h               |  2 -
>   2 files changed, 19 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
> index 1a2e0d94ccd1..d6fdd2d209d3 100644
> --- a/drivers/xen/xenbus/xenbus_client.c
> +++ b/drivers/xen/xenbus/xenbus_client.c
> @@ -363,50 +363,6 @@ static void xenbus_switch_fatal(struct xenbus_device *dev, int depth, int err,
>   		__xenbus_switch_state(dev, XenbusStateClosing, 1);
>   }
>   
> -/**
> - * xenbus_grant_ring
> - * @dev: xenbus device
> - * @vaddr: starting virtual address of the ring
> - * @nr_pages: number of pages to be granted
> - * @grefs: grant reference array to be filled in
> - *
> - * Grant access to the given @vaddr to the peer of the given device.
> - * Then fill in @grefs with grant references.  Return 0 on success, or
> - * -errno on error.  On error, the device will switch to
> - * XenbusStateClosing, and the error will be saved in the store.
> - */
> -int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
> -		      unsigned int nr_pages, grant_ref_t *grefs)
> -{
> -	int err;
> -	unsigned int i;
> -	grant_ref_t gref_head;
> -
> -	err = gnttab_alloc_grant_references(nr_pages, &gref_head);
> -	if (err) {
> -		xenbus_dev_fatal(dev, err, "granting access to ring page");
> -		return err;
> -	}
> -
> -	for (i = 0; i < nr_pages; i++) {
> -		unsigned long gfn;
> -
> -		if (is_vmalloc_addr(vaddr))
> -			gfn = pfn_to_gfn(vmalloc_to_pfn(vaddr));
> -		else
> -			gfn = virt_to_gfn(vaddr);
> -
> -		grefs[i] = gnttab_claim_grant_reference(&gref_head);
> -		gnttab_grant_foreign_access_ref(grefs[i], dev->otherend_id,
> -						gfn, 0);
> -
> -		vaddr = vaddr + XEN_PAGE_SIZE;
> -	}
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(xenbus_grant_ring);
> -
>   /*
>    * xenbus_setup_ring
>    * @dev: xenbus device
> @@ -424,6 +380,7 @@ int xenbus_setup_ring(struct xenbus_device *dev, gfp_t gfp, void **vaddr,
>   		      unsigned int nr_pages, grant_ref_t *grefs)
>   {
>   	unsigned long ring_size = nr_pages * XEN_PAGE_SIZE;
> +	grant_ref_t gref_head;
>   	unsigned int i;
>   	int ret;
>   
> @@ -433,9 +390,25 @@ int xenbus_setup_ring(struct xenbus_device *dev, gfp_t gfp, void **vaddr,
>   		goto err;
>   	}
>   
> -	ret = xenbus_grant_ring(dev, *vaddr, nr_pages, grefs);
> -	if (ret)
> +	ret = gnttab_alloc_grant_references(nr_pages, &gref_head);
> +	if (ret) {
> +		xenbus_dev_fatal(dev, ret, "granting access to %u ring pages",
> +				 nr_pages);
>   		goto err;
> +	}
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		unsigned long gfn;
> +
> +		if (is_vmalloc_addr(*vaddr))
> +			gfn = pfn_to_gfn(vmalloc_to_pfn(vaddr[i]));
> +		else
> +			gfn = virt_to_gfn(vaddr[i]);
> +
> +		grefs[i] = gnttab_claim_grant_reference(&gref_head);

gnttab_claim_grant_reference() can return error if no free grant 
reference remains.

I understand this patch only moves the code, but probably it would be 
better to add a missing check here (and likely rollback already 
processed grants if any?).



> +		gnttab_grant_foreign_access_ref(grefs[i], dev->otherend_id,
> +						gfn, 0);
> +	}
>   
>   	return 0;
>   
> diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> index b533b4adc835..eaa932b99d8a 100644
> --- a/include/xen/xenbus.h
> +++ b/include/xen/xenbus.h
> @@ -224,8 +224,6 @@ int xenbus_watch_pathfmt(struct xenbus_device *dev, struct xenbus_watch *watch,
>   			 const char *pathfmt, ...);
>   
>   int xenbus_switch_state(struct xenbus_device *dev, enum xenbus_state new_state);
> -int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
> -		      unsigned int nr_pages, grant_ref_t *grefs);
>   int xenbus_setup_ring(struct xenbus_device *dev, gfp_t gfp, void **vaddr,
>   		      unsigned int nr_pages, grant_ref_t *grefs);
>   void xenbus_teardown_ring(void **vaddr, unsigned int nr_pages,

-- 
Regards,

Oleksandr Tyshchenko

