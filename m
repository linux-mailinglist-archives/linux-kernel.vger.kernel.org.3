Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185A54F9201
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiDHJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiDHJ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E5CF23D744
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649409967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1epDrVyBwEQgvDGzorG+PC/lz08GO+3kCvmSNbPLn8=;
        b=gFUO8gZfy4S7eLbwNKkMPINuGVUzeBvdT5VuwVnIetiYD3DEWBk14uhbah1D19GqDWai6f
        oq7ZC7abT/ewJ9PEz1azmTSZif69dk8jIDbdhZHJBRRYsr9BPuiLla4KCLE5bZ9fPkXNlO
        nAEaYEpOawMqJC1vhZaKq0/lEM9D4X8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-RW17v8piOO-KLdzs1lMyDA-1; Fri, 08 Apr 2022 05:26:06 -0400
X-MC-Unique: RW17v8piOO-KLdzs1lMyDA-1
Received: by mail-wr1-f71.google.com with SMTP id x17-20020adfbb51000000b002060ff71a3bso2056602wrg.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 02:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=T1epDrVyBwEQgvDGzorG+PC/lz08GO+3kCvmSNbPLn8=;
        b=5nTybk+htafSKyaiuneZtTQmZqTKMxmv6PHSreaTs/RVQ5dPpGcNiKRJwtVR+iL4oB
         f8qZTM6pqkPXQzcwV7X/OtH5UQh9h7n2WwJoe3TFlMnOGR6rbdbImD9XD2RL4J+Gip55
         wZWqNZ7Nn9oNt24pi42EtbmyTtv38SZwa6OXQ+MhCvAoqzsrpUKZo2iWdxj3yoixD3gG
         IyOT8xEDy0G8JEKOp/g+UP6EF6tAAJZMvuLk8UJNh2HGyQIJDC0QQ4pL5Xmum6P5D4u6
         Vb8RB3EuEuUAYrK45nn3ozgzIGhNMmveVUT02EocgCstiOhWxuoC8C2l0DMtV+e+YTN7
         ZDAQ==
X-Gm-Message-State: AOAM530dq8AsSdewh9xxeMPIiSPdMe4Ow6yPXflQXrbV07WGCuWt9/Ut
        3a0qV2iYXiOWrXbIghzeJsHYX1fy8fXBNDALtPipYGL7YQznnsU+jfTlk6BJt+oq2xNbGpLVB5u
        hZ90uM1RvoesyUTfuF6nyIUC2
X-Received: by 2002:a5d:5108:0:b0:207:8a3e:dc0a with SMTP id s8-20020a5d5108000000b002078a3edc0amr5311246wrt.675.1649409964995;
        Fri, 08 Apr 2022 02:26:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykKAIz79E8TG/VSntdo5a/hLx8x45PcnYHzk/ulEsXZTfQfIYBUYwMui1zrqtYlQLvi+hS2A==
X-Received: by 2002:a5d:5108:0:b0:207:8a3e:dc0a with SMTP id s8-20020a5d5108000000b002078a3edc0amr5311229wrt.675.1649409964742;
        Fri, 08 Apr 2022 02:26:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:fd00:612:f12b:a4a2:26b0? (p200300cbc704fd000612f12ba4a226b0.dip0.t-ipconnect.de. [2003:cb:c704:fd00:612:f12b:a4a2:26b0])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0038cbcbcf994sm10549617wmq.36.2022.04.08.02.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 02:26:04 -0700 (PDT)
Message-ID: <dcda550d-a92a-c95e-bd08-c578924d7f8d@redhat.com>
Date:   Fri, 8 Apr 2022 11:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH 0/5] hugetlb: Change huge pmd sharing
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220406204823.46548-1-mike.kravetz@oracle.com>
 <045a59a1-0929-a969-b184-1311f81504b8@redhat.com>
 <4ddf7d53-db45-4201-8ae0-095698ec7e1a@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <4ddf7d53-db45-4201-8ae0-095698ec7e1a@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Let's assume a 4 TiB device and 2 MiB hugepage size. That's 2097152 huge
>> pages. Each such PMD entry consumes 8 bytes. That's 16 MiB.
>>
>> Sure, with thousands of processes sharing that memory, the size of page
>> tables required would increase with each and every process. But TBH,
>> that's in no way different to other file systems where we're even
>> dealing with PTE tables.
> 
> The numbers for a real use case I am frequently quoted are something like:
> 1TB shared mapping, 10,000 processes sharing the mapping
> 4K PMD Page per 1GB of shared mapping
> 4M saving for each shared process
> 9,999 * 4M ~= 39GB savings

3.7 % of all memory. Noticeable if the feature is removed? yes. Do we
care about supporting such corner cases that result in a maintenance
burden? My take is a clear no.

> 
> However, if you look at commit 39dde65c9940c which introduced huge pmd sharing
> it states that performance rather than memory savings was the primary
> objective.
> 
> "For hugetlb, the saving on page table memory is not the primary
>  objective (as hugetlb itself already cuts down page table overhead
>  significantly), instead, the purpose of using shared page table on hugetlb is
>  to allow faster TLB refill and smaller cache pollution upon TLB miss.
>     
>  With PT sharing, pte entries are shared among hundreds of processes, the
>  cache consumption used by all the page table is smaller and in return,
>  application gets much higher cache hit ratio.  One other effect is that
>  cache hit ratio with hardware page walker hitting on pte in cache will be
>  higher and this helps to reduce tlb miss latency.  These two effects
>  contribute to higher application performance."
> 
> That 'makes sense', but I have never tried to measure any such performance
> benefit.  It is easier to calculate the memory savings.

It does makes sense; but then, again, what's specific here about hugetlb?

Most probably it was just easy to add to hugetlb in contrast to other
types of shared memory.

> 
>>
>> Which results in me wondering if
>>
>> a) We should simply use gigantic pages for such extreme use case. Allows
>>    for freeing up more memory via vmemmap either way.
> 
> The only problem with this is that many processors in use today have
> limited TLB entries for gigantic pages.
> 
>> b) We should instead look into reclaiming reconstruct-able page table.
>>    It's hard to imagine that each and every process accesses each and
>>    every part of the gigantic file all of the time.
>> c) We should instead establish a more generic page table sharing
>>    mechanism.
> 
> Yes.  I think that is the direction taken by mshare() proposal.  If we have
> a more generic approach we can certainly start deprecating hugetlb pmd
> sharing.

My strong opinion is to remove it ASAP and get something proper into place.

-- 
Thanks,

David / dhildenb

