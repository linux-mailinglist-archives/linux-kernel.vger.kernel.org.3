Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5939557DAA2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiGVHJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVHJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D30A8E6F8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658473753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W03YUh23JrP2otyQElwrVQuoO95BxhmDO5t8VZsxiZg=;
        b=XaKcl6Tt7Y4YgiRs1TO/81uTDDURj13FL3x4HUACfGwlbGHI09sX7DuueC7O9Pl7Dcu4Z4
        YPImVeBlQtwfN5ZDTcTLC6b0nO9s+Sn8vt/Avqpkd13oJ5hzZXv7TOa/E5zxFcgq8ExLDU
        ugu5zEFjPJ0HU+whhwG1IQTujkFb8yI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-FGEiHQTYNnWWydVDc7msbA-1; Fri, 22 Jul 2022 03:09:10 -0400
X-MC-Unique: FGEiHQTYNnWWydVDc7msbA-1
Received: by mail-wm1-f72.google.com with SMTP id i184-20020a1c3bc1000000b003a026f48333so2090668wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=W03YUh23JrP2otyQElwrVQuoO95BxhmDO5t8VZsxiZg=;
        b=UkDUqCT3rv+pjyzVNDLDmrMWhTkKXvCnHOnC3BpBRwtcXmNEV/BXRe5uiDStaIPfF9
         2XM+pl4MUeuyxTGZwC9CoaQMd2mMcvJM/eTVA9r89MDMSEJay0kskxhkpT4hUKPrRCR/
         t8yrJxW89spKtBBfDg+hLff+ylVlwxjZ/LcHFhHGsj6MVj5u99uo6FDvlZcBqyrbtrTG
         suOgy5ofF3tqmAuPWQkfzrqlN3o1rI1uJHqa9CGxRTgg3edqFe83piMkoMzekYf2JwTp
         FjVZPj8+19dKD/6K0S1fWYg2M7f6Q7IYzUjcScv1mvi/nU3rPHzP9zap3+maCY+KSdu9
         20/A==
X-Gm-Message-State: AJIora8ERj+F5GhVY4QyEH2JggQfPViiDEfJH7wVktHCvobYCkpDJY94
        +le+h4EcvFIJNy1yWeoNiQMxOrapmG7kJ2yX41XFplzbixFn1mBbsHal2XMekoNa2djXwbLTcGX
        f9f4/wpsld43I91l3iOpz3uO5
X-Received: by 2002:a05:600c:4fc5:b0:3a3:2d73:c147 with SMTP id o5-20020a05600c4fc500b003a32d73c147mr8316868wmq.197.1658473749588;
        Fri, 22 Jul 2022 00:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vNPXifmqewhxBZfVs3JuSQs7OOt8RXLQG57YuQglvjvnMqQDHZomYGAjWysqcCNy2Su6Xigg==
X-Received: by 2002:a05:600c:4fc5:b0:3a3:2d73:c147 with SMTP id o5-20020a05600c4fc500b003a32d73c147mr8316827wmq.197.1658473749022;
        Fri, 22 Jul 2022 00:09:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6? (p200300cbc707cb00cd6b7964cc7db0e6.dip0.t-ipconnect.de. [2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003a0323463absm4039820wmc.45.2022.07.22.00.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 00:09:08 -0700 (PDT)
Message-ID: <e35e42ce-e942-141d-09e7-a3a7868f4abb@redhat.com>
Date:   Fri, 22 Jul 2022 09:08:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20220721183338.27871-1-peterx@redhat.com>
 <20220721183338.27871-2-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
In-Reply-To: <20220721183338.27871-2-peterx@redhat.com>
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

On 21.07.22 20:33, Peter Xu wrote:
> The check wanted to make sure when soft-dirty tracking is enabled we won't
> grant write bit by accident, as a page fault is needed for dirty tracking.
> The intention is correct but we didn't check it right because VM_SOFTDIRTY
> set actually means soft-dirty tracking disabled.  Fix it.
> 
> There's another thing tricky about soft-dirty is that, we can't check the
> vma flag !(vma_flags & VM_SOFTDIRTY) directly but only check it after we
> checked CONFIG_MEM_SOFT_DIRTY because otherwise VM_SOFTDIRTY will be
> defined as zero, and !(vma_flags & VM_SOFTDIRTY) will constantly return
> true.  To avoid misuse, introduce a helper for checking whether vma has
> soft-dirty tracking enabled.
> 


[...]

> 
> Here we attach a Fixes to commit 64fe24a3e05e only for easy tracking, as
> this patch won't apply to a tree before that point.  However the commit
> wasn't the source of problem, it's just that then anonymous memory will
> also suffer from this problem with mprotect().

I'd remove that paragraph and also add

Fixes: 64e455079e1b ("mm: softdirty: enable write notifications on VMAs after VM_SOFTDIRTY cleared")

That introduced this wrong check for pagecache pages AFAIKS.

We don't care if the patch applies before 64fe24a3e05e, if someone wants to
backport the fix, they can just adjust it accordingly.

> 
> Fixes: 64fe24a3e05e ("mm/mprotect: try avoiding write faults for exclusive anonymous pages when changing protection")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/internal.h | 18 ++++++++++++++++++
>  mm/mmap.c     |  2 +-
>  mm/mprotect.c |  2 +-
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 15e8cb118832..e2d442e3c0b2 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -860,4 +860,22 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
>  
>  DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>  
> +static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
> +{
> +	/*
> +	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
> +	 * enablements, because when without soft-dirty being compiled in,
> +	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
> +	 * will be constantly true.
> +	 */
> +	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> +		return false;
> +
> +	/*
> +	 * Soft-dirty is kind of special: its tracking is enabled when the
> +	 * vma flags not set.
> +	 */
> +	return !(vma->vm_flags & VM_SOFTDIRTY);
> +}

That will come in handy in other patches I'm cooking.

> +
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 125e8903c93c..93f9913409ea 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1518,7 +1518,7 @@ int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
>  		return 0;
>  
>  	/* Do we need to track softdirty? */
> -	if (IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) && !(vm_flags & VM_SOFTDIRTY))
> +	if (vma_soft_dirty_enabled(vma))
>  		return 1;
>  
>  	/* Specialty mapping? */
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 0420c3ed936c..c403e84129d4 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -49,7 +49,7 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
>  		return false;
>  
>  	/* Do we need write faults for softdirty tracking? */
> -	if ((vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
> +	if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
>  		return false;
>  
>  	/* Do we need write faults for uffd-wp tracking? */


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

