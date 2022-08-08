Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A158CBD1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiHHQFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiHHQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EBC1E49
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659974720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pr6iF/TtZ25Rn6ZY2ogRbqXiMq4oLu2Igv/PRch7AW4=;
        b=V1xR9fUxU4lBJtS3fugEWocZNkCAD7o6defWCyPDCyO0WAQnwn0kF9scqbz+Y69A+a6xD5
        mpbJEVpoiLlQCV1xbd+7pG9KW8FU5n1umSnudQENsMwQ6NPouSkInfYvog7HRkSZjpm9gH
        uRCAjK0pIGtD9wik1QPr5DPE9oX8wck=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486--R_SsdWxPhexPRQR-2hF_Q-1; Mon, 08 Aug 2022 12:05:19 -0400
X-MC-Unique: -R_SsdWxPhexPRQR-2hF_Q-1
Received: by mail-il1-f197.google.com with SMTP id j5-20020a056e02218500b002de1cf2347bso6748213ila.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=pr6iF/TtZ25Rn6ZY2ogRbqXiMq4oLu2Igv/PRch7AW4=;
        b=DcWXqQOG0n+oPeOtlaVRj+iv/yL+7fTUYyxRYm2lduUaCXjMHyLRebKtat6tddQBhz
         T6167wMLBIP0uUS/GyXiIHd/rFs2Cp2VkuF7moDu8C1DltYjyYniF65Qo9ctW2jSgj0N
         nqHlXDU/cmrid8gz6pqIz8TRV0ODkOOIvJ/Jd2ywc0apr5eLDpFQaPBNDFjqnDWKpX35
         drsSp0yQMsZAu1/d7fnZrKmheiSJX3xYjXYAFfQYETY9SyWtHHYbYWWujDA7Pb6LAnsH
         DoLTYUpOO68Xo+E/vwVDbBzBmWwYSdB+iiR2AhAAKzDdNK3RjCCJM/r4U/pDT87zeh4F
         l0Yw==
X-Gm-Message-State: ACgBeo1A/xdzfQrySoqjOrBWL6Tmovz/yw/n2oyvkotuCM32uBgdtRiB
        oeUMYuVCpwJjhS/gcESlstJWtTAnBR931P5MePLl6UV3h3ToH91ZobhkYPx5qdHlL7St56Q2sIQ
        gm5xUyvgLH+3x2tFdzNpzKihF
X-Received: by 2002:a05:6e02:1d8a:b0:2de:aa0d:b99e with SMTP id h10-20020a056e021d8a00b002deaa0db99emr8615592ila.138.1659974718327;
        Mon, 08 Aug 2022 09:05:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5hxO2cm5lfMWEyGlowPa05C8Tvdxxfr5EXfxxt7IQET3PvVfQIjV9iMQ5zAEYyH9ZaAzBR2A==
X-Received: by 2002:a05:6e02:1d8a:b0:2de:aa0d:b99e with SMTP id h10-20020a056e021d8a00b002deaa0db99emr8615579ila.138.1659974718091;
        Mon, 08 Aug 2022 09:05:18 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id x10-20020a92b00a000000b002e0f21f0be4sm30529ilh.27.2022.08.08.09.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:05:17 -0700 (PDT)
Date:   Mon, 8 Aug 2022 12:05:15 -0400
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
Message-ID: <YvE0OwsyQEL3K5Hm@xz-m1.local>
References: <20220805110329.80540-1-david@redhat.com>
 <20220805110329.80540-3-david@redhat.com>
 <Yu1dkZeBwv0SUQMq@xz-m1.local>
 <4f644ac5-c40b-32d4-3234-c1dac3d09f83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f644ac5-c40b-32d4-3234-c1dac3d09f83@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 08:20:52PM +0200, David Hildenbrand wrote:
> On 05.08.22 20:12, Peter Xu wrote:
> > On Fri, Aug 05, 2022 at 01:03:29PM +0200, David Hildenbrand wrote:
> >> Let's add a safety net if we ever get (again) a write-fault on a R/O-mapped
> >> page in a shared mapping, in which case we simply have to map the
> >> page writable.
> >>
> >> VM_MAYSHARE handling in hugetlb_fault() for FAULT_FLAG_WRITE
> >> indicates that this was at least envisioned, but could never have worked
> >> as expected. This theoretically paves the way for softdirty tracking
> >> support in hugetlb.
> >>
> >> Tested without the fix for softdirty tracking.
> >>
> >> Note that there is no need to do any kind of reservation in hugetlb_fault()
> >> in this case ... because we already have a hugetlb page mapped R/O
> >> that we will simply map writable and we are not dealing with COW/unsharing.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  mm/hugetlb.c | 21 ++++++++++++++-------
> >>  1 file changed, 14 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index a18c071c294e..bbab7aa9d8f8 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -5233,6 +5233,16 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
> >>  	VM_BUG_ON(unshare && (flags & FOLL_WRITE));
> >>  	VM_BUG_ON(!unshare && !(flags & FOLL_WRITE));
> >>  
> >> +	/* Let's take out shared mappings first, this should be a rare event. */
> >> +	if (unlikely(vma->vm_flags & VM_MAYSHARE)) {
> > 
> > Should we check VM_SHARED instead?
> 
> Relying on VM_SHARED to detect MAP_PRIVATE vs. MAP_SHARED is
> unfortunately wrong.
> 
> If you're curious, take a look at f83a275dbc5c ("mm: account for
> MAP_SHARED mappings using VM_MAYSHARE and not VM_SHARED in hugetlbfs")
> and mmap() code.
> 
> Long story short: if the file is read-only, we only have VM_MAYSHARE but
> not VM_SHARED (and consequently also not VM_MAYWRITE).

To ask in another way: if file is RO but mapped RW (mmap() will have
VM_SHARED cleared but VM_MAYSHARE set), then if we check VM_MAYSHARE here
won't we grant write bit errornously while we shouldn't? As the user
doesn't really have write permission to the file.

> 
> > 
> >> +		if (unshare)
> >> +			return 0;
> > 
> > Curious when will this happen especially if we switch to VM_SHARED above.
> > Shouldn't "unshare" not happen at all on a shared region?
> 
> FAULT_FLAG_UNSHARE is documented to behave like:
> 
> "FAULT_FLAG_UNSHARE is ignored and treated like an ordinary read fault
> when no existing R/O-mapped anonymous page is encountered."
> 
> It should currently not happen. Focus on should ;)

OK. :)

Then does it also mean that it should be better to turn into
WARN_ON_ONCE()?  It's just that it looks like a valid path if without it.

> 
> > 
> >> +		if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
> >> +			return VM_FAULT_SIGSEGV;
> > 
> > I had a feeling that you just want to double check we have write
> > permission, but IIUC this should be checked far earlier or we'll have
> > problem.  No strong opinion if so, but I'd suggest dropping this one,
> > otherwise we could add tons of WARN_ON_ONCE() in anywhere in the page fault
> > stack and they mostly won't trigger at all.
> 
> Not quite. We usually (!hugetlb) have maybe_mkwrite() all over the
> place. This is just an indication that we don't have maybe semantics
> here. But as we also don't have it for hugetlb anon code below, maybe I
> can just drop it. (or check it for both call paths)

Hmm, this reminded me to wonder how hugetlb handles FOLL_FORCE|FOLL_WRITE
on RO regions.

Maybe that check is needed, but however instead of warning and sigbus, we
need to handle it?

I'll need to read more on this later, but raise this up.

> 
> > 
> >> +		set_huge_ptep_writable(vma, haddr, ptep);
> > 
> > Do we wanna set dirty bits too?
> 
> set_huge_ptep_writable() handles that.

Right, I noticed it right after I sent too..

Thanks,

-- 
Peter Xu

