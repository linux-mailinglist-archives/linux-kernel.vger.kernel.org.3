Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E47563336
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbiGAMKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbiGAMJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:09:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE7C384EEB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656677368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a44l1BPonlFv22UzYK+zY86aCCDzfde91OGY+36yGaU=;
        b=N/dEism6ywTCj0RqezJV2cB8e+pX/sxu9CJ9W3GUgP4piGQsDiY4PBAYRJl0cK4IdSq+0i
        rCm/LsMhcQXkDeKrpLLMCipD79UgdKJnpO6jxVnb4G5bAs4DJ3JrdzqxBCzUZiWB0Oe8FI
        YurLZcFl5zy32Kq8WQu5jnZJlef9l0E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-SzwT10vvOrib_Y_3ZxPm1g-1; Fri, 01 Jul 2022 08:09:26 -0400
X-MC-Unique: SzwT10vvOrib_Y_3ZxPm1g-1
Received: by mail-wm1-f70.google.com with SMTP id bg6-20020a05600c3c8600b003a03d5d19e4so1335544wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 05:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=a44l1BPonlFv22UzYK+zY86aCCDzfde91OGY+36yGaU=;
        b=8Pl8PNo7sf9PnNTvqJnQBMxPuZfI90F1I+k52/ZadJ5SiJahOogweG7zpUkDr8lHhT
         2OTE8vzNhfFOKYXO3uIzyG/emsAH7FpxbgAv74KT2to9luyisUmrd2tcYsCtPtKqufHZ
         JrKneHqtO0533Mh+Igzu5wAiZzR3n2hxgeZkRjymWkye/bTcGb1ZXxrJ4Ob0GIIH90kO
         HqOguI9l78xRdFW3Gk0DvGU6uc2s3l5YjEN8C4Ws3AfpwN+iTWlOkRkDVrw19/AZ9DDk
         yDZZPAeRfKoaua9EJudQ/CSFm/KNN+HMyIUh668TDivHSxhqLy0X5a0fCVlq3ZRodtGd
         gENQ==
X-Gm-Message-State: AJIora9ZO9mTTGfpZcQm7fbObqGceuy5Bbwkdu+uI4lPUajzpKeqtzCM
        kZFACZO3w8zNS3++3POlYdm3+Vud6/rNGtNMBDJ5rGkptjv7u5/mTipkI8Co2QDZJgvTZtXoJq+
        qLobf1eNgNB8L+3EWY5U2Z2iR
X-Received: by 2002:a05:6000:1541:b0:21d:2ae1:a5dd with SMTP id 1-20020a056000154100b0021d2ae1a5ddmr13055097wry.621.1656677365500;
        Fri, 01 Jul 2022 05:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tDSsXRR94HN6cIWegpiPJC0FkTvoqWtVO/FzQjWQZvywkzkWoCXtISM/CsabnrmNdOGdxCsA==
X-Received: by 2002:a05:6000:1541:b0:21d:2ae1:a5dd with SMTP id 1-20020a056000154100b0021d2ae1a5ddmr13055066wry.621.1656677365146;
        Fri, 01 Jul 2022 05:09:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:e300:d7a0:7fc3:8428:43e5? (p200300cbc709e300d7a07fc3842843e5.dip0.t-ipconnect.de. [2003:cb:c709:e300:d7a0:7fc3:8428:43e5])
        by smtp.gmail.com with ESMTPSA id p28-20020a1c545c000000b003a02de5de80sm6283522wmi.4.2022.07.01.05.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 05:09:24 -0700 (PDT)
Message-ID: <203548a6-cf70-30ce-6756-f6c909e7ef21@redhat.com>
Date:   Fri, 1 Jul 2022 14:09:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgel.zte@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, minchan@kernel.org,
        oleksandr@redhat.com, xu xin <xu.xin16@zte.com.cn>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220701084323.1261361-1-xu.xin16@zte.com.cn>
 <Yr66Uhcv+XAPYPwj@dhcp22.suse.cz>
 <93e1e19a-deff-2dad-0b3c-ef411309ec58@redhat.com>
 <c9de1c34-2a39-e4a2-c9b0-9790c5ffab13@redhat.com>
 <Yr7h/E/6A+tsjU9r@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH linux-next] mm/madvise: allow KSM hints for
 process_madvise
In-Reply-To: <Yr7h/E/6A+tsjU9r@dhcp22.suse.cz>
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

