Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEB650A20E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389160AbiDUOXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389234AbiDUOXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BDF93B54E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650550818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgfeAm2iEB905RN1m/pwZv+PSShsBs0z05aWSrdVjJo=;
        b=XXGhuPwgEKb0vfRkFcHc9pysB7r8mfDnb4IrSyAt703aP94J4/eVa+RVEmOzDxeozzXwEL
        L50jMse/4f9+MArm/zD1oOvzoMu5Bris0g0wTH9zZzsqMHu6IgZoUbBqj4Wj4/ayOxzF3X
        h9Slcmx1KndImdZjuIwAA5r/GzDx4ps=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-fRxWr0urPfulMSsc5U38FA-1; Thu, 21 Apr 2022 10:20:17 -0400
X-MC-Unique: fRxWr0urPfulMSsc5U38FA-1
Received: by mail-wm1-f70.google.com with SMTP id t187-20020a1c46c4000000b0038ebc45dbfcso2421271wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=cgfeAm2iEB905RN1m/pwZv+PSShsBs0z05aWSrdVjJo=;
        b=scBVb6Yz1bsCa2oGadAnUqMvrRoY20H8KX1WbH+e2EOTSVSuFFsR+GsVurOImKClqg
         ouxCADuBm68m2W9KQQ3QtupTvfui4cAqt05QCvE/0kirjzTdo7tk9mrJKFKoqLu5PbXd
         brlbeqqRR/V41uHu00wDgMfQKgMz2spmEBwPqhJBX5JXOIGXU4LDI57Pp5bfoCxZZJGe
         g1vkXcQVK4XycQRovS7ZX57I1YU+RFovYdiQYoWNzzSDKB4mOxcy8Oo8p4GboC8NRcXY
         juUOoTnUpBmGzl2VLK2WkxEC14EIw0c5CeGkeq765mF+kmC7dUXd/+GtLjusy9q0mHMi
         oAFg==
X-Gm-Message-State: AOAM532OUcAzDctBzGbe1aO+8ucmNEjjpJfk2cv4KkfwqqXhgZhOsNGY
        fsVevstD7n6vIJIwQTgs6rBBZpxqVfQeo9JZ7RfE9A5vsoaAm6hJYEizbobMmo/H+3xM16kBcbG
        ENFLzCXNUEC7im3coP4/FIjjL
X-Received: by 2002:a05:6000:1a86:b0:20a:a933:ba16 with SMTP id f6-20020a0560001a8600b0020aa933ba16mr9480787wry.583.1650550816037;
        Thu, 21 Apr 2022 07:20:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRRbpKnJ9/eE6gsD+4QxEmdPqcDEaUEUINsFTdWmYyAgvU0MGDBkJJuVh1969nuIV7H33eeA==
X-Received: by 2002:a05:6000:1a86:b0:20a:a933:ba16 with SMTP id f6-20020a0560001a8600b0020aa933ba16mr9480767wry.583.1650550815692;
        Thu, 21 Apr 2022 07:20:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:de00:711b:76af:b335:9b70? (p200300cbc702de00711b76afb3359b70.dip0.t-ipconnect.de. [2003:cb:c702:de00:711b:76af:b335:9b70])
        by smtp.gmail.com with ESMTPSA id d11-20020adfa34b000000b0020ab3201c50sm2395559wrb.17.2022.04.21.07.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 07:20:15 -0700 (PDT)
Message-ID: <8fae51af-b12f-4232-1330-54f7b0943907@redhat.com>
Date:   Thu, 21 Apr 2022 16:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
References: <20220421135129.19767-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/memory_hotplug: avoid consuming corrupted data when
 offline pages
In-Reply-To: <20220421135129.19767-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.22 15:51, Miaohe Lin wrote:
> When trying to offline pages, HWPoisoned hugepage is migrated without
> checking PageHWPoison first. So corrupted data could be consumed. Fix
> it by deferring isolate_huge_page until PageHWPoison is handled.
> 

CCing Oscar, Mike and Naoya

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory_hotplug.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4c6065e5d274..093f85ec5c5c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1600,11 +1600,9 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  		folio = page_folio(page);
>  		head = &folio->page;
>  
> -		if (PageHuge(page)) {
> +		if (PageHuge(page))
>  			pfn = page_to_pfn(head) + compound_nr(head) - 1;
> -			isolate_huge_page(head, &source);
> -			continue;
> -		} else if (PageTransHuge(page))
> +		else if (PageTransHuge(page))
>  			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
>  
>  		/*
> @@ -1622,6 +1620,11 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  			continue;
>  		}
>  
> +		if (PageHuge(page)) {
> +			isolate_huge_page(head, &source);
> +			continue;
> +		}
> +
>  		if (!get_page_unless_zero(page))
>  			continue;
>  		/*

The problem statement makes sense to me but I am not sure about the
details if we run into the "PageHWPoison" path with a huge page. I have
the gut feeling that we have to do more for huge pages in the
PageHWPoison() path, because we might be dealing with a free huge page
after unmap succeeds. I might be wrong.

-- 
Thanks,

David / dhildenb

