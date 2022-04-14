Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4192C501D29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346783AbiDNVKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbiDNVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E7E5BE52
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649970499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=50hb9t2hWQpx3A7gqpiBQ8RZfEOgSrHlGcFbRUMDwYE=;
        b=a1PxToFf9FiIv0/7j2R0mjkPDOVjYsT/wKhiztBcXuObjxtVSffJWRuyl9qpOvB7tTTX1u
        40WUVh55yT3jWayhOJOkxIAQ9sycHIqllB7Uvss2yuIkKr537MCsgaXwjHVJG3ZUT6KOZ1
        2Q5C6fMXkFZ9pZWnk1HkaexJsK53Fqo=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-b166euY0PM-GAz_ve2G3eg-1; Thu, 14 Apr 2022 17:08:18 -0400
X-MC-Unique: b166euY0PM-GAz_ve2G3eg-1
Received: by mail-io1-f71.google.com with SMTP id h14-20020a05660208ce00b00645c339411bso3725268ioz.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=50hb9t2hWQpx3A7gqpiBQ8RZfEOgSrHlGcFbRUMDwYE=;
        b=5cGUzhpNys0HEsz5hr893HmyDxz+yO6S4aKWr8HGZq5oZ9Z2HiEPuykJBfHYrPtcv8
         AWkzmwwdAhV0SWtwiTfa2WBQPtSfl8Ke/5H7vIFy0KvdIM0TnNB1X9zmL0KexoTpT/qR
         TuLw4a515JMQ0rovKHcrFHumkEDceNn2Srg5onnSVPlOa3FiabnLwdbm3swrxGAAzBqq
         mosLqSpP2qGPXOf0dg9GdyHDx/XnPpaXEBr/3eKZFLIWhx6jUi1Ho/RG5UUDNbG0viny
         gdxqxjzRyKA1i0wen83Rybm3uZRP95Yq/MxCw7IuOi7rPcyLCadN3YUj6uQuUDoBURw7
         UBXQ==
X-Gm-Message-State: AOAM530D9WBL+1jFP4OHffd7NJtqu7GmLD+VZEOHv7QRjws8w3JTZ1wB
        xaMz4I7J48PkKdrAb1aqv0nU6r1tWRCNq1ytdSzYnFyA3iEYaY/H5NMr5jGXboUuE+07hCm8rOy
        rTUEAaLA7/oNrIs7ezRxAbA/s
X-Received: by 2002:a02:a40d:0:b0:326:72dd:feb8 with SMTP id c13-20020a02a40d000000b0032672ddfeb8mr2047809jal.303.1649970498011;
        Thu, 14 Apr 2022 14:08:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrSXg03wSwlqNUJEo5bOLrh3rEmDmIMlVB4DukeCQuZK49xyTij9i84kCWVWLY49WnoHGUTQ==
X-Received: by 2002:a02:a40d:0:b0:326:72dd:feb8 with SMTP id c13-20020a02a40d000000b0032672ddfeb8mr2047790jal.303.1649970497702;
        Thu, 14 Apr 2022 14:08:17 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id h24-20020a6bfb18000000b006497692016bsm1800923iog.15.2022.04.14.14.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 14:08:17 -0700 (PDT)
Date:   Thu, 14 Apr 2022 17:08:15 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v8 03/23] mm: Check against orig_pte for finish_fault()
Message-ID: <YliNP7ADcdc4Puvs@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014836.14077-1-peterx@redhat.com>
 <CGME20220413140330eucas1p167da41e079712b829ef8237dc27b049c@eucas1p1.samsung.com>
 <710c48c9-406d-e4c5-a394-10501b951316@samsung.com>
 <Ylb9rXJyPm8/ao8f@xz-m1.local>
 <6ccf5f5f-8dc5-16cc-f06c-78401b822a54@samsung.com>
 <YlhMDmko0IN82d21@xz-m1.local>
 <20220414135740.42fb26be9e13d2aada35f140@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220414135740.42fb26be9e13d2aada35f140@linux-foundation.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 01:57:40PM -0700, Andrew Morton wrote:
