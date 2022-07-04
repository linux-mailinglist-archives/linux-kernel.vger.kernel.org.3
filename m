Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE5D5650D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiGDJbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiGDJa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57974BF7E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656927008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmOci4VseGTQ2nlFPrT9ilHeR7wEpOBEKOi8eA9uYXU=;
        b=BKNTQ2ICB0l4i9R8eFA9F29x2BKkdyiSllaJHSwTWYK/9UufnQSCsNhzU0iLjfmvhJ3ZLz
        nI94Bw+hafT3svc7zz1eV0fDFbSmSNhw3XhkXD3nEQr4HXKQa8sYPRHgUXTSR+NOL7wvu+
        RBl5EILIp11TPl15TBF99taDJYoBAQ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-M2vV_bZKNPaVrlJtNuA-JQ-1; Mon, 04 Jul 2022 05:30:06 -0400
X-MC-Unique: M2vV_bZKNPaVrlJtNuA-JQ-1
Received: by mail-wr1-f72.google.com with SMTP id z11-20020a056000110b00b0021b9c009d09so1307866wrw.17
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=kmOci4VseGTQ2nlFPrT9ilHeR7wEpOBEKOi8eA9uYXU=;
        b=qh0mLJEnSUHvRqrWLILm1tycfZY/TstZaK39JzbCs8j06exgqtQTMaAlintRS/ZNWe
         HF8GEDY/llXmjGKw419kzzyabkGfDATz2wtp8xjixB+Vbxpkpo8JJYl5Pet7UGzL9SWW
         UZ0eAKtAwGtxIbBB/VyTn/pRVxYwSIxZOTCPLhpHtaHLem+lp5Pjvzy30+gWRiZ9I2NN
         3djzhbYYgkByLrFh1ffcOFwcPx14mRyu0OPbBo6cRTrL21wrIIOY0d8ixXn9A3h9Hrht
         CY0SCTFQIe8wsudu9BTRsmkRoqAZX44zn4F4X7ra08Cz98410B0y7EB1U7YbrTb6QPq3
         /KtQ==
X-Gm-Message-State: AJIora+fFm/LO7JZHdK3rLX7SxQKy7N4fMiC4pi9vP15kf3IoBA3Pdmd
        eIlqYhWrh14JQEDLwu/b4CABFJgJl8vaf3/tbEv0FBbBYjkdXh/3NBnBgZvuELsgIF0793vUb4H
        iHHJWTsCfhYpdMuAFI6afuT+Q
X-Received: by 2002:a05:600c:35d5:b0:3a0:4b1a:2a28 with SMTP id r21-20020a05600c35d500b003a04b1a2a28mr29085335wmq.22.1656927004996;
        Mon, 04 Jul 2022 02:30:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1voaGmGb5+y36zdi6y1vXxNkRbBrgSorRwYLvBn5AUdOfmh+i/xeRQGlhoEmuChnh7k7otxdQ==
X-Received: by 2002:a05:600c:35d5:b0:3a0:4b1a:2a28 with SMTP id r21-20020a05600c35d500b003a04b1a2a28mr29085309wmq.22.1656927004679;
        Mon, 04 Jul 2022 02:30:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f16:2a00:198:c1f8:a413:2600? (p200300d82f162a000198c1f8a4132600.dip0.t-ipconnect.de. [2003:d8:2f16:2a00:198:c1f8:a413:2600])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b0039ee391a024sm14707297wms.14.2022.07.04.02.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 02:30:04 -0700 (PDT)
Message-ID: <96622b10-1d95-425d-278a-1cf21ee92604@redhat.com>
Date:   Mon, 4 Jul 2022 11:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH linux-next] mm/madvise: allow KSM hints for
 process_madvise
Content-Language: en-US
To:     CGEL <cgel.zte@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, minchan@kernel.org,
        oleksandr@redhat.com, xu xin <xu.xin16@zte.com.cn>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220701084323.1261361-1-xu.xin16@zte.com.cn>
 <Yr66Uhcv+XAPYPwj@dhcp22.suse.cz>
 <93e1e19a-deff-2dad-0b3c-ef411309ec58@redhat.com>
 <c9de1c34-2a39-e4a2-c9b0-9790c5ffab13@redhat.com>
 <Yr7h/E/6A+tsjU9r@dhcp22.suse.cz>
 <203548a6-cf70-30ce-6756-f6c909e7ef21@redhat.com>
 <62c2a117.1c69fb81.3a929.dda9@mx.google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <62c2a117.1c69fb81.3a929.dda9@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.07.22 10:13, CGEL wrote:
