Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F074E4A9533
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357131AbiBDIfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:35:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357033AbiBDIfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643963705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewbjKA3RobEmPNVV+e+ATnicxNeLPCBA7u2EECMhFbw=;
        b=AqmxeIpLOnirYKYHlclZzv36TeAc2yYv05giHGlacYn2P/O9uBv9G+rqg8XJjw3J2RPMiN
        JR+oBHLGOzsNjW9k1LVavgXjuu5kYxga/VtCfxqUfeZBbSFRWOe3BY5Llp9CmEz4TgTU3y
        LqmoT2UpesB/huD8KVNVzNAsxhLaTCc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-K_eFAUNuN6OF8jTUniQNcQ-1; Fri, 04 Feb 2022 03:35:04 -0500
X-MC-Unique: K_eFAUNuN6OF8jTUniQNcQ-1
Received: by mail-wr1-f72.google.com with SMTP id e1-20020adfa741000000b001e2e74c3d4eso41701wrd.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 00:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ewbjKA3RobEmPNVV+e+ATnicxNeLPCBA7u2EECMhFbw=;
        b=TFVXWWuaC/ESgAnxbETQi4X1pmAlvaw/1QueF0vl1WRZxGxD/ytQc2tL3sPd8RtKGj
         kLXf74pr7CJNlkYg3PY4XqERRs/RtxR3OADu2j3MdHgD0wIEHKoJU6+Y1tlnYx2XIqlS
         MEWMkYHk9wLskbxhWHu/0UfSzF/8p/lli0cDOhvdc6m46BFQNgvmJz5qEP5xSQg30ouc
         EvZJcS+bGJfiyN/PkRUGXkgVGTLyicr6FrM2ZKFyy6/5lkcz8JdnvwJ0RyHpCfgfQwu8
         If/O/ZegGTtyo3qlTEGlyDOa4lj3uKuYs4WveLpkSHSC45iz5Hu/IdCbAuTn7vzhGPfN
         If5w==
X-Gm-Message-State: AOAM533OucJzC5gx3RaI3Ydy4i7qjwL9KMKH/QTlWxk+/icr57Zlt110
        +eKbJsFsccptefkSYUOVY8DejL2E+Mfii96arY3jbX9Ikn3F557loFfwj4dVWz5lg7vzMSPnFXF
        Fc6XIPgNhasJ6Bd55IjI0ruhA
X-Received: by 2002:a05:600c:3d89:: with SMTP id bi9mr1320792wmb.18.1643963703137;
        Fri, 04 Feb 2022 00:35:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBvUZTIxtC1omsCPEeZauaVUQ6J2EG+VIt2M/0eGF+OUlWBkCIfRYq6sravtSXE+E3rSngbA==
X-Received: by 2002:a05:600c:3d89:: with SMTP id bi9mr1320766wmb.18.1643963702801;
        Fri, 04 Feb 2022 00:35:02 -0800 (PST)
Received: from ?IPV6:2003:d8:2f11:9700:838c:3860:6500:5284? (p200300d82f119700838c386065005284.dip0.t-ipconnect.de. [2003:d8:2f11:9700:838c:3860:6500:5284])
        by smtp.gmail.com with ESMTPSA id l11sm1428118wry.50.2022.02.04.00.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 00:35:02 -0800 (PST)
Message-ID: <6a82ea68-6e1e-8f5a-ca89-6744fc896a0b@redhat.com>
Date:   Fri, 4 Feb 2022 09:35:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
 <20220202014034.182008-2-mike.kravetz@oracle.com>
 <20571829-9d3d-0b48-817c-b6b15565f651@redhat.com>
 <7b174c48-d368-43ba-7eab-13719a0d15ef@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
