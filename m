Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA6580E24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbiGZHp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbiGZHpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6EA4B7F4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658821524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vKrp0ZOd4wBRpP1jWQmTVuLD91idOPyFfvryoNQLhZ8=;
        b=RDx9MQSqT1gXXdrqQhnlXsuQe6oBL+VRnVHAXHcNCSI6K14sltMU77ow3B7vvolTCTEGpD
        yco+ErCYeG3rFZfV0OnN5aPIEYcMaNT5yLdnagTLoNzQfLizpf62mEB8prVSsfidk+Cr9X
        Lc3yvNUm8Ke7KBFfgUM+D981EOtpjFc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-WkAUC_51N9GWZaxwgFDFLw-1; Tue, 26 Jul 2022 03:45:22 -0400
X-MC-Unique: WkAUC_51N9GWZaxwgFDFLw-1
Received: by mail-wm1-f70.google.com with SMTP id n21-20020a7bc5d5000000b003a2ff4d7a9bso5043802wmk.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=vKrp0ZOd4wBRpP1jWQmTVuLD91idOPyFfvryoNQLhZ8=;
        b=asQeFe+uNXhNSv2JNnxF9KnDdyjl+2TolgrQr3XpABJPQ5K6GUyN/FKCSS8ZuvxS1+
         jiBvRR+zbzTjdvoISVT/ztLwx3DttCeHDtjtITboK2nCjkW60I9Jejw/1ye7RYkAxD88
         zW/5zmyVaAURjmKGYXwVWDhwzJKKd07zJfVCw2qjjIOukN8UuALwBN5uJiNM/m+Z3I7j
         odpzBAQBpCJBl5fS6ciEpem2tXKrc8x9T31rx5FX4GeUB/ldN5zGg2+nrLXtWZND8uK8
         waXf6UDnKpVjcyzh8z2yzILVncbb4B6E/2k90gEXiinGGMgMAiuRdea4OjLRLusqWVzt
         UF1g==
X-Gm-Message-State: AJIora8D+k7DWKn3atxr18TLKBSDZrxfurwjOMN5cgGyr82DbiynOpUd
        xhHq9BnHnxgU8fmaLfnTTlZlz5xGe9i0RFxGYgAD7vLDa5vg7jCj1SZGl+CtXI4oxPYCRinhCFI
        gYAzmyzYCiMtZO80dsVjQNqf3
X-Received: by 2002:a05:600c:4e86:b0:3a3:417a:2fcd with SMTP id f6-20020a05600c4e8600b003a3417a2fcdmr11569121wmq.149.1658821521494;
        Tue, 26 Jul 2022 00:45:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sDfK3CX7ILGePqeEWife2zKNCu8T0FdQqHE4clkkNF1efzUOGgQQxxbXnxlWFUZZLlI85s8Q==
X-Received: by 2002:a05:600c:4e86:b0:3a3:417a:2fcd with SMTP id f6-20020a05600c4e8600b003a3417a2fcdmr11569107wmq.149.1658821521174;
        Tue, 26 Jul 2022 00:45:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:fe00:8ba4:5871:abc3:8a75? (p200300cbc708fe008ba45871abc38a75.dip0.t-ipconnect.de. [2003:cb:c708:fe00:8ba4:5871:abc3:8a75])
        by smtp.gmail.com with ESMTPSA id t21-20020a1c7715000000b003a331c6bffdsm15938745wmi.47.2022.07.26.00.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 00:45:20 -0700 (PDT)
Message-ID: <621fb975-413d-a6b4-8126-0b78d5b60853@redhat.com>
Date:   Tue, 26 Jul 2022 09:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220726062436.90290-1-zhengqi.arch@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: fix NULL pointer dereference in wp_page_reuse()
In-Reply-To: <20220726062436.90290-1-zhengqi.arch@bytedance.com>
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

On 26.07.22 08:24, Qi Zheng wrote:
> The vmf->page can be NULL when the wp_page_reuse() is invoked
> by wp_pfn_shared(), it will cause the following panic:
> 
> [   12.981200] BUG: kernel NULL pointer dereference, address: 000000000000008
> [   12.981954] #PF: supervisor read access in kernel mode
> [   12.982615] #PF: error_code(0x0000) - not-present page
> [   12.983146] PGD 0 P4D 0
> [   12.983417] Oops: 0000 [#1] PREEMPT SMP PTI
> [   12.983846] CPU: 18 PID: 923 Comm: Xorg Not tainted 5.19.0-rc8.bm.1-amd64 #263
> [   12.984606] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g14
> [   12.985760] RIP: 0010:_compound_head+0x0/0x40
> [...]
> [   12.995932] Call Trace:
> [   12.996199]  <TASK>
> [   12.996424]  wp_page_reuse+0x1c/0xa0
> [   12.996800]  do_wp_page+0x1a5/0x3f0
> [   12.997169]  __handle_mm_fault+0x8cf/0xd20
> [   12.997587]  ? _raw_spin_unlock_irqrestore+0x23/0x35
> [   12.998105]  handle_mm_fault+0xd5/0x2a0
> [   12.998499]  do_user_addr_fault+0x1d0/0x680
> [   12.998930]  exc_page_fault+0x78/0x170
> [   12.999321]  asm_exc_page_fault+0x22/0x30
> 
> To fix it, this patch performs a NULL pointer check before
> dereferencing the vmf->page.
> 
> Fixes: 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 4cf7d4b6c950..9174918ce3f7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3043,7 +3043,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
>  	pte_t entry;
>  
>  	VM_BUG_ON(!(vmf->flags & FAULT_FLAG_WRITE));
> -	VM_BUG_ON(PageAnon(page) && !PageAnonExclusive(page));
> +	VM_BUG_ON(page && PageAnon(page) && !PageAnonExclusive(page));
>  
>  	/*
>  	 * Clear the pages cpupid information as the existing

Indeed, fortunately, only an issue in the VM_BUG_ON statement

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

