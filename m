Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCD15631E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbiGAKvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiGAKvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CF6F7BD3D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656672663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p904tAF9K07KDnBScamIzcjJHAu8q9svh+jJU8ShoFA=;
        b=TL/jmnxEo5qY44lhSRCOJRVjqrdxRYoFhzPoSslTkVVTlmX+FlXr3SDi16PBZw9z/Wn/SB
        U/OFcJGVworrBwENlc8azXjU4bXSBEUBXVJYK4hMUfbCTFVpxg1d0FfGKr78myw6wP1J7L
        pNHNhYudJIlnMKQJfbYQfSYQ0fTWkSY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-pJ8Ni3qsPZqhP1BZ499Lcg-1; Fri, 01 Jul 2022 06:51:02 -0400
X-MC-Unique: pJ8Ni3qsPZqhP1BZ499Lcg-1
Received: by mail-wm1-f72.google.com with SMTP id 187-20020a1c02c4000000b003a18127d11aso2326884wmc.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=p904tAF9K07KDnBScamIzcjJHAu8q9svh+jJU8ShoFA=;
        b=QAILWqK4Vt1KyqFv2ZnjapipWHyXqKEDLSDl/+f+Zz+dg+gYewNWg1royLQmlBtKY/
         yTfkcJLaWe2JZEBcatyxAUyezRNXhv7kAokDFbRmCRAPglSt8LCAIZiOhAGvsaTX52ZL
         w1iq4h05xn8HCd0uWZIgvAw54DDs3TOfM4AWTlzry2PjnZnWd23e5WvkJpuhVbMkivq4
         QIThPUh4GfCTTKBW89gPqhS9u88MB6MGC/+DvUYagD18HNrL5Fn5bvjO/Oi96+LorLGR
         OScrTMjgfIbWlrrfIMKW0PxmMg4ijzzVp4zDRTwymEmJAaq434ETtOp2c+puFGocmi2A
         Tq7g==
X-Gm-Message-State: AJIora8vz7I2PfiAfiYnlxvRj5pyBfFqVZHrmgH72ouyReTuA9Fs6kOV
        wtCTGNMzAnp+cg94DKK0xpNa7ovBIZLnXzUsBEfpm9kjv+0jwJgoE3a9DJV5rR1MHkkh7JbbhBh
        /PlFJ1+UNW+m9wZBQuHq8CC0k
X-Received: by 2002:adf:ce8f:0:b0:21b:b56a:fa24 with SMTP id r15-20020adfce8f000000b0021bb56afa24mr12806911wrn.173.1656672661443;
        Fri, 01 Jul 2022 03:51:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uXGAZr8bv/H+/RffeNr9hvP5W4YiErS9Acr664i6euyTxz/QPSWJhY4kOvWisocUAt00R1SA==
X-Received: by 2002:adf:ce8f:0:b0:21b:b56a:fa24 with SMTP id r15-20020adfce8f000000b0021bb56afa24mr12806876wrn.173.1656672661049;
        Fri, 01 Jul 2022 03:51:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:e300:d7a0:7fc3:8428:43e5? (p200300cbc709e300d7a07fc3842843e5.dip0.t-ipconnect.de. [2003:cb:c709:e300:d7a0:7fc3:8428:43e5])
        by smtp.gmail.com with ESMTPSA id a2-20020adfbc42000000b0021ba1b6186csm24658958wrh.40.2022.07.01.03.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 03:51:00 -0700 (PDT)
Message-ID: <c9de1c34-2a39-e4a2-c9b0-9790c5ffab13@redhat.com>
Date:   Fri, 1 Jul 2022 12:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Michal Hocko <mhocko@suse.com>, cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, minchan@kernel.org,
        oleksandr@redhat.com, xu xin <xu.xin16@zte.com.cn>,
        Jann Horn <jannh@google.com>
References: <20220701084323.1261361-1-xu.xin16@zte.com.cn>
 <Yr66Uhcv+XAPYPwj@dhcp22.suse.cz>
 <93e1e19a-deff-2dad-0b3c-ef411309ec58@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH linux-next] mm/madvise: allow KSM hints for
 process_madvise
