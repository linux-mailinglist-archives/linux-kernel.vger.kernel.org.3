Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C764F1577
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiDDNGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbiDDNGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2685FB9D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649077481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKLcnrXpl+KcZQr63lS1etgImM+Jisa8A4Tv6u94WeY=;
        b=LpZpYnJWLfiBRI5iwOr6GsZvvPjrrVRniAK7Pn6w/9e+J361t/68NyNr+e3ZKNzgdrUPyl
        h7nnAuXnGhiASXS5/E5Hkjt0j8sNU7rjYbKGBh70UEPOXBbCN9u+NCu/JknPLVS7D4Cv6J
        901qOBSdcR5/XC8Y5ctcffnkeuT1L+Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-Oo_20ewZPt6HHbMiceYzhg-1; Mon, 04 Apr 2022 09:04:31 -0400
X-MC-Unique: Oo_20ewZPt6HHbMiceYzhg-1
Received: by mail-wr1-f70.google.com with SMTP id i64-20020adf90c6000000b00203f2b5e090so1719825wri.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=bKLcnrXpl+KcZQr63lS1etgImM+Jisa8A4Tv6u94WeY=;
        b=qQ0u97ZGY6tYpVTzSxwkelM3hPynxjppnppe81URqqwBiVLZJY6gJnneCpqmpqJCfo
         KnLwy5RZWDh+ItnxxtYLJJ9V9kglnIz2SCOGDO9EcvZDxcQSM/h8Eez1jQ+BuSjyjeCq
         3m7zn423KTX72zCZDgt6a9sDjSJY6qeBsnlE4IfxWacIeQfk/GL4C7QkBa5CdtEXaF7N
         C9BtMQkTWzp3HpRFmnNSPweK6/K3dZrdsDkbrUVKldj0DZeZvr6veJZoXzJ6Uz5uGSHU
         utLTjoIbdHpyrO5JqRLo+QldFNhZkuTyUUnvdpi/tKgZd0Ru9PWViarH41rbTjzQCXr7
         Vutw==
X-Gm-Message-State: AOAM532hgsKuvqdsikstU3dHO/WJvTGVR4CdNiujMdiNptjJHI+wIns7
        spKqWQFO+wkStUIYokcpyaEcYcvZ9s1Hg92jJIPS2gDNmkfuu4WVNuWPp8s84HdODfDUIv4i/fc
        p0G1PBaJ18Q/RQCuZGB4T10zp
X-Received: by 2002:a5d:6b0f:0:b0:1e7:9432:ee8c with SMTP id v15-20020a5d6b0f000000b001e79432ee8cmr16587423wrw.216.1649077469856;
        Mon, 04 Apr 2022 06:04:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxtY/OPGax1qO/sx2WuexL7oOLf1eJuj6oF4bfJe58bEmh/NxbXjXnOtYCPACR/NKBsTM8ZA==
X-Received: by 2002:a5d:6b0f:0:b0:1e7:9432:ee8c with SMTP id v15-20020a5d6b0f000000b001e79432ee8cmr16587382wrw.216.1649077469430;
        Mon, 04 Apr 2022 06:04:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4100:c220:ede7:17d4:6ff4? (p200300cbc7044100c220ede717d46ff4.dip0.t-ipconnect.de. [2003:cb:c704:4100:c220:ede7:17d4:6ff4])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d6da7000000b00203d9d1875bsm10501373wrs.73.2022.04.04.06.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 06:04:28 -0700 (PDT)
Message-ID: <99cf9e14-7608-8e72-0c8e-0dd9b0047319@redhat.com>
Date:   Mon, 4 Apr 2022 15:04:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
References: <20220401101334.68859-1-david@redhat.com>
 <8A6AF878-D5D7-4D88-A736-0FEF71439D44@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 mmotm] mm/mprotect: try avoiding write faults for
 exclusive anonynmous pages when changing protection
In-Reply-To: <8A6AF878-D5D7-4D88-A736-0FEF71439D44@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.22 21:15, Nadav Amit wrote:
> [ +Rick ]
> 
>> On Apr 1, 2022, at 3:13 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> Similar to our MM_CP_DIRTY_ACCT handling for shared, writable mappings, we
>> can try mapping anonymous pages writable if they are exclusive,
>> the PTE is already dirty, and no special handling applies. Mapping the
>> PTE writable is essentially the same thing the write fault handler would do
>> in this case.
> 
> In general I am all supportive for such a change.
> 
> I do have some mostly-minor concerns.

