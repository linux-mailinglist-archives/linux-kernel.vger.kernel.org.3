Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C566953A33C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352361AbiFAKtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352359AbiFAKtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6700C2E09E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654080573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DS4blGTPG/TNOCJCMaY+3+JCDXOQcHN0U1VXQhbGGI4=;
        b=OVW5GC3Q2fbman5xaKLPO1xCoh1UaDBTjmQKSuENQAIK3/dgxy80MzbyIXJJuzEwb2XFcI
        Se5r7k2VQaUOdwwpqYg2HE2g4E87kXrIW7x1YnLHFm64MRp08N/3GZNJrxNxx/gLzAYxs3
        GGgRhbiMN4n70buN5qKUq9GNl5g8mhY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-kMhGAKOSNNatawOqspwyyg-1; Wed, 01 Jun 2022 06:49:32 -0400
X-MC-Unique: kMhGAKOSNNatawOqspwyyg-1
Received: by mail-wm1-f69.google.com with SMTP id l34-20020a05600c1d2200b003973a50c1e4so944050wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=DS4blGTPG/TNOCJCMaY+3+JCDXOQcHN0U1VXQhbGGI4=;
        b=NGbXexDfaxtOvDZu+DYM2EuOSs3SB6r6gK567cvQQU8UwBRrLznOdPJ73fMY9wbpV5
         8hME+dIaaPzX3Fenz5A6tbvQys0BqHj1He/XZnHJwSGovvm3/Sx85dKo3SBg5xStvDBW
         rIziw+AMfZEmVKP+ULb4ChoG0jQRHKzpyOBLsW24OlM2ylw/kSqBj9xu6imWf8IycQZp
         A+s2L1Ju/JOBNLZCkXE/PXIVPh29CkZWEw4HgdWlIHu45AgdIBfYEK+HAKd48dRprn7P
         KPUzgUHQDpZyIlsgCJGIQQgpVDeCTLWdC0bAxLhjqQ2nlV27vcS87NfYUM3xpZ3oTLXH
         cRsA==
X-Gm-Message-State: AOAM531jHiuRhpg/Dausv3OhOUY7VV0rF5OjQD/SEfWocklDoW/Xy5Tl
        x2Tz/aui5FDIdKCl+VSvphCW4mcqmOVu/qh5c4tvUqy2SlQpjt3zyCqD9r2KljPGkzuY5Po24gJ
        jL+0mrkt3RiNQealVCfVKJh5R
X-Received: by 2002:adf:e10d:0:b0:20c:dc8f:e5a5 with SMTP id t13-20020adfe10d000000b0020cdc8fe5a5mr54387150wrz.265.1654080571197;
        Wed, 01 Jun 2022 03:49:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNLblXQZWWG8YKRi1MWxDnwphi/PU6+MtD9BcohLoaFlU7Cvuccdym8QdqGZaoL9UVqtd5rQ==
X-Received: by 2002:adf:e10d:0:b0:20c:dc8f:e5a5 with SMTP id t13-20020adfe10d000000b0020cdc8fe5a5mr54387131wrz.265.1654080570899;
        Wed, 01 Jun 2022 03:49:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id y18-20020a05600c365200b003942a244f54sm5775095wmq.45.2022.06.01.03.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:49:29 -0700 (PDT)
Message-ID: <48a4a7f2-bee5-371a-1d9d-549fc59ce4f4@redhat.com>
Date:   Wed, 1 Jun 2022 12:49:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] mm: hugetlb_vmemmap: cleanup hugetlb_vmemmap related
 functions
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, smuchun@bytedance.com
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-2-songmuchun@bytedance.com>
 <087817e3-98ce-09f6-9ae9-68e544f43775@redhat.com>
 <YpdD7WCYlfCkvv2L@FVFYT0MHHV2J.googleapis.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YpdD7WCYlfCkvv2L@FVFYT0MHHV2J.googleapis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>  #endif
>>>  #ifdef CONFIG_CGROUP_HUGETLB
>>>  	/* cgroup control files */
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index dd642cfc538b..1f9fbdddc86b 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -1540,7 +1540,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>>>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>>>  		return;
>>>  
>>> -	if (alloc_huge_page_vmemmap(h, page)) {
>>> +	if (hugetlb_vmemmap_alloc(h, page)) {
>>>  		spin_lock_irq(&hugetlb_lock);
>>>  		/*
>>>  		 * If we cannot allocate vmemmap pages, just refuse to free the
>>> @@ -1617,7 +1617,7 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
>>>  
>>>  static inline void flush_free_hpage_work(struct hstate *h)
>>>  {
>>> -	if (free_vmemmap_pages_per_hpage(h))
>>> +	if (hugetlb_optimize_vmemmap_pages(h))
>>
>> It might be reasonable to call that hugetlb_should_optimize_vmemmap()
>> then, letting it return a bool.
>>
> 
> How about the name of "hugetlb_vmemmap_optimizable()"?  "should" seems to
> tell the user that this hugetlb should be optimized, however, optimization
> also depends on "hugetlb_free_vmemmap=on".  "optimizable" seems to be more
> appropriate, right?

No strong opinion. Either is clearer to me compared to what we have
right now :)


-- 
Thanks,

David / dhildenb