> On Fri, Jul 01, 2022 at 02:09:24PM +0200, David Hildenbrand wrote:
>> On 01.07.22 14:02, Michal Hocko wrote:
>>> On Fri 01-07-22 12:50:59, David Hildenbrand wrote:
>>>> On 01.07.22 12:32, David Hildenbrand wrote:
>>>>> On 01.07.22 11:11, Michal Hocko wrote:
>>>>>> [Cc Jann]
>>>>>>
>>>>>> On Fri 01-07-22 08:43:23, cgel.zte@gmail.com wrote:
>>>>>>> From: xu xin <xu.xin16@zte.com.cn>
>>>>>>>
>>>>>>> The benefits of doing this are obvious because using madvise in user code
>>>>>>> is the only current way to enable KSM, which is inconvenient for those
>>>>>>> compiled app without marking MERGEABLE wanting to enable KSM.
>>>>>>
>>>>>> I would rephrase:
>>>>>> "
>>>>>> KSM functionality is currently available only to processes which are
>>>>>> using MADV_MERGEABLE directly. This is limiting because there are
>>>>>> usecases which will benefit from enabling KSM on a remote process. One
>>>>>> example would be an application which cannot be modified (e.g. because
>>>>>> it is only distributed as a binary). MORE EXAMPLES WOULD BE REALLY
>>>>>> BENEFICIAL.
>>>>>> "
>>>>>>
>>>>>>> Since we already have the syscall of process_madvise(), then reusing the
>>>>>>> interface to allow external KSM hints is more acceptable [1].
>>>>>>>
>>>>>>> Although this patch was released by Oleksandr Natalenko, but it was
>>>>>>> unfortunately terminated without any conclusions because there was debate
>>>>>>> on whether it should use signal_pending() to check the target task besides
>>>>>>> the task of current() when calling unmerge_ksm_pages of other task [2].
>>>>>>
>>>>>> I am not sure this is particularly interesting. I do not remember
>>>>>> details of that discussion but checking signal_pending on a different
>>>>>> task is rarely the right thing to do. In this case the check is meant to
>>>>>> allow bailing out from the operation so that the caller could be
>>>>>> terminated for example.
>>>>>>
>>>>>>> I think it's unneeded to check the target task. For example, when we set
>>>>>>> the klob /sys/kernel/mm/ksm/run from 1 to 2,
>>>>>>> unmerge_and_remove_all_rmap_items() doesn't use signal_pending() to check
>>>>>>> all other target tasks either.
>>>>>>>
>>>>>>> I hope this patch can get attention again.
>>>>>>
>>>>>> One thing that the changelog is missing and it is quite important IMHO
>>>>>> is the permission model. As we have discussed in previous incarnations
>>>>>> of the remote KSM functionality that KSM has some security implications.
>>>>>> It would be really great to refer to that in the changelog for the
>>>>>> future reference (http://lkml.kernel.org/r/CAG48ez0riS60zcA9CC9rUDV=kLS0326Rr23OKv1_RHaTkOOj7A@mail.gmail.com)
>>>>>>
>>>>>> So this implementation requires PTRACE_MODE_READ_FSCREDS and
>>>>>> CAP_SYS_NICE so the remote process would need to be allowed to
>>>>>> introspect the address space. This is the same constrain applied to the
>>>>>> remote momory reclaim. Is this sufficient?
>>>>>>
>>>>>> I would say yes because to some degree KSM mergning can have very
>>>>>> similar effect to memory reclaim from the side channel POV. But it
>>>>>> should be really documented in the changelog so that it is clear that
>>>>>> this has been a deliberate decision and thought through.
>>>>>>
>>>>>> Other than that this looks like the most reasonable approach to me.
>>>>>>
>>>>>>> [1] https://lore.kernel.org/lkml/YoOrdh85+AqJH8w1@dhcp22.suse.cz/
>>>>>>> [2] https://lore.kernel.org/lkml/2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz/
>>>>>>>
>>>>>
>>>>> I have various concerns, but the biggest concern is that this modifies
>>>>> VMA flags and can possibly break applications.
>>>>>
>>>>> process_madvise must not modify remote process state.
>>>>>
>>>>> That's why we only allow a very limited selection that are merely hints.
>>>>>
>>>>> So nack from my side.
>>>>>
>>>>
>>>> [I'm quit ebusy, but I think some more explanation might be of value]
>>>>
>>>> One COW example where I think force-enabling KSM for processes is
>>>> *currently* not a good idea (besides the side channel discussions, which
>>>> is also why Windows stopped to enable KSM system wide a while ago):
>>>>
>>>> App:
>>>>
>>>> a) memset(page, 0);
>>>> b) trigger R/O long-term pin on page (e.g., vfio)
>>>>
>>>> If between a) and b) KSM replaces the page by the shared zeropage you'll
>>>> get an unreliable pin because we don't break yet COW when taking a R/O
>>>> pin on the shared zeropage. And in the traditional sense, the app did
>>>> everything right to guarantee that the pin will stay reliable.
>>>
>>> Isn't this a bug in the existing implementation of the CoW?
>>
>> One the one hand yes (pinning the shared zeropage is questionable), on
>> the other hand no (user space did modify that memory ahead of time and
>> filled it with something reasonable, that's how why always worked
>> correctly in the absence of KSM).
>>
> 
> Thanks for your information.
> 
> So does it needs to be fixed? and if yes, are you planning to fix it.

Very high on my todo list. So yes, I think it really needs fixing,
especially with KSM in mind.

-- 
Thanks,

David / dhildenb

