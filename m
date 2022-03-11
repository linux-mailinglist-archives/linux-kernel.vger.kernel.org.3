Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7B54D5EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347547AbiCKJ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiCKJ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:57:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 831931BE4F3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646992592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BzQ5znBqP745RuD+dwW1ikgl/12q0xJiq/I2QyjkhY=;
        b=dVeg8XUH6W3xfl7IOUCcYf0PXNIWqjPKaLLy9KtLUhsRclE1aBJ4KZphMb8cWydus2qwQZ
        b5hcJSDzGZOO2pHxqPVb6WNWw8hMCBvpRJ0uDyjgVe8p+2fbjvRv3prF4dPHO90vgZHnCc
        V6ZimFdVgUvGdtt2MtW8rqaTHGmOwXI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-HX0LnAoYMHib8LR2rodSJQ-1; Fri, 11 Mar 2022 04:56:31 -0500
X-MC-Unique: HX0LnAoYMHib8LR2rodSJQ-1
Received: by mail-wr1-f69.google.com with SMTP id p18-20020adfba92000000b001e8f7697cc7so2616874wrg.20
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=5BzQ5znBqP745RuD+dwW1ikgl/12q0xJiq/I2QyjkhY=;
        b=jDZgjrw/TOfBc79pj8Tuvsya9jgaZQbQE42oDWPxZCEvD+MZ/SABUYWNxHcePWMMZy
         kzP+XX+tZ+C1UNVMFlOqpLFMoKls6+kP2PduSYpJ/cqSbtvjyZBSRZyBKwKIjbLdRFQu
         9kuUlh/LPGi8YDRdUggtCM6n32Ipd/DZMnUdp8KKHzT0X5uK9HlPp4B6q3OolJAY2ENi
         5iGqnAvTnGzOHwFdh9vxgHCcGi2Rc2dLZVy5IPxgAXESuQT1XeTuJ+gAjtsNGRtT3Iqj
         J6+1JfPlDqL5UltIsnZEbFnswThVEZJgrzDA0CRbwQgOHSxm04ldbZQVL0shbjnZztwk
         +jeA==
X-Gm-Message-State: AOAM533EJsPK1TmKAAbKpt8Wfx7oqz8RQgVyh+AKY/LPC2R84hTYRGIl
        a9OPIPsEzAU7v7gxK3Zzu1QcWNaGJNEBHvHxB329BWFXr3CmmpRu/73F/0MdqZuX3PZlSykc2Uu
        bpKWSlLKY0aOtOHfVa8ya3ARQ
X-Received: by 2002:a05:600c:4f86:b0:389:d5bf:a7f3 with SMTP id n6-20020a05600c4f8600b00389d5bfa7f3mr7055369wmq.49.1646992590130;
        Fri, 11 Mar 2022 01:56:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxB5lHprBaxk2MYtTTjae6wI4Ju7wraprW3RrIO7aIylwfdcaT6j/CZz37ZLt5rzZ5idDRiRQ==
X-Received: by 2002:a05:600c:4f86:b0:389:d5bf:a7f3 with SMTP id n6-20020a05600c4f8600b00389d5bfa7f3mr7055355wmq.49.1646992589847;
        Fri, 11 Mar 2022 01:56:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:8200:163d:7a08:6e61:87a5? (p200300cbc7078200163d7a086e6187a5.dip0.t-ipconnect.de. [2003:cb:c707:8200:163d:7a08:6e61:87a5])
        by smtp.gmail.com with ESMTPSA id g17-20020adff411000000b001f03426827csm6257696wro.71.2022.03.11.01.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:56:29 -0800 (PST)
Message-ID: <377bc77d-a9b7-1622-c77d-df6533959804@redhat.com>
Date:   Fri, 11 Mar 2022 10:56:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/huge_memory: remove unneeded local variable follflags
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220310131253.30970-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220310131253.30970-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.22 14:12, Miaohe Lin wrote:
> We can pass FOLL_GET | FOLL_DUMP to follow_page directly to simplify
> the code a bit.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3557aabe86fe..418d077da246 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2838,7 +2838,6 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  	 */
>  	for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
>  		struct vm_area_struct *vma = find_vma(mm, addr);
> -		unsigned int follflags;
>  		struct page *page;
>  
>  		if (!vma || addr < vma->vm_start)
> @@ -2851,8 +2850,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  		}
>  
>  		/* FOLL_DUMP to ignore special (like zero) pages */
> -		follflags = FOLL_GET | FOLL_DUMP;
> -		page = follow_page(vma, addr, follflags);
> +		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>  
>  		if (IS_ERR(page))
>  			continue;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

