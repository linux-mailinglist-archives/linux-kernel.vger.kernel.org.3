Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4234F553D97
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356343AbiFUVYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355464AbiFUVYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AFC62186
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655846227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncxGKHn2fXjYFFgqRt4Fpjb6P4qj7hYEpB/9I/rKxUI=;
        b=W1GxWaxnrRr0iXsZd1UUmm+ixv+nNEjLqwK0Vv3CxwcRcYGFb/+XcQJrsA7h2hCFIwMhnw
        HXXHqRA1BMOeEs9OkDu6bQqyMXPZK+8ayitksPv2pOlFRNrHx2/zkJn0UAAnqxm+JTmGMy
        WRJ2htEryDWOn/XSOcjzdXQd1xvWzQE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-CclZEUjYNe67FGD0kl2P4Q-1; Tue, 21 Jun 2022 17:17:06 -0400
X-MC-Unique: CclZEUjYNe67FGD0kl2P4Q-1
Received: by mail-wm1-f72.google.com with SMTP id n15-20020a05600c4f8f00b0039c3e76d646so6745196wmq.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ncxGKHn2fXjYFFgqRt4Fpjb6P4qj7hYEpB/9I/rKxUI=;
        b=fTMA6vF5U46l+jkJvqv3wOLZA8dafyFT9sbmU8usoGAfEx/MiC9ffGIZlVkqGiFWse
         u9xAaX0RwX4BZhVnBb9TvGZ3UPwwF2hktQcoQI0X45c1LodImR0ZW/IMnoDA3dh/JcUJ
         ppuxF8t4KheEvNPuetYXzNe3uaNoJTQYbOQ5NLXOoDw/bsD2zvNk07mNgxA5PE9RgCvY
         3dzeVfoHZlXe9WOfoY7vqu5kLAYNIy68lyfgDrybM9DH44oQYTq6LmDVza86F5aBU0rU
         RG6qTFv2kpBx4/KVCpqJJZ+QCu8Ty1KlNzdWaWfitAesgvEuvr8Y8fEpJAxKyKUsxtr1
         oEAA==
X-Gm-Message-State: AJIora/RP6YKxPbmKAuTk2Y4femUjBmOZuMsRQqmEEfxCVOCC2pC2kUi
        7R9O7iszAXJx4f3/WNIG5xcm8nE1ud8qxXFIRdiZDLqV8lvIrxZ878VxPzybujPmduJ6wJJd7Sk
        oorr62o7LOPraHPv0F20kMIMY
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id c14-20020adffb0e000000b0021a34a25ca9mr28692550wrr.472.1655846225128;
        Tue, 21 Jun 2022 14:17:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s7mvnYEndH0NNtzPZ+cRT9yucSmwHDvgIekUsuB3uVzNJ+k0JDAj46iI0F/imm2A0LaiJAkg==
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id c14-20020adffb0e000000b0021a34a25ca9mr28692535wrr.472.1655846224902;
        Tue, 21 Jun 2022 14:17:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:bc00:a63c:7e37:6061:1706? (p200300cbc705bc00a63c7e3760611706.dip0.t-ipconnect.de. [2003:cb:c705:bc00:a63c:7e37:6061:1706])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b0039c7f790f6asm22892637wms.30.2022.06.21.14.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:17:04 -0700 (PDT)
Message-ID: <8e4d37dc-722c-6b9d-b1fd-84df4a0076bb@redhat.com>
Date:   Tue, 21 Jun 2022 23:17:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v10 12/69] mm/mmap: use the maple tree for find_vma_prev()
 instead of the rbtree
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-13-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220621204632.3370049-13-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.22 22:46, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Use the maple tree's advanced API and a maple state to walk the tree for
> the entry at the address of the next vma, then use the maple state to walk
> back one entry to find the previous entry.
> 
> Add kernel documentation comments for this API.
> 
> Link: https://lkml.kernel.org/r/20220504010716.661115-14-Liam.Howlett@oracle.com
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/mmap.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index fdb61252448f..08845a0317bf 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2512,23 +2512,30 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  }
>  EXPORT_SYMBOL(find_vma);
>  
> -/*
> - * Same as find_vma, but also return a pointer to the previous VMA in *pprev.
> +/**
> + * find_vma_prev() - Find the VMA for a given address, or the next vma and
> + * set %pprev to the previous VMA, if any.
> + * @mm: The mm_struct to check
> + * @addr: The address
> + * @pprev: The pointer to set to the previous VMA
> + *
> + * Note that RCU lock is missing here since the external mmap_lock() is used
> + * instead.

Can we assert that, please?

> + *
> + * Returns: The VMA associated with @addr, or the next vma.
> + * May return %NULL in the case of no vma at addr or above.

Nit: Inconsistent use of VMA vs. vma.

>   */
>  struct vm_area_struct *
>  find_vma_prev(struct mm_struct *mm, unsigned long addr,
>  			struct vm_area_struct **pprev)
>  {
>  	struct vm_area_struct *vma;
> +	MA_STATE(mas, &mm->mm_mt, addr, addr);
>  
> -	vma = find_vma(mm, addr);
> -	if (vma) {
> -		*pprev = vma->vm_prev;
> -	} else {
> -		struct rb_node *rb_node = rb_last(&mm->mm_rb);
> -
> -		*pprev = rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : NULL;
> -	}
> +	vma = mas_walk(&mas);
> +	*pprev = mas_prev(&mas, 0);
> +	if (!vma)
> +		vma = mas_next(&mas, ULONG_MAX);
>  	return vma;
>  }
>  
Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