In-Reply-To: <7b174c48-d368-43ba-7eab-13719a0d15ef@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +	/*
>>> +	 * start and size (end - start) must be huge page size aligned
>>> +	 * for hugetlb vmas.
>>> +	 */
>>> +	if (is_vm_hugetlb_page(vma)) {
>>> +		struct hstate *h = hstate_vma(vma);
>>> +
>>> +		start = ALIGN_DOWN(start, huge_page_size(h));
>>> +		end = ALIGN(end, huge_page_size(h));
>>
>> So you effectively extend the range silently. IIUC, if someone would zap
>> a 4k range you would implicitly zap a whole 2M page and effectively zero
>> out more data than requested.
>>
>>
>> Looking at do_madvise(), we:
>> (1) reject start addresses that are not page-aligned
>> (2) shrink lengths that are not page-aligned and refuse if it turns 0
> 
> I believe length is extended (rounded up) by this line:
> 	len = PAGE_ALIGN(len_in);

Ah, right. I was confused by the "!len" check below that, but the
comment explains how this applies to negative values only.

> 
> but, I see your point.
> 
>> The man page documents (1) but doesn't really document (2).
>>
>> Naturally I'd have assume that we apply the same logic to huge page
>> sizes and documenting it in the man page accordingly.
>>
>>
>> Why did you decide to extend the range? I'd assume MADV_REMOVE behaves
>> like FALLOC_FL_PUNCH_HOLE:
>>   "Within the specified range, partial filesystem blocks are zeroed, and
>>    whole filesystem blocks are removed from the file.  After a
>>    successful call, subsequent reads from  this  range will return
>>    zeros."
>> So we don't "discard more than requested".
> 
> Well.  hugetlbfs does not follow the man page. :(  It does not zero
> partial blocks.  I assume a filesystem block would be a huge page.
> Instead it does,
> 
>         /*
>          * For hole punch round up the beginning offset of the hole and
>          * round down the end.
>          */
>         hole_start = round_up(offset, hpage_size);
>         hole_end = round_down(offset + len, hpage_size);

Okay, so we skip any zeroing and only free completely covered blocks. We
might want to document that behavior. See below.

> 
> So, not only is this patch not following the man page.  It is not even
> following the existing MADV_REMOVE hugetlb code.  Thanks for pointing
> that out.  Part of my reason for adding this functionality was to make
> hugetlb be more like 'normal' memory.  I clearly failed.

:)

> 
> Related comment about madvise man page for PAGE_SIZE MADV_REMOVE.  The man
> page says.
> 
>        MADV_REMOVE (since Linux 2.6.16)
>               Free up a given range of pages and its associated backing store.
>               This is equivalent to punching a hole in the corresponding  byte
>               range  of  the backing store (see fallocate(2)).  Subsequent ac‐
>               cesses in the specified address range will see bytes  containing
>               zero.
> 
> This may need some clarification.  It says it will free pages.  We know
> madvise only operates on pages (PAGE_ALIGN(len)).  Yet, the statement about
> equivalent to a fallocate byte range may lead one to believe that length is
> treated the same in madvise and fallocate.

Yes

> 
>> I see the following possible alternatives:
>> (a) Fail if the range is not aligned
>> -> Clear semantics
>> (b) Fail if the start is not aligned, shrink the end if required
>> -> Same rules as for PAGE_SIZE
>> (c) Zero out the requested part
>> -> Same semantics as FALLOC_FL_PUNCH_HOLE.
>>
>> My preference would be a), properly documenting it in the man page.
> 
> However, a) would make hugetlb behave differently than other memory as
> len does not need to be aligned.
> 
> I would prefer b) as it is more in line with PAGE_SIZE.  But, that does
> make it different than MADV_REMOVE hugetlb alignment.
> 
> I thought this was simple. :)

It really bugs me that it's under-specified what's supposed to happen
when the length is not aligned.

BUT: in the posix world, "calling posix_madvise() shall not affect the
semantics of access to memory in the specified range". So we don't care
too much about if we align up/down, because it wouldn't affect the
semantics. Especially for MADV_DONTNEED/MADV_REMOVE as implemented by
Linux this is certainly different and the alignment handling matters.

So I guess especially for MADV_DONTNEED/MADV_REMOVE we need a clear
specification what's supposed to happen if the length falls into the
middle of a huge page. We should document alignment handling for
madvise() in general I assume.

IMHO we should have bailed out right from the start whenever something
is not properly aligned, but that ship has sailed. So I agree, maybe we
can make at least hugetlb MADV_DONTNEED obey the same (weird) rules as
ordinary pages.

So b) would mean, requiring start to be hugepage aligned and aligning-up
the end. Still feels wrong but at least matches existing semantics.

Hugetlb MADV_REMOVE semantics are unfortunate and we should document the
exception.

-- 
Thanks,

David / dhildenb

