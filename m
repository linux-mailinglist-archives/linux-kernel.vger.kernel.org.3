Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C64495ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350301AbiAUMER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:04:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348969AbiAUMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642766653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=plqbI4uQzIC/HoJcD7z9G3CYldKJvWvJe9PZR7YBaFw=;
        b=Jtl9hB66IjJDMWdGKVnfu3P11Do/D3uh3ebYyEeRddOZozVKxyssAOmeWTWQEPNffcdFYY
        67UMpnOMB3I1B7Ax8bJST8yPZE9kv7qBsshQ6rGPFb8iUyP/8+aI+iMed0444HHg+/hMRZ
        dJcMAFfz/ZxwM3M4Rwuook9u89H4az8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-kPXSSe-jML6Hc9-u4XSB5A-1; Fri, 21 Jan 2022 07:04:12 -0500
X-MC-Unique: kPXSSe-jML6Hc9-u4XSB5A-1
Received: by mail-wm1-f72.google.com with SMTP id az10-20020a05600c600a00b0034d64b1203aso8013936wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=plqbI4uQzIC/HoJcD7z9G3CYldKJvWvJe9PZR7YBaFw=;
        b=Oa4Zp2J1rBj9tTYedgCsmO5YVlU5/Vs8oL4P2INFiBdM70S/FPh4T+MsryNJYmO5da
         yiboXbgDg5HO7jxD2pD4YpwMDvbQJQLBbGqOiRi4owfegnuq8Ds5H4ArB45rdjW1apls
         MLPGrsZR4U5CZ/RFNxtBOzoJansdoIM/TRl/ZJlBFoshO8mPM1VqGNztmXek796emdXs
         xTPInTJSmDpYPsjLZhwB/f5yqcqwyNsZzK8ySH/6FOvwInRXRf+BkYimWurQ3sn1qUTk
         521wZR2Kek6UhYfm29syIs2flcaF80GJqjdbHJUjdm/wRh1P3Olk9fT4NaSoAAnrDsou
         W5WA==
X-Gm-Message-State: AOAM530pAEBdNvqzXO87Yvv8NjGIsJqmnBNzTKi4gykhxJS04lhV8+vb
        w6r+gjeYbbTADOF7YrIJVeveivVTe6M7/pVAFfxdIKaNWRDy60nop3WhVW+cVTLhacnxUsd/eOG
        A7zFKmVo8Cxsy+22h3ZokFwrZ
X-Received: by 2002:a1c:e913:: with SMTP id q19mr442669wmc.87.1642766651152;
        Fri, 21 Jan 2022 04:04:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvtpL32Y4x8vX37wPiF8/xHj0kcayPEkakqi21Uxs2dZI2m36gZPvmSDiRnKhy6IhJsvH1JA==
X-Received: by 2002:a1c:e913:: with SMTP id q19mr442652wmc.87.1642766650942;
        Fri, 21 Jan 2022 04:04:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:a200:adf9:611a:39a8:435a? (p200300cbc709a200adf9611a39a8435a.dip0.t-ipconnect.de. [2003:cb:c709:a200:adf9:611a:39a8:435a])
        by smtp.gmail.com with ESMTPSA id 8sm6727265wrz.57.2022.01.21.04.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 04:04:10 -0800 (PST)
Message-ID: <7744b904-4803-1c8e-3a1c-eebd30f2da91@redhat.com>
Date:   Fri, 21 Jan 2022 13:04:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
References: <20220120155517.066795336@infradead.org>
 <20220120160822.666778608@infradead.org>
 <ffb88819-a392-84f3-d40f-7406be8e3165@redhat.com>
 <20220121075157.GA20638@worktop.programming.kicks-ass.net>
 <20220121085917.GA22849@worktop.programming.kicks-ass.net>
 <10d6cc13-b96b-e1b6-8751-1b245b242738@redhat.com>
 <20220121114058.GE20638@worktop.programming.kicks-ass.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC][PATCH v2 1/5] mm: Avoid unmapping pinned pages
In-Reply-To: <20220121114058.GE20638@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.22 12:40, Peter Zijlstra wrote:
> On Fri, Jan 21, 2022 at 10:04:45AM +0100, David Hildenbrand wrote:
>> On 21.01.22 09:59, Peter Zijlstra wrote:
> 
>>> However, I'm not quite sure what fork() does with pages that have a pin.
>>
>> We COW the anon pages always, and we protect against concurrent GUP
>> using the
>> * mmap_lock in exclusive mode for ordinary GUP
>> * mm->write_protect_seq for GUP-fast
> 
> Right, but neither the mmap_sem nor the write_protect_seq help anything
> at all vs already extant page pins.
> 
> But I just found copy_present_page()'s page_needs_cow_for_dma(), which I
> think deals with exactly that case, it avoids doing CoW on pinned pages
> and instead feeds the child a full copy while keeping the pinned page in
> the original process.

Yes, page_needs_cow_for_dma() is the magic bit. The locking I explained
keep its output "reliable".

> 
>>> Naively, a page that has async DMA activity should not be CoW'ed, or if
>>> it is, care must be taken to ensure the original pages stays in the
>>> original process, but I realize that's somewhat hard.
>>
>> That's precisely what I'm working on fixing ... and yes, it's hard.
>>
>> Let me know if you need any other information, I've spent way too much
>> time on this than I ever panned.
> 
> So let me try and get this right:
> 
>  - GUP post-fork breaks CoW for FOLL_WRITE/FOLL_PIN, without either
>    there's a problem where one task might observe changes by another.
> 
>  - GUP pre-fork prevents CoW and does a full copy.

Yes, pretty much.

> 
> And that all mostly works, except for a fair amount of 'fun' cases?

I'd say some obviously broken cases, some racy cases, some fun cases :)


We have three main cases. And usually, trying to tackle one triggers
another.

(1) Missed CoW

If the child R/O pins and unmaps the page, the parent might miss to CoW
and reuse the page. Security issue. Once CVE in that area is currently
still applicable for THP (well, and hugetlb).

(2) Unnecessary CoW

We CoW instead of reusing the page, but there are no relevant pins, so
it's unnecessary.

(3) Wrong CoW

We CoW a page that has relevant pins, losing synchronicity between GUP
and the page tables.


The "criticality" is (1), (3), (2).

(3) can currently get triggered by anything that can map a pinned page
R/O. The racy case is what I described about the swapcache. Other broken
cases are mprotect() and friends (we cannot differentiate between R/O
and R/W pins ...).


-- 
Thanks,

David / dhildenb

