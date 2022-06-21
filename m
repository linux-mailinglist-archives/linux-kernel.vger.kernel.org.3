Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF31E553D69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355541AbiFUVTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355790AbiFUVTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E4173526D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655845462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6KcRH4/KUHtf5xpIj4aJVy42n1FCoQeasRmMHkO/WZY=;
        b=Qt5LTOXlYE83qQIlY9uXeg0NSio4kzTD5sD2z1meOpp5+/htVZ9s/FSSUGW1lBQR9jzs7R
        /869uxLv166UfwxArOUE/onpxRNBRyvNx1wf+CGrm3mtXInCz9kGCI3yrF7WOTzjRSmkuC
        4Jwp4eQn0saKjdh8im+BFBA/UtTsK4g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-cEr2j4qbOVa_-EGnshGRsw-1; Tue, 21 Jun 2022 17:04:20 -0400
X-MC-Unique: cEr2j4qbOVa_-EGnshGRsw-1
Received: by mail-wm1-f72.google.com with SMTP id l3-20020a05600c1d0300b0039c7efa2526so6741964wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=6KcRH4/KUHtf5xpIj4aJVy42n1FCoQeasRmMHkO/WZY=;
        b=UgnIZlSKASWaaOUmjtlwihFogJix0pmbgtSD9OoWwavag6FXewZc0jT5/2E5SlAQ04
         0cvn+nsezebW1rIf6xtzKQJ8qTmyu3/4LvKGPUBh+Xxplu881AR+6bkChrzTO4/MDFGU
         pQjliI5+1XcnXpEwQet/xXkxHO/uwyfFw+XUvMcO1nteLK4OqX4HhgHjfm0IFZ5/569G
         0WzX+Hzn880H2/HxGF8WO49pSByTo0EfGghoyoKvQy/UKjdauyJOizQDOz8erp3N+0Of
         Nny4AgswIBD18lXIjJYHdgRqofU7G0AWz9GJCM5/fDS15C2eYguqh4lovpiWY/cIYKpb
         fgDg==
X-Gm-Message-State: AOAM530AuIUk3w8+16X3Syl5zkvVKt9IYXMvC/8YJMoQIltcEeJ6ROW4
        Hn3xUwG5vIryLXRJpN/1HwO4FkJluIACIH99YRjzr8rbsRFWjnZXEK+6GqbH2Q6N5EcpjReJdRz
        YHe1ju+2K6RPa/L/GxvAOnMRn
X-Received: by 2002:a1c:7411:0:b0:39c:8e4c:9704 with SMTP id p17-20020a1c7411000000b0039c8e4c9704mr42808297wmc.52.1655845459381;
        Tue, 21 Jun 2022 14:04:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm+wwv4IGBrN3CJ2eLl14IUYzF8AfIDUJBjL++7SCmt5nepLdvMx+y2Kx/kdCIkOHLNxnIWg==
X-Received: by 2002:a1c:7411:0:b0:39c:8e4c:9704 with SMTP id p17-20020a1c7411000000b0039c8e4c9704mr42808282wmc.52.1655845459151;
        Tue, 21 Jun 2022 14:04:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:bc00:a63c:7e37:6061:1706? (p200300cbc705bc00a63c7e3760611706.dip0.t-ipconnect.de. [2003:cb:c705:bc00:a63c:7e37:6061:1706])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d5503000000b0021b881c4c5csm10872237wrv.53.2022.06.21.14.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:04:18 -0700 (PDT)
Message-ID: <e25cb58c-464c-8bd4-c7da-9ab80b49f3bb@redhat.com>
Date:   Tue, 21 Jun 2022 23:04:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v10 11/69] mm/mmap: use the maple tree in find_vma()
 instead of the rbtree.
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-12-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220621204632.3370049-12-Liam.Howlett@oracle.com>
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
> Using the maple tree interface mt_find() will handle the RCU locking and
> will start searching at the address up to the limit, ULONG_MAX in this
> case.
> 
> Add kernel documentation to this API.
> 
> Link: https://lkml.kernel.org/r/20220504010716.661115-13-Liam.Howlett@oracle.com
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/mmap.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d7e6baa2f40f..fdb61252448f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2486,11 +2486,18 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  
>  EXPORT_SYMBOL(get_unmapped_area);
>  
> -/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> +/**
> + * find_vma() - Find the VMA for a given address, or the next vma.
> + * @mm: The mm_struct to check
> + * @addr: The address
> + *
> + * Returns: The VMA associated with addr, or the next vma.
> + * May return %NULL in the case of no vma at addr or above.

Nit: inconsistent use of VMA vs. vma.

> + */
>  struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  {
> -	struct rb_node *rb_node;
>  	struct vm_area_struct *vma;
> +	unsigned long index = addr;
>  
>  	mmap_assert_locked(mm);
>  	/* Check the cache first. */
> @@ -2498,22 +2505,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  	if (likely(vma))
>  		return vma;
>  
> -	rb_node = mm->mm_rb.rb_node;
> -
> -	while (rb_node) {
> -		struct vm_area_struct *tmp;
> -
> -		tmp = rb_entry(rb_node, struct vm_area_struct, vm_rb);
> -
> -		if (tmp->vm_end > addr) {
> -			vma = tmp;
> -			if (tmp->vm_start <= addr)
> -				break;
> -			rb_node = rb_node->rb_left;
> -		} else
> -			rb_node = rb_node->rb_right;
> -	}
> -
> +	vma = mt_find(&mm->mm_mt, &index, ULONG_MAX);

I guess it would be handy to have a mt_find() variant that simply
consumes an address, because for example here, we don't actually care
about the output semantics? Does anything speak against such a utility
function or is this here really just a corner case?

That would make that code *even easier* to read.

>  	if (vma)
>  		vmacache_update(addr, vma);
>  	return vma;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

