Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884DD57B969
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbiGTPUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiGTPUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:20:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBB195A891
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658330402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXIv8z6wgYrxtRmSkO6MksNcPo7L1KXy6iCAgLmfCq8=;
        b=iC8uzrlGR0mVwwZvh+F6sRaJ6eIm+zREjeMGA2Aq+kPhGnwVoXAs3hv31Lp1ADHE7iTlwE
        7NF7OYoS5WNQuCo0DfhrIMwVhP5hnAmJ8rMQ2ONwuf61ObFV/KferleHApNSUm+t9oTIx4
        Po5lfRmh9c9aMDnnnIuMOhhBFFiNfII=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-M4XIYVdhPTWE00qg4KO2jQ-1; Wed, 20 Jul 2022 11:20:01 -0400
X-MC-Unique: M4XIYVdhPTWE00qg4KO2jQ-1
Received: by mail-wm1-f71.google.com with SMTP id h65-20020a1c2144000000b003a30cae106cso1381907wmh.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=vXIv8z6wgYrxtRmSkO6MksNcPo7L1KXy6iCAgLmfCq8=;
        b=NJdlkOxAXH5n1etHBLb0WT6NIRTA+ULv/WhnNoa1kxjBSxm3IS3NPpFUaYEdwhwTZV
         ql4wqPpD03C9cPX17qG509rcEqBzVhl6GNARpZA1pZoXrqETnmBwuh+7+rP4ZoaIfVyh
         Xc1lAMZf/a0VH+HhMlP++mmfCqgVUohQelGbCFliHym2uXLfhJOEWzWHRZbtH8R7/6aw
         ssxbHjn9IlHfujki5NwsqM7xZGXs0FsNznB8Vne06eaHahFsOP/3tAmvltZ1NNEDka9W
         mkg7G9/wnpJ5dZ18KZ7275lTUJPNYecbWokWtvbOefbJIVgUNNhFmvtqfdJWHvqj2ylq
         mrHQ==
X-Gm-Message-State: AJIora/CzqEPj3h6bAcFti0U0WPPpp8/U0gzMiIUdBR97JAlHas8i97H
        mO8CurKvb4kRG4SPd9J71loqh08XzA3TN79dSCthD78R2xKZZa4opNN9P+acg5Fv4Ub3NBpZlGc
        W1Ib/UjNhGmBZvEyjdOxMoR//
X-Received: by 2002:a05:6000:1ac8:b0:21d:b7d9:3c03 with SMTP id i8-20020a0560001ac800b0021db7d93c03mr30044896wry.149.1658330400079;
        Wed, 20 Jul 2022 08:20:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vhY4jMlcvydLqIIfpJUjBSd/bdgLq4ERjsnYiBMvxcW+HJNzw85znY51iyKWzZ3ktA+WCuNQ==
X-Received: by 2002:a05:6000:1ac8:b0:21d:b7d9:3c03 with SMTP id i8-20020a0560001ac800b0021db7d93c03mr30044869wry.149.1658330399812;
        Wed, 20 Jul 2022 08:19:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:e00:8d96:5dba:6bc4:6e89? (p200300cbc7060e008d965dba6bc46e89.dip0.t-ipconnect.de. [2003:cb:c706:e00:8d96:5dba:6bc4:6e89])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c068600b003a2e5caab12sm2576603wmn.47.2022.07.20.08.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 08:19:59 -0700 (PDT)
Message-ID: <23a9d678-487e-5940-4cde-dc53d920fb48@redhat.com>
Date:   Wed, 20 Jul 2022 17:19:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 03/14] mm/mprotect: allow exclusive anon pages to be
 writable
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-4-namit@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220718120212.3180-4-namit@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.22 14:02, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Anonymous pages might have the dirty bit clear, but this should not
> prevent mprotect from making them writable if they are exclusive.
> Therefore, skip the test whether the page is dirty in this case.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Nick Piggin <npiggin@gmail.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  mm/mprotect.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 34c2dfb68c42..da5b9bf8204f 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -45,7 +45,7 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
>  
>  	VM_BUG_ON(!(vma->vm_flags & VM_WRITE) || pte_write(pte));
>  
> -	if (pte_protnone(pte) || !pte_dirty(pte))
> +	if (pte_protnone(pte))
>  		return false;
>  
>  	/* Do we need write faults for softdirty tracking? */
> @@ -66,7 +66,8 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
>  		page = vm_normal_page(vma, addr, pte);
>  		if (!page || !PageAnon(page) || !PageAnonExclusive(page))
>  			return false;
> -	}
> +	} else if (!pte_dirty(pte))
> +		return false;
>  
>  	return true;
>  }

When I wrote that code, I was wondering how often that would actually
happen in practice -- and if we care about optimizing that. Do you have
a gut feeling in which scenarios this would happen and if we care?

If the page is in the swapcache and was swapped out, you'd be requiring
a writeback even though nobody modified the page and possibly isn't
going to do so in the near future.

-- 
Thanks,

David / dhildenb

