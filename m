Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D505813CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbiGZNFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiGZNFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24F5622B04
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658840745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EqUAbmYzG64TPwyrTQpkR4cRsi5LS7Ye58HFj4CSO6I=;
        b=NsqUjPzJrOO20NoSjX72bViFM8w5jHkKYFKQ1nt9FRQvvjPLgOiG0ZLZD9gcOL15uU3eNc
        XL0Zgj6Vv/Wri4hMEHRVAO1CVGGdqEjt5cl3y1nq+Z4qu6OPaPG9YMxcsaxW3lXhUBYaiC
        g1x1LoNW87rrhOsClfkm6VuGjCwB7nM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-uH82BfVqPKG-HOHewsuy2Q-1; Tue, 26 Jul 2022 09:05:44 -0400
X-MC-Unique: uH82BfVqPKG-HOHewsuy2Q-1
Received: by mail-wm1-f70.google.com with SMTP id i133-20020a1c3b8b000000b003a2fe4c345cso6646464wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=EqUAbmYzG64TPwyrTQpkR4cRsi5LS7Ye58HFj4CSO6I=;
        b=vS+Ox6+JSvjxD8o1pUybKg1U0A2dIMuV56EOAACMrsDhZ2fkj0QqfpV3qbKG0XtdZP
         zJbWa6xCpxDpUPuDyqdtyW70jGxqS75Gt1C3kXSGjFqMDx9hxEb9iHO3uHIM7RjXhe1P
         kshqOzwhlknW3w4Q/MlI5ylODNG3UCd963K3BDtGIIuVvunUBG8BtXQivuvHXHT7nz4G
         VLp5v4c5SiXp+PNLtkuh4DKWoZLyYdjlH03JKu9pmRdFhUu/y9tZ3RbEvrti9NiD3PtC
         fMVqNoZEWjXWZ2N1eKJaKIEABWVRsLglybsl5GYpvFcPrYpkeE+aySf5eIEV/HPyViAg
         7CtQ==
X-Gm-Message-State: AJIora+x/TLO73vTrPhR/jqh2Hb9DmBL+DJVASTGF7QXcF6Sr5jmuwQc
        Pr1ujJGPaXKV2Ne7BoDEqwtFtBheb6ZNlTwcg2Zy3HjbJxSPRed0VMLD5XXoNHk2ehjQk9W3b06
        vU3FfaSHMl8o9kGPMGI0AAqT8
X-Received: by 2002:a05:600c:4f51:b0:3a3:478f:6d1c with SMTP id m17-20020a05600c4f5100b003a3478f6d1cmr11290469wmq.143.1658840742899;
        Tue, 26 Jul 2022 06:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vMY6FedwCHXNkq9vi1saetTdROMBAqzr8R5qvIKH1IFxZ0VbgPqLEfOdGvT3QBajAAVIMU/w==
X-Received: by 2002:a05:600c:4f51:b0:3a3:478f:6d1c with SMTP id m17-20020a05600c4f5100b003a3478f6d1cmr11290440wmq.143.1658840742550;
        Tue, 26 Jul 2022 06:05:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:fe00:8ba4:5871:abc3:8a75? (p200300cbc708fe008ba45871abc38a75.dip0.t-ipconnect.de. [2003:cb:c708:fe00:8ba4:5871:abc3:8a75])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d4fc9000000b0021e6277bc50sm13615108wrw.36.2022.07.26.06.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:05:42 -0700 (PDT)
Message-ID: <621714a3-f3fd-e9de-c072-0fef3ad76288@redhat.com>
Date:   Tue, 26 Jul 2022 15:05:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: use is_zone_movable_page() helper
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20220726131135.146912-1-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220726131135.146912-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.22 15:11, Kefeng Wang wrote:
> Use is_zone_movable_page() helper to simplify code.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/virtio/virtio_mem.c | 6 ++----
>  mm/memory_hotplug.c         | 2 +-
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index e07486f01999..0c2892ec6817 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -862,8 +862,7 @@ static void virtio_mem_sbm_notify_online(struct virtio_mem *vm,
>  					 unsigned long mb_id,
>  					 unsigned long start_pfn)
>  {
> -	const bool is_movable = page_zonenum(pfn_to_page(start_pfn)) ==
> -				ZONE_MOVABLE;
> +	const bool is_movable = is_zone_movable_page(pfn_to_page(start_pfn));
>  	int new_state;
>  
>  	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
> @@ -1158,8 +1157,7 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
>   */
>  static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
>  {
> -	const bool is_movable = page_zonenum(pfn_to_page(pfn)) ==
> -				ZONE_MOVABLE;
> +	const bool is_movable = is_zone_movable_page(pfn_to_page(pfn));
>  	int rc, retry_count;
>  
>  	/*
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 1213d0c67a53..0f5914964a32 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -936,7 +936,7 @@ static struct zone *auto_movable_zone_for_pfn(int nid,
>  			if (!page)
>  				continue;
>  			/* If anything is !MOVABLE online the rest !MOVABLE. */
> -			if (page_zonenum(page) != ZONE_MOVABLE)
> +			if (!is_zone_movable_page(page))
>  				goto kernel_zone;
>  			online_pages += PAGES_PER_SECTION;
>  		}


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

