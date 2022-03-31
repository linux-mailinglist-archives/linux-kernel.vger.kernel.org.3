Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5E4ED63F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiCaIxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiCaIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EC7556238
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648716661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wa4p/wO+PmXujUL5WGPRn9DNetCFbX+Ev3ZZgYBJonU=;
        b=aH/uZgDvPTdd+9H3/Bq+EU2ZLSHHfBpPAg7AtoUIWm2ky7bMM2OmxsC4S1uCUK0AC90AOB
        HazfPeoG0DM6eEKIM/n228RYq/g1M342jQ695YX03Zgp9z7o2g00OwPuzQdtQjX7942cK8
        93huzO/AUeJM30rDMaHS8qOJhW22oQg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-N0QuN1ajNqWM5vpUxK6atQ-1; Thu, 31 Mar 2022 04:51:00 -0400
X-MC-Unique: N0QuN1ajNqWM5vpUxK6atQ-1
Received: by mail-wm1-f72.google.com with SMTP id 9-20020a05600c240900b0038c99b98f6fso926148wmp.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=wa4p/wO+PmXujUL5WGPRn9DNetCFbX+Ev3ZZgYBJonU=;
        b=liTLeka8LhCp8aUaFnLDm3BC/1WEf0c6dY5AAMcfVLQs7oU1tJlE7mWMZjUGrxfBjD
         kFfYpVHILYKHPzG3LtcjlntLK0NjIIYfVjYbL6HeS21mSOPlT+ZEK/X9TxUBH+mbqU0N
         D/Io6W7jxvxzZWLAXRnkVeX++Y0dM1Lp08tZjsDwCGcRzIZOVdydIUc0S2Il1f4cqlCQ
         fyVNFgTEDWS0jUNaXRmiY4eCXPwDdhhvBCVMBpSpcYjf9kch8rs7KzDtqkUhkRTaqq/S
         thnYuXg7fJkhLgxFtSYirF2C0DXvAacNRUUTwbklinVLWjannVui2kDrQ/9pgOxdqafl
         H+Kg==
X-Gm-Message-State: AOAM530ly8sffcrmLKVe/v5kO2xp6HENVsrG+4ajCNa5L65HYqStcrld
        88H5r5Kl51LHY6sem8PX+MVsibeEao4xeaBtLZuAV1mbKG6Lg6y0Z4a00Xi0ZGoqK7DB2u87U2/
        OLp0nPfvuMmybOGAsnMwhIeun
X-Received: by 2002:a05:600c:4241:b0:38c:ec66:7c8f with SMTP id r1-20020a05600c424100b0038cec667c8fmr3779463wmm.179.1648716658873;
        Thu, 31 Mar 2022 01:50:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydHgZaeT4SyBikwI+ArVPjRxw0uDniD5ZVMGFpCcHvAsXuy7PE8lVHxzWUOPwpkP/X97R8KA==
X-Received: by 2002:a05:600c:4241:b0:38c:ec66:7c8f with SMTP id r1-20020a05600c424100b0038cec667c8fmr3779451wmm.179.1648716658625;
        Thu, 31 Mar 2022 01:50:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:ac00:381c:2e8b:3b48:488e? (p200300cbc707ac00381c2e8b3b48488e.dip0.t-ipconnect.de. [2003:cb:c707:ac00:381c:2e8b:3b48:488e])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d5912000000b00205a7d0c6a3sm15035485wrd.69.2022.03.31.01.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 01:50:58 -0700 (PDT)
Message-ID: <445c5426-cfb6-0232-6ea5-41cf8aaa264e@redhat.com>
Date:   Thu, 31 Mar 2022 10:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4 1/2] mm: hugetlb_vmemmap: introduce
 ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        Barry Song <21cnbao@gmail.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
References: <20220331065640.5777-1-songmuchun@bytedance.com>
 <6c774e27-26d2-6c45-65f9-8a5b8acd6433@redhat.com>
 <CAMZfGtV6=n60f2cEWWtFk8Ci1c_JzeNJCmzAs2X6EHZkaXfP6Q@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAMZfGtV6=n60f2cEWWtFk8Ci1c_JzeNJCmzAs2X6EHZkaXfP6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.22 10:48, Muchun Song wrote:
> On Thu, Mar 31, 2022 at 4:42 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 31.03.22 08:56, Muchun Song wrote:
>>> The feature of minimizing overhead of struct page associated with each
>>> HugeTLB page is implemented on x86_64, however, the infrastructure of
>>> this feature is already there, we could easily enable it for other
>>> architectures.  Introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP for other
>>> architectures to be easily enabled.  Just select this config if they
>>> want to enable this feature.
>>>
>>> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>>  arch/x86/Kconfig |  1 +
>>>  fs/Kconfig       | 10 +++++++++-
>>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index 9f5bd41bf660..e69d42528542 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -119,6 +119,7 @@ config X86
>>>       select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>>>       select ARCH_WANTS_NO_INSTR
>>>       select ARCH_WANT_HUGE_PMD_SHARE
>>> +     select ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP      if X86_64
>>>       select ARCH_WANT_LD_ORPHAN_WARN
>>>       select ARCH_WANTS_THP_SWAP              if X86_64
>>>       select ARCH_HAS_PARANOID_L1D_FLUSH
>>> diff --git a/fs/Kconfig b/fs/Kconfig
>>> index 6c7dc1387beb..f6db2af33738 100644
>>> --- a/fs/Kconfig
>>> +++ b/fs/Kconfig
>>> @@ -245,9 +245,17 @@ config HUGETLBFS
>>>  config HUGETLB_PAGE
>>>       def_bool HUGETLBFS
>>>
>>> +#
>>> +# Select this config option from the architecture Kconfig, if it is preferred
>>> +# to enable the feature of minimizing overhead of struct page associated with
>>> +# each HugeTLB page.
>>> +#
>>> +config ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
>>> +     bool
>>> +
>>>  config HUGETLB_PAGE_FREE_VMEMMAP
>>>       def_bool HUGETLB_PAGE
>>> -     depends on X86_64
>>> +     depends on ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
>>>       depends on SPARSEMEM_VMEMMAP
>>>
>>>  config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
>>
>>
>> I think something like "HUGETLB_OPTIMIZE_VMEMMAP" might be more
>> expressive, but that would imply renaming the existing config knob.
>>
> 
> How about doing a full code cleanup in a separate series in the future?
> 

Yeah.

-- 
Thanks,

David / dhildenb

