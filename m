Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AD358AFAC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbiHESVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240859AbiHESVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84B95DF89
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659723666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mlYKrCPjqQWFwXGPhouLeMfdvjXX0OuvjhFYgKbtVo=;
        b=f/zQKBEVaPYhfAyT7oiP9OtJBpkqzVDofrWNFRruL155ZVa3/iBfRDaBHPK4VcyRgqq5Tg
        fqqvOJsDgEsw4N6w44ayajsIIRE0Ez3B5aLJpyYo0AFgdZAo3H1txezYwOvDE/1ohexgzU
        XpaEyStLQvHZxoo17y9Yf9yHMr7Dgy4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-zeFGQf9qOwCq3NJNo_nRtg-1; Fri, 05 Aug 2022 14:21:05 -0400
X-MC-Unique: zeFGQf9qOwCq3NJNo_nRtg-1
Received: by mail-wm1-f70.google.com with SMTP id n30-20020a05600c501e00b003a3264465ebso3583483wmr.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 11:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=1mlYKrCPjqQWFwXGPhouLeMfdvjXX0OuvjhFYgKbtVo=;
        b=t7axQrR9Xzg3WNoZUoNWmAeXY9qrxne0uvlI1BCGbwK9p3tclsitFq0bK3XgIYWIBK
         QsCpw6jHLYjsWPU0mPkZ2F5qFC8MR9TH+vcS670ezTM/tuWnp9QDomohbW+IkjVG94T5
         o73BdsSPJ4iOEudfc41WJY3Slin2shPG05MBNJV0IwWuodjhVMud85h5xowPEknyxbQ4
         uL7lZhH2PP1qB1Srgp6PycrQZ2eGf1go/iufVMv4ejHmk89PE0za8SNXXWyD5y67dCy5
         QqPvousw6NTozDjZyP5+fEVWztTR3FFeOV8jWGxB5GUdOEBBaNa0YpvNWbYHNo5Y62e0
         MgHg==
X-Gm-Message-State: ACgBeo22hFawkMWfepzYVPxkZ59vcdktFdOvEpXhrJ0yCuYbkbipCyTE
        qnLws3Pfu05fNuZSySr+vkmt28RIR3oqrASIb4UadOid+Akhjji9QVUBDnZC1FLrm8Iktm8HaPD
        YAmcDsq1tVMAHWUk7Qi2b2vyX
X-Received: by 2002:a05:6000:1d83:b0:21e:9ed9:9f65 with SMTP id bk3-20020a0560001d8300b0021e9ed99f65mr4999198wrb.680.1659723664141;
        Fri, 05 Aug 2022 11:21:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7i4CdqcHfa6DOEyLxtbYSrdKepdnypk2RFZhmbQICBeV1CG3WNiQ8MQE2A6EUZkKDKZa/Xyg==
X-Received: by 2002:a05:6000:1d83:b0:21e:9ed9:9f65 with SMTP id bk3-20020a0560001d8300b0021e9ed99f65mr4999188wrb.680.1659723663892;
        Fri, 05 Aug 2022 11:21:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id t124-20020a1c4682000000b00397402ae674sm10043665wma.11.2022.08.05.11.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 11:21:03 -0700 (PDT)
Message-ID: <4f644ac5-c40b-32d4-3234-c1dac3d09f83@redhat.com>
Date:   Fri, 5 Aug 2022 20:20:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20220805110329.80540-1-david@redhat.com>
 <20220805110329.80540-3-david@redhat.com> <Yu1dkZeBwv0SUQMq@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/2] mm/hugetlb: support write-faults in shared
 mappings
In-Reply-To: <Yu1dkZeBwv0SUQMq@xz-m1.local>
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

On 05.08.22 20:12, Peter Xu wrote:
> On Fri, Aug 05, 2022 at 01:03:29PM +0200, David Hildenbrand wrote:
>> Let's add a safety net if we ever get (again) a write-fault on a R/O-mapped
>> page in a shared mapping, in which case we simply have to map the
>> page writable.
>>
>> VM_MAYSHARE handling in hugetlb_fault() for FAULT_FLAG_WRITE
>> indicates that this was at least envisioned, but could never have worked
>> as expected. This theoretically paves the way for softdirty tracking
>> support in hugetlb.
>>
>> Tested without the fix for softdirty tracking.
>>
>> Note that there is no need to do any kind of reservation in hugetlb_fault()
>> in this case ... because we already have a hugetlb page mapped R/O
>> that we will simply map writable and we are not dealing with COW/unsharing.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/hugetlb.c | 21 ++++++++++++++-------
>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index a18c071c294e..bbab7aa9d8f8 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -5233,6 +5233,16 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>>  	VM_BUG_ON(unshare && (flags & FOLL_WRITE));
>>  	VM_BUG_ON(!unshare && !(flags & FOLL_WRITE));
>>  
>> +	/* Let's take out shared mappings first, this should be a rare event. */
>> +	if (unlikely(vma->vm_flags & VM_MAYSHARE)) {
> 
> Should we check VM_SHARED instead?

Relying on VM_SHARED to detect MAP_PRIVATE vs. MAP_SHARED is
unfortunately wrong.

If you're curious, take a look at f83a275dbc5c ("mm: account for
MAP_SHARED mappings using VM_MAYSHARE and not VM_SHARED in hugetlbfs")
and mmap() code.

Long story short: if the file is read-only, we only have VM_MAYSHARE but
not VM_SHARED (and consequently also not VM_MAYWRITE).

> 
>> +		if (unshare)
>> +			return 0;
> 
> Curious when will this happen especially if we switch to VM_SHARED above.
> Shouldn't "unshare" not happen at all on a shared region?

FAULT_FLAG_UNSHARE is documented to behave like:

"FAULT_FLAG_UNSHARE is ignored and treated like an ordinary read fault
when no existing R/O-mapped anonymous page is encountered."

It should currently not happen. Focus on should ;)

> 
>> +		if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
>> +			return VM_FAULT_SIGSEGV;
> 
> I had a feeling that you just want to double check we have write
> permission, but IIUC this should be checked far earlier or we'll have
> problem.  No strong opinion if so, but I'd suggest dropping this one,
> otherwise we could add tons of WARN_ON_ONCE() in anywhere in the page fault
> stack and they mostly won't trigger at all.

Not quite. We usually (!hugetlb) have maybe_mkwrite() all over the
place. This is just an indication that we don't have maybe semantics
here. But as we also don't have it for hugetlb anon code below, maybe I
can just drop it. (or check it for both call paths)

> 
>> +		set_huge_ptep_writable(vma, haddr, ptep);
> 
> Do we wanna set dirty bits too?

set_huge_ptep_writable() handles that.

Thanks!


-- 
Thanks,

David / dhildenb