In-Reply-To: <93e1e19a-deff-2dad-0b3c-ef411309ec58@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.07.22 12:32, David Hildenbrand wrote:
> On 01.07.22 11:11, Michal Hocko wrote:
>> [Cc Jann]
>>
>> On Fri 01-07-22 08:43:23, cgel.zte@gmail.com wrote:
>>> From: xu xin <xu.xin16@zte.com.cn>
>>>
>>> The benefits of doing this are obvious because using madvise in user code
>>> is the only current way to enable KSM, which is inconvenient for those
>>> compiled app without marking MERGEABLE wanting to enable KSM.
>>
>> I would rephrase:
>> "
>> KSM functionality is currently available only to processes which are
>> using MADV_MERGEABLE directly. This is limiting because there are
>> usecases which will benefit from enabling KSM on a remote process. One
>> example would be an application which cannot be modified (e.g. because
>> it is only distributed as a binary). MORE EXAMPLES WOULD BE REALLY
>> BENEFICIAL.
>> "
>>
>>> Since we already have the syscall of process_madvise(), then reusing the
>>> interface to allow external KSM hints is more acceptable [1].
>>>
>>> Although this patch was released by Oleksandr Natalenko, but it was
>>> unfortunately terminated without any conclusions because there was debate
>>> on whether it should use signal_pending() to check the target task besides
>>> the task of current() when calling unmerge_ksm_pages of other task [2].
>>
>> I am not sure this is particularly interesting. I do not remember
>> details of that discussion but checking signal_pending on a different
>> task is rarely the right thing to do. In this case the check is meant to
>> allow bailing out from the operation so that the caller could be
>> terminated for example.
>>
>>> I think it's unneeded to check the target task. For example, when we set
>>> the klob /sys/kernel/mm/ksm/run from 1 to 2,
>>> unmerge_and_remove_all_rmap_items() doesn't use signal_pending() to check
>>> all other target tasks either.
>>>
>>> I hope this patch can get attention again.
>>
>> One thing that the changelog is missing and it is quite important IMHO
>> is the permission model. As we have discussed in previous incarnations
>> of the remote KSM functionality that KSM has some security implications.
>> It would be really great to refer to that in the changelog for the
>> future reference (http://lkml.kernel.org/r/CAG48ez0riS60zcA9CC9rUDV=kLS0326Rr23OKv1_RHaTkOOj7A@mail.gmail.com)
>>
>> So this implementation requires PTRACE_MODE_READ_FSCREDS and
>> CAP_SYS_NICE so the remote process would need to be allowed to
>> introspect the address space. This is the same constrain applied to the
>> remote momory reclaim. Is this sufficient?
>>
>> I would say yes because to some degree KSM mergning can have very
>> similar effect to memory reclaim from the side channel POV. But it
>> should be really documented in the changelog so that it is clear that
>> this has been a deliberate decision and thought through.
>>
>> Other than that this looks like the most reasonable approach to me.
>>
>>> [1] https://lore.kernel.org/lkml/YoOrdh85+AqJH8w1@dhcp22.suse.cz/
>>> [2] https://lore.kernel.org/lkml/2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz/
>>>
> 
> I have various concerns, but the biggest concern is that this modifies
> VMA flags and can possibly break applications.
> 
> process_madvise must not modify remote process state.
> 
> That's why we only allow a very limited selection that are merely hints.
> 
> So nack from my side.
> 

[I'm quit ebusy, but I think some more explanation might be of value]

One COW example where I think force-enabling KSM for processes is
*currently* not a good idea (besides the side channel discussions, which
is also why Windows stopped to enable KSM system wide a while ago):

App:

a) memset(page, 0);
b) trigger R/O long-term pin on page (e.g., vfio)

If between a) and b) KSM replaces the page by the shared zeropage you'll
get an unreliable pin because we don't break yet COW when taking a R/O
pin on the shared zeropage. And in the traditional sense, the app did
everything right to guarantee that the pin will stay reliable.


Further, if an app explicitly decides to disable KSM one some region, we
should not overwrite that.


I can see that we might want such a (VMA-wide? process-wide?
system-wide?) overwrite, but IMHO we would have to make sure that

a) Any eventual side effects (see above) are handled correctly.
b) The app has an explicit mechanism to certainly disable KSM for a
   region (e.g., storing secrets) -- similarly to MADV_NOHUGEPAGE that
   ensures that there will *not* be huge pages.

IOW, fixes for a) [I'm planning on doing that] and two sets of flags for
b) to distinguish what the app wants and what somebody else might want.

-- 
Thanks,

David / dhildenb