Hi Nadav,

thanks a lot for your review!

> 
>>
>> +static inline bool can_change_pte_writable(struct vm_area_struct *vma,
>> +					   unsigned long addr, pte_t pte,
>> +					   unsigned long cp_flags)
>> +{
>> +	struct page *page;
>> +
>> +	if ((vma->vm_flags & VM_SHARED) && !(cp_flags & MM_CP_DIRTY_ACCT))
>> +		/*
>> +		 * MM_CP_DIRTY_ACCT is only expressive for shared mappings;
>> +		 * without MM_CP_DIRTY_ACCT, there is nothing to do.
>> +		 */
>> +		return false;
>> +
>> +	if (!(vma->vm_flags & VM_WRITE))
>> +		return false;
>> +
>> +	if (pte_write(pte) || pte_protnone(pte) || !pte_dirty(pte))
>> +		return false;
> 
> If pte_write() is already try then return false? I understand you want
> to do so because the page is already writable, but it is confusing.


I thought about just doing outside of the function

if ((vma->vm_flags & VM_WRITE) && !pte_write(pte) &&
    can_change_pte_writable()...

	
I refrained from doing so because the sequence of checks might be
sub-optimal. But most probably we don't really care about that and it
might make the code easier to grasp.

Would that make it clearer?

> 
> In addition, I am not sure about the pte_dirty() check is really robust.
> I mean I think it is ok, but is there any issue with shadow-stack? 

Judging that it's already used that way for VMAs with dirty tracking, I
assume it's ok. Without checking that the PTE is dirty, we'd have to do a:

pte_mkwrite(pte_mkwrite(ptent));

Which would set the pte and consequently the page dirty, although there
might not even be a write access. That's what we want to avoid here.

> 
> And this also assumes the kernel does not clear the dirty bit without
> clearing the present, as otherwise the note in Intel SDM section 4.8
> ("Accessed and Dirty Flags”) will be relevant and dirty bit might be
> set unnecessarily. I think it is ok.

Yeah, I think so as well.

> 
>> +
>> +	/* Do we need write faults for softdirty tracking? */
>> +	if (IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) && !pte_soft_dirty(pte) &&
>> +	    (vma->vm_flags & VM_SOFTDIRTY))
> 
> If !IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) then VM_SOFTDIRTY == 0. So I do not
> think the IS_ENABLED() is necessary (unless you think it is clearer this
> way).

Right, we can just do

if ((vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))

and it should get fully optimized out. Thanks!

> 
>> +		return false;
>> +
>> +	/* Do we need write faults for uffd-wp tracking? */
>> +	if (userfaultfd_pte_wp(vma, pte))
>> +		return false;
>> +
>> +	if (!(vma->vm_flags & VM_SHARED)) {
>> +		/*
>> +		 * We can only special-case on exclusive anonymous pages,
>> +		 * because we know that our write-fault handler similarly would
>> +		 * map them writable without any additional checks while holding
>> +		 * the PT lock.
>> +		 */
>> +		page = vm_normal_page(vma, addr, pte);
> 
> I guess we cannot call vm_normal_page() twice, once for prot_numa and once
> here, in practice...

I guess we could, but it doesn't necessarily make the code easier to
read :) And we want to skip protnone either way.

> 
>> +		if (!page || !PageAnon(page) || !PageAnonExclusive(page))
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
> 
> Note that there is a small downside to all of that. Assume you mprotect()
> a single page from RO to RW and you have many threads.
> 
> With my pending patch you would avoid the TLB shootdown (and get a PF).
> With this patch you would get a TLB shootdown and save the PF. IOW, I
> think it is worthy to skip the shootdown as well in such a case and
> instead flush the TLB on spurious page-faults. But I guess that’s for
> another patch.

Just so I understand correctly: your optimization avoids the flush when
effectively, nothing changed (R/O -> R/O).

And the optimization for this case here would be, to avoid the TLB flush
when similarly not required (R/O -> R/W).

Correct?

-- 
Thanks,

David / dhildenb

