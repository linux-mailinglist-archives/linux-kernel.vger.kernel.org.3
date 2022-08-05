Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAB058AF9B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbiHESMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiHESMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 468B832ECB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659723157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=azNlccd9KjWFp3EUvniWUfHZxqcCBT9BbelEFRqChqE=;
        b=IvXrhc8Ewkz9pBjkcIHg1m21kM3TUIncz55h4gNHIktDtDxw3/MQP1yhjcfqLPvtrimqLq
        aZzba3wuy7MMR4BfEYOdUNwbXxsxmcWuL1aIhDKsZyM2L0ZHj8yYDXxBk1SpIRBwX58iQB
        CiJbJX+t7Ov1lgt7C2k11BFL8y+hSSQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-oTeg_suBNWSFVLM2enS9fA-1; Fri, 05 Aug 2022 14:12:36 -0400
X-MC-Unique: oTeg_suBNWSFVLM2enS9fA-1
Received: by mail-qt1-f197.google.com with SMTP id bl15-20020a05622a244f00b0034218498b06so2419262qtb.14
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 11:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=azNlccd9KjWFp3EUvniWUfHZxqcCBT9BbelEFRqChqE=;
        b=bhNXA893AWJtSZ9Mqw0pdpqItYanWA6eJZpsQE8TBBPnEYALaqu2L4Q2aAj/BmNiHs
         b1aIB+pBM58kYzLjnE/fYciVmJRTmLTb9ps8fLGRu41rq5YRDRMdJUfyDCBvxGEFGcg4
         4ebdnv4p/tJ4alODzIPjGT0yadSs4ZWpEBvOGOlSM6lgzf7gSMEQ3dvHz4zgW8ezDcmB
         Fj9ogeVPS8Sy7iBOzxSMXOL0akpptHcgemEw2JTmcEzvOp0dWD0m7JPOE0jFj/OBRDQp
         j4hP9MCvCyaGCNxPYQ5iOiMGO7mjVtH4o7miJPqgnLJRoGvzbZSak4nPze+cOWxEkThw
         k+qg==
X-Gm-Message-State: ACgBeo2bXIM02qsqsQs6b9Tgld2QOlH4ne6rBH5p2pzKW37TRn6zgwFU
        GA0LWcedyXMK6+E6oKx3NNHasYPgEAysnwi2GWkSdFer7YSnV/fWzlqdBv7fgfQpSiGft66qdL2
        Cw4DiLwwc/vT74t8L2hI3Uzbz
X-Received: by 2002:a05:6214:2a82:b0:476:ae61:e61d with SMTP id jr2-20020a0562142a8200b00476ae61e61dmr6771262qvb.72.1659723155675;
        Fri, 05 Aug 2022 11:12:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6+9LksOO2oPrhIzWkwqZ+EqfBQakGdM7aUISj69kgv1WrYKGwj/U4NulEO1ZNnz+7hpY7zfw==
X-Received: by 2002:a05:6214:2a82:b0:476:ae61:e61d with SMTP id jr2-20020a0562142a8200b00476ae61e61dmr6771240qvb.72.1659723155432;
        Fri, 05 Aug 2022 11:12:35 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id i4-20020a05622a08c400b00342b7e4241fsm1728545qte.77.2022.08.05.11.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 11:12:34 -0700 (PDT)
Date:   Fri, 5 Aug 2022 14:12:33 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 2/2] mm/hugetlb: support write-faults in shared
 mappings
Message-ID: <Yu1dkZeBwv0SUQMq@xz-m1.local>
References: <20220805110329.80540-1-david@redhat.com>
 <20220805110329.80540-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220805110329.80540-3-david@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 01:03:29PM +0200, David Hildenbrand wrote:
> Let's add a safety net if we ever get (again) a write-fault on a R/O-mapped
> page in a shared mapping, in which case we simply have to map the
> page writable.
> 
> VM_MAYSHARE handling in hugetlb_fault() for FAULT_FLAG_WRITE
> indicates that this was at least envisioned, but could never have worked
> as expected. This theoretically paves the way for softdirty tracking
> support in hugetlb.
> 
> Tested without the fix for softdirty tracking.
> 
> Note that there is no need to do any kind of reservation in hugetlb_fault()
> in this case ... because we already have a hugetlb page mapped R/O
> that we will simply map writable and we are not dealing with COW/unsharing.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/hugetlb.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a18c071c294e..bbab7aa9d8f8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5233,6 +5233,16 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>  	VM_BUG_ON(unshare && (flags & FOLL_WRITE));
>  	VM_BUG_ON(!unshare && !(flags & FOLL_WRITE));
>  
> +	/* Let's take out shared mappings first, this should be a rare event. */
> +	if (unlikely(vma->vm_flags & VM_MAYSHARE)) {

Should we check VM_SHARED instead?

> +		if (unshare)
> +			return 0;

Curious when will this happen especially if we switch to VM_SHARED above.
Shouldn't "unshare" not happen at all on a shared region?

> +		if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
> +			return VM_FAULT_SIGSEGV;

I had a feeling that you just want to double check we have write
permission, but IIUC this should be checked far earlier or we'll have
problem.  No strong opinion if so, but I'd suggest dropping this one,
otherwise we could add tons of WARN_ON_ONCE() in anywhere in the page fault
stack and they mostly won't trigger at all.

> +		set_huge_ptep_writable(vma, haddr, ptep);

Do we wanna set dirty bits too?

> +		return 0;
> +	}

-- 
Peter Xu

