Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C272578016
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiGRKsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiGRKsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 162FF1C91B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658141292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m1eIyFyAH5ECjzpVGzYBj4pnrSXmSB4fhTqju7D/xzc=;
        b=RBMWvATZPPJCgSrKaaRihudjXEXZ0fUi5My24FTjZCEh7O+3JSmA1g5FfhzpBPs951sZwr
        8ThHEhwbkHtMKiWQyEGascuSf8yayFiCjQOC3ZIOEhsu53aOnrZ/Sb9bzbhwfxb3psltsc
        S03KWP+2UB7Fv/23WAQxwaBuyRZkcdo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-1vAuXqmgMOyk4t1zQE6HEA-1; Mon, 18 Jul 2022 06:48:10 -0400
X-MC-Unique: 1vAuXqmgMOyk4t1zQE6HEA-1
Received: by mail-wm1-f70.google.com with SMTP id h189-20020a1c21c6000000b003a2fdf9bd2aso5243954wmh.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=m1eIyFyAH5ECjzpVGzYBj4pnrSXmSB4fhTqju7D/xzc=;
        b=sOYvpe7k7mxyLfhO0c/Cdrd3T0XhHRFZu00LZEtHta5wlqshi8DEXO0qDYE56XKKKz
         4bPEBkVSvdeYvZ/eqSI8A2gJWsMJtAS9kwj/WRDyPNPDK6dsAtTzjm0dD2ZdiEOHIsKD
         Bl52YARMgvEMjAMNA5ET9HgNxlL4/ca2ZsWpf9cY+pNO4W+h8xX5VuRv8d4uGXIgVw20
         qac+n86dgSYEim90NPo8M8ePbw/RRIjB/hmql9tGIUTho1VzOKpfqlwB0g+gEC1gzmCi
         uNLy9Ojf3UnqagQGlEqKBAmndkXAd9oVB0+F/qVZnbF0bxsjPOy0FmOsdBucoSbEPiVr
         7Whw==
X-Gm-Message-State: AJIora/pYB3ltnAnaa5N1Sk4TmBsj9AOYQ0j7i8vHuDnP+9PDvR6xHJk
        5JslNOqHM9mJ6AXuJCWeEAZ7l00tnEbccU9k3XqbUY4L8f1ewdNhsvsErNSMcA5Ke4Ex1biX1r/
        DgfvfggqFCeqByyVWkcDP1hwA
X-Received: by 2002:a05:600c:3592:b0:3a0:4c17:5ec1 with SMTP id p18-20020a05600c359200b003a04c175ec1mr27131206wmq.4.1658141289624;
        Mon, 18 Jul 2022 03:48:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uRmHAMirZSX6nfWwms3dUWQLhN4ODOM6SYCpcpN8Ik9JAvPJClZIlCoGLbmC8KM2ZHWvYl8A==
X-Received: by 2002:a05:600c:3592:b0:3a0:4c17:5ec1 with SMTP id p18-20020a05600c359200b003a04c175ec1mr27131183wmq.4.1658141289385;
        Mon, 18 Jul 2022 03:48:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7400:6b3a:a74a:bd53:a018? (p200300cbc70574006b3aa74abd53a018.dip0.t-ipconnect.de. [2003:cb:c705:7400:6b3a:a74a:bd53:a018])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d5404000000b0021d7b999949sm10521072wrv.111.2022.07.18.03.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 03:48:09 -0700 (PDT)
Message-ID: <488f510f-00ad-4ef0-1eb9-ac73c7bb527c@redhat.com>
Date:   Mon, 18 Jul 2022 12:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Vaibhav Jain <vaibhav@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20220601163243.3806231-1-vaibhav@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] resource: re-factor page_is_ram()
In-Reply-To: <20220601163243.3806231-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.22 18:32, Vaibhav Jain wrote:
> Presently page_is_ram() relies on walk_system_ram_range() that performs a walk
> on kernel iomem resources hierarchy with a dummy callback __is_ram(). Before
> calling find_next_iomem_res(), walk_system_ram_range() does some book-keeping
> which can be avoided for page_is_ram() use-case.
> 
> Hence this patch proposes to update page_is_ram() to directly call
> find_next_iomem_res() with minimal book-keeping needed.
> 
> To avoid allocating a 'struct resource' the patch also updates
> find_next_iomem_res() to not return -EINVAL in case 'res == NULL'. Instead
> out 'struct resource *res' is only populated when its not NULL.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  kernel/resource.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 34eaee179689..ecf6b9a50adc 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -311,7 +311,7 @@ EXPORT_SYMBOL(release_resource);
>   *
>   * If a resource is found, returns 0 and @*res is overwritten with the part
>   * of the resource that's within [@start..@end]; if none is found, returns
> - * -ENODEV.  Returns -EINVAL for invalid parameters.
> + * -ENODEV.
>   *

There is still another -EINVAL in that function ...

>   * @start:	start address of the resource searched for
>   * @end:	end address of same resource
> @@ -328,9 +328,6 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>  {
>  	struct resource *p;
>  
> -	if (!res)
> -		return -EINVAL;
> -
>  	if (start >= end)
>  		return -EINVAL;

As all callers guarantee that, we might just remove it.

>  
> @@ -356,7 +353,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>  		break;
>  	}
>  
> -	if (p) {
> +	if (p && res) {
>  		/* copy data */
>  		*res = (struct resource) {
>  			.start = max(start, p->start),
> @@ -474,18 +471,18 @@ int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
>  	return ret;
>  }
>  
> -static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
> -{
> -	return 1;
> -}
> -
>  /*
>   * This generic page_is_ram() returns true if specified address is
>   * registered as System RAM in iomem_resource list.
>   */
>  int __weak page_is_ram(unsigned long pfn)
>  {
> -	return walk_system_ram_range(pfn, 1, NULL, __is_ram) == 1;
> +	const resource_size_t pfn_res = PFN_PHYS(pfn);
> +
> +	return find_next_iomem_res(pfn_res,
> +				   pfn_res + 1,
> +				   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				   IORES_DESC_NONE, NULL) == 0;
>  }
>  EXPORT_SYMBOL_GPL(page_is_ram);
>  

What about

a) A cleanup patch upfront that removes both -EINVAL cases from
find_next_iomem_res() followed by

b) The actual change to page_is_ram()

?

-- 
Thanks,

David / dhildenb

