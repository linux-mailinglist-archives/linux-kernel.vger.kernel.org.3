Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C482F5A86B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiHaTZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiHaTZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC958168D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661973927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3ggwS2nrH2KekbfZ8v1RY68Sf9S2v0ryOgRAbqObHY=;
        b=MbvWZrPydzf+A6bjyFPrEKpBK8zEt+GxAabdDbdCy/mrV84tACXoblEwXB4cArEVkv5reU
        NNPUHdCSs2MRPnUqOJVY7DRDJXEkEJXuJSL3YdPdu2hJGBdnN0BqKUQEz8YbDsB4t/SE+r
        LcRdRLkRTtT8YEu8wimjVxdUloquSpE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-459-fnBmVQqDMX2K8ZqcZhrPpA-1; Wed, 31 Aug 2022 15:25:25 -0400
X-MC-Unique: fnBmVQqDMX2K8ZqcZhrPpA-1
Received: by mail-wm1-f69.google.com with SMTP id r83-20020a1c4456000000b003a7b679981cso102072wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=y3ggwS2nrH2KekbfZ8v1RY68Sf9S2v0ryOgRAbqObHY=;
        b=WeDu8Gn1wQ6BKi4z5aJ3/I2/eziitN3GqH7FSGgP8Ge+znEI7VlKZQy5C5fE0rd4Y7
         vcSoQJEHj9mDnMHAAh7E1rc7tPQyUZkz/8TPx4N9b/WdsOCbzXk9aUGuUOD1QJ1S1M+A
         o/pZpNXPx4qctWksRIK+a3HflV7Fz7F517I7e3WGXBCFtxwPRazVOXIJXguG9qFEhLbp
         sx61QIZVhCXGs/uZweDzm3aYYCSQJPURf7aFt2QlQCcMHMFNkoQ4SZRYi2OsMic5eNFG
         /LA2PBu5ojmZn9635iDEOL0k8Q2Zx0xPqoRcJEfBW/TvrzH2yT7vuBZja+rIQyZp72MA
         N+sw==
X-Gm-Message-State: ACgBeo1LyaxaXsMENy1qx/iegpJItSqF1KRauw80DEV+qVMnlKRyYZ2I
        Lzd8EA0Z2a0TqgEOVg0Klze494gqqopGvBkMIvDHwwFnEonNiDWlZp8ojx9zfLiIhZq2JOrc1Z5
        qgBa3E6YkdeIYLRfhHkcc8A42
X-Received: by 2002:a05:6000:795:b0:226:e8d9:828c with SMTP id bu21-20020a056000079500b00226e8d9828cmr3618483wrb.464.1661973924583;
        Wed, 31 Aug 2022 12:25:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4fs8by6IoJFQ787oFgJNHbEqCREzybMcTnbSuDfwQnhjlpKfAOJG3sm+OqTQ8QlSY6Go1zUQ==
X-Received: by 2002:a05:6000:795:b0:226:e8d9:828c with SMTP id bu21-20020a056000079500b00226e8d9828cmr3618473wrb.464.1661973924345;
        Wed, 31 Aug 2022 12:25:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2900:1613:4308:aca3:2786? (p200300cbc706290016134308aca32786.dip0.t-ipconnect.de. [2003:cb:c706:2900:1613:4308:aca3:2786])
        by smtp.gmail.com with ESMTPSA id n42-20020a05600c502a00b003a83ac538a1sm3030022wmr.29.2022.08.31.12.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 12:25:23 -0700 (PDT)
Message-ID: <0aba2bfc-9f10-2fb1-1858-d8eb04b5d52e@redhat.com>
Date:   Wed, 31 Aug 2022 21:25:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
 <Yw5a1paQJ9MNdgmW@nvidia.com>
 <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
 <9a4fe603-950e-785b-6281-2e309256463f@nvidia.com>
 <68b38ac4-c680-b694-21a9-1971396d63b9@redhat.com>
 <Yw+KnRTrZ74qFUAA@xz-m1.local>
 <4d067a99-1112-3b3d-bedf-35c1124904fd@redhat.com>
 <Yw+nFBgnSH9WWYHv@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yw+nFBgnSH9WWYHv@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>>> index d7526c705081..971cf923c0eb 100644
>>>> --- a/mm/ksm.c
>>>> +++ b/mm/ksm.c
>>>> @@ -1091,6 +1091,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
>>>>  			goto out_unlock;
>>>>  		}
>>>>  
>>>> +		/* See page_try_share_anon_rmap(): clear PTE first. */
>>>>  		if (anon_exclusive && page_try_share_anon_rmap(page)) {
>>>>  			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
>>>>  			goto out_unlock;
>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>> index 27fb37d65476..47e955212f15 100644
>>>> --- a/mm/migrate_device.c
>>>> +++ b/mm/migrate_device.c
>>>> @@ -193,20 +193,16 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>  			bool anon_exclusive;
>>>>  			pte_t swp_pte;
>>>>  
>>>
>>> flush_cache_page() missing here?
>>
>> Hmm, wouldn't that already be missing on the !anon path right now?
> 
> Yes, I think Alistair plans to fix it too in the other patchset.  So either
> this will rebase to that or it should fix it too.  Thanks,
> 

I'll include it in this patch for now, because by dropping it I would
make the situation "worse". But most probably we want a separate fix
upfront that we can properly backport to older kernels.

Thanks!

-- 
Thanks,

David / dhildenb