On 01.07.22 14:02, Michal Hocko wrote:
> On Fri 01-07-22 12:50:59, David Hildenbrand wrote:
>> On 01.07.22 12:32, David Hildenbrand wrote:
>>> On 01.07.22 11:11, Michal Hocko wrote:
>>>> [Cc Jann]
>>>>
>>>> On Fri 01-07-22 08:43:23, cgel.zte@gmail.com wrote:
>>>>> From: xu xin <xu.xin16@zte.com.cn>
>>>>>
>>>>> The benefits of doing this are obvious because using madvise in user code
>>>>> is the only current way to enable KSM, which is inconvenient for those
>>>>> compiled app without marking MERGEABLE wanting to enable KSM.
>>>>
>>>> I would rephrase:
>>>> "
>>>> KSM functionality is currently available only to processes which are
>>>> using MADV_MERGEABLE directly. This is limiting because there are
>>>> usecases which will benefit from enabling KSM on a remote process. One
>>>> example would be an application which cannot be modified (e.g. because
>>>> it is only distributed as a binary). MORE EXAMPLES WOULD BE REALLY
>>>> BENEFICIAL.
>>>> "
>>>>
>>>>> Since we already have the syscall of process_madvise(), then reusing the
>>>>> interface to allow external KSM hints is more acceptable [1].
>>>>>
>>>>> Although this patch was released by Oleksandr Natalenko, but it was
>>>>> unfortunately terminated without any conclusions because there was debate
>>>>> on whether it should use signal_pending() to check the target task besides
>>>>> the task of current() when calling unmerge_ksm_pages of other task [2].
>>>>
>>>> I am not sure this is particularly interesting. I do not remember
>>>> details of that discussion but checking signal_pending on a different
>>>> task is rarely the right thing to do. In this case the check is meant to
>>>> allow bailing out from the operation so that the caller could be
>>>> terminated for example.
>>>>
>>>>> I think it's unneeded to check the target task. For example, when we set
>>>>> the klob /sys/kernel/mm/ksm/run from 1 to 2,
>>>>> unmerge_and_remove_all_rmap_items() doesn't use signal_pending() to check
>>>>> all other target tasks either.
>>>>>
>>>>> I hope this patch can get attention again.
>>>>
>>>> One thing that the changelog is missing and it is quite important IMHO
>>>> is the permission model. As we have discussed in previous incarnations
>>>> of the remote KSM functionality that KSM has some security implications.
>>>> It would be really great to refer to that in the changelog for the
>>>> future reference (http://lkml.kernel.org/r/CAG48ez0riS60zcA9CC9rUDV=kLS0326Rr23OKv1_RHaTkOOj7A@mail.gmail.com)
>>>>
>>>> So this implementation requires PTRACE_MODE_READ_FSCREDS and
>>>> CAP_SYS_NICE so the remote process would need to be allowed to
>>>> introspect the address space. This is the same constrain applied to the
>>>> remote momory reclaim. Is this sufficient?
>>>>
>>>> I would say yes because to some degree KSM mergning can have very
>>>> similar effect to memory reclaim from the side channel POV. But it
>>>> should be really documented in the changelog so that it is clear that
>>>> this has been a deliberate decision and thought through.
>>>>
>>>> Other than that this looks like the most reasonable approach to me.
>>>>
>>>>> [1] https://lore.kernel.org/lkml/YoOrdh85+AqJH8w1@dhcp22.suse.cz/
>>>>> [2] https://lore.kernel.org/lkml/2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz/
>>>>>
>>>
>>> I have various concerns, but the biggest concern is that this modifies
>>> VMA flags and can possibly break applications.
>>>
>>> process_madvise must not modify remote process state.
>>>
>>> That's why we only allow a very limited selection that are merely hints.
>>>
>>> So nack from my side.
>>>
>>
>> [I'm quit ebusy, but I think some more explanation might be of value]
>>
>> One COW example where I think force-enabling KSM for processes is
>> *currently* not a good idea (besides the side channel discussions, which
>> is also why Windows stopped to enable KSM system wide a while ago):
>>
>> App:
>>
>> a) memset(page, 0);
>> b) trigger R/O long-term pin on page (e.g., vfio)
>>
>> If between a) and b) KSM replaces the page by the shared zeropage you'll
>> get an unreliable pin because we don't break yet COW when taking a R/O
>> pin on the shared zeropage. And in the traditional sense, the app did
>> everything right to guarantee that the pin will stay reliable.
> 
> Isn't this a bug in the existing implementation of the CoW?

One the one hand yes (pinning the shared zeropage is questionable), on
the other hand no (user space did modify that memory ahead of time and
filled it with something reasonable, that's how why always worked
correctly in the absence of KSM).

> 
>> Further, if an app explicitly decides to disable KSM one some region, we
>> should not overwrite that.
> 
> Well, the interface is rather spartan. You cannot really tell "disable
> KSM on some reqion". You can only tell "KSM can be applied to this
> region" and later change your mind. Maybe this is what you had in
> mind though.

That's what I meant. The hugepage interface has different semantics and
you get three possible states:

1: yes please: MADV_HUGEPAGE
2: don't care -- don't set anything
3. please no: MADV_NOHUGEPAGE

Currently for KSM we only have 1 and 2 internally I think (single
flag), because it didn't matter in the past ebcause there was no
force-enablement. One could convert it into all 3 states, changing the
semantics of MADV_UNMERGEABLE slightly from


1: yes please: MADV_MERGEABLE
2: don't care: MADV_UNMERGEABLE

to

1: yes please: MADV_MERGEABLE
2: don't care -- don't set anything
3. please no: MADV_UNMERGEABLE


-- 
Thanks,

David / dhildenb

