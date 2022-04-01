Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546AC4EEBB1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344721AbiDAKl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344961AbiDAKlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D50EC1C649A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648809537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezvw0rKqPT5/LGCk85RqozRyZpuO5fC9uJeYVkFf5Cs=;
        b=Xu6sueT86W7cuNytNUm4KmIFr4rlQ9ovwG/Fd5ukY7bEdgndWsdD5yWChQ0YnnI+JFIMQI
        HbWUY+Tg/7Fk9abkgUvcUx+E6Pf7kPOIt2MPAAOv4LLkjShpTHK21wG+e0jarQzSQWs5EN
        j+0dIX5hHUQ7SWI3O271CJ8L88EZf3k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-XDmLdpgfOFCsU80pgvltkQ-1; Fri, 01 Apr 2022 06:38:56 -0400
X-MC-Unique: XDmLdpgfOFCsU80pgvltkQ-1
Received: by mail-wr1-f70.google.com with SMTP id v3-20020adf8b43000000b00205e463b017so516030wra.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 03:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ezvw0rKqPT5/LGCk85RqozRyZpuO5fC9uJeYVkFf5Cs=;
        b=0ABD5maCjRWYx/jJ8TDyVYN0WUvILpAIVenQKYpBA+hJUDgDK2cSXem7mwAIys8kwp
         mTidSKG5yKjdJO9zZ1AkLvNtyRINXZoSCktgmarxEiTMlefXwt6pZDdQxHodQ2DxCv8R
         PHzftAcNyoRIRRCsbvclBZTiIchgFCkBsvrAKxyYptpIvQbtQIx4gWFG/W2B81mAiM4y
         UUkCJ1GWj1t6Enw+mTaht66KEU6gnTdk9BEOhSReJCIiO0CaksO1UBQ55Chne/Cz6zMU
         lo+p0J3UHcHwoPmR3mGY547NPLuoGQH6Kux0rxtDeu3Vcbw8XSOoKcc7GA10d3JCQN5Y
         uLeA==
X-Gm-Message-State: AOAM53042nHjPBfoB1QLtLOGvJ5JHRelRAfJ9oxd7W/3lyAEbXu5euAx
        5o77wgqyHeSxjsN8f5+R2SXJpErffX6WdH8IGM5jNNKtxmsBrBsbyd24t7FiDn5hYOIlTdoDSlw
        W1O8F8FFVuK8AiIQclF06ukbx
X-Received: by 2002:a05:600c:3d0e:b0:38c:9b5e:52c0 with SMTP id bh14-20020a05600c3d0e00b0038c9b5e52c0mr7996505wmb.3.1648809534719;
        Fri, 01 Apr 2022 03:38:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaWgGQ8M2sjU3PoOKPy7iwYNiR2ru0Z0Wve7wdBUk79kqf/ISdWJtqlHY3s9J5U6IT3wH/2Q==
X-Received: by 2002:a05:600c:3d0e:b0:38c:9b5e:52c0 with SMTP id bh14-20020a05600c3d0e00b0038c9b5e52c0mr7996481wmb.3.1648809534399;
        Fri, 01 Apr 2022 03:38:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:9e00:229d:4a10:2574:c6fa? (p200300cbc7069e00229d4a102574c6fa.dip0.t-ipconnect.de. [2003:cb:c706:9e00:229d:4a10:2574:c6fa])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm1528779wma.48.2022.04.01.03.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 03:38:53 -0700 (PDT)
Message-ID: <3059b709-7d9a-079d-f7c4-f7cda6b7351e@redhat.com>
Date:   Fri, 1 Apr 2022 12:38:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220401081023.37080-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/mremap: avoid unneeded do_munmap call
In-Reply-To: <20220401081023.37080-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.22 10:10, Miaohe Lin wrote:
> When old_len == new_len, do_munmap will return -EINVAL due to len == 0.
> This errno will be simply ignored because of old_len != new_len check.
> So it is unnecessary to call do_munmap when old_len == new_len because
> nothing is actually done.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/mremap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index e776d4c2345c..dd966621a056 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -817,9 +817,9 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  			goto out;
>  	}
>  
> -	if (old_len >= new_len) {
> +	if (old_len > new_len) {
>  		ret = do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
> -		if (ret && old_len != new_len)
> +		if (ret)
>  			goto out;
>  		old_len = new_len;
>  	}

I remember stumbling over that myself a year ago or so but dig not
deeper. But indeed, both variants (mmu, nommu) return -EINVAL in case
len (old_len - new_len) == 0.

Maybe that used to be different before ecc1a8993751 ("do_mremap()
untangling, part 2"), but it doesn't look like it.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

