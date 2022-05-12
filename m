Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C789D5252BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356568AbiELQix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242977AbiELQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1E4520E090
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652373530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mp/k4+ROOQmqxpZwmJD0fhrk0KhPBsBL98sUg/4FvV4=;
        b=FO8DCwvg9XVsGepcd2Ml2n9NKAiwNzGTRD1t9DwQNQS+AOXxdncG5CjpBZWZ6tjeooO67j
        C8z2DL8Cx/j3PqrmylzETzJq+uLbcSQjBmmgFJOP7l/Xk63cK9qT5GoV1ZbKbIJeoGVHG0
        LRDONLlGa6Nr2jL2fwIi8QsUFGlWZso=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-tyUtRBZ-Mo2SsnRYaktzzA-1; Thu, 12 May 2022 12:38:48 -0400
X-MC-Unique: tyUtRBZ-Mo2SsnRYaktzzA-1
Received: by mail-wm1-f71.google.com with SMTP id n26-20020a1c721a000000b003941ea1ced7so1882043wmc.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=mp/k4+ROOQmqxpZwmJD0fhrk0KhPBsBL98sUg/4FvV4=;
        b=mzlKlYaVKROzix7DwuMZSVQ1yXFoetiDB9X6r9e+5KQuTmph27ilejYp5E8rrE/p5O
         uZnilKp7ESfMIiU6EuOF3zkYhzYlqanfjr8dkLqAqV0kzUJGwLQ5AU2pVA3qm0xlW5jx
         LWX5UzRv3sVYbN5qn3EW25FaGTwrv6qVUm/4Me/vMj4ZA9Fwh0Hg7LldzZk9Cl6mK150
         gnI/DX3uGADZjYc4wiSzB+DzTR7mcNTF56hQcc0lJTBe6VC36LsvQqtethqgGgyC15tY
         7mT4oOefOAOaQks+iOph6qWVCkE0BX4LWGfASjPRjaT+vQGJ2cvbF3K9rJ6pOxB9k25e
         UmYA==
X-Gm-Message-State: AOAM5328/10Xu6//732gK2YOo3lbaPi3MKEXSEg7DgyjzddCIGg3YxHC
        kbAheWwakCN8tF1TIX1oZdA6/CS//93Os8hEdoeDFMCUh+U7Rz4Oy2PUgprL6nFrA5Mlpfia/Gq
        ND8MsYvX3aoCxTNUXRxDDJD+K
X-Received: by 2002:a5d:52c5:0:b0:1f2:1a3:465a with SMTP id r5-20020a5d52c5000000b001f201a3465amr486450wrv.206.1652373527706;
        Thu, 12 May 2022 09:38:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw//xNJoDYn5jy5VfLK8EYdFrB0LMzS/0yyqB5elC7RCc26OTEcBI18h7H0GbGJR3KT78tEog==
X-Received: by 2002:a5d:52c5:0:b0:1f2:1a3:465a with SMTP id r5-20020a5d52c5000000b001f201a3465amr486433wrv.206.1652373527464;
        Thu, 12 May 2022 09:38:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id j10-20020adfc68a000000b0020c635ca28bsm2219wrg.87.2022.05.12.09.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 09:38:45 -0700 (PDT)
Message-ID: <5ca142fd-c7c0-768d-39f4-c58a84fff1f7@redhat.com>
Date:   Thu, 12 May 2022 18:38:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 2/4] mm: memory_hotplug: override memmap_on_memory
 when hugetlb_free_vmemmap=on
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220509062703.64249-1-songmuchun@bytedance.com>
 <20220509062703.64249-3-songmuchun@bytedance.com>
 <ebffd794-697b-9bf1-f41b-4b2d52c100fc@redhat.com>
 <Yn0Ck5isxx4ghQi6@FVFYT0MHHV2J.usts.net>
 <284eec3f-a79d-c5f0-3cd6-53b8e64100cd@redhat.com>
 <Yn0SyaqfS2YZ8kO/@FVFYT0MHHV2J.usts.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yn0SyaqfS2YZ8kO/@FVFYT0MHHV2J.usts.net>
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

On 12.05.22 15:59, Muchun Song wrote:
> On Thu, May 12, 2022 at 03:04:57PM +0200, David Hildenbrand wrote:
>> On 12.05.22 14:50, Muchun Song wrote:
>>> On Thu, May 12, 2022 at 09:36:15AM +0200, David Hildenbrand wrote:
>>>> On 09.05.22 08:27, Muchun Song wrote:
>>>>> Optimizing HugeTLB vmemmap pages is not compatible with allocating memmap on
>>>>> hot added memory. If "hugetlb_free_vmemmap=on" and
>>>>> memory_hotplug.memmap_on_memory" are both passed on the kernel command line,
>>>>> optimizing hugetlb pages takes precedence. 
>>>>
>>>> Why?
>>>>
>>>
>>> Because both two features are not compatible since hugetlb_free_vmemmap cannot
>>> optimize the vmemmap pages allocated from alternative allocator (when
>>> memory_hotplug.memmap_on_memory=1). So when the feature of hugetlb_free_vmemmap
>>> is introduced, I made hugetlb_free_vmemmap take precedence.  BTW, I have a plan
>>> to remove this restriction, I'll post it out ASAP.
>>
>> I was asking why vmemmap optimization should take precedence.
>> memmap_on_memory makes it more likely to succeed memory hotplug in
>> close-to-OOM situations -- which is IMHO more important than a vmemmap
>> optimization.
>>
> 
> I thought the users who enable hugetlb_free_vmemmap value memory
> savings more, so I made a decision in commit 4bab4964a59f.  Seems
> I made a bad decision from your description.

Depends on the perspective I guess. :)

>  
>> But anyhow, the proper approach should most probably be to simply not
>> mess with the vmemmap if we stumble over a vmemmap that's special due to
>> memmap_on_memory. I assume that's what you're talking about sending out.
>>
> 
> I mean I want to have hugetlb_vmemmap.c do the check whether the section
> which the HugeTLB pages belong to can be optimized instead of making
> hugetlb_free_vmemmap take precedence.  E.g. If the section's vmemmap pages
> are allocated from the added memory block itself, hugetlb_free_vmemmap will
> refuse to optimize the vmemmap, otherwise, do the optimization.  Then
> both kernel parameters are compatible.  I have done those patches, but
> haven't send them out.

Yeah, that's exactly what I thought. How complicated are they? If they
are easy, can we just avoid this patch here and do it "properly"? :)

-- 
Thanks,

David / dhildenb

