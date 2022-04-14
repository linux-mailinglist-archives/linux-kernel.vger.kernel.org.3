Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C273350176A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbiDNPfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346927AbiDNOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EB52B6468
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649944956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1AnOH9s7DSYL3vteuGfJhK0BPbgyTYHpqqRt2VurCg=;
        b=d9Z9QK4cqrRx9QlJMA0r7MGa4L/J25J8w88PwGyVKPVuZETY8CyuWr/0tJcUFU//LNfS9g
        wvU5Pk8d4ywnmJ272mb9CUa1J2v3DF+sLKZ2JGbLITt76uF9DwarX8tJNn96oG4krXja7x
        v1JqEgOBoqaI8ijWuqKwVR3KAD6OaAQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-DNNyKczDOHiWq0AUCJYu_w-1; Thu, 14 Apr 2022 10:02:34 -0400
X-MC-Unique: DNNyKczDOHiWq0AUCJYu_w-1
Received: by mail-wr1-f70.google.com with SMTP id v9-20020adfc409000000b002079e379921so850176wrf.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=r1AnOH9s7DSYL3vteuGfJhK0BPbgyTYHpqqRt2VurCg=;
        b=C7MbOvb3QHx8JMA+xAJMaD62L/h6YkG0NLr2vU7C+BSPzaVcBx5qWTrdgmMpegDZIA
         DdIqmKiuXSsIPgVIVuvu4HgX3+k1kcLBIiVhQBKu4usa3NVQ4iYhs+6wpaPCLA8Ke+r7
         wSa0UfFNTWn0yfhwRRjnHVnRhSieZRHCAtLCtbvXJMaKL3xwKWF1UVnbF5LvKO1EjTVN
         ubT5dI5EfA2JjOSPbPOGqA3gDA+PHPXnLvyFbP3QxbBVIC8M0OFuEBBViEUCqNSQz0AO
         vMtv/HF/AMP7OXLSlVC79old6tRsFRhODjVSpnHtUKDUDrdlDcu2u6uvE87PLiPxTEmj
         RMnw==
X-Gm-Message-State: AOAM531q261rHFr2zle1DlvTw+4PsANuCZKzAYZwP3BKvKivTnJPnjx1
        Bbe22FuICj3RZJjkGm4ogsOQv6XE9JIcMIrkrPRvvxZh7iQsHja2gH8WblOfQun72QYuT4RWY+4
        GuiN57PV4uY8Ep+tOJ9ZEMe6x
X-Received: by 2002:adf:e3c8:0:b0:207:a128:6205 with SMTP id k8-20020adfe3c8000000b00207a1286205mr2158344wrm.370.1649944953586;
        Thu, 14 Apr 2022 07:02:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCOLeKlyEqyoNtDnsf/KJBwbDMTg1Ighp92mVOoajOu0oPWOYLt1ASMLPz3qkqj3C5XmDGBA==
X-Received: by 2002:adf:e3c8:0:b0:207:a128:6205 with SMTP id k8-20020adfe3c8000000b00207a1286205mr2158327wrm.370.1649944953315;
        Thu, 14 Apr 2022 07:02:33 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id i5-20020adfb645000000b002060e559f24sm1858050wre.92.2022.04.14.07.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 07:02:32 -0700 (PDT)
Message-ID: <91b35970-b68e-580f-b17d-789fcc2e1c47@redhat.com>
Date:   Thu, 14 Apr 2022 16:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm, page_alloc: check pfn is valid before moving to
 freelist
Content-Language: en-US
To:     Mike Rapoport <rppt@linux.ibm.com>,
        David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <cover.1649794059.git.quic_sudaraja@quicinc.com>
 <fb3c8c008994b2ed96f74b6b9698ff998b689bd2.1649794059.git.quic_sudaraja@quicinc.com>
 <20220412135912.93175db2ab4e83f4bb060dbf@linux-foundation.org>
 <6daaaf5c-529d-f3eb-7486-a72cabb6e396@google.com>
 <Ylc437iBoQ4AU6zT@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Ylc437iBoQ4AU6zT@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.22 22:55, Mike Rapoport wrote:
> On Tue, Apr 12, 2022 at 02:05:51PM -0700, David Rientjes wrote:
>> On Tue, 12 Apr 2022, Andrew Morton wrote:
>>
>>> On Tue, 12 Apr 2022 13:16:23 -0700 Sudarshan Rajagopalan <quic_sudaraja@quicinc.com> wrote:
>>>
>>>> Check if pfn is valid before or not before moving it to freelist.
>>>>
>>>> There are possible scenario where a pageblock can have partial physical
>>>> hole and partial part of System RAM. This happens when base address in RAM
>>>> partition table is not aligned to pageblock size.
>>>>
>>>> ...
>>>>
>>>>
>>>> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>>> Fixes: 4c7b9896621be ("mm: remove pfn_valid_within() and CONFIG_HOLES_IN_ZONE")
>>>
>>> I made that 859a85ddf90e714092dea71a0e54c7b9896621be and added
>>> cc:stable.  I'll await reviewer input before proceeding further.
>>>
>>
>> Acked-by: David Rientjes <rientjes@google.com>
>>
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -2521,6 +2521,11 @@ static int move_freepages(struct zone *zone,
>>>>  	int pages_moved = 0;
>>>>  
>>>>  	for (pfn = start_pfn; pfn <= end_pfn;) {
>>>> +		if (!pfn_valid(pfn)) {
>>>
>>> Readers will wonder how we can encounter an invalid pfn here.  A small
>>> comment might help clue them in.
>>>
>>
>> Sudarshan can correct me if I'm wrong, but this has to do with the 
>> pageblock alignment of the caller that assumes all pages in the range has 
>> an underlying struct page that we can access but that fails to hold true 
>> when we have a memory hole.  A comment would definitely help:
> 
> We do have a struct page for every page in a pageblock even if there is a
> hole in the physical memory. If this is not the case, there is more
> fundamental bug that should be fixed.

Also, I dislike handling such a corner case in a way that affects all
other sane cases. move_freepages() is also used for page isolation.

I agree that this should be fixed differently, if possible.

-- 
Thanks,

David / dhildenb

