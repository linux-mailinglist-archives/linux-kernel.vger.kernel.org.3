Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A080D518B11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbiECRaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbiECRas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 253E43D4A5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651598835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2T9v+noUcsp5HoZ7AYLY1QHIF7e3pPU/42dWorsxvk=;
        b=T40k0U98kSXpJsB4F+zi7EI+7o/+ZB2pWq6RTD9nWvnzYf4mrqczZNRx2jjR3/VrNQ4ddh
        EAcm4Zx4TDnArByK1jF922+6c6BIQtPCY7/3s0zSv7AwwJ56aZphpAOqq0gY78gAoPPtzU
        wGPkuWMIVs+0kMtKYLcP3M8d69GBEJc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-dGh1fXnDMQKWBja-pFVHNA-1; Tue, 03 May 2022 13:27:11 -0400
X-MC-Unique: dGh1fXnDMQKWBja-pFVHNA-1
Received: by mail-pf1-f199.google.com with SMTP id b20-20020a62a114000000b0050a6280e374so9759970pff.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 10:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=I2T9v+noUcsp5HoZ7AYLY1QHIF7e3pPU/42dWorsxvk=;
        b=xjXSLVYWUjqTnwq5tAgL7j1VJJY33n3CMjsbqrzm+F1jMtbdn9b8S77KUQ79GgeAG9
         PockB4+L79Ee/isl25pTaSEXosDU8R/Dsxxg9/V495+S2IKXRP12mDj/gpmCITkQxWMA
         wVQ7Vqtm5G2nHrqV0GLZq/qW2McZr3NCQEAX5ELtouFWOyM1ENniR0zITBnsrgEfVJ2N
         p8ghBsuhXl4w0mhOWGuAIOL+mwqSCYh7ZtS45REcEoNmhhIkWSCAjUWiu1Cn5tmdiKdR
         T7daeLtzI0j7ULdNCK8cNEKYrz4p3XjXgXuM8NTL08KRmmTRIOIhJPRJnjEf5KTPGzWa
         ctvg==
X-Gm-Message-State: AOAM533rn2hNhhZ5MVT7CcAFQvLBgmtCPAOiC42xcbAGAdHmzm1SQkn3
        0gu2EXLhJml9+2tLl6u1DFxQXPn7m6L7Xz3Il5cFwJD2F7DwojwL6AFEs09B2QRnphqErJ8MfDa
        4yH6DnblHn7CF15k67iEiW461
X-Received: by 2002:a62:be14:0:b0:505:a43b:cf6e with SMTP id l20-20020a62be14000000b00505a43bcf6emr17037109pff.33.1651598830467;
        Tue, 03 May 2022 10:27:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVJTHu4ZFm7X+veJpuPJCnAmKetQVdl460LFzMz2t6BhT4J1SRTmS8Sr62Oo3JX2tienObCA==
X-Received: by 2002:a62:be14:0:b0:505:a43b:cf6e with SMTP id l20-20020a62be14000000b00505a43bcf6emr17037088pff.33.1651598830156;
        Tue, 03 May 2022 10:27:10 -0700 (PDT)
Received: from [10.10.69.234] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id m7-20020aa79007000000b0050dc7628189sm6742403pfo.99.2022.05.03.10.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 10:27:08 -0700 (PDT)
Message-ID: <f271ca5e-c573-1c48-35a7-b59e9f2e122e@redhat.com>
Date:   Tue, 3 May 2022 19:27:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
 <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
 <YnAhaRNjmIhtGUjk@google.com>
 <08e9855c-395d-f40c-de3d-1ec8b644bfe8@redhat.com>
 <YnFJss0doXGCmq3w@google.com>
 <da07530d-92ad-7aef-2f2b-d115f878ef76@redhat.com>
 <YnFkZmvW2thpIn8o@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
In-Reply-To: <YnFkZmvW2thpIn8o@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> GUP would see MIGRATE_ISOLATE and would reject pinning. The page has to
>> be migrated, which can fail if the page is temporarily unmovable.
> 
> Why is the page temporarily unmovable? The GUP didn't increase the
> refcount in the case. If it's not migrabtable, that's not a fault
> from the GUP but someone is already holding the temporal refcount.
> It's not the scope this patchset would try to solve it.

You can have other references on the page that turn it temporarily
unmovable, for example, via FOLL_GET, short-term FOLL_PIN.

> 
>>
>> See my point? We will try migrating in cases where we don't have to
> 
> Still not clear for me what you are concerning.
> 
>> migrate. I think what we would want to do is always reject pinning a CMA
>> page, independent of the isolation status. but we don't have that
> 
> Always reject pinning a CMA page if it is *FOLL_LONGTERM*

Yes.

> 
>> information available.
> 
> page && (MIGRATE_CMA | MIGRATE_ISOLATE) && gup_flags is not enough
> for it?
> 
>>
>> I raised in the past that we should look into preserving the migration
>> type and turning MIGRATE_ISOLATE essentially into an additional flag.
>>
>>
>> So I guess this patch is the right thing to do for now, but I wanted to
>> spell out the implications.
> 
> I want but still don't understand what you want to write further
> about the implication parts. If you make more clear, I am happy to
> include it.

What I am essentially saying is that when rejecting to long-term
FOLL_PIN something that is MIGRATE_ISOLATE now, we might now end up
having to migrate pages that are actually fine to get pinned, because
they are not actual CMA pages. And any such migration might fail when
pages are temporarily unmovable.


> 
>>
>>>
>>> A thing to get some attention is whether we need READ_ONCE or not
>>> for the local variable mt.
>>>
>>
>> Hmm good point. Staring at __get_pfnblock_flags_mask(), I don't think
>> there is anything stopping the compiler from re-reading the value. But
>> we don't care if we're reading MIGRATE_CMA or MIGRATE_ISOLATE, not
>> something in between.
> 
> How about this?
> 
>      CPU A                                                      CPU B
> 
> is_pinnable_page
>   ..
>   ..                                                set_pageblock_migratetype(MIGRATE_ISOLATE)
>   mt == MIGRATE_CMA
>     get_pageblock_miratetype(page)
>         returns MIGRATE_ISOLATE
>   mt == MIGRATE_ISOLATE                             set_pageblock_migratetype(MIGRATE_CMA)
>     get_pageblock_miratetype(page)
>         returns MIGRATE_CMA
>  
> So both conditions fails to detect it.

I think you're right. That's nasty.

-- 
Thanks,

David / dhildenb

