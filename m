Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9EC54DB6B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359165AbiFPHVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359141AbiFPHVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87A795C35C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655364099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BmKGnuktFvztcVSafDwftRNZMdy1HHQkqyAtAvqCv2M=;
        b=ey4hXQOLOtvuKJwI420i3r3d8IGovESa+aitn74MkSxucY2gkiUMu0n5G5Hz3bFh2UzZZe
        dsVNaArbbhuNEXkaiR8FeEWbvBs7rmDP0pAXRHli0EFob+0+MBH5gcAN/G5/3TNHuq9/n5
        23HdyIcEz/s0s8+UZHngMYNB947NLIg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-LHCe_yu1OrCFdn8ZbM5jqw-1; Thu, 16 Jun 2022 03:21:38 -0400
X-MC-Unique: LHCe_yu1OrCFdn8ZbM5jqw-1
Received: by mail-wr1-f72.google.com with SMTP id h2-20020adfe982000000b002102da95c71so58382wrm.23
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=BmKGnuktFvztcVSafDwftRNZMdy1HHQkqyAtAvqCv2M=;
        b=imp9z4I4+Yt4N6RfJh6sNZnCsKZIcdTiPHMUsP1mBq0KBQ6yr8+JjLwD0j5TMGbRA8
         rV/nt8MqUd5vRMvQUOfFMmNhjfmCqkViNHGYUIK8eQRg7er01fQMeUYYqpl2cB2Wth9Z
         dYYlyYyIeYcay5L3kzAbagaE94pmYlPwHVBAFzcuOyqWj2DtDnl2NM3t3rwQBDB5yoEL
         h2Z5bHQijUSN1AMG+KLtuTwuCRVcz4gusT4EyzQEOHdIsG/UNxaQ+6XU8wnDLBB+KUF9
         EMYl4bVem7kQHaEi/u0pnkcH4j8sw91e0oNNhtyWErBbpmDz+MTfHCMZ0Af30LoPTfIi
         /mfw==
X-Gm-Message-State: AJIora8fjw9YFBXBuJwNmhPbfOAH7Q8c7TGeutayPSGC16Iffv5jMVoG
        WIvVfb1xo6PjA2eUz2xYkaUYg5kO+6QBMl7H8cGVu89YZzPFCYSBSeOm2XjFTgsdkbwsW08dGxr
        VsQWlW2iw7djVlm+BYvl2WUZE
X-Received: by 2002:a5d:584c:0:b0:218:4e98:770a with SMTP id i12-20020a5d584c000000b002184e98770amr3205381wrf.271.1655364096975;
        Thu, 16 Jun 2022 00:21:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sCHqyHd8fBXb2/1perTt3JC0gqX+eoIPsBJarFVdNDwHFuc2T2urts+Aswd2WJYMkghrY7ow==
X-Received: by 2002:a5d:584c:0:b0:218:4e98:770a with SMTP id i12-20020a5d584c000000b002184e98770amr3205359wrf.271.1655364096688;
        Thu, 16 Jun 2022 00:21:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:2d00:73d7:5fab:cc8a:e48c? (p200300cbc70b2d0073d75fabcc8ae48c.dip0.t-ipconnect.de. [2003:cb:c70b:2d00:73d7:5fab:cc8a:e48c])
        by smtp.gmail.com with ESMTPSA id t2-20020a1c4602000000b0039db60fa340sm4809654wma.33.2022.06.16.00.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 00:21:36 -0700 (PDT)
Message-ID: <abf6bd60-b944-100e-b327-97365d366ed8@redhat.com>
Date:   Thu, 16 Jun 2022 09:21:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, osalvador@suse.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-3-songmuchun@bytedance.com>
 <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
 <YqqZOj+zby1fLGv/@FVFYT0MHHV2J.usts.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YqqZOj+zby1fLGv/@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.22 04:45, Muchun Song wrote:
> On Wed, Jun 15, 2022 at 11:51:49AM +0200, David Hildenbrand wrote:
>> On 20.05.22 04:55, Muchun Song wrote:
>>> For now, the feature of hugetlb_free_vmemmap is not compatible with the
>>> feature of memory_hotplug.memmap_on_memory, and hugetlb_free_vmemmap
>>> takes precedence over memory_hotplug.memmap_on_memory. However, someone
>>> wants to make memory_hotplug.memmap_on_memory takes precedence over
>>> hugetlb_free_vmemmap since memmap_on_memory makes it more likely to
>>> succeed memory hotplug in close-to-OOM situations.  So the decision
>>> of making hugetlb_free_vmemmap take precedence is not wise and elegant.
>>> The proper approach is to have hugetlb_vmemmap.c do the check whether
>>> the section which the HugeTLB pages belong to can be optimized.  If
>>> the section's vmemmap pages are allocated from the added memory block
>>> itself, hugetlb_free_vmemmap should refuse to optimize the vmemmap,
>>> otherwise, do the optimization.  Then both kernel parameters are
>>> compatible.  So this patch introduces SECTION_CANNOT_OPTIMIZE_VMEMMAP
>>> to indicate whether the section could be optimized.
>>>
>>
>> In theory, we have that information stored in the relevant memory block,
>> but I assume that lookup in the xarray + locking is impractical.
>>
>> I wonder if we can derive that information simply from the vmemmap pages
>> themselves, because *drumroll*
>>
>> For one vmemmap page (the first one), the vmemmap corresponds to itself
>> -- what?!
>>
>>
>> [	hotplugged memory	]
>> [ memmap ][      usable memory	]
>>       |    |                    |
>>   ^---     |                    |
>>    ^-------                     |
>>          ^----------------------
>>
>> The memmap of the first page of hotplugged memory falls onto itself.
>> We'd have to derive from actual "usable memory" that condition.
>>
>>
>> We currently support memmap_on_memory memory only within fixed-size
>> memory blocks. So "hotplugged memory" is guaranteed to be aligned to
>> memory_block_size_bytes() and the size is memory_block_size_bytes().
>>
>> If we'd have a page falling into usbale memory, we'd simply lookup the
>> first page and test if the vmemmap maps to itself.
>>
> 
> I think this can work. Should we use this approach in next version?
> 

Either that or more preferable, flagging the vmemmap pages eventually.
That's might be future proof.

>>
>> Of course, once we'd support variable-sized memory blocks, it would be
>> different.
>>
>>
>> An easier/future-proof approach might simply be flagging the vmemmap
>> pages as being special. We reuse page flags for that, which don't have
>> semantics yet (i.e., PG_reserved indicates a boot-time allocation via
>> memblock).
>>
> 
> I think you mean flag vmemmap pages' struct page as PG_reserved if it
> can be optimized, right? When the vmemmap pages are allocated in
> hugetlb_vmemmap_alloc(), is it valid to flag them as PG_reserved (they
> are allocated from buddy allocator not memblock)?
> 

Sorry I wasn't clear. I'd flag them with some other
not-yet-used-for-vmemmap-pages flag. Reusing PG_reserved could result in
trouble.


-- 
Thanks,

David / dhildenb

