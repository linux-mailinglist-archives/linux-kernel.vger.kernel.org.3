Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7011657A3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiGSPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbiGSPyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D9C55019B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658246050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDy3s2QOPJGPftDZNgnW2ktTSjzkXRv57+Dqh8lp+dc=;
        b=NTew3wUHeMz2u/uvLykcK8UNMhb+NGQvY/ZyojtlNIqWmSBPfuwINefZme0/M54k+/7zVu
        ZWoLAT7lTrcYzUueJiZjL5906hHrJ0i1QGdDDp+Mt9Z43MyUsKp9Z4n8whKKCFI5rYf6nb
        smk69unat1PRnFWTMfTjDQvF8CTf1yI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-m17xOo9jO1uycoHe6QyV8A-1; Tue, 19 Jul 2022 11:54:09 -0400
X-MC-Unique: m17xOo9jO1uycoHe6QyV8A-1
Received: by mail-wm1-f70.google.com with SMTP id n18-20020a05600c501200b003a050cc39a0so6958759wmr.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=uDy3s2QOPJGPftDZNgnW2ktTSjzkXRv57+Dqh8lp+dc=;
        b=4/JGXnDknEGAIno1Ekr0Crj8aGIW+GcVxhgF6XQms71pokUjfBvPMmoxIVxzS/5ulP
         trFbEpXP2LOR7D+X9CfW8IWBP/N0UjO3cGSwtnOwE9YMNzrfWh1uzvCegJA6QOIsCIdN
         H4qNX6yG4FDStDd4ZPF+NkiPIsxgjJ96RLS3XXzFSGaBfrm/7E3zvFPXd8e2dUuIgbno
         P6IoL/GfWw7rA3hOUdTs53o17n6Oc9ZiSa1TLgevgRGmBRzzfJN4FKKTaet9ek1bOu53
         Y0G+v800DHerhyHkz0pgXKhb9h1yqGwoXxg057LcgPwdQCJtM19hH1tClYGzse/dV77n
         T/kg==
X-Gm-Message-State: AJIora+y5qDzJ9uJyEpQyGoggfVKGRvxhe8JOl3yfTR1Rz+CAMyGHQoC
        UjOh66wScj4w8ShT3d++XgfF6RKMTu7iJzbGSrVrmeqcEN0aV53f//19RfKG03jM1RNEqxVjYei
        6okTFBBsBh/+dzcA15f0IQQxJ
X-Received: by 2002:a05:6000:49:b0:21d:78fe:34b2 with SMTP id k9-20020a056000004900b0021d78fe34b2mr26645039wrx.200.1658246048064;
        Tue, 19 Jul 2022 08:54:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tCgEneS8qXFTHOg4Z/NJV6IoJyNYt2ANrLuhZ2wKTFrfyj//ZS6x2HbMBQ7sJIZ5gFAGIUQA==
X-Received: by 2002:a05:6000:49:b0:21d:78fe:34b2 with SMTP id k9-20020a056000004900b0021d78fe34b2mr26645023wrx.200.1658246047808;
        Tue, 19 Jul 2022 08:54:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:600:7807:c947:bc5a:1aea? (p200300cbc70906007807c947bc5a1aea.dip0.t-ipconnect.de. [2003:cb:c709:600:7807:c947:bc5a:1aea])
        by smtp.gmail.com with ESMTPSA id p42-20020a05600c1daa00b003a30f84a9aasm14803515wms.26.2022.07.19.08.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 08:54:07 -0700 (PDT)
Message-ID: <7a77f387-9400-3b41-d89f-2f1ef7bfbdc4@redhat.com>
Date:   Tue, 19 Jul 2022 17:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org, vbabka@suse.cz,
        minchan@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
 <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
 <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
 <aaeec83d-bdf8-280c-b943-ad510f1d8db2@quicinc.com>
 <YtbRF9Z1tVxgw+g0@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YtbRF9Z1tVxgw+g0@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.22 17:43, Michal Hocko wrote:
> On Tue 19-07-22 20:42:42, Charan Teja Kalla wrote:
>> Thanks Michal!!
>>
>> On 7/18/2022 8:24 PM, Michal Hocko wrote:
> [...]
>>>>>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>>>>>> index 3dc715d..5ccd3ee 100644
>>>>>> --- a/mm/page_ext.c
>>>>>> +++ b/mm/page_ext.c
>>>>>> @@ -299,8 +299,9 @@ static void __free_page_ext(unsigned long pfn)
>>>>>>  	if (!ms || !ms->page_ext)
>>>>>>  		return;
>>>>>>  	base = get_entry(ms->page_ext, pfn);
>>>>>> -	free_page_ext(base);
>>>>>>  	ms->page_ext = NULL;
>>>>>> +	synchronize_rcu();
>>>>>> +	free_page_ext(base);
>>>>>>  }
>>>>> So you are imposing the RCU grace period for each page_ext! This can get
>>>>> really expensive. Have you tried to measure the effect?
>>> I was wrong here! This is for each memory section which is not as
>>> terrible as every single page_ext. This can be still quite a lot memory
>>> sections in a single memory block (e.g. on ppc memory sections are
>>> ridiculously small).
>>>
>>
>> On the ARM64, I see that the minimum a section size will go is 128MB. I
>> think 16MB is the section size on ppc. Any inputs on how frequently
>> offline/online operation is being done on this ppc arch?
> 
> I have seen several reports where 16MB sections were used on PPC LPARs
> with a non trivial size. My usual answer to that is tha this is mostly a
> self inflicted injury but I am told that for some reasons I cannot
> udnerstand this is not easy to change. So reasonable or not this is not
> all that uncommon in PPC land.
> 
> We definitely shouldn't optimize for those setups but we shouldn't make
> them suffer even more as well. Besides that it seems that a single
> rcu_synchronize per offline operation should be doable.

IIRC, any reasonable PPC64 installation uses LMB >= 256 MiB, which maps
to the logical memory block size, and we only online/offline complete
memory blocks, not individual memory sections.

So one these installations, you'll see memory getting onlined/offlined
in at least 256MiB granularity.

-- 
Thanks,

David / dhildenb