> On Thu, 14 Apr 2022 12:30:06 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > 
> > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > 
> > Thanks, Marek, for the fast feedback!
> 
> Certainly.
> 
> > I've also verified it for the uffd-wp case so the whole series keeps
> > running as usual and nothing else shows up after the new patch replaced.
> > 
> > Andrew, any suggestion on how we proceed with the replacement patch?
> > E.g. do you want me to post it separately to the list?
> 
> I turned it into an incremental diff and queued it against [03/23]:
> 
> --- a/include/linux/mm_types.h~mm-check-against-orig_pte-for-finish_fault-fix
> +++ a/include/linux/mm_types.h
> @@ -814,6 +814,8 @@ typedef struct {
>   * @FAULT_FLAG_UNSHARE: The fault is an unsharing request to unshare (and mark
>   *                      exclusive) a possibly shared anonymous page that is
>   *                      mapped R/O.
> + * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
> + *                        We should only access orig_pte if this flag set.
>   *
>   * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
>   * whether we would allow page faults to retry by specifying these two
> @@ -850,6 +852,7 @@ enum fault_flag {
>  	FAULT_FLAG_INSTRUCTION =	1 << 8,
>  	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
>  	FAULT_FLAG_UNSHARE =		1 << 10,
> +	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
>  };
>  
>  #endif /* _LINUX_MM_TYPES_H */
> --- a/mm/memory.c~mm-check-against-orig_pte-for-finish_fault-fix
> +++ a/mm/memory.c
> @@ -4194,6 +4194,15 @@ void do_set_pte(struct vm_fault *vmf, st
>  	set_pte_at(vma->vm_mm, addr, vmf->pte, entry);
>  }
>  
> +static bool vmf_pte_changed(struct vm_fault *vmf)
> +{
> +	if (vmf->flags & FAULT_FLAG_ORIG_PTE_VALID) {
> +		return !pte_same(*vmf->pte, vmf->orig_pte);
> +	}
> +
> +	return !pte_none(*vmf->pte);
> +}
> +
>  /**
>   * finish_fault - finish page fault once we have prepared the page to fault
>   *
> @@ -4252,7 +4261,7 @@ vm_fault_t finish_fault(struct vm_fault
>  				      vmf->address, &vmf->ptl);
>  	ret = 0;
>  	/* Re-check under ptl */
> -	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
> +	if (likely(!vmf_pte_changed(vmf)))
>  		do_set_pte(vmf, page, vmf->address);
>  	else
>  		ret = VM_FAULT_NOPAGE;
> @@ -4720,13 +4729,7 @@ static vm_fault_t handle_pte_fault(struc
>  		 * concurrent faults and from rmap lookups.
>  		 */
>  		vmf->pte = NULL;
> -		/*
> -		 * Always initialize orig_pte.  This matches with below
> -		 * code to have orig_pte to be the none pte if pte==NULL.
> -		 * This makes the rest code to be always safe to reference
> -		 * it, e.g. in finish_fault() we'll detect pte changes.
> -		 */
> -		pte_clear(vmf->vma->vm_mm, vmf->address, &vmf->orig_pte);
> +		vmf->flags &= ~FAULT_FLAG_ORIG_PTE_VALID;
>  	} else {
>  		/*
>  		 * If a huge pmd materialized under us just retry later.  Use
> @@ -4750,6 +4753,7 @@ static vm_fault_t handle_pte_fault(struc
>  		 */
>  		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
>  		vmf->orig_pte = *vmf->pte;
> +		vmf->flags |= FAULT_FLAG_ORIG_PTE_VALID;
>  
>  		/*
>  		 * some architectures can have larger ptes than wordsize,
> _
> 

I verified the diff, that matches with what I got.  Thanks Andrew.

-- 
Peter Xu

