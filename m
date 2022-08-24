Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A313159F45C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiHXHbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiHXHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340FC6EF2C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661326276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WT+7R10vk0aNE0rrUknR4gGXjPX6HeX45SVq2JF94dM=;
        b=Ed1QTD9IzwgxhaGY7IsjIbkfHSS9wHXGN2LwuOh5LOtsh+t4HKhhlPUNt/9HeqaoVNP/rF
        UmTHJzGUJWLoXmcggBeHxhJqTpifF8Bp+d8O+JV77bYRDf/Hxm+PFGiW/g3dq4xqzWkgDL
        K0uk0S+x/8G84rmS9nkxFMyrFtryjPE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-EEwSc4iZNuGTQ2jN4aA95g-1; Wed, 24 Aug 2022 03:31:15 -0400
X-MC-Unique: EEwSc4iZNuGTQ2jN4aA95g-1
Received: by mail-wr1-f71.google.com with SMTP id r23-20020adfa157000000b00225660d47b7so704998wrr.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=WT+7R10vk0aNE0rrUknR4gGXjPX6HeX45SVq2JF94dM=;
        b=LtsSD5VnkE9Xhf4geTfRvkpn8g+A3LlrPha1TcoMIccICEpkQ5YxBFuNP60hKAqIDC
         2NF2GVeDh35m47mYMYJvaGY+bi0cuWPSLXB7Eq/6NiF1NvxM+7LlZhkQg5CMti+XkS4W
         AwIc235QFVuFdBb7M85vWzdXNkWdId0nNRBHo4zJn/ovRmN3YXJksGNS+34PQyLHtIjT
         d9jCNIsqK04g1/3eCaWyOgR62pvCNzeIb0mSarZy6tQC//qkXpzrClIr0GAHNalADJoh
         Mrdhr1AUzsOhx6HYcGEC0s8aZC6SCsCoNsfeLmSM4o30FdDW4ctjgxO/jdaw9dWmk3mI
         Rdqw==
X-Gm-Message-State: ACgBeo0WZFFi1D9Blrtv14cJcHVRQ6LpAPKCeCFh9hiuIDJLIiC33DoP
        gKakpkiVIpYof2Jr7p1StGyAmJuveU+ryPuRT7OFT7rnE8IKgCbbw4QQBoeRSLTKQVaC5ofR57g
        F/yxNEYqrALkyUYPTXtfoT3Ym
X-Received: by 2002:a05:6000:1541:b0:222:cf65:18d7 with SMTP id 1-20020a056000154100b00222cf6518d7mr14983036wry.659.1661326273822;
        Wed, 24 Aug 2022 00:31:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7OD3lnFqJrfNvSSIMKPzccca+q0/+SvVbupvakHoiMYt8Uz2ObMdjTZycv71GlM/2xZ23TxA==
X-Received: by 2002:a05:6000:1541:b0:222:cf65:18d7 with SMTP id 1-20020a056000154100b00222cf6518d7mr14983020wry.659.1661326273536;
        Wed, 24 Aug 2022 00:31:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:c500:5445:cf40:2e32:6e73? (p200300cbc707c5005445cf402e326e73.dip0.t-ipconnect.de. [2003:cb:c707:c500:5445:cf40:2e32:6e73])
        by smtp.gmail.com with ESMTPSA id j27-20020a05600c1c1b00b003a5ce167a68sm1062881wms.7.2022.08.24.00.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 00:31:13 -0700 (PDT)
Message-ID: <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
Date:   Wed, 24 Aug 2022 09:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
 <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
 <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com> <YwVo7xSO+VebkIfQ@monkey>
 <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
In-Reply-To: <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>
>>>> IMHO, these follow_huge_xxx() functions are arch-specified at first and
>>>> were moved into the common hugetlb.c by commit 9e5fc74c3025 ("mm:
>>>> hugetlb: Copy general hugetlb code from x86 to mm"), and now there are
>>>> still some arch-specified follow_huge_xxx() definition, for example:
>>>> ia64: follow_huge_addr
>>>> powerpc: follow_huge_pd
>>>> s390: follow_huge_pud
>>>>
>>>> What I mean is that follow_hugetlb_page() is a common and
>>>> not-arch-specified function, is it suitable to change it to be
>>>> arch-specified?
>>>> And thinking more, can we rename follow_hugetlb_page() as
>>>> hugetlb_page_faultin() and simplify it to only handle the page faults of
>>>> hugetlb like the faultin_page() for normal page? That means we can make
>>>> sure only follow_page_mask() can handle hugetlb.
>>>>
>>
>> Something like that might work, but you still have two page table walkers
>> for hugetlb.  I like David's idea (if I understand it correctly) of
> 
> What I mean is we may change the hugetlb handling like normal page:
> 1) use follow_page_mask() to look up a hugetlb firstly.
> 2) if can not get the hugetlb, then try to page fault by 
> hugetlb_page_faultin().
> 3) if page fault successed, then retry to find hugetlb by 
> follow_page_mask().

That implies putting more hugetlbfs special code into generic GUP,
turning it even more complicated. But of course, it depends on how the
end result looks like. My gut feeling was that hugetlb is better handled
in follow_hugetlb_page() separately (just like we do with a lot of other
page table walkers).

> 
> Just a rough thought, and I need more investigation for my idea and 
> David's idea.
> 
>> using follow_hugetlb_page for both cases.  As noted, it will need to be
>> taught how to not trigger faults in the follow_page_mask case.
> 
> Anyway, I also agree we need some cleanup, and firstly I think we should 
> cleanup these arch-specified follow_huge_xxx() on some architectures 
> which are similar with the common ones. I will look into these.

There was a recent discussion on that, e.g.:

https://lkml.kernel.org/r/20220818135717.609eef8a@thinkpad

> 
> However, considering cleanup may need more investigation and 
> refactoring, now I prefer to make these bug-fix patches of this patchset 
> into mainline firstly, which are suitable to backport to old version to 
> fix potential race issues. Mike and David, how do you think? Could you 
> help to review these patches? Thanks.

Patch #1 certainly add more special code just to handle another hugetlb
corner case (CONT pages), and maybe just making it all use
follow_hugetlb_page() would be even cleaner and less error prone.

I agree that locking is shaky, but I'm not sure if we really want to
backport this to stable trees:

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

"It must fix a real bug that bothers people (not a, “This could be a
problem...” type thing)."


Do we actually have any instance of this being a real (and not a
theoretical) problem? If not, I'd rather clean it all up right away.

-- 
Thanks,

David / dhildenb

