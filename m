Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5414FDCBE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354171AbiDLKip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379315AbiDLKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 331655DE55
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649756235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqASKl2JW8OF7//R5gBnGu+2jzFwc031nNCcqeSxD8M=;
        b=Ndqh2IJ5OXQcBMA03UXfFIr1GcdLF+jj15h/MlTulVTXXK0JYml/A8e6QRzrBwWjR4yJy9
        JF5l2kggwyLRmGbBjnjh5tWSG3vF8/XkgM+tXNkQFlwNP6hkwHPbGbxQy7mOm38pegsj3/
        xdnOeGCkN8Fa60XQbT9tNfuNvZoMEd4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-boxZPR8YP1-UgW2tf2V3Xw-1; Tue, 12 Apr 2022 05:37:13 -0400
X-MC-Unique: boxZPR8YP1-UgW2tf2V3Xw-1
Received: by mail-wm1-f72.google.com with SMTP id q25-20020a1ce919000000b0038ead791083so1021717wmc.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=QqASKl2JW8OF7//R5gBnGu+2jzFwc031nNCcqeSxD8M=;
        b=tKIoNENpDxQUlLwXB4wTqho4PSLDVa9w2eef8Ae59kyi6dgVJ590C6bYrr+haCCiVj
         zUFsuw8jsmAlG7KLTKM/a154yeJf5sKZnzyqz2kGbTg8wJbTEpogxzjZdeO4r7XduG9k
         YyJ++5afe4vQBr4IpntvNfnCFDHvqlQp8blemzHKhtxzNcYvlq+4jJgLW7sN1DG9susO
         N+JmTh53NEDbIFHSRgezJd+SL/yzaMkSkyNoxfnarJxeEKP0Qk+lEHWwvI6rhVCZNc4X
         tRSPuqlXZNgMwy/ECW0NT0ECrLt4rf19uHe9C9UWdJJgXS/yHnpuOut62P/ihvQC+dMz
         YKeA==
X-Gm-Message-State: AOAM530AsNw17kN12tY1OyqL1tC9BazPVmhbNFPLbvBitzYqieR7tYtd
        vfmiXjBUeSY2Tu9eWBXrYTjm4vxO12POw9bTWv9ZRa9JEDi7P78Y44sb52eyYeA2Mup1cEU1lNU
        mW0cwVLUw6D/HmlVGBgLpgucf
X-Received: by 2002:a05:600c:1f17:b0:38b:b2b3:9faa with SMTP id bd23-20020a05600c1f1700b0038bb2b39faamr3334638wmb.190.1649756231977;
        Tue, 12 Apr 2022 02:37:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFdKjiRGvmX5jcrTl/ai7AaND7+BndRgIvrorg6KZ5vxUMxir/XkgirRzWpwcfBCleZLlw0A==
X-Received: by 2002:a05:600c:1f17:b0:38b:b2b3:9faa with SMTP id bd23-20020a05600c1f1700b0038bb2b39faamr3334613wmb.190.1649756231691;
        Tue, 12 Apr 2022 02:37:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1800:7c14:16cc:5291:a9f3? (p200300cbc70718007c1416cc5291a9f3.dip0.t-ipconnect.de. [2003:cb:c707:1800:7c14:16cc:5291:a9f3])
        by smtp.gmail.com with ESMTPSA id g1-20020a5d64e1000000b002079b871795sm9059647wri.50.2022.04.12.02.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 02:37:11 -0700 (PDT)
Message-ID: <368902ab-8d3f-5d62-581e-1ff930bcefa0@redhat.com>
Date:   Tue, 12 Apr 2022 11:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 08/16] mm/rmap: drop "compound" parameter from
 page_add_new_anon_rmap()
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220329160440.193848-1-david@redhat.com>
 <20220329160440.193848-9-david@redhat.com>
 <4cb92b41-95e1-1666-321e-96ff9e6095bb@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <4cb92b41-95e1-1666-321e-96ff9e6095bb@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.22 10:47, Vlastimil Babka wrote:
> On 3/29/22 18:04, David Hildenbrand wrote:
>> New anonymous pages are always mapped natively: only THP/khugepagd code
> 
> 						khugepaged ^
> 
>> maps a new compound anonymous page and passes "true". Otherwise, we're
>> just dealing with simple, non-compound pages.
>>
>> Let's give the interface clearer semantics and document these.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Nit:
> 
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1182,19 +1182,22 @@ void page_add_anon_rmap(struct page *page,
>>  }
>>  
>>  /**
>> - * page_add_new_anon_rmap - add pte mapping to a new anonymous page
>> + * page_add_new_anon_rmap - add mapping to a new anonymous page
>>   * @page:	the page to add the mapping to
>>   * @vma:	the vm area in which the mapping is added
>>   * @address:	the user virtual address mapped
>> - * @compound:	charge the page as compound or small page
>> + *
>> + * If it's a compound page, it is accounted as a compound page. As the page
>> + * is new, it's assume to get mapped exclusively by a single process.
>>   *
>>   * Same as page_add_anon_rmap but must only be called on *new* pages.
>>   * This means the inc-and-test can be bypassed.
>>   * Page does not have to be locked.
>>   */
>>  void page_add_new_anon_rmap(struct page *page,
>> -	struct vm_area_struct *vma, unsigned long address, bool compound)
>> +	struct vm_area_struct *vma, unsigned long address)
>>  {
>> +	const bool compound = PageCompound(page);
>>  	int nr = compound ? thp_nr_pages(page) : 1;
>>  
>>  	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
> 
> There's a VM_BUG_ON_PAGE(PageTransCompound(page), page); later in a
> !compound branch. Since compound is now determined by the same check, could
> be deleted.
> 

Yes, eventually we could get rid of both VM_BUG_ON_PAGE() on both
branches and add a single VM_BUG_ON_PAGE(PageTail(page), page) check on
the compound branch. (we could also make sure that we're not given a
hugetlb page)

-- 
Thanks,

David / dhildenb

