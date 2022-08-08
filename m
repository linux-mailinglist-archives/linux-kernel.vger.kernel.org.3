Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C864B58CC14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbiHHQZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbiHHQZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08435EBA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659975925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBJ8/l6jgpOV8t0mdJlCv5sc7ShJ57oNHXIQuHMcQt4=;
        b=RR1NHH2XNFEFYNyWWoVCfajrmBy/CLc7vxvZxNw5JcHkA6q/x/rwZgxWmQR2uY9xCwuWsz
        3jiuQ2aXcs6lBcEQ5WVJazystKgW7AXrmtNs8DJXL76HQCwE2ZliOHd4IKLp8rm4IA/ET7
        697oDd7CfXj11i4zxriWFerRxI08y98=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-oWhjDAG1OS-efZ-sL6af0A-1; Mon, 08 Aug 2022 12:25:23 -0400
X-MC-Unique: oWhjDAG1OS-efZ-sL6af0A-1
Received: by mail-wm1-f71.google.com with SMTP id c17-20020a7bc011000000b003a2bfaf8d3dso4930603wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=GBJ8/l6jgpOV8t0mdJlCv5sc7ShJ57oNHXIQuHMcQt4=;
        b=cOpRu9JC0SNNF42QAY/VO9MX+DRTjycBJ2NfzUx28sjpsrWEnod0fhec1rbtBAjpju
         Ny6XheQM6pLzNxHpwoLbEcgn8y0LZQpFHTYz+OjTYkXL8IFJLEWK06O4MltNL7aksUHf
         XGdADcF8V3EP+FgW5JFATtPgW1dNy9vUz2Nec502BeoTaavUYxr70cxygN5fsA1fpqHQ
         jdTnY7qLCf5UiJKOfQwwEzBrdyBE8cLZmY+t5+2UnQrP0tSP7h+zzvqNflEboEMZYIvb
         ojkQ6PIb5TOu1j6R6fl7RJdfNqY1qi0yAaldaUq/uflmMeYqYWwG//fWoYRpssmJH7Hp
         FpRQ==
X-Gm-Message-State: ACgBeo0grK8Bxh7JPt25IUd3ZbGQjGbUayyyUApG3sXRcDsytaACzv22
        KHh1YP5yDNm0qhINTmOLL/OfVc00h3r1KOEboYjxIU07OXmVY9vQEG9DAlKcZa0tor3VWj6cO0g
        KrwZveEIlJBm6XVpormR2X3B4
X-Received: by 2002:a05:6000:1a41:b0:20e:687f:1c3 with SMTP id t1-20020a0560001a4100b0020e687f01c3mr11602881wry.415.1659975922582;
        Mon, 08 Aug 2022 09:25:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5BAckX9l8cHaxk/zqkDO693mHCwu095nPZhvHuFjfESQPSw4kK4Ra96V+4C7Y5PJPf+bRrUQ==
X-Received: by 2002:a05:6000:1a41:b0:20e:687f:1c3 with SMTP id t1-20020a0560001a4100b0020e687f01c3mr11602869wry.415.1659975922271;
        Mon, 08 Aug 2022 09:25:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:c300:d2ce:1fb5:2460:179a? (p200300d82f15c300d2ce1fb52460179a.dip0.t-ipconnect.de. [2003:d8:2f15:c300:d2ce:1fb5:2460:179a])
        by smtp.gmail.com with ESMTPSA id e27-20020adfa45b000000b0021e519eba9bsm11790660wra.42.2022.08.08.09.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 09:25:21 -0700 (PDT)
Message-ID: <8b317ac7-f80e-4aab-4ad1-4e19a1a0740f@redhat.com>
Date:   Mon, 8 Aug 2022 18:25:21 +0200
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
 <4f644ac5-c40b-32d4-3234-c1dac3d09f83@redhat.com>
 <YvE0OwsyQEL3K5Hm@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/2] mm/hugetlb: support write-faults in shared
 mappings
In-Reply-To: <YvE0OwsyQEL3K5Hm@xz-m1.local>
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

>> Relying on VM_SHARED to detect MAP_PRIVATE vs. MAP_SHARED is
>> unfortunately wrong.
>>
>> If you're curious, take a look at f83a275dbc5c ("mm: account for
>> MAP_SHARED mappings using VM_MAYSHARE and not VM_SHARED in hugetlbfs")
>> and mmap() code.
>>
>> Long story short: if the file is read-only, we only have VM_MAYSHARE but
>> not VM_SHARED (and consequently also not VM_MAYWRITE).
> 
> To ask in another way: if file is RO but mapped RW (mmap() will have
> VM_SHARED cleared but VM_MAYSHARE set), then if we check VM_MAYSHARE here
> won't we grant write bit errornously while we shouldn't? As the user
> doesn't really have write permission to the file.

Thus the VM_WRITE check. :)

I wonder if we should just do it cleanly and introduce the maybe_mkwrite
semantics here as well. Then there is no need for additional VM_WRITE
checks and hugetlb will work just like !hugetlb.

Thoughts?

> 
>>
>>>
>>>> +		if (unshare)
>>>> +			return 0;
>>>
>>> Curious when will this happen especially if we switch to VM_SHARED above.
>>> Shouldn't "unshare" not happen at all on a shared region?
>>
>> FAULT_FLAG_UNSHARE is documented to behave like:
>>
>> "FAULT_FLAG_UNSHARE is ignored and treated like an ordinary read fault
>> when no existing R/O-mapped anonymous page is encountered."
>>
>> It should currently not happen. Focus on should ;)
> 
> OK. :)
> 
> Then does it also mean that it should be better to turn into
> WARN_ON_ONCE()?  It's just that it looks like a valid path if without it.

Well, it should work (and we handle the !hugetlb path) like that as
well. So I'd want to avoid WARN_ON_ONCE() at least for that check.


> 
>>
>>>
>>>> +		if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
>>>> +			return VM_FAULT_SIGSEGV;
>>>
>>> I had a feeling that you just want to double check we have write
>>> permission, but IIUC this should be checked far earlier or we'll have
>>> problem.  No strong opinion if so, but I'd suggest dropping this one,
>>> otherwise we could add tons of WARN_ON_ONCE() in anywhere in the page fault
>>> stack and they mostly won't trigger at all.
>>
>> Not quite. We usually (!hugetlb) have maybe_mkwrite() all over the
>> place. This is just an indication that we don't have maybe semantics
>> here. But as we also don't have it for hugetlb anon code below, maybe I
>> can just drop it. (or check it for both call paths)
> 
> Hmm, this reminded me to wonder how hugetlb handles FOLL_FORCE|FOLL_WRITE
> on RO regions.
> 
> Maybe that check is needed, but however instead of warning and sigbus, we
> need to handle it?

We don't support FOLL_FORCE|FOLL_WRITE for hugetlb, but if we would,
we'd need the maybe_mkwrite semantics.

Fortunately I detest private hugetlb mappings / anon hugetlb pages and
couldn't care less about debug access until it's actually a problem for
someone :)

-- 
Thanks,

David / dhildenb

